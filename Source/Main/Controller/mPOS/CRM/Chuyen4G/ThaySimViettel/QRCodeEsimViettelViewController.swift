//
//  QRCodeEsimViettelViewController.swift
//  fptshop
//
//  Created by Apple on 4/23/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class QRCodeEsimViettelViewController: UIViewController {
    
    var viewImageQRCode:UIView!
    var viewInfoUploadImage:UIView!
    var scrollView:UIScrollView!
    var esimQRCode:EsimQRCode?
    var btDone:UIButton!
    var isFromHistory = false
    
    override func viewDidLoad() {
        
        
        self.view.backgroundColor = UIColor.blue
        self.title = "QRCode"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        
        let imgViewQRCode  = UIImageView(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 200)))
        
        if let decodedImageData = Data(base64Encoded: self.esimQRCode!.arrQRCode, options: .ignoreUnknownCharacters) {
            let image = UIImage(data: decodedImageData)
            //self.viewQRCodeButton.image = image
            
            
            
            
            
            imgViewQRCode.contentMode = .scaleAspectFit
            imgViewQRCode.image = image
            scrollView.addSubview(imgViewQRCode)
            
            
            
            
            
        }
        
        //        let data = self.esimQRCode!.arrQRCode.data(using: String.Encoding.ascii)
        //        // Get a QR CIFilter
        //        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return }
        //        // Input the data
        //        qrFilter.setValue(data, forKey: "inputMessage")
        //        // Get the output image
        //        guard let qrImage = qrFilter.outputImage else { return }
        //        // Scale the image
        //        let transform = CGAffineTransform(scaleX: 50, y: 50)
        //        let scaledQrImage = qrImage.transformed(by: transform)
        //        // Do some processing to get the UIImage
        //        let context = CIContext()
        //        guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return }
        //        //let processedImage = UIImage(cgImage: cgImage)
        //          viewChanDungButton.image = UIImage(cgImage: cgImage)
        
        let lbTextPhone =  UILabel(frame: CGRect(x: Common.Size(s:15), y: imgViewQRCode.frame.origin.y + imgViewQRCode.frame.size.height + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhone.textAlignment = .left
        lbTextPhone.textColor = UIColor.black
        lbTextPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhone.text = "Số thuê bao: \(self.esimQRCode!.sdt)"
        scrollView.addSubview(lbTextPhone)
        
        let lbSeriSim =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbTextPhone.frame.origin.y + lbTextPhone.frame.size.height + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbSeriSim.textAlignment = .left
        lbSeriSim.textColor = UIColor.black
        lbSeriSim.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSeriSim.text = "Số ESIM: \(self.esimQRCode!.serial)"
        self.view.addSubview(lbSeriSim)
        
        btDone = UIButton()
        btDone.frame = CGRect(x: lbSeriSim.frame.origin.x, y: lbSeriSim.frame.origin.y + lbSeriSim.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30),height: Common.Size(s: 40))
        btDone.backgroundColor = UIColor(netHex:0x47B054)
        btDone.setTitle("Hoàn Tất", for: .normal)
        btDone.addTarget(self, action: #selector(actionDone), for: .touchUpInside)
        btDone.layer.borderWidth = 0.5
        btDone.layer.borderColor = UIColor.white.cgColor
        btDone.layer.cornerRadius = 3
        btDone.clipsToBounds = true
        scrollView.addSubview(btDone)
        
        //
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btDone.frame.origin.y + btDone.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 60))
        
        
    }
    
    @objc func actionDone(){
        if self.isFromHistory {
            for vc in self.navigationController?.viewControllers ?? [] {
                if vc is UpdateSimHistoryViewController {
                    self.navigationController?.popToViewController(vc, animated: true)
                }
            }
        } else {
            for vc in self.navigationController?.viewControllers ?? [] {
                if vc is ChonNhaMangThaySimViewController {
                    self.navigationController?.popToViewController(vc, animated: true)
                }
            }
        }
        
    }
    
}
