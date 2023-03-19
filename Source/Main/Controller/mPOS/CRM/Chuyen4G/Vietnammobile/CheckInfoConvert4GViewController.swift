//
//  Convert4GViewController.swift
//  mPOS
//
//  Created by tan on 7/9/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class CheckInfoConvert4GViewController: UIViewController,UITextFieldDelegate {
    var scrollView:UIScrollView!
    var tfPhone:UITextField!
    var btnCheck:UIButton!
    var phone:String!
    
    override func viewDidLoad() {
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Chuyển 2G/3G sang 4G"
        
        let lbTextPhone =  UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhone.textAlignment = .left
        lbTextPhone.textColor = UIColor.black
        lbTextPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhone.text = "Số điện thoại"
        scrollView.addSubview(lbTextPhone)
        
        tfPhone = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhone.frame.origin.y + lbTextPhone.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfPhone.placeholder = "Nhập số điện thoại khách hàng"
        tfPhone.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhone.autocorrectionType = UITextAutocorrectionType.no
        tfPhone.keyboardType = UIKeyboardType.numberPad
        tfPhone.returnKeyType = UIReturnKeyType.done
        tfPhone.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhone.delegate = self
        scrollView.addSubview(tfPhone)
        
        
        btnCheck = UIButton()
        btnCheck.frame = CGRect(x: tfPhone.frame.origin.x, y: tfPhone.frame.origin.y + tfPhone.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30),height: Common.Size(s:40))
        btnCheck.backgroundColor = UIColor(netHex:0xEF4A40)
        btnCheck.setTitle("Kiểm tra", for: .normal)
        btnCheck.addTarget(self, action: #selector(actionCheck), for: .touchUpInside)
        btnCheck.layer.borderWidth = 0.5
        btnCheck.layer.borderColor = UIColor.white.cgColor
        btnCheck.layer.cornerRadius = 3
        scrollView.addSubview(btnCheck)
        btnCheck.clipsToBounds = true
        
        
    }
    @objc func actionCheck(){
        self.hideKeyBoard()
        if(tfPhone.text == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Nhập số điện thoại khách hàng!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        let newViewController = LoadingViewController()
        newViewController.content = "Đang gửi mã OTP..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.SendOTPConvert4G(isdn: tfPhone.text!) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if (results.Success == true){
                    if(results.OTPRequestConvertData?.code == 0){
                        let newViewController = Convert4GViewController()
                        newViewController.phone = self.tfPhone.text
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }
                }else{
                    if(results.Message != ""){
                        let popup = PopupDialog(title: "Thông báo", message: results.Message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
                            
                        }
                        let buttonOne = CancelButton(title: "OK") {
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                        
                    }else{
                        let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
                            
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    func hideKeyBoard(){
        self.tfPhone.resignFirstResponder()
    }
}

