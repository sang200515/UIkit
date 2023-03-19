//
//  LoginViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/25/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
import PopupDialog
import Toaster

class LoginViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
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
        
        tfPassword = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:20), y: height/3, width: UIScreen.main.bounds.size.width - width * 2/10 - 10, height: Common.Size(s:40)), iconType: .image)
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
        let defaults = UserDefaults.standard
        if let Username = defaults.string(forKey: "Username_Login") {
            tfUserName.text = "\(Username)"
        }
        
        tfCode = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:20), y: tfPassword.frame.origin.y + tfPassword.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - width * 3/10 - Common.Size(s:10) , height: Common.Size(s:40)), iconType: .image)
        tfCode.placeholder = "Mã OTP"
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
        
        
        
        
        loading = LoadingWhiteView()
        loading.frame = CGRect(x: self.view.frame.size.width/2 - 45/2, y: height * 5/6 ,width: 45, height: 45)
        self.view.addSubview(loading)
        loading.isHidden = true
        loading.removeFromSuperview()
        self.hideKeyboardWhenTappedAround()
        
        
        
    }
    
    @objc func actionLogin() {
        let username = tfUserName.text!
        let password = tfPassword.text!
        let code = tfCode.text!
        if(!username.isEmpty && !password.isEmpty && !code.isEmpty){
            let height = UIScreen.main.bounds.size.height
            btLogin.isUserInteractionEnabled = false
            tfUserName.isUserInteractionEnabled = false
            tfPassword.isUserInteractionEnabled = false
            tfCode.isUserInteractionEnabled = false
            
            loading.frame = CGRect(x: self.view.frame.size.width/2 - 45/2, y: height * 5/6 ,width: 45, height: 45)
            self.view.addSubview(loading)
            
            self.loading.isHidden = false
            
            APIManager.getTokenAD(username:username,password:password,otp:code, completion: { (token, errGetTokenAD) in
                if(errGetTokenAD.count <= 0){
                    print(token)
                    self.btLogin.isUserInteractionEnabled = true
                    self.tfUserName.isUserInteractionEnabled = true
                    self.tfPassword.isUserInteractionEnabled = true
                    self.tfCode.isUserInteractionEnabled = true
                    APIManager.userinfo(handler: { (resultsUserInfo, errUserInfo) in
                        if(errUserInfo.count <= 0){
                            APIManager.mpos_sp_GateWay_GetInfoLogin(UserName: resultsUserInfo?.employee_code ?? "", handler: { (resultUser, errMpos_sp_GateWay_GetInfoLogin) in
                                if(resultUser != nil){
                                    //
                                    UserDefaults.standard.setUsernameEmployee(username: "\(resultUser?.UserName ?? "")")
                                    Cache.user = resultUser
                                    let defaults = UserDefaults.standard
                                    defaults.removeListUpdateModule()
                                    defaults.removeIsUpdateVersionRoot()
                                    defaults.removeGetUpdateDescription()
                                    let versionApp = Common.myCustomVersionApp() ?? ""
                                    guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
                                    let params: [String : Any] = [
                                        "Devicetype":2,
                                        "Version":versionApp,
                                        "Usercode": userCode
                                    ]
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        NewCheckVersionAPIManager.shared.newCheckVersion(params) {[weak self] (result, error) in
                                            guard let strongSelf = self else {return}
                                            
                                            if let item = result {
                                                guard let gateWay = item.isGateway else {return}
                                                Cache.is_getaway = 1//gateWay
                                                if item.version != versionApp {
                                                    guard let description = item.descriptions else {return}
                                                    UserDefaults.standard.setUpdateDescription(description)
                                                    if item.isUpdateApp == 1 {
                                                        UserDefaults.standard.setUpdateDescription(description)
                                                        UserDefaults.standard.setIsUpdateVersionRoot(isUpdate: true)
                                                        strongSelf.showPopUpCustom(title: "Thông báo", titleButtonOk: "Cập nhật", titleButtonCancel: nil, message: description, actionButtonOk: {
                                                            guard let url = URL(string: "\(Config.manager.URL_UPDATE!)") else {
                                                                return
                                                            }
                                                            if #available(iOS 10.0, *) {
                                                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                                            } else {
                                                                UIApplication.shared.openURL(url)
                                                            }
                                                        }, actionButtonCancel: nil, isHideButtonOk: false, isHideButtonCancel: true)
                                                        return
                                                    }
                                                    
                                                    if item.isUpdateApp == 0 {
                                                        UserDefaults.standard.setIsUpdateVersionRoot(isUpdate: false)
                                                        if let listModule = item.listModule {
                                                            UserDefaults.standard.setListUpdateApp(list: listModule)
                                                            guard let description = item.descriptions else {return}
                                                            strongSelf.showPopUpCustom(title: "Thông báo", titleButtonOk: "Chấp nhận", titleButtonCancel: "Huỷ", message: description, actionButtonOk: {
                                                                guard let url = URL(string: "\(Config.manager.URL_UPDATE!)") else {
                                                                    return
                                                                }
                                                                if #available(iOS 10.0, *) {
                                                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                                                } else {
                                                                    UIApplication.shared.openURL(url)
                                                                }
                                                            }, actionButtonCancel: {
                                                                APIManager.sp_mpos_FRT_SP_oneapp_CheckMenu(UserName:resultUser!.UserName,handler: { (results, errCheckMenu) in
                                                                    if(errCheckMenu.count <= 0){
                                                                        if(results.count > 0){
                                                                            Cache.ruleMenus = results
                                                                            if(resultUser!.multi_shop == 1){
                                                                                let newViewController = ChooseShopLoginViewController()
                                                                                newViewController.user = resultUser
                                                                                newViewController.password = password
                                                                                newViewController.codeCRM = code
                                                                                newViewController.is_getaway = Cache.is_getaway
                                                                                strongSelf.present(newViewController, animated: true, completion: nil)
                                                                            }else{
                                                                                let defaults = UserDefaults.standard
                                                                                defaults.set(resultUser!.UserName, forKey: "Username")
                                                                                defaults.set(username, forKey: "Username_Login")
                                                                                defaults.set(password, forKey: "password")
                                                                                defaults.set("654321", forKey: "CRMCode")
                                                                                defaults.set(Cache.is_getaway, forKey: "is_getaway")
                                                                                defaults.synchronize()
                                                                                //
                                                                                APIManager.registerDeviceToken()
                                                                                strongSelf.loading.isHidden = true
                                                                                // strongSelf.goToMain()
                                                                                self?.getListShiftChamCong()
                                                                            }
                                                                        }else{
                                                                            strongSelf.loading.isHidden = true
                                                                            let alert = UIAlertController(title: "Chú ý", message: error, preferredStyle: .alert)
                                                                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                                                                                
                                                                            })
                                                                            strongSelf.present(alert, animated: true)
                                                                        }
                                                                    }else{
                                                                        strongSelf.loading.isHidden = true
                                                                        let popup = PopupDialog(title: "Thông báo", message: errCheckMenu, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                                            print("Completed")
                                                                        }
                                                                        let buttonOne = CancelButton(title: "Đồng ý") {
                                                                        }
                                                                        popup.addButtons([buttonOne])
                                                                        strongSelf.present(popup, animated: true, completion: nil)
                                                                    }
                                                                })
                                                                return
                                                            }, isHideButtonOk: false, isHideButtonCancel: false)
                                                        } else {
                                                            let popup = PopupDialog(title: "Thông báo", message: "Không có danh sách module cập nhật nào", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                                print("Completed")
                                                            }
                                                            let buttonOne = DefaultButton(title: "ok", action: nil)
                                                            popup.addButtons([buttonOne])
                                                            strongSelf.present(popup, animated: true, completion: nil)
                                                            return
                                                        }
                                                    }
                                                } else {
                                                    APIManager.sp_mpos_FRT_SP_oneapp_CheckMenu(UserName:resultUser!.UserName,handler: { (results, errCheckMenu) in
                                                        if(errCheckMenu.count <= 0){
                                                            if(results.count > 0){
                                                                Cache.ruleMenus = results
                                                                if(resultUser!.multi_shop == 1){
                                                                    let newViewController = ChooseShopLoginViewController()
                                                                    newViewController.user = resultUser
                                                                    newViewController.password = password
                                                                    newViewController.codeCRM = code
                                                                    newViewController.is_getaway = Cache.is_getaway
                                                                    strongSelf.present(newViewController, animated: true, completion: nil)
                                                                }else{
                                                                    let defaults = UserDefaults.standard
                                                                    defaults.set(resultUser!.UserName, forKey: "Username")
                                                                    defaults.set(username, forKey: "Username_Login")
                                                                    defaults.set(password, forKey: "password")
                                                                    defaults.set("654321", forKey: "CRMCode")
                                                                    defaults.set(Cache.is_getaway, forKey: "is_getaway")
                                                                    defaults.synchronize()
                                                                    //
                                                                    APIManager.registerDeviceToken()
                                                                    strongSelf.loading.isHidden = true
                                                                    //                                                                    strongSelf.goToMain()
                                                                    self?.getListShiftChamCong()
                                                                    //
                                                                }
                                                                
                                                                
                                                                
                                                            }else{
                                                                strongSelf.loading.isHidden = true
                                                                let alert = UIAlertController(title: "Chú ý", message: error, preferredStyle: .alert)
                                                                alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                                                                    
                                                                })
                                                                strongSelf.present(alert, animated: true)
                                                            }
                                                        }else{
                                                            strongSelf.loading.isHidden = true
                                                            let popup = PopupDialog(title: "Thông báo", message: errCheckMenu, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                                print("Completed")
                                                            }
                                                            let buttonOne = CancelButton(title: "Đồng ý") {
                                                            }
                                                            popup.addButtons([buttonOne])
                                                            strongSelf.present(popup, animated: true, completion: nil)
                                                        }
                                                    })
                                                }
                                            }
                                        }
                                    }
                                    //
                                    //                                    Cache.user = resultUser
                                    //                                    APIManager.registerDeviceToken()
                                    //                                    self.loading.isHidden = true
                                    //                                    self.goToMain()
                                    
                                }else{
                                    self.loading.isHidden = true
                                    let popup = PopupDialog(title: "Thông báo", message: errMpos_sp_GateWay_GetInfoLogin, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        print("Completed")
                                    }
                                    let buttonOne = CancelButton(title: "Đồng ý") {
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                }
                            })
                        }else{
                            self.enableInput()
                            self.showPopUp(errUserInfo, "Thông báo", buttonTitle: "OK")
                        }
                        
                    })
                    
                    
                    
                }else{
                    self.enableInput()
                    self.showPopUp(errGetTokenAD, "Thông báo", buttonTitle: "OK")
                }
                
                
                
            })
        }else{
            let alert = UIAlertController(title: "Chú ý", message: "Bạn phải nhập mã inside, mật khẩu và mã CRM.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
        }
    }
    func goToMain(){
        let mainViewController = MainViewController()
        UIApplication.shared.keyWindow?.rootViewController = mainViewController
    }
    func enableInput(){
        self.loading.isHidden = true
        self.btLogin.isUserInteractionEnabled = true
        self.tfUserName.isUserInteractionEnabled = true
        self.tfPassword.isUserInteractionEnabled = true
        self.tfCode.isUserInteractionEnabled = true
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
