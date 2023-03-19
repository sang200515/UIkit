//
//  DetailCameraViewControllerV2.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/2/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import PopupDialog
class DetailCameraViewControllerV2: UIViewController, WKNavigationDelegate,WKUIDelegate{
    var cameraShop:CameraShop!
    var webView: WKWebView!
       var isLoad: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationBar()
        self.title = "\(cameraShop.WarehouseName)"
        self.view.backgroundColor = .white
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(DetailCameraViewControllerV2.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        //---
        let viewRightNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: viewRightNav)
        let btPlaybackIcon = UIButton.init(type: .custom)
        btPlaybackIcon.setImage(#imageLiteral(resourceName: "ic_camera"), for: UIControl.State.normal)
        btPlaybackIcon.imageView?.contentMode = .scaleAspectFit
        btPlaybackIcon.addTarget(self, action: #selector(DetailCameraViewControllerV2.actionPlayback), for: UIControl.Event.touchUpInside)
        btPlaybackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewRightNav.addSubview(btPlaybackIcon)
        
        isLoad = false
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
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
            MPOSAPIManager.mpos_GetPlayBackCamera(ShopCode: "\(cameraShop.WarehouseCode)", CarrierName: "\(carrierName)", isCellular: "\(isCellular)") { (playBackCamera, err) in
                if(playBackCamera != nil){
                    let urlS = URL(string: "http://\(playBackCamera!.livesPath)")!
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
        isLoad = false
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func actionPlayback() {
        let vc = PlaybackCameraViewController()
        vc.ShopCode = "\(cameraShop.WarehouseCode)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
