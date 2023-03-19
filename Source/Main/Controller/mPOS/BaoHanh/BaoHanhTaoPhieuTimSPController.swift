//
//  BaoHanhTaoPhieuTimSPController.swift
//  mPOS
//
//  Created by sumi on 1/10/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import PopupDialog

class BaoHanhTaoPhieuTimSPController: UIViewController {
    
    var mImeiUser:String?
    var baohanhTimSPView:BaoHanhTaoPhieuTimSPView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        baohanhTimSPView = BaoHanhTaoPhieuTimSPView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.view.addSubview(baohanhTimSPView)
        
        
        baohanhTimSPView.btnTimKiem.addTarget(self, action: #selector(self.SearchClick), for: UIControl.Event.touchDown)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @objc func SearchClick() {
        if(baohanhTimSPView.edtSDT.text == "")
        {
            let title = "THÔNG BÁO"
            let message = "Bạn phải nhập điều kiện tìm kiếm"
          
            
            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                
            }
            let buttonOne = DefaultButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            
        }
        else
        {
            let newViewController = BaoHanhSearchListController()
            newViewController.mValuee = baohanhTimSPView.edtSDT.text
            newViewController.mImei = self.mImeiUser ?? ""
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
    
    
    
}
