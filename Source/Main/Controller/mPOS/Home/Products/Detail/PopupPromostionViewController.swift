//
//  PopupPromostionViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/4/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Toaster
import UIKit
import WebKit
class PopupPromostionViewController: UIViewController {
    
    
    var btnClose:UIButton!
    var labelTitle:UILabel!
    
    var contentView:UIView!
    
    
    var webView:WKWebView!
    
    var barClose : UIBarButtonItem!
    var content:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00579c)
        self.title = "Khuyến mãi"
        self.navigationController?.navigationBar.isTranslucent = true
        
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "Close"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(PopupPromostionViewController.actionClose), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]
        
        
        self.webView = WKWebView(frame: CGRect(x: 0 , y: Common.Size(s: 5) , width: self.view.frame.size.width , height: self.view.frame.size.height))
        self.webView.loadHTMLString(Common.shared.headerString + content, baseURL: nil)

        self.view.addSubview(self.webView)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false
    }
    @objc func actionClose(){
        navigationController?.popViewController(animated: false)
        dismiss(animated: false, completion: nil)
    }
}
