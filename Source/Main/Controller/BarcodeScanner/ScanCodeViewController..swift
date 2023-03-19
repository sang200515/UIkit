//
//  ScanCodeViewController..swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/16/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import AVFoundation
import CoreGraphics
import UIKit

class ScanCodeViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var cornerViewCode : CornerView?
    var backgroundView: UIView!
    var videoCaptureDevice:AVCaptureDevice!
    var titleFlash: UILabel!
    var iconFlash:UIImageView!
    var scanSuccess: ((String)->Void)?
    var onClickBack:(()->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Quét mã kích hoạt"
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00955E)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        checkPermissions()
        self.getCameraPreview()
    }
    
    private func checkPermissions() {
      // TODO: Checking permissions
      switch AVCaptureDevice.authorizationStatus(for: .video) {
      case .notDetermined:
        AVCaptureDevice.requestAccess(for: .video) { isAcept in
          if !isAcept {
              DispatchQueue.main.async {
                  self.showAlertTwoButton(title: "Cho Phép sử dụng Camera", with: "Vui lòng cho phép ứng dụng sử dụng camera để quét mã sản phẩm!", titleButtonOne: "Hủy", titleButtonTwo: "Cài đặt") {
                      self.dismissOrPop()
                  } handleButtonTwo: {
                      self.dismissOrPop()
                      guard let setting = URL(string: UIApplication.openSettingsURLString) else {return}
                      UIApplication.shared.open(setting)
                  }
              }
          }
        }
      case .denied,.restricted:
          DispatchQueue.main.async {
              self.showAlertTwoButton(title: "Cho Phép sử dụng Camera", with: "Vui lòng cho phép ứng dụng sử dụng camera để quét mã sản phẩm!", titleButtonOne: "Hủy", titleButtonTwo: "Cài đặt") {
                  self.dismissOrPop()
              } handleButtonTwo: {
                  self.dismissOrPop()
                  guard let setting = URL(string: UIApplication.openSettingsURLString) else {return}
                  UIApplication.shared.open(setting)
              }
          }
      default:
        return
      }
    }
    
    @objc func dismissOrPop() {
        if let back = onClickBack {
            back()
        }
        if self.navigationController?.topViewController == self {
            self.navigationController?.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func getCameraPreview(){
        captureSession = AVCaptureSession()
         videoCaptureDevice = AVCaptureDevice.default(for: .video)
        let width = UIScreen.main.bounds.size.width
             let height = UIScreen.main.bounds.size.height
        //try to enable auto focus
     
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        if (captureSession.canAddInput(videoInput)){
            captureSession.addInput(videoInput)
        } else {
            showAlert()
            return
        }
        let metadataOutput = AVCaptureMetadataOutput()
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr,.ean13,.code128,.code39]
        } else {
            showAlert()
            return
        }
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer) // add preview layer to your view
        captureSession.startRunning() // start capturing

     
        
        
        let scanRect = CGRect(x: width/2 - (width * 2/3)/2, y: height/3 - width/4, width: width * 2/3, height: width/2)
        let rectOfInterest = previewLayer.metadataOutputRectConverted(fromLayerRect: scanRect)
        metadataOutput.rectOfInterest = rectOfInterest
        
        self.cornerViewCode = CornerView(frame: scanRect)
        self.cornerViewCode?.lineWidth = 4
        self.cornerViewCode?.lineColor = UIColor(netHex:0x00955E)
        self.view.addSubview(self.cornerViewCode!)
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.view.addSubview(backgroundView)

        if(videoCaptureDevice!.isFocusModeSupported(.continuousAutoFocus)) {
            try! videoCaptureDevice!.lockForConfiguration()
            videoCaptureDevice.focusMode = .continuousAutoFocus
            videoCaptureDevice.exposureMode = .continuousAutoExposure
            videoCaptureDevice!.unlockForConfiguration()
        }
        //---
        let viewLeftNav = UIView(frame: CGRect(x: 25, y: 60, width: 30, height: 50))
        self.view.addSubview(viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setTitle("Close", for: .normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(dismissOrPop), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        let title = UILabel(frame: CGRect(x: 0, y: 15, width: width, height: 45))
        title.text = "Quét mã"
        title.textColor = .white
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 16)
        self.view.addSubview(title)
        
        self.backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        // Draw a graphics with a mostly solid alpha channel
        // and a square of "clear" alpha in there.
        UIGraphicsBeginImageContext(self.backgroundView.bounds.size)
        let cgContext = UIGraphicsGetCurrentContext()
        cgContext?.setFillColor(UIColor.white.cgColor)
        cgContext?.fill(self.backgroundView.bounds)
        cgContext?.clear(scanRect)
        let maskImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
//
//        // Set the content of the mask view so that it uses our
//        // alpha channel image
        let maskView = UIView(frame: self.backgroundView.bounds)
        maskView.layer.contents = maskImage?.cgImage
        self.backgroundView.mask = maskView

        iconFlash = UIImageView(frame: CGRect(x: width/2 - 15, y: height * 2/3 + 50, width: 30, height: 50))
        iconFlash.image = UIImage(named: "flash-off")!
        iconFlash.contentMode = .scaleAspectFit
        self.backgroundView.addSubview(iconFlash)
        titleFlash = UILabel(frame: CGRect(x: 0, y: iconFlash.frame.origin.y + iconFlash.frame.size.height + 5, width: width, height: 18))
        titleFlash.text = "Chạm để bật đèn pin"
        titleFlash.textColor = .white
        titleFlash.textAlignment = .center
        titleFlash.font = UIFont.systemFont(ofSize: 14)
        self.backgroundView.addSubview(titleFlash)
    
        
        let tapOnOffFlash = UITapGestureRecognizer(target: self, action: #selector(onOffFlash(tapGestureRecognizer:)))
        iconFlash.isUserInteractionEnabled = true
        iconFlash.addGestureRecognizer(tapOnOffFlash)
        let tapOnOffFlash1 = UITapGestureRecognizer(target: self, action: #selector(onOffFlash(tapGestureRecognizer:)))
        titleFlash.isUserInteractionEnabled = true
        titleFlash.addGestureRecognizer(tapOnOffFlash1)
        
        
        let layer = createScannerGradientLayer(for: cornerViewCode!)
        cornerViewCode!.layer.insertSublayer(layer, at: 0)
        let timeInterval: CFTimeInterval = 2
        let rotateAnimation = CABasicAnimation(keyPath: "position.y")
        rotateAnimation.fromValue = layer.position.y
        rotateAnimation.toValue = cornerViewCode!.layer.frame.height - layer.position.y
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = timeInterval
        rotateAnimation.repeatCount = Float.infinity
        layer.add(rotateAnimation, forKey: nil)
    }
    func createScannerGradientLayer(for view: UIView) -> CAGradientLayer {
        let height: CGFloat = 25
        let opacity: Float = 0.5
        let topColor = UIColor(netHex:0x00955E)
        let bottomColor = topColor.withAlphaComponent(0)

        let layer = CAGradientLayer()
        layer.colors = [bottomColor.cgColor, topColor.cgColor]
        layer.opacity = opacity
        layer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        return layer
    }
    
   func createAnimation(for layer: CAGradientLayer) -> CABasicAnimation {
        guard let superLayer = layer.superlayer else {
            fatalError("Unable to create animation, layer should have superlayer")
        }
        let superLayerHeight = superLayer.frame.height
        let layerHeight = layer.frame.height
        let value = superLayerHeight - layerHeight

        let initialYPosition = layer.position.y
        let finalYPosition = initialYPosition + value
        let duration: CFTimeInterval = 1

        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = initialYPosition as NSNumber
        animation.toValue = finalYPosition as NSNumber
        animation.duration = duration
        animation.repeatCount = .infinity
        return animation
    }
    @objc func onOffFlash(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if(videoCaptureDevice.torchMode == .on){
            turnOffTorch(device: videoCaptureDevice)
            titleFlash.text = "Chạm để bật đèn pin"
            iconFlash.image = UIImage(named: "flash-off")!
        }else{
            turnOnTorch(device: videoCaptureDevice)
            titleFlash.text = "Chạm để tắt đèn pin"
            iconFlash.image = UIImage(named: "flash-on")!
        }
        
    }
    func turnOnTorch(device: AVCaptureDevice) {
        guard device.hasTorch else { return }
        withDeviceLock(on: device) {
            try? $0.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel)
        }
    }
    func turnOffTorch(device: AVCaptureDevice) {
        guard device.hasTorch else { return }
        withDeviceLock(on: device) {
            $0.torchMode = .off
        }
    }
    func withDeviceLock(on device: AVCaptureDevice, block: (AVCaptureDevice) -> Void) {
        do {
            try device.lockForConfiguration()
            block(device)
            device.unlockForConfiguration()
        } catch {
            // can't acquire lock
        }
    }
    
    private func getSettings(camera: AVCaptureDevice, flashMode: AVCaptureDevice.FlashMode) -> AVCapturePhotoSettings {
        let settings = AVCapturePhotoSettings()
        if camera.hasFlash {
            settings.flashMode = flashMode
        }
        return settings
    }
    func showAlert() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device doesn't support for scanning a QR code. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning() // stop scanning after receiving metadata output
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let codeString = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            //            self.receivedCode(qrcode: codeString)
            
//            self.navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
            print(codeString)
            if let success = scanSuccess {
                success(codeString)
            }
        }else{
//            self.navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
    }
}
class CornerView: UIView {
    
    @IBInspectable
    var sizeMultiplier : CGFloat = 0.2{
        didSet{
            self.draw(self.bounds)
        }
    }
    
    @IBInspectable
    var lineWidth : CGFloat = 2{
        didSet{
            self.draw(self.bounds)
        }
    }
    
    @IBInspectable
    var lineColor : UIColor = UIColor.black{
        didSet{
            self.draw(self.bounds)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
    }
    
    func drawCorners()
    {
        let currentContext = UIGraphicsGetCurrentContext()
        
        currentContext?.setLineWidth(lineWidth)
        currentContext?.setStrokeColor(lineColor.cgColor)
        
        //first part of top left corner
        currentContext?.beginPath()
        currentContext?.move(to: CGPoint(x: 0, y: 0))
        currentContext?.addLine(to: CGPoint(x: self.bounds.size.width*sizeMultiplier, y: 0))
     
        if #available(iOS 13.0, *) {
            currentContext?.strokePath()
        }
        
        //top rigth corner
        currentContext?.beginPath()
        currentContext?.move(to: CGPoint(x: self.bounds.size.width - self.bounds.size.width*sizeMultiplier, y: 0))
        currentContext?.addLine(to: CGPoint(x: self.bounds.size.width, y: 0))
        currentContext?.addLine(to: CGPoint(x: self.bounds.size.width, y: self.bounds.size.height*sizeMultiplier))
     
        if #available(iOS 13.0, *) {
            currentContext?.strokePath()
        }
        
        //bottom rigth corner
        currentContext?.beginPath()
        currentContext?.move(to: CGPoint(x: self.bounds.size.width, y: self.bounds.size.height - self.bounds.size.height*sizeMultiplier))
        currentContext?.addLine(to: CGPoint(x: self.bounds.size.width, y: self.bounds.size.height))
        currentContext?.addLine(to: CGPoint(x: self.bounds.size.width - self.bounds.size.width*sizeMultiplier, y: self.bounds.size.height))

        if #available(iOS 13.0, *) {
            currentContext?.strokePath()
        }
        
        //bottom left corner
        currentContext?.beginPath()
        currentContext?.move(to: CGPoint(x: self.bounds.size.width*sizeMultiplier, y: self.bounds.size.height))
        currentContext?.addLine(to: CGPoint(x: 0, y: self.bounds.size.height))
        currentContext?.addLine(to: CGPoint(x: 0, y: self.bounds.size.height - self.bounds.size.height*sizeMultiplier))
    
        if #available(iOS 13.0, *) {
            currentContext?.strokePath()
        }
        
        //second part of top left corner
        currentContext?.beginPath()
        currentContext?.move(to: CGPoint(x: 0, y: self.bounds.size.height*sizeMultiplier))
        currentContext?.addLine(to: CGPoint(x: 0, y: 0))
    
        if #available(iOS 13.0, *) {
            currentContext?.strokePath()
        }
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        self.drawCorners()
    }
}
extension UIView {
    
    func strokeBorder() {
        
        self.backgroundColor = .clear
        self.clipsToBounds = true
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = UIBezierPath(rect: self.bounds).cgPath
        self.layer.mask = maskLayer
        
        let line = NSNumber(value: Float(self.bounds.width / 2))
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.white.cgColor
        borderLayer.lineDashPattern = [line]
        borderLayer.lineDashPhase = self.bounds.width / 4
        borderLayer.lineWidth = 10
        borderLayer.frame = self.bounds
        self.layer.addSublayer(borderLayer)
    }
}
