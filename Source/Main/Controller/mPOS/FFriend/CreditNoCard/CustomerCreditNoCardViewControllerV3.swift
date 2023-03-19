//
//  CustomerCreditNoCardViewControllerV3.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import PopupDialog
import ActionSheetPicker_3_0
class CustomerCreditNoCardViewControllerV3: UIViewController,UITextFieldDelegate {
    var cmnd:String?
    var scrollView:UIScrollView!
    var companyButton: SearchTextField!
    var branchCompanyButton: SearchTextField!
    var isUpdate:Bool = false
    var listCompany:[CompanyFFriend] = []
    var listBranchCompany:[BranchCompanyFFriend] = []
    
    var tfName:UITextField!
    var tfPhone:UITextField!
    var tfCMND:UITextField!
    var tfBirthday:UITextField!
    var tfTime,tfFromTime,tfToTime,tfNameProduct:UITextField!
    var vendorCode:String = ""
    var branchCode:String = ""
    
    var fromeTime:String = ""
    var toTime:String = ""
    
    var fromeTimeLong:Int = 0
    var toTimeLong:Int = 0
    
    var ocfdFFriend:OCRDFFriend?
    var btUploadImage:UILabel!
    
    var checkResult:Int = 0
    var checkMessage:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Tạo KH Credit không thẻ"
        if(self.ocfdFFriend != nil){
            self.title = "Cập nhật KH Credit"
        }
        
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
        lbType.text = "Credit không thẻ"
        scrollView.addSubview(lbType)
        
        let lbTextCompany = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbType.frame.size.height + lbType.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCompany.textAlignment = .left
        lbTextCompany.textColor = UIColor.black
        lbTextCompany.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCompany.text = "Tên công ty (*)"
        scrollView.addSubview(lbTextCompany)
        
        companyButton = SearchTextField(frame: CGRect(x: lbTextCompany.frame.origin.x, y: lbTextCompany.frame.origin.y + lbTextCompany.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        companyButton.placeholder = "Chọn tên công ty"
        companyButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.borderStyle = UITextField.BorderStyle.roundedRect
        companyButton.autocorrectionType = UITextAutocorrectionType.no
        companyButton.keyboardType = UIKeyboardType.default
        companyButton.returnKeyType = UIReturnKeyType.done
        companyButton.clearButtonMode = UITextField.ViewMode.whileEditing
        companyButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        companyButton.delegate = self
        scrollView.addSubview(companyButton)
        
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
        lbTextBranchCompany.text = "Chi nhánh công ty"
        scrollView.addSubview(lbTextBranchCompany)
        
        branchCompanyButton = SearchTextField(frame: CGRect(x: lbTextBranchCompany.frame.origin.x, y: lbTextBranchCompany.frame.origin.y + lbTextCompany.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        branchCompanyButton.placeholder = "Chọn chi nhánh công ty"
        branchCompanyButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        branchCompanyButton.borderStyle = UITextField.BorderStyle.roundedRect
        branchCompanyButton.autocorrectionType = UITextAutocorrectionType.no
        branchCompanyButton.keyboardType = UIKeyboardType.default
        branchCompanyButton.returnKeyType = UIReturnKeyType.done
        branchCompanyButton.clearButtonMode = UITextField.ViewMode.whileEditing
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
        tfName.clearButtonMode = UITextField.ViewMode.whileEditing
        tfName.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfName.delegate = self
        tfName.placeholder = "Ghi đầy đủ họ tên bằng Tiếng Việt có dấu"
        scrollView.addSubview(tfName)
        
        if(self.ocfdFFriend != nil){
            tfName.text = "\(self.ocfdFFriend!.CardName)"
        }
        
        let lbTextPhone = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfName.frame.size.height + tfName.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhone.textAlignment = .left
        lbTextPhone.textColor = UIColor.black
        lbTextPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhone.text = "Số điện thoại (*)"
        scrollView.addSubview(lbTextPhone)
        
        tfPhone = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhone.frame.size.height + lbTextPhone.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfPhone.placeholder = ""
        tfPhone.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhone.autocorrectionType = UITextAutocorrectionType.no
        tfPhone.keyboardType = UIKeyboardType.numberPad
        tfPhone.returnKeyType = UIReturnKeyType.done
        tfPhone.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhone.delegate = self
        tfPhone.placeholder = "Nhập số điện thoại KH"
        scrollView.addSubview(tfPhone)
        
        if(self.ocfdFFriend != nil){
            tfPhone.text = "\(self.ocfdFFriend!.SDT)"
        }
        
        let lbTextCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhone.frame.size.height + tfPhone.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMND.textAlignment = .left
        lbTextCMND.textColor = UIColor.black
        lbTextCMND.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbTextCMND.text = "CMND (*)"
        scrollView.addSubview(lbTextCMND)
        
        tfCMND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextCMND.frame.origin.y + lbTextCMND.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfCMND.placeholder = "Nhập CMND khách hàng"
        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMND.autocorrectionType = UITextAutocorrectionType.no
        tfCMND.keyboardType = UIKeyboardType.numberPad
        tfCMND.returnKeyType = UIReturnKeyType.done
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMND.delegate = self
        scrollView.addSubview(tfCMND)
        if(cmnd != nil){
            if(cmnd!.count > 0){
                tfCMND.text = cmnd!
            }
        }
        if(self.ocfdFFriend != nil){
            tfCMND.text = "\(self.ocfdFFriend!.CMND)"
        }
        
        let lbTextBirthday = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfCMND.frame.size.height + tfCMND.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextBirthday.textAlignment = .left
        lbTextBirthday.textColor = UIColor.black
        lbTextBirthday.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbTextBirthday.text = "Ngày sinh (*)"
        scrollView.addSubview(lbTextBirthday)
        
        tfBirthday = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextBirthday.frame.origin.y + lbTextBirthday.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfBirthday.placeholder = "Nhập ngày sinh KH (dd/MM/yyyy)"
        tfBirthday.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfBirthday.borderStyle = UITextField.BorderStyle.roundedRect
        tfBirthday.autocorrectionType = UITextAutocorrectionType.no
        tfBirthday.keyboardType = UIKeyboardType.default
        tfBirthday.returnKeyType = UIReturnKeyType.done
        tfBirthday.clearButtonMode = UITextField.ViewMode.whileEditing
        tfBirthday.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfBirthday.delegate = self
        scrollView.addSubview(tfBirthday)
        if(self.ocfdFFriend != nil){
            if("\(self.ocfdFFriend!.Birthday)" != "01/01/1970"){
                tfBirthday.text = "\(self.ocfdFFriend!.Birthday)"
            }else{
                tfBirthday.text = ""
            }
        }
        
        let lbTextTimeCall = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfBirthday.frame.size.height + tfBirthday.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextTimeCall.textAlignment = .left
        lbTextTimeCall.textColor = UIColor.black
        lbTextTimeCall.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTimeCall.text = "Giờ gọi KH nghe máy để thẩm định"
        scrollView.addSubview(lbTextTimeCall)
        
        tfFromTime = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextTimeCall.frame.origin.y + lbTextTimeCall.frame.size.height + Common.Size(s:5), width: (scrollView.frame.size.width - Common.Size(s:30))/2 - Common.Size(s:2.5) , height: Common.Size(s:40)));
        tfFromTime.placeholder = "Chọn giờ từ"
        tfFromTime.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfFromTime.borderStyle = UITextField.BorderStyle.roundedRect
        tfFromTime.autocorrectionType = UITextAutocorrectionType.no
        tfFromTime.keyboardType = UIKeyboardType.numberPad
        tfFromTime.returnKeyType = UIReturnKeyType.done
        tfFromTime.clearButtonMode = UITextField.ViewMode.whileEditing
        tfFromTime.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfFromTime.delegate = self
        scrollView.addSubview(tfFromTime)
        tfFromTime.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidBegin)
        
        if(self.ocfdFFriend != nil){
            tfFromTime.text = "\(self.ocfdFFriend!.TimeFrom)"
            fromeTime = "\(self.ocfdFFriend!.TimeFrom)"
            
        }
        
        tfToTime = UITextField(frame: CGRect(x:tfFromTime.frame.origin.x + tfFromTime.frame.size.width + Common.Size(s:5), y: lbTextTimeCall.frame.origin.y + lbTextTimeCall.frame.size.height + Common.Size(s:5), width: (scrollView.frame.size.width - Common.Size(s:30))/2 - Common.Size(s:2.5) , height: Common.Size(s:40)));
        tfToTime.placeholder = "Chọn giờ đến"
        tfToTime.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfToTime.borderStyle = UITextField.BorderStyle.roundedRect
        tfToTime.autocorrectionType = UITextAutocorrectionType.no
        tfToTime.keyboardType = UIKeyboardType.numberPad
        tfToTime.returnKeyType = UIReturnKeyType.done
        tfToTime.clearButtonMode = UITextField.ViewMode.whileEditing
        tfToTime.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfToTime.delegate = self
        scrollView.addSubview(tfToTime)
        tfToTime.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidBegin)
        
        if(self.ocfdFFriend != nil){
            tfToTime.text = "\(self.ocfdFFriend!.TimeTo)"
            toTime = "\(self.ocfdFFriend!.TimeTo)"
        }
        
        let lbTextTime = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfFromTime.frame.size.height + tfFromTime.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextTime.textAlignment = .left
        lbTextTime.textColor = UIColor.black
        lbTextTime.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTime.text = "Giờ khác"
        scrollView.addSubview(lbTextTime)
        
        
        tfTime = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextTime.frame.origin.y + lbTextTime.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfTime.placeholder = "Nhập giờ khác"
        tfTime.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTime.borderStyle = UITextField.BorderStyle.roundedRect
        tfTime.autocorrectionType = UITextAutocorrectionType.no
        tfTime.keyboardType = UIKeyboardType.default
        tfTime.returnKeyType = UIReturnKeyType.done
        tfTime.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTime.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTime.delegate = self
        scrollView.addSubview(tfTime)
        if(self.ocfdFFriend != nil){
            tfTime.text = "\(self.ocfdFFriend!.OtherTime)"
        }
        
        let lbTextNameProduct = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfTime.frame.size.height + tfTime.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextNameProduct.textAlignment = .left
        lbTextNameProduct.textColor = UIColor.black
        lbTextNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextNameProduct.text = "Tên SP dự kiến mua"
        scrollView.addSubview(lbTextNameProduct)
        
        tfNameProduct = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextNameProduct.frame.origin.y + lbTextNameProduct.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfNameProduct.placeholder = "Nhập tên SP dự kiến mua"
        tfNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfNameProduct.borderStyle = UITextField.BorderStyle.roundedRect
        tfNameProduct.autocorrectionType = UITextAutocorrectionType.no
        tfNameProduct.keyboardType = UIKeyboardType.default
        tfNameProduct.returnKeyType = UIReturnKeyType.done
        tfNameProduct.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfNameProduct.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfNameProduct.delegate = self
        scrollView.addSubview(tfNameProduct)
        
        if(self.ocfdFFriend != nil){
            tfNameProduct.text = "\(self.ocfdFFriend!.TenSPThamDinh)"
        }
        if(isUpdate){
            tfNameProduct.isEnabled = false
        }
        let btSaveCustomer = UIButton()
        btSaveCustomer.frame = CGRect(x: tfCMND.frame.origin.x, y:tfNameProduct.frame.size.height + tfNameProduct.frame.origin.y + Common.Size(s:20), width: tfName.frame.size.width, height: tfCMND.frame.size.height * 1.2)
        btSaveCustomer.backgroundColor = UIColor(netHex:0xEF4A40)
        btSaveCustomer.setTitle("Lưu mới", for: .normal)
        
        btSaveCustomer.addTarget(self, action: #selector(actionSaveCustomer), for: .touchUpInside)
        btSaveCustomer.layer.borderWidth = 0.5
        btSaveCustomer.layer.borderColor = UIColor.white.cgColor
        btSaveCustomer.layer.cornerRadius = 3
        scrollView.addSubview(btSaveCustomer)
        
        if(self.ocfdFFriend != nil){
            btSaveCustomer.setTitle("Cập nhật", for: .normal)
            checkResult = 1
            btUploadImage = UILabel(frame: CGRect(x: btSaveCustomer.frame.origin.x, y: btSaveCustomer.frame.origin.y + btSaveCustomer.frame.size.height + Common.Size(s:10), width: btSaveCustomer.frame.size.width, height: 0))
            btUploadImage.textAlignment = .center
            btUploadImage.textColor = UIColor(netHex:0x47B054)
            btUploadImage.layer.cornerRadius = 5
            btUploadImage.layer.borderColor = UIColor(netHex:0x47B054).cgColor
            btUploadImage.layer.borderWidth = 0.5
            btUploadImage.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
            btUploadImage.text = "Upload hình ảnh ĐK credit"
            btUploadImage.numberOfLines = 1
            scrollView.addSubview(btUploadImage)
            
            if(self.ocfdFFriend!.Flag_Credit != "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"){
                btUploadImage.frame.size.height = tfCMND.frame.size.height
                let tapUploadImage = UITapGestureRecognizer(target: self, action: #selector(CustomerCreditNoCardViewControllerV3.actionUploadImage))
                btUploadImage.isUserInteractionEnabled = true
                btUploadImage.addGestureRecognizer(tapUploadImage)
            }
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        }else{
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btSaveCustomer.frame.origin.y + btSaveCustomer.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        }
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin công ty..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.getVendorFFriend(LoaiDN: "5", handler: { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count<=0){
                    var listCom: [String] = []
                    self.listCompany = results
                    for item in results {
                        listCom.append("\(item.VendorName)")
                        if(self.ocfdFFriend != nil){
                            if(self.ocfdFFriend!.MaCongTy == "\(item.ID)"){
                                self.companyButton.text = "\(item.VendorName)"
                                self.vendorCode = "\(item.ID)"
                                for item1 in item.ChiNhanh {
                                    if(self.ocfdFFriend!.MaChiNhanhDoanhNghiep == "\(item1.ID)"){
                                        self.branchCompanyButton.text = "\(item1.TenChiNhanh)"
                                        self.branchCode = "\(item1.ID)"
                                    }
                                }
                            }
                            self.companyButton.isEnabled = false
                            self.branchCompanyButton.isEnabled = false
                        }
                    }
                    self.companyButton.filterStrings(listCom)
                    
                }else{
                    let popup = PopupDialog(title: "THÔNG BÁO", message: "\(err)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        _ = self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
            }
        })
        
        companyButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.companyButton.text = item.title
            let obj =  self.listCompany.filter{ $0.VendorName == "\(item.title)" }.first
            if let id = obj?.ID {
                self.vendorCode = "\(id)"
            }
            self.branchCode =  ""
            self.branchCompanyButton.text = ""
            if let obj = obj?.ChiNhanh {
                var listBranch: [String] = []
                var listBranchId: [String] = []
                self.listBranchCompany = obj
                for item in obj {
                    listBranch.append("\(item.TenChiNhanh)")
                    listBranchId.append("\(item.ID)")
                }
                if(listBranch.count > 0){
                    self.branchCompanyButton.text = ""
                    self.branchCode = ""
                }
                self.branchCompanyButton.filterStrings(listBranch)
            }
            self.checkCreateCustomer()
        }
        branchCompanyButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.branchCompanyButton.text = item.title
            let obj =  self.listBranchCompany.filter{ $0.TenChiNhanh == "\(item.title)" }.first
            if let code = obj?.ID {
                self.branchCode =  "\(code)"
            }
        }
          self.hideKeyboardWhenTappedAround()
    }
    func checkCreateCustomer(){
        
        MPOSAPIManager.sp_mpos_CheckCreateCustomer(VendorCode: "\(self.vendorCode)", LoaiKH: "5", handler: { (result, message) in
            if(message.count > 0){
                let title = "Thông báo"
                let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "OK") {
                    
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }
            self.checkResult = result
            self.checkMessage = message
        })
        
    }
    @objc func actionUploadImage(){
        // let viewController = UploadImagesCreditNoCardViewController()
        let viewController = UploadImagesCreditNoCardViewControllerV2()
        viewController.name = "\(self.ocfdFFriend!.CardName)"
        viewController.cmnd = "\(self.ocfdFFriend!.CMND)"
        viewController.nameProduct = "\(self.ocfdFFriend!.TenSPThamDinh)"
        viewController.idCardCode = "\(self.ocfdFFriend!.IDcardCode)"
        viewController.ocfdFFriend = self.ocfdFFriend!
        viewController.isUpdate = isUpdate
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField == tfFromTime){
            let datePicker = ActionSheetDatePicker(title: "Chọn giờ từ:", datePickerMode: UIDatePicker.Mode.time, selectedDate: Date(), doneBlock: {
                picker, value, index in
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm:ss"
                let strDate = dateFormatter .string(from: value as! Date)
                self.tfFromTime.text = "\(strDate)"
                self.fromeTime = "\(strDate)"
                self.fromeTimeLong = (value as! Date).millisecondsSince1970
                //                print("value = \(value)")
                //                print("index = \(index)")
                //                print("picker = \(picker)")
                return
            }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
            let secondsInWeek: TimeInterval = 7 * 24 * 60 * 60;
            datePicker?.minimumDate = Date(timeInterval: -secondsInWeek, since: Date())
            datePicker?.maximumDate = Date(timeInterval: secondsInWeek, since: Date())
            
            datePicker?.show()
            textField.resignFirstResponder()
        }else if(textField == tfToTime){
            let datePicker = ActionSheetDatePicker(title: "Chọn giờ đến:", datePickerMode: UIDatePicker.Mode.time, selectedDate: Date(), doneBlock: {
                picker, value, index in
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm:ss"
                let strDate = dateFormatter.string(from: value as! Date)
                self.tfToTime.text = "\(strDate)"
                self.toTimeLong = (value as! Date).millisecondsSince1970
                self.toTime = "\(strDate)"
                //                print("value = \(value)")
                //                print("index = \(index)")
                //                print("picker = \(picker)")
                return
            }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
            let secondsInWeek: TimeInterval = 7 * 24 * 60 * 60;
            datePicker?.minimumDate = Date(timeInterval: -secondsInWeek, since: Date())
            datePicker?.maximumDate = Date(timeInterval: secondsInWeek, since: Date())
            
            datePicker?.show()
            textField.resignFirstResponder()
        }
        
    }
    @objc func actionSaveCustomer(){
        
        let company = self.vendorCode
        if (company.count == 0){
            let alert = UIAlertController(title: "Thông báo", message:  "Công ty không được để trống!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title:"Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        if(checkResult == 0){
            let title = "Thông báo"
            let popup = PopupDialog(title: title, message: checkMessage, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        
        let branchCode = self.branchCode
        if (branchCode.count == 0 && self.listBranchCompany.count > 0){
            let alert = UIAlertController(title: "Thông báo", message:  "Chi nhánh công ty không được để trống!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title:"Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        let name = self.tfName.text!
        if(name.count <= 0){
            let alert = UIAlertController(title: "Thông báo", message:  "Bạn chưa nhập đầy đủ tên khách hàng!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title:"Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        let phone = tfPhone.text!
        if (phone.hasPrefix("01") && phone.count == 11){
            
        }else if (phone.hasPrefix("0") && !phone.hasPrefix("01") && phone.count == 10){
            
        }else{
            let alert = UIAlertController(title: "Thông báo", message:  "Số điện thoại không hợp lệ!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title:"Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        let cmnd = tfCMND.text!
        if (cmnd.count < 9 || cmnd.count > 12){
            let alert = UIAlertController(title: "Thông báo", message:  "Vui lòng nhập đúng số cmnd khách hàng", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title:"Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        let birthday = tfBirthday.text!
        if (birthday.count == 0){
            let alert = UIAlertController(title: "Thông báo", message: "Ngày sinh không được để trống!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title:"Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        if (!checkDate(stringDate: birthday)){
            let alert = UIAlertController(title: "Thông báo", message: "Ngày sinh sai định dạng!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title:"Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }else{
            let listDate = birthday.components(separatedBy: "/")
            if (listDate.count == 3){
                let yearText = listDate[2]
                let date = Date()
                let calendar = Calendar.current
                let year = calendar.component(.year, from: date)
                let yearInt = year - Int(yearText)!
                
                if(yearInt == 23){
                    //cung nam
                    let month = calendar.component(.month, from: date)
                    let monthText = listDate[1]
                    let monthInt = Int(monthText)!
                    if(monthInt == month){
                        let day = calendar.component(.day, from: date)
                        let dayText = listDate[0]
                        let dayInt = Int(dayText)!
                        if(dayInt > day){
                            let alert = UIAlertController(title: "Thông báo", message: "Khách hàng dưới 23 tuổi không đủ điều kiện mở thẻ theo quy định ngân hàng", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title:"Đồng ý", style: .cancel) { _ in
                                
                            })
                            self.present(alert, animated: true)
                            return
                        }
                    }else if(monthInt > month){
                        let alert = UIAlertController(title: "Thông báo", message: "Khách hàng dưới 23 tuổi không đủ điều kiện mở thẻ theo quy định ngân hàng", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title:"Đồng ý", style: .cancel) { _ in
                            
                        })
                        self.present(alert, animated: true)
                        return
                    }
                }else if(yearInt < 23){
                    let alert = UIAlertController(title: "Thông báo", message: "Khách hàng dưới 23 tuổi không đủ điều kiện mở thẻ theo quy định ngân hàng", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title:"Đồng ý", style: .cancel) { _ in
                        
                    })
                    self.present(alert, animated: true)
                    return
                }
            }
        }
        
        let timeCall = tfTime.text!
        if(timeCall.count <= 0){
            if(fromeTime.count <= 0 || toTime.count <= 0){
                let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập thời gian gọi KH!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title:"Đồng ý", style: .cancel) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            
            if let strDateTo = dateFormatter.date(from: toTime) {
                if let strDateFrom = dateFormatter.date(from: fromeTime) {
                    self.toTimeLong = ((strDateTo).millisecondsSince1970)
                    self.fromeTimeLong = ((strDateFrom).millisecondsSince1970)
                    
                    if(self.toTimeLong <= self.fromeTimeLong){
                        let alert = UIAlertController(title: "Thông báo", message: "Thời gian gọi không hợp lệ!", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title:"Đồng ý", style: .cancel) { _ in
                            
                        })
                        self.present(alert, animated: true)
                        return
                    }
                } else {
                    let alert = UIAlertController(title: "Thông báo", message: "Thời gian gọi không hợp lệ!", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title:"Đồng ý", style: .cancel) { _ in
                        
                    })
                    self.present(alert, animated: true)
                    return
                }
                
            } else {
                let alert = UIAlertController(title: "Thông báo", message: "Thời gian gọi không hợp lệ!", preferredStyle: .alert)
        
                alert.addAction(UIAlertAction(title:"Đồng ý", style: .cancel) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
        }
        var nameProduct = tfNameProduct.text!
        //        if(nameProduct.count <= 0){
        //            Toast(text: "Bạn chưa nhập tên SP dự kiến mua!").show()
        //            return
        //        }
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang tạo mới thông tin KH..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        if(self.ocfdFFriend != nil){
            var idCardCode = "0"
            var idCardcodeRef = "\(self.ocfdFFriend!.IDcardCode)"
            if(isUpdate){
                idCardCode = "\(self.ocfdFFriend!.IDcardCode)"
                idCardcodeRef = "0"
            }
            
            if(self.ocfdFFriend!.TenSPThamDinh.count > 0){
                nameProduct = self.ocfdFFriend!.TenSPThamDinh
            }
            MPOSAPIManager.AddCustomerFFriend(VendorCode: "\(company)", CMND: cmnd, FullName: name, SDT: phone, HoKhauTT: "\(self.ocfdFFriend!.DiaChiHoKhau)", NgayCapCMND: "\(self.ocfdFFriend!.NgayCapCMND)", NoiCapCMND: "\(self.ocfdFFriend!.NoiCapCMND)", ChucVu: "\(self.ocfdFFriend!.MaChucVu)", NgayKiHD: "\(self.ocfdFFriend!.NgayBatDauLamViec)", SoTKNH: "\(self.ocfdFFriend!.SoTKNH)", IdBank: "\(self.ocfdFFriend!.IdBank)", ChiNhanhNH: "\(self.ocfdFFriend!.ChiNhanhNH)", Email: "\(self.ocfdFFriend!.Email)", Note: "", CreateBy: "\(Cache.user!.UserName)", FileAttachName: "", ChiNhanhDN: "\(branchCode)",IDCardCode: "\(idCardCode)", LoaiKH: "5", NgaySinh: "\(birthday)", CreditCard: "\(self.ocfdFFriend!.CreditCard)", MaNV_KH: "\(self.ocfdFFriend!.MaNV_KH)", VendorCodeRef: "\(self.ocfdFFriend!.VendorCodeRef)", CMND_TinhThanhPho: "\(self.ocfdFFriend!.CMND_TinhThanhPho)", CMND_QuanHuyen: "\(self.ocfdFFriend!.CMND_QuanHuyen)", CMND_PhuongXa: "\(self.ocfdFFriend!.CMND_PhuongXa)", NguoiLienHe: "\(self.ocfdFFriend!.NguoiLienHe)", SDT_NguoiLienHe: "\(self.ocfdFFriend!.SDT_NguoiLienHe)", QuanHeVoiNguoiLienHe: "\(self.ocfdFFriend!.QuanHeVoiNguoiLienHe)", NguoiLienHe_2: "\(self.ocfdFFriend!.NguoiLienHe_2)", SDT_NguoiLienHe_2: "\(self.ocfdFFriend!.SDT_NguoiLienHe_2)", QuanHeVoiNguoiLienHe_2: "\(self.ocfdFFriend!.QuanHeVoiNguoiLienHe_2)", AnhDaiDien: "",GioThamDinh_TimeFrom:"\(fromeTime)",GioThamDinh_TimeTo:"\(toTime)",GioThamDinh_OtherTime:"\(timeCall)",IdCardcodeRef:"\(idCardcodeRef)",TenSPThamDinh:"\(nameProduct)",Gender: -1,IDImageXN:"",ListIDSaoKe:"",NguoiLienHe_3:"",SDT_NguoiLienHe_3:"",QuanHeVoiNguoiLienHe_3:"",NguoiLienHe_4:"",SDT_NguoiLienHe_4:"",QuanHeVoiNguoiLienHe_4:"", EVoucher: "", SoHopDong: "",isQrCode:"",isComplete:"",OTP:"") { (result,code, err) in
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    if(err.count <= 0){
                        // Prepare the popup
                        let title = "THÔNG BÁO"
                        let message = result
                        
                        // Create the dialog
                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        // Create first button
                        let buttonOne = CancelButton(title: "OK") {
                            _ = self.navigationController?.popToRootViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                            let myDict = ["CMND": "\(cmnd)"]
                            let nc = NotificationCenter.default
                            nc.post(name: Notification.Name("AutoLoadCMND"), object: myDict)
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
        }else{
            MPOSAPIManager.AddCustomerFFriend(VendorCode: "\(company)", CMND: cmnd, FullName: name, SDT: phone, HoKhauTT: "", NgayCapCMND: "", NoiCapCMND: "", ChucVu: "", NgayKiHD: "", SoTKNH: "", IdBank: "", ChiNhanhNH: "", Email: "", Note: "", CreateBy: "\(Cache.user!.UserName)", FileAttachName: "", ChiNhanhDN: "\(branchCode)",IDCardCode: "0", LoaiKH: "5", NgaySinh: "\(birthday)", CreditCard: "", MaNV_KH: "", VendorCodeRef: "", CMND_TinhThanhPho: "0", CMND_QuanHuyen: "0", CMND_PhuongXa: "", NguoiLienHe: "", SDT_NguoiLienHe: "", QuanHeVoiNguoiLienHe: "0", NguoiLienHe_2: "", SDT_NguoiLienHe_2: "", QuanHeVoiNguoiLienHe_2: "0", AnhDaiDien: "",GioThamDinh_TimeFrom:"\(fromeTime)",GioThamDinh_TimeTo:"\(toTime)",GioThamDinh_OtherTime:"\(timeCall)",IdCardcodeRef:"0",TenSPThamDinh:"\(nameProduct)",Gender: -1,IDImageXN:"",ListIDSaoKe:"",NguoiLienHe_3:"",SDT_NguoiLienHe_3:"",QuanHeVoiNguoiLienHe_3:"",NguoiLienHe_4:"",SDT_NguoiLienHe_4:"",QuanHeVoiNguoiLienHe_4:"", EVoucher: "", SoHopDong: "",isQrCode:"",isComplete:"",OTP:"") { (result,code, err) in
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
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
                            let title = "THÔNG BÁO"
                            let message = "Bạn cần in UQTN, rồi đưa hội viên ký tên để hoàn tất thủ tục tạo tài khoản F.Friends.\r\nNếu đã có UQTN vui lòng chọn bỏ qua."
                            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = DefaultButton(title: "In ấn") {
                                let popup = PopupDialog(title: "Thông báo", message: "Vui lòng upload hình ảnh  trên form bản cứng có chữ kí của HO gởi xuống shop.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                    //   let viewController = UploadImagesCreditNoCardViewController()
                                    let viewController = UploadImagesCreditNoCardViewControllerV2()
                                    viewController.name = name
                                    viewController.cmnd = cmnd
                                    viewController.nameProduct = nameProduct
                                    viewController.idCardCode = code
                                    viewController.isUpdate = self.isUpdate
                                    self.navigationController?.pushViewController(viewController, animated: true)
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }
                            let buttonTwo = CancelButton(title: "Bỏ qua") {
                                let popup = PopupDialog(title: "Thông báo", message: "Vui lòng upload hình ảnh  trên form bản cứng có chữ kí của HO gởi xuống shop.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                    //   let viewController = UploadImagesCreditNoCardViewController()
                                    let viewController = UploadImagesCreditNoCardViewControllerV2()
                                    viewController.name = name
                                    viewController.cmnd = cmnd
                                    viewController.nameProduct = nameProduct
                                    viewController.idCardCode = code
                                    viewController.isUpdate = self.isUpdate
                                    self.navigationController?.pushViewController(viewController, animated: true)
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }
                            popup.addButtons([buttonOne,buttonTwo])
                            self.present(popup, animated: true, completion: nil)
                            
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
}

