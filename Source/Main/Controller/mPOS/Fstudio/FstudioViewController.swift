//
//  FstudioViewController.swift
//  fptshop
//
//  Created by tan on 12/25/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import WebKit
class FstudioViewController: UIViewController, WKNavigationDelegate  {
    
    var webView: WKWebView!
    var isLoad: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationBar()
        self.title = "Fstudio"
        isLoad = false
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - self.tabBarController!.tabBar.frame.size.height))
        // - self.navigationController!.navigationBar.frame.size.height - UIApplication.shared.statusBarFrame.height
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        let defaults = UserDefaults.standard
        let FSTUDIO_URL = Config.manager.URL_GATEWAY! + "/mpos-cloud-callogbeta/Users/AuthenticationApp?k="
        if let userName = defaults.string(forKey: "Username") {
            if let password = defaults.string(forKey: "password"){
                
                let KeyEncrypted = "\(userName)\n\r\(password)\n\r123456fpt@"
                let pwd = PasswordEncrypter.encrypt(password: KeyEncrypted)
                
                let url = URL(string: "\(FSTUDIO_URL)\(pwd)")!
                var request = URLRequest(url: url)
                var access_token = UserDefaults.standard.string(forKey: "access_token")
                access_token = access_token == nil ? "" : access_token
                
                request.setValue("application/json", forHTTPHeaderField: "Content-type")
                request.setValue("Bearer \(access_token!)", forHTTPHeaderField: "Authorization")

                webView.load(request)
                webView.allowsBackForwardNavigationGestures = true
//                if #available(iOS 10.0, *) {
//                    UIApplication.shared.open(URL(string: "\(FSTUDIO_URL)\(pwd)")!, options: [:], completionHandler: nil)
//                } else {
//                    UIApplication.shared.openURL(URL(string: "\(FSTUDIO_URL)\(pwd)")!)
//                }
            }
            
        }
   
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
        if(!isLoad){
            isLoad = true
            let newViewController = LoadingViewController()
            newViewController.content = "Đang tải trang..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.tabBarController?.present(newViewController, animated: true, completion: nil)
        }
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
        let nc = NotificationCenter.default
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
        }
    }
}
