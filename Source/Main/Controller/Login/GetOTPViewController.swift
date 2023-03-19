//
//  GetOTPViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 3/27/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
import PopupDialog
import Toaster
class GetOTPViewController: UIViewController {
    var scrollView: UIScrollView!
    var tfUserName:SkyFloatingLabelTextFieldWithIcon!
    var imageAvatar:UIImageView!
    var lbCRM:UILabel!
    var key: String = ""
    var lbAgain: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(GetOTPViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        self.title = "Lấy mã xác thực"
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        self.view.addSubview(scrollView)
        
        tfUserName = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)), iconType: .image)
        tfUserName.placeholder = "Mã Inside"
        tfUserName.title = "Mã Inside"
        tfUserName.iconImage = UIImage(named: "username")
        tfUserName.tintColor = UIColor(netHex:0x069C90)
        tfUserName.lineColor = UIColor(netHex:0x069C90)
        tfUserName.selectedTitleColor = UIColor(netHex:0x069C90)
        tfUserName.selectedLineColor = UIColor(netHex:0x069C90)
        tfUserName.lineHeight = 1.0
        tfUserName.selectedLineHeight = 1.0
        tfUserName.clearButtonMode = .whileEditing
        tfUserName.keyboardType = .numberPad
        scrollView.addSubview(tfUserName)
        
        var y = (scrollView.frame.size.height - tfUserName.frame.size.height - tfUserName.frame.origin.y)/2 - tfUserName.frame.size.width/2
        y = y - Common.Size(s: 15)
        imageAvatar = UIImageView(frame: CGRect(x: Common.Size(s: 20), y: y + tfUserName.frame.origin.y + tfUserName.frame.size.height, width: tfUserName.frame.size.width, height: tfUserName.frame.size.width - Common.Size(s: 30)))
        imageAvatar.clipsToBounds = true
        scrollView.addSubview(imageAvatar)
        imageAvatar.contentMode = .scaleAspectFit
        
        
        lbCRM = UILabel(frame: CGRect(x: imageAvatar.frame.origin.x, y: imageAvatar.frame.size.height + imageAvatar.frame.origin.y + Common.Size(s: 15), width: imageAvatar.frame.size.width, height: Common.Size(s: 30)))
        lbCRM.attributedText = NSAttributedString(string: "----------------",attributes:[ NSAttributedString.Key.kern: 4])
        lbCRM.textAlignment = .center
        lbCRM.font =  UIFont.boldSystemFont(ofSize: Common.Size(s: 20))
        scrollView.addSubview(lbCRM)
        lbCRM.isHidden = true
        lbAgain = UILabel(frame: CGRect(x: imageAvatar.frame.origin.x + lbCRM.frame.size.width/4, y: lbCRM.frame.origin.y + lbCRM.frame.size.height + Common.Size(s:10), width: lbCRM.frame.size.width/2, height: Common.Size(s: 30)))
        lbAgain.textAlignment = .center
        lbAgain.textColor = UIColor(netHex:0x47B054)
        lbAgain.layer.cornerRadius = 10.0
        lbAgain.layer.borderColor = UIColor(netHex:0x47B054).cgColor
        lbAgain.layer.borderWidth = 0.5
        lbAgain.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        lbAgain.text = "Sao chép"
        lbAgain.numberOfLines = 1
        scrollView.addSubview(lbAgain)
        lbAgain.isHidden = true
        
        let tapAgain = UITapGestureRecognizer(target: self, action: #selector(GetOTPViewController.functionRemove))
        lbAgain.isUserInteractionEnabled = true
        lbAgain.addGestureRecognizer(tapAgain)
        
        let btOTP = UIButton(frame: CGRect(x:tfUserName.frame.origin.x, y: tfUserName.frame.origin.y + tfUserName.frame.size.height + Common.Size(s: 20), width: tfUserName.frame.size.width, height: Common.Size(s: 40)))
        btOTP.backgroundColor = UIColor(netHex:0x00955E)
        btOTP.setTitle("XÁC NHẬN", for: .normal)
        btOTP.addTarget(self, action: #selector(actionOTP), for: .touchUpInside)
        btOTP.layer.borderWidth = 0.5
        btOTP.layer.borderColor = UIColor.white.cgColor
        btOTP.layer.cornerRadius = 5.0
        scrollView.addSubview(btOTP)
    }
    @objc func functionRemove(sender:UITapGestureRecognizer) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = "\(key)"
        Toast.init(text: "Đã sao chép").show()
    }
    @objc func actionOTP() {
        let user = tfUserName.text!
        tfUserName.resignFirstResponder()
        tfUserName.isUserInteractionEnabled = false
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        APIManager.sp_mpos_FRT_SP_Check_quyen_gen_otp_getway(UserID_OTP: user) { (resultCHECK, errCHECK) in
            if(resultCHECK == 1){
                APIManager.checkOTP(username: user) { (result, err) in
                    self.tfUserName.isUserInteractionEnabled = true
                    if(result != nil){
                        if(result!.enabled){
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                
                                let popup = PopupDialog(title: "THÔNG BÁO", message: "User \(user) đã được kích hoạt OTP. Bạn muốn lấy lại OTP mới?", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
//                                let buttonOne = CancelButton(title: "Sử dụng OTP cũ") {
//
////                                    let url = URL(string: "\(result!.qrCodeUrl)")!
////                                    self.imageAvatar.kf.setImage(with: url,
////                                                                 placeholder: nil,
////                                                                 options: [.transition(.fade(1))],
////                                                                 progressBlock: nil,
////                                                                 completionHandler: nil)
//                                    if let decodedData = Data(base64Encoded: "\(result!.qrCodeUrl)", options: .ignoreUnknownCharacters) {
//                                        let image = UIImage(data: decodedData)
//                                        self.imageAvatar.image = image
//                                    }
//                                    self.key = "\(result!.secret)"
//                                    self.lbCRM.attributedText = NSAttributedString(string: "\(result!.secret)",attributes:[ NSAttributedString.Key.kern: 4])
//                                    self.lbCRM.isHidden = false
//                                    self.lbAgain.isHidden = false
//                                }
                                let buttonTwo = DefaultButton(title: "Lấy mã xác thực mới") {
                                    let newViewController = LoadingViewController()
                                    newViewController.content = "Đang lấy mã xác thực mới..."
                                    newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                                    newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                                    self.navigationController?.present(newViewController, animated: true, completion: nil)
                                    
                                    APIManager.getOTP(username: user, action: "renew", handler: { (result, err) in
                                        let when = DispatchTime.now() + 0.5
                                        DispatchQueue.main.asyncAfter(deadline: when) {
                                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                            if(result != nil){
                                                if(result!.enabled){
//                                                    let url = URL(string: "\(result!.qrCodeUrl)")!
//                                                    self.imageAvatar.kf.setImage(with: url,
//                                                                                 placeholder: nil,
//                                                                                 options: [.transition(.fade(1))],
//                                                                                 progressBlock: nil,
//                                                                                 completionHandler: nil)
                                                    if let decodedData = Data(base64Encoded: "\(result!.qrCodeUrl)", options: .ignoreUnknownCharacters) {
                                                        let image = UIImage(data: decodedData)
                                                        self.imageAvatar.image = image
                                                    }
                                                    self.key = "\(result!.secret)"
                                                    self.lbCRM.attributedText = NSAttributedString(string: "\(result!.secret)",attributes:[ NSAttributedString.Key.kern: 4])
                                                    self.lbCRM.isHidden = false
                                                    self.lbAgain.isHidden = false
                                                }
                                            }else{
                                                let popup = PopupDialog(title: "THÔNG BÁO", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                    print("Completed")
                                                }
                                                let buttonOne = CancelButton(title: "OK") {
                                                }
                                                popup.addButtons([buttonOne])
                                                self.present(popup, animated: true, completion: nil)
                                            }
                                        }
                                    })
                                    
                                }
                                popup.addButtons([buttonTwo])
                                self.present(popup, animated: true, completion: nil)
                            }
                        }else{
                            APIManager.getOTP(username: user, action: "enable", handler: { (result, err) in
                                let when = DispatchTime.now() + 0.5
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    if(result != nil){
                                        if(result!.enabled){
//                                            let url = URL(string: "\(result!.qrCodeUrl)")!
//                                            self.imageAvatar.kf.setImage(with: url,
//                                                                         placeholder: nil,
//                                                                         options: [.transition(.fade(1))],
//                                                                         progressBlock: nil,
//                                                                         completionHandler: nil)
                                            if let decodedData = Data(base64Encoded: "\(result!.qrCodeUrl)", options: .ignoreUnknownCharacters) {
                                                let image = UIImage(data: decodedData)
                                                self.imageAvatar.image = image
                                            }
                                            self.key = "\(result!.secret)"
                                            self.lbCRM.attributedText = NSAttributedString(string: "\(result!.secret)",attributes:[ NSAttributedString.Key.kern: 4])
                                            self.lbCRM.isHidden = false
                                            self.lbAgain.isHidden = false
                                        }
                                    }else{
                                        let popup = PopupDialog(title: "THÔNG BÁO", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                            print("Completed")
                                        }
                                        let buttonOne = CancelButton(title: "OK") {
                                        }
                                        popup.addButtons([buttonOne])
                                        self.present(popup, animated: true, completion: nil)
                                    }
                                }
                            })
                        }
                    }else{
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            let popup = PopupDialog(title: "THÔNG BÁO", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    }
                }
            }else{
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let popup = PopupDialog(title: "THÔNG BÁO", message: errCHECK, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        self.tfUserName.isUserInteractionEnabled = true
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
            }
        }
        
        
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
