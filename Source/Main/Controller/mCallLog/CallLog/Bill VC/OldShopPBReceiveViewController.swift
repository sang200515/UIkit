//
//  ReceiverInfoUpdateViewController.swift
//  fptshop
//
//  Created by Apple on 5/9/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol OldShopPBReceiveViewControllerDelegate: AnyObject {
    func updateReceiver(shopName: String, address: String, quanHuyen: String, tinhTp: String, sdt: String)
}

class OldShopPBReceiveViewController: UIViewController {
    
    var parentNavigationController : UINavigationController?
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var receiverPhone = ""
    var receiverShopName = ""
    var receiverFullName = ""
    var tfReceiverShopText: iOSDropDown!
    var tfReceiverAddressText: UITextField!
    var tfQuanHuyen: iOSDropDown!
    var tfTinhTp: iOSDropDown!
    var tfPhoneNumber: UITextField!
    var tfFullName: UITextField!
    var btnReceiverUpdate: UIButton!
    
    
    var listShopPhongBan:[BillLoadShopPhongBan] = []
    var listQuanHuyen:[BillLoadQuanHuyen] = []
    var listTinhTp:[BillLoadTinhThanhPho] = []
    var listShopPBName:[String] = []
    var listTinhTpName:[String] = []
    var listQuanHuyenName:[String] = []
    
    var selectedPB:BillLoadShopPhongBan?
    var selectedQuanHuyen:BillLoadQuanHuyen?
    var selectedTinhTp:BillLoadTinhThanhPho?
    
    var receiveObj:BillLoadDiaChiNhan?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.initNavigationBar()
        self.title = "Shop/PB nhận"
        self.view.backgroundColor = UIColor.white
        
        self.loadShopPB()
        self.loadQuanHuyen()
        self.loadTinhTp()
        
        self.setUpView()
        
    }
    
    func setUpListShopPB() {
        if self.listShopPBName.count > 0 {
            tfReceiverShopText.optionArray = listShopPBName
            tfReceiverShopText.selectedRowColor = UIColor.lightText
            tfReceiverShopText.didSelect { (selectedText , index ,id) in
                self.tfReceiverShopText.text = "\(selectedText)"
                
                for item in self.listShopPhongBan {
                    if item.FullName == selectedText {
                        self.selectedPB = item
                    }
                }
                
                var maPB = ""
                for item in self.listShopPhongBan {
                    if item.FullName == selectedText {
                        maPB = item.Code
                    }
                }
                self.loadDiaChiNhan(maPB: maPB)
            }
        }
    }
    
    func setUpListQuanHuyen() {
        if self.listQuanHuyenName.count > 0 {
            tfQuanHuyen.optionArray = listQuanHuyenName
            tfQuanHuyen.selectedRowColor = UIColor.lightText
            tfQuanHuyen.didSelect { (selectedText , index ,id) in
                self.tfQuanHuyen.text = "\(selectedText)"
            }
        }
    }
    
    func setUpListTinhTp() {
        if self.listTinhTpName.count > 0 {
            tfTinhTp.optionArray = listTinhTpName
            tfTinhTp.selectedRowColor = UIColor.lightText
            tfTinhTp.didSelect { (selectedText , index ,id) in
                self.tfTinhTp.text = "\(selectedText)"
            }
        }
    }
    
    
    func setUpView() {
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let lblReceiverShop = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lblReceiverShop.text = "Shop/PB nhận:"
        lblReceiverShop.font = UIFont.systemFont(ofSize: 13)
        lblReceiverShop.textColor = UIColor.lightGray
        scrollView.addSubview(lblReceiverShop)
        
        
        tfReceiverShopText = iOSDropDown(frame: CGRect(x: Common.Size(s: 15), y: lblReceiverShop.frame.origin.y + lblReceiverShop.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 30)))
        tfReceiverShopText.borderStyle = .roundedRect
        tfReceiverShopText.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(tfReceiverShopText)
        tfReceiverShopText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        let arrowImgView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let arrowImg = UIImageView(frame: CGRect(x: -5, y: 0, width: 15, height: 15))
        arrowImg.image = #imageLiteral(resourceName: "ArrowDown-1")
        arrowImgView.addSubview(arrowImg)
        tfReceiverShopText.rightViewMode = .always
        tfReceiverShopText.rightView = arrowImgView
        
        let lblReceiverAddress = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfReceiverShopText.frame.origin.y + tfReceiverShopText.frame.height + Common.Size(s: 10), width: lblReceiverShop.frame.width, height: Common.Size(s: 15)))
        lblReceiverAddress.text = "Địa chỉ nhận:"
        lblReceiverAddress.font = UIFont.systemFont(ofSize: 13)
        lblReceiverAddress.textColor = UIColor.lightGray
        scrollView.addSubview(lblReceiverAddress)
        
        tfReceiverAddressText = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblReceiverAddress.frame.origin.y + lblReceiverAddress.frame.height + Common.Size(s: 5), width: tfReceiverShopText.frame.width, height: Common.Size(s: 30)))
        tfReceiverAddressText.borderStyle = .roundedRect
        tfReceiverAddressText.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(tfReceiverAddressText)
        tfReceiverAddressText.text = self.receiveObj?.Address
        tfReceiverAddressText.isEnabled = false
        
        let lblQuanHuyen = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfReceiverAddressText.frame.origin.y + tfReceiverAddressText.frame.height + Common.Size(s: 10), width: lblReceiverShop.frame.width, height: Common.Size(s: 15)))
        lblQuanHuyen.text = "Quận/Huyện:"
        lblQuanHuyen.font = UIFont.systemFont(ofSize: 13)
        lblQuanHuyen.textColor = UIColor.lightGray
        scrollView.addSubview(lblQuanHuyen)
        
        tfQuanHuyen = iOSDropDown(frame: CGRect(x: Common.Size(s: 15), y: lblQuanHuyen.frame.origin.y + lblQuanHuyen.frame.height + Common.Size(s: 5), width: tfReceiverShopText.frame.width, height: Common.Size(s: 30)))
        tfQuanHuyen.borderStyle = .roundedRect
        tfQuanHuyen.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(tfQuanHuyen)
        tfQuanHuyen.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        self.tfQuanHuyen.text = self.receiveObj?.TenHuyen ?? ""
        
        let arrowImgView1 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let arrowImg1 = UIImageView(frame: CGRect(x: -5, y: 0, width: 15, height: 15))
        arrowImg1.image = #imageLiteral(resourceName: "ArrowDown-1")
        arrowImgView1.addSubview(arrowImg1)
        tfQuanHuyen.rightViewMode = .always
        tfQuanHuyen.rightView = arrowImgView1
        
        let lblTinhTp = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfQuanHuyen.frame.origin.y + tfQuanHuyen.frame.height + Common.Size(s: 10), width: lblReceiverShop.frame.width, height: Common.Size(s: 15)))
        lblTinhTp.text = "Tỉnh/Thành phố:"
        lblTinhTp.font = UIFont.systemFont(ofSize: 13)
        lblTinhTp.textColor = UIColor.lightGray
        scrollView.addSubview(lblTinhTp)
        
        tfTinhTp = iOSDropDown(frame: CGRect(x: Common.Size(s: 15), y: lblTinhTp.frame.origin.y + lblTinhTp.frame.height + Common.Size(s: 5), width: tfReceiverShopText.frame.width, height: Common.Size(s: 30)))
        tfTinhTp.borderStyle = .roundedRect
        tfTinhTp.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(tfTinhTp)
        tfTinhTp.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        self.tfTinhTp.text = self.receiveObj?.TenTinh ?? ""
        
        let arrowImgView2 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let arrowImg2 = UIImageView(frame: CGRect(x: -5, y: 0, width: 15, height: 15))
        arrowImg2.image = #imageLiteral(resourceName: "ArrowDown-1")
        arrowImgView2.addSubview(arrowImg2)
        tfTinhTp.rightViewMode = .always
        tfTinhTp.rightView = arrowImgView2
        
        let lblFullName = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfTinhTp.frame.origin.y + tfTinhTp.frame.height + Common.Size(s: 10), width: lblReceiverShop.frame.width, height: Common.Size(s: 15)))
        lblFullName.text = "Họ tên người nhận:"
        lblFullName.font = UIFont.systemFont(ofSize: 13)
        lblFullName.textColor = UIColor.lightGray
        scrollView.addSubview(lblFullName)
        
        tfFullName = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblFullName.frame.origin.y + lblFullName.frame.height + Common.Size(s: 5), width: tfReceiverShopText.frame.width, height: Common.Size(s: 30)))
        tfFullName.borderStyle = .roundedRect
        tfFullName.font = UIFont.systemFont(ofSize: 13)
        tfFullName.text = self.receiverFullName
        tfFullName.clearButtonMode = UITextField.ViewMode.whileEditing
        scrollView.addSubview(tfFullName)
        tfFullName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        let lblSdt = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfFullName.frame.origin.y + tfFullName.frame.height + Common.Size(s: 10), width: lblReceiverShop.frame.width, height: Common.Size(s: 15)))
        lblSdt.text = "SĐT người nhận:"
        lblSdt.font = UIFont.systemFont(ofSize: 13)
        lblSdt.textColor = UIColor.lightGray
        scrollView.addSubview(lblSdt)
        
        tfPhoneNumber = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lblSdt.frame.origin.y + lblSdt.frame.height + Common.Size(s: 5), width: tfReceiverShopText.frame.width, height: Common.Size(s: 30)))
        tfPhoneNumber.borderStyle = .roundedRect
        tfPhoneNumber.font = UIFont.systemFont(ofSize: 13)
        tfPhoneNumber.text = self.receiverPhone
        tfPhoneNumber.keyboardType = .numberPad
        tfPhoneNumber.clearButtonMode = UITextField.ViewMode.whileEditing
        scrollView.addSubview(tfPhoneNumber)
        tfPhoneNumber.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        btnReceiverUpdate = UIButton(frame: CGRect(x: Common.Size(s: 15), y: tfPhoneNumber.frame.origin.y +  tfPhoneNumber.frame.height + Common.Size(s: 20), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        btnReceiverUpdate.setTitle("CẬP NHẬT", for: .normal)
        btnReceiverUpdate.layer.cornerRadius = 5
        btnReceiverUpdate.backgroundColor = UIColor(red: 34/255, green: 134/255, blue: 70/255, alpha: 1)
        scrollView.addSubview(btnReceiverUpdate)
        btnReceiverUpdate.addTarget(self, action: #selector(updateReceiverInfo), for: .touchUpInside)
        
        //setUpListShopPB
        self.setUpListShopPB()
        if self.receiverShopName == "" {
            self.tfReceiverShopText.text = self.listShopPBName[0]
        } else {
            self.tfReceiverShopText.text = self.receiverShopName
        }
        self.setUpListQuanHuyen()
        self.setUpListTinhTp()
        
        scrollView.bringSubviewToFront(tfTinhTp)
        scrollView.bringSubviewToFront(tfQuanHuyen)
        scrollView.bringSubviewToFront(tfReceiverShopText)
        
        scrollViewHeight = self.view.frame.height
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)

    }
    
    @objc func updateReceiverInfo() {
        guard let shopName = self.tfReceiverShopText.text, !shopName.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa chọn Shop/PB!")
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
        guard let fullName = self.tfFullName.text, !fullName.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập họ tên người nhận!")
            return
        }
        guard let sdt = self.tfPhoneNumber.text, !sdt.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập số điện thoại!")
            return
        }
        
        for item in self.listQuanHuyen {
            if item.Name == self.tfQuanHuyen.text {
                //                self.maHuyenNhan = "\(item.ID )"
                self.selectedQuanHuyen = item
            }
        }
        
        for item in self.listTinhTp {
            if item.Name == self.tfTinhTp.text {
                //                self.matinhNhan = "\(item.ID )"
                self.selectedTinhTp = item
            }
        }
        
        if selectedQuanHuyen?.IDCity != selectedTinhTp?.ID {
            self.showAlert(title: "Thông báo", message: "Quận/Huyện không thuộc Tỉnh/Thành phố này.\nVui lòng cập nhật lại!")
        } else {
            let dictionaryValue = ["shopName": shopName, "shopReceiverCode": self.selectedPB?.Code ?? "", "address": self.tfReceiverAddressText.text ?? "", "quanHuyenName": quanHuyen, "quanHuyenCode": "\(selectedQuanHuyen?.ID ?? 0)", "tinhTpName": tinhTp, "tinhTpCode": "\(selectedTinhTp?.ID ?? 0)", "hoTen":fullName, "sdt":sdt] as [String : Any]
            
            NotificationCenter.default.post(name: NSNotification.Name.init("didUpdateOldReceiverInfo"), object: nil, userInfo: dictionaryValue)
            
            self.parentNavigationController?.popViewController(animated: true)
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
    
    func loadShopPB() {
        if self.listShopPhongBan.count > 0 {
            for item in self.listShopPhongBan {
                self.listShopPBName.append(item.FullName )
            }
        } else {
            debugPrint("Không lấy được danh sách listShopPhongBan")
        }
    }
    
    func loadQuanHuyen() {
        if self.listQuanHuyen.count > 0 {
            for item in self.listQuanHuyen {
                self.listQuanHuyenName.append(item.Name )
            }
        } else {
            debugPrint("Không lấy được listQuanHuyen")
        }
    }
    
    func loadTinhTp() {
        if self.listTinhTp.count > 0 {
            for item in self.listTinhTp {
                self.listTinhTpName.append(item.Name )
            }
        } else {
            debugPrint("Không lấy được listTinhTp")
        }
    }
    
    func loadDiaChiNhan(maPB: String) {
        
        mCallLogApiManager.Bill__LoadDiaChiNhan(p_MaShopPhongBan: maPB) { (results, err) in
            if results.count > 0 {
                self.receiveObj = results[0]
                
                self.tfReceiverAddressText.text = " \(results[0].Address)"
                self.tfPhoneNumber.text = " \(results[0].SoDienThoaiNguoiNhan)"
                self.tfFullName.text = " \(results[0].HoTenNguoiNhan)"
                self.tfQuanHuyen.text = " \(results[0].TenHuyen)"
                self.tfTinhTp.text = " \(results[0].TenTinh)"
                for item in self.listQuanHuyen {
                    if item.Name == results[0].TenHuyen {
                        self.selectedQuanHuyen = item
                    }
                }
                
                for item in self.listTinhTp {
                    if item.Name == results[0].TenTinh {
                        self.selectedTinhTp = item
                    }
                }
            } else {
                debugPrint("Không lấy được DiaChiNhan")
                self.tfReceiverAddressText.text = ""
                self.tfFullName.text = ""
                self.tfPhoneNumber.text = ""
                self.tfQuanHuyen.text = ""
                self.tfTinhTp.text = ""
            }
            
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.endEditing(true)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight + Common.Size(s: 65) + Common.Size(s: 10))
    }
    
}



