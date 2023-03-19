//
//  VNPTInfoCustomerViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 11/15/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class VNPTInfoCustomerViewController: UIViewController,UITextFieldDelegate{
    var scrollView:UIScrollView!
    
    var tfCMND:UITextField!
    var tfCusName:UITextField!
    var tfPhone:UITextField!
    var tfTinhTrang:UITextField!
    var tfOTP:UITextField!
    
    var viewInfoCMNDTruoc:UIView!
    var viewImageCMNDTruoc:UIView!
    var imgViewCMNDTruoc: UIImageView!
    
    //--
    //--
    var viewInfoCMNDSau:UIView!
    var viewImageCMNDSau:UIView!
    var imgViewCMNDSau: UIImageView!
    
    
    
    var viewInfoPhieuMuaHang:UIView!
    var viewImagePhieuMuaHang:UIView!
    var imgViewPhieuMuaHang: UIImageView!
    
    
    
    var imagePicker = UIImagePickerController()
    var barSearchRight : UIBarButtonItem!
    var posImageUpload:Int = -1
    var btChooseProduction:UIButton!
    var lbShowHistoryCustomer:UILabel!
    var infoCMND:InfoCmndVNPT?
    var url_cmnd_matTruoc:String = ""
    var url_cmnd_matsau:String = ""
    var url_phieumuahang:String = ""
    var viewKH:UIView!
    var viewTTND:UIView!
    var viewOTP:UIView!
    var viewUpload:UIView!
    var tfUnit:UITextField!
    var tfNameND:UITextField!
    var tfPositionND:UITextField!
    var tfPhoneND:UITextField!
    var tfEmailND:UITextField!
    var heightViewND:CGFloat = 0.0
    var isShowND:Bool = false

    override func viewDidLoad() {
        self.title = "VNPT"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(VNPTInfoCustomerViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        let btSearchIcon = UIButton.init(type: .custom)
        
        btSearchIcon.setImage(#imageLiteral(resourceName: "list"), for: UIControl.State.normal)
        btSearchIcon.imageView?.contentMode = .scaleAspectFit
        btSearchIcon.addTarget(self, action: #selector(VNPTInfoCustomerViewController.tapShowHistoryShop), for: UIControl.Event.touchUpInside)
        btSearchIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barSearchRight = UIBarButtonItem(customView: btSearchIcon)
        
        self.navigationItem.rightBarButtonItems = [barSearchRight]
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        let lbTextCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMND.textAlignment = .left
        lbTextCMND.textColor = UIColor.black
        lbTextCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMND.text = "CMND"
        scrollView.addSubview(lbTextCMND)
        
        tfCMND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextCMND.frame.origin.y + lbTextCMND.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:70) , height: Common.Size(s:40)));
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
        tfCMND.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        //tfCMND.text = "164156657"
        
        let btnScan = UIImageView(frame:CGRect(x: tfCMND.frame.size.width + tfCMND.frame.origin.x + Common.Size(s: 10) , y:  tfCMND.frame.origin.y, width: Common.Size(s:25), height: tfCMND.frame.size.height));
        btnScan.image = #imageLiteral(resourceName: "ItemCamera")
        btnScan.contentMode = .scaleAspectFit
        scrollView.addSubview(btnScan)
        
        let tapScan = UITapGestureRecognizer(target: self, action: #selector(actionScan(_:)))
        btnScan.isUserInteractionEnabled = true
        btnScan.addGestureRecognizer(tapScan)
        
        let lbTextHoTen = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfCMND.frame.origin.y + tfCMND.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextHoTen.textAlignment = .left
        lbTextHoTen.textColor = UIColor.black
        lbTextHoTen.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextHoTen.text = "Họ và tên"
        scrollView.addSubview(lbTextHoTen)
        
        tfCusName = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextHoTen.frame.origin.y + lbTextHoTen.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfCusName.placeholder = "Nhập họ tên khách hàng"
        tfCusName.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCusName.borderStyle = UITextField.BorderStyle.roundedRect
        tfCusName.autocorrectionType = UITextAutocorrectionType.no
        tfCusName.keyboardType = UIKeyboardType.numberPad
        tfCusName.returnKeyType = UIReturnKeyType.done
        tfCusName.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCusName.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCusName.delegate = self
        scrollView.addSubview(tfCusName)
        
        let lbTextSDT = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfCusName.frame.origin.y + tfCusName.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSDT.textAlignment = .left
        lbTextSDT.textColor = UIColor.black
        lbTextSDT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSDT.text = "Số điện thoại"
        scrollView.addSubview(lbTextSDT)
        
        tfPhone = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextSDT.frame.origin.y + lbTextSDT.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        
        tfPhone.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhone.autocorrectionType = UITextAutocorrectionType.no
        tfPhone.keyboardType = UIKeyboardType.phonePad
        tfPhone.returnKeyType = UIReturnKeyType.done
        tfPhone.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhone.delegate = self
        scrollView.addSubview(tfPhone)
        
        let lbTextTinhTrang = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhone.frame.origin.y + tfPhone.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextTinhTrang.textAlignment = .left
        lbTextTinhTrang.textColor = UIColor.black
        lbTextTinhTrang.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTinhTrang.text = "Tình trạng"
        scrollView.addSubview(lbTextTinhTrang)
        
        tfTinhTrang = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextTinhTrang.frame.origin.y + lbTextTinhTrang.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        
        tfTinhTrang.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTinhTrang.borderStyle = UITextField.BorderStyle.roundedRect
        tfTinhTrang.autocorrectionType = UITextAutocorrectionType.no
        tfTinhTrang.keyboardType = UIKeyboardType.phonePad
        tfTinhTrang.returnKeyType = UIReturnKeyType.done
        tfTinhTrang.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTinhTrang.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTinhTrang.delegate = self
        tfTinhTrang.isUserInteractionEnabled = false
        scrollView.addSubview(tfTinhTrang)
        
        let labelTTND = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfTinhTrang.frame.origin.y + tfTinhTrang.frame.size.height , width: self.view.frame.width - Common.Size(s: 110), height: Common.Size(s: 35)))
        labelTTND.text = "THÔNG TIN NGƯỜI DUYỆT"
        labelTTND.textColor = UIColor(netHex:0x04AB6E)
        labelTTND.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        scrollView.addSubview(labelTTND)
        
        let lbInfoCustomerMore = UILabel(frame: CGRect(x: labelTTND.frame.size.width + labelTTND.frame.origin.x, y: labelTTND.frame.origin.y + Common.Size(s:10) ,width:scrollView.frame.size.width/2 - Common.Size(s:15), height: Common.Size(s: 14)))
        lbInfoCustomerMore.textAlignment = .left
        lbInfoCustomerMore.textColor = UIColor(netHex:0x04AB6E)
        lbInfoCustomerMore.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
    
        lbInfoCustomerMore.text = "Ẩn/Hiện"
        scrollView.addSubview(lbInfoCustomerMore)
        
        let tapShowDetailCustomer = UITapGestureRecognizer(target: self, action: #selector(VNPTInfoCustomerViewController.tapShowDetailCustomer))
        lbInfoCustomerMore.isUserInteractionEnabled = true
        lbInfoCustomerMore.addGestureRecognizer(tapShowDetailCustomer)
        
        viewTTND = UIView()
        viewTTND.frame = CGRect(x: 0, y:labelTTND.frame.origin.y + labelTTND.frame.size.height , width: scrollView.frame.size.width, height: 0)
        viewTTND.backgroundColor = UIColor.white
        viewTTND.clipsToBounds = true
        scrollView.addSubview(viewTTND)
        
        let lbTextUnit = UILabel(frame: CGRect(x: Common.Size(s:15), y:Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextUnit.textAlignment = .left
        lbTextUnit.textColor = UIColor.black
        lbTextUnit.clipsToBounds = true
        lbTextUnit.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextUnit.text = "Đơn vị"
        viewTTND.addSubview(lbTextUnit)
        
        tfUnit = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextUnit.frame.origin.y + lbTextUnit.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
     
        tfUnit.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfUnit.borderStyle = UITextField.BorderStyle.roundedRect
        tfUnit.autocorrectionType = UITextAutocorrectionType.no
        tfUnit.keyboardType = UIKeyboardType.default
        tfUnit.returnKeyType = UIReturnKeyType.done
        tfUnit.clearButtonMode = UITextField.ViewMode.whileEditing
        tfUnit.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfUnit.delegate = self
        tfUnit.clipsToBounds = true
        tfUnit.isUserInteractionEnabled = false
        viewTTND.addSubview(tfUnit)
        
        let lbTextHoTenND = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfUnit.frame.origin.y + tfUnit.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextHoTenND.textAlignment = .left
        lbTextHoTenND.textColor = UIColor.black
        lbTextHoTenND.clipsToBounds = true
        lbTextHoTenND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextHoTenND.text = "Họ và tên người duyệt"
        viewTTND.addSubview(lbTextHoTenND)
        
        tfNameND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextHoTenND.frame.origin.y + lbTextHoTenND.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
      
        tfNameND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfNameND.borderStyle = UITextField.BorderStyle.roundedRect
        tfNameND.autocorrectionType = UITextAutocorrectionType.no
        tfNameND.keyboardType = UIKeyboardType.default
        tfNameND.returnKeyType = UIReturnKeyType.done
        tfNameND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfNameND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfNameND.delegate = self
        tfNameND.clipsToBounds = true
        tfNameND.isUserInteractionEnabled = false
        viewTTND.addSubview(tfNameND)
        
        let lbTextPositionND = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfNameND.frame.origin.y + tfNameND.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPositionND.textAlignment = .left
        lbTextPositionND.textColor = UIColor.black
        lbTextPositionND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPositionND.clipsToBounds = true
        lbTextPositionND.text = "Chức vụ người duyệt"
        viewTTND.addSubview(lbTextPositionND)
        
        tfPositionND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPositionND.frame.origin.y + lbTextPositionND.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        
        tfPositionND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPositionND.borderStyle = UITextField.BorderStyle.roundedRect
        tfPositionND.autocorrectionType = UITextAutocorrectionType.no
        tfPositionND.keyboardType = UIKeyboardType.default
        tfPositionND.clipsToBounds = true
        tfPositionND.returnKeyType = UIReturnKeyType.done
        tfPositionND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPositionND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPositionND.delegate = self
        tfPositionND.isUserInteractionEnabled = false
        viewTTND.addSubview(tfPositionND)
        
        
        let lbTextPhoneND = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPositionND.frame.origin.y + tfPositionND.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhoneND.textAlignment = .left
        lbTextPhoneND.textColor = UIColor.black
        lbTextPhoneND.clipsToBounds = true
        lbTextPhoneND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhoneND.text = "SĐT người duyệt"
        viewTTND.addSubview(lbTextPhoneND)
        
        tfPhoneND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhoneND.frame.origin.y + lbTextPhoneND.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        
        tfPhoneND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhoneND.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhoneND.autocorrectionType = UITextAutocorrectionType.no
        tfPhoneND.keyboardType = UIKeyboardType.default
        tfPhoneND.returnKeyType = UIReturnKeyType.done
        tfPhoneND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhoneND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhoneND.delegate = self
        tfPhoneND.clipsToBounds = true
        tfPhoneND.isUserInteractionEnabled = false
        viewTTND.addSubview(tfPhoneND)
        
        
        let lbTextEmailND = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhoneND.frame.origin.y + tfPhoneND.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextEmailND.textAlignment = .left
        lbTextEmailND.textColor = UIColor.black
        lbTextEmailND.clipsToBounds = true
        lbTextEmailND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextEmailND.text = "Email người duyệt"
        viewTTND.addSubview(lbTextEmailND)
        
        tfEmailND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextEmailND.frame.origin.y + lbTextEmailND.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfEmailND.clipsToBounds = true
        tfEmailND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfEmailND.borderStyle = UITextField.BorderStyle.roundedRect
        tfEmailND.autocorrectionType = UITextAutocorrectionType.no
        tfEmailND.keyboardType = UIKeyboardType.default
        tfEmailND.returnKeyType = UIReturnKeyType.done
        tfEmailND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfEmailND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfEmailND.delegate = self
        tfEmailND.isUserInteractionEnabled = false
        viewTTND.addSubview(tfEmailND)
        viewTTND.frame.size.height = tfEmailND.frame.size.height + tfEmailND.frame.origin.y + Common.Size(s:10)
        heightViewND = viewTTND.frame.size.height
        viewTTND.frame.size.height = 0
        
        viewOTP = UIView()
        viewOTP.frame = CGRect(x: 0, y:viewTTND.frame.origin.y + viewTTND.frame.size.height , width: scrollView.frame.size.width, height: 0)
        viewOTP.backgroundColor = UIColor.white
        scrollView.addSubview(viewOTP)
        
        let lbTextOTP = UILabel(frame: CGRect(x: Common.Size(s:15), y:  Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextOTP.textAlignment = .left
        lbTextOTP.textColor = UIColor.black
        lbTextOTP.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextOTP.text = "OTP"
        viewOTP.addSubview(lbTextOTP)
        
        
        tfOTP = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextOTP.frame.origin.y + lbTextOTP.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:180) , height: Common.Size(s:40)));
        
        tfOTP.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfOTP.borderStyle = UITextField.BorderStyle.roundedRect
        tfOTP.autocorrectionType = UITextAutocorrectionType.no
        tfOTP.keyboardType = UIKeyboardType.numberPad
        tfOTP.returnKeyType = UIReturnKeyType.done
        tfOTP.clearButtonMode = UITextField.ViewMode.whileEditing
        tfOTP.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfOTP.delegate = self
        viewOTP.addSubview(tfOTP)
        
        let btOTP = UIButton()
        btOTP.frame = CGRect(x: tfOTP.frame.origin.x + tfOTP.frame.size.width + Common.Size(s:10), y: lbTextOTP.frame.origin.y + lbTextOTP.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:180), height: Common.Size(s:40))
        btOTP.backgroundColor = UIColor(netHex:0x00955E)
        btOTP.setTitle("Lấy mã OTP", for: .normal)
        btOTP.addTarget(self, action: #selector(actionSendOTP), for: .touchUpInside)
        btOTP.layer.borderWidth = 0.5
        btOTP.layer.borderColor = UIColor.white.cgColor
        btOTP.layer.cornerRadius = 5.0
        viewOTP.addSubview(btOTP)
        
        let lbSendOTPMail = UILabel(frame: CGRect(x: Common.Size(s:15), y: btOTP.frame.size.height + btOTP.frame.origin.y + Common.Size(s: 15), width:scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 14)))
        lbSendOTPMail.textAlignment = .center
        lbSendOTPMail.textColor = UIColor(netHex:0x04AB6E)
        lbSendOTPMail.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute1 = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString1 = NSAttributedString(string: "Gửi OTP qua mail", attributes: underlineAttribute1)
        lbSendOTPMail.attributedText = underlineAttributedString1
        viewOTP.addSubview(lbSendOTPMail)
        let tapSendOTPMail = UITapGestureRecognizer(target: self, action: #selector(VNPTInfoCustomerViewController.tapSendOTPMail))
        lbSendOTPMail.isUserInteractionEnabled = true
        lbSendOTPMail.addGestureRecognizer(tapSendOTPMail)
        
        viewOTP.frame.size.height = lbSendOTPMail.frame.size.height + lbSendOTPMail.frame.origin.y + Common.Size(s:10)
        
        viewUpload = UIView()
        viewUpload.frame = CGRect(x: 0, y:viewOTP.frame.size.height + viewOTP.frame.origin.y + Common.Size(s:10) , width: scrollView.frame.size.width, height: 0)
        viewUpload.backgroundColor = UIColor.white
        scrollView.addSubview(viewUpload)
        
        
        viewInfoCMNDTruoc = UIView(frame: CGRect(x:0,y: Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoCMNDTruoc.clipsToBounds = true
        viewUpload.addSubview(viewInfoCMNDTruoc)
        
        let lbTextCMNDTruoc = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMNDTruoc.textAlignment = .left
        lbTextCMNDTruoc.textColor = UIColor.black
        lbTextCMNDTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMNDTruoc.text = "Mặt trước CMND"
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
        
        let lbPDKButtonCMNDTruoc = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageCMNDTruoc.frame.size.height/3))
        lbPDKButtonCMNDTruoc.textAlignment = .center
        lbPDKButtonCMNDTruoc.textColor = UIColor(netHex:0xc2c2c2)
        lbPDKButtonCMNDTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPDKButtonCMNDTruoc.text = "Thêm hình ảnh"
        viewImageCMNDTruoc.addSubview(lbPDKButtonCMNDTruoc)
        viewInfoCMNDTruoc.frame.size.height = viewImageCMNDTruoc.frame.size.height + viewImageCMNDTruoc.frame.origin.y
        
        let tapShowCMNDTruoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDTruoc))
        viewImageCMNDTruoc.isUserInteractionEnabled = true
        viewImageCMNDTruoc.addGestureRecognizer(tapShowCMNDTruoc)
        
        
        viewInfoCMNDSau = UIView(frame: CGRect(x:0,y:viewInfoCMNDTruoc.frame.size.height + viewInfoCMNDTruoc.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoCMNDSau.clipsToBounds = true
        viewUpload.addSubview(viewInfoCMNDSau)
        
        let lbTextCMNDSau = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMNDSau.textAlignment = .left
        lbTextCMNDSau.textColor = UIColor.black
        lbTextCMNDSau.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMNDSau.text = "Mặt sau CMND"
        viewInfoCMNDSau.addSubview(lbTextCMNDSau)
        
        viewImageCMNDSau = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextCMNDTruoc.frame.origin.y + lbTextCMNDTruoc.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageCMNDSau.layer.borderWidth = 0.5
        viewImageCMNDSau.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageCMNDSau.layer.cornerRadius = 3.0
        viewInfoCMNDSau.addSubview(viewImageCMNDSau)
        
        let viewCMNDSauButton = UIImageView(frame: CGRect(x: viewImageCMNDTruoc.frame.size.width/2 - (viewImageCMNDTruoc.frame.size.height * 2/3)/2, y: 0, width: viewImageCMNDTruoc.frame.size.height * 2/3, height: viewImageCMNDTruoc.frame.size.height * 2/3))
        viewCMNDSauButton.image = UIImage(named:"AddImage")
        viewCMNDSauButton.contentMode = .scaleAspectFit
        viewImageCMNDSau.addSubview(viewCMNDSauButton)
        
        let lbPDKButtonCMNDSau = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageCMNDTruoc.frame.size.height/3))
        lbPDKButtonCMNDSau.textAlignment = .center
        lbPDKButtonCMNDSau.textColor = UIColor(netHex:0xc2c2c2)
        lbPDKButtonCMNDSau.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPDKButtonCMNDSau.text = "Thêm hình ảnh"
        viewImageCMNDSau.addSubview(lbPDKButtonCMNDSau)
        viewInfoCMNDSau.frame.size.height = viewImageCMNDSau.frame.size.height + viewImageCMNDSau.frame.origin.y
        
        let tapShowCMNDSau = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDSau))
        viewImageCMNDSau.isUserInteractionEnabled = true
        viewImageCMNDSau.addGestureRecognizer(tapShowCMNDSau)
        
        
        viewInfoPhieuMuaHang = UIView(frame: CGRect(x:0,y:viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoPhieuMuaHang.clipsToBounds = true
        viewUpload.addSubview(viewInfoPhieuMuaHang)
        
        let lbTextPhieuMuaHang = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhieuMuaHang.textAlignment = .left
        lbTextPhieuMuaHang.textColor = UIColor.black
        lbTextPhieuMuaHang.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhieuMuaHang.text = "Phiếu mua hàng"
        viewInfoPhieuMuaHang.addSubview(lbTextPhieuMuaHang)
        
        viewImagePhieuMuaHang = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextPhieuMuaHang.frame.origin.y + lbTextPhieuMuaHang.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImagePhieuMuaHang.layer.borderWidth = 0.5
        viewImagePhieuMuaHang.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImagePhieuMuaHang.layer.cornerRadius = 3.0
        viewInfoPhieuMuaHang.addSubview(viewImagePhieuMuaHang)
        
        let viewPhieuMuaHangButton = UIImageView(frame: CGRect(x: viewImagePhieuMuaHang.frame.size.width/2 - (viewImagePhieuMuaHang.frame.size.height * 2/3)/2, y: 0, width: viewImagePhieuMuaHang.frame.size.height * 2/3, height: viewImagePhieuMuaHang.frame.size.height * 2/3))
        viewPhieuMuaHangButton.image = UIImage(named:"AddImage")
        viewPhieuMuaHangButton.contentMode = .scaleAspectFit
        viewImagePhieuMuaHang.addSubview(viewPhieuMuaHangButton)
        
        let lbPDKButtonPhieuMuaHang = UILabel(frame: CGRect(x: 0, y: viewPhieuMuaHangButton.frame.size.height + viewPhieuMuaHangButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImagePhieuMuaHang.frame.size.height/3))
        lbPDKButtonPhieuMuaHang.textAlignment = .center
        lbPDKButtonPhieuMuaHang.textColor = UIColor(netHex:0xc2c2c2)
        lbPDKButtonPhieuMuaHang.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPDKButtonPhieuMuaHang.text = "Thêm hình ảnh"
        viewImagePhieuMuaHang.addSubview(lbPDKButtonPhieuMuaHang)
        viewInfoPhieuMuaHang.frame.size.height = viewImagePhieuMuaHang.frame.size.height + viewImagePhieuMuaHang.frame.origin.y
        
        let tapShowPhieuMuaHang = UITapGestureRecognizer(target: self, action: #selector(self.tapShowPhieuMuaHang))
        viewImagePhieuMuaHang.isUserInteractionEnabled = true
        viewImagePhieuMuaHang.addGestureRecognizer(tapShowPhieuMuaHang)
        
        btChooseProduction = UIButton()
        btChooseProduction.frame = CGRect(x: Common.Size(s:15), y: viewInfoPhieuMuaHang.frame.origin.y + viewInfoPhieuMuaHang.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: tfCMND.frame.size.height * 1.1)
        btChooseProduction.backgroundColor = UIColor(netHex:0x00955E)
        btChooseProduction.setTitle("Chọn sản phẩm", for: .normal)
        btChooseProduction.addTarget(self, action: #selector(tapChooseProduction), for: .touchUpInside)
        btChooseProduction.layer.borderWidth = 0.5
        btChooseProduction.layer.borderColor = UIColor.white.cgColor
        btChooseProduction.layer.cornerRadius = 5.0
        viewUpload.addSubview(btChooseProduction)
        
        lbShowHistoryCustomer = UILabel(frame: CGRect(x: Common.Size(s:15), y: btChooseProduction.frame.size.height + btChooseProduction.frame.origin.y + Common.Size(s: 10), width:scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 14)))
        lbShowHistoryCustomer.textAlignment = .center
        lbShowHistoryCustomer.textColor = UIColor(netHex:0x04AB6E)
        lbShowHistoryCustomer.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Lịch sử mua hàng của KH", attributes: underlineAttribute)
        lbShowHistoryCustomer.attributedText = underlineAttributedString
        viewUpload.addSubview(lbShowHistoryCustomer)
        let tapShowHistory = UITapGestureRecognizer(target: self, action: #selector(VNPTInfoCustomerViewController.tapShowHistoryCustomer))
        lbShowHistoryCustomer.isUserInteractionEnabled = true
        lbShowHistoryCustomer.addGestureRecognizer(tapShowHistory)
        
        viewUpload.frame.size.height = lbShowHistoryCustomer.frame.origin.y + lbShowHistoryCustomer.frame.size.height + Common.Size(s:10)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewUpload.frame.origin.y + viewUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
    }
    
    @objc func tapShowHistoryCustomer(){
        self.tfCMND.resignFirstResponder()
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
        let newViewController = HistoryCMNDVNPTViewController()
        newViewController.cmnd = self.tfCMND.text!
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func tapShowHistoryShop(){
        self.tfCMND.resignFirstResponder()
        let newViewController = HistoryVNPTViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
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
        let newViewController = LoadingViewController()
        newViewController.content = "Đang gửi otp vui lòng chờ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_FRT_SP_VNPT_sendotp(CMND:self.tfCMND.text!,sdt_email:self.infoCMND!.SDT_boss,type:"1") { (result,err) in
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                if(err.count <= 0){
                    
                    let title = "THÔNG BÁO"
                    let popup = PopupDialog(title: title, message: result, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
    @objc func tapSendOTPMail(){
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
        let newViewController = LoadingViewController()
        newViewController.content = "Đang gửi otp vui lòng chờ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_FRT_SP_VNPT_sendotp(CMND:self.tfCMND.text!,sdt_email: "\(self.infoCMND!.Emai_boss)",type:"2") { (result,err) in
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                if(err.count <= 0){
                    
                    let title = "THÔNG BÁO"
                    let popup = PopupDialog(title: title, message: result, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
    @objc func tapChooseProduction(){
        
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
        if(self.tfOTP.text == ""){
            let title = "THÔNG BÁO"
            let popup = PopupDialog(title: title, message: "Vui lòng nhập OTP !", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        if(self.tfCusName.text == ""){
            let title = "THÔNG BÁO"
            let popup = PopupDialog(title: title, message: "Chưa load thông tin KH !", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        if(self.url_cmnd_matTruoc == ""){
            let title = "THÔNG BÁO"
            let popup = PopupDialog(title: title, message: "Chưa chụp hình mặt trước cmnd !", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        if(self.url_cmnd_matsau == ""){
            let title = "THÔNG BÁO"
            let popup = PopupDialog(title: title, message: "Chưa chụp hình mặt sau cmnd !", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
            
        }
        if(self.url_phieumuahang == ""){
            let title = "THÔNG BÁO"
            let popup = PopupDialog(title: title, message: "Chưa chụp hình phiếu mua hàng !", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin khách hàng..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_FRT_SP_VNPT_create_info(otp:self.tfOTP.text!,cmnd:self.tfCMND.text!,sdt:self.tfPhone.text!,TenKh:self.tfCusName.text!,url_cmnd_matTruoc:self.url_cmnd_matTruoc,url_cmnd_matsau:self.url_cmnd_matsau,url_phieumuahang:self.url_phieumuahang) { (result,err) in
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                if(err.count <= 0){
                    if(result[0].p_status == 0){
                        let title = "THÔNG BÁO"
                        let popup = PopupDialog(title: title, message: result[0].p_messages, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                        return
                    }
                    
                    let newViewController = ProductVNPTViewController()
                    self.infoCMND?.Docentry = result[0].Docentry
                    Cache.infoCMNDVNPT = self.infoCMND
                    
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
            
        }
        
        
    }
    
    
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func actionScan(_: UITapGestureRecognizer){
        self.posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
        
    }
    
    @objc  func tapShowCMNDTruoc(sender:UITapGestureRecognizer) {
        self.posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowCMNDSau(sender:UITapGestureRecognizer) {
        self.posImageUpload = 2
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowPhieuMuaHang(sender:UITapGestureRecognizer) {
        self.posImageUpload = 3
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField == tfCMND){
            let cmnd = textField.text!
            if(cmnd.count > 0){
                self.actionLoadCMND()
            }else{
                
            }
        }
    }
    @objc func tapShowDetailCustomer(sender:UITapGestureRecognizer) {
        if(isShowND == false){
            isShowND = true
            viewTTND.frame.size.height = heightViewND
            viewOTP.frame.origin.y = viewTTND.frame.size.height + viewTTND.frame.origin.y + Common.Size(s:10)
            viewUpload.frame.origin.y = viewOTP.frame.size.height + viewOTP.frame.origin.y + Common.Size(s:10)
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewUpload.frame.origin.y + viewUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        }else{
            isShowND = false
            viewTTND.frame.size.height = 0
            viewOTP.frame.origin.y = viewTTND.frame.size.height + viewTTND.frame.origin.y + Common.Size(s:10)
            viewUpload.frame.origin.y = viewOTP.frame.size.height + viewOTP.frame.origin.y + Common.Size(s:10)
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewUpload.frame.origin.y + viewUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
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
                            self.tfCMND.text = result!.IdCard
                            self.actionLoadCMND()
                            
                        }
                        
                        
                        
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
        
    }
    func uploadImage(image:UIImage,type:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang upload hình ảnh, vui lòng chờ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        if let imageData:NSData = image.jpegData(compressionQuality: Common.resizeImageScanCMND) as NSData?{
            let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
            MPOSAPIManager.mpos_FRT_Image_VNPT(CMND:"\(self.tfCMND.text!)",IDMpos:"\(self.infoCMND?.ID_mpos ?? 0)",Base64:"\(strBase64)",Type:"\(type)") { (result,err) in
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    if(err.count <= 0){
                        if (type == "1") {
                            self.url_cmnd_matTruoc = result
                        }
                        if (type == "2"){
                            self.url_cmnd_matsau = result
                            
                        }
                        if (type == "3"){
                            self.url_phieumuahang = result
                        }
                        
                        
                        
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
    }
    func actionLoadCMND(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang load thông tin KH..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_FRT_SP_VNPT_loadinfoByCMND(CMND:"\(self.tfCMND.text!)") { (result,err) in
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                if(err.count <= 0){
                    if(result[0].p_status == 0){
                        let title = "THÔNG BÁO"
                        let popup = PopupDialog(title: title, message: result[0].p_messagess, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                        return
                    }
                    self.infoCMND = result[0]
                    
                    self.tfCusName.text = result[0].TenKH
                    self.tfCusName.isUserInteractionEnabled = false
                    self.tfPhone.text = result[0].SDT
                    self.tfPhone.isUserInteractionEnabled = false
                    self.tfTinhTrang.text = result[0].p_messagess
                    self.tfNameND.text = result[0].HoTen_boss
                    self.tfPositionND.text = result[0].Chucvu_boss
                    self.tfPhoneND.text = result[0].SDT_boss
                    self.tfEmailND.text = result[0].Emai_boss
                    self.tfUnit.text = result[0].DonVi
                    
                    
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
        
        viewInfoCMNDSau.frame.origin.y =  viewInfoCMNDTruoc.frame.size.height + viewInfoCMNDTruoc.frame.origin.y + Common.Size(s: 10)
        
        viewInfoPhieuMuaHang.frame.origin.y =  viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s: 10)
        
        btChooseProduction.frame.origin.y = viewInfoPhieuMuaHang.frame.size.height + viewInfoPhieuMuaHang.frame.origin.y + Common.Size(s:10)
        lbShowHistoryCustomer.frame.origin.y = btChooseProduction.frame.size.height + btChooseProduction.frame.origin.y + Common.Size(s: 10)
        viewUpload.frame.size.height = lbShowHistoryCustomer.frame.origin.y + lbShowHistoryCustomer.frame.size.height + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewUpload.frame.origin.y + viewUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30) )
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            if(self.tfCMND.text! != ""){
                self.uploadImage(image: self.imgViewCMNDTruoc.image!,type:"1")
            }else{
                self.scanCMND(image: self.imgViewCMNDTruoc.image!)
            }
            
            
        }
        
        
    }
    func imageCMNDSau(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDTruoc.frame.size.width / sca
        viewImageCMNDSau.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDSau  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDSau.frame.size.width, height: heightImage))
        imgViewCMNDSau.contentMode = .scaleAspectFit
        imgViewCMNDSau.image = image
        viewImageCMNDSau.addSubview(imgViewCMNDSau)
        viewImageCMNDSau.frame.size.height = imgViewCMNDSau.frame.size.height + imgViewCMNDSau.frame.origin.y
        viewInfoCMNDSau.frame.size.height = viewImageCMNDSau.frame.size.height + viewImageCMNDSau.frame.origin.y
        
        
        viewInfoPhieuMuaHang.frame.origin.y =  viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s: 10)
        
        btChooseProduction.frame.origin.y = viewInfoPhieuMuaHang.frame.size.height + viewInfoPhieuMuaHang.frame.origin.y + Common.Size(s:10)
        lbShowHistoryCustomer.frame.origin.y = btChooseProduction.frame.size.height + btChooseProduction.frame.origin.y + Common.Size(s: 10)
        viewUpload.frame.size.height = lbShowHistoryCustomer.frame.origin.y + lbShowHistoryCustomer.frame.size.height + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewUpload.frame.origin.y + viewUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30) )
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImage( image: self.imgViewCMNDSau.image!,type: "2")
            
        }
        
        
    }
    
    func imagePhieuMuaHang(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImagePhieuMuaHang.frame.size.width / sca
        viewImagePhieuMuaHang.subviews.forEach { $0.removeFromSuperview() }
        imgViewPhieuMuaHang  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImagePhieuMuaHang.frame.size.width, height: heightImage))
        imgViewPhieuMuaHang.contentMode = .scaleAspectFit
        imgViewPhieuMuaHang.image = image
        viewImagePhieuMuaHang.addSubview(imgViewPhieuMuaHang)
        viewImagePhieuMuaHang.frame.size.height = imgViewPhieuMuaHang.frame.size.height + imgViewPhieuMuaHang.frame.origin.y
        viewInfoPhieuMuaHang.frame.size.height = viewImagePhieuMuaHang.frame.size.height + viewImagePhieuMuaHang.frame.origin.y
        
        btChooseProduction.frame.origin.y = viewInfoPhieuMuaHang.frame.size.height + viewInfoPhieuMuaHang.frame.origin.y + Common.Size(s:10)
        lbShowHistoryCustomer.frame.origin.y = btChooseProduction.frame.size.height + btChooseProduction.frame.origin.y + Common.Size(s: 15)
        viewUpload.frame.size.height = lbShowHistoryCustomer.frame.origin.y + lbShowHistoryCustomer.frame.size.height + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewUpload.frame.origin.y + viewUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30) )
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImage(image: self.imgViewPhieuMuaHang.image!,type: "3")
            
        }
        
        
    }
    
}
extension VNPTInfoCustomerViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
        self.openCamera()
        //        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        //        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
        //            self.openCamera()
        //        }))
        //
        //        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
        //            self.openGallary()
        //        }))
        //
        //        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        //
        //        /*If you want work actionsheet on ipad
        //         then you have to use popoverPresentationController to present the actionsheet,
        //         otherwise app will crash on iPad */
        //        switch UIDevice.current.userInterfaceIdiom {
        //        case .pad:
        //            //            alert.popoverPresentationController?.sourceView = sender
        //            //            alert.popoverPresentationController?.sourceRect = sender.bounds
        //            alert.popoverPresentationController?.permittedArrowDirections = .up
        //        default:
        //            break
        //        }
        //        self.present(alert, animated: true, completion: nil)
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
            self.imagePhieuMuaHang(image: image)
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
