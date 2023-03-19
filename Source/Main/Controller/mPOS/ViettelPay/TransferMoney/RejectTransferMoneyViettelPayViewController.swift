//
//  RejectTransferMoneyViettelPayViewController.swift
//  fptshop
//
//  Created by tan on 6/27/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import Toaster
class RejectTransferMoneyViettelPayViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate {
    var tfReason:UITextView!
    var tfConfirmCode:UITextField!
    var btConfirm:UIButton!
    var btReject:UIButton!
    var scrollView:UIScrollView!
    var transferDetail:TransferDetails?
    override func viewDidLoad() {
        self.title = "Huỷ giao dịch"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(RejectTransferMoneyViettelPayViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = .white
        self.view.addSubview(scrollView)
        
        
        let lbTitleCode = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbTitleCode.textAlignment = .left
        lbTitleCode.textColor = UIColor.black
        lbTitleCode.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitleCode.text = "Mã Xác Nhận"
        scrollView.addSubview(lbTitleCode)
        
        tfConfirmCode = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTitleCode.frame.origin.y + lbTitleCode.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfConfirmCode.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfConfirmCode.borderStyle = UITextField.BorderStyle.roundedRect
        tfConfirmCode.autocorrectionType = UITextAutocorrectionType.no
        tfConfirmCode.keyboardType = UIKeyboardType.numberPad
        tfConfirmCode.returnKeyType = UIReturnKeyType.done
        tfConfirmCode.clearButtonMode = UITextField.ViewMode.whileEditing
        tfConfirmCode.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfConfirmCode.delegate = self
        scrollView.addSubview(tfConfirmCode)
        
        let lbTitleLyDo = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfConfirmCode.frame.size.height + tfConfirmCode.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbTitleLyDo.textAlignment = .left
        lbTitleLyDo.textColor = UIColor.black
        lbTitleLyDo.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitleLyDo.text = "Lý do huỷ"
        scrollView.addSubview(lbTitleLyDo)
        
        tfReason = UITextView(frame: CGRect(x: lbTitleLyDo.frame.origin.x , y: lbTitleLyDo.frame.origin.y  + lbTitleLyDo.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:35) * 2 ))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        tfReason.layer.borderWidth = 0.5
        tfReason.layer.borderColor = borderColor.cgColor
        tfReason.layer.cornerRadius = 5.0
        tfReason.delegate = self
        tfReason.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        scrollView.addSubview(tfReason)
        
        btConfirm = UIButton()
        btConfirm.frame = CGRect(x: Common.Size(s:15), y: tfReason.frame.size.height + tfReason.frame.origin.y + Common.Size(s: 10)  , width: tfReason.frame.size.width, height: Common.Size(s:35) * 1.2)
        btConfirm.backgroundColor = UIColor(netHex:0x00955E)
        btConfirm.setTitle("Xác nhận", for: .normal)
        btConfirm.addTarget(self, action: #selector(actionGetInfo), for: .touchUpInside)
        btConfirm.layer.borderWidth = 0.5
        btConfirm.layer.borderColor = UIColor.white.cgColor
        btConfirm.layer.cornerRadius = 3
        scrollView.addSubview(btConfirm)
        
        
    }
    
    @objc func actionGetInfo(){
        let code = tfConfirmCode.text!
        if(code.isEmpty){
            
            let alert = UIAlertController(title: "Thông báo", message: "Mã nhận tiền không được để trống", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            tfConfirmCode.becomeFirstResponder()
            return
        }
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        //let date = Date()
        //let dateString = dateFormatter.string(from: date)
        
        self.actionCheckFeeBack(trans_id:"\(self.transferDetail!.trans_id_viettel)")
        
//        let newViewController = LoadingViewController()
//        newViewController.content = "Đang lấy thông tin  ..."
//        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        self.navigationController?.present(newViewController, animated: true, completion: nil)
//        let nc = NotificationCenter.default
//
//        MPOSAPIManager.getTransInfoEx(order_id:"frt-gettransinfo-\(dateString)",trans_date:dateString,receipt_code:code,amount:"\(self.transferDetail!.amount)",receiver_msisdn:"\(self.transferDetail!.receiver_msisdn)") { (results, err) in
//            let when = DispatchTime.now() + 0.5
//            DispatchQueue.main.asyncAfter(deadline: when) {
//                nc.post(name: Notification.Name("dismissLoading"), object: nil)
//                if(err.count <= 0){
//
//
//                    //self.actionInitHuy()
//                    //self.actionHuy()
//
//
//                }else{
//                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
//
//                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                    })
//                    self.present(alert, animated: true)
//                }
//            }
//        }
    }
    
    //    @objc func actionConfirm(){
    //
    //        let dateFormatter : DateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "yyyyMMddHHmmss"
    //        let date = Date()
    //        let dateString = dateFormatter.string(from: date)
    //
    //        let newViewController = LoadingViewController()
    //        newViewController.content = "Đang huỷ giao dịch ..."
    //        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    //        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    //        self.navigationController?.present(newViewController, animated: true, completion: nil)
    //        let nc = NotificationCenter.default
    //
    //        MPOSAPIManager.partnerCancel(original_trans_id: "\(self.transferDetail!.trans_id_viettel)" , original_order_id: "frt-maketransfer-\(dateString)") { (results, err) in
    //            let when = DispatchTime.now() + 0.5
    //            DispatchQueue.main.asyncAfter(deadline: when) {
    //                nc.post(name: Notification.Name("dismissLoading"), object: nil)
    //
    //                if(err.count <= 0){
    //
    //                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
    //
    //                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
    //                        _ = self.navigationController?.popViewController(animated: true)
    //                        self.dismiss(animated: true, completion: nil)
    //                    })
    //                    self.present(alert, animated: true)
    //
    //
    //
    //
    //                }else{
    //                    let title = "Thông báo"
    //
    //
    //                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
    //                        print("Completed")
    //                    }
    //                    let buttonOne = CancelButton(title: "OK") {
    //
    //                    }
    //                    popup.addButtons([buttonOne])
    //                    self.present(popup, animated: true, completion: nil)
    //
    //                }
    //            }
    //        }
    //
    //    }
    
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    func actionInitHuy(){
        let dateFormatter : DateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        
        let date = Date()
        
        let dateString = dateFormatter.string(from: date)
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang xác nhận thông tin  ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.initTransfer(trans_date: dateString,receiver_msisdn: self.transferDetail!.receiver_msisdn,receiver_id_number: "\(self.transferDetail!.receiver_id_number)",receipt_code: "\(self.tfConfirmCode.text!)",amount: "\(self.transferDetail!.amount)",image_cmtmt: "",image_cmtms: "",receiver_address:"\(self.transferDetail!.receiver_address)",image_pnt:"",init_type:"2") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    
                    //                    let alert = UIAlertController(title: "Thông báo", message: results.error_msg, preferredStyle: .alert)
                    //
                    //                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    //
                    //                    })
                    //                    self.present(alert, animated: true)
                    //   self.actionHuy(confirmCode:results.confirm_code)
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc func actionHuy(fee:Int,title:String){
     

        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang huỷ giao dịch  ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default

        MPOSAPIManager.partnerCancel(original_trans_id: "\(self.transferDetail!.trans_id_viettel)" , original_order_id: "\(self.transferDetail!.docentry)") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                
                if(err.count <= 0){
                    
                    let alert = UIAlertController(title: title, message: "\(results!.error_msg) \r\n \(results!.cust_fee_back_msg) \r\n Phí GD: \(Common.convertCurrencyV2(value: fee))", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                        _ = self.navigationController?.popToRootViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("viettelPayView"), object: nil)
                        
                    })
                    self.present(alert, animated: true)
            
//                    if(results!.cust_fee_back == false){
//
//                        let alert = UIAlertController(title: "Thông báo", message: "\(results!.cust_fee_back_msg) \r\n Phí GD: \(Common.convertCurrencyV2(value: self.transferDetail!.cust_fee))", preferredStyle: .alert)
//
//                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                            self.actionCheckFeeBack(trans_id:"\(self.transferDetail!.trans_id_viettel)")
//
//                        })
//                        self.present(alert, animated: true)
//                    }else{
//                        let alert = UIAlertController(title: "Thông báo", message: "\(results!.error_msg) \r\n \(results!.cust_fee_back_msg) \r\n Phí GD: \(Common.convertCurrencyV2(value: self.transferDetail!.cust_fee))", preferredStyle: .alert)
//
//                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                            _ = self.navigationController?.popToRootViewController(animated: true)
//                            self.dismiss(animated: true, completion: nil)
//                            let nc = NotificationCenter.default
//                            nc.post(name: Notification.Name("viettelPayView"), object: nil)
//
//                        })
//                        self.present(alert, animated: true)
//                    }
               
                    
                    
                    
                    
                }else{
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let title = "Thông báo"
                    
                    
                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                }
            }
        }
        
    }
    func actionCheckFeeBack(trans_id:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang thực hiện truy vấn hoàn phí  ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.CheckCustFeeBack(trans_id:trans_id) { (results,message, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    
                    self.actionHuy(fee:results!.cust_fee,title:results!.p_notefee)
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
}
