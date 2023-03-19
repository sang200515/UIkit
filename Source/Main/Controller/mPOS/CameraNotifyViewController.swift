//
//  CameraNotifyViewController.swift
//  fptshop
//
//  Created by Apple on 8/15/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class CameraNotifyViewController: UIViewController {
    
    var btnClose:UIButton!
    var labelTitle:UILabel!
    
    var CallLog_ReqId:Int! = 0
    var titleCallLog: String = ""
    var noiDung: String = ""
    
//    var contentView:UIView!
//    var webView:UIWebView!
    var barClose : UIBarButtonItem!
    var barConfirm : UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00579c)
        self.title = "Thông báo"
        self.navigationController?.navigationBar.isTranslucent = true
        
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "Close"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(actionClose), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]
        
        barConfirm = UIBarButtonItem(title: "Xác nhận", style: .done, target: self, action: #selector(confirm))
        self.navigationItem.rightBarButtonItem = barConfirm
        
//        MPOSAPIManager.sp_mpos_FRT_SP_GetFormNotiHome() { (result, err) in
//
//            if(err.count <= 0){
//
//                self.webView = UIWebView(frame: CGRect(x: 0 , y: Common.Size(s: 5) , width: self.view.frame.size.width , height: self.view.frame.size.height))
//                self.webView.loadHTMLString(result, baseURL: nil)
//
//                self.view.addSubview(self.webView)
//
//
//
//            }else{
//
//            }
//
//        }
        
        let tvND = UITextView(frame: CGRect(x: 0 , y: 0 , width: self.view.frame.size.width , height: self.view.frame.size.height))
        tvND.text = noiDung
        self.view.addSubview(tvND)
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

    @objc func confirm() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.sp_mpos_FRT_SP_Notify_Confirm(handler: { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if rs.count > 0 {
                        if rs[0].p_status == 1 {
                            let alertVC = UIAlertController(title: "Thông báo", message: "\(rs[0].p_messages )", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                self.navigationController?.popViewController(animated: true)
                            })
                            self.dismiss(animated: true, completion: nil)
                            alertVC.addAction(action)
                            self.present(alertVC, animated: true, completion: nil)
                        } else {
                            self.showAlert(title: "Thông báo", message: "\(rs[0].p_messages )")
                        }
                        
                    } else {
                        debugPrint("load api err")
                    }
                }
            })
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }

}
