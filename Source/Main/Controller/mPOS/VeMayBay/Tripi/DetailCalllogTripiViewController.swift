//
//  DetailCalllogTripiViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 1/13/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import WebKit

class DetailCalllogTripiViewController: UIViewController, WKNavigationDelegate {
    var requestID = ""
    var webView: WKWebView!
    var isLoad: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calllog Tripi"
        self.view.backgroundColor = UIColor.white
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - self.tabBarController!.tabBar.frame.size.height))
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        let defaults = UserDefaults.standard
        let password = defaults.string(forKey: "password")
        let key = "\(Cache.user!.UserName)\n\r\(password!)\n\r/Requests/DetailFormMobile/\(requestID)"
        let endpoint = PasswordEncrypter.encrypt(password: key)
//        let url = URL(string: "\(Config.manager.URL_GATEWAY!)/mpos-cloud-callogoutside/Users/AuthenticationApp?k=\(endpoint)")!;
        
        let target = Bundle.main.infoDictionary?["TargetName"] as? String
        var url: URL!
        switch target {
        case "fptshop", "Production":
            url = URL(string: "https://calllogoutside.fptshop.com.vn/Users/AuthenticationApp?k=\(endpoint)")!
        default:
            url = URL(string: "https://calllogoutsidebeta.fptshop.com.vn/Users/AuthenticationApp?k=\(endpoint)")!
        }
    
        debugPrint("url str: \(url)")
        
        var request = URLRequest(url: url)
//        var access_token = UserDefaults.standard.string(forKey: "access_token")
//        access_token = access_token == nil ? "" : access_token
        
//        request.setValue("application/json", forHTTPHeaderField: "Content-type")
//        request.setValue("Bearer \(access_token!)", forHTTPHeaderField: "Authorization")

        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
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
