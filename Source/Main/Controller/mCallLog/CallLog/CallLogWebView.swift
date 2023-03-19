//
//  TabInsideViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/17/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import WebKit
class CallLogWebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var url: URL!;
    var isLoad: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationBar()
        self.title = "CallLog"
        isLoad = false
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - self.tabBarController!.tabBar.frame.size.height))
        // - self.navigationController!.navigationBar.frame.size.height - UIApplication.shared.statusBarFrame.height
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        
        var request = URLRequest(url: url!)
        var access_token = UserDefaults.standard.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.setValue("Bearer \(access_token!)", forHTTPHeaderField: "Authorization")

        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.tabBarController?.tabBar.isHidden = true
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
