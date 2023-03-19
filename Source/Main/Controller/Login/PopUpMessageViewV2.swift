//
//  InputCodeView.swift
//  mPOS
//
//  Created by MinhDH on 11/12/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import Foundation
import Toaster
import UIKit
import WebKit
class PopUpMessageViewV2: UIViewController, WKNavigationDelegate {

    
    var btnClose:UIButton!
    var labelTitle:UILabel!
    
    var contentView:UIView!

  
    var webView:WKWebView!
    
     var barClose : UIBarButtonItem!
    var onClose: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00579c)
        self.title = "Thông báo"
        self.navigationController?.navigationBar.isTranslucent = true
        view.backgroundColor = .white
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "Close"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(PopUpMessageViewV2.actionClose), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]
        
        
        MPOSAPIManager.sp_mpos_FRT_SP_GetFormNotiHome() { (result, err) in
            
            if(err.count <= 0){
                
                let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width, initial-scale=1.0, shrink-to-fit=yes'); document.getElementsByTagName('head')[0].appendChild(meta);"
                  
                  let userScript = WKUserScript(source: jscript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
                  
                  let wkUController = WKUserContentController()
                  
                  wkUController.addUserScript(userScript)
                  
                  let wkWebConfig = WKWebViewConfiguration()
                  
                  wkWebConfig.userContentController = wkUController
                
                self.webView = WKWebView(frame: CGRect(x: 0 , y: Common.Size(s: 5) , width: self.view.frame.size.width , height: self.view.frame.size.height),configuration: wkWebConfig)
                self.webView.navigationDelegate = self
                self.webView.loadHTMLString(result, baseURL: nil)
                
                self.view.addSubview(self.webView)
          
                
                
            }else{
           
            }
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("showVerifyVersion"), object: nil)
        if let close = onClose {
            close()
        }
    }


    
    
    @objc func actionClose(){
        self.dismiss(animated: false, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name.init("didClosePopUpMessageViewV2"), object: nil)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            print("link")
            webView.load(navigationAction.request)
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        print("no link")
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    
    
    
    
}




















