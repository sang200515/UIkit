//
//  SenderInfoUpdateViewController.swift
//  fptshop
//
//  Created by Apple on 5/9/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class SenderInfoUpdateViewController: UIViewController {
    
    //    var senderAddess = ""
    var senderPhone = ""
    var senderObj:BillLoadDiaChiGui?
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var tfAddress: UITextField!
    var tfPhoneNumber: UITextField!
    var btnSenderUpdate: UIButton!
    var tfQuanHuyen: iOSDropDown!
    var tfTinhTp: iOSDropDown!
    
    var listQuanHuyen:[BillLoadQuanHuyen] = []
    var listTinhTp:[BillLoadTinhThanhPho] = []
    var listTinhTpName:[String] = []
    var listQuanHuyenName:[String] = []
    
    var selectedQuanHuyen:BillLoadQuanHuyen?
    var selectedTinhTp:BillLoadTinhThanhPho?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cập nhật thông tin người gửi"
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationItem.hidesBackButton = true
        let backView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:30), height: Common.Size(s:50))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: backView)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        backView.addSubview(btBackIcon)
        
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            mCallLogApiManager.Bill__LoadQuanHuyen(handler: { (resultsQuanHuyen, err) in
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if resultsQuanHuyen.count > 0 {
                        for item in resultsQuanHuyen {
                            self.listQuanHuyen.append(item)
                            self.listQuanHuyenName.append(item.Name)
                        }
                    } else {
                        debugPrint("Không lấy được danh sách listQuanHuyen")
                    }
                }
                
                mCallLogApiManager.Bill__LoadTinhThanhPho(handler: { (resultsTinh, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if resultsTinh.count > 0 {
                            for item in resultsTinh {
                                self.listTinhTp.append(item)
                                self.listTinhTpName.append(item.Name)
                            }
                        } else {
                            debugPrint("Không lấy được danh sách listTinhTpName")
                        }
                        
                        self.setUpView()
                    }
                })
                
            })
        }
    }
    
    func setUpView() {
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let lblAddress = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lblAddress.text = "Địa chỉ gửi:"
        lblAddress.font = UIFont.systemFont(ofSize: 13)
        lblAddress.textColor = UIColor.lightGray
        scrollView.addSubview(lblAddress)
        
        tfAddress = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblAddress.frame.origin.y + lblAddress.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 30)))
        tfAddress.borderStyle = .roundedRect
        tfAddress.font = UIFont.systemFont(ofSize: 13)
        tfAddress.text = self.senderObj?.Address ?? ""
        scrollView.addSubview(tfAddress)
        tfAddress.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        let lblQuanHuyen = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfAddress.frame.origin.y + tfAddress.frame.height + Common.Size(s: 10), width: lblAddress.frame.width, height: Common.Size(s: 15)))
        lblQuanHuyen.text = "Quận/Huyện:"
        lblQuanHuyen.font = UIFont.systemFont(ofSize: 13)
        lblQuanHuyen.textColor = UIColor.lightGray
        scrollView.addSubview(lblQuanHuyen)
        
        tfQuanHuyen = iOSDropDown(frame: CGRect(x: Common.Size(s: 15), y: lblQuanHuyen.frame.origin.y + lblQuanHuyen.frame.height + Common.Size(s: 5), width: tfAddress.frame.width, height: Common.Size(s: 30)))
        tfQuanHuyen.borderStyle = .roundedRect
        tfQuanHuyen.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(tfQuanHuyen)
        tfQuanHuyen.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        self.setUpListQuanHuyen()
        self.tfQuanHuyen.text = self.senderObj?.TenHuyen ?? ""
        
        let arrowImgView1 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let arrowImg1 = UIImageView(frame: CGRect(x: -5, y: 0, width: 15, height: 15))
        arrowImg1.image = #imageLiteral(resourceName: "ArrowDown-1")
        arrowImgView1.addSubview(arrowImg1)
        tfQuanHuyen.rightViewMode = .always
        tfQuanHuyen.rightView = arrowImgView1
        
        
        let lblTinhTp = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfQuanHuyen.frame.origin.y + tfQuanHuyen.frame.height + Common.Size(s: 10), width: lblAddress.frame.width, height: Common.Size(s: 15)))
        lblTinhTp.text = "Tỉnh/Thành phố:"
        lblTinhTp.font = UIFont.systemFont(ofSize: 13)
        lblTinhTp.textColor = UIColor.lightGray
        scrollView.addSubview(lblTinhTp)
        
        tfTinhTp = iOSDropDown(frame: CGRect(x: Common.Size(s: 15), y: lblTinhTp.frame.origin.y + lblTinhTp.frame.height + Common.Size(s: 5), width: tfAddress.frame.width, height: Common.Size(s: 30)))
        tfTinhTp.borderStyle = .roundedRect
        tfTinhTp.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(tfTinhTp)
        tfTinhTp.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        self.setUpListTinhTp()
        self.tfTinhTp.text = self.senderObj?.TenTinh ?? ""
        
        
        let arrowImgView2 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let arrowImg2 = UIImageView(frame: CGRect(x: -5, y: 0, width: 15, height: 15))
        arrowImg2.image = #imageLiteral(resourceName: "ArrowDown-1")
        arrowImgView2.addSubview(arrowImg2)
        tfTinhTp.rightViewMode = .always
        tfTinhTp.rightView = arrowImgView2
        
        
        let lblSdt = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfTinhTp.frame.origin.y + tfTinhTp.frame.height + Common.Size(s: 10), width: lblAddress.frame.width, height: Common.Size(s: 15)))
        lblSdt.text = "SĐT người gửi:"
        lblSdt.font = UIFont.systemFont(ofSize: 13)
        lblSdt.textColor = UIColor.lightGray
        scrollView.addSubview(lblSdt)
        
        tfPhoneNumber = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblSdt.frame.origin.y + lblSdt.frame.height + Common.Size(s: 5), width: tfAddress.frame.width, height: Common.Size(s: 30)))
        tfPhoneNumber.borderStyle = .roundedRect
        tfPhoneNumber.font = UIFont.systemFont(ofSize: 13)
        tfPhoneNumber.text = self.senderPhone
        scrollView.addSubview(tfPhoneNumber)
        tfPhoneNumber.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        btnSenderUpdate = UIButton(frame: CGRect(x: Common.Size(s: 15), y: tfPhoneNumber.frame.origin.y +  tfPhoneNumber.frame.height + Common.Size(s: 20), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        btnSenderUpdate.setTitle("CẬP NHẬT", for: .normal)
        btnSenderUpdate.layer.cornerRadius = 5
        btnSenderUpdate.backgroundColor = UIColor(red: 34/255, green: 134/255, blue: 70/255, alpha: 1)
        scrollView.addSubview(btnSenderUpdate)
        btnSenderUpdate.addTarget(self, action: #selector(updateSenderInfo), for: .touchUpInside)
        
        scrollView.bringSubviewToFront(tfTinhTp)
        scrollView.bringSubviewToFront(tfQuanHuyen)
        
        scrollViewHeight = self.view.frame.height
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    func setUpListQuanHuyen() {
        if self.listQuanHuyenName.count > 0 {
            tfQuanHuyen.optionArray = listQuanHuyenName
            tfQuanHuyen.text = listQuanHuyenName[0]
            tfQuanHuyen.selectedRowColor = UIColor.lightText
            tfQuanHuyen.didSelect { (selectedText , index ,id) in
                self.tfQuanHuyen.text = "\(selectedText)"
            }
        }
    }
    
    func setUpListTinhTp() {
        if self.listTinhTpName.count > 0 {
            tfTinhTp.optionArray = listTinhTpName
            //            tfTinhTp.text = listTinhTpName[0]
            tfTinhTp.selectedRowColor = UIColor.lightText
            tfTinhTp.didSelect { (selectedText , index ,id) in
                self.tfTinhTp.text = "\(selectedText)"
                
            }
        }
    }
    
    @objc func updateSenderInfo() {
        
        guard let address = self.tfAddress.text, !address.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập địa chỉ!")
            return
        }
        guard let quanHuyen = self.tfQuanHuyen.text, !quanHuyen.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa chọn quận/huyện!")
            return
        }
        guard let tinhTp = self.tfTinhTp.text, !tinhTp.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa chọn tỉnh/Tp!")
            return
        }
        guard let sdt = self.tfPhoneNumber.text, !sdt.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập số điện thoại!")
            return
        }
        
        for item in self.listQuanHuyen {
            if item.Name == self.tfQuanHuyen.text {
                self.selectedQuanHuyen = item
            }
        }
        
        for item in self.listTinhTp {
            if item.Name == self.tfTinhTp.text {
                self.selectedTinhTp = item
            }
        }
        
        if selectedQuanHuyen?.IDCity != selectedTinhTp?.ID {
            self.showAlert(title: "Thông báo", message: "Quận/Huyện không thuộc Tỉnh/Thành phố này.\nVui lòng cập nhật lại!")
        }
        
        let dictionaryValue = ["address": address, "quanHuyenName": selectedQuanHuyen?.Name ?? "", "quanHuyenCode": "\(selectedQuanHuyen?.ID ?? 0)", "tinhTpName": selectedTinhTp?.Name ?? "", "tinhTpCode": "\(selectedTinhTp?.ID ?? 0)", "sdt":sdt] as [String : Any]
        
        NotificationCenter.default.post(name: NSNotification.Name.init("didUpdateSenderInfo"), object: nil, userInfo: dictionaryValue)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.endEditing(true)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight + Common.Size(s: 65) + Common.Size(s: 10))
    }
    
}
