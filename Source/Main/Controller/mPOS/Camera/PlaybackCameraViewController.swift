//
//  PlaybackCameraViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/1/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import AVFoundation
import PopupDialog
class PlaybackCameraViewController: UIViewController, WKNavigationDelegate,WKUIDelegate {
    var webView: WKWebView!
    var isLoad: Bool = false
    var ShopCode:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationBar()
        self.title = "Playback"
        isLoad = false
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - self.tabBarController!.tabBar.frame.size.height))
        webView.navigationDelegate = self
        self.webView.uiDelegate = self
        self.view.addSubview(webView)
        
        webView.allowsBackForwardNavigationGestures = true
        
        load()
    }
    func load(){
        if(!isLoad){
            isLoad = true
            
            var isCellular = ""
            let carrierName = Common.getTelephoneName()
            if(isConntectStatus != .notReachable){
                if (isConntectStatus == .reachableViaWiFi) {
                    isCellular = "0"
                } else if (isConntectStatus == .reachableViaWWAN) {
                    isCellular = "1"
                } else {
                    isCellular = ""
                }
                
                if carrierName.isEmpty {
                    let popup = PopupDialog(title: "Thông báo", message: "Không có SIM!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "Đồng ý") {
                        isCellular = ""
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
            } else {
                let popup = PopupDialog(title: "Thông báo", message: "Không có kết nối mạng!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "Đồng ý") {
                    isCellular = ""
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang tải trang..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.tabBarController?.present(newViewController, animated: true, completion: nil)
            MPOSAPIManager.mpos_GetPlayBackCamera(ShopCode: "\(ShopCode)", CarrierName: "\(carrierName)", isCellular: "\(isCellular)") { (playBackCamera, err) in
                if(playBackCamera != nil){
                    let urlS = URL(string: "http://\(playBackCamera!.playbackPath)")!
                    self.webView.load(URLRequest(url: urlS))
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
}

