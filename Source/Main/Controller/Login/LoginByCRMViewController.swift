//
//  LoginByCRMViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 5/23/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
import PopupDialog
import Toaster
class LoginByCRMViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    var window: UIWindow?
    var scrollView:UIScrollView!
    var tfPassword, tfUserName, tfCode:SkyFloatingLabelTextFieldWithIcon!
    var yLogo:CGFloat = 0
    var logo : UIImageView!
    
    var spinner = UIActivityIndicatorView()
    var btLogin:UIButton!
    
    var loading:LoadingWhiteView!
    private var btnShowHide:UIImageView!
    private var isShowPassword = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let bg = UIImageView(frame: CGRect(x:0,y:0 ,width:width,height: height))
        bg.image = UIImage(named: "bg")
        bg.contentMode = .scaleAspectFill
        self.scrollView.addSubview(bg)
        
        let logo = UIImageView(frame: CGRect(x:width/16,y: height/8 - (width / 2.2 / 3.77)/2 ,width:width / 2.2,height: width / 2.2 / 3.77 ))
        logo.image = UIImage(named: "fptshop")
        logo.contentMode = .scaleAspectFit
        self.scrollView.addSubview(logo)
        
        let lbCopyright = UILabel(frame: CGRect(x: 0, y: height - Common.Size(s:40), width: width, height: Common.Size(s:40)))
        lbCopyright.textAlignment = .center
        lbCopyright.textColor = UIColor.white
        lbCopyright.font = UIFont.systemFont(ofSize: Common.Size(s: 11))
        lbCopyright.text = "Copyright © 2017 FPT Retail J.S.C\r\nVersion \(Common.versionApp())"
        lbCopyright.numberOfLines = 3
        self.scrollView.addSubview(lbCopyright)
        
        btLogin = UIButton(frame: CGRect(x: width/6, y: height/2 + width * 1.5/10, width: width - width * 2/6, height: Common.Size(s: 45)))
        btLogin.layer.cornerRadius = 20
        btLogin.setTitle("Đăng nhập",for: .normal)
        btLogin.titleLabel?.font = UIFont.systemFont(ofSize: Common.Size(s: 16))
        btLogin.layer.shadowColor = UIColor.black.cgColor
        btLogin.layer.shadowOffset = CGSize(width: 3, height: 3)
        btLogin.layer.shadowOpacity = 0.5
        btLogin.layer.shadowRadius = 1.0
        btLogin.backgroundGradient()
        scrollView.addSubview(btLogin)
        btLogin.addTarget(self, action:#selector(self.actionLogin), for: .touchUpInside)
        
        tfPassword = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:20), y: height/3, width: UIScreen.main.bounds.size.width - width * 2/10 - 10 , height: Common.Size(s:40)), iconType: .image)
        tfPassword.placeholder = "Mật khẩu"
        tfPassword.title = "Mật khẩu"
        tfPassword.iconImage = UIImage(named: "password")
        tfPassword.tintColor = UIColor(netHex:0x069C90)
        //        tfPassword.textColor = UIColor(netHex:0x069C90)
        tfPassword.lineColor = UIColor(netHex:0x069C90)
        tfPassword.selectedTitleColor = UIColor(netHex:0x069C90)
        tfPassword.selectedLineColor = UIColor(netHex:0x069C90)
        tfPassword.lineHeight = 1.0
        tfPassword.selectedLineHeight = 1.0
        tfPassword.isSecureTextEntry = true
        tfPassword.clearButtonMode = .whileEditing
        scrollView.addSubview(tfPassword)
        
        
        btnShowHide = UIImageView(frame:CGRect(x: tfPassword.frame.size.width + tfPassword.frame.origin.x + 10, y:  tfPassword.frame.origin.y, width: Common.Size(s:25), height: tfPassword.frame.size.height));
        btnShowHide.image = UIImage(named: "password-viewhide")
        btnShowHide.contentMode = .scaleAspectFit
        scrollView.addSubview(btnShowHide)
        
        let tapScan = UITapGestureRecognizer(target: self, action: #selector(handleShowHide))
        btnShowHide.isUserInteractionEnabled = true
        btnShowHide.addGestureRecognizer(tapScan)
        
        tfUserName = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:20), y: tfPassword.frame.origin.y - tfPassword.frame.size.height - Common.Size(s:10), width: UIScreen.main.bounds.size.width - width * 2/10 , height: Common.Size(s:40)), iconType: .image)
        tfUserName.placeholder = "Mã Inside/Email"
        tfUserName.title = "Mã Inside/Email"
        tfUserName.iconImage = UIImage(named: "username")
        tfUserName.tintColor = UIColor(netHex:0x069C90)
        //        tfUserName.textColor = UIColor(netHex:0x069C90)
        tfUserName.lineColor = UIColor(netHex:0x069C90)
        tfUserName.selectedTitleColor = UIColor(netHex:0x069C90)
        tfUserName.selectedLineColor = UIColor(netHex:0x069C90)
        tfUserName.lineHeight = 1.0
        tfUserName.selectedLineHeight = 1.0
        tfUserName.clearButtonMode = .whileEditing
        tfUserName.keyboardType = .default
        scrollView.addSubview(tfUserName)
        
        tfCode = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:20), y: tfPassword.frame.origin.y + tfPassword.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - width * 3/10 - Common.Size(s:10) , height: Common.Size(s:40)), iconType: .image)
        tfCode.placeholder = "Mã OTP(Beta)"
        tfCode.title = "Mã OTP"
        tfCode.iconImage = UIImage(named: "code")
        tfCode.tintColor = UIColor(netHex:0x069C90)
        //        tfUserName.textColor = UIColor(netHex:0x069C90)
        tfCode.lineColor = UIColor(netHex:0x069C90)
        tfCode.selectedTitleColor = UIColor(netHex:0x069C90)
        tfCode.selectedLineColor = UIColor(netHex:0x069C90)
        tfCode.lineHeight = 1.0
        tfCode.selectedLineHeight = 1.0
        tfCode.clearButtonMode = .whileEditing
        tfCode.keyboardType = .numberPad
        scrollView.addSubview(tfCode)
        
        let defaults = UserDefaults.standard
        if let Username = defaults.string(forKey: "Username_Login") {
            tfUserName.text = "\(Username)"
        }
        
        let  lbInfoCRMCode = UILabel(frame: CGRect(x: tfCode.frame.origin.x, y: tfCode.frame.size.height + tfCode.frame.origin.y + Common.Size(s: 20), width:tfCode.frame.size.width, height: 0))
        lbInfoCRMCode.textAlignment = .left
        lbInfoCRMCode.textColor = UIColor(netHex:0x04AB6E)
        lbInfoCRMCode.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Lấy mã CRM", attributes: underlineAttribute)
        lbInfoCRMCode.attributedText = underlineAttributedString
        scrollView.addSubview(lbInfoCRMCode)
        let tapShowDetailCustomer = UITapGestureRecognizer(target: self, action: #selector(LoginByCRMViewController.getCRMCode))
        lbInfoCRMCode.isUserInteractionEnabled = false
        lbInfoCRMCode.addGestureRecognizer(tapShowDetailCustomer)
        
        
        loading = LoadingWhiteView()
        loading.frame = CGRect(x: self.view.frame.size.width/2 - 45/2, y: height * 5/6 ,width: 45, height: 45)
        self.view.addSubview(loading)
        loading.isHidden = true
        
        self.hideKeyboardWhenTappedAround()
    }
    @objc func getCRMCode(sender:UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Lấy mã CRM", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Mã inside"
            let heightConstraint = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Common.Size(s: 25))
            textField.addConstraint(heightConstraint)
            textField.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
            textField.keyboardType = .numberPad
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Password"
            let heightConstraint = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Common.Size(s: 25))
            textField.addConstraint(heightConstraint)
            textField.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
            textField.isSecureTextEntry = true
        }
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: { (_) in
            
        }))
        alert.addAction(UIAlertAction(title: "Xác nhận", style: .default, handler: { [weak alert] (_) in
            if let username = alert?.textFields![0].text  {
                if let password = alert?.textFields![1].text {
                    if(username != "" && password != ""){
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            let newViewController = LoadingViewController()
                            newViewController.content = "Đang kiểm tra thông tin..."
                            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                            self.present(newViewController, animated: true, completion: nil)
                            let nc = NotificationCenter.default
                            
                            MPOSAPIManager.sp_mpos_GetCRMCode_ByMail(UserID: username, Password: password, handler: { (result, err) in
                                let when = DispatchTime.now() + 0.5
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    if(result.count > 0){
                                        let alert2 = UIAlertController(title: "Thông báo", message: result, preferredStyle: .alert)
                                        alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                            
                                        }))
                                        self.present(alert2, animated: true, completion: nil)
                                    }else{
                                        let alert2 = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                                        alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                            
                                        }))
                                        self.present(alert2, animated: true, completion: nil)
                                    }
                                }
                            })
                        }
                    }else{
                        Toast.init(text: "Bạn phải nhập đủ thông tin.").show()
                    }
                }else{
                    Toast.init(text: "Bạn phải nhập đủ thông tin.").show()
                }
            }else{
                Toast.init(text: "Bạn phải nhập đủ thông tin.").show()
            }
        }))
        
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func actionLogin() {
        let username = tfUserName.text!
        let password = tfPassword.text!
        let code = tfCode.text!
        //MARK: - new Login AD
        /**
         # https://identity.fptshop.com.vn/connect/token
         
         - get bear token
         
         ## https://identity-beta.fptshop.com.vn/connect/userinfo
         
         - Header use bear token
         - Use only inside_id and email .[0] inside_id [1] email
         ## Call API Login
         
         */
        if(!username.isEmpty && !password.isEmpty && !code.isEmpty){
            btLogin.isUserInteractionEnabled = false
            tfUserName.isUserInteractionEnabled = false
            tfPassword.isUserInteractionEnabled = false
            tfCode.isUserInteractionEnabled = false
            self.loading.isHidden = false
            APIManager.getTokenAD(username:username,password:password,otp:code, completion: {[weak self] (token, err) in
                guard let strongSelf = self else {return}
                if(err.count <= 0){
                    print(token)
                    
                    APIManager.userinfo(handler: { (resultsUserInfo, err) in
                        if(err.count <= 0){
                            
                            APIManager.login(UserName:resultsUserInfo?.employee_code ?? "",Password:password,CRMCode:code,SysType:"0") { (result, err1) in
                                
                                if(result != nil){
                                    UserDefaults.standard.setUsernameEmployee(username: result!.UserName)
                                    //CHECK RULE MENU
                                    APIManager.sp_mpos_FRT_SP_oneapp_CheckMenu(UserName:result!.UserName,handler: { (results, err) in
                                        strongSelf.hideLoading()
                                        if(err.count <= 0){
                                            if(results.count > 0){
                                                Cache.ruleMenus = results
                                                if(result!.multi_shop == 1){
                                                    let newViewController = ChooseShopLoginViewController()
                                                    newViewController.user = result
                                                    newViewController.password = password
                                                    newViewController.codeCRM = code
                                                    newViewController.is_getaway = 0
                                                    strongSelf.present(newViewController, animated: true, completion: nil)
                                                } else {
                                                    let defaults = UserDefaults.standard
                                                    defaults.set(result!.UserName, forKey: "Username")
                                                    defaults.set(result!.UserName, forKey: "Username_Login")
                                                    defaults.set(password, forKey: "password")
                                                    defaults.set(code, forKey: "CRMCode")
                                                    defaults.set(Cache.is_getaway, forKey: "is_getaway")
                                                    defaults.synchronize()
                                                    Cache.user = result
                                                    APIManager.registerDeviceToken()
                                                    self?.getListShiftChamCong()
//                                                    strongSelf.goToMain()
                                                    
                                                }
                                            }else{
                                                let popup = PopupDialog(title: "Thông báo", message: "Bạn không được cấp quyền sử dụng ứng dụng.\r\nVui lòng kiểm tra lại.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                    print("Completed")
                                                }
                                                let buttonOne = CancelButton(title: "Thử lại") {
                                                    strongSelf.actionLogin()
                                                }
                                                popup.addButtons([buttonOne])
                                                strongSelf.present(popup, animated: true, completion: nil)
                                            }
                                        }else{
                                            let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                print("Completed")
                                            }
                                            let buttonOne = CancelButton(title: "Thử lại") {
                                                strongSelf.actionLogin()
                                            }
                                            popup.addButtons([buttonOne])
                                            strongSelf.present(popup, animated: true, completion: nil)
                                        }
                                    })
                                }else{
                                    strongSelf.hideLoading()
                                    let alert = UIAlertController(title: "Chú ý", message: err1, preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                                        
                                    })
                                    strongSelf.present(alert, animated: true)
                                }
                            }
                            
                            
                        }else{
                            strongSelf.hideLoading()
                            Toast.init(text: err).show()
                        }
                    })
                    
                    
                }else{
                    strongSelf.hideLoading()
                    Toast.init(text: err).show()
                }
            })
            
            
            
        }else{
            let alert = UIAlertController(title: "Chú ý", message: "Bạn phải nhập mã inside, mật khẩu và mã CRM.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
        }
    }
    func hideLoading(){
        self.btLogin.isUserInteractionEnabled = true
        self.tfUserName.isUserInteractionEnabled = true
        self.tfPassword.isUserInteractionEnabled = true
        self.tfCode.isUserInteractionEnabled = true
        self.loading.isHidden = true
    }
    
    func goToMain(){
        let mainViewController = MainViewController()
//        let nc = NotificationCenter.default
//        nc.post(name: Notification.Name("showVerifyVersion"), object: nil)
        //        let mainView = UINavigationController(rootViewController: mainViewController)
        UIApplication.shared.keyWindow?.rootViewController = mainViewController
    }
    
    @objc func handleShowHide(){
        if isShowPassword {
            isShowPassword = false
            tfPassword.isSecureTextEntry = false
            btnShowHide.image = UIImage(named: "password-viewshow")
        }else{
            isShowPassword = true
            tfPassword.isSecureTextEntry = true
            btnShowHide.image = UIImage(named: "password-viewhide")
        }
    }
    
    func getListShiftChamCong() {
        CRMAPIManager.GetListShiftDateByEmployee { (rs, err) in
            if err.count <= 0 {
                if rs.count > 0 {
                    Cache.arrShiftChamCong = rs
                } else {
                    Cache.arrShiftChamCong = []
                    debugPrint("user khong co danh sách ca làm")
                }
            } else {
                Cache.arrShiftChamCong = []
            }
            self.goToMain()
        }
    }
}

