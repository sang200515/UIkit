//
//  CheckInfoSubsidyViewController.swift
//  mPOS
//
//  Created by MinhDH on 4/6/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import Toaster
class CheckInfoSubsidyViewController: UIViewController,UITextFieldDelegate{
    var scrollView:UIScrollView!
    //    var tfCMND:UITextField!
    var tfStatus:UITextField!
    var buttonSaveAction:Bool = false
    

    override func viewDidLoad() {
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(CheckInfoSubsidyViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "KT KNOX"
        navigationController?.navigationBar.isTranslucent = false
        
        let lbUserInfo = UILabel(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: 0))
        lbUserInfo.textAlignment = .center
        lbUserInfo.textColor = UIColor(netHex:0x47B054)
        lbUserInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbUserInfo.text = ""
        scrollView.addSubview(lbUserInfo)
        
        //        let lbTextCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbUserInfo.frame.size.height + lbUserInfo.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        //        lbTextCMND.textAlignment = .left
        //        lbTextCMND.textColor = UIColor.black
        //        lbTextCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        //        lbTextCMND.text = "SĐT"
        //        scrollView.addSubview(lbTextCMND)
        
        //        tfCMND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextCMND.frame.origin.y + lbTextCMND.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:40)));
        //        tfCMND.placeholder = "Nhập SĐT khách hàng"
        //        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        //        tfCMND.borderStyle = UITextBorderStyle.roundedRect
        //        tfCMND.autocorrectionType = UITextAutocorrectionType.no
        //        tfCMND.keyboardType = UIKeyboardType.numberPad
        //        tfCMND.returnKeyType = UIReturnKeyType.done
        //        tfCMND.clearButtonMode = UITextFieldViewMode.whileEditing;
        //        tfCMND.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        //        tfCMND.delegate = self
        ////        tfCMND.text = "0928320003"
        //        scrollView.addSubview(tfCMND)
        //        tfCMND.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        let lbTextStatus = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbUserInfo.frame.size.height + lbUserInfo.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextStatus.textAlignment = .left
        lbTextStatus.textColor = UIColor.black
        lbTextStatus.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextStatus.text = "IMEI"
        scrollView.addSubview(lbTextStatus)
        
        tfStatus = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextStatus.frame.size.height + lbTextStatus.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfStatus.placeholder = "Nhập imei máy"
        tfStatus.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfStatus.borderStyle = UITextField.BorderStyle.roundedRect
        tfStatus.autocorrectionType = UITextAutocorrectionType.no
        tfStatus.keyboardType = UIKeyboardType.default
        tfStatus.returnKeyType = UIReturnKeyType.done
        tfStatus.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfStatus.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfStatus.delegate = self
        tfStatus.textAlignment = .left
        tfStatus.autocapitalizationType = .words
        scrollView.addSubview(tfStatus)
        
        let btPay = UIButton()
        btPay.frame = CGRect(x: tfStatus.frame.origin.x, y: tfStatus.frame.origin.y + tfStatus.frame.size.height + Common.Size(s:20), width: tfStatus.frame.size.width, height: tfStatus.frame.size.height * 1.2)
        btPay.backgroundColor = UIColor(netHex:0xEF4A40)
        btPay.setTitle("Kiểm tra thông tin", for: .normal)
        btPay.addTarget(self, action: #selector(actionPay), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        scrollView.addSubview(btPay)
        self.hideKeyboardWhenTappedAround()
        
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func actionPay(sender: UIButton!) {
        
        //         let phone = tfCMND.text!
        let imei = tfStatus.text!
        
        if(imei.isEmpty){
            Toast(text: "Bạn phải nhập IMEI máy của khách hàng!").show()
            return
        }
        
        if (buttonSaveAction == false){
            buttonSaveAction = true
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra thông tin..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            MPOSAPIManager.mpos_sp_GetInfoSubsidy(imei: "\(imei)", sdt: "", handler: { (result, err) in
                if(result != nil){
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        
                        if let data = result{
                            if(data.listThongTinSubsidy.count > 0 || data.listLogRequestImei.count > 0 || data.listThongTinCongNo.count > 0){
                                self.buttonSaveAction = false
                                let newController = ResultCheckSubsidyViewController()
                                newController.infoSubsidy = result!
                                self.navigationController?.pushViewController(newController, animated: true)
                            }else{
                                let popup = PopupDialog(title: "THÔNG BÁO", message: "Không tìm thấy thông tin subsidy!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                    self.buttonSaveAction = false
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }
                        }else{
                            let popup = PopupDialog(title: "THÔNG BÁO", message: "Không tìm thấy thông tin subsidy!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                self.buttonSaveAction = false
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                        
                        
                    }
                }else{
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        
                        let popup = PopupDialog(title: "THÔNG BÁO", message: "\(err)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            self.buttonSaveAction = false
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
            })
        }
    }
}
