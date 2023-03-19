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
class PopUpMiraeViewController: UIViewController {

    
    var btnClose:UIButton!
    var labelTitle:UILabel!
    
    var contentView:UIView!

  
    var webView:WKWebView!
    
     var barClose : UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00579c)
        self.title = "Thông báo"
        self.navigationController?.navigationBar.isTranslucent = true
        
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "Close"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(PopUpMiraeViewController.actionClose), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]
        
        let result = "<strong>Hướng dẫn check KM Online đơn hàng Mirea</strong><br>Bước 1: Đặt đơn hàng Ecom và đẩy về shop.<br>Bước 2: Mở đơn hàng, bấm [Extra], chọn <strong>Đẩy SO để đăng ký trả góp MIRAE</strong><br>Bước 3: Đọc thông báo và Chọn [Yes] tại thông báo hiện lên<br>Bước 4: Sau khi hoàn tất đẩy, đơn hàng sẽ tự động tắt và hiện thông báo <strong>Đã chuyển sang đơn hàng MPOS ,hãy lên mpos để đăng ký trả góp Mirae!</strong><br>Bước 5: Trên màn hình kiểm tra đặt cọc - Nhập số đơn hàng Ecom vào ô đơn hàng đặt cọc để kéo đơn hàng về MPOS và tạo đơn hàng Mirae.<br>Nếu chưa đăng ký trả góp trên mpos, khi mở lại đơn hàng vẫn sẽ bị chặn."
        self.webView = WKWebView(frame: CGRect(x: 0 , y: Common.Size(s: 5) , width: self.view.frame.size.width , height: self.view.frame.size.height))
        self.webView.loadHTMLString(result, baseURL: nil)
        
        self.view.addSubview(self.webView)
        
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
    }


    
    
    @objc func actionClose(){
        //        self.dismiss(animated: false, completion: nil)
        navigationController?.popViewController(animated: false)
        dismiss(animated: false, completion: nil)
    }
    
    
    
    
    
}




















