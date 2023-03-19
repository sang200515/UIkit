//
//  RegisterCheckinViewController.swift
//  CheckIn
//
//  Created by Apple on 1/18/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class RegisterCheckinViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var tfVendor: iOSDropDown!
    var tfFullName: UITextField!
    var tfCMND: UITextField!
    var tfPhone: UITextField!
    var tfBirthYear: UITextField!
    var tfPassword: UITextField!
    var tfEmail: UITextField!
    var btnRegister: UIButton!
    var vendors = [Vendor]()
    var vendorListName = [String]()
    var vendorListCode = [Int]()
    var vendorCode: String?
    //bo sung PG
    var tfQlyPGName: UITextField!
    var tfPGCode: UITextField!
    var tfPositionName: iOSDropDown!
    var scrollViewHeight: CGFloat = 0
    var arrPGPosition: [String] = ["Fix", "Cover FPT", "Cover khác"]
    
    var cmndString = ""
    let PASSWORD_PATTERN = "((?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{6,20})"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = " Đăng ký PG"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        let backView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:30), height: Common.Size(s:50))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: backView)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        backView.addSubview(btBackIcon)
        self.view.backgroundColor = UIColor.white
        
        //----
        getListVendors()
        setUpView()
        tfVendor.isSearchEnable = false
        tfPositionName.isSearchEnable = false
        
        tfFullName.delegate = self
        tfCMND.delegate = self
        tfPhone.delegate = self
        tfPassword.delegate = self
        tfBirthYear.delegate = self
        tfQlyPGName.delegate = self
        tfPGCode.delegate = self
        ///
        if !cmndString.isEmpty {
            tfCMND.text = cmndString
            tfCMND.isEnabled = false
        } else {
            tfCMND.text = ""
            tfCMND.isEnabled = true
        }
        
        tfCMND.keyboardType = .numberPad
        tfPhone.keyboardType = .numberPad
        tfBirthYear.keyboardType = .numberPad
        //
        tfFullName.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhone.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPassword.clearButtonMode = UITextField.ViewMode.whileEditing
        tfBirthYear.clearButtonMode = UITextField.ViewMode.whileEditing
        tfQlyPGName.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPGCode.clearButtonMode = UITextField.ViewMode.whileEditing
    }
    
    
    func setUpVendorList() {
        if self.vendors.count > 0 {
            for vendor in vendors {
                self.vendorListName.append(vendor.VendorName)
                self.vendorListCode.append(Int(vendor.VendorCode)!)
            }
            //----
            tfVendor.optionArray = vendorListName
            tfVendor.optionIds = vendorListCode
            tfVendor.didSelect { (selectedText , index ,id) in
                self.tfVendor.text = "\(selectedText)"
            }
        }
    }
    
    func setUpPGPositionList() {
        tfPositionName.optionArray = arrPGPosition
        tfVendor.didSelect { (selectedText , index ,id) in
            self.tfVendor.text = "\(selectedText)"
        }
    }
    
    func setUpView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        //doi tac
        let lblPartner = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:15), width: self.view.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:20)))
        lblPartner.text = "Đối tác"
        lblPartner.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lblPartner)
        
        tfVendor = iOSDropDown(frame: CGRect(x: Common.Size(s:15), y: lblPartner.frame.origin.y + lblPartner.frame.height, width: scrollView.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:35)))
        tfVendor.borderStyle = .roundedRect
        
        let imgVenderArrow = UIImageView(frame: CGRect(x: Common.Size(s: 0), y: Common.Size(s: 15), width: Common.Size(s: 10), height: Common.Size(s: 10)))
        imgVenderArrow.image = #imageLiteral(resourceName: "ArrowDown-1")
        tfVendor.rightViewMode = .always
        tfVendor.rightView = imgVenderArrow
        
        //----Bo sung PG register
        
        //ho ten
        let lblName = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfVendor.frame.origin.y + tfVendor.frame.height + Common.Size(s:10), width: scrollView.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:20)))
        lblName.text = "Họ tên"
        lblName.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lblName)
        
        tfFullName = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblName.frame.origin.y + lblName.frame.height, width: scrollView.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:35)))
        tfFullName.borderStyle = .roundedRect
        scrollView.addSubview(tfFullName)
        tfFullName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        tfFullName.placeholder = "Nhập họ và tên"
        
        
        /// ho ten quan ly PG
        let lbQlyPG = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfFullName.frame.origin.y + tfFullName.frame.height + Common.Size(s:10), width: self.view.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:20)))
        lbQlyPG.text = "Họ tên quản lý PG"
        lbQlyPG.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lbQlyPG)
        
        tfQlyPGName = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbQlyPG.frame.origin.y + lbQlyPG.frame.height, width: self.view.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:35)))
        tfQlyPGName.borderStyle = .roundedRect
        scrollView.addSubview(tfQlyPGName)
        tfQlyPGName.placeholder = "Nhập họ và tên quản lý PG"
        
        
        /// MA PG
        let lbMaPG = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfQlyPGName.frame.origin.y + tfQlyPGName.frame.height + Common.Size(s:10), width: self.view.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:20)))
        lbMaPG.text = "Mã PG"
        lbMaPG.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lbMaPG)
        
        tfPGCode = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbMaPG.frame.origin.y + lbMaPG.frame.height, width: self.view.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:35)))
        tfPGCode.borderStyle = .roundedRect
        scrollView.addSubview(tfPGCode)
        
        tfPGCode.placeholder = "Nhập mã PG"
        
        /// chức danh
        let lbChucDanh = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPGCode.frame.origin.y + tfPGCode.frame.height + Common.Size(s:10), width: self.view.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:20)))
        lbChucDanh.text = "Chức danh"
        lbChucDanh.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lbChucDanh)
        
        tfPositionName = iOSDropDown(frame: CGRect(x: Common.Size(s:15), y: lbChucDanh.frame.origin.y + lbChucDanh.frame.height, width: self.view.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:35)))
        tfPositionName.borderStyle = .roundedRect
        setUpPGPositionList()
        
        
        let imgPositionArrow = UIImageView(frame: CGRect(x: Common.Size(s: 0), y: Common.Size(s: 20), width: Common.Size(s: 10), height: Common.Size(s: 10)))
        imgPositionArrow.image = #imageLiteral(resourceName: "ArrowDown-1")
        tfPositionName.rightViewMode = .always
        tfPositionName.rightView = imgPositionArrow
        
        //cmnd
        let lblCmnd = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPositionName.frame.origin.y + tfPositionName.frame.height + Common.Size(s:10), width: scrollView.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:20)))
        lblCmnd.text = "CMND"
        lblCmnd.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lblCmnd)
        
        tfCMND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblCmnd.frame.origin.y + lblCmnd.frame.height, width: scrollView.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:35)))
        tfCMND.borderStyle = .roundedRect
        scrollView.addSubview(tfCMND)
        
        
        //sdt
        let lblPhone = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfCMND.frame.origin.y + tfCMND.frame.height + Common.Size(s:10), width: scrollView.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:20)))
        lblPhone.text = "Số điện thoại"
        lblPhone.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lblPhone)
        
        tfPhone = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblPhone.frame.origin.y + lblPhone.frame.height, width: scrollView.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:35)))
        tfPhone.borderStyle = .roundedRect
        scrollView.addSubview(tfPhone)
        tfPhone.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        tfPhone.placeholder = "Nhập số điện thoại"
        
        //email
        let lblEmail = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhone.frame.origin.y + tfPhone.frame.height + Common.Size(s:10), width: scrollView.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:20)))
        lblEmail.text = "Email"
        lblEmail.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lblEmail)
        
        tfEmail = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblEmail.frame.origin.y + lblEmail.frame.height, width: scrollView.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:35)))
        tfEmail.borderStyle = .roundedRect
        scrollView.addSubview(tfEmail)
        tfEmail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        tfEmail.placeholder = "Nhập email"
        
        //nam sinh
        let lblBirthYear = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfEmail.frame.origin.y + tfEmail.frame.height + Common.Size(s:10), width: scrollView.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:20)))
        lblBirthYear.text = "Năm sinh"
        lblBirthYear.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lblBirthYear)
        
        tfBirthYear = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblBirthYear.frame.origin.y + lblBirthYear.frame.height, width: scrollView.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:35)))
        tfBirthYear.borderStyle = .roundedRect
        scrollView.addSubview(tfBirthYear)
        tfBirthYear.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        tfBirthYear.placeholder = "Nhập năm sinh"
        //mat khau
        let lblPassword = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfBirthYear.frame.origin.y + tfBirthYear.frame.height + Common.Size(s:10), width: scrollView.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:20)))
        lblPassword.text = "Mật khẩu"
        lblPassword.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lblPassword)
        
        tfPassword = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblPassword.frame.origin.y + lblPassword.frame.height, width: scrollView.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:35)))
        tfPassword.borderStyle = .roundedRect
        tfPassword.isSecureTextEntry = true
        scrollView.addSubview(tfPassword)
        tfPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        tfPassword.placeholder = "Nhập mật khẩu"
        //btn dang ki
        btnRegister = UIButton(frame: CGRect(x: Common.Size(s:15), y: tfPassword.frame.origin.y + tfPassword.frame.height + Common.Size(s:20), width: scrollView.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:35)))
        btnRegister.backgroundColor = UIColor(red: 44/255, green: 171/255, blue: 110/255, alpha: 1)
        btnRegister.setTitle("ĐĂNG KÝ", for: .normal)
        btnRegister.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btnRegister.titleLabel?.textColor = UIColor.white
        btnRegister.layer.cornerRadius = 5
        scrollView.addSubview(btnRegister)
        btnRegister.addTarget(self, action: #selector(registerCheckin), for: .touchUpInside)
        scrollView.addSubview(tfVendor)
        scrollView.addSubview(tfPositionName)
        
        scrollViewHeight = btnRegister.frame.origin.y + btnRegister.frame.height + Common.Size(s: 100)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    func getListVendors(){
        MPOSAPIManager.getListVendors { (vendorList, error) in
            guard vendorList != nil else {
                self.showAlert(title: "Thông báo", message: "Không lấy được danh sách đối tác!")
                return
            }
            
            if vendorList?.Code == "001" {
                if vendorList?.mdata != nil {
                    self.vendors = (vendorList?.mdata)!
                    debugPrint(self.vendors.count)
                    self.setUpVendorList()
                } else {
                    self.showAlert(title: "Thông báo", message: "Không lấy được danh sách đối tác!")
                }
            } else {
                let message = vendorList?.Detail
                self.showAlert(title: "Thông báo", message: "\(message ?? "Không lấy được danh sách đối tác")!")
            }
        }
        
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
        //            self.dismiss(animated: true, completion: nil)
        //        }
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func registerCheckin() {
        guard let vendor = tfVendor.text, !vendor.isEmpty else {
            showAlert(title: "Thông báo", message: "Bạn chưa chọn đối tác!")
            return
        }
        
        guard let name = tfFullName.text, !name.isEmpty else {
            showAlert(title: "Thông báo", message: "Bạn chưa nhập Họ tên!")
            return
        }
        
        //bo sung PG
        guard let pgManagerName = tfQlyPGName.text, !pgManagerName.isEmpty else {
            showAlert(title: "Thông báo", message: "Bạn chưa nhập Họ tên quản lý PG!")
            return
        }
        guard let pgCode = tfPGCode.text, !pgCode.isEmpty else {
            showAlert(title: "Thông báo", message: "Bạn chưa nhập mã PG!")
            return
        }
        
        guard let pgPosition = tfPositionName.text, !pgPosition.isEmpty else {
            showAlert(title: "Thông báo", message: "Bạn chưa chọn chức danh!")
            return
        }
        //------
        
        guard let cmnd = tfCMND.text, !cmnd.isEmpty else {
            showAlert(title: "Thông báo", message: "Bạn chưa nhập CMND!")
            return
        }
        
        guard let sdt = tfPhone.text, !sdt.isEmpty else {
            showAlert(title: "Thông báo", message: "Bạn chưa nhập Số điện thoại!")
            return
        }
        
        guard sdt.count == 10, isNumber(string: sdt) == true else {
            showAlert(title: "Thông báo", message: "Số điện thoại không hợp lệ!")
            return
        }
        
        guard let email = tfEmail.text, !email.isEmpty else {
            showAlert(title: "Thông báo", message: "Bạn chưa nhập Email!")
            return
        }
        
        guard isValidEmail(testStr: email) == true else {
            showAlert(title: "Thông báo", message: "Vui lòng nhập đúng định dạng Email!")
            return
        }
        
        guard let birthYear = tfBirthYear.text, !birthYear.isEmpty else {
            showAlert(title: "Thông báo", message: "Bạn chưa nhập Năm sinh!")
            return
        }
        
        guard let birthYearInt = Int(birthYear), birthYearInt > 1900, birthYearInt < 2019 else {
            showAlert(title: "Thông báo", message: "Năm sinh không hợp lệ!")
            return
        }
        
        if let password = tfPassword.text {
            if password.isEmpty {
                showAlert(title: "Thông báo", message: "Bạn chưa nhập Mật khẩu!")
                return
            } else if isValidPassword(testStr: password) == false {
                showAlert(title: "Thông báo", message: "Mật khẩu phải có ít nhất 6 ký tự, chữ hoa, chữ thường, ký tự số và ký tự đặc biệt!")
                return
            }
        }
        
        for ven in self.vendors {
            if vendor == ven.VendorName {
                self.vendorCode = ven.VendorCode
            }
        }
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            MPOSAPIManager.register(name: name, birthYear: Int(birthYear)!, idCard: cmnd, phone: sdt, vender: self.vendorCode ?? "", password: self.tfPassword.text ?? "", userCreate: "\(Cache.user!.UserName)", jobtitleName: pgPosition, leaderPG: pgManagerName, pgCode: pgCode, email: email, isReg: 1) { (pgInfo, detail, Code)  in
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if Code == "001" {
                        if pgInfo != nil {
                            let alertVC = UIAlertController(title: "Thông báo", message: "Đăng ký thành công!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
                                let checkInVC = CheckInViewController()
                                checkInVC.pgInfo = pgInfo
                                self.navigationController?.pushViewController(checkInVC, animated: true)
                            }
                            alertVC.addAction(action)
                            self.present(alertVC, animated: true, completion: nil)
                        } else {
                            self.showAlert(title: "Thông báo", message: "API Error")
                        }
                        
                    } else if Code == "002" {
                        self.showAlert(title: "Thông báo", message: "\(detail)")
                    } else if Code == "004" {
                        self.showAlert(title: "Thông báo", message: "\(detail)")
                    }
                }
                
            }
        }
        
        
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
        let pw = NSPredicate(format: "SELF MATCHES %@", PASSWORD_PATTERN)
        return pw.evaluate(with: testStr)
    }
    
    func isNumber(string: String) -> Bool{
        
        let numberCharacters = NSCharacterSet.decimalDigits.inverted
        if !string.isEmpty && string.rangeOfCharacter(from: numberCharacters) == nil {
            debugPrint("numstring toan so")
            return true
        } else {
            return false
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.endEditing(true)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
}

extension RegisterCheckinViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.endEditing(false)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight + Common.Size(s: 65) + Common.Size(s: 10))
        return true
    }
}
