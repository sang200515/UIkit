//
//  UserInfoViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/20/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//


import Foundation
import UIKit
import PopupDialog
import Kingfisher
class UserInfoViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    var btLogin:UIButton!
    var scrollView: UIScrollView!
    var infoView: UIView!
    var versionView: UIView!
    var userNameLbl: UILabel!
    var userAddressLbl: UILabel!
    var scrollViewHeight:CGFloat = 0
    
    var companyView: UIView!
    var incView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Thông tin nhân viên"
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(UserInfoViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let footer = UIView(frame: CGRect(x: 0, y: height - Common.Size(s: 60) - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height), width: width, height: Common.Size(s: 60)))
        self.view.addSubview(footer)
        
        let btPay = UIButton()
        btPay.frame = CGRect(x: Common.Size(s: 20), y: Common.Size(s: 10), width: footer.frame.size.width - Common.Size(s: 40), height: Common.Size(s: 40))
        btPay.backgroundColor = UIColor(netHex:0xD0021B)
        btPay.setTitle("ĐĂNG XUẤT", for: .normal)
        btPay.addTarget(self, action: #selector(actionCheckKMVC), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        footer.addSubview(btPay)
        
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - Common.Size(s: 60) - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height - Common.Size(s: 60) - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        infoView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width))
        infoView.backgroundColor = UIColor.white
        scrollView.addSubview(infoView)
        
        let imageAvatar = UIImageView(frame: CGRect(x: width/2 - ( width/4)/2, y: Common.Size(s: 20), width: width/4, height: width/4))
        imageAvatar.image = UIImage(named: "avatar")
        imageAvatar.layer.borderWidth = 1
        imageAvatar.layer.masksToBounds = false
        imageAvatar.layer.borderColor = UIColor.white.cgColor
        imageAvatar.layer.cornerRadius = imageAvatar.frame.height/2
        imageAvatar.clipsToBounds = true
        infoView.addSubview(imageAvatar)
        imageAvatar.contentMode = .scaleAspectFill
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        let url_avatar = "\(Cache.user!.AvatarImageLink)".replacingOccurrences(of: "~", with: "")
        if(url_avatar != ""){
            if let escapedString = "https://inside.fptshop.com.vn/\(url_avatar)".addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                print(escapedString)
                let url = URL(string: "\(escapedString)")!
                imageAvatar.kf.setImage(with: url,
                                        placeholder: nil,
                                        options: [.transition(.fade(1))],
                                        progressBlock: nil,
                                        completionHandler: nil)
            }
        }
        
        
        userNameLbl = UILabel(frame: CGRect(x: 0, y: imageAvatar.frame.size.height + imageAvatar.frame.origin.y + Common.Size(s: 15), width: infoView.frame.width, height: Common.Size(s: 18)))
        userNameLbl.text = "\(Cache.user!.UserName) - \(Cache.user!.EmployeeName)"
        userNameLbl.textAlignment = .center
        userNameLbl.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        infoView.addSubview(userNameLbl)
        
        userAddressLbl = UILabel(frame: CGRect(x: 0, y: userNameLbl.frame.size.height + userNameLbl.frame.origin.y + Common.Size(s: 5), width: infoView.frame.width, height: Common.Size(s: 16)))
        userAddressLbl.text = "\(Cache.user!.ShopName)"
        userAddressLbl.textAlignment = .center
        userAddressLbl.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        infoView.addSubview(userAddressLbl)
        
        infoView.frame.size.height = userAddressLbl.frame.size.height + userAddressLbl.frame.origin.y + Common.Size(s: 15)
        
        companyView = UIView(frame: CGRect(x: 0, y: infoView.frame.size.height + infoView.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width, height: Common.Size(s: 90)))
        companyView.backgroundColor = UIColor.white
        scrollView.addSubview(companyView)
        
        let centerLine = UIView(frame: CGRect(x: Common.Size(s: 20), y: companyView.frame.size.height/2 - 0.5, width: companyView.frame.width - Common.Size(s: 20), height: 1))
        centerLine.backgroundColor = UIColor(netHex: 0xEEEEEE)
        companyView.addSubview(centerLine)
        
        let companyLbl = UILabel(frame: CGRect(x: Common.Size(s: 10), y: 0, width: companyView.frame.width/3 - Common.Size(s: 10), height: centerLine.frame.origin.y))
        companyLbl.text = "Công ty"
        companyLbl.textAlignment = .left
        companyLbl.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        companyView.addSubview(companyLbl)
        
        let companyNameLbl = UILabel(frame: CGRect(x: companyLbl.frame.width + companyLbl.frame.origin.x, y: 0, width: companyView.frame.width * 2/3 - Common.Size(s: 10), height: companyLbl.frame.height))
        companyNameLbl.text = "\(Cache.user!.CompanyName)"
        companyNameLbl.numberOfLines = 2
        companyNameLbl.textAlignment = .right
        companyNameLbl.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        companyView.addSubview(companyNameLbl)
        
        let addressLbl = UILabel(frame: CGRect(x: companyLbl.frame.origin.x, y: centerLine.frame.size.height + centerLine.frame.origin.y, width: companyLbl.frame.width, height: companyLbl.frame.height))
        addressLbl.text = "Địa chỉ"
        addressLbl.textAlignment = .left
        addressLbl.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        companyView.addSubview(addressLbl)
        
        let addressValueLbl = UILabel(frame: CGRect(x: companyNameLbl.frame.origin.x, y: addressLbl.frame.origin.y, width: companyNameLbl.frame.width, height: companyNameLbl.frame.height))
        addressValueLbl.text = "\(Cache.user!.Address)"
        addressValueLbl.numberOfLines = 2
        addressValueLbl.textAlignment = .right
        addressValueLbl.font = UIFont.boldSystemFont(ofSize: 13)
        companyView.addSubview(addressValueLbl)
        
        incView = UIView(frame: CGRect(x: 0, y: companyView.frame.size.height + companyView.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width, height: companyView.frame.height / 2))
        incView.backgroundColor = UIColor.white
        scrollView.addSubview(incView)
        
        let incLbl = UILabel(frame: CGRect(x: companyLbl.frame.origin.x, y: 0, width: incView.frame.width/2 - Common.Size(s: 10), height: incView.frame.height))
        incLbl.text = "INC"
        incLbl.textAlignment = .left
        incLbl.font = UIFont.systemFont(ofSize: 13)
        incView.addSubview(incLbl)
        
        let incValueLbl = UILabel(frame: CGRect(x: incLbl.frame.width + incLbl.frame.origin.x, y: 0, width: incView.frame.width/2 - Common.Size(s: 10), height: incView.frame.height))
        incValueLbl.numberOfLines = 2
        incValueLbl.textAlignment = .right
        incValueLbl.textColor = .red
        incValueLbl.font = UIFont.boldSystemFont(ofSize: 16)
        incView.addSubview(incValueLbl)
        let cash = Cache.user!.CashAccount.floatValue()
        if( cash != nil){
            incValueLbl.text = "\(Common.convertCurrencyFloat(value: cash!))"
        }else{
            incValueLbl.text = "0đ"
        }
        //--- version view
        versionView = UIView(frame: CGRect(x: 0, y: incView.frame.size.height + incView.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width, height: incView.frame.height))
        versionView.backgroundColor = UIColor.white
        scrollView.addSubview(versionView)
        
        let versionLbl = UILabel(frame: CGRect(x: incLbl.frame.origin.x, y: 0, width: versionView.frame.width/2 - Common.Size(s: 10), height: versionView.frame.height))
        versionLbl.text = "Version"
        versionLbl.textAlignment = .left
        versionLbl.font = UIFont.systemFont(ofSize: 13)
        versionView.addSubview(versionLbl)
        
        let versionValueLbl = UILabel(frame: CGRect(x: versionLbl.frame.width + versionLbl.frame.origin.x, y: 0, width: versionView.frame.width/2 - Common.Size(s: 10), height: versionView.frame.height))
        versionValueLbl.numberOfLines = 2
        versionValueLbl.textAlignment = .right
        versionValueLbl.textColor = .black
        versionValueLbl.font = UIFont.boldSystemFont(ofSize: 16)
        versionValueLbl.text = Common.versionApp()
        versionView.addSubview(versionValueLbl)
        
        let tapVersionView = UITapGestureRecognizer(target: self, action: #selector(self.tapToInstallApp))
        //        tapversionView.isUserInteractionEnabled = true
        tapVersionView.numberOfTapsRequired = 1
        versionView.addGestureRecognizer(tapVersionView)
        
        //--- version view
        let otpView = UIView(frame: CGRect(x: 0, y: versionView.frame.size.height + versionView.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width, height: Common.Size(s: 50)))
        otpView.backgroundColor = UIColor.white
        scrollView.addSubview(otpView)
        
        let btOTP = UIButton()
        btOTP.frame = CGRect(x: Common.Size(s: 20), y: Common.Size(s: 5), width: otpView.frame.size.width - Common.Size(s: 40), height: otpView.frame.size.height - Common.Size(s: 10))
        btOTP.backgroundColor = UIColor(netHex:0x00955E)
        btOTP.setTitle("Lấy mã xác thực", for: .normal)
        btOTP.addTarget(self, action: #selector(actionOTP), for: .touchUpInside)
        btOTP.layer.borderWidth = 0.5
        btOTP.layer.borderColor = UIColor.white.cgColor
        btOTP.layer.cornerRadius = 5.0
        otpView.addSubview(btOTP)
        
    }
    @objc func actionOTP(sender: UIButton!){
        let vc = GetOTPViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapToInstallApp() {
        guard let url = URL(string: "\(Config.manager.URL_UPDATE!)") else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc func actionCheckKMVC(sender: UIButton!){
        let popup = PopupDialog(title: "ĐĂNG XUẤT", message: "Bạn muốn đăng xuất tài khoản ra khỏi ứng dụng?", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            print("Completed")
        }
        let buttonOne = CancelButton(title: "Huỷ bỏ") {
            
        }
        let buttonTwo = DefaultButton(title: "Đăng xuất") {
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "Username")
            defaults.removeObject(forKey: "Password")
            defaults.removeObject(forKey: "mDate")
            defaults.removeObject(forKey: "mCardNumber")
            defaults.removeObject(forKey: "typePhone")
            defaults.removeObject(forKey: "mPrice")
            defaults.removeObject(forKey: "mPriceCardDisplay")
            defaults.removeObject(forKey: "CRMCode")
            defaults.synchronize()
            APIManager.removeDeviceToken()
            let mainViewController = LoginViewController()
            UIApplication.shared.keyWindow?.rootViewController = mainViewController
        }
        popup.addButtons([buttonOne, buttonTwo])
        present(popup, animated: true, completion: nil)
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
