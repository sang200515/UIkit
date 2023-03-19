//
//  PopUpHTTD.swift
//  fptshop
//
//  Created by Ngo Dang tan on 8/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import WebKit

class PopUpHTTD: UIViewController {

    
    var btnClose:UIButton!
    var labelTitle:UILabel!
    
    var contentView:UIView!

  
    var webView:WKWebView!
    
     var barClose : UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
           self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00955E)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.title = "Thông báo"
        view.backgroundColor = .white
 
        
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "Close"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(PopUpMessageViewV2.actionClose), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]
        
        
        MPOSAPIManager.mpos_FRT_SP_Mirae_noteforsale(type:"6") { (result, err) in
            
            if(err.count <= 0){
                
                
                
                self.webView = WKWebView(frame: CGRect(x: 0 , y: Common.Size(s: 5) , width: self.view.frame.size.width , height: self.view.frame.size.height))
                
                self.webView.loadHTMLString(Common.shared.headerString + result, baseURL: nil)

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
    }


    
    
    @objc func actionClose(){
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    
    
    
}
