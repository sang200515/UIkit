//
//  PopUpWebview.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 20/09/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Toaster
import UIKit
import WebKit

class PopUpWebview: UIViewController, WKNavigationDelegate {
    private var btnClose: UIButton!
    private var labelTitle: UILabel!
    private var contentView: UIView!
    private var webView: WKWebView!
    private var barClose: UIBarButtonItem!

    var path: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00579c)
        self.title = "Thông báo"
        self.navigationController?.navigationBar.isTranslucent = true
        view.backgroundColor = .white
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "Close"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(PopUpWebview.actionClose), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]

        self.webView = WKWebView(frame: CGRect(x: 0, y: Common.Size(s: 5), width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.webView.navigationDelegate = self

        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        if let path = path.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet), let url = URL(string: path) {
            let request = URLRequest(url: url)
            self.webView.load(request)
            self.view.addSubview(self.webView)
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
        popToRootVC()
    }

    @objc func actionClose(){
        navigationController?.popViewController(animated: false)
        dismiss(animated: false, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name.init("didClosePopUpWebview"), object: nil)
    }

    private func popToRootVC(){
        NotificationCenter.default.post(name: NSNotification.Name.init("didClosePopUpWebview"), object: nil)
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
