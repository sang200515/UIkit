//
//  GiaHanSSDViewController.swift
//  mPOS
//
//  Created by tan on 10/3/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
//import EPSignature
import PopupDialog
class GiaHanSSDViewController: UIViewController,UITextFieldDelegate,EPSignatureDelegate {
    var scrollView:UIScrollView!
    var tfPhone:UITextField!
    var btKiemTra:UIButton!
    var lbTitle1:UILabel!
    var lbTitle:UILabel!
    var lbTenKH:UILabel!
    var lbSoDuTK:UILabel!
    var lbGoiCuoc:UILabel!
    var lbCMND:UILabel!
    var lbNgaySinh:UILabel!
    var window: UIWindow?
    
    //--
    var imgViewSignature: UIImageView!
    var viewImageSign:UIView!
    var viewSign:UIView!
    //--
    var btSendOTP:UIButton!
    var btDangKy:UIButton!
    
    var otp:String = ""
    var token:String = ""
    var thongtingiahans:[ThongTinGiaHanSSD] = []
    

    override func viewDidLoad() {
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(GiaHanSSDViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Gia hạn SSD"
        
        let lbTextPhone =  UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhone.textAlignment = .left
        lbTextPhone.textColor = UIColor.black
        lbTextPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhone.text = "Số điện thoại"
        scrollView.addSubview(lbTextPhone)
        
        tfPhone = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhone.frame.origin.y + lbTextPhone.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfPhone.placeholder = "Nhập số điện thoại khách hàng"
        tfPhone.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhone.autocorrectionType = UITextAutocorrectionType.no
        tfPhone.keyboardType = UIKeyboardType.numberPad
        tfPhone.returnKeyType = UIReturnKeyType.done
        tfPhone.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhone.delegate = self
        tfPhone.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        scrollView.addSubview(tfPhone)
        
        btKiemTra = UIButton()
        btKiemTra.frame = CGRect(x: tfPhone.frame.origin.x, y: tfPhone.frame.origin.y + tfPhone.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30),height: Common.Size(s:40))
        btKiemTra.backgroundColor = UIColor(netHex:0x47B054)
        btKiemTra.setTitle("Kiểm tra", for: .normal)
        btKiemTra.addTarget(self, action: #selector(actionKiemTra), for: .touchUpInside)
        btKiemTra.layer.borderWidth = 0.5
        btKiemTra.layer.borderColor = UIColor.white.cgColor
        btKiemTra.layer.cornerRadius = 3
        scrollView.addSubview(btKiemTra)
        btKiemTra.clipsToBounds = true
        
        
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField == tfPhone){
            actionKiemTra()
        }
        
    }
    
    @objc func actionKiemTra(){
        self.tfPhone.resignFirstResponder()
        if(self.otp == ""){
            let sdt = self.tfPhone.text!
            
            if (sdt=="") {
                self.showDialog(message: "Vui lòng nhập số điện thoại khách hàng")
                return
            }
            if (sdt.hasPrefix("01") && sdt.count == 11){
                
            }else if (sdt.hasPrefix("0") && !sdt.hasPrefix("01") && sdt.count == 10){
                
            }else{
             
                self.showDialog(message: "Số điện thoại nhập sai định dạng!!!")
                return
            }
            let newViewController = LoadingViewController()
            newViewController.content = "Đang lấy thông tin khách hàng..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            MPOSAPIManager.getThongTinGiaHanSSD(phoneNumber: sdt) { (results,IsLogin,p_Status, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(IsLogin == "1"){
                        let title = "Thông báo"
                        let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            
                            let defaults = UserDefaults.standard
                            defaults.removeObject(forKey: "UserName")
                            defaults.removeObject(forKey: "Password")
                            defaults.removeObject(forKey: "mDate")
                            defaults.removeObject(forKey: "mCardNumber")
                            defaults.removeObject(forKey: "typePhone")
                            defaults.removeObject(forKey: "mPrice")
                            defaults.removeObject(forKey: "mPriceCardDisplay")
                            defaults.removeObject(forKey: "CRMCodeLogin")
                            defaults.synchronize()
//                            APIService.removeDeviceToken()
                            // Initialize the window
                            self.window = UIWindow.init(frame: UIScreen.main.bounds)
                            
                            // Set Background Color of window
                            self.window?.backgroundColor = UIColor.white
                            
                            // Allocate memory for an instance of the 'MainViewController' class
                            let mainViewController = LoginViewController()
                            
                            // Set the root view controller of the app's window
                            self.window!.rootViewController = mainViewController
                            
                            // Make the window visible
                            self.window!.makeKeyAndVisible()
                            
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                        
                        return
                    }
                    if(p_Status == "0"){
                    
                        self.showDialog(message: err)
                        return
                        
                    }
                    if(err.count <= 0){
                        if results.count > 0 {
                            self.thongtingiahans = results
                            self.setupUI(thongtingiahan: results[0])
                        }
 
                    }else{
                  
                        self.showDialog(message: err)
                    }
                }
            }
            
            
            
            
        }else{
            let popup = PopupDialog(title: "Thông báo", message: "Bạn muốn reload lại thông tin ?", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
                
            }
            let buttonOne = CancelButton(title: "Không") {
                
            }
            let buttonTwo = DefaultButton(title: "Có") {
                let sdt = self.tfPhone.text!
                
                if (sdt=="") {
                    self.showDialog(message: "Vui lòng nhập số điện thoại khách hàng")
                    return
                }
                if (sdt.hasPrefix("01") && sdt.count == 11){
                    
                }else if (sdt.hasPrefix("0") && !sdt.hasPrefix("01") && sdt.count == 10){
                    
                }else{
              
                    self.showDialog(message: "Số điện thoại nhập sai định dạng!!!")
                    return
                }
                
                let newViewController = LoadingViewController()
                newViewController.content = "Đang lấy thông tin khách hàng..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                MPOSAPIManager.getThongTinGiaHanSSD(phoneNumber: sdt) { (results,IsLogin,p_Status, err) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(IsLogin == "1"){
                            let title = "Thông báo"
                            let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                
                                let defaults = UserDefaults.standard
                                defaults.removeObject(forKey: "UserName")
                                defaults.removeObject(forKey: "Password")
                                defaults.removeObject(forKey: "mDate")
                                defaults.removeObject(forKey: "mCardNumber")
                                defaults.removeObject(forKey: "typePhone")
                                defaults.removeObject(forKey: "mPrice")
                                defaults.removeObject(forKey: "mPriceCardDisplay")
                                defaults.removeObject(forKey: "CRMCodeLogin")
                                defaults.synchronize()
//                                APIService.removeDeviceToken()
                                // Initialize the window
                                self.window = UIWindow.init(frame: UIScreen.main.bounds)
                                
                                // Set Background Color of window
                                self.window?.backgroundColor = UIColor.white
                                
                                // Allocate memory for an instance of the 'MainViewController' class
                                let mainViewController = LoginViewController()
                                
                                // Set the root view controller of the app's window
                                self.window!.rootViewController = mainViewController
                                
                                // Make the window visible
                                self.window!.makeKeyAndVisible()
                                
                                
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                            
                            return
                        }
                        if(p_Status == "0"){
                            let title = "Thông báo"
                            let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                
                                
                                
                                
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                            return
                            
                        }
                        if(err.count <= 0){
                            
                            self.thongtingiahans = results
                            self.setupUI(thongtingiahan: results[0])
                            
                        }else{
                          
                            self.showDialog(message: err)
                        }
                    }
                }
                
                
            }
            popup.addButtons([buttonOne,buttonTwo])
            self.present(popup, animated: true, completion: nil)
        }
        
    }
    
    func setupUI(thongtingiahan:ThongTinGiaHanSSD){
        if(lbTitle1 != nil){
            lbTitle1.subviews.forEach { $0.removeFromSuperview() }
            lbTitle1.frame = CGRect(x: Common.Size(s:15), y: btKiemTra.frame.origin.y + btKiemTra.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:30))
            lbTitle1.textAlignment = .left
            lbTitle1.textColor = UIColor.red
            lbTitle1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbTitle1.text = thongtingiahan.NoiDung
            
            lbTitle1.numberOfLines = 0
            lbTitle1.lineBreakMode = .byTruncatingTail // or .byWrappingWord
            lbTitle1.minimumScaleFactor = 0.8
        }else{
            lbTitle1 =  UILabel(frame: CGRect(x: Common.Size(s:15), y: btKiemTra.frame.origin.y + btKiemTra.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:30)))
            lbTitle1.textAlignment = .left
            lbTitle1.textColor = UIColor.red
            lbTitle1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbTitle1.text = thongtingiahan.NoiDung
            
            lbTitle1.numberOfLines = 0
            lbTitle1.lineBreakMode = .byTruncatingTail // or .byWrappingWord
            lbTitle1.minimumScaleFactor = 0.8
            
            
            scrollView.addSubview(lbTitle1)
        }
        
        
        let lblLine = UILabel()
        lblLine.backgroundColor = UIColor(netHex:0xEEEEEE)
        lblLine.frame = CGRect(x: 0 ,y: lbTitle1.frame.origin.y + lbTitle1.frame.size.height + Common.Size(s: 10) ,width: UIScreen.main.bounds.size.width  ,height: Common.Size(s:5))
        scrollView.addSubview(lblLine)
        
        lbTitle =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lblLine.frame.origin.y + lblLine.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:18)))
        lbTitle.textAlignment = .left
        lbTitle.textColor = UIColor(netHex:0x47B054)
        lbTitle.font = UIFont.systemFont(ofSize: Common.Size(s:18))
        lbTitle.text = "Thông tin kích hoạt"
        scrollView.addSubview(lbTitle)
        
        lbTenKH =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbTitle.frame.origin.y + lbTitle.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:16)))
        lbTenKH.textAlignment = .left
        lbTenKH.textColor = UIColor.black
        lbTenKH.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTenKH.text = "Tên khách hàng:   \(thongtingiahan.TenKH)"
        scrollView.addSubview(lbTenKH)
        
        
        
        
        lbNgaySinh =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbTenKH.frame.origin.y + lbTenKH.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:16)))
        lbNgaySinh.textAlignment = .left
        lbNgaySinh.textColor = UIColor.black
        lbNgaySinh.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbNgaySinh.text = "Ngày sinh:   \(thongtingiahan.NgaySinh)"
        scrollView.addSubview(lbNgaySinh)
        
        
        
        lbCMND =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbNgaySinh.frame.origin.y + lbNgaySinh.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:16)))
        lbCMND.textAlignment = .left
        lbCMND.textColor = UIColor.black
        lbCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMND.text = "CMND:   \(thongtingiahan.CMND)"
        scrollView.addSubview(lbCMND)
        
        
        
        lbGoiCuoc =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbCMND.frame.origin.y + lbCMND.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:16)))
        lbGoiCuoc.textAlignment = .left
        lbGoiCuoc.textColor = UIColor.black
        lbGoiCuoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbGoiCuoc.text = "Gói cước:   \(thongtingiahan.GoiCuoc)"
        scrollView.addSubview(lbGoiCuoc)
        
        if(lbSoDuTK != nil){
            let sodutk = Common.convertCurrencyV2(value: thongtingiahan.SoDuTaiKhoan)
            lbSoDuTK.text = "Số dư tài khoản:   \(sodutk) vnđ"
        }else{
            lbSoDuTK =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbGoiCuoc.frame.origin.y + lbGoiCuoc.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:16)))
            lbSoDuTK.textAlignment = .left
            lbSoDuTK.textColor = UIColor.black
            lbSoDuTK.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            let sodutk = Common.convertCurrencyV2(value: thongtingiahan.SoDuTaiKhoan)
            lbSoDuTK.text = "Số dư tài khoản:   \(sodutk) vnđ"
            scrollView.addSubview(lbSoDuTK)
        }
        
        
        if(viewSign != nil){
            
            
            
            viewSign.subviews.forEach { $0.removeFromSuperview() }
            
            viewSign.frame = CGRect(x:0, y: lbSoDuTK.frame.origin.y + lbSoDuTK.frame.size.height + Common.Size(s:10), width:scrollView.frame.size.width, height: 100)
            viewSign.clipsToBounds = true
            
            let lbTextSign = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
            lbTextSign.textAlignment = .left
            lbTextSign.textColor = UIColor(netHex:0x47B054)
            lbTextSign.font = UIFont.systemFont(ofSize: Common.Size(s:18))
            lbTextSign.text = "Chữ ký"
            lbTextSign.sizeToFit()
            viewSign.addSubview(lbTextSign)
            
            viewImageSign = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSign.frame.origin.y + lbTextSign.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
            viewImageSign.layer.borderWidth = 0.5
            viewImageSign.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
            viewImageSign.layer.cornerRadius = 3.0
            viewSign.addSubview(viewImageSign)
            
            let viewSignButton = UIImageView(frame: CGRect(x: viewImageSign.frame.size.width/2 - (viewImageSign.frame.size.height * 2/3)/2, y: 0, width: viewImageSign.frame.size.height * 2/3, height: viewImageSign.frame.size.height * 2/3))
            viewSignButton.image = UIImage(named:"Sign Up-50")
            viewSignButton.contentMode = .scaleAspectFit
            viewImageSign.addSubview(viewSignButton)
            
            let lbSignButton = UILabel(frame: CGRect(x: 0, y: viewSignButton.frame.size.height + viewSignButton.frame.origin.y, width: viewImageSign.frame.size.width, height: viewImageSign.frame.size.height/3))
            lbSignButton.textAlignment = .center
            lbSignButton.textColor = UIColor(netHex:0xc2c2c2)
            lbSignButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbSignButton.text = "Thêm chữ ký"
            viewImageSign.addSubview(lbSignButton)
            
            viewSign.frame.size.height = viewImageSign.frame.origin.y + viewImageSign.frame.size.height
            
            
            
            btSendOTP.frame = CGRect(x: tfPhone.frame.origin.x, y: viewSign.frame.origin.y + viewSign.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30),height: Common.Size(s:40))
            btDangKy.frame = CGRect(x: tfPhone.frame.origin.x, y: btSendOTP.frame.origin.y + btSendOTP.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30),height: Common.Size(s:0))
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btDangKy.frame.origin.y + btDangKy.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        }else{
            //sign
            viewSign = UIView(frame: CGRect(x:0, y: lbSoDuTK.frame.origin.y + lbSoDuTK.frame.size.height + Common.Size(s:10), width:scrollView.frame.size.width, height: 100))
            viewSign.clipsToBounds = true
            scrollView.addSubview(viewSign)
            
            let lbTextSign = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
            lbTextSign.textAlignment = .left
            lbTextSign.textColor = UIColor(netHex:0x47B054)
            lbTextSign.font = UIFont.systemFont(ofSize: Common.Size(s:18))
            lbTextSign.text = "Chữ ký"
            lbTextSign.sizeToFit()
            viewSign.addSubview(lbTextSign)
            
            viewImageSign = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSign.frame.origin.y + lbTextSign.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
            viewImageSign.layer.borderWidth = 0.5
            viewImageSign.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
            viewImageSign.layer.cornerRadius = 3.0
            viewSign.addSubview(viewImageSign)
            
            let viewSignButton = UIImageView(frame: CGRect(x: viewImageSign.frame.size.width/2 - (viewImageSign.frame.size.height * 2/3)/2, y: 0, width: viewImageSign.frame.size.height * 2/3, height: viewImageSign.frame.size.height * 2/3))
            viewSignButton.image = UIImage(named:"Sign Up-50")
            viewSignButton.contentMode = .scaleAspectFit
            viewImageSign.addSubview(viewSignButton)
            
            let lbSignButton = UILabel(frame: CGRect(x: 0, y: viewSignButton.frame.size.height + viewSignButton.frame.origin.y, width: viewImageSign.frame.size.width, height: viewImageSign.frame.size.height/3))
            lbSignButton.textAlignment = .center
            lbSignButton.textColor = UIColor(netHex:0xc2c2c2)
            lbSignButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbSignButton.text = "Thêm chữ ký"
            viewImageSign.addSubview(lbSignButton)
            
            viewSign.frame.size.height = viewImageSign.frame.origin.y + viewImageSign.frame.size.height
            
            let tapShowSign = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSign))
            //viewSign.isUserInteractionEnabled = false
            viewSign.addGestureRecognizer(tapShowSign)
            
            
            btSendOTP = UIButton()
            btSendOTP.frame = CGRect(x: tfPhone.frame.origin.x, y: viewSign.frame.origin.y + viewSign.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30),height: Common.Size(s:40))
            btSendOTP.backgroundColor = UIColor(netHex:0x47B054)
            btSendOTP.setTitle("Gửi OTP", for: .normal)
            btSendOTP.addTarget(self, action: #selector(checkOTP), for: .touchUpInside)
            btSendOTP.layer.borderWidth = 0.5
            btSendOTP.layer.borderColor = UIColor.white.cgColor
            btSendOTP.layer.cornerRadius = 3
            scrollView.addSubview(btSendOTP)
            btSendOTP.clipsToBounds = true
            
            
            btDangKy = UIButton()
            btDangKy.frame = CGRect(x: tfPhone.frame.origin.x, y: btSendOTP.frame.origin.y + btSendOTP.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30),height: Common.Size(s:0))
            btDangKy.backgroundColor = UIColor(netHex:0x47B054)
            btDangKy.setTitle("Đăng Ký", for: .normal)
            btDangKy.addTarget(self, action: #selector(actionUpHinhChuKy), for: .touchUpInside)
            btDangKy.layer.borderWidth = 0.5
            btDangKy.layer.borderColor = UIColor.white.cgColor
            btDangKy.layer.cornerRadius = 3
            scrollView.addSubview(btDangKy)
            btDangKy.clipsToBounds = true
            
            
            
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btDangKy.frame.origin.y + btDangKy.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        }
        
        
    }
    
    @objc func actionUpHinhChuKy(){
        let imageSign:UIImage = self.resizeImage(image: imgViewSignature.image!,newHeight: 500)!
        if let imageDataChuKy:NSData = imageSign.pngData() as NSData?{
            let srtBase64ChuKy = imageDataChuKy.base64EncodedString(options: .endLineWithLineFeed)
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang upload chữ ký khách hàng..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            MPOSAPIManager.uploadHinhGiaHanSSD(p_Signature: srtBase64ChuKy, thongtingiahan: thongtingiahans[0]) { (results, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        
                        self.actionDangKy()
                        
                    }else{
                      
                        self.showDialog(message: err)
                    }
                }
            }
            
        }
        
        
    }
    
    func actionDangKy(){
        let imageSign:UIImage = self.resizeImage(image: imgViewSignature.image!,newHeight: 500)!
        if let _:NSData = imageSign.pngData() as NSData?{
   
            let newViewController = LoadingViewController()
            newViewController.content = "Đang gia hạn gói cước..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            MPOSAPIManager.giaHanSSDResult(thongtingiahan: self.thongtingiahans[0],token:self.token,otp:self.otp) { (results, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        
                        let title = "Thông báo"
                        let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            if(results.Success == true){
                                //self.btDangKy.frame.size.height = 0
                                
                                
                                _ = self.navigationController?.popViewController(animated: true)
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                        
                    }else{
                       
                        self.showDialog(message: err)
                    }
                }
            }
            
        }
    }
    
    
    func actionSendOTP(otp:String,token:String){
        self.otp = otp
        self.token = token
        self.btSendOTP.frame.size.height = 0
        btDangKy.frame = CGRect(x: tfPhone.frame.origin.x, y: viewSign.frame.origin.y + viewSign.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30),height: Common.Size(s:40))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btDangKy.frame.origin.y + btDangKy.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    
    @objc func checkOTP(){
        
        if(self.thongtingiahans[0].TenKH == ""){
            self.showDialog(message: self.thongtingiahans[0].NoiDung)
            return
        }
        
        
        let sdt = self.tfPhone.text!
        
        if (sdt=="") {
            self.showDialog(message: "Vui lòng nhập số điện thoại khách hàng")
            return
        }
        if (sdt.hasPrefix("01") && sdt.count == 11){
            
        }else if (sdt.hasPrefix("0") && !sdt.hasPrefix("01") && sdt.count == 10){
            
        }else{
        
            self.showDialog(message: "Số điện thoại nhập sai định dạng!!!")
            return
        }
        
        if (imgViewSignature == nil){
            self.showDialog(message: "Khách hàng chưa ký tên")
            return
        }
        
        if(self.thongtingiahans[0].p_status == 2){
            if(self.thongtingiahans[0].SoDuTaiKhoan < self.thongtingiahans[0].TienGoiCuoc){
                let tiengoicuocstring = Common.convertCurrencyV2(value: self.thongtingiahans[0].TienGoiCuoc)
                let message = "Thuê bao \(self.thongtingiahans[0].SDT) cần có số dư tài khoản tối thiểu là \(tiengoicuocstring) để gia hạn gói cước \(self.thongtingiahans[0].GoiCuoc)"
              
                self.showDialog(message: message)
                return
            }
        }
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang gửi mã OTP.."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.getOTPGiaHanSSD(isdn: self.tfPhone.text!) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){

                        self.showInputDialog(title: "OTP",
                                             subtitle: "Vui lòng nhập mã OTP",
                                             actionTitle: "Xác nhận",
                                             cancelTitle: "Cancel",
                                             inputPlaceholder: "mã OTP",
                                             inputKeyboardType: UIKeyboardType.default, actionHandler:
                                                { (input:String?) in
                                                    print("The pass input is \(input ?? "")")
                                                    // call api
                                                    //self.checkAPIPassCode(pass: input!)
                                                    if(input == ""){
                                                        self.showDialog(message: "Vui lòng nhập mã otp!")
                                                        return
                                                    }
                                                    self.actionSendOTP(otp: input!,token: results.Token)
                                                })
                         self.showDialog(message: results.Status)
            
                    
                }else{
                 
                    self.showDialog(message: err)
                }
            }
        }
    }
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
            textField.isSecureTextEntry = false
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
    @objc func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
}
extension GiaHanSSDViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // chu ky lib
    @objc func tapShowSign(sender:UITapGestureRecognizer) {
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
//        let nav = UINavigationController(rootViewController: signatureVC)
//        present(nav, animated: true, completion: nil)
         self.navigationController?.pushViewController(signatureVC, animated: true)
    }
    func epSignature(_: EPSignatureViewController, didCancel error : NSError) {
        print("User canceled")
        _ = self.navigationController?.popViewController(animated: true)
              self.dismiss(animated: true, completion: nil)
    }
    
    func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect) {
        print(signatureImage)
        print(boundingRect)
        
        let width = viewImageSign.frame.size.width - Common.Size(s:10)
        
        let sca:CGFloat = boundingRect.size.width / boundingRect.size.height
        let heightImage:CGFloat = width / sca
        
        viewImageSign.subviews.forEach { $0.removeFromSuperview() }
        imgViewSignature  = UIImageView(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:5), width: width, height: heightImage))
        //        imgViewSignature.backgroundColor = .red
        imgViewSignature.contentMode = .scaleAspectFit
        viewImageSign.addSubview(imgViewSignature)
        imgViewSignature.image = cropImage(image: signatureImage, toRect: boundingRect)
        
        viewImageSign.frame.size.height = imgViewSignature.frame.size.height + imgViewSignature.frame.origin.y + Common.Size(s:5)
        viewSign.frame.size.height = viewImageSign.frame.origin.y + viewImageSign.frame.size.height
        
        
        btSendOTP.frame.origin.y = viewSign.frame.size.height + viewSign.frame.origin.y + Common.Size(s:20)
        btDangKy.frame.origin.y = btSendOTP.frame.size.height + btSendOTP.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btDangKy.frame.origin.y + btDangKy.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        _ = self.navigationController?.popViewController(animated: true)
              self.dismiss(animated: true, completion: nil)
    }
    
    
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }

    override func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage? {
        
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    func resizeImageWidth(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    //cut cut a a
}
