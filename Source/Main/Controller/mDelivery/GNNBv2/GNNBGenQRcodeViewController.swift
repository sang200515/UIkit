//
//  GNNBGenQRcodeViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 8/28/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class GNNBGenQRcodeViewController: UIViewController {
    
    var imgQRcode: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Gen QRCode"
        self.view.backgroundColor = .white
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        let viewCofirmQrcode = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s: 25), height: Common.Size(s: 25))))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: viewCofirmQrcode)
        let btCofirmQrcodeIcon = UIButton.init(type: .custom)
        btCofirmQrcodeIcon.setImage(#imageLiteral(resourceName: "icons8-available-updates-100"), for: UIControl.State.normal)
        btCofirmQrcodeIcon.imageView?.contentMode = .scaleToFill
        btCofirmQrcodeIcon.addTarget(self, action: #selector(genQRcode), for: UIControl.Event.touchUpInside)
        btCofirmQrcodeIcon.frame = CGRect(x: 0, y: 0, width: Common.Size(s: 25), height: Common.Size(s: 25))
        viewCofirmQrcode.addSubview(btCofirmQrcodeIcon)
        
        imgQRcode = UIImageView(frame: CGRect(x: Common.Size(s: 20), y: Common.Size(s: 20), width: self.view.frame.width - Common.Size(s: 40), height: self.view.frame.width - Common.Size(s: 40)))
        imgQRcode.backgroundColor = UIColor(netHex: 0xf0f4fa)
        imgQRcode.contentMode = .scaleAspectFit
        imgQRcode.image = #imageLiteral(resourceName: "qrcode")
        self.view.addSubview(imgQRcode)
        
        self.genQRcode()
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func genQRcode() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            APIManager.gnnbv2_GenQRCodeImg(typeQRCode: "1") { (keyQR, type, rsCode, msg, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rsCode == "200" {
//                            if let decodedImageData = Data(base64Encoded: keyQR, options: .ignoreUnknownCharacters) {
//                                let image = UIImage(data: decodedImageData)
//                                self.imgQRcode.image = image
//                            } else {
//                                self.imgQRcode.image = #imageLiteral(resourceName: "add-image-256")
//                            }
                            if let img = Barcode.fromString(string: keyQR) {
                                self.imgQRcode.image = img
                            } else {
                                let alert = UIAlertController(title: "Thông báo", message: "Gen thất bại. Vui lòng thử lại!", preferredStyle: UIAlertController.Style.alert)
                                let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                    self.imgQRcode.image = #imageLiteral(resourceName: "qrcode")
                                }
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            }
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "\(msg)", preferredStyle: UIAlertController.Style.alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }

}
