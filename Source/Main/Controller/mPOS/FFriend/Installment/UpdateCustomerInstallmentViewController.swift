//
//  UpdateCustomerInstallmentViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import PopupDialog
import DLRadioButton
class UpdateCustomerInstallmentViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    var imagePicker = UIImagePickerController()
    var scrollView:UIScrollView!
    var companyButton: SearchTextField!
    var branchCompanyButton: SearchTextField!
    var positionButton: SearchTextField!
    var tfDateBirthday:UITextField!
    var tfName:UITextField!
    var tfPhone:UITextField!
    var tfLimit:UITextField!
    var tfDate:UITextField!
    var tfCMND:UITextField!
    var tfAddressCMND:UITextField!
    var tfDateCMND:UITextField!
    var viewInfoBank:UIView!
    var tfIdBank:UITextField!
    var tfNameBank:UITextField!
    var branchBankButton: SearchTextField!
    var provinceButton: SearchTextField!
    var bankButton: SearchTextField!
    var viewButtons:UIView!
    
    
    
    var ocfdFFriend: OCRDFFriend?
    
    var taskNotes: UITextView!
    var placeholderLabel : UILabel!
    
    var listPosition: [ChucVuFFriend] = []
    var listProvince:[TinhThanhFFriend] = []
    var listBank:[BankFFriend] = []
    var listBranchBank:[BranchBankFFriend] = []
    var positionCode:String  = ""
    var provinceCode:String = ""
    var bankCode:String  = ""
    var branchBankCode:String  = ""
    var isBank: Bool = false
    var lbTextDateCMND:UILabel!
    var lbTextPlaceOfGrantCMND:UILabel!
    var lbTextAddressCMND:UILabel!
    
    var inputAddressCMND:Bool?
    var inputDateCMND:Bool?
    var inputPlaceCMND:Bool?
    
    var tfEmail:UITextField!
    var emailButton: SearchTextField!
    
    var tu:String  = ""
    var den:String  = ""
    
    var inputSoTKNH:Bool?
    var inputIdBank:Bool?
    var inputChiNhanhNH:Bool?
    
    var btUploadImage:UILabel!
    var btCreateCredit:UILabel!
    
    var loaiKH:Int = 1
    
    var tfCodeEmp:UITextField!
    
    var viewInfoUpload:UIView!
    var viewInfoUploadImage:UIView!
    
    var viewImageNV:UIView!
    var imgViewNV: UIImageView!
    var viewNV:UIView!
    
    var btSaveCustomer:UIButton!
    var posImageUpload:Int = -1
//    var viewUploadMore:UIView!
//    var lbInfoCustomerMore:UILabel!
//
//    var viewImageCMNDTruoc:UIView!
//    var imgViewCMNDTruoc: UIImageView!
//    var viewCMNDTruoc:UIView!
//
//    var viewImageCMNDSau:UIView!
//    var imgViewCMNDSau: UIImageView!
//    var viewCMNDSau:UIView!
    var fullFlagArr:[String] = []
    var lbInfoCustomerMore:UILabel!
    var selectUploadImage:Int = 0
    var heightUploadView:CGFloat = 0.0
    var listTinhThanhPho:[TinhThanhPhoFFriend] = []
    var listMoiLienHeVoiNguoiLL: [MoiLienHeVoiNguoiLL] = []
    var listQuanHuyen:[QuanHuyenFFriend] = []
    
    var tinhThanhPhoButton: SearchTextField!
    var quanHuyenButton: SearchTextField!
    var moiLienHeVoiNguoiLLButton: SearchTextField!
    
    var idTinhThanhPho:Int  = 0
    var idQuanHuyen:Int  = 0
    var idQuanHe_1:String  = ""
    var idQuanHe_2:String  = ""
    var idQuanHe_3:String  = ""
    var idQuanHe_4:String  = ""
    
    var tfPhuongXa:UITextField!
    var tfTenNguoiThan_1:UITextField!
    var tfTenNguoiThan_2:UITextField!
    var tfSDTNguoiThan_1:UITextField!
    var tfSDTNguoiThan_2:UITextField!
    
    var quanHeNguoiThan_1Button: SearchTextField!
    var quanHeNguoiThan_2Button: SearchTextField!
    
    var tfTenNguoiThan_3:UITextField!
    var tfTenNguoiThan_4:UITextField!
    var tfSDTNguoiThan_3:UITextField!
    var tfSDTNguoiThan_4:UITextField!
    
    var quanHeNguoiThan_3Button: SearchTextField!
    var quanHeNguoiThan_4Button: SearchTextField!
    var lbTextUpload:UILabel!
    
    var viewImageChanDung:UIView!
    var imgViewChanDung: UIImageView!
    var viewChanDung:UIView!
    
    var lbGenderText:UILabel!
    var radioMan:DLRadioButton!
    var radioWoman:DLRadioButton!
    var genderType:Int = -1
    var imagesUpload: [String:UIImageView] = [:]
    var nameimagesUpload: [String:String] = [:]
    var viewUpload:UIView!
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
    
    //--
    var viewInfoAvatar:UIView!
    var viewImageAvatar:UIView!
    var imgVieAvatar: UIImageView!
    var viewAvatar:UIView!
    //--
    //--
    var viewInfoAvatarSign:UIView!
    var viewImageAvatarSign:UIView!
    var imgVieAvatarSign: UIImageView!
    var viewAvatarSign:UIView!
    //--
    //--
    var viewInfoGPLXTruoc:UIView!
    var viewImageGPLXTruoc:UIView!
    var imgViewGPLXTruoc: UIImageView!
    var viewGPLXTruoc:UIView!
    //--
    
    //--
    var viewInfoGPLXSau:UIView!
    var viewImageGPLXSau:UIView!
    var imgViewGPLXSau: UIImageView!
    var viewGPLXSau:UIView!
    //--
    //--
    var viewInfoTheNV:UIView!
    var viewImageFormRegister:UIView!
    var imgViewFormRegister: UIImageView!
    var viewFormRegister:UIView!
    //--
    //--
    var viewInfoChanDungKH:UIView!
    var viewImageTrichNoTD:UIView!
    var imgViewTrichNoTD: UIImageView!
    var viewTrichNoTD:UIView!
    //--
    //--
    var viewInfoTrichNoTDTrang2:UIView!
    var viewImageTrichNoTDTrang2:UIView!
    var imgViewTrichNoTDTrang2: UIImageView!
    var viewTrichNoTDTrang2:UIView!
    //--
    //--
    var viewInfoSoHK:UIView!
    var viewImageSoHK:UIView!
    var imgViewSoHK: UIImageView!
    var viewSoHK:UIView!
    //--
    
    var lbInfoUploadMore:UILabel!
    
    //---
    var viewUploadMore:UIView!
    
    //--
    var viewInfoSoHKTrang2:UIView!
    var viewImageSoHKTrang2:UIView!
    var imgViewSoHKTrang2: UIImageView!
    var viewSoHKTrang2:UIView!
    //--
    //--
    var viewInfoSoHKTrang3:UIView!
    var viewImageSoHKTrang3:UIView!
    var imgViewSoHKTrang3: UIImageView!
    var viewSoHKTrang3:UIView!
    //--
    //--
    var viewInfoSoHKTrang4:UIView!
    var viewImageSoHKTrang4:UIView!
    var imgViewSoHKTrang4: UIImageView!
    var viewSoHKTrang4:UIView!
    //--
    //--
    var viewInfoSoHKTrang5:UIView!
    var viewImageSoHKTrang5:UIView!
    var imgViewSoHKTrang5: UIImageView!
    var viewSoHKTrang5:UIView!
    //--
    //--
    var viewInfoSoHKTrang6:UIView!
    var viewImageSoHKTrang6:UIView!
    var imgViewSoHKTrang6: UIImageView!
    var viewSoHKTrang6:UIView!
    //--
    //--
    var viewInfoSoHKTrang7:UIView!
    var viewImageSoHKTrang7:UIView!
    var imgViewSoHKTrang7: UIImageView!
    var viewSoHKTrang7:UIView!
    //--
    //--
    var viewInfoSoHKTrang8:UIView!
    var viewImageSoHKTrang8:UIView!
    var imgViewSoHKTrang8: UIImageView!
    var viewSoHKTrang8:UIView!
    //--
    var viewInfoSaoKeLuong1:UIView!
    var viewImageSaoKeLuong1:UIView!
    var imgViewSaoKeLuong1: UIImageView!
    var viewSaoKeLuong1:UIView!
    //
    //--
    var viewInfoSaoKeLuong2:UIView!
    var viewImageSaoKeLuong2:UIView!
    var imgViewSaoKeLuong2: UIImageView!
    var viewSaoKeLuong2:UIView!
    //
    //--
    var viewInfoSaoKeLuong3:UIView!
    var viewImageSaoKeLuong3:UIView!
    var imgViewSaoKeLuong3: UIImageView!
    var viewSaoKeLuong3:UIView!
    //
    var CRD_MT_CMND2:String = ""
    var CRD_MS_CMND2:String = ""
    var CRD_GPLX_MT2:String = ""
    var CRD_GPLX_MS2:String = ""
    var CRD_TheNV2:String = ""
    var CRD_ChanDungKH2:String = ""
    var CRD_XNNS2:String = ""
    var CRD_SHK_12:String = ""
    var CRD_SHK_22:String = ""
    var CRD_SHK_32:String = ""
    var CRD_SHK_42:String = ""
    var CRD_SHK_52:String = ""
    var CRD_SHK_62:String = ""
    var CRD_SHK_72:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Cập nhật KH Trả Góp"
        
        loaiKH = self.ocfdFFriend!.LoaiKH
        
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
        lbType.text = "Trả góp"
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
        self.companyButton.filterStrings(["A","B"])
        companyButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.companyButton.text = item.title
        }
        companyButton.isUserInteractionEnabled = false
        companyButton.isEnabled = false
        
        let lbTextBranchCompany = UILabel(frame: CGRect(x: Common.Size(s:15), y: companyButton.frame.size.height + companyButton.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextBranchCompany.textAlignment = .left
        lbTextBranchCompany.textColor = UIColor.black
        lbTextBranchCompany.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextBranchCompany.text = "Chi nhánh công ty (*)"
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
        
        branchCompanyButton.isUserInteractionEnabled = false
        branchCompanyButton.isEnabled = false
        
        var yName:CGFloat = branchCompanyButton.frame.size.height + branchCompanyButton.frame.origin.y
        
        // bat buoc phai nhap mã nhân viên
//        if("\(self.ocfdFFriend!.HinhThucXacNhan)" == "4"){
//
//            let lbTextCodeEmp = UILabel(frame: CGRect(x: Common.Size(s:15), y:branchCompanyButton.frame.size.height + branchCompanyButton.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
//            lbTextCodeEmp.textAlignment = .left
//            lbTextCodeEmp.textColor = UIColor.black
//            lbTextCodeEmp.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//            lbTextCodeEmp.text = "Mã nhân viên (*)"
//            scrollView.addSubview(lbTextCodeEmp)
//
//            tfCodeEmp = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextCodeEmp.frame.size.height + lbTextCodeEmp.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
//            tfCodeEmp.font = UIFont.systemFont(ofSize: Common.Size(s:15))
//            tfCodeEmp.borderStyle = UITextField.BorderStyle.roundedRect
//            tfCodeEmp.autocorrectionType = UITextAutocorrectionType.no
//            tfCodeEmp.keyboardType = UIKeyboardType.default
//            tfCodeEmp.returnKeyType = UIReturnKeyType.done
//            tfCodeEmp.clearButtonMode = UITextField.ViewMode.whileEditing
//            tfCodeEmp.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
//            tfCodeEmp.delegate = self
//            tfCodeEmp.placeholder = "Nhập mã nhân viên của khách hàng"
//            scrollView.addSubview(tfCodeEmp)
//            yName = tfCodeEmp.frame.size.height + tfCodeEmp.frame.origin.y
//
//            tfCodeEmp.text = "\(self.ocfdFFriend!.MaNV_KH)"
//        }
        let lbTextCodeEmp = UILabel(frame: CGRect(x: Common.Size(s:15), y:branchCompanyButton.frame.size.height + branchCompanyButton.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCodeEmp.textAlignment = .left
        lbTextCodeEmp.textColor = UIColor.black
        lbTextCodeEmp.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCodeEmp.text = "Mã nhân viên (*)"
        scrollView.addSubview(lbTextCodeEmp)
        
        tfCodeEmp = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextCodeEmp.frame.size.height + lbTextCodeEmp.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfCodeEmp.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCodeEmp.borderStyle = UITextField.BorderStyle.roundedRect
        tfCodeEmp.autocorrectionType = UITextAutocorrectionType.no
        tfCodeEmp.keyboardType = UIKeyboardType.default
        tfCodeEmp.returnKeyType = UIReturnKeyType.done
        tfCodeEmp.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCodeEmp.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCodeEmp.delegate = self
        tfCodeEmp.placeholder = "Nhập mã nhân viên của khách hàng"
        scrollView.addSubview(tfCodeEmp)
        yName = tfCodeEmp.frame.size.height + tfCodeEmp.frame.origin.y
        
        tfCodeEmp.text = "\(self.ocfdFFriend!.MaNV_KH)"
        
        let lbTextName = UILabel(frame: CGRect(x: Common.Size(s:15), y:yName + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
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
        tfName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        let  lbTextBirthday = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfName.frame.size.height + tfName.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextBirthday.textAlignment = .left
        lbTextBirthday.textColor = UIColor.black
        lbTextBirthday.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextBirthday.text = "Ngày sinh (*)"
        scrollView.addSubview(lbTextBirthday)
        
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
        scrollView.addSubview(tfDateBirthday)
         tfDateBirthday.addTarget(self, action: #selector(UpdateCustomerInstallmentViewController.textFieldDidEndEditing), for: .editingDidEnd)
        
        
        // choose gioi tinh
        
        let lbGenderText = UILabel(frame: CGRect(x: lbTextBirthday.frame.origin.x, y: tfDateBirthday.frame.origin.y + tfDateBirthday.frame.size.height + Common.Size(s:10), width: tfDateBirthday.frame.size.width, height: Common.Size(s:25)))
        lbGenderText.textAlignment = .left
        lbGenderText.textColor = UIColor.black
        lbGenderText.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbGenderText.text = "Giới tính"
        scrollView.addSubview(lbGenderText)
        
        radioMan = createRadioButtonGender(CGRect(x: lbGenderText.frame.origin.x,y:lbGenderText.frame.origin.y + lbGenderText.frame.size.height + Common.Size(s:5) , width: lbGenderText.frame.size.width/3, height: Common.Size(s:15)), title: "Nam", color: UIColor.black);
        scrollView.addSubview(radioMan)
        
        radioWoman = createRadioButtonGender(CGRect(x: radioMan.frame.origin.x + radioMan.frame.size.width ,y:radioMan.frame.origin.y, width: radioMan.frame.size.width, height: radioMan.frame.size.height), title: "Nữ", color: UIColor.black);
        scrollView.addSubview(radioWoman)
        
        if (ocfdFFriend?.Gender == 0){
            radioMan.isSelected = true
            genderType = 0
        }else if (ocfdFFriend?.Gender == 1){
            radioWoman.isSelected = true
            genderType = 1
        }else{
            radioMan.isSelected = false
            radioWoman.isSelected = false
            genderType = -1
        }
        
        let lbTextPhone = UILabel(frame: CGRect(x: Common.Size(s:15), y: radioMan.frame.size.height + radioMan.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
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
        
        let lbTextPosition = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhone.frame.size.height + tfPhone.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPosition.textAlignment = .left
        lbTextPosition.textColor = UIColor.black
        lbTextPosition.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPosition.text = "Chức vụ (*)"
        scrollView.addSubview(lbTextPosition)
        
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
        scrollView.addSubview(positionButton)
        
        positionButton.startVisible = true
        positionButton.theme.bgColor = UIColor.white
        positionButton.theme.fontColor = UIColor.black
        positionButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        positionButton.theme.cellHeight = Common.Size(s:40)
        positionButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        let lbTextLimit = UILabel(frame: CGRect(x: Common.Size(s:15), y:positionButton.frame.size.height + positionButton.frame.origin.y + Common.Size(s:24), width: scrollView.frame.size.width/2 - Common.Size(s:15), height: Common.Size(s:40)))
        lbTextLimit.textAlignment = .left
        lbTextLimit.textColor = UIColor.black
        lbTextLimit.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextLimit.text = "Hạn mức dự kiến"
        scrollView.addSubview(lbTextLimit)
        
        tfLimit = UITextField(frame: CGRect(x: scrollView.frame.size.width/2, y: lbTextLimit.frame.origin.y, width: scrollView.frame.size.width/2 - Common.Size(s:15) , height: Common.Size(s:40)))
        tfLimit.placeholder = ""
        tfLimit.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfLimit.borderStyle = UITextField.BorderStyle.roundedRect
        tfLimit.autocorrectionType = UITextAutocorrectionType.no
        tfLimit.keyboardType = UIKeyboardType.default
        tfLimit.returnKeyType = UIReturnKeyType.done
        tfLimit.clearButtonMode = UITextField.ViewMode.whileEditing
        tfLimit.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfLimit.delegate = self
        tfLimit.textAlignment = .center
        tfLimit.isUserInteractionEnabled = false
        scrollView.addSubview(tfLimit)
        
        tfLimit.text = "\(Common.convertCurrencyFloatV2(value: self.ocfdFFriend!.HanMucConLai))"
        
        let lbSaoKeLuong = UILabel(frame: CGRect(x: Common.Size(s:15), y:tfLimit.frame.size.height + tfLimit.frame.origin.y + Common.Size(s:20), width: scrollView.frame.size.width/2 - Common.Size(s:15), height: Common.Size(s:40)))
        lbSaoKeLuong.textAlignment = .left
        lbSaoKeLuong.textColor = UIColor.blue
        lbSaoKeLuong.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSaoKeLuong.text = "Sao Kê Lương"
        scrollView.addSubview(lbSaoKeLuong)
        let tapShowSaoKeLuong = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSaoKeLuong))
        lbSaoKeLuong.isUserInteractionEnabled = true
        lbSaoKeLuong.addGestureRecognizer(tapShowSaoKeLuong)
        
        
        let lbTextDate = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbSaoKeLuong.frame.size.height + lbSaoKeLuong.frame.origin.y + Common.Size(s:24), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextDate.textAlignment = .left
        lbTextDate.textColor = UIColor.black
        lbTextDate.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextDate.text = "Ngày bắt đầu làm việc ở DN"
        scrollView.addSubview(lbTextDate)
        
        tfDate = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextDate.frame.size.height + lbTextDate.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfDate.placeholder = ""
        tfDate.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDate.borderStyle = UITextField.BorderStyle.roundedRect
        tfDate.autocorrectionType = UITextAutocorrectionType.no
        tfDate.keyboardType = UIKeyboardType.default
        tfDate.returnKeyType = UIReturnKeyType.done
        tfDate.clearButtonMode = UITextField.ViewMode.whileEditing
        tfDate.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDate.delegate = self
        tfDate.placeholder = "Nhập ngày/tháng/năm"
        scrollView.addSubview(tfDate)
        
        let lbTextCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfDate.frame.size.height + tfDate.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
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
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMND.delegate = self
        scrollView.addSubview(tfCMND)
        
        
        lbTextAddressCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfCMND.frame.size.height + tfCMND.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextAddressCMND.textAlignment = .left
        lbTextAddressCMND.textColor = UIColor.black
        lbTextAddressCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextAddressCMND.text = "Số nhà, tên đường/ thôn, ấp"
        scrollView.addSubview(lbTextAddressCMND)
        
        tfAddressCMND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextAddressCMND.frame.origin.y + lbTextAddressCMND.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfAddressCMND.placeholder = "Nhập đầy đủ địa chỉ ghi trên CMND"
        tfAddressCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfAddressCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfAddressCMND.autocorrectionType = UITextAutocorrectionType.no
        tfAddressCMND.keyboardType = UIKeyboardType.default
        tfAddressCMND.returnKeyType = UIReturnKeyType.done
        tfAddressCMND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfAddressCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfAddressCMND.delegate = self
        scrollView.addSubview(tfAddressCMND)
        if(inputAddressCMND != nil){
            lbTextAddressCMND.textColor = .red
        }
        
        let lbTextTinhThanh = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfAddressCMND.frame.size.height + tfAddressCMND.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextTinhThanh.textAlignment = .left
        lbTextTinhThanh.textColor = UIColor.black
        lbTextTinhThanh.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTinhThanh.text = "Tỉnh/Thành phố trên CMND (*)"
        scrollView.addSubview(lbTextTinhThanh)
        
        if let check = ocfdFFriend?.CMND_TinhThanhPho {
            if(check == 0){
                lbTextTinhThanh.textColor = .red
            }
        }
        
        tinhThanhPhoButton = SearchTextField(frame: CGRect(x: lbTextBranchCompany.frame.origin.x, y: lbTextTinhThanh.frame.origin.y + lbTextTinhThanh.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        tinhThanhPhoButton.placeholder = "Chọn Tỉnh/Thành phố"
        tinhThanhPhoButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tinhThanhPhoButton.borderStyle = UITextField.BorderStyle.roundedRect
        tinhThanhPhoButton.autocorrectionType = UITextAutocorrectionType.no
        tinhThanhPhoButton.keyboardType = UIKeyboardType.default
        tinhThanhPhoButton.returnKeyType = UIReturnKeyType.done
        tinhThanhPhoButton.clearButtonMode = UITextField.ViewMode.whileEditing
        tinhThanhPhoButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tinhThanhPhoButton.delegate = self
        scrollView.addSubview(tinhThanhPhoButton)
        
        tinhThanhPhoButton.startVisible = true
        tinhThanhPhoButton.theme.bgColor = UIColor.white
        tinhThanhPhoButton.theme.fontColor = UIColor.black
        tinhThanhPhoButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tinhThanhPhoButton.theme.cellHeight = Common.Size(s:40)
        tinhThanhPhoButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        let lbTextQuanHuyen = UILabel(frame: CGRect(x: Common.Size(s:15), y: tinhThanhPhoButton.frame.size.height + tinhThanhPhoButton.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextQuanHuyen.textAlignment = .left
        lbTextQuanHuyen.textColor = UIColor.black
        lbTextQuanHuyen.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextQuanHuyen.text = "Quận/Huyện trên CMND (*)"
        scrollView.addSubview(lbTextQuanHuyen)
        
        if let check = ocfdFFriend?.CMND_QuanHuyen {
            if(check == 0){
                lbTextQuanHuyen.textColor = .red
            }
        }
        
        quanHuyenButton = SearchTextField(frame: CGRect(x: lbTextBranchCompany.frame.origin.x, y: lbTextQuanHuyen.frame.origin.y + lbTextQuanHuyen.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        quanHuyenButton.placeholder = "Chọn Quận/Huyện"
        quanHuyenButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        quanHuyenButton.borderStyle = UITextField.BorderStyle.roundedRect
        quanHuyenButton.autocorrectionType = UITextAutocorrectionType.no
        quanHuyenButton.keyboardType = UIKeyboardType.default
        quanHuyenButton.returnKeyType = UIReturnKeyType.done
        quanHuyenButton.clearButtonMode = UITextField.ViewMode.whileEditing
        quanHuyenButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        quanHuyenButton.delegate = self
        scrollView.addSubview(quanHuyenButton)
        
        quanHuyenButton.startVisible = true
        quanHuyenButton.theme.bgColor = UIColor.white
        quanHuyenButton.theme.fontColor = UIColor.black
        quanHuyenButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        quanHuyenButton.theme.cellHeight = Common.Size(s:40)
        quanHuyenButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        let lbTextPhuongXa = UILabel(frame: CGRect(x: Common.Size(s:15), y: quanHuyenButton.frame.size.height + quanHuyenButton.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhuongXa.textAlignment = .left
        lbTextPhuongXa.textColor = UIColor.black
        lbTextPhuongXa.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhuongXa.text = "Phường/Xã trên CMND (*)"
        scrollView.addSubview(lbTextPhuongXa)
        
        if let check = ocfdFFriend?.CMND_PhuongXa {
            if(check.count <= 0){
                lbTextPhuongXa.textColor = .red
            }
        }
        
        tfPhuongXa = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhuongXa.frame.origin.y + lbTextPhuongXa.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfPhuongXa.placeholder = "Nhập Phường/Xã trên CMND"
        tfPhuongXa.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhuongXa.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhuongXa.autocorrectionType = UITextAutocorrectionType.no
        tfPhuongXa.keyboardType = UIKeyboardType.default
        tfPhuongXa.returnKeyType = UIReturnKeyType.done
        tfPhuongXa.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhuongXa.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhuongXa.delegate = self
        scrollView.addSubview(tfPhuongXa)
        tfPhuongXa.text = "\(self.ocfdFFriend!.CMND_PhuongXa)"
        
        lbTextPlaceOfGrantCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhuongXa.frame.size.height + tfPhuongXa.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPlaceOfGrantCMND.textAlignment = .left
        lbTextPlaceOfGrantCMND.textColor = UIColor.black
        lbTextPlaceOfGrantCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPlaceOfGrantCMND.text = "Nơi cấp CMND"
        scrollView.addSubview(lbTextPlaceOfGrantCMND)
        if(inputPlaceCMND != nil){
            lbTextPlaceOfGrantCMND.textColor = .red
        }
        
        provinceButton = SearchTextField(frame: CGRect(x: lbTextPlaceOfGrantCMND.frame.origin.x, y: lbTextPlaceOfGrantCMND.frame.origin.y + lbTextPlaceOfGrantCMND.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        provinceButton.placeholder = "Chọn nơi cấp CMND"
        provinceButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        provinceButton.borderStyle = UITextField.BorderStyle.roundedRect
        provinceButton.autocorrectionType = UITextAutocorrectionType.no
        provinceButton.keyboardType = UIKeyboardType.default
        provinceButton.returnKeyType = UIReturnKeyType.done
        provinceButton.clearButtonMode = UITextField.ViewMode.whileEditing
        provinceButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        provinceButton.delegate = self
        scrollView.addSubview(provinceButton)
        
        provinceButton.startVisible = true
        provinceButton.theme.bgColor = UIColor.white
        provinceButton.theme.fontColor = UIColor.black
        provinceButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        provinceButton.theme.cellHeight = Common.Size(s:40)
        provinceButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        lbTextDateCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: provinceButton.frame.size.height + provinceButton.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextDateCMND.textAlignment = .left
        lbTextDateCMND.textColor = UIColor.black
        lbTextDateCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextDateCMND.text = "Ngày cấp CMND"
        scrollView.addSubview(lbTextDateCMND)
        if(inputDateCMND != nil){
            lbTextDateCMND.textColor = .red
        }
        
        tfDateCMND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextDateCMND.frame.origin.y + lbTextDateCMND.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfDateCMND.placeholder = "Nhập dd/mm/năm"
        tfDateCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDateCMND.borderStyle = UITextField.BorderStyle.roundedRect
        
        tfDateCMND.autocorrectionType = UITextAutocorrectionType.no
        tfDateCMND.keyboardType = UIKeyboardType.default
        tfDateCMND.returnKeyType = UIReturnKeyType.done
        tfDateCMND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfDateCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDateCMND.delegate = self
        scrollView.addSubview(tfDateCMND)
        let lbTextTenNguoiThan_1 = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfDateCMND.frame.size.height + tfDateCMND.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextTenNguoiThan_1.textAlignment = .left
        lbTextTenNguoiThan_1.textColor = UIColor.black
        lbTextTenNguoiThan_1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTenNguoiThan_1.text = "Tên người thân 1 (*)"
        scrollView.addSubview(lbTextTenNguoiThan_1)
        
        if let check = ocfdFFriend?.NguoiLienHe {
            if(check.count <= 0){
                lbTextTenNguoiThan_1.textColor = .red
            }
        }
        
        tfTenNguoiThan_1 = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextTenNguoiThan_1.frame.origin.y + lbTextTenNguoiThan_1.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfTenNguoiThan_1.placeholder = "Nhập họ tên người thân"
        tfTenNguoiThan_1.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTenNguoiThan_1.borderStyle = UITextField.BorderStyle.roundedRect
        tfTenNguoiThan_1.autocorrectionType = UITextAutocorrectionType.no
        tfTenNguoiThan_1.keyboardType = UIKeyboardType.default
        tfTenNguoiThan_1.returnKeyType = UIReturnKeyType.done
        tfTenNguoiThan_1.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTenNguoiThan_1.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTenNguoiThan_1.delegate = self
        scrollView.addSubview(tfTenNguoiThan_1)
        tfTenNguoiThan_1.text = "\(self.ocfdFFriend!.NguoiLienHe)"
        tfTenNguoiThan_1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        let lbTextQuanHeNguoiThan_1 = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfTenNguoiThan_1.frame.size.height + tfTenNguoiThan_1.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextQuanHeNguoiThan_1.textAlignment = .left
        lbTextQuanHeNguoiThan_1.textColor = UIColor.black
        lbTextQuanHeNguoiThan_1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextQuanHeNguoiThan_1.text = "Quan hệ của người thân 1 (*)"
        scrollView.addSubview(lbTextQuanHeNguoiThan_1)
        
        if let check = ocfdFFriend?.QuanHeVoiNguoiLienHe {
            if(check == 0){
                lbTextQuanHeNguoiThan_1.textColor = .red
            }
        }
        
        quanHeNguoiThan_1Button = SearchTextField(frame: CGRect(x: lbTextPlaceOfGrantCMND.frame.origin.x, y: lbTextQuanHeNguoiThan_1.frame.origin.y + lbTextQuanHeNguoiThan_1.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        quanHeNguoiThan_1Button.placeholder = "Chọn quan hệ"
        quanHeNguoiThan_1Button.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        quanHeNguoiThan_1Button.borderStyle = UITextField.BorderStyle.roundedRect
        quanHeNguoiThan_1Button.autocorrectionType = UITextAutocorrectionType.no
        quanHeNguoiThan_1Button.keyboardType = UIKeyboardType.default
        quanHeNguoiThan_1Button.returnKeyType = UIReturnKeyType.done
        quanHeNguoiThan_1Button.clearButtonMode = UITextField.ViewMode.whileEditing
        quanHeNguoiThan_1Button.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        quanHeNguoiThan_1Button.delegate = self
        scrollView.addSubview(quanHeNguoiThan_1Button)
        
        quanHeNguoiThan_1Button.startVisible = true
        quanHeNguoiThan_1Button.theme.bgColor = UIColor.white
        quanHeNguoiThan_1Button.theme.fontColor = UIColor.black
        quanHeNguoiThan_1Button.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        quanHeNguoiThan_1Button.theme.cellHeight = Common.Size(s:40)
        quanHeNguoiThan_1Button.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        let lbTextSDTNguoiThan_1 = UILabel(frame: CGRect(x: Common.Size(s:15), y: quanHeNguoiThan_1Button.frame.size.height + quanHeNguoiThan_1Button.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSDTNguoiThan_1.textAlignment = .left
        lbTextSDTNguoiThan_1.textColor = UIColor.black
        lbTextSDTNguoiThan_1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSDTNguoiThan_1.text = "Số điện thoại người thân 1 (*)"
        scrollView.addSubview(lbTextSDTNguoiThan_1)
        
        if let check = ocfdFFriend?.SDT_NguoiLienHe {
            if(check.count == 0){
                lbTextSDTNguoiThan_1.textColor = .red
            }
        }
        
        tfSDTNguoiThan_1 = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextSDTNguoiThan_1.frame.origin.y + lbTextSDTNguoiThan_1.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfSDTNguoiThan_1.placeholder = "Nhập số điện thoại người thân"
        tfSDTNguoiThan_1.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSDTNguoiThan_1.borderStyle = UITextField.BorderStyle.roundedRect
        tfSDTNguoiThan_1.autocorrectionType = UITextAutocorrectionType.no
        tfSDTNguoiThan_1.keyboardType = UIKeyboardType.numberPad
        tfSDTNguoiThan_1.returnKeyType = UIReturnKeyType.done
        tfSDTNguoiThan_1.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSDTNguoiThan_1.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSDTNguoiThan_1.delegate = self
        scrollView.addSubview(tfSDTNguoiThan_1)
        tfSDTNguoiThan_1.text = "\(self.ocfdFFriend!.SDT_NguoiLienHe)"
        
        
        let lbTextTenNguoiThan_2 = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfSDTNguoiThan_1.frame.size.height + tfSDTNguoiThan_1.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextTenNguoiThan_2.textAlignment = .left
        lbTextTenNguoiThan_2.textColor = UIColor.black
        lbTextTenNguoiThan_2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTenNguoiThan_2.text = "Tên người thân 2 (*)"
        scrollView.addSubview(lbTextTenNguoiThan_2)
        
        if let check = ocfdFFriend?.NguoiLienHe_2 {
            if(check.count == 0){
                lbTextTenNguoiThan_2.textColor = .red
            }
        }
        
        if(self.ocfdFFriend!.Lock_NguoiLienHe == 1){
            tfTenNguoiThan_1.isEnabled = false
            quanHeNguoiThan_1Button.isEnabled = false
            tfSDTNguoiThan_1.isEnabled = false
        }
        
        tfTenNguoiThan_2 = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextTenNguoiThan_2.frame.origin.y + lbTextTenNguoiThan_2.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfTenNguoiThan_2.placeholder = "Nhập họ tên người thân"
        tfTenNguoiThan_2.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTenNguoiThan_2.borderStyle = UITextField.BorderStyle.roundedRect
        tfTenNguoiThan_2.autocorrectionType = UITextAutocorrectionType.no
        tfTenNguoiThan_2.keyboardType = UIKeyboardType.default
        tfTenNguoiThan_2.returnKeyType = UIReturnKeyType.done
        tfTenNguoiThan_2.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTenNguoiThan_2.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTenNguoiThan_2.delegate = self
        scrollView.addSubview(tfTenNguoiThan_2)
        tfTenNguoiThan_2.text = "\(self.ocfdFFriend!.NguoiLienHe_2)"
        tfTenNguoiThan_2.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        let lbTextQuanHeNguoiThan_2 = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfTenNguoiThan_2.frame.size.height + tfTenNguoiThan_2.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextQuanHeNguoiThan_2.textAlignment = .left
        lbTextQuanHeNguoiThan_2.textColor = UIColor.black
        lbTextQuanHeNguoiThan_2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextQuanHeNguoiThan_2.text = "Quan hệ của người thân 2 (*)"
        scrollView.addSubview(lbTextQuanHeNguoiThan_2)
        
        if let check = ocfdFFriend?.QuanHeVoiNguoiLienHe_2 {
            if(check == 0){
                lbTextQuanHeNguoiThan_2.textColor = .red
            }
        }
        
        quanHeNguoiThan_2Button = SearchTextField(frame: CGRect(x: lbTextPlaceOfGrantCMND.frame.origin.x, y: lbTextQuanHeNguoiThan_2.frame.origin.y + lbTextQuanHeNguoiThan_2.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        quanHeNguoiThan_2Button.placeholder = "Chọn quan hệ"
        quanHeNguoiThan_2Button.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        quanHeNguoiThan_2Button.borderStyle = UITextField.BorderStyle.roundedRect
        quanHeNguoiThan_2Button.autocorrectionType = UITextAutocorrectionType.no
        quanHeNguoiThan_2Button.keyboardType = UIKeyboardType.default
        quanHeNguoiThan_2Button.returnKeyType = UIReturnKeyType.done
        quanHeNguoiThan_2Button.clearButtonMode = UITextField.ViewMode.whileEditing
        quanHeNguoiThan_2Button.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        quanHeNguoiThan_2Button.delegate = self
        scrollView.addSubview(quanHeNguoiThan_2Button)
        
        quanHeNguoiThan_2Button.startVisible = true
        quanHeNguoiThan_2Button.theme.bgColor = UIColor.white
        quanHeNguoiThan_2Button.theme.fontColor = UIColor.black
        quanHeNguoiThan_2Button.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        quanHeNguoiThan_2Button.theme.cellHeight = Common.Size(s:40)
        quanHeNguoiThan_2Button.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        let lbTextSDTNguoiThan_2 = UILabel(frame: CGRect(x: Common.Size(s:15), y: quanHeNguoiThan_2Button.frame.size.height + quanHeNguoiThan_2Button.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSDTNguoiThan_2.textAlignment = .left
        lbTextSDTNguoiThan_2.textColor = UIColor.black
        lbTextSDTNguoiThan_2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSDTNguoiThan_2.text = "Số điện thoại người thân 2 (*)"
        scrollView.addSubview(lbTextSDTNguoiThan_2)
        
        if let check = ocfdFFriend?.SDT_NguoiLienHe_2 {
            if(check.count == 0){
                lbTextSDTNguoiThan_2.textColor = .red
            }
        }
        
        tfSDTNguoiThan_2 = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextSDTNguoiThan_2.frame.origin.y + lbTextSDTNguoiThan_2.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfSDTNguoiThan_2.placeholder = "Nhập số điện thoại người thân"
        tfSDTNguoiThan_2.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSDTNguoiThan_2.borderStyle = UITextField.BorderStyle.roundedRect
        tfSDTNguoiThan_2.autocorrectionType = UITextAutocorrectionType.no
        tfSDTNguoiThan_2.keyboardType = UIKeyboardType.numberPad
        tfSDTNguoiThan_2.returnKeyType = UIReturnKeyType.done
        tfSDTNguoiThan_2.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSDTNguoiThan_2.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSDTNguoiThan_2.delegate = self
        scrollView.addSubview(tfSDTNguoiThan_2)
        tfSDTNguoiThan_2.text = "\(self.ocfdFFriend!.SDT_NguoiLienHe_2)"
        
        if(self.ocfdFFriend!.Lock_NguoiLienHe_2 == 1){
               tfTenNguoiThan_2.isEnabled = false
               quanHeNguoiThan_2Button.isEnabled = false
               tfSDTNguoiThan_2.isEnabled = false
           }
        
        let lbTextTenNguoiThan_3 = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfSDTNguoiThan_2.frame.size.height + tfSDTNguoiThan_2.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextTenNguoiThan_3.textAlignment = .left
        lbTextTenNguoiThan_3.textColor = UIColor.black
        lbTextTenNguoiThan_3.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTenNguoiThan_3.text = "Tên người thân 3 (*)"
        scrollView.addSubview(lbTextTenNguoiThan_3)
        
        
        tfTenNguoiThan_3 = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextTenNguoiThan_3.frame.origin.y + lbTextTenNguoiThan_3.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfTenNguoiThan_3.placeholder = "Nhập họ tên người thân"
        tfTenNguoiThan_3.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTenNguoiThan_3.borderStyle = UITextField.BorderStyle.roundedRect
        tfTenNguoiThan_3.autocorrectionType = UITextAutocorrectionType.no
        tfTenNguoiThan_3.keyboardType = UIKeyboardType.default
        tfTenNguoiThan_3.returnKeyType = UIReturnKeyType.done
        tfTenNguoiThan_3.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTenNguoiThan_3.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTenNguoiThan_3.delegate = self
        scrollView.addSubview(tfTenNguoiThan_3)
        tfTenNguoiThan_3.text = "\(self.ocfdFFriend!.NguoiLienHe_3)"
         tfTenNguoiThan_3.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        let lbTextQuanHeNguoiThan_3 = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfTenNguoiThan_3.frame.size.height + tfTenNguoiThan_3.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextQuanHeNguoiThan_3.textAlignment = .left
        lbTextQuanHeNguoiThan_3.textColor = UIColor.black
        lbTextQuanHeNguoiThan_3.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextQuanHeNguoiThan_3.text = "Quan hệ của người thân 3 (*)"
        scrollView.addSubview(lbTextQuanHeNguoiThan_3)
        
  
        
        quanHeNguoiThan_3Button = SearchTextField(frame: CGRect(x: lbTextPlaceOfGrantCMND.frame.origin.x, y: lbTextQuanHeNguoiThan_3.frame.origin.y + lbTextQuanHeNguoiThan_3.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        quanHeNguoiThan_3Button.placeholder = "Chọn quan hệ"
        quanHeNguoiThan_3Button.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        quanHeNguoiThan_3Button.borderStyle = UITextField.BorderStyle.roundedRect
        quanHeNguoiThan_3Button.autocorrectionType = UITextAutocorrectionType.no
        quanHeNguoiThan_3Button.keyboardType = UIKeyboardType.default
        quanHeNguoiThan_3Button.returnKeyType = UIReturnKeyType.done
        quanHeNguoiThan_3Button.clearButtonMode = UITextField.ViewMode.whileEditing
        quanHeNguoiThan_3Button.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        quanHeNguoiThan_3Button.delegate = self
        scrollView.addSubview(quanHeNguoiThan_3Button)
        
        quanHeNguoiThan_3Button.startVisible = true
        quanHeNguoiThan_3Button.theme.bgColor = UIColor.white
        quanHeNguoiThan_3Button.theme.fontColor = UIColor.black
        quanHeNguoiThan_3Button.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        quanHeNguoiThan_3Button.theme.cellHeight = Common.Size(s:40)
        quanHeNguoiThan_3Button.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        let lbTextSDTNguoiThan_3 = UILabel(frame: CGRect(x: Common.Size(s:15), y: quanHeNguoiThan_3Button.frame.size.height + quanHeNguoiThan_3Button.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSDTNguoiThan_3.textAlignment = .left
        lbTextSDTNguoiThan_3.textColor = UIColor.black
        lbTextSDTNguoiThan_3.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSDTNguoiThan_3.text = "Số điện thoại người thân 3 (*)"
        scrollView.addSubview(lbTextSDTNguoiThan_3)
    
        
        tfSDTNguoiThan_3 = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextSDTNguoiThan_3.frame.origin.y + lbTextSDTNguoiThan_3.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfSDTNguoiThan_3.placeholder = "Nhập số điện thoại người thân"
        tfSDTNguoiThan_3.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSDTNguoiThan_3.borderStyle = UITextField.BorderStyle.roundedRect
        tfSDTNguoiThan_3.autocorrectionType = UITextAutocorrectionType.no
        tfSDTNguoiThan_3.keyboardType = UIKeyboardType.numberPad
        tfSDTNguoiThan_3.returnKeyType = UIReturnKeyType.done
        tfSDTNguoiThan_3.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSDTNguoiThan_3.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSDTNguoiThan_3.delegate = self
        scrollView.addSubview(tfSDTNguoiThan_3)
        tfSDTNguoiThan_3.text = "\(self.ocfdFFriend!.SDT_NguoiLienHe_3)"
        
        if(self.ocfdFFriend!.Lock_NguoiLienHe_3 == 1){
            tfTenNguoiThan_3.isEnabled = false
            quanHeNguoiThan_3Button.isEnabled = false
            tfSDTNguoiThan_3.isEnabled = false
        }
        
        
        let lbTextTenNguoiThan_4 = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfSDTNguoiThan_3.frame.size.height + tfSDTNguoiThan_3.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextTenNguoiThan_4.textAlignment = .left
        lbTextTenNguoiThan_4.textColor = UIColor.black
        lbTextTenNguoiThan_4.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTenNguoiThan_4.text = "Tên người thân 4 (*)"
        scrollView.addSubview(lbTextTenNguoiThan_4)
        
     
        
        tfTenNguoiThan_4 = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextTenNguoiThan_4.frame.origin.y + lbTextTenNguoiThan_4.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfTenNguoiThan_4.placeholder = "Nhập họ tên người thân"
        tfTenNguoiThan_4.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTenNguoiThan_4.borderStyle = UITextField.BorderStyle.roundedRect
        tfTenNguoiThan_4.autocorrectionType = UITextAutocorrectionType.no
        tfTenNguoiThan_4.keyboardType = UIKeyboardType.default
        tfTenNguoiThan_4.returnKeyType = UIReturnKeyType.done
        tfTenNguoiThan_4.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTenNguoiThan_4.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTenNguoiThan_4.delegate = self
        scrollView.addSubview(tfTenNguoiThan_4)
        tfTenNguoiThan_4.text = "\(self.ocfdFFriend!.NguoiLienHe_4)"
           tfTenNguoiThan_4.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        let lbTextQuanHeNguoiThan_4 = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfTenNguoiThan_4.frame.size.height + tfTenNguoiThan_4.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextQuanHeNguoiThan_4.textAlignment = .left
        lbTextQuanHeNguoiThan_4.textColor = UIColor.black
        lbTextQuanHeNguoiThan_4.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextQuanHeNguoiThan_4.text = "Quan hệ của người thân 4 (*)"
        scrollView.addSubview(lbTextQuanHeNguoiThan_4)
        
       
        
        quanHeNguoiThan_4Button = SearchTextField(frame: CGRect(x: lbTextPlaceOfGrantCMND.frame.origin.x, y: lbTextQuanHeNguoiThan_4.frame.origin.y + lbTextQuanHeNguoiThan_4.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        quanHeNguoiThan_4Button.placeholder = "Chọn quan hệ"
        quanHeNguoiThan_4Button.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        quanHeNguoiThan_4Button.borderStyle = UITextField.BorderStyle.roundedRect
        quanHeNguoiThan_4Button.autocorrectionType = UITextAutocorrectionType.no
        quanHeNguoiThan_4Button.keyboardType = UIKeyboardType.default
        quanHeNguoiThan_4Button.returnKeyType = UIReturnKeyType.done
        quanHeNguoiThan_4Button.clearButtonMode = UITextField.ViewMode.whileEditing
        quanHeNguoiThan_4Button.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        quanHeNguoiThan_4Button.delegate = self
        scrollView.addSubview(quanHeNguoiThan_4Button)
        
        quanHeNguoiThan_4Button.startVisible = true
        quanHeNguoiThan_4Button.theme.bgColor = UIColor.white
        quanHeNguoiThan_4Button.theme.fontColor = UIColor.black
        quanHeNguoiThan_4Button.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        quanHeNguoiThan_4Button.theme.cellHeight = Common.Size(s:40)
        quanHeNguoiThan_4Button.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        let lbTextSDTNguoiThan_4 = UILabel(frame: CGRect(x: Common.Size(s:15), y: quanHeNguoiThan_4Button.frame.size.height + quanHeNguoiThan_4Button.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSDTNguoiThan_4.textAlignment = .left
        lbTextSDTNguoiThan_4.textColor = UIColor.black
        lbTextSDTNguoiThan_4.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSDTNguoiThan_4.text = "Số điện thoại người thân 4 (*)"
        scrollView.addSubview(lbTextSDTNguoiThan_4)
        
    
        
        tfSDTNguoiThan_4 = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextSDTNguoiThan_4.frame.origin.y + lbTextSDTNguoiThan_4.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfSDTNguoiThan_4.placeholder = "Nhập số điện thoại người thân"
        tfSDTNguoiThan_4.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSDTNguoiThan_4.borderStyle = UITextField.BorderStyle.roundedRect
        tfSDTNguoiThan_4.autocorrectionType = UITextAutocorrectionType.no
        tfSDTNguoiThan_4.keyboardType = UIKeyboardType.numberPad
        tfSDTNguoiThan_4.returnKeyType = UIReturnKeyType.done
        tfSDTNguoiThan_4.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSDTNguoiThan_4.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSDTNguoiThan_4.delegate = self
        scrollView.addSubview(tfSDTNguoiThan_4)
        tfSDTNguoiThan_4.text = "\(self.ocfdFFriend!.SDT_NguoiLienHe_4)"
        
        if(self.ocfdFFriend!.Lock_NguoiLienHe_4 == 1){
                tfTenNguoiThan_4.isEnabled = false
                quanHeNguoiThan_4Button.isEnabled = false
                tfSDTNguoiThan_4.isEnabled = false
        }
        if(self.ocfdFFriend!.IS_Show_NT34 == 0){
            lbTextTenNguoiThan_3.frame.size.height = 0
            tfTenNguoiThan_3.frame.origin.y = lbTextTenNguoiThan_3.frame.size.height + lbTextTenNguoiThan_3.frame.origin.y
            
            tfTenNguoiThan_3.frame.size.height = 0
            lbTextQuanHeNguoiThan_3.frame.origin.y = tfTenNguoiThan_3.frame.origin.y + tfTenNguoiThan_3.frame.size.height
            lbTextQuanHeNguoiThan_3.frame.size.height = 0
            
            quanHeNguoiThan_3Button.frame.origin.y = lbTextQuanHeNguoiThan_3.frame.size.height + lbTextQuanHeNguoiThan_3.frame.origin.y
            quanHeNguoiThan_3Button.frame.size.height = 0
            lbTextSDTNguoiThan_3.frame.origin.y = quanHeNguoiThan_3Button.frame.origin.y + quanHeNguoiThan_3Button.frame.size.height
            lbTextSDTNguoiThan_3.frame.size.height = 0
            
            tfSDTNguoiThan_3.frame.origin.y = lbTextSDTNguoiThan_3.frame.size.height + lbTextSDTNguoiThan_3.frame.origin.y
            tfSDTNguoiThan_3.frame.size.height = 0
            //
            lbTextTenNguoiThan_4.frame.origin.y = tfSDTNguoiThan_3.frame.origin.y + tfSDTNguoiThan_3.frame.size.height
            lbTextTenNguoiThan_4.frame.size.height = 0
            tfTenNguoiThan_4.frame.origin.y = lbTextTenNguoiThan_4.frame.size.height + lbTextTenNguoiThan_4.frame.origin.y
            
            tfTenNguoiThan_4.frame.size.height = 0
            lbTextQuanHeNguoiThan_4.frame.origin.y = tfTenNguoiThan_4.frame.origin.y + tfTenNguoiThan_4.frame.size.height
            lbTextQuanHeNguoiThan_4.frame.size.height = 0
            
            quanHeNguoiThan_4Button.frame.origin.y = lbTextQuanHeNguoiThan_4.frame.size.height + lbTextQuanHeNguoiThan_4.frame.origin.y
            quanHeNguoiThan_4Button.frame.size.height = 0
            lbTextSDTNguoiThan_4.frame.origin.y = quanHeNguoiThan_4Button.frame.origin.y + quanHeNguoiThan_4Button.frame.size.height
            lbTextSDTNguoiThan_4.frame.size.height = 0
            
            tfSDTNguoiThan_4.frame.origin.y = lbTextSDTNguoiThan_4.frame.size.height + lbTextSDTNguoiThan_4.frame.origin.y
            tfSDTNguoiThan_4.frame.size.height = 0
            
            
            
            
        }
        
        viewInfoBank = UIView(frame: CGRect(x:0,y:tfSDTNguoiThan_4.frame.origin.y + tfSDTNguoiThan_4.frame.size.height,width:scrollView.frame.size.width, height: 100))
        //                viewInfoBank.backgroundColor = .red
        viewInfoBank.clipsToBounds = true
        scrollView.addSubview(viewInfoBank)
        
        let lbTextIdBank = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextIdBank.textAlignment = .left
        lbTextIdBank.textColor = UIColor.black
        if(inputSoTKNH != nil){
            lbTextIdBank.textColor = .red
        }
        lbTextIdBank.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextIdBank.text = "Số TK ngân hàng"
        viewInfoBank.addSubview(lbTextIdBank)
        
        tfIdBank = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextIdBank.frame.origin.y + lbTextIdBank.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfIdBank.placeholder = "Nhập số tk ngân hàng"
        tfIdBank.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfIdBank.borderStyle = UITextField.BorderStyle.roundedRect
        tfIdBank.autocorrectionType = UITextAutocorrectionType.no
        tfIdBank.keyboardType = UIKeyboardType.numberPad
        tfIdBank.returnKeyType = UIReturnKeyType.done
        tfIdBank.clearButtonMode = UITextField.ViewMode.whileEditing
        tfIdBank.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfIdBank.delegate = self
        viewInfoBank.addSubview(tfIdBank)
        
        let lbTextNameBank = UILabel(frame: CGRect(x: Common.Size(s:15), y:tfIdBank.frame.origin.y + tfIdBank.frame.size.height  + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextNameBank.textAlignment = .left
        lbTextNameBank.textColor = UIColor.black
        lbTextNameBank.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextNameBank.text = "Tên ngân hàng"
        viewInfoBank.addSubview(lbTextNameBank)
        if(inputIdBank != nil){
            lbTextNameBank.textColor = .red
        }
        
        bankButton = SearchTextField(frame: CGRect(x: lbTextNameBank.frame.origin.x, y: lbTextNameBank.frame.origin.y + lbTextNameBank.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        bankButton.placeholder = "Chọn ngân hàng"
        bankButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        bankButton.borderStyle = UITextField.BorderStyle.roundedRect
        bankButton.autocorrectionType = UITextAutocorrectionType.no
        bankButton.keyboardType = UIKeyboardType.default
        bankButton.returnKeyType = UIReturnKeyType.done
        bankButton.clearButtonMode = UITextField.ViewMode.whileEditing
        bankButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        bankButton.delegate = self
        viewInfoBank.addSubview(bankButton)
        
        bankButton.startVisible = true
        bankButton.theme.bgColor = UIColor.white
        bankButton.theme.fontColor = UIColor.black
        bankButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        bankButton.theme.cellHeight = Common.Size(s:40)
        bankButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        let lbTextBranchBank = UILabel(frame: CGRect(x: Common.Size(s:15), y: bankButton.frame.size.height + bankButton.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextBranchBank.textAlignment = .left
        lbTextBranchBank.textColor = UIColor.black
        lbTextBranchBank.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextBranchBank.text = "Chi nhánh ngân hàng"
        viewInfoBank.addSubview(lbTextBranchBank)
        if(inputChiNhanhNH != nil){
            lbTextBranchBank.textColor = .red
        }
        
        branchBankButton = SearchTextField(frame: CGRect(x: lbTextBranchBank.frame.origin.x, y: lbTextBranchBank.frame.origin.y + lbTextBranchBank.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        branchBankButton.placeholder = "Chọn chi nhánh ngân hàng"
        branchBankButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        branchBankButton.borderStyle = UITextField.BorderStyle.roundedRect
        branchBankButton.autocorrectionType = UITextAutocorrectionType.no
        branchBankButton.keyboardType = UIKeyboardType.default
        branchBankButton.returnKeyType = UIReturnKeyType.done
        branchBankButton.clearButtonMode = UITextField.ViewMode.whileEditing
        branchBankButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        branchBankButton.delegate = self
        viewInfoBank.addSubview(branchBankButton)
        
        branchBankButton.startVisible = true
        branchBankButton.theme.bgColor = UIColor.white
        branchBankButton.theme.fontColor = UIColor.black
        branchBankButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        branchBankButton.theme.cellHeight = Common.Size(s:40)
        branchBankButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        viewInfoBank.frame.size.height = branchBankButton.frame.size.height + branchBankButton.frame.origin.y
        
        
        viewButtons = UIView(frame: CGRect(x:0,y:viewInfoBank.frame.origin.y + viewInfoBank.frame.size.height,width:scrollView.frame.size.width, height: 100))
        //          viewButtons.backgroundColor = .red
        viewButtons.clipsToBounds = true
        scrollView.addSubview(viewButtons)
        
        let lbTextEmail = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextEmail.textAlignment = .left
        lbTextEmail.textColor = UIColor.black
        lbTextEmail.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextEmail.text = "Email KH"
        viewButtons.addSubview(lbTextEmail)
        
        tfEmail = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextEmail.frame.size.height + lbTextEmail.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width/3, height: Common.Size(s:40)))
        tfEmail.placeholder = ""
        tfEmail.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfEmail.borderStyle = UITextField.BorderStyle.roundedRect
        tfEmail.autocorrectionType = UITextAutocorrectionType.no
        tfEmail.keyboardType = UIKeyboardType.default
        tfEmail.returnKeyType = UIReturnKeyType.done
        tfEmail.clearButtonMode = UITextField.ViewMode.whileEditing
        tfEmail.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfEmail.delegate = self
        tfEmail.placeholder = "Tên email"
        viewButtons.addSubview(tfEmail)
        
        emailButton = SearchTextField(frame: CGRect(x: tfEmail.frame.origin.x + tfEmail.frame.size.width, y: tfEmail.frame.origin.y , width: scrollView.frame.size.width * 2/3 - Common.Size(s:30), height: tfEmail.frame.size.height ));
        
        emailButton.placeholder = "Chọn đuôi email"
        emailButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        emailButton.borderStyle = UITextField.BorderStyle.roundedRect
        emailButton.autocorrectionType = UITextAutocorrectionType.no
        emailButton.keyboardType = UIKeyboardType.default
        emailButton.returnKeyType = UIReturnKeyType.done
        emailButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        emailButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        emailButton.delegate = self
        viewButtons.addSubview(emailButton)
        
        emailButton.startVisible = true
        emailButton.theme.bgColor = UIColor.white
        emailButton.theme.fontColor = UIColor.black
        emailButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        emailButton.theme.cellHeight = Common.Size(s:40)
        emailButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        let lbTextNote = UILabel(frame: CGRect(x: Common.Size(s:15), y: emailButton.frame.size.height + emailButton.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextNote.textAlignment = .left
        lbTextNote.textColor = UIColor.black
        lbTextNote.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextNote.text = "Ghi chú"
        viewButtons.addSubview(lbTextNote)
        
        taskNotes = UITextView(frame: CGRect(x: lbTextNote.frame.origin.x , y: lbTextNote.frame.origin.y  + lbTextNote.frame.size.height + Common.Size(s:10), width: lbTextNote.frame.size.width, height: tfCMND.frame.size.height * 2 ))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        taskNotes.layer.borderWidth = 0.5
        taskNotes.layer.borderColor = borderColor.cgColor
        taskNotes.layer.cornerRadius = 5.0
        taskNotes.delegate = self
        taskNotes.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        viewButtons.addSubview(taskNotes)
        
        placeholderLabel = UILabel()
        placeholderLabel.text = "Nhập nội dung ghi chú"
        placeholderLabel.font = UIFont.systemFont(ofSize: (taskNotes.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        taskNotes.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (taskNotes.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !taskNotes.text.isEmpty
        
        viewButtons.frame.size.height = taskNotes.frame.origin.y + taskNotes.frame.size.height + Common.Size(s: 20)
        if(self.ocfdFFriend != nil){
            fullFlagArr = self.ocfdFFriend!.Flag_ImageScoring.components(separatedBy: ",")
        }

        viewUpload = UIView(frame: CGRect(x: 0, y: viewButtons.frame.origin.y + viewButtons.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width, height: Common.Size(s:100) ))
        //        viewUpload.backgroundColor = .red
        scrollView.addSubview(viewUpload)
        
        //---CMND TRUOC
        viewInfoCMNDTruoc = UIView(frame: CGRect(x:0,y:0,width:scrollView.frame.size.width, height: 100))
//        if(fullFlagArr[0] == "1"){
//            viewInfoCMNDTruoc.frame.size.height = 100
//        }
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
//        if(fullFlagArr[1] == "1"){
//           viewInfoCMNDSau.frame.size.height = 100
//        }
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
        
        
        
        //---GPLX TRUOC
        viewInfoGPLXTruoc = UIView(frame: CGRect(x:0,y:viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoGPLXTruoc.clipsToBounds = true
        viewUpload.addSubview(viewInfoGPLXTruoc)
     
        
        let lbTextGPLXTruoc = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextGPLXTruoc.textAlignment = .left
        lbTextGPLXTruoc.textColor = UIColor.black
        lbTextGPLXTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextGPLXTruoc.text = "Giấy phép lái xe (mặt trước)"
        viewInfoGPLXTruoc.addSubview(lbTextGPLXTruoc)
        
        viewImageGPLXTruoc = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextGPLXTruoc.frame.origin.y + lbTextGPLXTruoc.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height:  Common.Size(s:60)))
        viewImageGPLXTruoc.layer.borderWidth = 0.5
        viewImageGPLXTruoc.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageGPLXTruoc.layer.cornerRadius = 3.0
        viewInfoGPLXTruoc.addSubview(viewImageGPLXTruoc)
        
        let viewGPLXTruocButton = UIImageView(frame: CGRect(x: viewImageGPLXTruoc.frame.size.width/2 - (viewImageGPLXTruoc.frame.size.height * 2/3)/2, y: 0, width: viewImageGPLXTruoc.frame.size.height * 2/3, height: viewImageGPLXTruoc.frame.size.height * 2/3))
        viewGPLXTruocButton.image = UIImage(named:"AddImage")
        viewGPLXTruocButton.contentMode = .scaleAspectFit
        viewImageGPLXTruoc.addSubview(viewGPLXTruocButton)
        
        let lbGPLXTruocButton = UILabel(frame: CGRect(x: 0, y: viewGPLXTruocButton.frame.size.height + viewGPLXTruocButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageGPLXTruoc.frame.size.height/3))
        lbGPLXTruocButton.textAlignment = .center
        lbGPLXTruocButton.textColor = UIColor(netHex:0xc2c2c2)
        lbGPLXTruocButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbGPLXTruocButton.text = "Thêm hình ảnh"
        viewImageGPLXTruoc.addSubview(lbGPLXTruocButton)
        viewInfoGPLXTruoc.frame.size.height = viewImageGPLXTruoc.frame.size.height + viewImageGPLXTruoc.frame.origin.y
        
        let tapShowGPLXTruoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowGPLXTruoc))
        viewImageGPLXTruoc.isUserInteractionEnabled = true
        viewImageGPLXTruoc.addGestureRecognizer(tapShowGPLXTruoc)
        if(fullFlagArr[2] != "1"){
            viewInfoGPLXTruoc.frame.size.height = 0
            lbTextGPLXTruoc.frame.size.height = 0
            viewImageGPLXTruoc.frame.size.height = 0
            viewGPLXTruocButton.frame.size.height = 0
            lbGPLXTruocButton.frame.size.height = 0
            
        }
        
        //---GPLX Sau
        viewInfoGPLXSau = UIView(frame: CGRect(x:0,y:viewInfoGPLXTruoc.frame.size.height + viewInfoGPLXTruoc.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoGPLXSau.clipsToBounds = true
        viewUpload.addSubview(viewInfoGPLXSau)
     
        
        let lbTextGPLXSau = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextGPLXSau.textAlignment = .left
        lbTextGPLXSau.textColor = UIColor.black
        lbTextGPLXSau.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextGPLXSau.text = "Giấy phép lái xe (mặt sau)"
        viewInfoGPLXSau.addSubview(lbTextGPLXSau)
        
        viewImageGPLXSau = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextGPLXSau.frame.origin.y + lbTextGPLXSau.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageGPLXSau.layer.borderWidth = 0.5
        viewImageGPLXSau.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageGPLXSau.layer.cornerRadius = 3.0
        viewInfoGPLXSau.addSubview(viewImageGPLXSau)
        
        let viewGPLXSauButton = UIImageView(frame: CGRect(x: viewImageGPLXSau.frame.size.width/2 - (viewImageGPLXSau.frame.size.height * 2/3)/2, y: 0, width: viewImageGPLXSau.frame.size.height * 2/3, height: viewImageGPLXSau.frame.size.height * 2/3))
        viewGPLXSauButton.image = UIImage(named:"AddImage")
        viewGPLXSauButton.contentMode = .scaleAspectFit
        viewImageGPLXSau.addSubview(viewGPLXSauButton)
        
        let lbGPLXSauButton = UILabel(frame: CGRect(x: 0, y: viewGPLXSauButton.frame.size.height + viewGPLXSauButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageGPLXSau.frame.size.height/3))
        lbGPLXSauButton.textAlignment = .center
        lbGPLXSauButton.textColor = UIColor(netHex:0xc2c2c2)
        lbGPLXSauButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbGPLXSauButton.text = "Thêm hình ảnh"
        viewImageGPLXSau.addSubview(lbGPLXSauButton)
        viewInfoGPLXSau.frame.size.height = viewImageGPLXSau.frame.size.height + viewImageGPLXSau.frame.origin.y
        
        let tapShowGPLXSau = UITapGestureRecognizer(target: self, action: #selector(self.tapShowGPLXSau))
        viewImageGPLXSau.isUserInteractionEnabled = true
        viewImageGPLXSau.addGestureRecognizer(tapShowGPLXSau)
        if(fullFlagArr[3] != "1"){
            viewInfoGPLXSau.frame.size.height = 0
            lbTextGPLXSau.frame.size.height = 0
            viewImageGPLXSau.frame.size.height = 0
            viewGPLXSauButton.frame.size.height = 0
            lbGPLXSauButton.frame.size.height = 0
            
     
        }else{
      
        }
        
        //---Form register
        viewInfoTheNV = UIView(frame: CGRect(x:0,y:viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
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
        if(fullFlagArr[4] != "1"){
            viewInfoTheNV.frame.size.height = 0
            lbTextFormRegister.frame.size.height = 0
            viewImageFormRegister.frame.size.height = 0
            viewFormRegisterButton.frame.size.height = 0
            lbFormRegisterButton.frame.size.height = 0
            
        }
        
        //---Form TRICH NO TINH DUNG
        viewInfoChanDungKH = UIView(frame: CGRect(x:0,y:viewInfoTheNV.frame.size.height + viewInfoTheNV.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoChanDungKH.clipsToBounds = true
        viewUpload.addSubview(viewInfoChanDungKH)
     
        
        let lbTextTrichNoTD = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextTrichNoTD.textAlignment = .left
        lbTextTrichNoTD.textColor = UIColor.black
        lbTextTrichNoTD.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTrichNoTD.text = "Chân dung KH (*)"
        viewInfoChanDungKH.addSubview(lbTextTrichNoTD)
        
        viewImageTrichNoTD = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextTrichNoTD.frame.origin.y + lbTextTrichNoTD.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageTrichNoTD.layer.borderWidth = 0.5
        viewImageTrichNoTD.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageTrichNoTD.layer.cornerRadius = 3.0
        viewInfoChanDungKH.addSubview(viewImageTrichNoTD)
        
        let viewTrichNoTDButton = UIImageView(frame: CGRect(x: viewImageTrichNoTD.frame.size.width/2 - (viewImageTrichNoTD.frame.size.height * 2/3)/2, y: 0, width: viewImageTrichNoTD.frame.size.height * 2/3, height: viewImageTrichNoTD.frame.size.height * 2/3))
        viewTrichNoTDButton.image = UIImage(named:"AddImage")
        viewTrichNoTDButton.contentMode = .scaleAspectFit
        viewImageTrichNoTD.addSubview(viewTrichNoTDButton)
        
        let lbTrichNoTDButton = UILabel(frame: CGRect(x: 0, y: viewTrichNoTDButton.frame.size.height + viewTrichNoTDButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageTrichNoTD.frame.size.height/3))
        lbTrichNoTDButton.textAlignment = .center
        lbTrichNoTDButton.textColor = UIColor(netHex:0xc2c2c2)
        lbTrichNoTDButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTrichNoTDButton.text = "Thêm hình ảnh"
        viewImageTrichNoTD.addSubview(lbTrichNoTDButton)
        viewInfoChanDungKH.frame.size.height = viewImageTrichNoTD.frame.size.height + viewImageTrichNoTD.frame.origin.y
        
        let tapShowTrichNoTD = UITapGestureRecognizer(target: self, action: #selector(self.tapShowChanDungKH))
        viewImageTrichNoTD.isUserInteractionEnabled = true
        viewImageTrichNoTD.addGestureRecognizer(tapShowTrichNoTD)
//        if(fullFlagArr[5] != "1"){
//            viewInfoChanDungKH.frame.size.height = 0
//            viewImageTrichNoTD.frame.size.height = 0
//            lbTextTrichNoTD.frame.size.height = 0
//            viewTrichNoTDButton.frame.size.height = 0
//            lbTrichNoTDButton.frame.size.height = 0
//
//        }
        viewInfoChanDungKH.frame.size.height = 0
        viewImageTrichNoTD.frame.size.height = 0
        lbTextTrichNoTD.frame.size.height = 0
        viewTrichNoTDButton.frame.size.height = 0
        lbTrichNoTDButton.frame.size.height = 0
        
        
        //---Form TRICH NO TINH DUNG Trang 2
        viewInfoTrichNoTDTrang2 = UIView(frame: CGRect(x:0,y:viewInfoChanDungKH.frame.size.height + viewInfoChanDungKH.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoTrichNoTDTrang2.clipsToBounds = true
        viewUpload.addSubview(viewInfoTrichNoTDTrang2)
   
        
        let lbTextTrichNoTDTrang2 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextTrichNoTDTrang2.textAlignment = .left
        lbTextTrichNoTDTrang2.textColor = UIColor.black
        lbTextTrichNoTDTrang2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTrichNoTDTrang2.text = "Giấy xác nhận nhân sự"
        viewInfoTrichNoTDTrang2.addSubview(lbTextTrichNoTDTrang2)
        
        viewImageTrichNoTDTrang2 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextTrichNoTDTrang2.frame.origin.y + lbTextTrichNoTDTrang2.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageTrichNoTDTrang2.layer.borderWidth = 0.5
        viewImageTrichNoTDTrang2.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageTrichNoTDTrang2.layer.cornerRadius = 3.0
        viewInfoTrichNoTDTrang2.addSubview(viewImageTrichNoTDTrang2)
        
        let viewTrichNoTDButtonTrang2 = UIImageView(frame: CGRect(x: viewImageTrichNoTDTrang2.frame.size.width/2 - (viewImageTrichNoTDTrang2.frame.size.height * 2/3)/2, y: 0, width: viewImageTrichNoTDTrang2.frame.size.height * 2/3, height: viewImageTrichNoTDTrang2.frame.size.height * 2/3))
        viewTrichNoTDButtonTrang2.image = UIImage(named:"AddImage")
        viewTrichNoTDButtonTrang2.contentMode = .scaleAspectFit
        viewImageTrichNoTDTrang2.addSubview(viewTrichNoTDButtonTrang2)
        
        let lbTrichNoTDButtonTrang2 = UILabel(frame: CGRect(x: 0, y: viewTrichNoTDButtonTrang2.frame.size.height + viewTrichNoTDButtonTrang2.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageTrichNoTDTrang2.frame.size.height/3))
        lbTrichNoTDButtonTrang2.textAlignment = .center
        lbTrichNoTDButtonTrang2.textColor = UIColor(netHex:0xc2c2c2)
        lbTrichNoTDButtonTrang2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTrichNoTDButtonTrang2.text = "Thêm hình ảnh"
        viewImageTrichNoTDTrang2.addSubview(lbTrichNoTDButtonTrang2)
        viewInfoTrichNoTDTrang2.frame.size.height = viewImageTrichNoTDTrang2.frame.size.height + viewImageTrichNoTDTrang2.frame.origin.y
        
        let tapShowXNNS = UITapGestureRecognizer(target: self, action: #selector(self.tapShowXNNS))
        viewImageTrichNoTDTrang2.isUserInteractionEnabled = true
        viewImageTrichNoTDTrang2.addGestureRecognizer(tapShowXNNS)
        if(fullFlagArr[6] != "1"){
            viewInfoTrichNoTDTrang2.frame.size.height = 0
            lbTextTrichNoTDTrang2.frame.size.height = 0
            viewImageTrichNoTDTrang2.frame.size.height = 0
        }
        
        //---SO HO KHAU
        viewInfoSoHK = UIView(frame: CGRect(x:0,y:viewInfoTrichNoTDTrang2.frame.size.height + viewInfoTrichNoTDTrang2.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHK.clipsToBounds = true
        viewUpload.addSubview(viewInfoSoHK)
   
        
        let lbTextSoHK = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHK.textAlignment = .left
        lbTextSoHK.textColor = UIColor.black
        lbTextSoHK.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHK.text = "Sổ hộ khẩu (Trang 1)"
        viewInfoSoHK.addSubview(lbTextSoHK)
        
        viewImageSoHK = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHK.frame.origin.y + lbTextSoHK.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHK.layer.borderWidth = 0.5
        viewImageSoHK.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHK.layer.cornerRadius = 3.0
        viewInfoSoHK.addSubview(viewImageSoHK)
        
        let viewSoHKButton = UIImageView(frame: CGRect(x: viewImageSoHK.frame.size.width/2 - (viewImageSoHK.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHK.frame.size.height * 2/3, height: viewImageSoHK.frame.size.height * 2/3))
        viewSoHKButton.image = UIImage(named:"AddImage")
        viewSoHKButton.contentMode = .scaleAspectFit
        viewImageSoHK.addSubview(viewSoHKButton)
        
        let lbSoHKButton = UILabel(frame: CGRect(x: 0, y: viewSoHKButton.frame.size.height + viewSoHKButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageSoHK.frame.size.height/3))
        lbSoHKButton.textAlignment = .center
        lbSoHKButton.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKButton.text = "Thêm hình ảnh"
        viewImageSoHK.addSubview(lbSoHKButton)
        viewInfoSoHK.frame.size.height = viewImageSoHK.frame.size.height + viewImageSoHK.frame.origin.y
        let tapShowSoHK = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK))
        viewImageSoHK.isUserInteractionEnabled = true
        viewImageSoHK.addGestureRecognizer(tapShowSoHK)
        if(fullFlagArr[7] != "1"){
            viewInfoSoHK.frame.size.height = 0
            lbTextSoHK.frame.size.height = 0
            viewImageSoHK.frame.size.height = 0
            viewSoHKButton.frame.size.height = 0
            lbSoHKButton.frame.size.height = 0
            
        }
        
        //---
        
        lbInfoUploadMore = UILabel(frame: CGRect(x:tfCMND.frame.origin.x, y: viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 14)))
        lbInfoUploadMore.textAlignment = .right
        lbInfoUploadMore.textColor = UIColor(netHex:0x47B054)
        lbInfoUploadMore.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute1 = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString1 = NSAttributedString(string: "Upload thêm hình", attributes: underlineAttribute1)
        lbInfoUploadMore.attributedText = underlineAttributedString1
        viewUpload.addSubview(lbInfoUploadMore)
        let tapShowUploadMore = UITapGestureRecognizer(target: self, action: #selector(CustomerInstallmentViewController.tapShowUploadMore))
        lbInfoUploadMore.isUserInteractionEnabled = true
        lbInfoUploadMore.addGestureRecognizer(tapShowUploadMore)
        
        viewUploadMore = UIView(frame: CGRect(x: 0, y: lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width, height: Common.Size(s:100) ))
        viewUploadMore.clipsToBounds = true
        //                viewUploadMore.backgroundColor = .red
        viewUpload.addSubview(viewUploadMore)
        
        
        
        //---SO HO KHAU Trang 2
        viewInfoSoHKTrang2 = UIView(frame: CGRect(x:0,y: 0,width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang2.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang2)
 
        
        let lbTextSoHKTrang2 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang2.textAlignment = .left
        lbTextSoHKTrang2.textColor = UIColor.black
        lbTextSoHKTrang2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang2.text = "Sổ hộ khẩu (Trang 2)"
        viewInfoSoHKTrang2.addSubview(lbTextSoHKTrang2)
        
        viewImageSoHKTrang2 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang2.frame.origin.y + lbTextSoHKTrang2.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang2.layer.borderWidth = 0.5
        viewImageSoHKTrang2.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang2.layer.cornerRadius = 3.0
        viewInfoSoHKTrang2.addSubview(viewImageSoHKTrang2)
        
        let viewSoHKTrang2Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang2.frame.size.width/2 - (viewImageSoHKTrang2.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang2.frame.size.height * 2/3, height: viewImageSoHKTrang2.frame.size.height * 2/3))
        viewSoHKTrang2Button.image = UIImage(named:"AddImage")
        viewSoHKTrang2Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang2.addSubview(viewSoHKTrang2Button)
        
        let lbSoHKTrang2Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang2Button.frame.size.height + viewSoHKTrang2Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageSoHKTrang2.frame.size.height/3))
        lbSoHKTrang2Button.textAlignment = .center
        lbSoHKTrang2Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang2Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang2Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang2.addSubview(lbSoHKTrang2Button)
        viewInfoSoHKTrang2.frame.size.height = viewImageSoHKTrang2.frame.size.height + viewImageSoHKTrang2.frame.origin.y
        
        let tapShowSoHK2 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK2))
        viewImageSoHKTrang2.isUserInteractionEnabled = true
        viewImageSoHKTrang2.addGestureRecognizer(tapShowSoHK2)
        if(fullFlagArr[8] != "1"){
            viewInfoSoHKTrang2.frame.size.height = 0
            lbTextSoHKTrang2.frame.size.height = 0
            viewImageSoHKTrang2.frame.size.height = 0
            viewSoHKTrang2Button.frame.size.height = 0
            lbSoHKTrang2Button.frame.size.height = 0
            
        }
        
        
        //---SO HO KHAU Trang 3
        viewInfoSoHKTrang3 = UIView(frame: CGRect(x:0,y: viewInfoSoHKTrang2.frame.origin.y + viewInfoSoHKTrang2.frame.size.height + Common.Size(s: 10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang3.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang3)
     
        
        let lbTextSoHKTrang3 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang3.textAlignment = .left
        lbTextSoHKTrang3.textColor = UIColor.black
        lbTextSoHKTrang3.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang3.text = "Sổ hộ khẩu (Trang 3)"
        viewInfoSoHKTrang3.addSubview(lbTextSoHKTrang3)
        
        viewImageSoHKTrang3 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang3.frame.origin.y + lbTextSoHKTrang3.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang3.layer.borderWidth = 0.5
        viewImageSoHKTrang3.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang3.layer.cornerRadius = 3.0
        viewInfoSoHKTrang3.addSubview(viewImageSoHKTrang3)
        
        let viewSoHKTrang3Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang3.frame.size.width/2 - (viewImageSoHKTrang3.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang3.frame.size.height * 2/3, height: viewImageSoHKTrang3.frame.size.height * 2/3))
        viewSoHKTrang3Button.image = UIImage(named:"AddImage")
        viewSoHKTrang3Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang3.addSubview(viewSoHKTrang3Button)
        
        let lbSoHKTrang3Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang3Button.frame.size.height + viewSoHKTrang3Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageGPLXTruoc.frame.size.height/3))
        lbSoHKTrang3Button.textAlignment = .center
        lbSoHKTrang3Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang3Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang3Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang3.addSubview(lbSoHKTrang3Button)
        viewInfoSoHKTrang3.frame.size.height = viewImageSoHKTrang3.frame.size.height + viewImageSoHKTrang3.frame.origin.y
        let tapShowSoHK3 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK3))
        viewImageSoHKTrang3.isUserInteractionEnabled = true
        viewImageSoHKTrang3.addGestureRecognizer(tapShowSoHK3)
        if(fullFlagArr[9] != "1"){
            viewInfoSoHKTrang3.frame.size.height = 0
            lbTextSoHKTrang3.frame.size.height = 0
            viewImageSoHKTrang3.frame.size.height = 0
            viewSoHKTrang3Button.frame.size.height = 0
            lbSoHKTrang3Button.frame.size.height = 0
            
            
        }
        //---SO HO KHAU Trang 4
        viewInfoSoHKTrang4 = UIView(frame: CGRect(x:0,y: viewInfoSoHKTrang3.frame.origin.y + viewInfoSoHKTrang3.frame.size.height + Common.Size(s: 10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang4.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang4)
 
        
        let lbTextSoHKTrang4 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang4.textAlignment = .left
        lbTextSoHKTrang4.textColor = UIColor.black
        lbTextSoHKTrang4.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang4.text = "Sổ hộ khẩu (Trang 4)"
        viewInfoSoHKTrang4.addSubview(lbTextSoHKTrang4)
        
        viewImageSoHKTrang4 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang4.frame.origin.y + lbTextSoHKTrang4.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang4.layer.borderWidth = 0.5
        viewImageSoHKTrang4.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang4.layer.cornerRadius = 3.0
        viewInfoSoHKTrang4.addSubview(viewImageSoHKTrang4)
        
        let viewSoHKTrang4Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang4.frame.size.width/2 - (viewImageSoHKTrang4.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang4.frame.size.height * 2/3, height: viewImageSoHKTrang4.frame.size.height * 2/3))
        viewSoHKTrang4Button.image = UIImage(named:"AddImage")
        viewSoHKTrang4Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang4.addSubview(viewSoHKTrang4Button)
        
        let lbSoHKTrang4Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang4Button.frame.size.height + viewSoHKTrang4Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageSoHKTrang4.frame.size.height/3))
        lbSoHKTrang4Button.textAlignment = .center
        lbSoHKTrang4Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang4Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang4Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang4.addSubview(lbSoHKTrang4Button)
        viewInfoSoHKTrang4.frame.size.height = viewImageSoHKTrang4.frame.size.height + viewImageSoHKTrang4.frame.origin.y
        let tapShowSoHK4 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK4))
        viewImageSoHKTrang4.isUserInteractionEnabled = true
        viewImageSoHKTrang4.addGestureRecognizer(tapShowSoHK4)
        if(fullFlagArr[10] != "1"){
            viewInfoSoHKTrang4.frame.size.height = 0
            lbTextSoHKTrang4.frame.size.height = 0
            viewImageSoHKTrang4.frame.size.height = 0
            viewSoHKTrang4Button.frame.size.height = 0
            lbSoHKTrang4Button.frame.size.height = 0
            
        }
        //---SO HO KHAU Trang 5
        viewInfoSoHKTrang5 = UIView(frame: CGRect(x:0,y: viewInfoSoHKTrang4.frame.origin.y + viewInfoSoHKTrang4.frame.size.height + Common.Size(s: 10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang5.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang5)
    
        
        let lbTextSoHKTrang5 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang5.textAlignment = .left
        lbTextSoHKTrang5.textColor = UIColor.black
        lbTextSoHKTrang5.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang5.text = "Sổ hộ khẩu (Trang 5)"
        viewInfoSoHKTrang5.addSubview(lbTextSoHKTrang5)
        
        viewImageSoHKTrang5 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang5.frame.origin.y + lbTextSoHKTrang5.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang5.layer.borderWidth = 0.5
        viewImageSoHKTrang5.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang5.layer.cornerRadius = 3.0
        viewInfoSoHKTrang5.addSubview(viewImageSoHKTrang5)
        
        let viewSoHKTrang5Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang5.frame.size.width/2 - (viewImageSoHKTrang5.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang5.frame.size.height * 2/3, height: viewImageSoHKTrang5.frame.size.height * 2/3))
        viewSoHKTrang5Button.image = UIImage(named:"AddImage")
        viewSoHKTrang5Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang5.addSubview(viewSoHKTrang5Button)
        
        let lbSoHKTrang5Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang5Button.frame.size.height + viewSoHKTrang5Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageGPLXTruoc.frame.size.height/3))
        lbSoHKTrang5Button.textAlignment = .center
        lbSoHKTrang5Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang5Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang5Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang5.addSubview(lbSoHKTrang5Button)
        viewInfoSoHKTrang5.frame.size.height = viewImageSoHKTrang5.frame.size.height + viewImageSoHKTrang5.frame.origin.y
        let tapShowSoHK5 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK5))
        viewImageSoHKTrang5.isUserInteractionEnabled = true
        viewImageSoHKTrang5.addGestureRecognizer(tapShowSoHK5)
        if(fullFlagArr[11] != "1"){
            viewInfoSoHKTrang5.frame.size.height = 0
            lbTextSoHKTrang5.frame.size.height = 0
            viewImageSoHKTrang5.frame.size.height = 0
            viewSoHKTrang5Button.frame.size.height = 0
            lbSoHKTrang5Button.frame.size.height = 0
            
        }
        //---SO HO KHAU Trang 6
        viewInfoSoHKTrang6 = UIView(frame: CGRect(x:0,y: viewInfoSoHKTrang5.frame.origin.y + viewInfoSoHKTrang5.frame.size.height + Common.Size(s: 10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang6.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang6)
   
        
        let lbTextSoHKTrang6 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang6.textAlignment = .left
        lbTextSoHKTrang6.textColor = UIColor.black
        lbTextSoHKTrang6.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang6.text = "Sổ hộ khẩu (Trang 6)"
        viewInfoSoHKTrang6.addSubview(lbTextSoHKTrang6)
        
        viewImageSoHKTrang6 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang6.frame.origin.y + lbTextSoHKTrang6.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang6.layer.borderWidth = 0.5
        viewImageSoHKTrang6.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang6.layer.cornerRadius = 3.0
        viewInfoSoHKTrang6.addSubview(viewImageSoHKTrang6)
        
        let viewSoHKTrang6Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang6.frame.size.width/2 - (viewImageSoHKTrang6.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang6.frame.size.height * 2/3, height: viewImageSoHKTrang6.frame.size.height * 2/3))
        viewSoHKTrang6Button.image = UIImage(named:"AddImage")
        viewSoHKTrang6Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang6.addSubview(viewSoHKTrang6Button)
        
        let lbSoHKTrang6Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang6Button.frame.size.height + viewSoHKTrang6Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageSoHKTrang6.frame.size.height/3))
        lbSoHKTrang6Button.textAlignment = .center
        lbSoHKTrang6Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang6Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang6Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang6.addSubview(lbSoHKTrang6Button)
        viewInfoSoHKTrang6.frame.size.height = viewImageSoHKTrang6.frame.size.height + viewImageSoHKTrang6.frame.origin.y
        let tapShowSoHK6 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK6))
        viewImageSoHKTrang6.isUserInteractionEnabled = true
        viewImageSoHKTrang6.addGestureRecognizer(tapShowSoHK6)
        if(fullFlagArr[12] != "1"){
            viewInfoSoHKTrang6.frame.size.height = 0
            lbTextSoHKTrang6.frame.size.height = 0
            viewImageSoHKTrang6.frame.size.height = 0
            viewSoHKTrang6Button.frame.size.height = 0
        }
        //---SO HO KHAU Trang 7
        viewInfoSoHKTrang7 = UIView(frame: CGRect(x:0,y: viewInfoSoHKTrang6.frame.origin.y + viewInfoSoHKTrang6.frame.size.height + Common.Size(s: 10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang7.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang7)
      
        
        let lbTextSoHKTrang7 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang7.textAlignment = .left
        lbTextSoHKTrang7.textColor = UIColor.black
        lbTextSoHKTrang7.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang7.text = "Sổ hộ khẩu (Trang 7)"
        viewInfoSoHKTrang7.addSubview(lbTextSoHKTrang7)
        
        viewImageSoHKTrang7 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang7.frame.origin.y + lbTextSoHKTrang7.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang7.layer.borderWidth = 0.5
        viewImageSoHKTrang7.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang7.layer.cornerRadius = 3.0
        viewInfoSoHKTrang7.addSubview(viewImageSoHKTrang7)
        
        let viewSoHKTrang7Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang7.frame.size.width/2 - (viewImageSoHKTrang7.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang7.frame.size.height * 2/3, height: viewImageSoHKTrang7.frame.size.height * 2/3))
        viewSoHKTrang7Button.image = UIImage(named:"AddImage")
        viewSoHKTrang7Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang7.addSubview(viewSoHKTrang7Button)
        
        let lbSoHKTrang7Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang7Button.frame.size.height + viewSoHKTrang7Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageSoHKTrang7.frame.size.height/3))
        lbSoHKTrang7Button.textAlignment = .center
        lbSoHKTrang7Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang7Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang7Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang7.addSubview(lbSoHKTrang7Button)
        viewInfoSoHKTrang7.frame.size.height = viewImageSoHKTrang7.frame.size.height + viewImageSoHKTrang7.frame.origin.y
        let tapShowSoHK7 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK7))
        viewImageSoHKTrang7.isUserInteractionEnabled = true
        viewImageSoHKTrang7.addGestureRecognizer(tapShowSoHK7)
        if(fullFlagArr[13] != "1"){
            viewInfoSoHKTrang7.frame.size.height = 0
            lbTextSoHKTrang7.frame.size.height = 0
            viewImageSoHKTrang7.frame.size.height = 0
            viewSoHKTrang7Button.frame.size.height = 0
            lbSoHKTrang7Button.frame.size.height = 0
            
            
        }
 
        viewUploadMore.frame.size.height = viewInfoSoHKTrang7.frame.size.height + viewInfoSoHKTrang7.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
        viewUploadMore.frame.size.height = 0
    
        //
        if(fullFlagArr[8] != "1" && fullFlagArr[9] != "1" && fullFlagArr[10] != "1" && fullFlagArr[11] != "1" && fullFlagArr[12] != "1" &&
            fullFlagArr[13] != "1" ){
            lbInfoUploadMore.frame.size.height = 0
            viewUploadMore.frame.size.height = 0
        
            
        }else{
            
        }
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        //        }
        btSaveCustomer = UIButton()
        btSaveCustomer.frame = CGRect(x: tfCMND.frame.origin.x, y: viewUpload.frame.origin.y + viewUpload.frame.size.height + Common.Size(s:5), width: tfName.frame.size.width, height: tfCMND.frame.size.height * 1.2)
        
        
        btSaveCustomer.backgroundColor = UIColor(netHex:0xEF4A40)
        btSaveCustomer.setTitle("Cập nhật", for: .normal)
        btSaveCustomer.addTarget(self, action: #selector(actionSaveCustomer), for: .touchUpInside)
        btSaveCustomer.layer.borderWidth = 0.5
        btSaveCustomer.layer.borderColor = UIColor.white.cgColor
        btSaveCustomer.layer.cornerRadius = 3
        scrollView.addSubview(btSaveCustomer)
        
        btUploadImage = UILabel(frame: CGRect(x: btSaveCustomer.frame.origin.x, y: btSaveCustomer.frame.origin.y + btSaveCustomer.frame.size.height + Common.Size(s:10), width: btSaveCustomer.frame.size.width, height: 0))
        btUploadImage.textAlignment = .center
        btUploadImage.textColor = UIColor(netHex:0x47B054)
        btUploadImage.layer.cornerRadius = 5
        btUploadImage.layer.borderColor = UIColor(netHex:0x47B054).cgColor
        btUploadImage.layer.borderWidth = 0.5
        btUploadImage.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        btUploadImage.text = "Upload UQTN"
        btUploadImage.numberOfLines = 1
        scrollView.addSubview(btUploadImage)
        
        let tapUploadImage = UITapGestureRecognizer(target: self, action: #selector(UpdateCustomerInstallmentViewController.actionUploadImage))
        btUploadImage.isUserInteractionEnabled = true
        btUploadImage.addGestureRecognizer(tapUploadImage)
        
        if(self.ocfdFFriend!.MaHTThanhToan == "BANK"){
            //            if(self.ocfdFFriend!.TTDuyetHanMuc == "N" || self.ocfdFFriend!.TTDuyetHanMuc == "M"){
            //                btUploadImage.frame.size.height = tfCMND.frame.size.height
            //            }
            if(self.ocfdFFriend!.flag_UQTN != "0,0,0,0,0"){
                btUploadImage.frame.size.height = tfCMND.frame.size.height
            }
        }
        
        
        btCreateCredit = UILabel(frame: CGRect(x: btSaveCustomer.frame.origin.x, y: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + Common.Size(s:10), width: btSaveCustomer.frame.size.width, height:  0))
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
        //
        //        let tapCreateCredit = UITapGestureRecognizer(target: self, action: #selector(UpdateCustomerInstallmentViewController.tapCreateCredit))
        //        btCreateCredit.isUserInteractionEnabled = true
        //        btCreateCredit.addGestureRecognizer(tapCreateCredit)
        
        
        
        
//        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btCreateCredit.frame.origin.y + btCreateCredit.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        
        if (ocfdFFriend != nil){
            tfName.text = ocfdFFriend?.CardName
            let dateBirthday = ocfdFFriend?.Birthday == "01/01/1970" ? "" : ocfdFFriend?.Birthday
            tfDateBirthday.text = dateBirthday
            
            tfPhone.text = ocfdFFriend?.SDT
            tfCMND.text = ocfdFFriend?.CMND
            companyButton.text = ocfdFFriend?.TenCongTy
            branchCompanyButton.text = ocfdFFriend?.TenChiNhanhDoanhNghiep
            
            let dateCom = ocfdFFriend?.NgayBatDauLamViec == "01/01/1970" ? "" : ocfdFFriend?.NgayBatDauLamViec
            tfDate.text = dateCom
            tfAddressCMND.text = ocfdFFriend?.DiaChiHoKhau
            let dateCMND = ocfdFFriend?.NgayCapCMND == "01/01/1970" ? "" : ocfdFFriend?.NgayCapCMND
            
            tfDateCMND.text =  dateCMND
            tfIdBank.text = ocfdFFriend?.SoTKNH
            tfAddressCMND.text = ocfdFFriend?.DiaChiHoKhau
            
            self.hideBank(HT:(ocfdFFriend?.MaHTThanhToan)!)
            
            positionButton.itemSelectionHandler = { filteredResults, itemPosition in
                let item = filteredResults[itemPosition]
                self.positionButton.text = item.title
                let obj =  self.listPosition.filter{ $0.ChucVu == "\(item.title)" }.first
                if let ob = obj?.HanMuc {
                    //self.tfLimit.text = ob
                    self.tfLimit.text = Common.convertCurrencyFloatV2(value: Float(ob)!)
                }else{
                    self.tfLimit.text = ""
                }
                if let id = obj?.ID {
                    self.positionCode = id
                }
            }
            //            MPOSAPIManager.getChucVuFFriend(vendor: "\(ocfdFFriend!.MaCongTy)", handler: { (results, err) in
            //                if(err.count <= 0){
            //                    var listPosition: [String] = []
            //                    self.listPosition = results
            //                    for item in results {
            //                        listPosition.append("\(item.ChucVu)")
            //                        if (item.ID == "\(self.ocfdFFriend!.MaChucVu)"){
            //                            self.positionCode = item.ID
            //                            self.positionButton.text = item.ChucVu
            //                            self.tfLimit.text = item.HanMuc
            //                        }
            //                    }
            //
            //                    self.positionButton.filterStrings(listPosition)
            //                }else{
            //
            //                }
            //            })
            provinceButton.itemSelectionHandler = { filteredResults, itemPosition in
                let item = filteredResults[itemPosition]
                self.provinceButton.text = item.title
                let obj =  self.listProvince.filter{ $0.TenTinhThanh == "\(item.title)" }.first
                if let code = obj?.ID {
                    self.provinceCode = "\(code)"
                }
            }
            MPOSAPIManager.getTinhThanhFFriend { (results, err) in
                if(err.count<=0){
                    var listPro: [String] = []
                    self.listProvince = results
                    for item in results {
                        listPro.append("\(item.TenTinhThanh)")
                        if(item.ID == self.ocfdFFriend!.NoiCapCMND){
                            self.provinceCode = "\(item.ID)"
                            self.provinceButton.text = item.TenTinhThanh
                        }
                    }
                    self.provinceButton.filterStrings(listPro)
                }else{
                    
                }
            }
            bankButton.itemSelectionHandler = { filteredResults, itemPosition in
                let item = filteredResults[itemPosition]
                self.bankButton.text = item.title
                
                let obj =  self.listBank.filter{ $0.BankName == "\(item.title)" }.first
                if let ob = obj?.TenChiNhanh {
                    var listBranchBankText: [String] = []
                    self.listBranchBank = ob
                    for it in ob {
                        listBranchBankText.append("\(it.TenChiNhanh)")
                    }
                    self.branchBankButton.filterStrings(listBranchBankText)
                }
                
                if let code = obj?.ID {
                    self.bankCode = code
                }
                if let tu = obj?.Tu {
                    self.tu  = tu
                }
                if let den = obj?.Den {
                    self.den = den
                }
                self.branchBankCode = ""
                self.branchBankButton.text = ""
            }
            branchBankButton.itemSelectionHandler = { filteredResults, itemPosition in
                let item = filteredResults[itemPosition]
                self.branchBankButton.text = item.title
                let obj =  self.listBranchBank.filter{ $0.TenChiNhanh == "\(item.title)" }.first
                if let code = obj?.ID {
                    self.branchBankCode = code
                }
            }
            
            MPOSAPIManager.getThongTinNganHangFFriend(Vendor: "\(self.ocfdFFriend!.MaCongTy)", CNVendor: "\(self.ocfdFFriend!.MaChiNhanhDoanhNghiep)") { (results, err) in
                if(err.count<=0){
                    var listBank: [String] = []
                    self.listBank = results
                    for item in results {
                        listBank.append("\(item.BankName)")
                        if(item.ID == "\(self.ocfdFFriend!.IdBank)"){
                            self.bankCode = "\(item.ID)"
                            self.bankButton.text = item.BankName
                            self.tu  = item.Tu
                            self.den = item.Den
                            let ob = item.TenChiNhanh
                            var listBranchBankText: [String] = []
                            self.listBranchBank = ob
                            for it in ob {
                                listBranchBankText.append("\(it.TenChiNhanh)")
                                print("\(it.ID) \(self.ocfdFFriend!.ChiNhanhNH)")
                                if(it.ID == "\(self.ocfdFFriend!.ChiNhanhNH)"){
                                    self.branchBankCode = it.ID
                                    self.branchBankButton.text = it.TenChiNhanh
                                }
                            }
                            self.branchBankButton.filterStrings(listBranchBankText)
                        }
                    }
                    self.bankButton.filterStrings(listBank)
                }else{
                    
                }
            }
            emailButton.itemSelectionHandler = { filteredResults, itemPosition in
                let item = filteredResults[itemPosition]
                self.emailButton.text = item.title
            }
            MPOSAPIManager.getVendorFFriendV2(LoaiDN: "\(self.ocfdFFriend!.LoaiKH)", handler: { (results, err) in
                if(err.count<=0){
                    for item in results {
                        if("\(item.ID)" == self.ocfdFFriend!.MaCongTy){
                         //   let listEmail = item.DuoiEmail.components(separatedBy: ";")
                            //                            if (listEmail.count == 1){
                            //                                self.emailButton.text = listEmail[0]
                            //                            }
                            if (self.ocfdFFriend!.Email != ""){
                                let listEm = self.ocfdFFriend!.Email.components(separatedBy: "@")
                                if (listEm.count >= 2){
                                    self.emailButton.text = "@\(listEm[1])"
                                    self.tfEmail.text = listEm[0]
                                }
                            }
                            
                          //  self.emailButton.filterStrings(listEmail)
                            
                      
                            break
                        }
                    }
                }
            })
            MPOSAPIManager.mpos_sp_GetVendor_DuoiEmail(VendorCode: "\(self.ocfdFFriend!.MaCongTy)") { (results, err) in
                if(err.count<=0){
                    var listEmail:[String] = []
                    for item in results{
                        listEmail.append(item.DuoiEmail)
                    }

                    self.emailButton.filterStrings(listEmail)
                }else{
                    
                }
            }
            MPOSAPIManager.getChucVuFFriend(handler: { (cv, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    //nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count<=0){
                        var listPosition: [String] = []
                        self.listPosition = cv
                        for ite in cv {
                            listPosition.append("\(ite.ChucVu)")
                            if(ite.ID == "\(self.ocfdFFriend!.MaChucVu)"){
                                self.positionButton.text = ite.ChucVu
                                self.positionCode = ite.ID
                                //                                    self.tfLimit.text = ite.HanMuc
                            }
                        }
                        self.positionButton.filterStrings(listPosition)
                        
                    }else{
                        
                    }
                }
            })
            
        }
        MPOSAPIManager.getTinhThanhFFriend { (results, err) in
            if(err.count<=0){
                var listPro: [String] = []
                self.listProvince = results
                for item in results {
                    listPro.append("\(item.TenTinhThanh)")
                }
                self.provinceButton.filterStrings(listPro)
            }else{
                
            }
        }
        
        MPOSAPIManager.mpos_sp_LoadTinhThanhPho { (results, err) in
            if(err.count <= 0){
                self.listTinhThanhPho = results
                var listTinhThanhPhoString: [String] = []
                for item in results {
                    listTinhThanhPhoString.append("\(item.Name)")
                    if(item.ID == self.ocfdFFriend!.CMND_TinhThanhPho){
                        self.tinhThanhPhoButton.text = item.Name
                        self.idTinhThanhPho = item.ID
                        MPOSAPIManager.mpos_sp_LoadQuanHuyen(TinhThanh: "\(item.ID)", handler: { (results, err) in
                            if(err.count <= 0){
                                self.listQuanHuyen = results
                                var listString: [String] = []
                                for item in results {
                                    listString.append("\(item.Name)")
                                    if(item.ID ==  self.ocfdFFriend!.CMND_QuanHuyen){
                                        self.quanHuyenButton.text = item.Name
                                        self.idQuanHuyen = item.ID
                                    }
                                }
                                self.quanHuyenButton.filterStrings(listString)
                            }
                        })
                    }
                }
                self.tinhThanhPhoButton.filterStrings(listTinhThanhPhoString)
            }else{
                print("LOI mpos_sp_LoadTinhThanhPho")
            }
        }
        tinhThanhPhoButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.tinhThanhPhoButton.text = item.title
            let obj =  self.listTinhThanhPho.filter{ $0.Name == "\(item.title)" }.first
            if let code = obj?.ID {
                self.idTinhThanhPho = code
                self.quanHuyenButton.text = ""
                self.idQuanHuyen = 0
                self.tfPhuongXa.text = ""
                MPOSAPIManager.mpos_sp_LoadQuanHuyen(TinhThanh: "\(code)", handler: { (results, err) in
                    if(err.count <= 0){
                        self.listQuanHuyen = results
                        var listString: [String] = []
                        for item in results {
                            listString.append("\(item.Name)")
                        }
                        self.quanHuyenButton.filterStrings(listString)
                    }
                })
            }
        }
        quanHuyenButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.quanHuyenButton.text = item.title
            let obj =  self.listQuanHuyen.filter{ $0.Name == "\(item.title)" }.first
            self.tfPhuongXa.text = ""
            if let code = obj?.ID {
                self.idQuanHuyen = code
            }
        }
        MPOSAPIManager.mpos_sp_GetMoiLienHeVoiNguoiLL { (results, err) in
            if(err.count <= 0){
                self.listMoiLienHeVoiNguoiLL = results
                var listString: [String] = []
                for item in results {
                    listString.append("\(item.Name)")
                    if(item.Code == "\(self.ocfdFFriend!.QuanHeVoiNguoiLienHe)"){
                        self.quanHeNguoiThan_1Button.text = item.Name
                        self.idQuanHe_1 = item.Code
                    }
                    if(item.Code == "\(self.ocfdFFriend!.QuanHeVoiNguoiLienHe_2)"){
                        self.quanHeNguoiThan_2Button.text = item.Name
                        self.idQuanHe_2 = item.Code
                    }
                    if(item.Code == "\(self.ocfdFFriend!.QuanHeVoiNguoiLienHe_3)"){
                        self.quanHeNguoiThan_3Button.text = item.Name
                        self.idQuanHe_3 = item.Code
                    }
                    if(item.Code == "\(self.ocfdFFriend!.QuanHeVoiNguoiLienHe_4)"){
                        self.quanHeNguoiThan_4Button.text = item.Name
                        self.idQuanHe_4 = item.Code
                    }
                }
                self.quanHeNguoiThan_1Button.filterStrings(listString)
                self.quanHeNguoiThan_2Button.filterStrings(listString)
                self.quanHeNguoiThan_3Button.filterStrings(listString)
                self.quanHeNguoiThan_4Button.filterStrings(listString)
            }else{
                print("LOI mpos_sp_GetMoiLienHeVoiNguoiLL")
            }
        }
        quanHeNguoiThan_1Button.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.quanHeNguoiThan_1Button.text = item.title
            let obj =  self.listMoiLienHeVoiNguoiLL.filter{ $0.Name == "\(item.title)" }.first
            if let code = obj?.Code {
                self.idQuanHe_1 = code
            }
        }
        quanHeNguoiThan_2Button.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.quanHeNguoiThan_2Button.text = item.title
            let obj =  self.listMoiLienHeVoiNguoiLL.filter{ $0.Name == "\(item.title)" }.first
            if let code = obj?.Code {
                self.idQuanHe_2 = code
            }
        }
        quanHeNguoiThan_3Button.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.quanHeNguoiThan_3Button.text = item.title
            let obj =  self.listMoiLienHeVoiNguoiLL.filter{ $0.Name == "\(item.title)" }.first
            if let code = obj?.Code {
                self.idQuanHe_3 = code
            }
        }
        quanHeNguoiThan_4Button.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.quanHeNguoiThan_4Button.text = item.title
            let obj =  self.listMoiLienHeVoiNguoiLL.filter{ $0.Name == "\(item.title)" }.first
            if let code = obj?.Code {
                self.idQuanHe_4 = code
            }
        }
        self.hideKeyboardWhenTappedAround()
    }
    @objc func tapShowSaoKeLuong(){
        let newViewController = ThongTinSaoKeLuongViewController()
        newViewController.IDCardCode = self.ocfdFFriend?.IDcardCode
        newViewController.CMND = self.ocfdFFriend?.CMND
        self.navigationController?.pushViewController(newViewController, animated: true)
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
                    //let newViewController = CustomerCreditNoCardViewControllerV2()
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
                //let newViewController = CustomerCreditNoCardViewControllerV2()
                let newViewController = CustomerCreditNoCardViewControllerV3()
                newViewController.ocfdFFriend = self.ocfdFFriend
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
        }
    }
//    @objc func tapShowCMNDTruoc(sender:UITapGestureRecognizer) {
//        self.selectUploadImage = 0
//        self.thisIsTheFunctionWeAreCalling()
//    }
//    @objc func tapShowCMNDTruoc2(sender:UITapGestureRecognizer) {
//        self.selectUploadImage = 1
//        self.thisIsTheFunctionWeAreCalling()
//    }
//    @objc func tapShowCMNDSau(sender:UITapGestureRecognizer) {
//        self.selectUploadImage = 2
//        self.thisIsTheFunctionWeAreCalling()
//    }
 
    @objc func actionUploadImage(){
        if (self.ocfdFFriend!.IdBank == 0 || self.ocfdFFriend!.SoTKNH == ""){
            let title = "THÔNG BÁO"
            let message = "KH không đủ thông tin ngân hàng bắt buộc. Vui lòng nhập thông tin ngân hàng đầy đủ, bấm Cập nhật trước khi up hình !!!"
            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = DefaultButton(title: "OK") {}
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        
        //        if (self.bankCode.count == 0){
        //            self.showDialog(message: "Ngân hàng không được để trống!")
        //            return
        //        }
        //        if (self.bankButton.text!.count == 0){
        //            self.showDialog(message: "Ngân hàng không được để trống!")
        //            return
        //        }
        //        if (self.branchBankCode.count == 0 && self.listBranchBank.count > 0){
        //            self.showDialog(message: "Chi nhánh ngân hàng không được để trống!")
        //            return
        //        }
        //        if (self.branchBankButton.text!.count == 0 && self.listBranchBank.count > 0){
        //            self.showDialog(message: "Chi nhánh ngân hàng không được để trống!")
        //            return
        //        }
        
        let listImages = self.ocfdFFriend!.flag_UQTN.components(separatedBy: ",")
        if(listImages.count == 5){
            let title = "THÔNG BÁO"
            let message = "Bạn cần in UQTN, rồi đưa hội viên ký tên để hoàn tất thủ tục tạo tài khoản F.Friends.\r\nNếu đã có UQTN vui lòng chọn bỏ qua."
            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = DefaultButton(title: "In ấn") {
                
                let newViewController1 = LoadingViewController()
                newViewController1.content = "Đang in UQTN..."
                newViewController1.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController1.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController1, animated: true, completion: nil)
                let nc = NotificationCenter.default
                MPOSAPIManager.mpos_sp_PrintUQTNPOS(IDCardCode: "\(self.ocfdFFriend!.IDcardCode)", UserID: "\(Cache.user!.UserName)", handler: { (success, err) in
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        if(err.count <= 0 ){
                            let newViewController =  UploadUQTNViewController()
                            newViewController.idCardCode = "\(self.ocfdFFriend!.IDcardCode)"
                            newViewController.cmnd = "\(self.ocfdFFriend!.CMND)"
                            newViewController.name = "\(self.ocfdFFriend!.CardName)"
                            newViewController.nameBank = "\(self.bankButton.text!)"
                            newViewController.rolesImage = listImages
                            if(listImages[0] == "0"){
                                newViewController.isUploadUQTN1 = true
                            }
                            if(listImages[1] == "0"){
                                newViewController.isUploadUQTN2 = true
                            }
                            if(listImages[2] == "0"){
                                newViewController.isUploadUQTN3 = true
                            }
                            if(listImages[3] == "0"){
                                newViewController.isUploadCMNDTruoc = true
                            }
                            if(listImages[4] == "0"){
                                newViewController.isUploadCMNDSau = true
                            }
                            self.navigationController?.pushViewController(newViewController, animated: true)
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
                })
            }
            let buttonTwo = CancelButton(title: "Bỏ qua") {
                let newViewController =  UploadUQTNViewController()
                newViewController.idCardCode = "\(self.ocfdFFriend!.IDcardCode)"
                newViewController.cmnd = "\(self.ocfdFFriend!.CMND)"
                newViewController.name = "\(self.ocfdFFriend!.CardName)"
                newViewController.nameBank = "\(self.bankButton.text!)"
                newViewController.rolesImage = listImages
                if(listImages[0] == "0"){
                    newViewController.isUploadUQTN1 = true
                }
                if(listImages[1] == "0"){
                    newViewController.isUploadUQTN2 = true
                }
                if(listImages[2] == "0"){
                    newViewController.isUploadUQTN3 = true
                }
                if(listImages[3] == "0"){
                    newViewController.isUploadCMNDTruoc = true
                }
                if(listImages[4] == "0"){
                    newViewController.isUploadCMNDSau = true
                }
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
            popup.addButtons([buttonOne,buttonTwo])
            self.present(popup, animated: true, completion: nil)
        }
    }

    @objc func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    @objc  func hideBank(HT:String){
        if(HT == "HR"){
            isBank = false
            lbTextDateCMND.text = "Ngày cấp CMND"
            lbTextPlaceOfGrantCMND.text = "Nơi cấp CMND"
            lbTextAddressCMND.text = "Số nhà, tên đường/ thôn, ấp"
            tfIdBank.text = ""
            bankCode = ""
            branchBankCode = ""
            viewInfoBank.frame.size.height = 0
            viewButtons.frame.origin.y = viewInfoBank.frame.origin.y + viewInfoBank.frame.size.height
        }else{
            isBank = true
            lbTextDateCMND.text = "Ngày cấp CMND (*)"
            lbTextPlaceOfGrantCMND.text = "Nơi cấp CMND (*)"
            lbTextAddressCMND.text = "Số nhà, tên đường/ thôn, ấp (*)"
            
            viewInfoBank.frame.size.height = branchBankButton.frame.size.height + branchBankButton.frame.origin.y
            viewButtons.frame.origin.y = viewInfoBank.frame.origin.y + viewInfoBank.frame.size.height
        }
      
        viewUpload.frame.origin.y = viewButtons.frame.origin.y + viewButtons.frame.size.height
           btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btCreateCredit.frame.origin.y + btCreateCredit.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    @objc func actionSaveCustomer(){
        var codeEmp:String = ""
        if("\(self.ocfdFFriend!.HinhThucXacNhan)" == "4"){
            codeEmp = tfCodeEmp.text!
            if (codeEmp.count == 0){
                self.showDialog(message: "Mã nhân viên KH không được để trống!")
                return
            }
        }
        
        let name = tfName.text!
        if (name.count == 0){
            self.showDialog(message: "Tên KH không được để trống!")
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
        let phone = tfPhone.text!
        if (phone.count == 0){
            self.showDialog(message: "SDT KH không được để trống!")
            return
            
        }
        if (!phone.hasPrefix("01") && !phone.hasPrefix("00") && phone.hasPrefix("0") && phone.count == 10){
            
        }else{
            self.showDialog(message: "SĐT KH không hợp lệ!")
            return
        }
        
        let positionCode = self.positionCode
        if (positionCode.count == 0){
            self.showDialog(message: "Chức vụ không được để trống!")
            return
        }
        let tDate = tfDate.text!
        if (tDate.count > 0){
            if (!checkDate(stringDate: tDate)){
                self.showDialog(message: "Ngày làm việc sai định dạng!")
                return
            }
        }else{
            self.showDialog(message: "Ngày bắt đầu làm việc không được để trống!")
            return
        }
        let cmnd = tfCMND.text!
        if (cmnd.count == 0){
            self.showDialog(message: "CMND không được để trống!")
            return
        }
        let addressCMND = tfAddressCMND.text!
        let dateCMND = tfDateCMND.text!
        let idBank = tfIdBank.text!
        
        if(isBank){
            if (addressCMND.count == 0){
                self.showDialog(message: "Địa chỉ CMND không được để trống!")
                return
            }
            if (self.provinceCode.count == 0){
                self.showDialog(message: "Nơi cấp CMND không được để trống!")
                return
            }
            if (dateCMND.count == 0){
                self.showDialog(message: "Ngày cấp CMND không được để trống!")
                return
            }
            if (!checkDate(stringDate: dateCMND)){
                self.showDialog(message: "Ngày cấp CMND sai định dạng!")
                return
            }
            if (idBank.count == 0){
                self.showDialog(message: "Số TK ngân hàng không được để trống!")
                return
            }
            if idBank.range(of:" ") != nil {
                self.showDialog(message: "Số TK ngân hàng không được có khoảng trắng!")
                return
            }
            if (self.bankCode.count == 0){
                self.showDialog(message: "Ngân hàng không được để trống!")
                return
            }
            if (self.bankButton.text!.count == 0){
                self.showDialog(message: "Ngân hàng không được để trống!")
                return
            }
            if (self.branchBankCode.count == 0 && self.listBranchBank.count > 0){
                self.showDialog(message: "Chi nhánh ngân hàng không được để trống!")
                return
            }
            if (self.branchBankButton.text!.count == 0 && self.listBranchBank.count > 0){
                self.showDialog(message: "Chi nhánh ngân hàng không được để trống!")
                return
            }
            
            if (self.tu == "" && self.den == "" || self.tu == "" || self.den == ""){
                self.showDialog(message: "Chiều dài số tài khoản ngân hàng không hợp lệ")
                return
            }
            let tuInt = Int(self.tu)
            let denInt = Int(self.den)
            if (idBank.count < tuInt! || idBank.count > denInt!){
                self.showDialog(message: "Chiều dài số tài khoản ngân hàng không hợp lệ")
                return
            }
        }
        let note = taskNotes.text!
        if (note.count == 0){
            self.showDialog(message: "Ghi chú không được để trống!")
            return
        }


        
        if(self.idTinhThanhPho == 0){
            self.showDialog(message: "Bạn phải chọn Tỉnh/Thành phố trên CMND")
            return
        }
        if(self.idQuanHuyen == 0){
            self.showDialog(message: "Bạn phải chọn Quận/Huyện trên CMND")
            return
        }
        let phuongXaCMND = tfPhuongXa.text!
        if(phuongXaCMND.count <= 0){
            self.showDialog(message: "Bạn phải nhập Phường/Xã trên CMND")
            return
        }
        let tenNguoiThan_1 = tfTenNguoiThan_1.text!
        if(tenNguoiThan_1.count <= 0){
            self.showDialog(message: "Bạn phải nhập tên người thân 1")
            return
        }
        if(self.idQuanHe_1 == ""){
            self.showDialog(message: "Bạn phải chọn quan hệ người thân 1")
            return
        }
        let sdtNguoiThan_1 = tfSDTNguoiThan_1.text!
        if(sdtNguoiThan_1.count <= 0){
            self.showDialog(message: "Bạn phải nhập SĐT người thân 1")
            return
        }
        
        let tenNguoiThan_2 = tfTenNguoiThan_2.text!
        if(tenNguoiThan_2.count <= 0){
            self.showDialog(message: "Bạn phải nhập tên người thân 2")
            return
        }
        if(self.idQuanHe_2 == ""){
            self.showDialog(message: "Bạn phải chọn quan hệ người thân 2")
            return
        }
        let sdtNguoiThan_2 = tfSDTNguoiThan_2.text!
        if(sdtNguoiThan_2.count <= 0){
            self.showDialog(message: "Bạn phải nhập SĐT người thân 2")
            return
        }
        
//        if (sdtNguoiThan_1.hasPrefix("01") && sdtNguoiThan_1.count == 11){
//
//        }else if (sdtNguoiThan_1.hasPrefix("0") && !sdtNguoiThan_1.hasPrefix("01") && sdtNguoiThan_1.count == 10){
//
//        }else{
//            self.showDialog(message: "SĐT người thân 1 không hợp lệ!")
//            return
//        }
        
        if (!sdtNguoiThan_1.hasPrefix("01") && !sdtNguoiThan_1.hasPrefix("00") && sdtNguoiThan_1.hasPrefix("0") && sdtNguoiThan_1.count == 10){
            
        }else{
            self.showDialog(message: "SĐT người thân 1 không hợp lệ!")
            return
        }
        
//        if (sdtNguoiThan_2.hasPrefix("01") && sdtNguoiThan_2.count == 11){
//
//        }else if (sdtNguoiThan_2.hasPrefix("0") && !sdtNguoiThan_2.hasPrefix("01") && sdtNguoiThan_2.count == 10){
//
//        }else{
//            self.showDialog(message: "SĐT người thân 2 không hợp lệ!")
//            return
//        }
        if (!sdtNguoiThan_2.hasPrefix("01") && !sdtNguoiThan_2.hasPrefix("00") && sdtNguoiThan_2.hasPrefix("0") && sdtNguoiThan_2.count == 10){
            
        }else{
            self.showDialog(message: "SĐT người thân 2 không hợp lệ!")
            return
        }
        if((phone == sdtNguoiThan_1) || (phone == sdtNguoiThan_2)){
            self.showDialog(message: "SĐT khách hàng không được trùng với SĐT người thân 1 và người thân 2!")
            return
        }
        if(sdtNguoiThan_1 == sdtNguoiThan_2){
            self.showDialog(message: "SĐT người thân 1 và người thân 2 không được trùng nhau!")
            return
        }
        //
        if(tfSDTNguoiThan_3.text != ""){
            let sdtNguoiThan_3 = tfSDTNguoiThan_3.text!
//            if (sdtNguoiThan_3.hasPrefix("01") && sdtNguoiThan_3.count == 11){
//
//            }else if (sdtNguoiThan_3.hasPrefix("0") && !sdtNguoiThan_3.hasPrefix("01") && sdtNguoiThan_3.count == 10){
//
//            }else{
//                self.showDialog(message: "SĐT người thân 3 không hợp lệ!")
//                return
//            }
            if (!sdtNguoiThan_3.hasPrefix("01") && !sdtNguoiThan_3.hasPrefix("00") && sdtNguoiThan_3.hasPrefix("0") && sdtNguoiThan_3.count == 10){
                
            }else{
                self.showDialog(message: "SĐT người thân 3 không hợp lệ!")
                return
            }
        }
        if(tfSDTNguoiThan_4.text != ""){
              let sdtNguoiThan_4 = tfSDTNguoiThan_4.text!
//              if (sdtNguoiThan_4.hasPrefix("01") && sdtNguoiThan_4.count == 11){
//
//              }else if (sdtNguoiThan_4.hasPrefix("0") && !sdtNguoiThan_4.hasPrefix("01") && sdtNguoiThan_4.count == 10){
//
//              }else{
//                  self.showDialog(message: "SĐT người thân 3 không hợp lệ!")
//                  return
//              }
            if (!sdtNguoiThan_4.hasPrefix("01") && !sdtNguoiThan_4.hasPrefix("00") && sdtNguoiThan_4.hasPrefix("0") && sdtNguoiThan_4.count == 10){
                
            }else{
                self.showDialog(message: "SĐT người thân 4 không hợp lệ!")
                return
            }
          }
        //
        
        //        if (imgViewChanDung == nil){
        //            self.showDialog(message: "Chưa có ảnh chân dung KH")
        //            return
        //        }
       
        
//
//        imagesUpload.removeAll()
//        if(imgViewCMNDTruoc != nil){
//            imagesUpload.updateValue(imgViewCMNDTruoc, forKey: "1")
//        }
//
//        if(imgViewCMNDSau != nil){
//            imagesUpload.updateValue(imgViewCMNDSau, forKey: "2")
//        }
//
//        if(imgViewGPLXTruoc != nil){
//            imagesUpload.updateValue(imgViewGPLXTruoc, forKey: "3")
//        }
//
//        if(imgViewGPLXSau != nil){
//            imagesUpload.updateValue(imgViewGPLXSau, forKey: "4")
//        }
//        if(imgViewFormRegister != nil){
//            imagesUpload.updateValue(imgViewFormRegister, forKey: "5")
//        }
//        if(imgViewTrichNoTD != nil){
//            imagesUpload.updateValue(imgViewTrichNoTD, forKey: "6")
//        }
//        if(imgViewTrichNoTDTrang2 != nil){
//            imagesUpload.updateValue(imgViewTrichNoTDTrang2, forKey: "7")
//        }
//
//        if(imgViewSoHK != nil){
//            imagesUpload.updateValue(imgViewSoHK, forKey: "8")
//        }
//        if(imgViewSoHKTrang2 != nil){
//            imagesUpload.updateValue(imgViewSoHKTrang2, forKey: "9")
//        }
//        if(imgViewSoHKTrang3 != nil){
//            imagesUpload.updateValue(imgViewSoHKTrang3, forKey: "10")
//        }
//        if(imgViewSoHKTrang4 != nil){
//            imagesUpload.updateValue(imgViewSoHKTrang4, forKey: "11")
//        }
//        if(imgViewSoHKTrang5 != nil){
//            imagesUpload.updateValue(imgViewSoHKTrang5, forKey: "12")
//        }
//        if(imgViewSoHKTrang6 != nil){
//            imagesUpload.updateValue(imgViewSoHKTrang6, forKey: "13")
//        }
//        if(imgViewSoHKTrang7 != nil){
//            imagesUpload.updateValue(imgViewSoHKTrang7, forKey: "14")
//        }
//        if(imgViewSaoKeLuong1 != nil){
//            imagesUpload.updateValue(imgViewSaoKeLuong1, forKey: "15")
//        }
//        if(imgViewSaoKeLuong2 != nil){
//            imagesUpload.updateValue(imgViewSaoKeLuong2, forKey: "16")
//        }
//        if(imgViewSaoKeLuong3 != nil){
//            imagesUpload.updateValue(imgViewSaoKeLuong3, forKey: "17")
//        }
//        let newViewController = LoadingViewController()
//        newViewController.content = "Đang upload hình ảnh..."
//        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        self.navigationController?.present(newViewController, animated: true, completion: nil)
//        self.nameimagesUpload.removeAll()
//        uploadImage(loading:newViewController)
        
        actionSaveCustomer2()

        
    
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
                        if (type == "3"){
                            self.CRD_GPLX_MT2 = result
                        }
                        if (type == "4"){
                            self.CRD_GPLX_MS2 = result
                        }
                        if (type == "5"){
                            self.CRD_TheNV2 = result
                        }
                        if (type == "6"){
                            self.CRD_ChanDungKH2 = result
                        }
                        if (type == "7"){
                            self.CRD_XNNS2 = result
                        }
                        if (type == "8"){
                            self.CRD_SHK_12 = result
                        }
                        if (type == "9"){
                            self.CRD_SHK_22 = result
                        }
                        if (type == "10"){
                            self.CRD_SHK_32 = result
                        }
                        if (type == "11"){
                            self.CRD_SHK_42 = result
                        }
                        if (type == "12"){
                            self.CRD_SHK_52 = result
                        }
                        if (type == "13"){
                            self.CRD_SHK_62 = result
                        }
                        if (type == "14"){
                            self.CRD_SHK_72 = result
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
    
    func actionSaveCustomer2(){
        var idxacnhan:String = ""
        let newViewController = LoadingViewController()
        newViewController.content = "Đang đăng ký thông tin KH..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.sp_mpos_UploadImageScoring(UserID:Cache.user!.UserName,IdCardCode:"\(self.ocfdFFriend!.IDcardCode)",Url_MT_CMND: self.CRD_MT_CMND2,
                                                  Url_MS_CMND: self.CRD_MS_CMND2,
                                                  Url_GPLX_MT: self.CRD_GPLX_MT2,
                                                  Url_GPLX_MS: self.CRD_GPLX_MS2,
                                                  Url_TheNV: self.CRD_TheNV2,
                                                  Url_ChanDungKH: self.CRD_ChanDungKH2,
                                                  Url_XacNhanNhanSu: self.CRD_XNNS2,
                                                  Url_SoHoKhau_1: self.CRD_SHK_12,
                                                  Url_SoHoKhau_2: self.CRD_SHK_22,
                                                  Url_SoHoKhau_3: self.CRD_SHK_32,
                                                  Url_SoHoKhau_4:self.CRD_SHK_42,
                                                  Url_SoHoKhau_5: self.CRD_SHK_52,
                                                  Url_SoHoKhau_6:self.CRD_SHK_62,
                                                  Url_SoHoKhau_7: self.CRD_SHK_72,
                                                  Url_SaoKeLuong_1:Cache.CRD_SaoKeLuong1,
                                                  Url_SaoKeLuong_2:Cache.CRD_SaoKeLuong2,
                                                  Url_SaoKeLuong_3:Cache.CRD_SaoKeLuong3,
                                                  CMND: self.ocfdFFriend!.CMND,VendorCode: "\(self.ocfdFFriend!.MaCongTy)", handler: { (result, err) in
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
                    idxacnhan = "\(result[0].IDImageXN)"
                    let name = self.tfName.text!
                    let tDateBirthday = self.tfDateBirthday.text!
                    let phone = self.tfPhone.text!
                    let addressCMND = self.tfAddressCMND.text!
                    let dateCMND = self.tfDateCMND.text!
                    let idBank = self.tfIdBank.text!
                    var codeEmp:String = ""
                    if(self.tfCodeEmp != nil){
                        codeEmp = self.tfCodeEmp.text!
                    }
                    
                    let sdtNguoiThan_1 = self.tfSDTNguoiThan_1.text!
                    let tenNguoiThan_1 = self.tfTenNguoiThan_1.text!
                    
                    let tenNguoiThan_2 = self.tfTenNguoiThan_2.text!
                    let sdtNguoiThan_2 = self.tfSDTNguoiThan_2.text!
                    let note = self.taskNotes.text!
                    let phuongXaCMND = self.tfPhuongXa.text!
                    let tDate = self.tfDate.text!
                    let cmnd = self.tfCMND.text!
                    let positionCode = self.positionCode
                    
                    let email = self.tfEmail.text!
                    let duoiMail = self.emailButton.text!
                    var emailKH = ""
                    if (email.count > 0 && duoiMail.count > 0){
                        emailKH = "\(email)\(duoiMail)"
                    }
            
                    
                    MPOSAPIManager.mpos_sp_CheckUpdateInfo_TraGop(VendorCode: self.ocfdFFriend!.MaCongTy, CMND: cmnd, FullName: name, SDT: phone, HoKhauTT: addressCMND, NgayCapCMND: dateCMND, NoiCapCMND: self.provinceCode, ChucVu: positionCode, NgayKiHD: tDate, SoTKNH: idBank, IdBank: self.bankCode, ChiNhanhNH: self.branchBankCode, Email: emailKH, Note: note, CreateBy: "\(Cache.user!.UserName)", FileAttachName: "\(self.CRD_MT_CMND2)|\(self.CRD_MS_CMND2)|\(self.CRD_ChanDungKH2)", ChiNhanhDN: self.ocfdFFriend!.MaChiNhanhDoanhNghiep,IDCardCode: "\(self.ocfdFFriend!.IDcardCode)", LoaiKH: "1", NgaySinh: tDateBirthday, CreditCard:"", MaNV_KH: codeEmp, VendorCodeRef: "", CMND_TinhThanhPho: "\(self.idTinhThanhPho)", CMND_QuanHuyen: "\(self.idQuanHuyen)", CMND_PhuongXa: "\(phuongXaCMND)", NguoiLienHe: "\(tenNguoiThan_1)", SDT_NguoiLienHe: sdtNguoiThan_1, QuanHeVoiNguoiLienHe: self.idQuanHe_1, NguoiLienHe_2: "\(tenNguoiThan_2)", SDT_NguoiLienHe_2: sdtNguoiThan_2, QuanHeVoiNguoiLienHe_2: self.idQuanHe_2, AnhDaiDien: "",GioThamDinh_TimeFrom:"",GioThamDinh_TimeTo:"",GioThamDinh_OtherTime:"",IdCardcodeRef:"",TenSPThamDinh:"",Gender: self.genderType) { (result,code, err) in
                        // nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            if(err.count <= 0){
                                if(code != "0"){
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    let alert = UIAlertController(title: "Thông báo", message: result, preferredStyle: .alert)
                                    
                                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                        
                                    })
                                    self.present(alert, animated: true)
                                    return
                                }
                                
                                MPOSAPIManager.AddCustomerFFriend(VendorCode: self.ocfdFFriend!.MaCongTy, CMND: cmnd, FullName: name, SDT: phone, HoKhauTT: addressCMND, NgayCapCMND: dateCMND, NoiCapCMND: self.provinceCode, ChucVu: positionCode, NgayKiHD: tDate, SoTKNH: idBank, IdBank: self.bankCode, ChiNhanhNH: self.branchBankCode, Email: emailKH, Note: note, CreateBy: "\(Cache.user!.UserName)", FileAttachName: "\(self.CRD_MT_CMND2)|\(self.CRD_MS_CMND2)", ChiNhanhDN: self.ocfdFFriend!.MaChiNhanhDoanhNghiep,IDCardCode: "\(self.ocfdFFriend!.IDcardCode)", LoaiKH: "1", NgaySinh: tDateBirthday, CreditCard:"", MaNV_KH: codeEmp, VendorCodeRef: "", CMND_TinhThanhPho: "\(self.idTinhThanhPho)", CMND_QuanHuyen: "\(self.idQuanHuyen)", CMND_PhuongXa: "\(phuongXaCMND)", NguoiLienHe: "\(tenNguoiThan_1)", SDT_NguoiLienHe: sdtNguoiThan_1, QuanHeVoiNguoiLienHe: self.idQuanHe_1, NguoiLienHe_2: "\(tenNguoiThan_2)", SDT_NguoiLienHe_2: sdtNguoiThan_2, QuanHeVoiNguoiLienHe_2: self.idQuanHe_2, AnhDaiDien: "",GioThamDinh_TimeFrom:"",GioThamDinh_TimeTo:"",GioThamDinh_OtherTime:"",IdCardcodeRef:"",TenSPThamDinh:"",Gender: self.genderType,IDImageXN:"\(idxacnhan)",ListIDSaoKe:"\(Cache.listIDSaoKeLuongFFriend)",NguoiLienHe_3:"\(self.tfTenNguoiThan_3.text!)",SDT_NguoiLienHe_3:"\(self.tfSDTNguoiThan_3.text!)",QuanHeVoiNguoiLienHe_3:self.idQuanHe_3,NguoiLienHe_4:"\(self.tfTenNguoiThan_4.text!)",SDT_NguoiLienHe_4:"\(self.tfSDTNguoiThan_4.text!)",QuanHeVoiNguoiLienHe_4:self.idQuanHe_4, EVoucher: "", SoHopDong: "",isQrCode:"",isComplete:"",OTP:"") { (result,code, err) in
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
                                            let buttonOne = CancelButton(title: "Đóng") {
                                                
                                                if(self.loaiKH != 2){
                                                    
                                                    _ = self.navigationController?.popToRootViewController(animated: true)
                                                    self.dismiss(animated: true, completion: nil)
                                                    
                                                    let myDict = ["CMND": "\(self.ocfdFFriend!.CMND)"]
                                                    let nc = NotificationCenter.default
                                                    nc.post(name: Notification.Name("AutoLoadCMND"), object: myDict)
                                                }else{
                                                    if(self.ocfdFFriend!.MaHTThanhToan == "BANK"){
                                                        self.actionUploadImage()
                                                    }else{
                                                        _ = self.navigationController?.popToRootViewController(animated: true)
                                                        self.dismiss(animated: true, completion: nil)
                                                        
                                                        let myDict = ["CMND": "\(self.ocfdFFriend!.CMND)"]
                                                        let nc = NotificationCenter.default
                                                        nc.post(name: Notification.Name("AutoLoadCMND"), object: myDict)
                                                    }
                                                }
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
    
    func uploadImage(loading:LoadingViewController){
        let nc = NotificationCenter.default
        if(imagesUpload.count > 0){
            let item = imagesUpload.popFirst()
            if let imageData:NSData = (item?.value.image!)!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
                MPOSAPIManager.UploadImage_CalllogScoring(IdCardCode: "\(self.ocfdFFriend!.IDcardCode)", base64: strBase64, type: "\((item?.key)!)", CMND: self.tfCMND.text ?? "") { (result, err) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        if(err.count <= 0){
                            self.nameimagesUpload.updateValue("\(result)", forKey: "\((item?.key)!)")
                            print("NAME \(result)")
                            self.uploadImage(loading: loading)
                        }else{
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                let title = "THÔNG BÁO(1)"
                                let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                    print("base64 \(strBase64)")
                                    print("type: \((item?.key)!)")
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        }else{
            var CRD_MT_CMND:String = ""
            var CRD_MS_CMND:String = ""
            
            var CRD_GPLX_MT:String = ""
            var CRD_GPLX_MS:String = ""
            var CRD_TheNV:String = ""
            var CRD_ChanDungKH:String = ""
            var CRD_XNNS:String = ""
            var CRD_SHK_1:String = ""
            var CRD_SHK_2:String = ""
            var CRD_SHK_3:String = ""
            var CRD_SHK_4:String = ""
            var CRD_SHK_5:String = ""
            var CRD_SHK_6:String = ""
            var CRD_SHK_7:String = ""
//            var CRD_SaoKeLuong1:String = ""
//
//            var CRD_SaoKeLuong2:String = ""
//            var CRD_SaoKeLuong3:String = ""
            var idxacnhan:String = ""
            
            for item in self.nameimagesUpload {
                let type:String = item.key
                if (type == "1") {
                    CRD_MT_CMND = item.value
                    print("CRD_MT_CMND \(item.value)")
                }
                if (type == "2"){
                    CRD_MS_CMND = item.value
                       print("CRD_MS_CMND \(item.value)")
                }
                if (type == "3"){
                    CRD_GPLX_MT = item.value
                }
                if (type == "4"){
                    CRD_GPLX_MS = item.value
                }
                if (type == "5"){
                    CRD_TheNV = item.value
                }
                if (type == "6"){
                    CRD_ChanDungKH = item.value
                }
                if (type == "7"){
                    CRD_XNNS = item.value
                }
                if (type == "8"){
                    CRD_SHK_1 = item.value
                }
                if (type == "9"){
                    CRD_SHK_2 = item.value
                }
                if (type == "10"){
                    CRD_SHK_3 = item.value
                }
                if (type == "11"){
                    CRD_SHK_4 = item.value
                }
                if (type == "12"){
                    CRD_SHK_5 = item.value
                }
                if (type == "13"){
                    CRD_SHK_6 = item.value
                }
                if (type == "14"){
                    CRD_SHK_7 = item.value
                }
//                if (type == "15"){
//                    CRD_SaoKeLuong1 = item.value
//                }
//                if (type == "16"){
//                    CRD_SaoKeLuong2 = item.value
//                }
//                if (type == "17"){
//                    CRD_SaoKeLuong3 = item.value
//                }
            }
            MPOSAPIManager.sp_mpos_UploadImageScoring(UserID:Cache.user!.UserName,IdCardCode:"\(self.ocfdFFriend!.IDcardCode)",Url_MT_CMND:CRD_MT_CMND,Url_MS_CMND:CRD_MS_CMND,Url_GPLX_MT:CRD_GPLX_MT,Url_GPLX_MS:CRD_GPLX_MS,Url_TheNV:CRD_TheNV,Url_ChanDungKH:CRD_ChanDungKH,Url_XacNhanNhanSu:CRD_XNNS,Url_SoHoKhau_1:CRD_SHK_1,Url_SoHoKhau_2:CRD_SHK_2,Url_SoHoKhau_3:CRD_SHK_3,Url_SoHoKhau_4:CRD_SHK_4,Url_SoHoKhau_5:CRD_SHK_5,Url_SoHoKhau_6:CRD_SHK_6,Url_SoHoKhau_7:CRD_SHK_7,Url_SaoKeLuong_1:Cache.CRD_SaoKeLuong1,Url_SaoKeLuong_2: Cache.CRD_SaoKeLuong2,Url_SaoKeLuong_3: Cache.CRD_SaoKeLuong3,CMND: self.ocfdFFriend!.CMND,VendorCode:"\(self.ocfdFFriend!.MaCongTy)", handler: { (result, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        if(result[0].Result == 0){
                            let alert = UIAlertController(title: "Thông báo", message: result[0].Message, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                
                            })
                            self.present(alert, animated: true)
                            return
                        }
                        idxacnhan = "\(result[0].IDImageXN)"
                        let name = self.tfName.text!
                        let tDateBirthday = self.tfDateBirthday.text!
                        let phone = self.tfPhone.text!
                        let addressCMND = self.tfAddressCMND.text!
                        let dateCMND = self.tfDateCMND.text!
                        let idBank = self.tfIdBank.text!
                        var codeEmp:String = ""
                        if(self.tfCodeEmp != nil){
                            codeEmp = self.tfCodeEmp.text!
                        }
                
                        let sdtNguoiThan_1 = self.tfSDTNguoiThan_1.text!
                        let tenNguoiThan_1 = self.tfTenNguoiThan_1.text!
                        
                        let tenNguoiThan_2 = self.tfTenNguoiThan_2.text!
                        let sdtNguoiThan_2 = self.tfSDTNguoiThan_2.text!
                        let note = self.taskNotes.text!
                         let phuongXaCMND = self.tfPhuongXa.text!
                           let tDate = self.tfDate.text!
                         let cmnd = self.tfCMND.text!
                          let positionCode = self.positionCode
                        
                        let email = self.tfEmail.text!
                        let duoiMail = self.emailButton.text!
                        var emailKH = ""
                        if (email.count > 0 && duoiMail.count > 0){
                            emailKH = "\(email)\(duoiMail)"
                        }
                        let newViewController = LoadingViewController()
                        newViewController.content = "Đang đăng ký thông tin KH..."
                        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                        self.navigationController?.present(newViewController, animated: true, completion: nil)
                        let nc = NotificationCenter.default
                        
                        MPOSAPIManager.mpos_sp_CheckUpdateInfo_TraGop(VendorCode: self.ocfdFFriend!.MaCongTy, CMND: cmnd, FullName: name, SDT: phone, HoKhauTT: addressCMND, NgayCapCMND: dateCMND, NoiCapCMND: self.provinceCode, ChucVu: positionCode, NgayKiHD: tDate, SoTKNH: idBank, IdBank: self.bankCode, ChiNhanhNH: self.branchBankCode, Email: emailKH, Note: note, CreateBy: "\(Cache.user!.UserName)", FileAttachName: "", ChiNhanhDN: self.ocfdFFriend!.MaChiNhanhDoanhNghiep,IDCardCode: "\(self.ocfdFFriend!.IDcardCode)", LoaiKH: "1", NgaySinh: tDateBirthday, CreditCard:"", MaNV_KH: codeEmp, VendorCodeRef: "", CMND_TinhThanhPho: "\(self.idTinhThanhPho)", CMND_QuanHuyen: "\(self.idQuanHuyen)", CMND_PhuongXa: "\(phuongXaCMND)", NguoiLienHe: "\(tenNguoiThan_1)", SDT_NguoiLienHe: sdtNguoiThan_1, QuanHeVoiNguoiLienHe: self.idQuanHe_1, NguoiLienHe_2: "\(tenNguoiThan_2)", SDT_NguoiLienHe_2: sdtNguoiThan_2, QuanHeVoiNguoiLienHe_2: self.idQuanHe_2, AnhDaiDien: "",GioThamDinh_TimeFrom:"",GioThamDinh_TimeTo:"",GioThamDinh_OtherTime:"",IdCardcodeRef:"",TenSPThamDinh:"",Gender: self.genderType) { (result,code, err) in
                            // nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                if(err.count <= 0){
                                    
                                    MPOSAPIManager.AddCustomerFFriend(VendorCode: self.ocfdFFriend!.MaCongTy, CMND: cmnd, FullName: name, SDT: phone, HoKhauTT: addressCMND, NgayCapCMND: dateCMND, NoiCapCMND: self.provinceCode, ChucVu: positionCode, NgayKiHD: tDate, SoTKNH: idBank, IdBank: self.bankCode, ChiNhanhNH: self.branchBankCode, Email: emailKH, Note: note, CreateBy: "\(Cache.user!.UserName)", FileAttachName: "\(CRD_MT_CMND)|\(CRD_MS_CMND)", ChiNhanhDN: self.ocfdFFriend!.MaChiNhanhDoanhNghiep,IDCardCode: "\(self.ocfdFFriend!.IDcardCode)", LoaiKH: "1", NgaySinh: tDateBirthday, CreditCard:"", MaNV_KH: codeEmp, VendorCodeRef: "", CMND_TinhThanhPho: "\(self.idTinhThanhPho)", CMND_QuanHuyen: "\(self.idQuanHuyen)", CMND_PhuongXa: "\(phuongXaCMND)", NguoiLienHe: "\(tenNguoiThan_1)", SDT_NguoiLienHe: sdtNguoiThan_1, QuanHeVoiNguoiLienHe: self.idQuanHe_1, NguoiLienHe_2: "\(tenNguoiThan_2)", SDT_NguoiLienHe_2: sdtNguoiThan_2, QuanHeVoiNguoiLienHe_2: self.idQuanHe_2, AnhDaiDien: "",GioThamDinh_TimeFrom:"",GioThamDinh_TimeTo:"",GioThamDinh_OtherTime:"",IdCardcodeRef:"",TenSPThamDinh:"",Gender: self.genderType,IDImageXN:"\(idxacnhan)",ListIDSaoKe:"\(Cache.listIDSaoKeLuongFFriend)",NguoiLienHe_3:"\(self.tfTenNguoiThan_3.text!)",SDT_NguoiLienHe_3:"\(self.tfSDTNguoiThan_3.text!)",QuanHeVoiNguoiLienHe_3:self.idQuanHe_3,NguoiLienHe_4:"\(self.tfTenNguoiThan_4.text!)",SDT_NguoiLienHe_4:"\(self.tfSDTNguoiThan_4.text!)",QuanHeVoiNguoiLienHe_4:self.idQuanHe_4, EVoucher: "", SoHopDong: "",isQrCode:"",isComplete:"",OTP:"") { (result,code, err) in
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
                                                let buttonOne = CancelButton(title: "Đóng") {
                                                    
                                                    if(self.loaiKH != 2){
                                                        
                                                        _ = self.navigationController?.popToRootViewController(animated: true)
                                                        self.dismiss(animated: true, completion: nil)
                                                        
                                                        let myDict = ["CMND": "\(self.ocfdFFriend!.CMND)"]
                                                        let nc = NotificationCenter.default
                                                        nc.post(name: Notification.Name("AutoLoadCMND"), object: myDict)
                                                    }else{
                                                        if(self.ocfdFFriend!.MaHTThanhToan == "BANK"){
                                                            self.actionUploadImage()
                                                        }else{
                                                            _ = self.navigationController?.popToRootViewController(animated: true)
                                                            self.dismiss(animated: true, completion: nil)
                                                            
                                                            let myDict = ["CMND": "\(self.ocfdFFriend!.CMND)"]
                                                            let nc = NotificationCenter.default
                                                            nc.post(name: Notification.Name("AutoLoadCMND"), object: myDict)
                                                        }
                                                    }
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
    @objc func tapShowCMNDTruoc(sender:UITapGestureRecognizer) {
        self.posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowCMNDSau(sender:UITapGestureRecognizer) {
        self.posImageUpload = 2
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowGPLXTruoc(sender:UITapGestureRecognizer) {
        self.posImageUpload = 3
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowGPLXSau(sender:UITapGestureRecognizer) {
        self.posImageUpload = 4
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowTheNV(sender:UITapGestureRecognizer) {
        self.posImageUpload = 5
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc  func tapShowChanDungKH(sender:UITapGestureRecognizer) {
        self.posImageUpload = 6
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowXNNS(sender:UITapGestureRecognizer) {
        self.posImageUpload = 7
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK(sender:UITapGestureRecognizer) {
        self.posImageUpload = 8
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK2(sender:UITapGestureRecognizer) {
        self.posImageUpload = 9
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK3(sender:UITapGestureRecognizer) {
        self.posImageUpload = 10
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK4(sender:UITapGestureRecognizer) {
        self.posImageUpload = 11
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK5(sender:UITapGestureRecognizer) {
        self.posImageUpload = 12
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK6(sender:UITapGestureRecognizer) {
        self.posImageUpload = 13
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK7(sender:UITapGestureRecognizer) {
        self.posImageUpload = 14
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSaoKeLuong1(sender:UITapGestureRecognizer) {
        self.posImageUpload = 15
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSaoKeLuong2(sender:UITapGestureRecognizer) {
        self.posImageUpload = 16
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSaoKeLuong3(sender:UITapGestureRecognizer) {
        self.posImageUpload = 17
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
        
        viewInfoGPLXTruoc.frame.origin.y = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s:10)
        viewInfoGPLXSau.frame.origin.y = viewInfoGPLXTruoc.frame.size.height + viewInfoGPLXTruoc.frame.origin.y + Common.Size(s:10)
        viewInfoTheNV.frame.origin.y = viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10)
        viewInfoChanDungKH.frame.origin.y = viewInfoTheNV.frame.size.height + viewInfoTheNV.frame.origin.y + Common.Size(s:10)
        viewInfoTrichNoTDTrang2.frame.origin.y = viewInfoChanDungKH.frame.size.height + viewInfoChanDungKH.frame.origin.y + Common.Size(s:10)
        viewInfoSoHK.frame.origin.y = viewInfoTrichNoTDTrang2.frame.size.height + viewInfoTrichNoTDTrang2.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
   
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btUploadImage.frame.origin.y = btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "1", image: self.imgViewCMNDTruoc.image!)
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
        viewInfoGPLXTruoc.frame.origin.y = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s:10)
        viewInfoGPLXSau.frame.origin.y = viewInfoGPLXTruoc.frame.size.height + viewInfoGPLXTruoc.frame.origin.y + Common.Size(s:10)
        viewInfoTheNV.frame.origin.y = viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10)
        viewInfoChanDungKH.frame.origin.y = viewInfoTheNV.frame.size.height + viewInfoTheNV.frame.origin.y + Common.Size(s:10)
        viewInfoTrichNoTDTrang2.frame.origin.y = viewInfoChanDungKH.frame.size.height + viewInfoChanDungKH.frame.origin.y + Common.Size(s:10)
        viewInfoSoHK.frame.origin.y = viewInfoTrichNoTDTrang2.frame.size.height + viewInfoTrichNoTDTrang2.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
   
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btUploadImage.frame.origin.y = btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "2", image: self.imgViewCMNDSau.image!)
        }
      
    }
    
    
    func imageGPLXTruoc(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageGPLXTruoc.frame.size.width / sca
        viewImageGPLXTruoc.subviews.forEach { $0.removeFromSuperview() }
        imgViewGPLXTruoc  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageGPLXTruoc.frame.size.width, height: heightImage))
        imgViewGPLXTruoc.contentMode = .scaleAspectFit
        imgViewGPLXTruoc.image = image
        viewImageGPLXTruoc.addSubview(imgViewGPLXTruoc)
        viewImageGPLXTruoc.frame.size.height = imgViewGPLXTruoc.frame.size.height + imgViewGPLXTruoc.frame.origin.y
        viewInfoGPLXTruoc.frame.size.height = viewImageGPLXTruoc.frame.size.height + viewImageGPLXTruoc.frame.origin.y
        viewInfoGPLXSau.frame.origin.y = viewInfoGPLXTruoc.frame.size.height + viewInfoGPLXTruoc.frame.origin.y + Common.Size(s:10)
        viewInfoTheNV.frame.origin.y = viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10)
        viewInfoChanDungKH.frame.origin.y = viewInfoTheNV.frame.size.height + viewInfoTheNV.frame.origin.y + Common.Size(s:10)
        viewInfoTrichNoTDTrang2.frame.origin.y = viewInfoChanDungKH.frame.size.height + viewInfoChanDungKH.frame.origin.y + Common.Size(s:10)
        viewInfoSoHK.frame.origin.y = viewInfoTrichNoTDTrang2.frame.size.height + viewInfoTrichNoTDTrang2.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
 
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btUploadImage.frame.origin.y = btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "3", image: self.imgViewGPLXTruoc.image!)
        }
      
    }
    
    func imageGPLXSau(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageGPLXSau.frame.size.width / sca
        viewImageGPLXSau.subviews.forEach { $0.removeFromSuperview() }
        imgViewGPLXSau  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageGPLXSau.frame.size.width, height: heightImage))
        imgViewGPLXSau.contentMode = .scaleAspectFit
        imgViewGPLXSau.image = image
        viewImageGPLXSau.addSubview(imgViewGPLXSau)
        viewImageGPLXSau.frame.size.height = imgViewGPLXSau.frame.size.height + imgViewGPLXSau.frame.origin.y
        viewInfoGPLXSau.frame.size.height = viewImageGPLXSau.frame.size.height + viewImageGPLXSau.frame.origin.y
        viewInfoTheNV.frame.origin.y = viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10)
        viewInfoChanDungKH.frame.origin.y = viewInfoTheNV.frame.size.height + viewInfoTheNV.frame.origin.y + Common.Size(s:10)
        viewInfoTrichNoTDTrang2.frame.origin.y = viewInfoChanDungKH.frame.size.height + viewInfoChanDungKH.frame.origin.y + Common.Size(s:10)
        viewInfoSoHK.frame.origin.y = viewInfoTrichNoTDTrang2.frame.size.height + viewInfoTrichNoTDTrang2.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)

        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btUploadImage.frame.origin.y = btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "4", image: self.imgViewGPLXSau.image!)
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
        viewInfoChanDungKH.frame.origin.y = viewInfoTheNV.frame.size.height + viewInfoTheNV.frame.origin.y + Common.Size(s:10)
        viewInfoTrichNoTDTrang2.frame.origin.y = viewInfoChanDungKH.frame.size.height + viewInfoChanDungKH.frame.origin.y + Common.Size(s:10)
        viewInfoSoHK.frame.origin.y = viewInfoTrichNoTDTrang2.frame.size.height + viewInfoTrichNoTDTrang2.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)

        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btUploadImage.frame.origin.y = btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "5", image: self.imgViewFormRegister.image!)
        }
       
    }
    func imageChanDungKH(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageTrichNoTD.frame.size.width / sca
        viewImageTrichNoTD.subviews.forEach { $0.removeFromSuperview() }
        imgViewTrichNoTD  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageTrichNoTD.frame.size.width, height: heightImage))
        imgViewTrichNoTD.contentMode = .scaleAspectFit
        imgViewTrichNoTD.image = image
        viewImageTrichNoTD.addSubview(imgViewTrichNoTD)
        viewImageTrichNoTD.frame.size.height = imgViewTrichNoTD.frame.size.height + imgViewTrichNoTD.frame.origin.y
        viewInfoChanDungKH.frame.size.height = viewImageTrichNoTD.frame.size.height + viewImageTrichNoTD.frame.origin.y
        viewInfoTrichNoTDTrang2.frame.origin.y = viewInfoChanDungKH.frame.size.height + viewInfoChanDungKH.frame.origin.y + Common.Size(s:10)
        viewInfoSoHK.frame.origin.y = viewInfoTrichNoTDTrang2.frame.size.height + viewInfoTrichNoTDTrang2.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)

        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btUploadImage.frame.origin.y = btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "6", image: self.imgViewTrichNoTD.image!)
        }
       
    }
    func imageXNNNS(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageTrichNoTDTrang2.frame.size.width / sca
        viewImageTrichNoTDTrang2.subviews.forEach { $0.removeFromSuperview() }
        imgViewTrichNoTDTrang2  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageTrichNoTDTrang2.frame.size.width, height: heightImage))
        imgViewTrichNoTDTrang2.contentMode = .scaleAspectFit
        imgViewTrichNoTDTrang2.image = image
        viewImageTrichNoTDTrang2.addSubview(imgViewTrichNoTDTrang2)
        viewImageTrichNoTDTrang2.frame.size.height = imgViewTrichNoTDTrang2.frame.size.height + imgViewTrichNoTDTrang2.frame.origin.y
        viewInfoTrichNoTDTrang2.frame.size.height = viewImageTrichNoTDTrang2.frame.size.height + viewImageTrichNoTDTrang2.frame.origin.y
        viewInfoSoHK.frame.origin.y = viewInfoTrichNoTDTrang2.frame.size.height + viewInfoTrichNoTDTrang2.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)

        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
            btUploadImage.frame.origin.y = btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "7", image: self.imgViewTrichNoTDTrang2.image!)
        }
      
    }
    func imageSoHK(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHK.frame.size.width / sca
        viewImageSoHK.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHK  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHK.frame.size.width, height: heightImage))
        imgViewSoHK.contentMode = .scaleAspectFit
        imgViewSoHK.image = image
        viewImageSoHK.addSubview(imgViewSoHK)
        viewImageSoHK.frame.size.height = imgViewSoHK.frame.size.height + imgViewSoHK.frame.origin.y
        viewInfoSoHK.frame.size.height = viewImageSoHK.frame.size.height + viewImageSoHK.frame.origin.y
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)

        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
              btUploadImage.frame.origin.y = btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "8", image: self.imgViewSoHK.image!)
        }
         
    }
    func imageSoHK2(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang2.frame.size.width / sca
        viewImageSoHKTrang2.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang2  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang2.frame.size.width, height: heightImage))
        imgViewSoHKTrang2.contentMode = .scaleAspectFit
        imgViewSoHKTrang2.image = image
        viewImageSoHKTrang2.addSubview(imgViewSoHKTrang2)
        viewImageSoHKTrang2.frame.size.height = imgViewSoHKTrang2.frame.size.height + imgViewSoHKTrang2.frame.origin.y
        viewInfoSoHKTrang2.frame.size.height = viewImageSoHKTrang2.frame.size.height + viewImageSoHKTrang2.frame.origin.y
        
        viewInfoSoHKTrang3.frame.origin.y = viewInfoSoHKTrang2.frame.origin.y + viewInfoSoHKTrang2.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang4.frame.origin.y = viewInfoSoHKTrang3.frame.origin.y + viewInfoSoHKTrang3.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang5.frame.origin.y = viewInfoSoHKTrang4.frame.origin.y + viewInfoSoHKTrang4.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang6.frame.origin.y = viewInfoSoHKTrang5.frame.origin.y + viewInfoSoHKTrang5.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang7.frame.origin.y = viewInfoSoHKTrang6.frame.origin.y + viewInfoSoHKTrang6.frame.size.height + Common.Size(s: 10)
     
        viewUploadMore.frame.size.height = viewInfoSoHKTrang7.frame.size.height + viewInfoSoHKTrang7.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
  
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
                 btUploadImage.frame.origin.y = btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "9", image: self.imgViewSoHKTrang2.image!)
        }
        
    }
    
    func imageSoHK3(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang3.frame.size.width / sca
        viewImageSoHKTrang3.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang3  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang3.frame.size.width, height: heightImage))
        imgViewSoHKTrang3.contentMode = .scaleAspectFit
        imgViewSoHKTrang3.image = image
        viewImageSoHKTrang3.addSubview(imgViewSoHKTrang3)
        viewImageSoHKTrang3.frame.size.height = imgViewSoHKTrang3.frame.size.height + imgViewSoHKTrang3.frame.origin.y
        viewInfoSoHKTrang3.frame.size.height = viewImageSoHKTrang3.frame.size.height + viewImageSoHKTrang3.frame.origin.y
        viewInfoSoHKTrang4.frame.origin.y = viewInfoSoHKTrang3.frame.origin.y + viewInfoSoHKTrang3.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang5.frame.origin.y = viewInfoSoHKTrang4.frame.origin.y + viewInfoSoHKTrang4.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang6.frame.origin.y = viewInfoSoHKTrang5.frame.origin.y + viewInfoSoHKTrang5.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang7.frame.origin.y = viewInfoSoHKTrang6.frame.origin.y + viewInfoSoHKTrang6.frame.size.height + Common.Size(s: 10)
     
        viewUploadMore.frame.size.height = viewInfoSoHKTrang7.frame.size.height + viewInfoSoHKTrang7.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
        

        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
                btUploadImage.frame.origin.y = btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "10", image: self.imgViewSoHKTrang3.image!)
        }
           
    }
    func imageSoHK4(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang4.frame.size.width / sca
        viewImageSoHKTrang4.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang4  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang4.frame.size.width, height: heightImage))
        imgViewSoHKTrang4.contentMode = .scaleAspectFit
        imgViewSoHKTrang4.image = image
        viewImageSoHKTrang4.addSubview(imgViewSoHKTrang4)
        viewImageSoHKTrang4.frame.size.height = imgViewSoHKTrang4.frame.size.height + imgViewSoHKTrang4.frame.origin.y
        viewInfoSoHKTrang4.frame.size.height = viewImageSoHKTrang4.frame.size.height + viewImageSoHKTrang4.frame.origin.y
        viewInfoSoHKTrang5.frame.origin.y = viewInfoSoHKTrang4.frame.origin.y + viewInfoSoHKTrang4.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang6.frame.origin.y = viewInfoSoHKTrang5.frame.origin.y + viewInfoSoHKTrang5.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang7.frame.origin.y = viewInfoSoHKTrang6.frame.origin.y + viewInfoSoHKTrang6.frame.size.height + Common.Size(s: 10)
   
        viewUploadMore.frame.size.height = viewInfoSoHKTrang7.frame.size.height + viewInfoSoHKTrang7.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
  
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btUploadImage.frame.origin.y = btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "11", image: self.imgViewSoHKTrang4.image!)
        }
        
    }
    func imageSoHK5(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang5.frame.size.width / sca
        viewImageSoHKTrang5.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang5  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang5.frame.size.width, height: heightImage))
        imgViewSoHKTrang5.contentMode = .scaleAspectFit
        imgViewSoHKTrang5.image = image
        viewImageSoHKTrang5.addSubview(imgViewSoHKTrang5)
        viewImageSoHKTrang5.frame.size.height = imgViewSoHKTrang5.frame.size.height + imgViewSoHKTrang5.frame.origin.y
        viewInfoSoHKTrang5.frame.size.height = viewImageSoHKTrang5.frame.size.height + viewImageSoHKTrang5.frame.origin.y
        viewInfoSoHKTrang6.frame.origin.y = viewInfoSoHKTrang5.frame.origin.y + viewInfoSoHKTrang5.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang7.frame.origin.y = viewInfoSoHKTrang6.frame.origin.y + viewInfoSoHKTrang6.frame.size.height + Common.Size(s: 10)
     
        viewUploadMore.frame.size.height = viewInfoSoHKTrang7.frame.size.height + viewInfoSoHKTrang7.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
  
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
            btUploadImage.frame.origin.y = btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "12", image: self.imgViewSoHKTrang5.image!)
        }
       
    }
    func imageSoHK6(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang6.frame.size.width / sca
        viewImageSoHKTrang6.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang6  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang6.frame.size.width, height: heightImage))
        imgViewSoHKTrang6.contentMode = .scaleAspectFit
        imgViewSoHKTrang6.image = image
        viewImageSoHKTrang6.addSubview(imgViewSoHKTrang6)
        viewImageSoHKTrang6.frame.size.height = imgViewSoHKTrang6.frame.size.height + imgViewSoHKTrang6.frame.origin.y
        viewInfoSoHKTrang6.frame.size.height = viewImageSoHKTrang6.frame.size.height + viewImageSoHKTrang6.frame.origin.y
        viewInfoSoHKTrang7.frame.origin.y = viewInfoSoHKTrang6.frame.origin.y + viewInfoSoHKTrang6.frame.size.height + Common.Size(s: 10)
  
        viewUploadMore.frame.size.height = viewInfoSoHKTrang7.frame.size.height + viewInfoSoHKTrang7.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
   
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btUploadImage.frame.origin.y = btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "13", image: self.imgViewSoHKTrang6.image!)
        }
           
    }
    func imageSoHK7(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang7.frame.size.width / sca
        viewImageSoHKTrang7.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang7  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang7.frame.size.width, height: heightImage))
        imgViewSoHKTrang7.contentMode = .scaleAspectFit
        imgViewSoHKTrang7.image = image
        viewImageSoHKTrang7.addSubview(imgViewSoHKTrang7)
        viewImageSoHKTrang7.frame.size.height = imgViewSoHKTrang7.frame.size.height + imgViewSoHKTrang7.frame.origin.y
        viewInfoSoHKTrang7.frame.size.height = viewImageSoHKTrang7.frame.size.height + viewImageSoHKTrang7.frame.origin.y
     
        viewUploadMore.frame.size.height = viewInfoSoHKTrang7.frame.size.height + viewInfoSoHKTrang7.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height

        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btUploadImage.frame.origin.y = btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "14", image: self.imgViewSoHKTrang7.image!)
        }
      
    }
    func imageSaoKeLuong1(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSaoKeLuong1.frame.size.width / sca
        viewImageSaoKeLuong1.subviews.forEach { $0.removeFromSuperview() }
        imgViewSaoKeLuong1  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSaoKeLuong1.frame.size.width, height: heightImage))
        imgViewSaoKeLuong1.contentMode = .scaleAspectFit
        imgViewSaoKeLuong1.image = image
        viewImageSaoKeLuong1.addSubview(imgViewSaoKeLuong1)
        viewImageSaoKeLuong1.frame.size.height = imgViewSaoKeLuong1.frame.size.height + imgViewSaoKeLuong1.frame.origin.y
        viewInfoSaoKeLuong1.frame.size.height = viewImageSaoKeLuong1.frame.size.height + viewImageSaoKeLuong1.frame.origin.y
        
        viewInfoSaoKeLuong2.frame.origin.y = viewInfoSaoKeLuong1.frame.size.height + viewInfoSaoKeLuong1.frame.origin.y + Common.Size(s: 10)
        viewInfoSaoKeLuong3.frame.origin.y = viewInfoSaoKeLuong2.frame.size.height + viewInfoSaoKeLuong2.frame.origin.y + Common.Size(s: 10)
        viewUpload.frame.size.height = viewInfoSaoKeLuong3.frame.size.height + viewInfoSaoKeLuong3.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
            btUploadImage.frame.origin.y = btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    func imageSaoKeLuong2(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSaoKeLuong1.frame.size.width / sca
        viewImageSaoKeLuong2.subviews.forEach { $0.removeFromSuperview() }
        imgViewSaoKeLuong2  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSaoKeLuong2.frame.size.width, height: heightImage))
        imgViewSaoKeLuong2.contentMode = .scaleAspectFit
        imgViewSaoKeLuong2.image = image
        viewImageSaoKeLuong2.addSubview(imgViewSaoKeLuong2)
        viewImageSaoKeLuong2.frame.size.height = imgViewSaoKeLuong2.frame.size.height + imgViewSaoKeLuong2.frame.origin.y
        viewInfoSaoKeLuong2.frame.size.height = viewImageSaoKeLuong2.frame.size.height + viewImageSaoKeLuong2.frame.origin.y
        
        viewInfoSaoKeLuong3.frame.origin.y = viewInfoSaoKeLuong2.frame.size.height + viewInfoSaoKeLuong2.frame.origin.y + Common.Size(s: 10)
        viewUpload.frame.size.height = viewInfoSaoKeLuong3.frame.size.height + viewInfoSaoKeLuong3.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
            btUploadImage.frame.origin.y = btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    func imageSaoKeLuong3(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSaoKeLuong1.frame.size.width / sca
        viewImageSaoKeLuong3.subviews.forEach { $0.removeFromSuperview() }
        imgViewSaoKeLuong3  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSaoKeLuong3.frame.size.width, height: heightImage))
        imgViewSaoKeLuong3.contentMode = .scaleAspectFit
        imgViewSaoKeLuong3.image = image
        viewImageSaoKeLuong3.addSubview(imgViewSaoKeLuong3)
        viewImageSaoKeLuong3.frame.size.height = imgViewSaoKeLuong3.frame.size.height + imgViewSaoKeLuong3.frame.origin.y
        viewInfoSaoKeLuong3.frame.size.height = viewImageSaoKeLuong3.frame.size.height + viewImageSaoKeLuong3.frame.origin.y
        
        viewUpload.frame.size.height = viewInfoSaoKeLuong3.frame.size.height + viewInfoSaoKeLuong3.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
               btUploadImage.frame.origin.y = btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    @objc func tapShowUploadMore(sender:UITapGestureRecognizer) {
        if(viewUploadMore.frame.size.height != 0){
            viewUploadMore.frame.size.height = 0
        }else{
            viewUploadMore.frame.size.height = heightUploadView
        }

        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btSaveCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
               btUploadImage.frame.origin.y = btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }

    func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
    
    fileprivate func createRadioButtonGender(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:12));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(UpdateCustomerInstallmentViewController.logSelectedButtonGender), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonGender(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioMan.isSelected = false
            radioWoman.isSelected = false
            switch temp {
            case "Nam":
                genderType = 0
                Cache.genderType = 0
                radioMan.isSelected = true
                break
            case "Nữ":
                genderType = 1
                Cache.genderType = 1
                radioWoman.isSelected = true
                break
            default:
                genderType = -1
                Cache.genderType = -1
                break
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if(textField == tfDateBirthday || textField == tfDateCMND || textField == tfDate){
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
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
            if(textField == tfDateBirthday){
                if let text = textField.text, text != "" && text != "DD/MM/YYYY" {
                    // Do something with your value
                } else {
                    textField.text = ""
                }
            }
         
        }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField == tfName){
            let str = tfName.text!
            if(str.count > 0){
                tfName.text = str.capitalized
            }else{
                
                
            }
        }
        if (textField == tfTenNguoiThan_1){
            let str = tfTenNguoiThan_1.text!
            if(str.count > 0){
                tfTenNguoiThan_1.text = str.capitalized
            }else{
                
                
            }
        }
        if (textField == tfTenNguoiThan_2){
            let str = tfTenNguoiThan_2.text!
            if(str.count > 0){
                tfTenNguoiThan_2.text = str.capitalized
            }else{
                
                
            }
        }
        if (textField == tfTenNguoiThan_3){
            let str = tfTenNguoiThan_3.text!
            if(str.count > 0){
                tfTenNguoiThan_3.text = str.capitalized
            }else{
                
                
            }
        }
        if (textField == tfTenNguoiThan_4){
            let str = tfTenNguoiThan_4.text!
            if(str.count > 0){
                tfTenNguoiThan_4.text = str.capitalized
            }else{
                
                
            }
        }
    }
}
extension UpdateCustomerInstallmentViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
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
         //self.openCamera()
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        if (self.posImageUpload == 1){
            
            self.imageCMNDTruoc(image: image)
        }else if (self.posImageUpload == 2){
            
            self.imageCMNDSau(image: image)
        }else if (self.posImageUpload == 3){
            self.imageGPLXTruoc(image: image)
        }else if (self.posImageUpload == 4){
            self.imageGPLXSau(image: image)
        }else if (self.posImageUpload == 5){
            self.imageTheNV(image: image)
        }else if (self.posImageUpload == 6){
            self.imageChanDungKH(image: image)
        }else if (self.posImageUpload == 7){
            self.imageXNNNS(image: image)
        }else if (self.posImageUpload == 8){
            self.imageSoHK(image: image)
        }else if (self.posImageUpload == 9){
            self.imageSoHK2(image: image)
        }else if (self.posImageUpload == 10){
            self.imageSoHK3(image: image)
        }else if (self.posImageUpload == 11){
            self.imageSoHK4(image: image)
        }else if (self.posImageUpload == 12){
            self.imageSoHK5(image: image)
        }else if (self.posImageUpload == 13){
            self.imageSoHK6(image: image)
        }else if (self.posImageUpload == 14){
            self.imageSoHK7(image: image)
        }else if (self.posImageUpload == 15){
            self.imageSaoKeLuong1(image: image)
        }else if (self.posImageUpload == 16){
            self.imageSaoKeLuong2(image: image)
        }else if (self.posImageUpload == 17){
            self.imageSaoKeLuong3(image: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
  

}

