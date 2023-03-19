//
//  ScanVoucherKhongGia.swift
//  mPOS
//
//  Created by tan on 5/25/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

protocol ScanImeiConvert4GViewControllerDelegate: NSObjectProtocol {
    
    func scanSuccess(_ viewController: ScanImeiConvert4GViewController, scan: String)
    
}

class ScanImeiConvert4GViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    weak var delegate: ScanImeiConvert4GViewControllerDelegate?
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    var messageLabel:UILabel!
    let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                              AVMetadataObject.ObjectType.code39,
                              AVMetadataObject.ObjectType.code39Mod43,
                              AVMetadataObject.ObjectType.code93,
                              AVMetadataObject.ObjectType.code128,
                              AVMetadataObject.ObjectType.ean8,
                              AVMetadataObject.ObjectType.ean13,
                              AVMetadataObject.ObjectType.aztec,
                              AVMetadataObject.ObjectType.pdf417,
                              AVMetadataObject.ObjectType.qr]
    
    var success:Bool!
    
    override func viewDidLoad() {
        self.navigationItem.title = "Quét Seri Sim"
        success = false
        
       let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            //            captureMetadataOutput.rectOfInterest = CGRect(x:0,y:UIScreen.main.bounds.size.height/2,width:UIScreen.main.bounds.size.width, height:300)
            
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            
            view.layer.addSublayer(videoPreviewLayer!)
            
            let viewScanTop:UIView = UIView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/2 - Common.Size(s: 40)))
            viewScanTop.backgroundColor = UIColor.black
            viewScanTop.alpha = 0.4
            view.addSubview(viewScanTop)
            
            let viewScanBottom:UIView = UIView(frame:CGRect(x: 0, y: viewScanTop.frame.size.height + Common.Size(s: 120), width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/2 - Common.Size(s: 40)))
            viewScanBottom.backgroundColor = UIColor.black
            viewScanBottom.alpha = 0.4
            view.addSubview(viewScanBottom)
            
            let viewScanLeft:UIView = UIView(frame:CGRect(x: 0, y: viewScanTop.frame.size.height, width: Common.Size(s: 30), height: Common.Size(s: 120)))
            viewScanLeft.backgroundColor = UIColor.black
            viewScanLeft.alpha = 0.4
            view.addSubview(viewScanLeft)
            
            let viewScanRight:UIView = UIView(frame:CGRect(x: UIScreen.main.bounds.size.width - Common.Size(s: 30), y: viewScanLeft.frame.origin.y, width: Common.Size(s: 30), height: Common.Size(s: 120)))
            viewScanRight.backgroundColor = UIColor.black
            viewScanRight.alpha = 0.4
            view.addSubview(viewScanRight)
            
            let scanLayer = CAShapeLayer()
            scanLayer.path = UIBezierPath(roundedRect: CGRect(x: Common.Size(s: 30), y: UIScreen.main.bounds.size.height/2 - Common.Size(s: 40), width: UIScreen.main.bounds.size.width - Common.Size(s: 60), height: 1.5), cornerRadius: 2).cgPath
            scanLayer.fillColor = UIColor.green.cgColor
            scanLayer.lineWidth = 1.5
            videoPreviewLayer?.addSublayer(scanLayer)
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 1
            animation.repeatCount = 500
            animation.autoreverses = true
            
            animation.fromValue = NSValue(cgPoint: CGPoint(x:scanLayer.frame.origin.x, y:scanLayer.frame.origin.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x:scanLayer.frame.origin.x,y: scanLayer.frame.origin.y + Common.Size(s: 120)))
            scanLayer.add(animation, forKey: "position")
            
            // Start video capture.
            captureSession?.startRunning()
            
            // Move the message label and top bar to the front
            //            view.bringSubview(toFront: messageLabel)
            
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubviewToFront(qrCodeFrameView)
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
    }
    
    func actionSelectVoucher(){
        _ = navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        delegate?.scanSuccess(self, scan: "SELECT_SERI_SIM_4G")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate Methods
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            //            messageLabel.text = "No QR/barcode is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                //                messageLabel.text = metadataObj.stringValue
                
                _ = navigationController?.popViewController(animated: true)
                dismiss(animated: true, completion: nil)
                if (success == false){
                    delegate?.scanSuccess(self, scan: metadataObj.stringValue!)
                    success = true
                }
            }
        }
    }
    
}

