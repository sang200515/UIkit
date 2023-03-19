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
class PopUpMessageView: UIView {
    
    var inputCodeViewDelegate:PopUpMessageViewDelegate!
    
    
    
    var mVoucherArr = [CheckVoucherResult]()
    
    var btnClose:UIButton!
    var labelTitle:UILabel!
    
    var contentView:UIView!
    
    
    var btnAdd:UIButton!
    var view:UIScrollView!
    var webView:WKWebView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        view = UIScrollView(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:50), width: UIScreen.main.bounds.size.width - Common.Size(s:30), height: Common.Size(s: 100)))
        view.backgroundColor = UIColor.white
        addSubview(view)
        
        
        
        
        MPOSAPIManager.sp_mpos_FRT_SP_GetFormNotiHome() { (result, err) in
            
            if(err.count <= 0){
                
                
                let sizeDes = "\(result.stripHTML().stringByDecodingHTMLEntities.replace(target: "\t", withString:"- ").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))".height(withConstrainedWidth: self.view.frame.size.width - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
                
                
                self.webView = WKWebView(frame: CGRect(x: Common.Size(s: 5) , y: Common.Size(s: 5) , width: self.view.frame.size.width - Common.Size(s:15), height: sizeDes))
                self.webView.loadHTMLString(result, baseURL: nil)
                
                self.view.addSubview(self.webView)
                self.view.frame.size.height = self.webView.frame.origin.y + self.webView.frame.size.height + Common.Size(s: 5)
          
                self.btnClose = UIButton(frame: CGRect(x: Common.Size(s: 15), y: self.view.frame.origin.y + self.view.frame.size.height , width: UIScreen.main.bounds.size.width - Common.Size(s:30) , height: Common.Size(s: 40)));
                
                self.btnClose.backgroundColor = UIColor(netHex:0x00955E)
                self.btnClose.layer.cornerRadius = 1
                
                self.btnClose.setTitle("Đóng",for: .normal)
                self.btnClose.setTitleColor(UIColor.white, for: .normal)
                
                
                self.addSubview(self.btnClose)
                self.btnClose.addTarget(self, action: #selector(PopUpMessageView.ClickClose), for: UIControl.Event.touchDown)
                
                
            }else{
                self.inputCodeViewDelegate?.didClose(sender:
                    self)
            }
            
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    
    
    
    
    @objc func ClickClose()
    {
        inputCodeViewDelegate?.didClose(sender:
            self)
    }
    
    
    
    
    
}


protocol PopUpMessageViewDelegate
{
    func didClose(sender: PopUpMessageViewDelegate)
    
    
    
}





extension PopUpMessageView: PopUpMessageViewDelegate
{
    
    func didClose(sender: PopUpMessageViewDelegate) {
        
    }
    
    
}



















