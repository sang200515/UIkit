//
//  CheckInfoChangeSimViewController.swift
//  fptshop
//
//  Created by Apple on 4/12/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Toaster

class CheckInfoChangeSimViewController: UIViewController,UITextFieldDelegate  {
    
    var tfPhone:UITextField!
    var tfCMND:UITextField!
    var btnCheck:UIButton!
    var sim: SimThuong?
    var listCustomerInfo = [SimCustomer]()
    var listProvinces = [Province]()
    var customerInfo: SimCustomer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "KIỂM TRA THÔNG TIN SIM"
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.hidesBackButton = true
        
        let backView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:30), height: Common.Size(s:50))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: backView)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        backView.addSubview(btBackIcon)
        
        self.setUpView()
        self.getListProvince()
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpView() {
        let lbTextPhone =  UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: self.view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhone.textAlignment = .left
        lbTextPhone.textColor = UIColor.black
        lbTextPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhone.text = "Số điện thoại"
        self.view.addSubview(lbTextPhone)
        
        tfPhone = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhone.frame.origin.y + lbTextPhone.frame.size.height + Common.Size(s:5), width: self.view.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfPhone.placeholder = "Nhập số điện thoại khách hàng"
        tfPhone.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhone.autocorrectionType = UITextAutocorrectionType.no
        tfPhone.keyboardType = UIKeyboardType.numberPad
        tfPhone.returnKeyType = UIReturnKeyType.done
        tfPhone.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhone.delegate = self
        self.view.addSubview(tfPhone)
        //        tfPhone.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        let lbTextCMND =  UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhone.frame.origin.y + tfPhone.frame.height + Common.Size(s:10), width: self.view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMND.textAlignment = .left
        lbTextCMND.textColor = UIColor.black
        lbTextCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMND.text = "CMND"
        self.view.addSubview(lbTextCMND)
        
        tfCMND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextCMND.frame.origin.y + lbTextCMND.frame.size.height + Common.Size(s:5), width: self.view.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfCMND.placeholder = "Nhập CMND khách hàng"
        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMND.autocorrectionType = UITextAutocorrectionType.no
        tfCMND.keyboardType = UIKeyboardType.numberPad
        tfCMND.returnKeyType = UIReturnKeyType.done
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMND.delegate = self
        self.view.addSubview(tfCMND)
        
        btnCheck = UIButton()
        btnCheck.frame = CGRect(x: Common.Size(s:15), y: tfCMND.frame.origin.y + tfCMND.frame.size.height + Common.Size(s:20), width: self.view.frame.size.width - Common.Size(s:30),height: Common.Size(s:40))
        btnCheck.backgroundColor = UIColor(red: 34/255, green: 134/255, blue: 70/255, alpha: 1)
        btnCheck.setTitle("TRA CỨU", for: .normal)
        btnCheck.addTarget(self, action: #selector(actionCheck), for: .touchUpInside)
        btnCheck.layer.borderWidth = 0.5
        btnCheck.layer.borderColor = UIColor.white.cgColor
        btnCheck.layer.cornerRadius = 3
        self.view.addSubview(btnCheck)
        btnCheck.clipsToBounds = true
    }
    
    func hideKeyBoard(){
        self.tfPhone.resignFirstResponder()
    }
    
    @objc func actionCheck(){
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            MPOSAPIManager.VTCheckSim(isdn: self.tfPhone.text ?? "", custId: self.tfCMND.text ?? "", handler: { (statusCode, message, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if statusCode == 0 {
                        
                        //lay OTP
                        let alertVC = UIAlertController(title: "Thông báo", message: "Để cập nhật Sim, số TB của bạn phải còn nguyên vẹn trên máy!", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Lấy OTP", style: .default) { (_) in
                            self.getOPT(sdt: self.tfPhone.text ?? "")
                        }
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    } else { //statusCode == 1
                        self.getListCustomer()
                    }
                }
            })
            
        }
    }
    
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle1:String?,
                         actionTitle2:String?,
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         actionHandler1: ((_ text: String?) -> Void)? = nil,
                         actionHandler2: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            //            textField.keyboardType = inputKeyboardType
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: actionTitle1, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler1?(nil)
                return
            }
            actionHandler1?(textField.text)
        }))
        
        alert.addAction(UIAlertAction(title: actionTitle2, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler2?(nil)
                return
            }
            actionHandler2?(textField.text)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func getOPT(sdt: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.VTSendOTPErp(isdn: sdt, handler: { (success, message, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if success {
                        
                        self.showInputDialog(title: "Xác nhận", subtitle: "Nhập mã OTP được gửi về máy khách hàng", actionTitle1: "Gửi lại OTP", actionTitle2: "Xác nhận", inputPlaceholder: "Nhập mã OTP", inputKeyboardType: .default, actionHandler1: { (_) in
                            self.getOPT(sdt: self.tfPhone.text ?? "")
                            
                        }, actionHandler2: { (otpString) in
                            if otpString == "" {
                                Toast(text: "Bạn chưa nhập OTP!").show()
                                return
                            }
                            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                                MPOSAPIManager.VTGetSimInfoByPhoneNumber(isdn: self.tfPhone.text ?? "", handler: { (results, message) in
                                    
                                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                                        if results != nil {
                                            self.sim = results!
                                            
                                            let newVC = ChangeSimViewController()
                                            newVC.sim = results!
                                            newVC.otpString = otpString ?? ""
                                            newVC.isOtp = 1
                                            newVC.listProvinces = self.listProvinces
                                            newVC.phone = self.tfPhone.text ?? ""
                                            newVC.cmndNumber = self.tfCMND.text ?? ""
                                            self.navigationController?.pushViewController(newVC, animated: true)
                                            
                                        } else {
                                            self.showMessage(title: "Thông báo", message: message)
                                        }
                                    }
                                })
                                ////--------
                                
                            }
                        })
                    } else {
                        self.showMessage(title: "Thông báo", message: message)
                    }
                }
            })
        }
    }
    
    func getListCustomer() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.VTGetListCustomerByIsdnErp(Isdn: self.tfPhone.text ?? "", idNo: self.tfCMND.text ?? "", handler: { (arrCustomerResults, message) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if arrCustomerResults.count > 0 {
                        self.listCustomerInfo.removeAll()
                        for item in arrCustomerResults {
                            self.listCustomerInfo.append(item)
                            
                        }
                        MPOSAPIManager.VTGetSimInfoByPhoneNumber(isdn: self.tfPhone.text ?? "", handler: { (results, message) in
                            
                            WaitingNetworkResponseAlert.DismissWaitingAlert {
                                if results != nil {
                                    self.sim = results!
                                    
                                    let newViewController = ListCustomerInfoViewController()
                                    newViewController.listCustomerInfo = self.listCustomerInfo
                                    newViewController.phone = self.tfPhone.text ?? ""
                                    newViewController.cmndNumber = self.tfCMND.text ?? ""
                                    //                                        newViewController.sim = self.sim!
                                    newViewController.sim = results!
                                    newViewController.listProvinces = self.listProvinces
                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                    
                                } else {
                                    self.showMessage(title: "Thông báo", message: message)
                                }
                            }
                        })
                        
                    } else {
                        self.showMessage(title: "Thông báo", message: message)
                    }
                }
            })
        }
        
    }
    
    func showMessage(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func getListProvince() {
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.GetProvincesSim(NhaMang: "Viettel") { (listProvince, error) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if listProvince.count > 0 {
                        for item in listProvince {
                            self.listProvinces.append(item)
                        }
                    } else {
                        debugPrint("k co ds province")
                    }
                }
                
            }
        }
    }
}
