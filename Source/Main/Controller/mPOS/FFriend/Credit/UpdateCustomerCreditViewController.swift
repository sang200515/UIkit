//
//  UpdateCustomerCreditViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/13/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import PopupDialog
class UpdateCustomerCreditViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    var scrollView:UIScrollView!
    var companyButton: SearchTextField!
    var branchCompanyButton: SearchTextField!
    var btCreateCredit:UILabel!
    var tfName:UITextField!
    var tfDateBirthday:UITextField!
    var tfPhone:UITextField!
    var tfBank:UITextField!
    var tfCMND:UITextField!
    var taskNotes: UITextView!
    var placeholderLabel : UILabel!
    
    var listCompany:[CompanyFFriend] = []
    var listBranchCompany:[CompanyFFriend] = []
    
    var vendorCode:String  = ""
    var branchCode:String  = ""
    
    var ocfdFFriend: OCRDFFriend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Cập nhật KH Credit"
        
        let lbTextType = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextType.textAlignment = .left
        lbTextType.textColor = UIColor.black
        lbTextType.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextType.text = "Loại khách hàng (*)"
        scrollView.addSubview(lbTextType)
        
        let lbType = UILabel(frame: CGRect(x: Common.Size(s:15), y:lbTextType.frame.size.height + lbTextType.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbType.textAlignment = .center
        lbType.textColor = UIColor.black
        lbType.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbType.text = "Credit"
        scrollView.addSubview(lbType)
        
        let lbTextCompany = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbType.frame.size.height + lbType.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCompany.textAlignment = .left
        lbTextCompany.textColor = UIColor.black
        lbTextCompany.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCompany.text = "Tên ngân hàng (*)"
        scrollView.addSubview(lbTextCompany)
        
        companyButton = SearchTextField(frame: CGRect(x: lbTextCompany.frame.origin.x, y: lbTextCompany.frame.origin.y + lbTextCompany.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        companyButton.placeholder = "Chọn tên ngân hàng"
        companyButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.borderStyle = UITextField.BorderStyle.roundedRect
        companyButton.autocorrectionType = UITextAutocorrectionType.no
        companyButton.keyboardType = UIKeyboardType.default
        companyButton.returnKeyType = UIReturnKeyType.done
        companyButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        companyButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        companyButton.delegate = self
        scrollView.addSubview(companyButton)
        companyButton.isEnabled = false
        
        companyButton.startVisible = true
        companyButton.theme.bgColor = UIColor.white
        companyButton.theme.fontColor = UIColor.black
        companyButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.theme.cellHeight = Common.Size(s:40)
        companyButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        
        let lbTextBranchCompany = UILabel(frame: CGRect(x: Common.Size(s:15), y: companyButton.frame.size.height + companyButton.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextBranchCompany.textAlignment = .left
        lbTextBranchCompany.textColor = UIColor.black
        lbTextBranchCompany.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextBranchCompany.text = "Tên công ty hiện tại"
        scrollView.addSubview(lbTextBranchCompany)
        
        branchCompanyButton = SearchTextField(frame: CGRect(x: lbTextBranchCompany.frame.origin.x, y: lbTextBranchCompany.frame.origin.y + lbTextCompany.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        branchCompanyButton.placeholder = "Chọn tên công ty"
        branchCompanyButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        branchCompanyButton.borderStyle = UITextField.BorderStyle.roundedRect
        branchCompanyButton.autocorrectionType = UITextAutocorrectionType.no
        branchCompanyButton.keyboardType = UIKeyboardType.default
        branchCompanyButton.returnKeyType = UIReturnKeyType.done
        branchCompanyButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        branchCompanyButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        branchCompanyButton.delegate = self
        scrollView.addSubview(branchCompanyButton)
        
        branchCompanyButton.startVisible = true
        branchCompanyButton.theme.bgColor = UIColor.white
        branchCompanyButton.theme.fontColor = UIColor.black
        branchCompanyButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        branchCompanyButton.theme.cellHeight = Common.Size(s:40)
        branchCompanyButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        let lbTextName = UILabel(frame: CGRect(x: Common.Size(s:15), y:branchCompanyButton.frame.size.height + branchCompanyButton.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextName.textAlignment = .left
        lbTextName.textColor = UIColor.black
        lbTextName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextName.text = "Tên khách hàng (*)"
        scrollView.addSubview(lbTextName)
        
        tfName = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextName.frame.size.height + lbTextName.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfName.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfName.borderStyle = UITextField.BorderStyle.roundedRect
        tfName.autocorrectionType = UITextAutocorrectionType.no
        tfName.keyboardType = UIKeyboardType.default
        tfName.returnKeyType = UIReturnKeyType.done
        tfName.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfName.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfName.delegate = self
        tfName.placeholder = "Ghi đầy đủ họ tên bằng Tiếng Việt có dấu"
        scrollView.addSubview(tfName)
        tfName.text = "\(ocfdFFriend!.CardName)"
        
        
        let lbTextPhone = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfName.frame.size.height + tfName.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhone.textAlignment = .left
        lbTextPhone.textColor = UIColor.black
        lbTextPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhone.text = "Số điện thoại (*)"
        scrollView.addSubview(lbTextPhone)
        
        if(ocfdFFriend!.SDT == ""){
            lbTextPhone.textColor = .red
        }
        
        tfPhone = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhone.frame.size.height + lbTextPhone.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfPhone.placeholder = ""
        tfPhone.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhone.autocorrectionType = UITextAutocorrectionType.no
        tfPhone.keyboardType = UIKeyboardType.numberPad
        tfPhone.returnKeyType = UIReturnKeyType.done
        tfPhone.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhone.delegate = self
        tfPhone.placeholder = "Nhập số điện thoại KH"
        scrollView.addSubview(tfPhone)
        tfPhone.text = "\(ocfdFFriend!.SDT)"
        
        
        let lbTextBank = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhone.frame.size.height + tfPhone.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextBank.textAlignment = .left
        lbTextBank.textColor = UIColor.black
        lbTextBank.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextBank.text = "Số thẻ ngân hàng (*)"
        scrollView.addSubview(lbTextBank)
        
        if(ocfdFFriend!.CreditCard == ""){
            lbTextBank.textColor = .red
        }
        
        tfBank = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextBank.frame.size.height + lbTextBank.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfBank.placeholder = ""
        tfBank.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfBank.borderStyle = UITextField.BorderStyle.roundedRect
        tfBank.autocorrectionType = UITextAutocorrectionType.no
        tfBank.keyboardType = UIKeyboardType.numberPad
        tfBank.returnKeyType = UIReturnKeyType.done
        tfBank.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfBank.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfBank.delegate = self
        tfBank.placeholder = "Nhập số thẻ ngân hàng"
        scrollView.addSubview(tfBank)
        tfBank.text = "\(ocfdFFriend!.CreditCard)"
        
        let lbTextCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfBank.frame.size.height + tfBank.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMND.textAlignment = .left
        lbTextCMND.textColor = UIColor.black
        lbTextCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMND.text = "CMND (*)"
        scrollView.addSubview(lbTextCMND)
        
        if(ocfdFFriend!.CMND == ""){
            lbTextCMND.textColor = .red
        }
        
        tfCMND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextCMND.frame.size.height + lbTextCMND.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfCMND.placeholder = ""
        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMND.autocorrectionType = UITextAutocorrectionType.no
        tfCMND.keyboardType = UIKeyboardType.numberPad
        tfCMND.returnKeyType = UIReturnKeyType.done
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMND.delegate = self
        tfCMND.placeholder = "Nhập số CMND"
        scrollView.addSubview(tfCMND)
        tfCMND.text = "\(ocfdFFriend!.CMND)"
        
        let lbTextNote = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfCMND.frame.size.height + tfCMND.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextNote.textAlignment = .left
        lbTextNote.textColor = UIColor.black
        lbTextNote.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextNote.text = "Ghi chú"
        scrollView.addSubview(lbTextNote)
        
        taskNotes = UITextView(frame: CGRect(x: lbTextNote.frame.origin.x , y: lbTextNote.frame.origin.y  + lbTextNote.frame.size.height + Common.Size(s:10), width: lbTextNote.frame.size.width, height: tfCMND.frame.size.height * 2 ))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        taskNotes.layer.borderWidth = 0.5
        taskNotes.layer.borderColor = borderColor.cgColor
        taskNotes.layer.cornerRadius = 5.0
        taskNotes.delegate = self
        taskNotes.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        scrollView.addSubview(taskNotes)
        
        placeholderLabel = UILabel()
        placeholderLabel.text = "Nhập nội dung ghi chú"
        placeholderLabel.font = UIFont.systemFont(ofSize: (taskNotes.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        taskNotes.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (taskNotes.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !taskNotes.text.isEmpty
        
        let btSaveCustomer = UIButton()
        btSaveCustomer.frame = CGRect(x: tfCMND.frame.origin.x, y: taskNotes.frame.size.height + taskNotes.frame.origin.y + Common.Size(s:20), width: tfName.frame.size.width, height: tfCMND.frame.size.height * 1.2)
        btSaveCustomer.backgroundColor = UIColor(netHex:0xEF4A40)
        btSaveCustomer.setTitle("Cập nhật", for: .normal)
        btSaveCustomer.addTarget(self, action: #selector(actionSaveCustomer), for: .touchUpInside)
        btSaveCustomer.layer.borderWidth = 0.5
        btSaveCustomer.layer.borderColor = UIColor.white.cgColor
        btSaveCustomer.layer.cornerRadius = 3
        scrollView.addSubview(btSaveCustomer)
        
        
        btCreateCredit = UILabel(frame: CGRect(x: btSaveCustomer.frame.origin.x, y: btSaveCustomer.frame.origin.y + btSaveCustomer.frame.size.height + Common.Size(s:10), width: btSaveCustomer.frame.size.width, height:  0))
        btCreateCredit.textAlignment = .center
        btCreateCredit.textColor = UIColor(netHex:0x47B054)
        btCreateCredit.layer.cornerRadius = 5
        btCreateCredit.layer.borderColor = UIColor(netHex:0x47B054).cgColor
        btCreateCredit.layer.borderWidth = 0.5
        btCreateCredit.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        btCreateCredit.text = "Mở thẻ tín dụng"
        btCreateCredit.numberOfLines = 1
        scrollView.addSubview(btCreateCredit)
        
//        if (ocfdFFriend != nil){
//            if(ocfdFFriend!.Is_AllowCreateCust){
//                btCreateCredit.frame.size.height = tfCMND.frame.size.height
//            }
//        }
        
//        let tapCreateCredit = UITapGestureRecognizer(target: self, action: #selector(UpdateCustomerCreditViewController.tapCreateCredit))
//        btCreateCredit.isUserInteractionEnabled = true
//        btCreateCredit.addGestureRecognizer(tapCreateCredit)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btCreateCredit.frame.origin.y + btCreateCredit.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 20))
        
        branchCompanyButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.branchCompanyButton.text = item.title
            let obj =  self.listBranchCompany.filter{ $0.VendorName == "\(item.title)" }.first
            if let code = obj?.ID {
                self.branchCode =  "\(code)"
            }
        }
        
        companyButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.companyButton.text = item.title
            let obj =  self.listCompany.filter{ $0.VendorName == "\(item.title)" }.first
            if let id = obj?.ID {
                self.vendorCode = "\(id)"
            }
            if let knox = obj?.Knox {
                if(knox.count > 0){
                    let title = "Thông báo"
                    let popup = PopupDialog(title: title, message: knox, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
            }
            //            if let obj = obj?.ChiNhanh {
            //                var listBranch: [String] = []
            //                var listBranchId: [String] = []
            //                self.listBranchCompany = obj
            //                for item in obj {
            //                    listBranch.append("\(item.TenChiNhanh)")
            //                    listBranchId.append("\(item.ID)")
            //                }
            //                if(self.listBranchCompany.count > 0){
            //                    lbTextBranchCompany.textColor = .red
            //                }else{
            //                    lbTextBranchCompany.textColor = .black
            //                }
            //                self.branchCompanyButton.text = ""
            //                self.branchCode = ""
            //                self.branchCompanyButton.filterStrings(listBranch)
            //
            //            }
            
        }
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin công ty..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.getVendorFFriend(LoaiDN: "4", handler: { (results, err) in
            //            let when = DispatchTime.now() + 0.5
            //            DispatchQueue.main.asyncAfter(deadline: when) {
            //                nc.post(name: Notification.Name("dismissLoading"), object: nil)
            if(err.count<=0){
                var listCom: [String] = []
                self.listCompany = results
                for item in results {
                    listCom.append("\(item.VendorName)")
                    if("\(item.ID)" == "\(self.ocfdFFriend!.MaCongTy)"){
                        self.vendorCode = "\(item.ID)"
                        self.companyButton.text = item.VendorName
                        
                        //                            let objCN = item.ChiNhanh
                        //                            var listBranch: [String] = []
                        //                            var listBranchId: [String] = []
                        //                            self.listBranchCompany = objCN
                        //                            for itemCN in objCN {
                        //                                listBranch.append("\(itemCN.TenChiNhanh)")
                        //                                listBranchId.append("\(itemCN.ID)")
                        //                                if(itemCN.ID == "\(self.ocfdFFriend!.MaChiNhanhDoanhNghiep)"){
                        //                                    self.branchCompanyButton.text = itemCN.TenChiNhanh
                        //                                    self.branchCode =  itemCN.ID
                        //                                }
                        //                            }
                        //                            self.branchCompanyButton.filterStrings(listBranch)
                        
                    }
                }
                if(self.vendorCode == ""){
                    self.companyButton.isEnabled = true
                    lbTextCompany.textColor = .red
                }
                self.companyButton.filterStrings(listCom)
                
                
                MPOSAPIManager.getVendorFFriend(LoaiDN: "0", handler: { (results, err) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count<=0){
                            var listCom: [String] = []
                            self.listBranchCompany = results
                            
                            for item in results {
                                listCom.append("\(item.VendorName)")
                                if("\(item.ID)" == "\(self.ocfdFFriend!.VendorCodeRef)"){
                                    self.branchCode = "\(item.ID)"
                                    self.branchCompanyButton.text = item.VendorName
                                }
                            }
                            self.branchCompanyButton.filterStrings(listCom)
                            
                        }else{
                            
                        }
                    }
                })
            }else{
                
            }
            //            }
        })
          self.hideKeyboardWhenTappedAround()
    }
    @objc func tapCreateCredit(sender:UITapGestureRecognizer) {
        
        if(self.ocfdFFriend!.NoteCredit != ""){
            let title = "THÔNG BÁO"
            let message = "\(self.ocfdFFriend!.NoteCredit)"
            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            }
            let buttonOne = DefaultButton(title: "Đóng") {
                
            }
            let buttonTow = DefaultButton(title: "Tiếp tục") {
                
                //NOT GOLIVE
                let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                }
                let buttonOne = CancelButton(title: "OK") {
                    // let newViewController = CustomerCreditNoCardViewControllerV2()
                    let newViewController = CustomerCreditNoCardViewControllerV3()
                    newViewController.ocfdFFriend = self.ocfdFFriend
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }
            if(self.ocfdFFriend!.Is_AllowCreateCust){
                popup.addButtons([buttonOne,buttonTow])
            }else{
                popup.addButtons([buttonOne])
            }
            self.present(popup, animated: true, completion: nil)
        }else{
            //NOT GOLIVE
            let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            }
            let buttonOne = CancelButton(title: "OK") {
                // let newViewController = CustomerCreditNoCardViewControllerV2()
                let newViewController = CustomerCreditNoCardViewControllerV3()
                newViewController.ocfdFFriend = self.ocfdFFriend
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    @objc func actionSaveCustomer(){
        
        let company = self.vendorCode
        if (company.count == 0){
            self.showDialog(message: "Ngân hàng không được để trống!")
            return
        }
        //        let branchCode = self.branchCode
        //        if (branchCode.count == 0 && self.listBranchCompany.count > 0){
        //            self.showDialog(message: "Chi nhánh công ty không được để trống!")
        //            return
        //        }
        let name = tfName.text!
        if (name.count == 0){
            self.showDialog(message: "Tên KH không được để trống!")
            return
        }
        // check phone
        let phone = tfPhone.text!
        if (phone.hasPrefix("01") && phone.count == 11){
            
        }else if (phone.hasPrefix("0") && !phone.hasPrefix("01") && phone.count == 10){
            
        }else{
            self.showDialog(message: "Số điện thoại không hợp lệ!")
            return
        }
        let bank = tfBank.text!
        if (bank.count == 0){
            self.showDialog(message: "Số thẻ ngân hàng không được để trống!")
            return
        }
        if (bank.count != 16){
            self.showDialog(message: "Số thẻ ngân hàng phải đúng 16 ký tự!")
            return
        }
        if bank.range(of:" ") != nil {
            self.showDialog(message: "Số TK ngân hàng không được có khoảng trắng!")
            return
        }
        
        let cmnd = tfCMND.text!
        if (cmnd.count == 0){
            self.showDialog(message: "CMND không được để trống!")
            return
        }
        if (cmnd.count == 9 || cmnd.count == 12){
            
        }else{
            self.showDialog(message: "CMND sai định dạng")
            return
        }
        let note = taskNotes.text!
        if (note.count == 0){
            self.showDialog(message: "Ghi chú không được để trống!")
            return
        }
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang đăng ký thông tin KH..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.AddCustomerFFriend(VendorCode: company, CMND: cmnd, FullName: name, SDT: phone, HoKhauTT: "", NgayCapCMND: "", NoiCapCMND: "", ChucVu: "", NgayKiHD: "", SoTKNH: "", IdBank: "", ChiNhanhNH: "", Email:
        "", Note: "", CreateBy: "\(Cache.user!.UserName)", FileAttachName: "", ChiNhanhDN: "",IDCardCode: "\(self.ocfdFFriend!.IDcardCode)", LoaiKH: "4", NgaySinh: "", CreditCard: "\(bank)", MaNV_KH: "", VendorCodeRef: "\(self.branchCode)", CMND_TinhThanhPho: "0", CMND_QuanHuyen: "0", CMND_PhuongXa: "", NguoiLienHe: "", SDT_NguoiLienHe: "", QuanHeVoiNguoiLienHe: "0", NguoiLienHe_2: "", SDT_NguoiLienHe_2: "", QuanHeVoiNguoiLienHe_2: "0", AnhDaiDien: "",GioThamDinh_TimeFrom:"",GioThamDinh_TimeTo:"",GioThamDinh_OtherTime:"",IdCardcodeRef:"",TenSPThamDinh:"",Gender: -1,IDImageXN:"",ListIDSaoKe:"",NguoiLienHe_3:"",SDT_NguoiLienHe_3:"",QuanHeVoiNguoiLienHe_3:"",NguoiLienHe_4:"",SDT_NguoiLienHe_4:"",QuanHeVoiNguoiLienHe_4:"", EVoucher: "", SoHopDong: "",isQrCode:"",isComplete:"",OTP:"") { (result,code, err) in
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    // Prepare the popup
                    let title = "THÔNG BÁO"
                    let message = result
                    
                    // Create the dialog
                    let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    
                    // Create first button
                    let buttonOne = CancelButton(title: "Tiếp theo") {
                        
                        //                        if(self.isBank){
                        //                            self.uploadUQTN(code:code,cmnd:cmnd,name:name,nameBank: self.bankButton.text!)
                        //                        }else{
                        _ = self.navigationController?.popToRootViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                        let myDict = ["CMND": cmnd]
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("AutoLoadCMND"), object: myDict)
                        //                        }
                    }
                    // Add buttons to dialog
                    popup.addButtons([buttonOne])
                    
                    // Present dialog
                    self.present(popup, animated: true, completion: nil)
                }else{
                    // Prepare the popup
                    let title = "THÔNG BÁO"
                    let message = err
                    
                    // Create the dialog
                    let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    
                    // Create first button
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    // Add buttons to dialog
                    popup.addButtons([buttonOne])
                    
                    // Present dialog
                    self.present(popup, animated: true, completion: nil)
                }
            }
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    func checkDate(stringDate:String) -> Bool{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yyyy"
        
        if let _ = dateFormatterGet.date(from: stringDate) {
            return true
        } else {
            return false
        }
    }
    @objc func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
}

