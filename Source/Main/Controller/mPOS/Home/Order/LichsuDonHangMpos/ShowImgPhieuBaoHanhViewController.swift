//
//  ShowImgPhieuBaoHanhViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 7/30/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
import UIKit
import WebKit

class ShowImgPhieuBaoHanhViewController: UIViewController, WKNavigationDelegate {
    var linkAnh = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame.size = CGSize(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.7)
        self.view.backgroundColor = UIColor.white
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hidePopUp))
        view.addGestureRecognizer(tap)

        let webView = WKWebView(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: self.view.frame.size.width - Common.Size(s: 10), height: self.view.frame.size.height - Common.Size(s: 10)))
        webView.navigationDelegate = self
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        if let path = linkAnh.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet), let url = URL(string: path) {
            let request = URLRequest(url: url)
            webView.load(request)
            webView.layer.cornerRadius = 5
            self.view.addSubview(webView)
        }
        
//        let imgViewBaoHanh = UIImageView(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: self.view.frame.width - Common.Size(s: 10), height: self.view.frame.height - Common.Size(s: 10)))
//        imgViewBaoHanh.contentMode = .scaleAspectFit
//        imgViewBaoHanh.layer.cornerRadius = 5
//        self.view.addSubview(imgViewBaoHanh)
//        Common.encodeURLImg(urlString: "\(linkAnh)", imgView: imgViewBaoHanh)
    }
    
    @objc func hidePopUp() {
        UIView.animate(withDuration: 0.2) {
            self.dismiss(animated: true, completion: nil)
        }
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
