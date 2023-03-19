//
//  BaoHanhSearchController.swift
//  mPOS
//
//  Created by sumi on 12/15/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import PopupDialog

class BaoHanhSearchController: UIViewController {
    
    var baohanhSearchView:BaoHanhSearchView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        baohanhSearchView = BaoHanhSearchView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.view.addSubview(baohanhSearchView)
        
        
        baohanhSearchView.btnTimKiem.addTarget(self, action: #selector(self.SearchClick), for: UIControl.Event.touchDown)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func SearchClick() {
        if(baohanhSearchView.edtSDT.text == "" &&
            baohanhSearchView.edtImei.text == "" &&
            baohanhSearchView.edtSONum.text == "" &&
            baohanhSearchView.edtHoaDonDo.text == "" )
        {
            let title = "THÔNG BÁO"
            let message = "Bạn phải nhập điều kiện tìm kiếm"
         
            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = DefaultButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            
        }
        else
        {
            let newViewController = BaoHanhSearchV2ListController()
            newViewController.p_BILL = baohanhSearchView.edtHoaDonDo.text!
            newViewController.p_PhoneNumber = baohanhSearchView.edtSDT.text!
            newViewController.p_Imei = baohanhSearchView.edtImei.text!
            newViewController.p_SO_DocNum = baohanhSearchView.edtSONum.text!
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        }
        
    }
    
    
    
}
