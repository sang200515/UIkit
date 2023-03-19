//
//  CheckVoucherOTPViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 6/2/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
protocol CheckVoucherOTPViewControllerDelegate: NSObjectProtocol {
    func returnCheckOTPVoucher(voucher:String)
}

class CheckVoucherOTPViewController: UIViewController,UITextFieldDelegate {
    var tfOTP:UITextField!
    var btConfirmOTP:UIButton!
    var voucher:String?
    var phone:String?
    var doctype:String?
    var delegate:CheckVoucherOTPViewControllerDelegate?
    var barClose : UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00955E)
        self.title = "Lấy mã OTP"
        self.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "Close"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(NCCThuHoViewController.actionClose), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]
        
        let lbTitleOTP = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTitleOTP.textAlignment = .left
        lbTitleOTP.textColor = UIColor.black
        lbTitleOTP.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbTitleOTP.text = "Nhập OTP _ \(phone!)"
        self.view.addSubview(lbTitleOTP)
        
        tfOTP = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTitleOTP.frame.origin.y + lbTitleOTP.frame.size.height + Common.Size(s:5), width: self.view.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfOTP.placeholder = "Vui lòng nhập mã OTP"
        tfOTP.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfOTP.borderStyle = UITextField.BorderStyle.roundedRect
        tfOTP.autocorrectionType = UITextAutocorrectionType.no
        tfOTP.keyboardType = UIKeyboardType.numberPad
        tfOTP.returnKeyType = UIReturnKeyType.done
        tfOTP.clearButtonMode = UITextField.ViewMode.whileEditing
        tfOTP.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfOTP.delegate = self
        self.view.addSubview(tfOTP)
        
        
        btConfirmOTP = UIButton()
        btConfirmOTP.frame = CGRect(x: tfOTP.frame.origin.x, y: tfOTP.frame.origin.y + tfOTP.frame.size.height + Common.Size(s:20), width: tfOTP.frame.size.width, height: Common.Size(s:40))
        btConfirmOTP.backgroundColor = UIColor(netHex:0x00955E)
        btConfirmOTP.setTitle("Xác nhận", for: .normal)
        btConfirmOTP.addTarget(self, action: #selector(actionConfirm), for: .touchUpInside)
        btConfirmOTP.layer.borderWidth = 0.5
        btConfirmOTP.layer.borderColor = UIColor.white.cgColor
        btConfirmOTP.layer.cornerRadius = 3
        self.view.addSubview(btConfirmOTP)
        
        
        
        
        
        
    }
    @objc func actionConfirm(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_FRT_SP_check_otp_VC_CRM(voucher:"\(voucher!)",sdt:"\(phone!)",doctype:"\(doctype!)",otp:"\(tfOTP.text!)") { (p_status,p_message,err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(p_status == 1){
                        let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            self.navigationController?.popViewController(animated: false)
                            self.dismiss(animated: false, completion: nil)
                            self.delegate?.returnCheckOTPVoucher(voucher:"\(self.voucher!)")
                        })
                        self.present(alert, animated: true)
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
            
        }
    }
    @objc func actionClose(){
        //        self.dismiss(animated: false, completion: nil)
        navigationController?.popViewController(animated: false)
        dismiss(animated: false, completion: nil)
    }
}
