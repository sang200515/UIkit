//
//  CheckListSMVC.swift
//  fptshop
//
//  Created by Ngoc Bao on 16/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import WebKit

class CheckListSMVC: UIViewController,WKNavigationDelegate,WKUIDelegate {
    
    @IBOutlet weak var webView:WKWebView!
    @IBOutlet weak var bottomView:UIView!
    @IBOutlet weak var confirmButton: UIButton!
    var disPlayData: ListSMItem?
    var onClosePage: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        webView.uiDelegate = self
        self.webView.navigationDelegate = self
        self.webView.loadHTMLString(disPlayData?.template ?? "", baseURL: nil)
        bottomView.isHidden = disPlayData?.buttonName == ""
        confirmButton.setTitle(disPlayData?.buttonName ?? "", for: .normal)
        
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
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let js = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust='250%'"//dual size
        webView.evaluateJavaScript(js, completionHandler: nil)
    }
    
    @IBAction func onConfirm() {
        Provider.shared.listSmApiService.confirm(id: disPlayData?.iD ?? 0) { object in
            self.showAlertOneButton(title: "Thông báo", with: "Bạn đã xác nhận check list thành công", titleButton: "OK", handleOk: {
                self.dismiss(animated: true, completion: nil)
            })
        } failure: { error in
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK", handleOk: {
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    @IBAction func onClose() {
        self.showAlert("Bạn cần phải xác nhận để sử dụng app!")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        onClosePage?()
    }
}
