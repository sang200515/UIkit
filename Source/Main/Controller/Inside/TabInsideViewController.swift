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
import AVFoundation
import PopupDialog
class TabInsideViewController: UIViewController, WKNavigationDelegate,WKUIDelegate {
    var webView: WKWebView!
    var isLoad: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationBar()
        self.title = "Inside"
        isLoad = false
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - self.tabBarController!.tabBar.frame.size.height))
        // - self.navigationController!.navigationBar.frame.size.height - UIApplication.shared.statusBarFrame.height
        webView.navigationDelegate = self
        self.webView.uiDelegate = self
        self.view.addSubview(webView)
        
        webView.allowsBackForwardNavigationGestures = true
        
        load()
    }
    func load(){
        if(!isLoad){
        isLoad = true
        let newViewController = LoadingViewController()
        newViewController.content = "Đang tải trang..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.tabBarController?.present(newViewController, animated: true, completion: nil)
        let randomInt = Int.random(in: 000001..<999999)
        APIManager.require_sso_token(ssoId: "\(randomInt)", url: "insidenew.fptshop.com.vn") { (urlString, err) in
            if(urlString.count > 0){
                
                if(Cache.INSIDE_URL != "https://insidenew.fptshop.com.vn"){
                    print("URL \(Cache.INSIDE_URL)&\(urlString)")
                    let url = URL(string: "\(Cache.INSIDE_URL)&\(urlString)")!
                    self.webView.load(URLRequest(url: url))
                    Cache.INSIDE_URL = "https://insidenew.fptshop.com.vn"
                }else{
                    print("URL \(Cache.INSIDE_URL)?\(urlString)")
                    let url = URL(string: "\(Cache.INSIDE_URL)?\(urlString)")!
                    self.webView.load(URLRequest(url: url))
                }
                
            }else{
                let nc = NotificationCenter.default
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "Đồng ý") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
            }
            }
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        checkCameraAccess()
        if(Cache.INSIDE_URL != "https://insidenew.fptshop.com.vn"){
            load()
        }
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
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if (navigationAction.navigationType == .linkActivated){
            decisionHandler(.allow)
        } else {
            decisionHandler(.allow)
        }
    }
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
        let nc = NotificationCenter.default
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
        }
        isLoad = false
    }
    func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            print("Denied, request permission from settings")
            presentCameraSettings()
        case .restricted:
            print("Restricted, device owner must approve")
        case .authorized:
            print("Authorized, proceed")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    print("Permission granted, proceed")
                } else {
                    print("Permission denied")
                }
            }
        @unknown default:
            print("Didn't request permission for User Notification")
        }
    }
    func presentCameraSettings() {
        let alertController = UIAlertController(title: "Error",
                                                message: "Bạn cần phải cấp quyền camera cho ứng dụng!",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
        })
        
        present(alertController, animated: true)
    }
}
