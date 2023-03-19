//
//  QRScannerView.swift
//  fptshop
//
//  Created by DiemMy Le on 8/27/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import AVFoundation

protocol QRScannerViewDelegate: AnyObject {
    func qrScanningDidFail()
    func qrScanningSucceededWithCode(_ str: String?)
    func qrScanningDidStop()
}

class QRScannerView: UIView {
    
    weak var delegate: QRScannerViewDelegate?
    var backgroundView: UIView!
    var layer1: CAGradientLayer!
    
    /// capture settion which allows us to start and stop scanning.
    var captureSession: AVCaptureSession?
    
    // Init methods..
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doInitialSetup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        doInitialSetup()
    }
    
    //MARK: overriding the layerClass to return `AVCaptureVideoPreviewLayer`.
    override class var layerClass: AnyClass  {
        return AVCaptureVideoPreviewLayer.self
    }
    override var layer: AVCaptureVideoPreviewLayer {
        return super.layer as! AVCaptureVideoPreviewLayer
    }
}
extension QRScannerView {
    
    var isRunning: Bool {
        return captureSession?.isRunning ?? false
    }
    
    func startScanning() {
        captureSession?.startRunning()
        if self.layer1 != nil {
            self.layer1.isHidden = false
        }
    }
    
    func stopScanning() {
        captureSession?.stopRunning()
        if self.layer1 != nil {
            self.layer1.isHidden = true
        }
        delegate?.qrScanningDidStop()
    }
    
    /// Does the initial setup for captureSession
    private func doInitialSetup() {
        clipsToBounds = true
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch let error {
            print(error)
            return
        }
        
        if (captureSession?.canAddInput(videoInput) ?? false) {
            captureSession?.addInput(videoInput)
        } else {
            scanningDidFail()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession?.canAddOutput(metadataOutput) ?? false) {
            captureSession?.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr, .ean8, .ean13, .pdf417]
        } else {
            scanningDidFail()
            return
        }
        
        self.layer.session = captureSession
        self.layer.videoGravity = .resizeAspectFill
        
        captureSession?.startRunning()
        
        ///More-------------------
        
        let scanRect = CGRect(x: Common.Size(s: 30), y: Common.Size(s: 40), width: self.bounds.width - Common.Size(s: 60), height: self.bounds.height - Common.Size(s: 80))
        let rectOfInterest = self.layer.metadataOutputRectConverted(fromLayerRect: scanRect)
        metadataOutput.rectOfInterest = rectOfInterest
        
        let cornerViewCode = CornerView(frame: scanRect)
        cornerViewCode.lineWidth = 4
        cornerViewCode.lineColor = UIColor(netHex:0x00955E)
        self.addSubview(cornerViewCode)
        
        self.backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        self.addSubview(backgroundView)
        self.backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let lbScan = UILabel(frame: CGRect(x: 0, y: cornerViewCode.frame.origin.y + cornerViewCode.frame.height + Common.Size(s: 5), width: self.frame.width, height: Common.Size(s: 20)))
        lbScan.text = "Di chuyển camera đến vùng chứa mã QRCode để quét"
        lbScan.font = UIFont.systemFont(ofSize: 11)
        lbScan.textColor = .white
        lbScan.textAlignment = .center
        lbScan.backgroundColor = UIColor.clear
        self.addSubview(lbScan)

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
        
        layer1 = createScannerGradientLayer(for: cornerViewCode)
        cornerViewCode.layer.insertSublayer(layer1, at: 0)
        let timeInterval: CFTimeInterval = 2
        let rotateAnimation = CABasicAnimation(keyPath: "position.y")
        rotateAnimation.fromValue = layer1.position.y
        rotateAnimation.toValue = cornerViewCode.layer.frame.height - layer1.position.y
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = timeInterval
        rotateAnimation.repeatCount = Float.infinity
        layer1.add(rotateAnimation, forKey: nil)
        
        

//        if(videoCaptureDevice!.isFocusModeSupported(.continuousAutoFocus)) {
//            try! videoCaptureDevice!.lockForConfiguration()
//            videoCaptureDevice.focusMode = .continuousAutoFocus
//            videoCaptureDevice.exposureMode = .continuousAutoExposure
//            videoCaptureDevice!.unlockForConfiguration()
//        }
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
    
    func scanningDidFail() {
        delegate?.qrScanningDidFail()
        captureSession = nil
    }
    
    func found(code: String) {
        delegate?.qrScanningSucceededWithCode(code)
    }
}

extension QRScannerView: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        stopScanning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    }
    
}
