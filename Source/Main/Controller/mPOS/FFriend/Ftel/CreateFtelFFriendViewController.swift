//
//  CustomerPayDirectlyViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/13/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import PopupDialog
class CreateFtelFFriendViewController: UIViewController,UITextFieldDelegate {
    
    var scrollView:UIScrollView!
    var tfCMND:UITextField!
    var tfName:UITextField!
    var tfPhone:UITextField!
    var tfEmail:UITextField!
    var companyButton: SearchTextField!
    var emailButton: SearchTextField!
    
    var branchCompanyButton: SearchTextField!
    var btSaveCustomer:UIButton!
    var cmnd:String?
    
    var listCompany:[CompanyFFriend] = []
    var listBranchCompany:[BranchCompanyFFriend] = []
    
    var vendorCode:String  = ""
    var branchCode:String  = ""
    
    var checkResult:Int = -1
    var checkMessage:String = ""
    var checkEmail:Bool = false
    
    var posImageUpload:Int = -1
    //--
    var viewInfoCMNDTruoc:UIView!
    var viewImageCMNDTruoc:UIView!
    var imgViewCMNDTruoc: UIImageView!
    var viewCMNDTruoc:UIView!
    //--
    
    //--
    var viewInfoCMNDSau:UIView!
    var viewImageCMNDSau:UIView!
    var imgViewCMNDSau: UIImageView!
    var viewCMNDSau:UIView!
    //--
    var tfVoucher:UITextField!
    var tfAddress:UITextField!
    var tfSoHD:UITextField!
    var CRD_MT_CMND2:String = ""
    var CRD_MS_CMND2:String = ""
    var FtelCustomer:QRcodeFFriend?
    var imagePicker = UIImagePickerController()
     var viewUpload:UIView!
    var isFalseCMNDTruoc:Bool = false
    var idDetect:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Tạo KH Trả Thẳng"
        
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
        lbType.text = "Trả thẳng"
        scrollView.addSubview(lbType)
        
        let lbTextCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbType.frame.size.height + lbType.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMND.textAlignment = .left
        lbTextCMND.textColor = UIColor.black
        lbTextCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMND.text = "CMND (*)"
        scrollView.addSubview(lbTextCMND)
        
        tfCMND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextCMND.frame.origin.y + lbTextCMND.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfCMND.placeholder = "Nhập CMND khách hàng"
        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMND.autocorrectionType = UITextAutocorrectionType.no
        tfCMND.keyboardType = UIKeyboardType.numberPad
        tfCMND.returnKeyType = UIReturnKeyType.done
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMND.delegate = self
        scrollView.addSubview(tfCMND)
        tfCMND.isUserInteractionEnabled = false
        tfCMND.text = self.FtelCustomer!.IdCard
        
        let lbTextName = UILabel(frame: CGRect(x: Common.Size(s:15), y:tfCMND.frame.size.height + tfCMND.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
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
        tfName.text = self.FtelCustomer!.FullName
        tfName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        scrollView.addSubview(tfName)
        
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
        tfPhone.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhone.delegate = self
        tfPhone.placeholder = "Nhập số điện thoại KH"
        tfPhone.text = self.FtelCustomer!.PhoneNumber
        tfPhone.isUserInteractionEnabled = false
        scrollView.addSubview(tfPhone)
        
        let lbTextCompany = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhone.frame.size.height + tfPhone.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCompany.textAlignment = .left
        lbTextCompany.textColor = UIColor.black
        lbTextCompany.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCompany.text = "Tên công ty (*)"
        scrollView.addSubview(lbTextCompany)
        
        companyButton = SearchTextField(frame: CGRect(x: lbTextCompany.frame.origin.x, y: lbTextCompany.frame.origin.y + lbTextCompany.frame.size.height + Common.Size(s:10), width: tfPhone.frame.size.width , height: tfPhone.frame.size.height ));
        
        companyButton.placeholder = "Chọn tên công ty"
        companyButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.borderStyle = UITextField.BorderStyle.roundedRect
        companyButton.autocorrectionType = UITextAutocorrectionType.no
        companyButton.keyboardType = UIKeyboardType.default
        companyButton.returnKeyType = UIReturnKeyType.done
        companyButton.clearButtonMode = UITextField.ViewMode.whileEditing;
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
        
        
//        let lbTextVoucher = UILabel(frame: CGRect(x: Common.Size(s:15), y: branchCompanyButton.frame.size.height + branchCompanyButton.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
//        lbTextVoucher.textAlignment = .left
//        lbTextVoucher.textColor = UIColor.black
//        lbTextVoucher.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lbTextVoucher.text = "Voucher"
//        scrollView.addSubview(lbTextVoucher)
//
//        tfVoucher = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextVoucher.frame.size.height + lbTextVoucher.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
//        tfVoucher.placeholder = ""
//        tfVoucher.font = UIFont.systemFont(ofSize: Common.Size(s:15))
//        tfVoucher.borderStyle = UITextField.BorderStyle.roundedRect
//        tfVoucher.autocorrectionType = UITextAutocorrectionType.no
//        tfVoucher.keyboardType = UIKeyboardType.default
//        tfVoucher.returnKeyType = UIReturnKeyType.done
//        tfVoucher.clearButtonMode = UITextField.ViewMode.whileEditing;
//        tfVoucher.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
//        tfVoucher.delegate = self
//        tfVoucher.placeholder = "Nhập voucher"
//        scrollView.addSubview(tfVoucher)
        
        let lbTextSoHD = UILabel(frame: CGRect(x: Common.Size(s:15), y: branchCompanyButton.frame.size.height + branchCompanyButton.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHD.textAlignment = .left
        lbTextSoHD.textColor = UIColor.black
        lbTextSoHD.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHD.text = "Số hợp đồng"
        scrollView.addSubview(lbTextSoHD)
        
        tfSoHD = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextSoHD.frame.size.height + lbTextSoHD.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfSoHD.placeholder = ""
        tfSoHD.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSoHD.borderStyle = UITextField.BorderStyle.roundedRect
        tfSoHD.autocorrectionType = UITextAutocorrectionType.no
        tfSoHD.keyboardType = UIKeyboardType.default
        tfSoHD.returnKeyType = UIReturnKeyType.done
        tfSoHD.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfSoHD.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSoHD.delegate = self
        tfSoHD.placeholder = "Nhập số hợp đồng"
        tfSoHD.isUserInteractionEnabled = false
        tfSoHD.text = self.FtelCustomer!.contractNo
        scrollView.addSubview(tfSoHD)
        
        let lbTextDiaChi = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfSoHD.frame.size.height + tfSoHD.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextDiaChi.textAlignment = .left
        lbTextDiaChi.textColor = UIColor.black
        lbTextDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextDiaChi.text = "Địa chỉ"
        scrollView.addSubview(lbTextDiaChi)
        
        tfAddress = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextDiaChi.frame.size.height + lbTextDiaChi.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfAddress.placeholder = ""
        tfAddress.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfAddress.borderStyle = UITextField.BorderStyle.roundedRect
        tfAddress.autocorrectionType = UITextAutocorrectionType.no
        tfAddress.keyboardType = UIKeyboardType.default
        tfAddress.returnKeyType = UIReturnKeyType.done
        tfAddress.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfAddress.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfAddress.delegate = self
        tfAddress.placeholder = "Nhập địa chỉ"
        //tfAddress.text = "\(self.ftelCus![3])"
        scrollView.addSubview(tfAddress)
        
        
        let lbTextEmail = UILabel(frame: CGRect(x: Common.Size(s:15), y:tfAddress.frame.size.height + tfAddress.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextEmail.textAlignment = .left
        lbTextEmail.textColor = UIColor.black
        lbTextEmail.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextEmail.text = "Email KH (*)"
        scrollView.addSubview(lbTextEmail)
        
        tfEmail = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextEmail.frame.size.height + lbTextEmail.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width/3, height: Common.Size(s:40)))
        tfEmail.placeholder = ""
        tfEmail.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfEmail.borderStyle = UITextField.BorderStyle.roundedRect
        tfEmail.autocorrectionType = UITextAutocorrectionType.no
        tfEmail.keyboardType = UIKeyboardType.default
        tfEmail.returnKeyType = UIReturnKeyType.done
        tfEmail.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfEmail.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfEmail.delegate = self
        tfEmail.placeholder = "Tên email"
        scrollView.addSubview(tfEmail)
        
        emailButton = SearchTextField(frame: CGRect(x: tfEmail.frame.origin.x + tfEmail.frame.size.width, y: tfEmail.frame.origin.y , width: scrollView.frame.size.width * 2/3 - Common.Size(s:30), height: tfEmail.frame.size.height ));
        
        emailButton.placeholder = "Chọn email"
        emailButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        emailButton.borderStyle = UITextField.BorderStyle.roundedRect
        emailButton.autocorrectionType = UITextAutocorrectionType.no
        emailButton.keyboardType = UIKeyboardType.default
        emailButton.returnKeyType = UIReturnKeyType.done
        emailButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        emailButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        emailButton.delegate = self
        scrollView.addSubview(emailButton)
        
        emailButton.startVisible = true
        emailButton.theme.bgColor = UIColor.white
        emailButton.theme.fontColor = UIColor.black
        emailButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        emailButton.theme.cellHeight = Common.Size(s:40)
        emailButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        
        
        viewUpload = UIView(frame: CGRect(x: 0, y: emailButton.frame.origin.y + emailButton.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width, height: Common.Size(s:100) ))
        //        viewUpload.backgroundColor = .red
        scrollView.addSubview(viewUpload)
        
        //---CMND TRUOC
        viewInfoCMNDTruoc = UIView(frame: CGRect(x:0,y:0,width:scrollView.frame.size.width, height: 100))
        viewInfoCMNDTruoc.clipsToBounds = true
        viewUpload.addSubview(viewInfoCMNDTruoc)
        
        let lbTextCMNDTruoc = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMNDTruoc.textAlignment = .left
        lbTextCMNDTruoc.textColor = UIColor.black
        lbTextCMNDTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMNDTruoc.text = "Mặt trước CMND (*)"
        viewInfoCMNDTruoc.addSubview(lbTextCMNDTruoc)
        
        viewImageCMNDTruoc = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextCMNDTruoc.frame.origin.y + lbTextCMNDTruoc.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageCMNDTruoc.layer.borderWidth = 0.5
        viewImageCMNDTruoc.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageCMNDTruoc.layer.cornerRadius = 3.0
        viewInfoCMNDTruoc.addSubview(viewImageCMNDTruoc)
        
        let viewCMNDTruocButton = UIImageView(frame: CGRect(x: viewImageCMNDTruoc.frame.size.width/2 - (viewImageCMNDTruoc.frame.size.height * 2/3)/2, y: 0, width: viewImageCMNDTruoc.frame.size.height * 2/3, height: viewImageCMNDTruoc.frame.size.height * 2/3))
        viewCMNDTruocButton.image = UIImage(named:"AddImage")
        viewCMNDTruocButton.contentMode = .scaleAspectFit
        viewImageCMNDTruoc.addSubview(viewCMNDTruocButton)
        
        
        let lbCMNDTruocButton = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageCMNDTruoc.frame.size.height/3))
        lbCMNDTruocButton.textAlignment = .center
        lbCMNDTruocButton.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDTruocButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDTruocButton.text = "Thêm hình ảnh"
        viewImageCMNDTruoc.addSubview(lbCMNDTruocButton)
        viewInfoCMNDTruoc.frame.size.height = viewImageCMNDTruoc.frame.size.height + viewImageCMNDTruoc.frame.origin.y
        
        let tapShowCMNDTruoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDTruoc))
        viewImageCMNDTruoc.isUserInteractionEnabled = true
        viewImageCMNDTruoc.addGestureRecognizer(tapShowCMNDTruoc)
        
        
        
        
        //---------
        
        //---CMND SAU
        viewInfoCMNDSau = UIView(frame: CGRect(x:0,y:viewInfoCMNDTruoc.frame.size.height + viewInfoCMNDTruoc.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoCMNDSau.clipsToBounds = true
        viewUpload.addSubview(viewInfoCMNDSau)
        
        let lbTextCMNDSau = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMNDSau.textAlignment = .left
        lbTextCMNDSau.textColor = UIColor.black
        lbTextCMNDSau.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMNDSau.text = "Mặt sau CMND (*)"
        viewInfoCMNDSau.addSubview(lbTextCMNDSau)
        
        viewImageCMNDSau = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextCMNDSau.frame.origin.y + lbTextCMNDSau.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageCMNDSau.layer.borderWidth = 0.5
        viewImageCMNDSau.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageCMNDSau.layer.cornerRadius = 3.0
        viewInfoCMNDSau.addSubview(viewImageCMNDSau)
        
        let viewCMNDSauButton = UIImageView(frame: CGRect(x: viewImageCMNDSau.frame.size.width/2 - (viewImageCMNDSau.frame.size.height * 2/3)/2, y: 0, width: viewImageCMNDSau.frame.size.height * 2/3, height: viewImageCMNDSau.frame.size.height * 2/3))
        viewCMNDSauButton.image = UIImage(named:"AddImage")
        viewCMNDSauButton.contentMode = .scaleAspectFit
        viewImageCMNDSau.addSubview(viewCMNDSauButton)
        
        let lbCMNDSauButton = UILabel(frame: CGRect(x: 0, y: viewCMNDSauButton.frame.size.height + viewCMNDSauButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageCMNDSau.frame.size.height/3))
        lbCMNDSauButton.textAlignment = .center
        lbCMNDSauButton.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDSauButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDSauButton.text = "Thêm hình ảnh"
        viewImageCMNDSau.addSubview(lbCMNDSauButton)
        viewInfoCMNDSau.frame.size.height = viewImageCMNDSau.frame.size.height + viewImageCMNDSau.frame.origin.y
        
        let tapShowCMNDSau = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDSau))
        viewImageCMNDSau.isUserInteractionEnabled = true
        viewImageCMNDSau.addGestureRecognizer(tapShowCMNDSau)
        
        viewUpload.frame.size.height = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s:10)
        
        
        
        btSaveCustomer = UIButton()
        btSaveCustomer.frame = CGRect(x: tfEmail.frame.origin.x, y: viewUpload.frame.origin.y + viewUpload.frame.size.height + Common.Size(s:20), width: tfName.frame.size.width, height: tfEmail.frame.size.height * 1.2)
        btSaveCustomer.backgroundColor = UIColor(netHex:0xEF4A40)
        btSaveCustomer.setTitle("Lưu mới", for: .normal)
        btSaveCustomer.addTarget(self, action: #selector(actionSaveCustomer), for: .touchUpInside)
        btSaveCustomer.layer.borderWidth = 0.5
        btSaveCustomer.layer.borderColor = UIColor.white.cgColor
        btSaveCustomer.layer.cornerRadius = 3
        scrollView.addSubview(btSaveCustomer)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btSaveCustomer.frame.origin.y + btSaveCustomer.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 20))
        self.checkEmail = false
        emailButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.emailButton.text = item.title
            
            if(item.title != ""){
                self.checkEmail = true
            }
        }
        
        branchCompanyButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.branchCompanyButton.text = item.title
            let obj =  self.listBranchCompany.filter{ $0.TenChiNhanh == "\(item.title)" }.first
            if let code = obj?.ID {
                self.branchCode =  "\(code)"
            }
        }
        
        companyButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.companyButton.text = item.title
            let obj =  self.listCompany.filter{ $0.VendorName == "\(item.title)" }.first
            if let code = obj?.ID {
                self.vendorCode = "\(code)"
            }
            if let knox = obj?.Knox {
                if(knox.count > 0){
                    let title = "Thông báo"
                    let popup = PopupDialog(title: title, message: knox, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        self.checkCreateCustomer()
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }else{
                    self.checkCreateCustomer()
                }
            }else{
                self.checkCreateCustomer()
            }
            
            if let obj = obj?.ChiNhanh {
                var listBranch: [String] = []
                var listBranchId: [String] = []
                self.listBranchCompany = obj
                for item in obj {
                    listBranch.append("\(item.TenChiNhanh)")
                    listBranchId.append("\(item.ID)")
                }
                if(listBranch.count > 0){
                    self.branchCompanyButton.text = listBranch[0]
                    self.branchCode =  listBranchId[0]
                }else{
                    self.branchCompanyButton.text = ""
                    self.branchCode = ""
                }
                self.emailButton.text = ""
                self.branchCompanyButton.filterStrings(listBranch)
            }
//            if let email = obj?.DuoiEmail {
//                let listEmail = email.components(separatedBy: ";")
//                if (listEmail.count == 1){
//                    self.emailButton.text = listEmail[0]
//                    self.checkEmail = true
//                }
//                self.emailButton.filterStrings(listEmail)
//            }
            MPOSAPIManager.mpos_sp_GetVendor_DuoiEmail(VendorCode: "\(self.vendorCode)") { (results, err) in
                if(err.count<=0){
                    var listEmail:[String] = []
                    for item in results{
                        listEmail.append(item.DuoiEmail)
                    }
                    
                    self.emailButton.filterStrings(listEmail)
                }else{
                    
                }
            }
            
            
        }
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin công ty..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.getVendorFFriendV2(LoaiDN: "2", handler: { (results, err) in
            
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count<=0){
                    var listCom: [String] = []
                    self.listCompany = results
                    for item in results {
                        listCom.append("\(item.VendorName)")
                        if("\(item.ID)" == self.FtelCustomer!.VendorCode){
                            self.companyButton.text = item.VendorName
                            self.vendorCode = "\(item.ID)"
                        }
                    }
                    self.companyButton.filterStrings(listCom)
                }else{
                    
                }
                
            }
        })
        if(self.FtelCustomer!.prefix == "UTOP"){
            self.tfCMND.isUserInteractionEnabled = true
        }
    }
    func imageCMNDTruoc(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDTruoc.frame.size.width / sca
        viewImageCMNDTruoc.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDTruoc  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDTruoc.frame.size.width, height: heightImage))
        imgViewCMNDTruoc.contentMode = .scaleAspectFit
        imgViewCMNDTruoc.image = image
        viewImageCMNDTruoc.addSubview(imgViewCMNDTruoc)
        viewImageCMNDTruoc.frame.size.height = imgViewCMNDTruoc.frame.size.height + imgViewCMNDTruoc.frame.origin.y
        viewInfoCMNDTruoc.frame.size.height = viewImageCMNDTruoc.frame.size.height + viewImageCMNDTruoc.frame.origin.y
        viewInfoCMNDSau.frame.origin.y = viewInfoCMNDTruoc.frame.size.height + viewInfoCMNDTruoc.frame.origin.y + Common.Size(s:10)
        
        viewUpload.frame.size.height = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btSaveCustomer.frame.origin.y + btSaveCustomer.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:40))
        
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
           
             self.scanCMND(image: self.imgViewCMNDTruoc.image!)
        }
        
    }
    func imageCMNDSau(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDSau.frame.size.width / sca
        viewImageCMNDSau.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDSau  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDSau.frame.size.width, height: heightImage))
        imgViewCMNDSau.contentMode = .scaleAspectFit
        imgViewCMNDSau.image = image
        viewImageCMNDSau.addSubview(imgViewCMNDSau)
        viewImageCMNDSau.frame.size.height = imgViewCMNDSau.frame.size.height + imgViewCMNDSau.frame.origin.y
        viewInfoCMNDSau.frame.size.height = viewImageCMNDSau.frame.size.height + viewImageCMNDSau.frame.origin.y
        
        
        viewUpload.frame.size.height = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btSaveCustomer.frame.origin.y + btSaveCustomer.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:40))
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "2", image: self.imgViewCMNDSau.image!)
        }
        
    }
    func checkCreateCustomer(){
        
        MPOSAPIManager.sp_mpos_CheckCreateCustomer(VendorCode: "\(self.vendorCode)", LoaiKH: "2", handler: { (result, message) in
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
    func uploadImageV2(type:String,image:UIImage){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang upload hình ảnh..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        if let imageData:NSData = image.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
            let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
            MPOSAPIManager.UploadImage_CalllogScoring(IdCardCode: "0", base64: strBase64, type: type, CMND: self.tfCMND.text ?? "") { (result, err) in
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    if(err.count <= 0){
                        if (type == "1") {
                            self.CRD_MT_CMND2 = result
                        }
                        if (type == "2"){
                            self.CRD_MS_CMND2 = result
                            
                        }
                        
                        
                        
                    }else{
                        let title = "THÔNG BÁO(1)"
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
        
    }
    func scanCMND(image:UIImage){
         let newViewController = LoadingViewController()
         newViewController.content = "Đang nhận dạng CMND..."
         newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
         newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
         self.navigationController?.present(newViewController, animated: true, completion: nil)
         let nc = NotificationCenter.default
         
         if let imageData:NSData = image.jpegData(compressionQuality: Common.resizeImageScanCMND) as NSData?{
             let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
             MPOSAPIManager.mpos_DetectIDCard(Image_CMND:"\(strBase64)") { (result,err) in
                 nc.post(name: Notification.Name("dismissLoading"), object: nil)
                 let when = DispatchTime.now() + 0.5
                 DispatchQueue.main.asyncAfter(deadline: when) {
                     if(err.count <= 0){
                         if(result != nil){
                         
                            if(result!.IdCard == self.tfCMND.text!){
                                self.isFalseCMNDTruoc = false
                                self.tfAddress.text = result!.Address
                                self.uploadImageV2(type: "1", image: self.imgViewCMNDTruoc.image!)
                            }else{
                                let title = "THÔNG BÁO"
                                let popup = PopupDialog(title: title, message: "CMND của KH: \(self.tfCMND.text!) \n CMND trên ảnh \(result!.IdCard) \n CMND không khớp vui lòng kiểm tra lại", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                    self.idDetect = result!.IdCard
                                    self.isFalseCMNDTruoc = true
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }
                            
                             
                         }
                         
                         
                         
                     }else{
                        let title = "THÔNG BÁO"
                        let popup = PopupDialog(title: title, message: "CMND của KH: \(self.tfCMND.text!) \n CMND trên ảnh \("") \n CMND không khớp vui lòng kiểm tra lại", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            //self.idDetect = result!.IdCard
                            self.isFalseCMNDTruoc = true
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                     }
                 }
                 
             }
         }
         
     }
    @objc func tapShowCMNDTruoc(sender:UITapGestureRecognizer) {
        self.posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowCMNDSau(sender:UITapGestureRecognizer) {
        self.posImageUpload = 2
        self.thisIsTheFunctionWeAreCalling()
    }

    @objc func actionSaveCustomer(){
        let cmnd = tfCMND.text!
        if(isFalseCMNDTruoc == true){
            let title = "THÔNG BÁO"
            let popup = PopupDialog(title: title, message: "CMND của KH: \(self.tfCMND.text!) \n CMND trên ảnh \(self.idDetect) \n CMND không khớp kiểm tra lại", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                self.isFalseCMNDTruoc = true
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        if (cmnd.count == 0){
            self.showDialog(message: "CMND không được để trống!")
            self.tfCMND.becomeFirstResponder()
            return
           }
           if (cmnd.count == 0){
               self.showDialog(message: "CMND không được để trống!")
               return
           }
           if (cmnd.count == 9 || cmnd.count == 12){
               
           }else{
               self.showDialog(message: "CMND sai định dạng")
               return
           }
           
           let name = tfName.text!
           if (name.count == 0){
               self.showDialog(message: "Tên KH không được để trống!")
               tfName.becomeFirstResponder()
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
           let company = self.vendorCode
           if (company.count == 0){
               self.showDialog(message: "Công ty không được để trống!")
               return
           }
           if (self.companyButton.text!.count == 0){
               self.showDialog(message: "Công ty không được để trống!")
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
               self.showDialog(message: "Chi nhánh công ty không được để trống!")
               return
           }
           if (branchCompanyButton.text!.count == 0 && self.listBranchCompany.count > 0){
               self.showDialog(message: "Chi nhánh công ty không được để trống!")
               return
           }
           let email = tfEmail.text!
           //        if (email.count == 0){
           //            self.showDialog(message: "Tên Email không được để trống!")
           //            return
           //        }
           //        if(checkEmail == false){
           //            self.showDialog(message: "Bạn phải chọn đuôi Email!")
           //            return
           //        }
           let emailLast = emailButton.text!
           //        if (emailLast.count == 0){
           //            self.showDialog(message: "Đuôi Email không được để trống!")
           //            return
           //        }
           
           let emailFull = "\(email)\(emailLast)"
        if(self.tfSoHD.text! == ""){
            self.showDialog(message: "Số hợp đồng không được để trống!")
            return
        }
//        if(self.tfVoucher.text! == ""){
//            self.showDialog(message: "Voucher không được để trống!")
//            return
//        }
        
        if (imgViewCMNDTruoc == nil){
            
            let alert = UIAlertController(title: "Thông báo", message: "Chưa chụp ảnh cmnd trước !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        if (imgViewCMNDSau == nil){
                
                let alert = UIAlertController(title: "Thông báo", message: "Chưa chụp ảnh cmnd sau !", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
     
       
         let newViewController = LoadingViewController()
         newViewController.content = "Đang đăng ký thông tin KH..."
         newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
         newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
         self.navigationController?.present(newViewController, animated: true, completion: nil)
         let nc = NotificationCenter.default
         MPOSAPIManager.sp_mpos_UploadImageScoring(UserID:Cache.user!.UserName,IdCardCode:"0",
                                                   Url_MT_CMND:CRD_MT_CMND2,
                                                   Url_MS_CMND:CRD_MS_CMND2,
                                                   Url_GPLX_MT:"",
                                                   Url_GPLX_MS:"",
                                                   Url_TheNV:"",
                                                   Url_ChanDungKH:"",
                                                   Url_XacNhanNhanSu:"",
                                                   Url_SoHoKhau_1:"",
                                                   Url_SoHoKhau_2:"",
                                                   Url_SoHoKhau_3:"",
                                                   Url_SoHoKhau_4:"",
                                                   Url_SoHoKhau_5:"",
                                                   Url_SoHoKhau_6:"",
                                                   Url_SoHoKhau_7:"",
                                                   Url_SaoKeLuong_1:"",
                                                   Url_SaoKeLuong_2:"",
                                                   Url_SaoKeLuong_3:"",
                                                   CMND: self.tfCMND.text!,VendorCode: "\(company)", handler: { (result, err) in
             let when = DispatchTime.now() + 0.5
             DispatchQueue.main.asyncAfter(deadline: when) {
               
                 if(err.count <= 0){
                     if(result[0].Result == 0){
                          nc.post(name: Notification.Name("dismissLoading"), object: nil)
                         let alert = UIAlertController(title: "Thông báo", message: result[0].Message, preferredStyle: .alert)
                         
                         alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                             
                         })
                         self.present(alert, animated: true)
                         return
                     }
                     
//                     let email = self.tfEmail.text!
//                     let duoiMail = self.emailButton.text!
                    // var emailKH = ""
//                     if (email.count > 0 && duoiMail.count > 0){
//                         emailKH = "\(email)\(duoiMail)"
//                     }
                     
                    
                     
                     
                    MPOSAPIManager.AddCustomerFFriend(VendorCode: company, CMND: cmnd, FullName: name, SDT: phone, HoKhauTT: "\(self.tfAddress.text!)", NgayCapCMND: "", NoiCapCMND: "", ChucVu: "", NgayKiHD: "", SoTKNH: "", IdBank: "", ChiNhanhNH: "", Email: emailFull, Note: "", CreateBy: "\(Cache.user!.UserName)", FileAttachName: "", ChiNhanhDN: branchCode,IDCardCode: "0", LoaiKH: "2", NgaySinh: "", CreditCard: "", MaNV_KH: "", VendorCodeRef: "", CMND_TinhThanhPho: "0", CMND_QuanHuyen: "0", CMND_PhuongXa: "", NguoiLienHe: "", SDT_NguoiLienHe: "", QuanHeVoiNguoiLienHe: "0", NguoiLienHe_2: "", SDT_NguoiLienHe_2: "", QuanHeVoiNguoiLienHe_2: "0", AnhDaiDien: "",GioThamDinh_TimeFrom:"",GioThamDinh_TimeTo:"",GioThamDinh_OtherTime:"",IdCardcodeRef:"",TenSPThamDinh:"",Gender: -1,IDImageXN:"\(result[0].IDImageXN)",ListIDSaoKe:"",NguoiLienHe_3:"",SDT_NguoiLienHe_3:"",QuanHeVoiNguoiLienHe_3:"",NguoiLienHe_4:"",SDT_NguoiLienHe_4:"",QuanHeVoiNguoiLienHe_4:"",EVoucher:"",SoHopDong:"\(self.tfSoHD.text!)",isQrCode:"1",isComplete:"",OTP:"") { (result,code, err) in
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
                                    
                                    _ = self.navigationController?.popToRootViewController(animated: true)
                                    self.dismiss(animated: true, completion: nil)
                                    
                                    let myDict = ["CMND": cmnd]
                                    let nc = NotificationCenter.default
                                    nc.post(name: Notification.Name("AutoLoadCMND"), object: myDict)
                                    
                                }
                                // Add buttons to dialog
                                popup.addButtons([buttonOne])
                                
                                // Present dialog
                                self.present(popup, animated: true, completion: nil)
                                 
                                 
                                 
                             }else{
                                 nc.post(name: Notification.Name("dismissLoading"), object: nil)
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
                     nc.post(name: Notification.Name("dismissLoading"), object: nil)
                     let title = "THÔNG BÁO"
                     let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                         print("Completed")
                     }
                     let buttonOne = CancelButton(title: "OK") {
                     }
                     popup.addButtons([buttonOne])
                     self.present(popup, animated: true, completion: nil)
                 }
             }
         })
     }
    @objc func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
          if (textField == tfName){
              let str = tfName.text!
              if(str.count > 0){
                  tfName.text = str.capitalized
              }else{
                  
                  
              }
        }
        
    }
}

extension CreateFtelFFriendViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
        //self.openCamera()
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            //            alert.popoverPresentationController?.sourceView = sender
            //            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        self.present(alert, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        if (self.posImageUpload == 1){
            
            self.imageCMNDTruoc(image: image)
        }else if (self.posImageUpload == 2){
            
            self.imageCMNDSau(image: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Open the camera
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Choose image from camera roll
    
    func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}
