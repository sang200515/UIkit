//
//  BaseController.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/15/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseController: UIViewController {
    var progressLoading = NVActivityIndicatorView(frame: .zero, type: .ballClipRotateMultiple, color: Constants.COLORS.main_orange_my_info, padding: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = Constants.COLORS.bold_green
        self.navigationController?.navigationBar.isTranslucent = false
        
        setupViews()
        getData()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(listenerNoHaveWifi(_:)), name: Notification.Name("noHaveNetwork"), object: nil)
        nc.addObserver(self, selector: #selector(listenerHaveConnectedWifiOrWWAN(_:)), name: Notification.Name("connectEthernetOrWifi"), object: nil)
        nc.addObserver(self, selector: #selector(listenerHaveConnectedWifiOrWWAN(_:)), name: Notification.Name("connectWWAN"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    func showPopup(with error: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: "Thông Báo", message: error, preferredStyle: .alert)
        let okaction = UIAlertAction(title: "OK", style: .default) { (action) in
            if let back = completion {
                back()
            }
        }
        alert.addAction(okaction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func dismissOrPop() {
        if self.navigationController?.topViewController == self {
            self.navigationController?.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func showLoading() {
        let frameLoading = CGRect(x: self.view.frame.size.width/2 - 15, y: self.view.frame.size.height/2 - 15, width: 50, height: 50)
        self.progressLoading.frame = frameLoading
        self.view.addSubview(self.progressLoading)
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.progressLoading.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            self.progressLoading.stopAnimating()
        }
    }
    
    @objc func listenerNoHaveWifi(_ notif: Notification) -> Void {
        let vc = AlertConnectionController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @objc func listenerHaveConnectedWifiOrWWAN(_ notif: Notification) -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    func stopLoading() {
        self.progressLoading.stopAnimating()
        self.progressLoading.isHidden = true
    }
    
    func isShowLoading(isShow : Bool) {
        if isShow {
            self.view.isUserInteractionEnabled = false
            customActivityIndicatory(self.view, startAnimate: true)
            
        } else {
            self.view.isUserInteractionEnabled = true
            customActivityIndicatory(self.view, startAnimate: false)            
        }
    }
    
    func getData() {
        
    }
    
    func setupViews() {
        
    }
    
    deinit {
        
    }
    
    func checkGotoLogin() {
        loadCache(is_getaway: 1)
    }
    
    func loadCache(is_getaway:Int){
        let defaults = UserDefaults.standard
        defaults.set(nil, forKey: "Username")
        defaults.set(nil, forKey: "password")
        defaults.set(nil, forKey: "CRMCode")
        defaults.synchronize()
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.goToLogin(is_getaway: is_getaway)
        })
    }
    func goToLogin(is_getaway: Int){
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
    }}
