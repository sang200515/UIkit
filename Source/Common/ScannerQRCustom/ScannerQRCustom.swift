//
//  ScannerQRCustom.swift
//  fptshop
//
//  Created by KhanhNguyen on 10/26/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import AVFoundation

public protocol ScannerQRCustomDelegate: AnyObject {
    
    var videoPreview: UIView { get }
    /// rect of focus while scanning. Metadata outside of this rect will be skipped
    var rectOfInterest: UIView { get }
    
    func quickScanner(_ scanner: ScannerQRCustom, didCaptureCode code: String, type: CodeTypeScan)
    func quickScanner(_ scanner: ScannerQRCustom, didReceiveError error: ScannerQRCustomError)
    func quickScannerDidSetup(_ scanner: ScannerQRCustom)
    func quickScannerDidEndScanning(_ scanner: ScannerQRCustom)
}

public enum ScannerQRCustomError: Swift.Error {
    case notAuthorizedToUseCamera
    case cameraInvalid
    case cameraNotFound
    case invalidCodeScanned
    case system(_: Swift.Error)
    case other
}

enum EnvironmentScannerQRCustom {
    
    case simulator
    case device
    
    static var current: EnvironmentScannerQRCustom {
        
        #if targetEnvironment(simulator)
        return .simulator
        #else
        return .device
        #endif
    }
}

open class ScannerQRCustom: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    
    open weak var delegate: ScannerQRCustomDelegate? {
        didSet {
            self.prepareCamera()
        }
    }
    
    private let scannerQueue = DispatchQueue(label: "QuickScanner Queue")
    private let metadataScannerQueue = DispatchQueue(label: "Metadata QuickScanner Queue")
    
    private var captureSession: AVCaptureSession
    private var captureDevice: AVCaptureDevice?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    private var output: AVCaptureMetadataOutput?
    
    private var videoPermission: VideoPermission
    private var codeTypes: [CodeTypeScan]
    
    /// Rect for scanning focus area. It calculate coordinates of ROI based on coordinates of videoPreview.
    private var roiBounds: CGRect {
        guard let roi = delegate?.rectOfInterest, let videoPreview = delegate?.videoPreview else {
            return CGRect.zero
        }
        return roi.convert(roi.bounds, to: videoPreview)
    }
    
    open var isCapturing: Bool {
        return captureSession.isRunning
    }
    
    deinit {
        captureSession.stopRunning()
        videoPreviewLayer?.removeFromSuperlayer()
        delegate = nil
        
        if let output = output {
            captureSession.removeOutput(output)
        }
    }
    
    /// Initialize the captureSession object.
    public init(codeTypes: [CodeTypeScan]) {
        captureSession = AVCaptureSession()
        videoPermission = VideoPermission()
        self.codeTypes = codeTypes
    }
    
    private func prepareCamera() {
        self.scannerQueue.async {
            self.videoPermission.checkPersmission { [weak self] error in
                guard let `self` = self else { return }
                
                guard error == nil else {
                    DispatchQueue.main.async {
                        self.delegate?.quickScanner(self, didReceiveError: ScannerQRCustomError.notAuthorizedToUseCamera)
                    }
                    return
                }
                
                self.prepareVideoPreviewLayer()
                self.setupSessionInput(for: .back)
                self.setupSessionOutput()
                
                DispatchQueue.main.async {
                    self.insertPreviewLayer()
                    self.layoutFrames()
                    self.delegate?.quickScannerDidSetup(self)
                }
            }
        }
    }
    
    /**
     Setup instance of the AVCaptureDevice class to initialize a device object
     and provide the video as the media type parameter.
     */
    private func prepareVideoPreviewLayer() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    }
    
    func layoutFrames() {
        self.videoPreviewLayer.frame = self.delegate?.videoPreview.bounds ?? .zero
        self.delegate?.videoPreview.setNeedsLayout()
    }
    
    fileprivate func insertPreviewLayer() {
        self.delegate?.videoPreview.layer.insertSublayer(self.videoPreviewLayer, at: 0)
    }
    
    private func setupSessionInput(for position: CameraPosition) {
        if EnvironmentScannerQRCustom.current == .simulator { return }
        
        guard let device = ScannerQRCustom.Camera.device(for: position) else {
            delegate?.quickScanner(self, didReceiveError: ScannerQRCustomError.cameraNotFound)
            return
        }
        
        // Get an instance of the AVCaptureDeviceInput class using the previous device object.
        do {
            let input = try AVCaptureDeviceInput(device: device)
            try device.lockForConfiguration()
            captureSession.beginConfiguration()
            
            // autofocus settings and focus on middle point
            device.autoFocusRangeRestriction = .near
            device.focusMode = .continuousAutoFocus
            device.exposureMode = .continuousAutoExposure
            
            if let currentInput = captureSession.inputs.filter({$0 is AVCaptureDeviceInput}).first {
                captureSession.removeInput(currentInput)
            }
            
            // Set the input device on the capture session.
            
            if device.supportsSessionPreset(.hd1920x1080) == true {
                captureSession.sessionPreset = .hd1920x1080
            } else if device.supportsSessionPreset(.high) == true {
                captureSession.sessionPreset = .high
            }
            
            captureSession.usesApplicationAudioSession = false
            captureSession.addInput(input)
            captureSession.commitConfiguration()
            captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
            if device.isLowLightBoostSupported == true {
                device.automaticallyEnablesLowLightBoostWhenAvailable = true
            }
            device.unlockForConfiguration()
            captureDevice = device
            
        } catch(let error) {
            
            delegate?.quickScanner(self, didReceiveError: ScannerQRCustomError.system(error))
            ScannerQRCustomLogger.warning(message: error.localizedDescription)
            return
        }
    }
    
    private func setupSessionOutput() {
        if EnvironmentScannerQRCustom.current == .simulator { return }
        
        let captureOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureOutput)
        captureOutput.setMetadataObjectsDelegate(self, queue: metadataScannerQueue)
        captureOutput.metadataObjectTypes = self.codeTypes
        
        output = captureOutput
    }
    
    /// Remember to use in main thread
    private func configurePointOfInterests() {
        guard let device = self.captureDevice else { return }
        guard let videoPreviewLayer = self.videoPreviewLayer else { return }
        
        do {
            try device.lockForConfiguration()
            let point = CGPoint(x: roiBounds.midX, y: roiBounds.midY)
            let convPoint = videoPreviewLayer.captureDevicePointConverted(fromLayerPoint: point)
            
            device.exposurePointOfInterest = convPoint
            device.focusPointOfInterest = convPoint
            device.unlockForConfiguration()
        } catch {
            delegate?.quickScanner(self, didReceiveError: .system(error))
        }
    }
    
    private func configureRectOfInterest() {
        let roi = videoPreviewLayer.metadataOutputRectConverted(fromLayerRect: roiBounds)
        output?.rectOfInterest = roi
    }
    
    // MARK: - Open functions to use framework
    open func startCapturing() {
        self.scannerQueue.async {
            self.videoPermission.checkPersmission { [weak self] error in
                guard let `self` = self else { return }
                
                guard error == nil else {
                    DispatchQueue.main.async {
                        self.delegate?.quickScanner(self, didReceiveError: ScannerQRCustomError.notAuthorizedToUseCamera)
                    }
                    return
                }
                
                self.captureSession.startRunning()
                
                DispatchQueue.main.async {
                    self.configurePointOfInterests()
                    self.configureRectOfInterest()
                }
            }
        }
    }
    
    open func stopCapturing() {
        scannerQueue.async {
            self.captureSession.stopRunning()
            DispatchQueue.main.async {
                self.delegate?.quickScannerDidEndScanning(self)
            }
        }
    }
    
}

extension ScannerQRCustom {
    
    class Camera {
        
        static func device(for position: CameraPosition) -> AVCaptureDevice? {
            switch position {
            case .front:
                return Camera.front
            case .back:
                return Camera.back
            default:
                return nil
            }
        }
        
        private static var front: AVCaptureDevice? {
            return AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                                           for: AVMediaType.video,
                                           position: CameraPosition.front)
        }
        
        private static var back: AVCaptureDevice? {
            return AVCaptureDevice.default(for: .video)
        }
    }
}

extension ScannerQRCustom {

    open func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        for obj in metadataObjects {
            guard let text = (obj as? AVMetadataMachineReadableCodeObject)?.stringValue else { return }

            let myGroup = DispatchGroup()
            myGroup.enter()
            stopCapturing()
            myGroup.leave() //// When your task completes
            myGroup.notify(queue: DispatchQueue.main) {
                self.delegate?.quickScanner(self, didCaptureCode: text, type: obj.type)
            }
        }
    }
}


