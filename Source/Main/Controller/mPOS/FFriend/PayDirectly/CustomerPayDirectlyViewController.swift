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
import DLRadioButton
import SwiftyBeaver
class CustomerPayDirectlyViewController: UIViewController,UITextFieldDelegate {
    
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
    
    var checkResult:Int = 0
    var checkMessage:String = ""
    var checkEmail:Bool = false
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
    var posImageUpload:Int = -1
    var positionButton: SearchTextField!
    var viewUpload:UIView!
    var tfDate:UITextField!
    var imagePicker = UIImagePickerController()
    var CRD_MT_CMND2:String = ""
    var CRD_MS_CMND2:String = ""
    var CRD_TheNV2:String = ""
    var listPosition: [ChucVuFFriend] = []
    var positionCode:String  = ""
    var detailView:UIView!
    var tfOTP:UITextField!
    var radOTP:DLRadioButton!
    var radCallLog:DLRadioButton!
    var htType:Int = 0
    var viewOTP:UIView!
    //--
     var viewInfoTheNV:UIView!
     var viewImageFormRegister:UIView!
     var imgViewFormRegister: UIImageView!
     var viewFormRegister:UIView!
     //--
      var heightView:CGFloat = 0.0
     var tfDateBirthday:UITextField!
    var cmnDetect:String = ""
     let log = SwiftyBeaver.self
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Tạo KH Trả Thẳng"
        
        viewUpload = UIView(frame: CGRect(x: 0, y:  Common.Size(s:10), width: scrollView.frame.size.width, height: Common.Size(s:100) ))
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
        
        viewInfoTheNV = UIView(frame: CGRect(x:0,y:viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoTheNV.clipsToBounds = true
        viewUpload.addSubview(viewInfoTheNV)
        
        let lbTextFormRegister = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextFormRegister.textAlignment = .left
        lbTextFormRegister.textColor = UIColor.black
        lbTextFormRegister.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextFormRegister.text = "Thẻ nhân viên"
        viewInfoTheNV.addSubview(lbTextFormRegister)
        
        let  lbInfoCheckForm = UILabel(frame: CGRect(x:scrollView.frame.size.width/2, y: lbTextFormRegister.frame.origin.y, width: scrollView.frame.size.width/2 - Common.Size(s:15), height: Common.Size(s: 14)))
        lbInfoCheckForm.textAlignment = .right
        lbInfoCheckForm.textColor = UIColor(netHex:0x47B054)
        lbInfoCheckForm.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        // lbInfoCheckForm.attributedText = underlineAttributedStringAvatarSign
        viewInfoTheNV.addSubview(lbInfoCheckForm)
        let tapShowCheckForm = UITapGestureRecognizer(target: self, action: #selector(CustomerInstallmentViewController.tapShowTheNV))
        lbInfoCheckForm.isUserInteractionEnabled = true
        lbInfoCheckForm.addGestureRecognizer(tapShowCheckForm)
        
        
        viewImageFormRegister = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextFormRegister.frame.origin.y + lbTextFormRegister.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageFormRegister.layer.borderWidth = 0.5
        viewImageFormRegister.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageFormRegister.layer.cornerRadius = 3.0
        viewInfoTheNV.addSubview(viewImageFormRegister)
        
        let viewFormRegisterButton = UIImageView(frame: CGRect(x: viewImageFormRegister.frame.size.width/2 - (viewImageFormRegister.frame.size.height * 2/3)/2, y: 0, width: viewImageFormRegister.frame.size.height * 2/3, height: viewImageFormRegister.frame.size.height * 2/3))
        viewFormRegisterButton.image = UIImage(named:"AddImage")
        viewFormRegisterButton.contentMode = .scaleAspectFit
        viewImageFormRegister.addSubview(viewFormRegisterButton)
        
        let lbFormRegisterButton = UILabel(frame: CGRect(x: 0, y: viewFormRegisterButton.frame.size.height + viewFormRegisterButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageFormRegister.frame.size.height/3))
        lbFormRegisterButton.textAlignment = .center
        lbFormRegisterButton.textColor = UIColor(netHex:0xc2c2c2)
        lbFormRegisterButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbFormRegisterButton.text = "Thêm hình ảnh"
        viewImageFormRegister.addSubview(lbFormRegisterButton)
        viewInfoTheNV.frame.size.height = viewImageFormRegister.frame.size.height + viewImageFormRegister.frame.origin.y
        
        let tapShowFormRegister = UITapGestureRecognizer(target: self, action: #selector(self.tapShowTheNV))
        viewImageFormRegister.isUserInteractionEnabled = true
        viewImageFormRegister.addGestureRecognizer(tapShowFormRegister)
        
        viewUpload.frame.size.height = viewInfoTheNV.frame.origin.y + viewInfoTheNV.frame.size.height + Common.Size(s:10)
        
        detailView = UIView()
        detailView.frame = CGRect(x: 0, y:viewUpload.frame.origin.y + viewUpload.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        detailView.backgroundColor = UIColor.white
        scrollView.addSubview(detailView)
        
        let lbTextType = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextType.textAlignment = .left
        lbTextType.textColor = UIColor.black
        lbTextType.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextType.text = "Loại khách hàng (*)"
        detailView.addSubview(lbTextType)
        
        let lbType = UILabel(frame: CGRect(x: Common.Size(s:15), y:lbTextType.frame.size.height + lbTextType.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbType.textAlignment = .center
        lbType.textColor = UIColor.black
        lbType.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbType.text = "Trả thẳng"
        detailView.addSubview(lbType)
        
        let lbTextCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbType.frame.size.height + lbType.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMND.textAlignment = .left
        lbTextCMND.textColor = UIColor.black
        lbTextCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMND.text = "CMND (*)"
        detailView.addSubview(lbTextCMND)
        
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
        detailView.addSubview(tfCMND)
        if(cmnd != nil){
            tfCMND.text = cmnd
        }
        
        let lbTextName = UILabel(frame: CGRect(x: Common.Size(s:15), y:tfCMND.frame.size.height + tfCMND.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextName.textAlignment = .left
        lbTextName.textColor = UIColor.black
        lbTextName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextName.text = "Tên khách hàng (*)"
        detailView.addSubview(lbTextName)
        
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
        detailView.addSubview(tfName)
        
        
        let  lbTextBirthday = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfName.frame.size.height + tfName.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextBirthday.textAlignment = .left
        lbTextBirthday.textColor = UIColor.black
        lbTextBirthday.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextBirthday.text = "Ngày sinh (*)"
        detailView.addSubview(lbTextBirthday)
        
        tfDateBirthday = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextBirthday.frame.origin.y + lbTextBirthday.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfDateBirthday.placeholder = "Nhập dd/MM/yyyy"
        tfDateBirthday.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDateBirthday.borderStyle = UITextField.BorderStyle.roundedRect
        tfDateBirthday.autocorrectionType = UITextAutocorrectionType.no
        tfDateBirthday.keyboardType = UIKeyboardType.numberPad
        tfDateBirthday.returnKeyType = UIReturnKeyType.done
        tfDateBirthday.clearButtonMode = UITextField.ViewMode.whileEditing
        tfDateBirthday.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDateBirthday.delegate = self
        //tfDateBirthday.addTarget(self, action: #selector(CustomerPayDirectlyViewController.textFieldDidEndEditing), for: .editingDidEnd)
        detailView.addSubview(tfDateBirthday)
        
        let lbTextPhone = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfDateBirthday.frame.size.height + tfDateBirthday.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhone.textAlignment = .left
        lbTextPhone.textColor = UIColor.black
        lbTextPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhone.text = "Số điện thoại (*)"
        detailView.addSubview(lbTextPhone)
        
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
        detailView.addSubview(tfPhone)
        
        let lbTextCompany = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhone.frame.size.height + tfPhone.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCompany.textAlignment = .left
        lbTextCompany.textColor = UIColor.black
        lbTextCompany.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCompany.text = "Tên công ty (*)"
        detailView.addSubview(lbTextCompany)
        
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
        detailView.addSubview(companyButton)
        
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
        detailView.addSubview(lbTextBranchCompany)
        
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
        detailView.addSubview(branchCompanyButton)
        
        branchCompanyButton.startVisible = true
        branchCompanyButton.theme.bgColor = UIColor.white
        branchCompanyButton.theme.fontColor = UIColor.black
        branchCompanyButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        branchCompanyButton.theme.cellHeight = Common.Size(s:40)
        branchCompanyButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        let lbTextPosition = UILabel(frame: CGRect(x: Common.Size(s:15), y: branchCompanyButton.frame.size.height + branchCompanyButton.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPosition.textAlignment = .left
        lbTextPosition.textColor = UIColor.black
        lbTextPosition.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPosition.text = "Chức vụ (*)"
        detailView.addSubview(lbTextPosition)
        
        positionButton = SearchTextField(frame: CGRect(x: lbTextBranchCompany.frame.origin.x, y: lbTextPosition.frame.origin.y + lbTextPosition.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        positionButton.placeholder = "Chọn chức vụ"
        positionButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        positionButton.borderStyle = UITextField.BorderStyle.roundedRect
        positionButton.autocorrectionType = UITextAutocorrectionType.no
        positionButton.keyboardType = UIKeyboardType.default
        positionButton.returnKeyType = UIReturnKeyType.done
        positionButton.clearButtonMode = UITextField.ViewMode.whileEditing
        positionButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        positionButton.delegate = self
        detailView.addSubview(positionButton)
        
        positionButton.startVisible = true
        positionButton.theme.bgColor = UIColor.white
        positionButton.theme.fontColor = UIColor.black
        positionButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        positionButton.theme.cellHeight = Common.Size(s:40)
        positionButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        let lbTextDate = UILabel(frame: CGRect(x: Common.Size(s:15), y: positionButton.frame.size.height + positionButton.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextDate.textAlignment = .left
        lbTextDate.textColor = UIColor.black
        lbTextDate.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextDate.text = "Ngày bắt đầu làm việc ở DN"
        detailView.addSubview(lbTextDate)
        
        tfDate = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextDate.frame.size.height + lbTextDate.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfDate.placeholder = ""
        tfDate.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDate.borderStyle = UITextField.BorderStyle.roundedRect
        tfDate.autocorrectionType = UITextAutocorrectionType.no
        tfDate.keyboardType = UIKeyboardType.numberPad
        tfDate.returnKeyType = UIReturnKeyType.done
        tfDate.clearButtonMode = UITextField.ViewMode.whileEditing
        tfDate.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDate.delegate = self
        tfDate.placeholder = "Nhập ngày/tháng/năm"
        detailView.addSubview(tfDate)
        
        
        let lbTextEmail = UILabel(frame: CGRect(x: Common.Size(s:15), y:tfDate.frame.size.height + tfDate.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextEmail.textAlignment = .left
        lbTextEmail.textColor = UIColor.black
        lbTextEmail.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextEmail.text = "Email KH (*)"
        detailView.addSubview(lbTextEmail)
        
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
        detailView.addSubview(tfEmail)
        
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
        detailView.addSubview(emailButton)
        
        emailButton.startVisible = true
        emailButton.theme.bgColor = UIColor.white
        emailButton.theme.fontColor = UIColor.black
        emailButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        emailButton.theme.cellHeight = Common.Size(s:40)
        emailButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        
        let lbTextHT = UILabel(frame: CGRect(x: Common.Size(s:15), y:emailButton.frame.size.height + emailButton.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextHT.textAlignment = .left
        lbTextHT.textColor = UIColor.black
        lbTextHT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextHT.text = "Hình thức thẩm định"
        detailView.addSubview(lbTextHT)
        
        radOTP = createRadioButtonHT(CGRect(x: lbTextHT.frame.origin.x,y:lbTextHT.frame.origin.y + lbTextHT.frame.size.height + Common.Size(s:10) , width: lbTextHT.frame.size.width - Common.Size(s:150), height: Common.Size(s:15)), title: "Thẩm định qua OTP", color: UIColor.black);
        detailView.addSubview(radOTP)
        radOTP.isSelected = true
        htType = 1
        
        
        let lbShowMoreHTTD = UILabel(frame: CGRect(x:radOTP.frame.size.width + radOTP.frame.origin.x, y:radOTP.frame.origin.y, width: Common.Size(s:30), height: Common.Size(s:14)))
        lbShowMoreHTTD.textAlignment = .left
        lbShowMoreHTTD.textColor = UIColor(netHex:0x2B60DE)
        lbShowMoreHTTD.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbShowMoreHTTD.text = "(?)"
        detailView.addSubview(lbShowMoreHTTD)
        
        let tapShowHTTD = UITapGestureRecognizer(target: self, action: #selector(CustomerPayDirectlyViewController.showHTTD))
        lbShowMoreHTTD.isUserInteractionEnabled = true
        lbShowMoreHTTD.addGestureRecognizer(tapShowHTTD)
        
        radCallLog = createRadioButtonHT(CGRect(x: lbTextHT.frame.origin.x ,y:radOTP.frame.origin.y + radOTP.frame.size.height + Common.Size(s:10), width: lbTextHT.frame.size.width, height: radOTP.frame.size.height), title: "Thẩm định qua CallLog (Duyệt thủ công)", color: UIColor.black);
        detailView.addSubview(radCallLog)
       
        
        viewOTP = UIView(frame: CGRect(x: 0, y:  radCallLog.frame.size.height + radCallLog.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width, height: Common.Size(s:100) ))
        viewOTP.clipsToBounds = true
        detailView.addSubview(viewOTP)
        
        
        let lbOTP = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbOTP.textAlignment = .left
        lbOTP.textColor = UIColor.black
        lbOTP.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbOTP.text = "Mã xác nhận OTP"
        viewOTP.addSubview(lbOTP)
        
        tfOTP = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbOTP.frame.size.height + lbOTP.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:180) , height: Common.Size(s:40)))
        tfOTP.placeholder = ""
        tfOTP.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfOTP.borderStyle = UITextField.BorderStyle.roundedRect
        tfOTP.autocorrectionType = UITextAutocorrectionType.no
        tfOTP.keyboardType = UIKeyboardType.default
        tfOTP.returnKeyType = UIReturnKeyType.done
        tfOTP.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfOTP.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfOTP.delegate = self
        tfOTP.placeholder = "Nhập mã OTP"
        viewOTP.addSubview(tfOTP)
        
        let btOTP = UIButton()
        btOTP.frame = CGRect(x: tfOTP.frame.origin.x + tfOTP.frame.size.width + Common.Size(s:10), y: lbOTP.frame.origin.y + lbOTP.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:180), height: Common.Size(s:40))
        btOTP.backgroundColor = UIColor(netHex:0x00955E)
        btOTP.setTitle("Lấy mã OTP", for: .normal)
        btOTP.addTarget(self, action: #selector(actionSendOTP), for: .touchUpInside)
        btOTP.layer.borderWidth = 0.5
        btOTP.layer.borderColor = UIColor.white.cgColor
        btOTP.layer.cornerRadius = 5.0
        viewOTP.addSubview(btOTP)
        
        viewOTP.frame.size.height = tfOTP.frame.size.height + tfOTP.frame.origin.y + Common.Size(s:10)
        self.heightView =  viewOTP.frame.size.height

        
        
        btSaveCustomer = UIButton()
        btSaveCustomer.frame = CGRect(x: tfEmail.frame.origin.x, y: viewOTP.frame.origin.y + viewOTP.frame.size.height + Common.Size(s:10), width: tfName.frame.size.width, height: tfEmail.frame.size.height * 1.2)
        btSaveCustomer.backgroundColor = UIColor(netHex:0xEF4A40)
        btSaveCustomer.setTitle("Lưu mới", for: .normal)
        btSaveCustomer.addTarget(self, action: #selector(actionCompleteImage), for: .touchUpInside)
        btSaveCustomer.layer.borderWidth = 0.5
        btSaveCustomer.layer.borderColor = UIColor.white.cgColor
        btSaveCustomer.layer.cornerRadius = 3
        detailView.addSubview(btSaveCustomer)
        detailView.frame.size.height = btSaveCustomer.frame.origin.y + btSaveCustomer.frame.size.height + Common.Size(s:10)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: detailView.frame.origin.y + detailView.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 20))
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
        positionButton.itemSelectionHandler = { filteredResults, itemPosition in
                let item = filteredResults[itemPosition]
                self.positionButton.text = item.title
                let obj =  self.listPosition.filter{ $0.ChucVu == "\(item.title)" }.first
//                if let ob = obj?.HanMuc {
//                   // self.tfLimit.text = ob
//                    self.tfLimit.text = Common.convertCurrencyFloatV2(value: Float(ob) as! Float)
//                }else{
//                    self.tfLimit.text = ""
//                }
                if let id = obj?.ID {
                    self.positionCode = id
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
                    }
                    self.companyButton.filterStrings(listCom)
                    MPOSAPIManager.getChucVuFFriend(handler: { (cv, err) in
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            if(err.count<=0){
                                var listPosition: [String] = []
                                self.listPosition = cv
                                for item in cv {
                                    listPosition.append("\(item.ChucVu)")
                                }
                                self.positionButton.filterStrings(listPosition)
                                
                            }else{
                                
                            }
                        }
                    })
                }else{
                    
                }
                
            }
        })
    }
    @objc func actionSendOTP(){
        if(self.tfCMND.text == ""){
            let title = "THÔNG BÁO"
            let popup = PopupDialog(title: title, message: "Vui lòng nhập cmnd KH !", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        if(self.tfPhone.text == ""){
            let title = "THÔNG BÁO"
            let popup = PopupDialog(title: title, message: "Vui lòng nhập sdt KH !", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
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
        if(email == "" || emailLast == ""){
            self.showDialog(message: "Email không được để trống!")
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
        let newViewController = LoadingViewController()
        newViewController.content = "Đang gửi otp vui lòng chờ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_CheckEmail_Vendor_SendOTP(vendorcode:"\(self.vendorCode)",idcard:"\(self.tfCMND.text!)",phonenumber:"\(self.tfPhone.text!)",email:"\(emailFull)",idcardcode:"0") { (stauts,message,err) in
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                if(err.count <= 0){
                    
                    let title = "THÔNG BÁO"
                    let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                    
                    
                }else{
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
    @objc func tapShowCMNDTruoc(sender:UITapGestureRecognizer) {
        self.posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowCMNDSau(sender:UITapGestureRecognizer) {
        self.posImageUpload = 2
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowTheNV(sender:UITapGestureRecognizer) {
        self.posImageUpload = 5
        self.thisIsTheFunctionWeAreCalling()
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
        viewInfoTheNV.frame.origin.y = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s:10)
        
        viewUpload.frame.size.height = viewInfoTheNV.frame.size.height + viewInfoTheNV.frame.origin.y
        detailView.frame.origin.y = viewUpload.frame.origin.y + viewUpload.frame.size.height + Common.Size(s:10)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: detailView.frame.origin.y + detailView.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
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
        viewInfoTheNV.frame.origin.y = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s:10)
        
        viewUpload.frame.size.height = viewInfoTheNV.frame.size.height + viewInfoTheNV.frame.origin.y
        
        
        detailView.frame.origin.y = viewUpload.frame.origin.y + viewUpload.frame.size.height + Common.Size(s:10)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: detailView.frame.origin.y + detailView.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "2", image: self.imgViewCMNDSau.image!)
        }
        
    }
    func imageTheNV(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageFormRegister.frame.size.width / sca
        viewImageFormRegister.subviews.forEach { $0.removeFromSuperview() }
        imgViewFormRegister  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageFormRegister.frame.size.width, height: heightImage))
        imgViewFormRegister.contentMode = .scaleAspectFit
        imgViewFormRegister.image = image
        viewImageFormRegister.addSubview(imgViewFormRegister)
        viewImageFormRegister.frame.size.height = imgViewFormRegister.frame.size.height + imgViewFormRegister.frame.origin.y
        viewInfoTheNV.frame.size.height = viewImageFormRegister.frame.size.height + viewImageFormRegister.frame.origin.y
   
        
        viewUpload.frame.size.height = viewInfoTheNV.frame.size.height + viewInfoTheNV.frame.origin.y
        detailView.frame.origin.y = viewUpload.frame.origin.y + viewUpload.frame.size.height + Common.Size(s:10)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: detailView.frame.origin.y + detailView.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "5", image: self.imgViewFormRegister.image!)
        }
        
      }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         
        
         if(textField == tfDate || textField == tfDateBirthday){
             guard var number = textField.text else {
                 return true
             }
             // If user try to delete, remove the char manually
             if string == "" {
                 number.remove(at: number.index(number.startIndex, offsetBy: range.location))
             }
             // Remove all mask characters
             number = number.replacingOccurrences(of: "/", with: "")
             number = number.replacingOccurrences(of: "D", with: "")
             number = number.replacingOccurrences(of: "M", with: "")
             number = number.replacingOccurrences(of: "Y", with: "")
             
             // Set the position of the cursor
             var cursorPosition = number.count+1
             if string == "" {
                 //if it's delete, just take the position given by the delegate
                 cursorPosition = range.location
             } else {
                 // If not, take into account the slash
                 if cursorPosition > 2 && cursorPosition < 5 {
                     cursorPosition += 1
                 } else if cursorPosition > 4 {
                     cursorPosition += 2
                 }
             }
             // Stop editing if we have rich the max numbers
             if number.count == 8 { return false }
             // Readd all mask char
             number += string
             while number.count < 8 {
                 if number.count < 2 {
                     number += "D"
                 } else if number.count < 4 {
                     number += "M"
                 } else {
                     number += "Y"
                 }
             }
             number.insert("/", at: number.index(number.startIndex, offsetBy: 4))
             number.insert("/", at: number.index(number.startIndex, offsetBy: 2))
             
             // Some styling
             let enteredTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
             let maskTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
             
             let partOne = NSMutableAttributedString(string: String(number.prefix(cursorPosition)), attributes: enteredTextAttribute)
             let partTwo = NSMutableAttributedString(string: String(number.suffix(number.count-cursorPosition)), attributes: maskTextAttribute)
             
             let combination = NSMutableAttributedString()
             
             combination.append(partOne)
             combination.append(partTwo)
             
             textField.attributedText = combination
             textField.setCursor(position: cursorPosition)
             return false
             
             
         }
         return true
         
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
                                self.cmnDetect = result!.IdCard
                                //self.tfAddress.text = result!.Address
                                self.tfName.text = result!.FullName
                                self.tfDateBirthday.text = result!.BirthDay
                                self.uploadImageV2(type: "1", image: self.imgViewCMNDTruoc.image!)
                            }else{
                                let title = "THÔNG BÁO"
                                let popup = PopupDialog(title: title, message: "CMND của KH: \(self.tfCMND.text!) \n CMND trên ảnh \(result!.IdCard) \n CMND không khớp vui lòng kiểm tra lại", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                    self.CRD_MT_CMND2 = ""
                                     self.cmnDetect = ""
                                    //
                                    self.viewImageCMNDTruoc.subviews.forEach { $0.removeFromSuperview() }
                                    self.viewImageCMNDTruoc.frame.size.width = self.scrollView.frame.size.width - Common.Size(s:30)
                                    self.viewImageCMNDTruoc.frame.size.height = Common.Size(s:60)
                                    let lbTextCMNDTruoc = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: self.scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
                                    lbTextCMNDTruoc.textAlignment = .left
                                    lbTextCMNDTruoc.textColor = UIColor.black
                                    lbTextCMNDTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                                    lbTextCMNDTruoc.text = "Mặt trước CMND (*)"
                                    self.viewInfoCMNDTruoc.addSubview(lbTextCMNDTruoc)
                                    
                                    
                                    let viewCMNDTruocButton = UIImageView(frame: CGRect(x: self.viewImageCMNDTruoc.frame.size.width/2 - (self.viewImageCMNDTruoc.frame.size.height * 2/3)/2, y: 0, width: self.viewImageCMNDTruoc.frame.size.height * 2/3, height: self.viewImageCMNDTruoc.frame.size.height * 2/3))
                                    viewCMNDTruocButton.image = UIImage(named:"AddImage")
                                    viewCMNDTruocButton.contentMode = .scaleAspectFit
                                    self.viewImageCMNDTruoc.addSubview(viewCMNDTruocButton)
                                    
                                    
                                    let lbCMNDTruocButton = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: self.scrollView.frame.size.width - Common.Size(s:30), height: self.viewImageCMNDTruoc.frame.size.height/3))
                                    lbCMNDTruocButton.textAlignment = .center
                                    lbCMNDTruocButton.textColor = UIColor(netHex:0xc2c2c2)
                                    lbCMNDTruocButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                                    lbCMNDTruocButton.text = "Thêm hình ảnh"
                                    self.viewImageCMNDTruoc.addSubview(lbCMNDTruocButton)
                                    self.viewInfoCMNDTruoc.frame.size.height = self.viewImageCMNDTruoc.frame.size.height + self.viewImageCMNDTruoc.frame.origin.y
                                    self.viewInfoCMNDSau.frame.origin.y = self.viewInfoCMNDTruoc.frame.size.height + self.viewInfoCMNDTruoc.frame.origin.y + Common.Size(s:10)
                                    self.viewInfoTheNV.frame.origin.y = self.viewInfoCMNDSau.frame.size.height + self.viewInfoCMNDSau.frame.origin.y + Common.Size(s:10)
                                    self.viewUpload.frame.size.height = self.viewInfoTheNV.frame.size.height + self.viewInfoTheNV.frame.origin.y
                                  
                                  
                                      self.detailView.frame.origin.y = self.viewUpload.frame.size.height + self.viewUpload.frame.origin.y + Common.Size(s:20)
                                    self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.detailView.frame.origin.y + self.detailView.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
                                    
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
                            self.CRD_MT_CMND2 = ""
                            //
                            self.viewImageCMNDTruoc.subviews.forEach { $0.removeFromSuperview() }
                            self.viewImageCMNDTruoc.frame.size.width = self.scrollView.frame.size.width - Common.Size(s:30)
                            self.viewImageCMNDTruoc.frame.size.height = Common.Size(s:60)
                            let lbTextCMNDTruoc = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: self.scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
                            lbTextCMNDTruoc.textAlignment = .left
                            lbTextCMNDTruoc.textColor = UIColor.black
                            lbTextCMNDTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                            lbTextCMNDTruoc.text = "Mặt trước CMND (*)"
                            self.viewInfoCMNDTruoc.addSubview(lbTextCMNDTruoc)
                            
                            
                            let viewCMNDTruocButton = UIImageView(frame: CGRect(x: self.viewImageCMNDTruoc.frame.size.width/2 - (self.viewImageCMNDTruoc.frame.size.height * 2/3)/2, y: 0, width: self.viewImageCMNDTruoc.frame.size.height * 2/3, height: self.viewImageCMNDTruoc.frame.size.height * 2/3))
                            viewCMNDTruocButton.image = UIImage(named:"AddImage")
                            viewCMNDTruocButton.contentMode = .scaleAspectFit
                            self.viewImageCMNDTruoc.addSubview(viewCMNDTruocButton)
                            
                            
                            let lbCMNDTruocButton = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: self.scrollView.frame.size.width - Common.Size(s:30), height: self.viewImageCMNDTruoc.frame.size.height/3))
                            lbCMNDTruocButton.textAlignment = .center
                            lbCMNDTruocButton.textColor = UIColor(netHex:0xc2c2c2)
                            lbCMNDTruocButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                            lbCMNDTruocButton.text = "Thêm hình ảnh"
                            self.viewImageCMNDTruoc.addSubview(lbCMNDTruocButton)
                            self.viewInfoCMNDTruoc.frame.size.height = self.viewImageCMNDTruoc.frame.size.height + self.viewImageCMNDTruoc.frame.origin.y
                            self.viewInfoCMNDSau.frame.origin.y = self.viewInfoCMNDTruoc.frame.size.height + self.viewInfoCMNDTruoc.frame.origin.y + Common.Size(s:10)
                            self.viewInfoTheNV.frame.origin.y = self.viewInfoCMNDSau.frame.size.height + self.viewInfoCMNDSau.frame.origin.y + Common.Size(s:10)
                            
                            self.viewUpload.frame.size.height = self.viewInfoTheNV.frame.size.height + self.viewInfoTheNV.frame.origin.y
                            self.detailView.frame.origin.y = self.viewUpload.frame.size.height + self.viewUpload.frame.origin.y + Common.Size(s:20)
                            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.detailView.frame.origin.y + self.detailView.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
                
            }
        }
        
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
                        if(type == "5"){
                            self.CRD_TheNV2 = result
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
    @objc func actionCompleteImage(){
        let newViewController = LoadingViewController()
             newViewController.content = "Đang upload hình ảnh..."
             newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
             newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
             self.navigationController?.present(newViewController, animated: true, completion: nil)
             let nc = NotificationCenter.default
             MPOSAPIManager.sp_mpos_UploadImageScoring(UserID:Cache.user!.UserName,IdCardCode:"0",
                                                       Url_MT_CMND:CRD_MT_CMND2,
                                                       Url_MS_CMND:CRD_MS_CMND2,
                                                       Url_GPLX_MT:"",
                                                       Url_GPLX_MS:"",
                                                       Url_TheNV:CRD_TheNV2,
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
                                                       CMND: self.cmnd!,VendorCode: "\(self.vendorCode)", handler: { (result, err) in
                 let when = DispatchTime.now() + 0.5
                 DispatchQueue.main.asyncAfter(deadline: when) {
                   
                     if(err.count <= 0){
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                         if(result[0].Result == 0){
                         
                             let alert = UIAlertController(title: "Thông báo", message: result[0].Message, preferredStyle: .alert)
                             
                             alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                 
                             })
                             self.present(alert, animated: true)
                             return
                         }
                        self.actionSaveCustomer(IDImageXN:"\(result[0].IDImageXN)")
                     
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
    func actionSaveCustomer(IDImageXN:String){
        let cmnd = tfCMND.text!
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
        if(cmnDetect != cmnd){
            log.debug("cmnDetect: \(cmnDetect)")
            self.showDialog(message: "Số CMND không trùng với hình chụp cmnd mặt trước !")
            return
        }
    
        
        let name = tfName.text!
        if (name.count == 0){
            self.showDialog(message: "Tên KH không được để trống!")
            tfName.becomeFirstResponder()
            return
        }
        let tDateBirthday = tfDateBirthday.text!
        if (tDateBirthday.count > 0){
            if(tDateBirthday.count == 10){
                if (!checkDate(stringDate: tDateBirthday)){
                    self.showDialog(message: "Ngày sinh sai định dạng!")
                    return
                }else{
                    let listDate = tDateBirthday.components(separatedBy: "/")
                    if (listDate.count == 3){
                        let yearText = listDate[2]
                        let date = Date()
                        let calendar = Calendar.current
                        let year = calendar.component(.year, from: date)
                        
                        let yearInt = Int(yearText)
                        
                        if (year < yearInt!){
                            self.showDialog(message: "Năm sinh không được lớn hơn năm hiện tại")
                            return
                        }
                    }
                }
            }else{
                self.showDialog(message: "Ngày sinh sai định dạng!")
            }
        }else{
            self.showDialog(message: "Ngày sinh không được để trống!")
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
        if (email.count == 0){
            self.showDialog(message: "Tên Email không được để trống!")
            return
        }
//        if(checkEmail == false){
//            self.showDialog(message: "Bạn phải chọn đuôi Email!")
//            return
//        }
        let emailLast = emailButton.text!
        if (emailLast.count == 0){
            self.showDialog(message: "Đuôi Email không được để trống!")
            return
        }
        
        let emailFull = "\(email)\(emailLast)"
     
        if(self.tfDate.text == ""){
            self.showDialog(message: "Vui lòng nhập ngày bắt đầu làm việc !")
            return
        }
        if(self.positionButton.text == "" || self.positionCode == ""){
            self.showDialog(message: "Vui lòng chọn chức vụ !")
            return
        }
        if(self.htType == 1){
            if(self.tfOTP.text == ""){
                self.showDialog(message: "Vui lòng nhập mã OTP !")
                return
            }
        }
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang đăng ký thông tin KH..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.AddCustomerFFriend(VendorCode: company, CMND: cmnd, FullName: name, SDT: phone, HoKhauTT: "", NgayCapCMND: "", NoiCapCMND: "", ChucVu: "\(self.positionCode)", NgayKiHD: "\(self.tfDate.text!)", SoTKNH: "", IdBank: "", ChiNhanhNH: "", Email: emailFull, Note: "", CreateBy: "\(Cache.user!.UserName)", FileAttachName: "", ChiNhanhDN: branchCode,IDCardCode: "0", LoaiKH: "2", NgaySinh: "\(tDateBirthday)", CreditCard: "", MaNV_KH: "", VendorCodeRef: "", CMND_TinhThanhPho: "0", CMND_QuanHuyen: "0", CMND_PhuongXa: "", NguoiLienHe: "", SDT_NguoiLienHe: "", QuanHeVoiNguoiLienHe: "0", NguoiLienHe_2: "", SDT_NguoiLienHe_2: "", QuanHeVoiNguoiLienHe_2: "0", AnhDaiDien: "",GioThamDinh_TimeFrom:"",GioThamDinh_TimeTo:"",GioThamDinh_OtherTime:"",IdCardcodeRef:"",TenSPThamDinh:"",Gender: -1,IDImageXN:"\(IDImageXN)",ListIDSaoKe:"",NguoiLienHe_3:"",SDT_NguoiLienHe_3:"",QuanHeVoiNguoiLienHe_3:"",NguoiLienHe_4:"",SDT_NguoiLienHe_4:"",QuanHeVoiNguoiLienHe_4:"",EVoucher:"",SoHopDong:"",isQrCode:"",isComplete:"\(self.htType)",OTP:"\(self.tfOTP.text!)") { (result,code, err) in
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
                    // Prepare the popup
                    let title = "THÔNG BÁO"
                    let message = err
                    
                    // Create the dialog
                    let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    
                    // Create first button
                    let buttonOne = CancelButton(title: "OK") {
                        
                        //                        _ = self.navigationController?.popToRootViewController(animated: true)
                        //                        self.dismiss(animated: true, completion: nil)
                        //
                        //                        let myDict = ["CMND": "215068836"]
                        //                        let nc = NotificationCenter.default
                        //                        nc.post(name: Notification.Name("AutoLoadCMND"), object: myDict)
                        
                    }
                    // Add buttons to dialog
                    popup.addButtons([buttonOne])
                    
                    // Present dialog
                    self.present(popup, animated: true, completion: nil)
                }
            }
        }
    }
    @objc func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
    fileprivate func createRadioButtonHT(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:12));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
     
        radioButton.titleLabel?.numberOfLines = 0
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(CustomerPayDirectlyViewController.logSelectedButtonHT), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonHT(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radOTP.isSelected = false
            radCallLog.isSelected = false
            switch temp {
            case "Thẩm định qua OTP":
                htType = 1

                radOTP.isSelected = true
                self.viewOTP.frame.size.height = self.heightView
                self.btSaveCustomer.frame.origin.y = self.viewOTP.frame.size.height + self.viewOTP.frame.origin.y + Common.Size(s: 10)
                self.detailView.frame.origin.y = self.viewUpload.frame.origin.y + self.viewUpload.frame.size.height + Common.Size(s:10)
                
                scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.detailView.frame.origin.y + self.detailView.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
                break
            case "Thẩm định qua CallLog (Duyệt thủ công)":
                htType = 0
                self.viewOTP.frame.size.height = 0
                self.btSaveCustomer.frame.origin.y = self.viewOTP.frame.size.height + self.viewOTP.frame.origin.y + Common.Size(s: 10)
                self.detailView.frame.origin.y = self.viewUpload.frame.origin.y + self.viewUpload.frame.size.height + Common.Size(s:10)
               
                scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.detailView.frame.origin.y + self.detailView.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
                radCallLog.isSelected = true
                break
            default:
                htType = -1
         
                break
            }
        }
    }
    @objc func checkDate(stringDate:String) -> Bool{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yyyy"
        
        if let _ = dateFormatterGet.date(from: stringDate) {
            return true
        } else {
            return false
        }
    }
    @objc func showHTTD(){
        let myVC = PopUpHTTD()
        let navController = UINavigationController(rootViewController: myVC)
        self.navigationController?.present(navController, animated:false, completion: nil)
    }
}
extension CustomerPayDirectlyViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
        }else if (self.posImageUpload == 5){
            self.imageTheNV(image: image)
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

