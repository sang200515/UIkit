//
//  ScanCustomerQRCodeZaloScreen.swift
//  fptshop
//
//  Created by KhanhNguyen on 10/22/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ScanCustomerQRCodeZaloScreen: BaseController {
    
    fileprivate var qrCodeScanner: ScannerQRCustom!
    
    let vScanQR: UIImageView = {
        let scanView = UIImageView()
        scanView.image = UIImage.init(named: "img_scan_border")
        scanView.translatesAutoresizingMaskIntoConstraints = false
        return scanView
    }()
    
    let btnScan: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.COLORS.main_red_my_info
        button.setTitle("DỪNG", for: .normal)
        button.makeCorner(corner: 8)
        return button
    }()
    
    private var senderID: String?
    private var urlImage: String?
    private var userNameZalo: String?
    private var createDate: String?
    
    override func setupViews() {
        super.setupViews()
        self.title = "Scan QR Code Zalo"
        
        let types: [CodeTypeScan] = [
            CodeTypeScan.aztec,
            CodeTypeScan.code128,
            CodeTypeScan.code39,
            CodeTypeScan.code39Mod43,
            CodeTypeScan.code93,
            CodeTypeScan.dataMatrix,
            CodeTypeScan.ean13,
            CodeTypeScan.ean8,
            CodeTypeScan.interleaved2of5,
            CodeTypeScan.itf14,
            CodeTypeScan.pdf417,
            CodeTypeScan.qr,
            CodeTypeScan.upce
        ]
        
        qrCodeScanner = ScannerQRCustom(codeTypes: types)
        qrCodeScanner.delegate = self
        
        self.view.addSubview(vScanQR)
        vScanQR.myAnchorWithUIEdgeInsets(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 30, bottom: 0, right: 30), size: .zero)
        vScanQR.addConstraint(NSLayoutConstraint(item: vScanQR,
                                                 attribute: .height,
                                                 relatedBy: .equal,
                                                 toItem: vScanQR,
                                                 attribute: .width,
                                                 multiplier: 1.0 / 1.0,
                                                 constant: 0))
        
        view.addSubview(btnScan)
        btnScan.myAnchorWithUIEdgeInsets(top: vScanQR.bottomAnchor, leading: vScanQR.leadingAnchor, bottom: nil, trailing: vScanQR.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0), size: .zero)
        
        btnScan.addTarget(self, action: #selector(scanTapped(_:)), for: .touchUpInside)
        btnScan.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        qrCodeScanner.startCapturing()
    }
    
    fileprivate func scanQRCodeCustomer(_ qrCode: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            FollowZaloShopAPIManager.shared.verify_QRCode_Zalo_Customer(qrCode, completion: {[weak self] (result) in
                guard let strongSelf = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if let item = result {
                        //                        strongSelf.showAlertOneButton(title: "QR Scan", with: "\(item.messages ?? "") \n \(item.fullname ?? "") \n \(item.phonenumber ?? "")", titleButton: "Ok") {
                        //                            if item.fullname != "" {
                        //
                        //                            } else {
                        //                                strongSelf.navigationController?.popViewController(animated: true)
                        //                            }
                        //                        }
                        if item.messages != "" {
                            let infoCustomerVC = InfoCustomerFollowZaloScreen()
                            infoCustomerVC.getSenderID(strongSelf.senderID ?? "")
                            infoCustomerVC.getNameCustomer(strongSelf.userNameZalo ?? "")
                            infoCustomerVC.loadImgAvatar(strongSelf.urlImage ?? "")
                            infoCustomerVC.getCreateDate(strongSelf.createDate ?? "")
                            if item.phonenumber != "" {
                                infoCustomerVC.getPhoneNumberInput(item.phonenumber ?? "")
                            }
                            
                            if item.fullname != "" {
                                infoCustomerVC.getNameInput(item.fullname ?? "")
                            }
                            
                            if item.gender != "" {
                                infoCustomerVC.getGender(item.gender ?? "")
                            }
                                
                            strongSelf.navigationController?.pushViewController(infoCustomerVC, animated: true)
                        }
                    }
                }
                
            }) {[weak self] (error) in
                guard let strongSelf = self else {return}
                strongSelf.showAlertOneButton(title: "QR Scan", with: error ?? "", titleButton: "Ok")
            }
        }
    }
    
    @objc private func scanTapped(_ sender: UIButton) {
        let buttonTitle = qrCodeScanner.isCapturing ? "DỪNG" : "TIẾP TỤC"
        let buttonColor = qrCodeScanner.isCapturing ? Constants.COLORS.bold_green : Constants.COLORS.main_red_my_info
        sender.setTitle(buttonTitle, for: .normal)
        sender.backgroundColor = buttonColor
    }
    
    func getURLImage(_ urlImg: String) {
        self.urlImage = urlImg
    }
    
    func getSenderID(_ id: String) {
        self.senderID = id
    }
    
    func getUserNameZalo(_ name: String) {
        self.userNameZalo = name
    }
    
    func getCreateDate(_ date: String) {
        self.createDate = date
    }
    
    func createScannerGradientLayer(for view: UIView) -> CAGradientLayer {
        let height: CGFloat = 50
        let opacity: Float = 0.5
        let topColor = Constants.COLORS.bold_green
        let bottomColor = topColor.withAlphaComponent(0)
        
        let layer = CAGradientLayer()
        layer.colors = [topColor.cgColor, bottomColor.cgColor]
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
}

extension ScanCustomerQRCodeZaloScreen: ScannerQRCustomDelegate {
    var videoPreview: UIView {
        return self.view
    }
    
    var rectOfInterest: UIView {
        return vScanQR
    }
    
    func quickScanner(_ scanner: ScannerQRCustom, didCaptureCode code: String, type: CodeTypeScan) {
        self.scanQRCodeCustomer(code)
    }
    
    func quickScanner(_ scanner: ScannerQRCustom, didReceiveError error: ScannerQRCustomError) {
        self.showAlertOneButton(title: "Thông báo", with: error.localizedDescription, titleButton: "Ok")
    }
    
    func quickScannerDidSetup(_ scanner: ScannerQRCustom) {
        scanner.startCapturing()
    }
    
    func quickScannerDidEndScanning(_ scanner: ScannerQRCustom) {
        printLog(function: #function, json: "barcodeScannerDidEndScanning")
    }
    
    
}
