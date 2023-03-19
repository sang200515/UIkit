//
//  FFriendViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Foundation
import SelectionDialog
import PopupDialog
import AVFoundation
import SwiftyJSON
import Toaster
import WebKit
class FFriendViewController: UIViewController,UITextFieldDelegate {
    
    var scrollView:UIScrollView!
    var viewInfoCustomer:UIView!
    
    var viewInfoInstallment:UIView!
    var viewInfoCallLog:UIView!
    var viewInfoButtons:UIView!
    
    var tfCMND:UITextField!
    var tfName:UITextField!
    var tfPhone:UITextField!
    var tfCompany:UILabel!
    var tfType:UITextField!
    var tfUnusedAmount:UITextField!
    var tfUsedAmount:UITextField!
    var tfStatus:UITextField!
    var tfCallLogTT:UITextField!
    var tfCallLogUQTN:UITextField!
    var lbInfoCustomerMore:UILabel!
    var lbInfoCallLogMore:UILabel!
    var lbInfoHistoryMore:UILabel!
    var btCreateOrder:UIButton!
    
    var btUpdate:UIButton!
    var btCreateNew:UIButton!
    var ocfdFFriend:OCRDFFriend?
    
    var lbUpdate:UILabel!
    var lbTextStatusCallLog:UILabel!
    
    var CMND:String = ""
    var autoLoadCMND: Int = 0 // 1: auto
    var hinhthucmua:String = ""
    var webView:WKWebView!
 
    var FtelCustomer:QRcodeFFriend? = nil
    var isQrCode:String = "0"
    
    deinit {
        print("DEBUG: DEINIT FFriendViewController")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(FFriendViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        //---
        let viewRightNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: viewRightNav)
        let btAddIcon = UIButton.init(type: .custom)
        btAddIcon.setImage(#imageLiteral(resourceName: "scan"), for: UIControl.State.normal)
        btAddIcon.imageView?.contentMode = .scaleAspectFit
        btAddIcon.addTarget(self, action: #selector(FFriendViewController.actionScan), for: UIControl.Event.touchUpInside)
        btAddIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewRightNav.addSubview(btAddIcon)
        //---
        
        navigationController?.navigationBar.isTranslucent = false
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "F.Friends"
        
        
        let lbUserInfo = UILabel(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:20)))
        lbUserInfo.textAlignment = .center
        lbUserInfo.textColor = UIColor(netHex:0x04AB6E)
        lbUserInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbUserInfo.text = "THÔNG TIN KHÁCH HÀNG"
        scrollView.addSubview(lbUserInfo)
        
        let lbTextCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbUserInfo.frame.size.height + lbUserInfo.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
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
        tfCMND.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        let  lbInfoCheckCredit = UILabel(frame: CGRect(x:tfCMND.frame.origin.x, y: tfCMND.frame.size.height + tfCMND.frame.origin.y + Common.Size(s: 5), width:  scrollView.frame.size.width/2 - Common.Size(s:15), height: Common.Size(s: 14)))
        lbInfoCheckCredit.textAlignment = .left
        lbInfoCheckCredit.textColor = UIColor(netHex:0x04AB6E)
        lbInfoCheckCredit.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute1 = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString1 = NSAttributedString(string: "Check DNghiệp", attributes: underlineAttribute1)
        lbInfoCheckCredit.attributedText = underlineAttributedString1
        scrollView.addSubview(lbInfoCheckCredit)
        let tapShowCheckCredit = UITapGestureRecognizer(target: self, action: #selector(FFriendViewController.tapShowCheckCredit))
        lbInfoCheckCredit.isUserInteractionEnabled = true
        lbInfoCheckCredit.addGestureRecognizer(tapShowCheckCredit)
        
        let  lbInfoCheckCreditNoCard = UILabel(frame: CGRect(x:scrollView.frame.size.width/2, y: lbInfoCheckCredit.frame.origin.y , width: scrollView.frame.size.width/2 - Common.Size(s:15), height: Common.Size(s: 14)))
        lbInfoCheckCreditNoCard.textAlignment = .right
        lbInfoCheckCreditNoCard.textColor = UIColor(netHex:0x04AB6E)
        lbInfoCheckCreditNoCard.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute11 = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString11 = NSAttributedString(string: "Check Credit không thẻ", attributes: underlineAttribute11)
        lbInfoCheckCreditNoCard.attributedText = underlineAttributedString11
        lbInfoCheckCreditNoCard.isEnabled = false
        scrollView.addSubview(lbInfoCheckCreditNoCard)
        lbInfoCheckCreditNoCard.isHidden = true
        //        let tapShowCheckCreditNoCard = UITapGestureRecognizer(target: self, action: #selector(FFriendViewController.tapShowCheckCreditNoCard))
        //        lbInfoCheckCreditNoCard.isUserInteractionEnabled = true
        //        lbInfoCheckCreditNoCard.addGestureRecognizer(tapShowCheckCreditNoCard)
        
        lbInfoCustomerMore = UILabel(frame: CGRect(x: scrollView.frame.size.width/2, y: lbInfoCheckCreditNoCard.frame.size.height + lbInfoCheckCreditNoCard.frame.origin.y + Common.Size(s: 10), width:scrollView.frame.size.width/2 - Common.Size(s:15), height: Common.Size(s: 14)))
        lbInfoCustomerMore.textAlignment = .right
        lbInfoCustomerMore.textColor = UIColor(netHex:0x04AB6E)
        lbInfoCustomerMore.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Hiện chi tiết", attributes: underlineAttribute)
        lbInfoCustomerMore.attributedText = underlineAttributedString
        scrollView.addSubview(lbInfoCustomerMore)
        let tapShowDetailCustomer = UITapGestureRecognizer(target: self, action: #selector(FFriendViewController.tapShowDetailCustomer))
        lbInfoCustomerMore.isUserInteractionEnabled = true
        lbInfoCustomerMore.addGestureRecognizer(tapShowDetailCustomer)
        
        viewInfoCustomer = UIView(frame: CGRect(x:0,y:lbInfoCustomerMore.frame.origin.y + lbInfoCustomerMore.frame.size.height,width:scrollView.frame.size.width, height: 0))
        //        viewInfoCustomer.backgroundColor = .red
        viewInfoCustomer.clipsToBounds = true
        scrollView.addSubview(viewInfoCustomer)
        
        let lbTextName = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextName.textAlignment = .left
        lbTextName.textColor = UIColor.black
        lbTextName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextName.text = "Tên khách hàng"
        viewInfoCustomer.addSubview(lbTextName)
        
        tfName = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextName.frame.size.height + lbTextName.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfName.placeholder = ""
        tfName.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfName.borderStyle = UITextField.BorderStyle.roundedRect
        tfName.autocorrectionType = UITextAutocorrectionType.no
        tfName.keyboardType = UIKeyboardType.default
        tfName.returnKeyType = UIReturnKeyType.done
        tfName.clearButtonMode =  UITextField.ViewMode.whileEditing
        tfName.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfName.delegate = self
        tfName.isUserInteractionEnabled = false
        viewInfoCustomer.addSubview(tfName)
        tfName.isEnabled = false
        
        let lbTextPhone = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfName.frame.size.height + tfName.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhone.textAlignment = .left
        lbTextPhone.textColor = UIColor.black
        lbTextPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhone.text = "Số điện thoại khách hàng"
        viewInfoCustomer.addSubview(lbTextPhone)
        
        tfPhone = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhone.frame.size.height + lbTextPhone.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfPhone.placeholder = ""
        tfPhone.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhone.autocorrectionType = UITextAutocorrectionType.no
        tfPhone.keyboardType = UIKeyboardType.numberPad
        tfPhone.returnKeyType = UIReturnKeyType.done
        tfPhone.clearButtonMode =  UITextField.ViewMode.whileEditing
        tfPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhone.delegate = self
        tfPhone.isUserInteractionEnabled = false
        viewInfoCustomer.addSubview(tfPhone)
        tfPhone.isEnabled = false
        
        let lbTextCompany = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhone.frame.size.height + tfPhone.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCompany.textAlignment = .left
        lbTextCompany.textColor = UIColor.black
        lbTextCompany.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCompany.text = "Tên công ty"
        viewInfoCustomer.addSubview(lbTextCompany)
        
        tfCompany = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbTextCompany.frame.size.height + lbTextCompany.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:80)))
//        tfCompany.placeholder = ""
        tfCompany.font = UIFont.systemFont(ofSize: Common.Size(s:15))
//        tfCompany.borderStyle = UITextField.BorderStyle.roundedRect
//        tfCompany.autocorrectionType = UITextAutocorrectionType.no
//        tfCompany.keyboardType = UIKeyboardType.default
//        tfCompany.returnKeyType = UIReturnKeyType.done
//        tfCompany.clearButtonMode =  UITextField.ViewMode.whileEditing
//        tfCompany.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
//        tfCompany.delegate = self
        tfCompany.numberOfLines = 0
        tfCompany.isUserInteractionEnabled = false
        viewInfoCustomer.addSubview(tfCompany)
        tfCompany.isEnabled = false
        
    
        viewInfoInstallment = UIView(frame: CGRect(x:0,y:viewInfoCustomer.frame.origin.y + viewInfoCustomer.frame.size.height,width:scrollView.frame.size.width, height: 100))
        //                viewInfoInstallment.backgroundColor = .red
        scrollView.addSubview(viewInfoInstallment)
        
        let lbTextType = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextType.textAlignment = .left
        lbTextType.textColor = UIColor.black
        lbTextType.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextType.text = "Hình thức mua hàng"
        viewInfoInstallment.addSubview(lbTextType)
        
        tfType = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextType.frame.size.height + lbTextType.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfType.placeholder = ""
        tfType.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfType.borderStyle = UITextField.BorderStyle.roundedRect
        tfType.autocorrectionType = UITextAutocorrectionType.no
        tfType.keyboardType = UIKeyboardType.default
        tfType.returnKeyType = UIReturnKeyType.done
        tfType.clearButtonMode =  UITextField.ViewMode.whileEditing
        tfType.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfType.delegate = self
        tfType.textAlignment = .center
        tfType.isUserInteractionEnabled = false
        viewInfoInstallment.addSubview(tfType)
        tfType.isEnabled = false
        
        viewInfoButtons = UIView(frame: CGRect(x:0,y:tfType.frame.origin.y + tfType.frame.size.height,width:scrollView.frame.size.width, height: 0))
        //         viewInfoButtons.backgroundColor = .red
        viewInfoButtons.clipsToBounds = true
        viewInfoInstallment.addSubview(viewInfoButtons)
        
        btCreateNew = UIButton()
        btCreateNew.frame = CGRect(x: 0, y:  Common.Size(s:10), width: scrollView.frame.size.width/4, height: 0)
        btCreateNew.backgroundColor = UIColor(netHex:0xEF4A40)
        btCreateNew.setTitle("Tạo mới", for: .normal)
        btCreateNew.addTarget(self, action: #selector(actionCreateNew), for: .touchUpInside)
        btCreateNew.layer.borderWidth = 0.5
        btCreateNew.layer.borderColor = UIColor.white.cgColor
        btCreateNew.layer.cornerRadius = 3
        viewInfoButtons.addSubview(btCreateNew)
        
        let sp = (scrollView.frame.size.width - (btCreateNew.frame.size.width * 2))/3
        
        btUpdate = UIButton()
        btUpdate.frame = CGRect(x: btCreateNew.frame.size.width + btCreateNew.frame.origin.x + Common.Size(s:sp), y:  Common.Size(s:10), width: 0, height: scrollView.frame.size.width/9)
        btUpdate.backgroundColor = UIColor(netHex:0xEF4A40)
        btUpdate.setTitle("Cập nhật", for: .normal)
        btUpdate.addTarget(self, action: #selector(actionUpdate), for: .touchUpInside)
        btUpdate.layer.borderWidth = 0.5
        btUpdate.layer.borderColor = UIColor.white.cgColor
        btUpdate.layer.cornerRadius = 3
        viewInfoButtons.addSubview(btUpdate)
        

        
        let lbInstallmentInfo = UILabel(frame: CGRect(x: Common.Size(s:20), y:viewInfoButtons.frame.size.height + viewInfoButtons.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:20)))
        lbInstallmentInfo.textAlignment = .center
        lbInstallmentInfo.textColor = UIColor(netHex:0x04AB6E)
        lbInstallmentInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbInstallmentInfo.text = "THÔNG TIN TRẢ GÓP"
        viewInfoInstallment.addSubview(lbInstallmentInfo)
        
        let lbTextUnused = UILabel(frame: CGRect(x: Common.Size(s:15), y:lbInstallmentInfo.frame.size.height + lbInstallmentInfo.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextUnused.textAlignment = .left
        lbTextUnused.textColor = UIColor.black
        lbTextUnused.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextUnused.text = "Hạn mức cho phép"
        viewInfoInstallment.addSubview(lbTextUnused)
        
        tfUnusedAmount = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextUnused.frame.size.height + lbTextUnused.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfUnusedAmount.placeholder = ""
        tfUnusedAmount.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfUnusedAmount.borderStyle = UITextField.BorderStyle.roundedRect
        tfUnusedAmount.autocorrectionType = UITextAutocorrectionType.no
        tfUnusedAmount.keyboardType = UIKeyboardType.default
        tfUnusedAmount.returnKeyType = UIReturnKeyType.done
        tfUnusedAmount.clearButtonMode =  UITextField.ViewMode.whileEditing
        tfUnusedAmount.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfUnusedAmount.delegate = self
        tfUnusedAmount.textAlignment = .center
        tfUnusedAmount.isUserInteractionEnabled = false
        viewInfoInstallment.addSubview(tfUnusedAmount)
        tfUnusedAmount.isEnabled = false
        
        let lbTextUsed = UILabel(frame: CGRect(x: Common.Size(s:15), y:tfUnusedAmount.frame.size.height + tfUnusedAmount.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextUsed.textAlignment = .left
        lbTextUsed.textColor = UIColor.black
        lbTextUsed.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextUsed.text = "Hạn mức còn lại"
        viewInfoInstallment.addSubview(lbTextUsed)
        
        tfUsedAmount = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextUsed.frame.size.height + lbTextUsed.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfUsedAmount.placeholder = ""
        tfUsedAmount.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfUsedAmount.borderStyle = UITextField.BorderStyle.roundedRect
        tfUsedAmount.autocorrectionType = UITextAutocorrectionType.no
        tfUsedAmount.keyboardType = UIKeyboardType.default
        tfUsedAmount.returnKeyType = UIReturnKeyType.done
        tfUsedAmount.clearButtonMode =  UITextField.ViewMode.whileEditing
        tfUsedAmount.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfUsedAmount.delegate = self
        tfUsedAmount.textAlignment = .center
        tfUsedAmount.isUserInteractionEnabled = false
        viewInfoInstallment.addSubview(tfUsedAmount)
        tfUsedAmount.isEnabled = false
        
        let lbTextStatus = UILabel(frame: CGRect(x: Common.Size(s:15), y:tfUsedAmount.frame.size.height + tfUsedAmount.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextStatus.textAlignment = .left
        lbTextStatus.textColor = UIColor.black
        lbTextStatus.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextStatus.text = "Tình trạng hạn mức"
        viewInfoInstallment.addSubview(lbTextStatus)
        
        tfStatus = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextStatus.frame.size.height + lbTextStatus.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfStatus.placeholder = ""
        tfStatus.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfStatus.borderStyle = UITextField.BorderStyle.roundedRect
        tfStatus.autocorrectionType = UITextAutocorrectionType.no
        tfStatus.keyboardType = UIKeyboardType.default
        tfStatus.returnKeyType = UIReturnKeyType.done
        tfStatus.clearButtonMode =  UITextField.ViewMode.whileEditing
        tfStatus.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfStatus.delegate = self
        tfStatus.isUserInteractionEnabled = false
        tfStatus.textAlignment = .center
        viewInfoInstallment.addSubview(tfStatus)
        tfStatus.isEnabled = false
        
        lbInfoCallLogMore = UILabel(frame: CGRect(x: scrollView.frame.size.width/2, y: tfStatus.frame.size.height + tfStatus.frame.origin.y + Common.Size(s: 5), width: scrollView.frame.size.width/2 - Common.Size(s:15), height: Common.Size(s: 14)))
        lbInfoCallLogMore.textAlignment = .right
        lbInfoCallLogMore.textColor = UIColor(netHex:0x04AB6E)
        lbInfoCallLogMore.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttributeCallLog = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedStringCallLog = NSAttributedString(string: "Hiện CallLog", attributes: underlineAttributeCallLog)
        lbInfoCallLogMore.attributedText = underlineAttributedStringCallLog
        viewInfoInstallment.addSubview(lbInfoCallLogMore)
        
        let tapShowDetailCallLog = UITapGestureRecognizer(target: self, action: #selector(FFriendViewController.tapShowDetailCallLog))
        lbInfoCallLogMore.isUserInteractionEnabled = true
        lbInfoCallLogMore.addGestureRecognizer(tapShowDetailCallLog)
        
        viewInfoCallLog = UIView(frame: CGRect(x:0,y:lbInfoCallLogMore.frame.origin.y + lbInfoCallLogMore.frame.size.height,width:scrollView.frame.size.width, height: 0))
        //                        viewInfoCallLog.backgroundColor = .red
        viewInfoCallLog.clipsToBounds = true
        scrollView.addSubview(viewInfoCallLog)
        
        let lbTextCallLogInfo = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:24), width: scrollView.frame.size.width/2 - Common.Size(s:15), height: Common.Size(s:40)))
        lbTextCallLogInfo.textAlignment = .left
        lbTextCallLogInfo.textColor = UIColor.black
        lbTextCallLogInfo.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTextCallLogInfo.text = "CallLog duyệt TT"
        viewInfoCallLog.addSubview(lbTextCallLogInfo)
        
        tfCallLogTT = UITextField(frame: CGRect(x: scrollView.frame.size.width/2, y: lbTextCallLogInfo.frame.origin.y, width: scrollView.frame.size.width/2 - Common.Size(s:15) , height: Common.Size(s:40)))
        tfCallLogTT.placeholder = ""
        tfCallLogTT.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCallLogTT.borderStyle = UITextField.BorderStyle.roundedRect
        tfCallLogTT.autocorrectionType = UITextAutocorrectionType.no
        tfCallLogTT.keyboardType = UIKeyboardType.default
        tfCallLogTT.returnKeyType = UIReturnKeyType.done
        tfCallLogTT.clearButtonMode =  UITextField.ViewMode.whileEditing
        tfCallLogTT.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCallLogTT.delegate = self
        tfCallLogTT.textAlignment = .center
        tfCallLogTT.isUserInteractionEnabled = false
        viewInfoCallLog.addSubview(tfCallLogTT)
        tfCallLogTT.isEnabled = false
        
        let clickCallogTT = UIView(frame: tfCallLogTT.frame)
        viewInfoCallLog.addSubview(clickCallogTT)
        
        let tapShowCallogTT = UITapGestureRecognizer(target: self, action: #selector(FFriendViewController.tapShowCallogTT))
        clickCallogTT.isUserInteractionEnabled = true
        clickCallogTT.addGestureRecognizer(tapShowCallogTT)
        
        let lbTextCallLogUQTN = UILabel(frame: CGRect(x: Common.Size(s:15), y:lbTextCallLogInfo.frame.size.height + lbTextCallLogInfo.frame.origin.y + Common.Size(s:24), width: scrollView.frame.size.width/2 - Common.Size(s:15), height: Common.Size(s:40)))
        lbTextCallLogUQTN.textAlignment = .left
        lbTextCallLogUQTN.textColor = UIColor.black
        lbTextCallLogUQTN.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTextCallLogUQTN.text = "Calllog UQTN/Mở thẻ"
        viewInfoCallLog.addSubview(lbTextCallLogUQTN)
        
        tfCallLogUQTN = UITextField(frame: CGRect(x: scrollView.frame.size.width/2, y: lbTextCallLogUQTN.frame.origin.y, width: scrollView.frame.size.width/2 - Common.Size(s:15) , height: Common.Size(s:40)))
        tfCallLogUQTN.placeholder = ""
        tfCallLogUQTN.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCallLogUQTN.borderStyle = UITextField.BorderStyle.roundedRect
        tfCallLogUQTN.autocorrectionType = UITextAutocorrectionType.no
        tfCallLogUQTN.keyboardType = UIKeyboardType.default
        tfCallLogUQTN.returnKeyType = UIReturnKeyType.done
        tfCallLogUQTN.clearButtonMode =  UITextField.ViewMode.whileEditing
        tfCallLogUQTN.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCallLogUQTN.delegate = self
        tfCallLogUQTN.textAlignment = .center
        tfCallLogUQTN.isUserInteractionEnabled = false
        viewInfoCallLog.addSubview(tfCallLogUQTN)
        tfCallLogUQTN.isEnabled = false
        
        lbTextStatusCallLog = UILabel(frame:CGRect(x:tfCallLogUQTN.frame.origin.x, y:tfCallLogUQTN.frame.size.height + tfCallLogUQTN.frame.origin.y + Common.Size(s:5), width: tfCallLogUQTN.frame.size.width, height: Common.Size(s:20)))
        lbTextStatusCallLog.textAlignment = .center
        lbTextStatusCallLog.textColor = UIColor.red
        lbTextStatusCallLog.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        viewInfoCallLog.addSubview(lbTextStatusCallLog)
        
        let clickCallogUQTN = UIView(frame: tfCallLogUQTN.frame)
        viewInfoCallLog.addSubview(clickCallogUQTN)
        
        let tapShowCallogUQTN = UITapGestureRecognizer(target: self, action: #selector(FFriendViewController.tapShowCallogUQTN))
        clickCallogUQTN.isUserInteractionEnabled = true
        clickCallogUQTN.addGestureRecognizer(tapShowCallogUQTN)
      
        viewInfoInstallment.addSubview(viewInfoCallLog)
        
        lbInfoHistoryMore = UILabel(frame: CGRect(x: scrollView.frame.size.width/2, y: viewInfoCallLog.frame.size.height + viewInfoCallLog.frame.origin.y + Common.Size(s: 15), width: scrollView.frame.size.width/2 - Common.Size(s:15), height: Common.Size(s: 14)))
        lbInfoHistoryMore.textAlignment = .right
        lbInfoHistoryMore.textColor = UIColor(netHex:0x04AB6E)
        lbInfoHistoryMore.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttributeHistory = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedStringHistory = NSAttributedString(string: "Lịch sử mua hàng", attributes: underlineAttributeHistory)
        lbInfoHistoryMore.attributedText = underlineAttributedStringHistory
        viewInfoInstallment.addSubview(lbInfoHistoryMore)
        
        let tapShowHistory = UITapGestureRecognizer(target: self, action: #selector(FFriendViewController.tapShowHistory))
        lbInfoHistoryMore.isUserInteractionEnabled = true
        lbInfoHistoryMore.addGestureRecognizer(tapShowHistory)
        
        btCreateOrder = UIButton()
        btCreateOrder.frame = CGRect(x: tfCMND.frame.origin.x, y: lbInfoHistoryMore.frame.origin.y + lbInfoHistoryMore.frame.size.height + Common.Size(s:20), width: tfCMND.frame.size.width, height: 0)
        btCreateOrder.backgroundColor = UIColor(netHex:0xEF4A40)
        btCreateOrder.setTitle("Tạo phiếu mua hàng", for: .normal)
       // btCreateOrder.addTarget(self, action: #selector(actionCreateOrder), for: .touchUpInside)
        btCreateOrder.addTarget(self, action: #selector(checkCallLogCIC), for: .touchUpInside)
        btCreateOrder.layer.borderWidth = 0.5
        btCreateOrder.layer.borderColor = UIColor.white.cgColor
        btCreateOrder.layer.cornerRadius = 3
        viewInfoInstallment.addSubview(btCreateOrder)
        btCreateOrder.clipsToBounds = true
        
        lbUpdate = UILabel(frame: CGRect(x: tfCMND.frame.origin.x, y: btCreateOrder.frame.origin.y + btCreateOrder.frame.size.height + Common.Size(s:20), width: tfCMND.frame.size.width, height: Common.Size(s: 0)))
        lbUpdate.textAlignment = .center
        lbUpdate.textColor = UIColor(netHex:0x04AB6E)
        lbUpdate.layer.cornerRadius = 5
        lbUpdate.layer.borderColor = UIColor(netHex:0x04AB6E).cgColor
        lbUpdate.layer.borderWidth = 0.5
        lbUpdate.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        lbUpdate.text = "Cập nhật"
        lbUpdate.numberOfLines = 1
        viewInfoInstallment.addSubview(lbUpdate)
        
        let tapUpdate = UITapGestureRecognizer(target: self, action: #selector(FFriendViewController.actionUpdate))
        lbUpdate.isUserInteractionEnabled = true
        lbUpdate.addGestureRecognizer(tapUpdate)
        
        //
        viewInfoInstallment.frame.size.height = lbUpdate.frame.size.height + lbUpdate.frame.origin.y + Common.Size(s:10)
    
        self.webView = WKWebView(frame: CGRect(x: 0 , y: self.viewInfoInstallment.frame.size.height + self.viewInfoInstallment.frame.origin.y + Common.Size(s: 5) , width: self.view.frame.size.width , height:  Common.Size(s: 500)))
        self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.webView.frame.origin.y + self.webView.frame.size.height + Common.Size(s: 100))
        MPOSAPIManager.mpos_FRT_SP_Mirae_noteforsale(type:"1") { [weak self](result, err) in
            guard let self = self else {return}
              
              if(result.count > 0){
                  self.webView.loadHTMLString(Common.shared.headerString + result, baseURL: nil)
                  self.webView.backgroundColor = .white
                self.scrollView.addSubview(self.webView)
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.webView.frame.origin.y + self.webView.frame.size.height + Common.Size(s: 100))
              }
          }
        
        
        self.hideKeyboardWhenTappedAround()
        
        
        if(CMND != "") {
            self.tfCMND.text = self.CMND
            checkCMND(cmnd: self.CMND)
        }
    }
    @objc func actionBack() {
        tfCMND.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)
    }
    @objc func actionScan(){
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { code in
            if(code != ""){
                self.scanQRCode(code:code)
            }
        }
        self.present(viewController, animated: false, completion: nil)
    }
    @objc func actionAdd() {
        let title = "THÔNG BÁO"
        let message = "Vui lòng chọn loại khách hàng cần tạo"
        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            print("Completed")
        }
        let buttonOne = CancelButton(title: "KH trả góp") {
            let newViewController =  CustomerInstallmentViewController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        let buttonTwo = CancelButton(title: "KH trả thẳng") {
            let newViewController =  CustomerPayDirectlyViewController()
            newViewController.cmnd = ""
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        let buttonThree = CancelButton(title: "KH Credit") {

            //MOI
            let popup1 = PopupDialog(title: "THÔNG BÁO", message: "Vui lòng chọn hình thức mở thẻ của KH", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne1 = CancelButton(title: "Credit có thẻ") {
                let newViewController =  CustomerCreditViewController()
                newViewController.cmnd = ""
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
            popup1.addButtons([buttonOne1])
            self.present(popup1, animated: true, completion: nil)
        }
        popup.addButtons([buttonOne,buttonTwo,buttonThree])
        self.present(popup, animated: true, completion: nil)

    }
    @objc func tapShowCallogTT(){
        let idCallLog = tfCallLogTT.text!
        if(idCallLog != "" && idCallLog != "0"){
             let urlCL = Config.manager.URL_GATEWAY! + "/mpos-cloud-callogoutside/Requests/Details/"
            guard let url = URL(string: "\(urlCL)\(idCallLog)") else {
                return
            }
            
            let webView = FFriendWebViewController()
            webView.url = url
            self.navigationController?.pushViewController(webView, animated: true)
        }
    }
    @objc func tapShowCallogUQTN(){
        let idCallLog = tfCallLogUQTN.text!
        if(idCallLog != "" && idCallLog != "0"){
           let urlCL = Config.manager.URL_GATEWAY! + "/mpos-cloud-callogoutside/Requests/Details/"
            guard let url = URL(string: "\(urlCL)\(idCallLog)") else {
                return
            }
            
            let webView = FFriendWebViewController()
            webView.url = url
            self.navigationController?.pushViewController(webView, animated: true)
        }
        
    }
    @objc func tapShowHistory(){
        if(self.ocfdFFriend != nil && self.tfCMND.text!.count > 0){
            let newViewController = SOHistoryFFriendViewController()
            newViewController.ocfdFFriend = self.ocfdFFriend
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }
   
    
    @objc func autoLoadCMND(notification:Notification) -> Void {
        let dict = notification.object as! NSDictionary
        
        if let cmnd = dict["CMND"] as? String{
            self.tfCMND.text = cmnd
//            checkCMND(cmnd: cmnd)
        }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField == tfCMND){
            let cmnd = textField.text!
            self.FtelCustomer = nil
            if(cmnd.count > 0){
                checkCMND(cmnd: cmnd)
            }else{
                self.tfName.text = ""
                self.tfPhone.text = ""
                self.tfCompany.text = ""
                self.tfType.text = ""
                self.tfUnusedAmount.text = ""
                self.tfUsedAmount.text = ""
                self.tfStatus.text = ""
                self.tfCallLogTT.text = ""
                self.tfCallLogUQTN.text = ""
                self.lbTextStatusCallLog.text = ""
                self.lbUpdate.frame.size.height = 0
                self.btCreateOrder.frame.origin.y = self.lbUpdate.frame.size.height + self.lbUpdate.frame.origin.y
                self.btCreateOrder.frame.size.height = 0
                self.viewInfoInstallment.frame.size.height =  self.btCreateOrder.frame.size.height +  self.btCreateOrder.frame.origin.y + Common.Size(s:20)
                   self.webView.frame.origin.y = self.viewInfoInstallment.frame.size.height + self.viewInfoInstallment.frame.origin.y + Common.Size(s: 5)
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.webView.frame.origin.y + self.webView.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                
            }
        }
    }
    func checkCMND(cmnd:String){
        Cache.listIDSaoKeLuongFFriend = ""
        Cache.CRD_SaoKeLuong1 = ""
        Cache.CRD_SaoKeLuong2 = ""
        Cache.CRD_SaoKeLuong3 = ""
        Cache.listVoucherNoPriceFF = []
        if (cmnd != ""){
            if (cmnd.count < 9 || cmnd.count > 12){
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập đúng số cmnd khách hàng", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
            // check diem liet frt cmnd
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra thông tin KH..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            
            MPOSAPIManager.sp_mpos_Scoring_CheckDiemLietFRT_ByCMND(CMND:cmnd) {[weak self] (results, err) in
                guard let self = self else {return}
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        //
                        let title = "THÔNG BÁO"
                        let popup = PopupDialog(title: title, message: "Bạn muốn chọn loại đơn hàng nào ?", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        }
                        let buttonOne = CancelButton(title: "Trả góp") {
                            if(results[0].FlagTraGop != ""){
                                let alert = UIAlertController(title: "Thông báo", message: results[0].FlagTraGop, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                                    
                                })
                                self.present(alert, animated: true)
                                return
                            }
                            //            NotificationCenter.default.removeObserver(self, name: Notification.Name("AutoLoadCMND"), object: nil)
                            self.hinhthucmua = "1"
                            if(self.FtelCustomer != nil){
                                self.isQrCode = "1"
                            }
                            let newViewController = LoadingViewController()
                            newViewController.content = "Đang kiểm tra thông tin KH..."
                            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                            self.navigationController?.present(newViewController, animated: true, completion: nil)
                            let nc = NotificationCenter.default
                            MPOSAPIManager.getOCRDFFriend(cmnd: cmnd,HinhThucMua:"1",MaShop:Cache.user!.ShopCode,isQrCode:"\(self.isQrCode)", handler: { [weak self](results, err) in
                                guard let self = self else {return}
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                let when = DispatchTime.now() + 0.5
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    if(results.count > 0){
                                        if(results.count == 1){
                                            let data = results[0]
                                            self.ocfdFFriend = data
                                            self.tfName.text = data.CardName
                                            self.tfPhone.text = data.SDT
                                            self.tfCompany.text = data.Name
                                            self.tfType.text = data.TenHinhThucMuaHang
                                            self.tfUnusedAmount.text = Common.convertCurrencyFloatV2(value: data.HanMucSoTien)
                                            self.tfUsedAmount.text = Common.convertCurrencyFloatV2(value: data.HanMucConLai)
                                            self.tfStatus.text = data.TTHanMuc
                                            self.tfCallLogTT.text = data.IDCLDuyetTK
                                            self.tfCallLogUQTN.text = data.IDCLDuyetCT
                                            self.lbTextStatusCallLog.text = data.TTCalllogChungTu
                                            
                                            self.btCreateOrder.frame.size.height = Common.Size(s: 40) * 1.2
                                            self.lbUpdate.frame.size.height = Common.Size(s: 40)
                                            self.lbUpdate.frame.origin.y = self.btCreateOrder.frame.size.height + self.btCreateOrder.frame.origin.y + Common.Size(s: 10)
                                            self.viewInfoInstallment.frame.size.height =  self.lbUpdate.frame.size.height +  self.lbUpdate.frame.origin.y + Common.Size(s:20)
                                            self.webView.frame.origin.y = self.viewInfoInstallment.frame.size.height + self.viewInfoInstallment.frame.origin.y + Common.Size(s: 5)
                                            
                                            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.webView.frame.origin.y + self.webView.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                                            
                                            if(data.Message_InfoScoring != ""){
                                                let title = "Thông báo"
                                                let popup = PopupDialog(title: title, message: data.Message_InfoScoring, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                    print("Completed")
                                                }
                                                let buttonOne = CancelButton(title: "OK") {
                                                    
                                                }
                                                popup.addButtons([buttonOne])
                                                self.present(popup, animated: true, completion: nil)
                                            }
                                            if(data.Knox.count > 0){
                                                let title = "Thông báo"
                                                let popup = PopupDialog(title: title, message: data.Knox, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                    print("Completed")
                                                }
                                                let buttonOne = CancelButton(title: "OK") {
                                                    
                                                }
                                                popup.addButtons([buttonOne])
                                                self.present(popup, animated: true, completion: nil)
                                            }
                                            if(data.NoteCredit.count > 0){
                                                let title = "THÔNG BÁO"
                                                let message = "\(data.NoteCredit)"
                                                let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                }
                                                let buttonOne = DefaultButton(title: "Đóng") {
                                                    
                                                }
                                                let buttonTow = DefaultButton(title: "Tiếp tục") {
                                             
                                                    if(data.CMND != "" && data.CardName != "" && data.SDT != ""){
                                                        if(data.OtherTime != ""){
                                                            //NOT GOLIVE
                                                            let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                            }
                                                            let buttonOne = CancelButton(title: "OK") {
                                                       
                                                                let newViewController = CustomerCreditNoCardViewControllerV3()
                                                                newViewController.ocfdFFriend = data
                                                                self.navigationController?.pushViewController(newViewController, animated: true)
                                                            }
                                                            popup.addButtons([buttonOne])
                                                            self.present(popup, animated: true, completion: nil)
                                                        }else if(data.TimeFrom != "" &&  data.TimeTo != ""){
                                                            //NOT GOLIVE
                                                            let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                            }
                                                            let buttonOne = CancelButton(title: "OK") {
                                                                //let newViewController = CustomerCreditNoCardViewControllerV2()
                                                                let newViewController = CustomerCreditNoCardViewControllerV3()
                                                                newViewController.ocfdFFriend = data
                                                                self.navigationController?.pushViewController(newViewController, animated: true)
                                                            }
                                                            popup.addButtons([buttonOne])
                                                            self.present(popup, animated: true, completion: nil)
                                                        }else{
                                                            let title = "THÔNG BÁO"
                                                            let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                                                            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                            }
                                                            let buttonOne = DefaultButton(title: "OK") {
                                                                //NOT GOLIVE
                                                                let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                                }
                                                                let buttonOne = CancelButton(title: "OK") {
                                                                    //let newViewController = CustomerCreditNoCardViewControllerV2()
                                                                    let newViewController = CustomerCreditNoCardViewControllerV3()
                                                                    newViewController.ocfdFFriend = data
                                                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                                                }
                                                                popup.addButtons([buttonOne])
                                                                self.present(popup, animated: true, completion: nil)
                                                            }
                                                            popup.addButtons([buttonOne])
                                                            self.present(popup, animated: true, completion: nil)
                                                        }
                                                    }else{
                                                        let title = "THÔNG BÁO"
                                                        let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                                                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                        }
                                                        let buttonOne = DefaultButton(title: "OK") {
                                                            //NOT GOLIVE
                                                            let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                            }
                                                            let buttonOne = CancelButton(title: "OK") {
                                                                //let newViewController = CustomerCreditNoCardViewControllerV2()
                                                                let newViewController = CustomerCreditNoCardViewControllerV3()
                                                                newViewController.ocfdFFriend = data
                                                                self.navigationController?.pushViewController(newViewController, animated: true)
                                                            }
                                                            popup.addButtons([buttonOne])
                                                            self.present(popup, animated: true, completion: nil)
                                                        }
                                                        popup.addButtons([buttonOne])
                                                        self.present(popup, animated: true, completion: nil)
                                                    }
                                                }
                                                if(data.Is_AllowCreateCust){
                                                    popup.addButtons([buttonOne,buttonTow])
                                                }else{
                                                    popup.addButtons([buttonOne])
                                                }
                                                
                                                self.present(popup, animated: true, completion: nil)
                                            }
                                        }else{
                                            self.tfName.text = ""
                                            self.tfPhone.text = ""
                                            self.tfCompany.text = ""
                                            self.tfType.text = ""
                                            self.tfUnusedAmount.text = ""
                                            self.tfUsedAmount.text = ""
                                            self.tfStatus.text = ""
                                            self.tfCallLogTT.text = ""
                                            self.tfCallLogUQTN.text = ""
                                            self.lbTextStatusCallLog.text = ""
                                            
                                            self.btCreateOrder.frame.size.height = 0
                                            self.lbUpdate.frame.size.height = 0
                                            self.lbUpdate.frame.origin.y = self.btCreateOrder.frame.size.height + self.btCreateOrder.frame.origin.y
                                            
                                            self.viewInfoInstallment.frame.size.height =  self.lbUpdate.frame.size.height +  self.lbUpdate.frame.origin.y + Common.Size(s:20)
                                            self.webView.frame.origin.y = self.viewInfoInstallment.frame.size.height + self.viewInfoInstallment.frame.origin.y + Common.Size(s: 5)
                                            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.webView.frame.origin.y + self.webView.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                                            
                                            let dialog = SelectionDialog(title: "Chọn doanh nghiệp", closeButtonTitle: "Huỷ")
                                            for data in results {
                                                dialog.addItem(item: "\(data.TenCongTy)", didTapHandler: { () in
                                                    print("Item didTap! \(data.TenCongTy)")
                                                    self.ocfdFFriend = data
                                                    self.tfName.text = data.CardName
                                                    self.tfPhone.text = data.SDT
                                                    self.tfCompany.text = data.Name
                                                    self.tfType.text = data.TenHinhThucMuaHang
                                                    self.tfUnusedAmount.text = Common.convertCurrencyFloatV2(value: data.HanMucSoTien)
                                                    self.tfUsedAmount.text = Common.convertCurrencyFloatV2(value: data.HanMucConLai)
                                                    self.tfStatus.text = data.TTHanMuc
                                                    self.tfCallLogTT.text = data.IDCLDuyetTK
                                                    self.tfCallLogUQTN.text = data.IDCLDuyetCT
                                                    self.lbTextStatusCallLog.text = data.TTCalllogChungTu
                                                    
                                                    self.btCreateOrder.frame.size.height = Common.Size(s: 40) * 1.2
                                                    self.lbUpdate.frame.size.height = Common.Size(s: 40)
                                                    self.lbUpdate.frame.origin.y = self.btCreateOrder.frame.size.height + self.btCreateOrder.frame.origin.y + Common.Size(s: 10)
                                                    if(data.FlagEdit == 0){
                                                        self.lbUpdate.frame.size.height = 0
                                                    }
                                                    self.viewInfoInstallment.frame.size.height =  self.lbUpdate.frame.size.height +  self.lbUpdate.frame.origin.y + Common.Size(s:20)
                                                    self.webView.frame.origin.y = self.viewInfoInstallment.frame.size.height + self.viewInfoInstallment.frame.origin.y + Common.Size(s: 5)
                                                    self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.webView.frame.origin.y + self.webView.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                                                    
                                                    dialog.close()
                                                    
                                                    if(data.Knox.count > 0){
                                                        let title = "Thông báo"
                                                        let popup = PopupDialog(title: title, message: data.Knox, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                            print("Completed")
                                                        }
                                                        let buttonOne = CancelButton(title: "OK") {
                                                            
                                                        }
                                                        popup.addButtons([buttonOne])
                                                        self.present(popup, animated: true, completion: nil)
                                                    }
                                                    if(data.NoteCredit.count > 0){
                                                        let title = "THÔNG BÁO"
                                                        let message = "\(data.NoteCredit)"
                                                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                        }
                                                        let buttonOne = DefaultButton(title: "Đóng") {
                                                            
                                                        }
                                                        let buttonTow = DefaultButton(title: "Tiếp tục") {
                                                            //                                            let nc = NotificationCenter.default
                                                            //                                            nc.addObserver(self, selector: #selector(self.autoLoadCMND), name: Notification.Name("AutoLoadCMND"), object: nil)
                                                            if(data.CMND != "" && data.CardName != "" && data.SDT != ""){
                                                                if(data.OtherTime != ""){
                                                                    //NOT GOLIVE
                                                                    let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                                    }
                                                                    let buttonOne = CancelButton(title: "OK") {
                                                                        //let newViewController = CustomerCreditNoCardViewControllerV2()
                                                                        let newViewController = CustomerCreditNoCardViewControllerV3()
                                                                        newViewController.ocfdFFriend = data
                                                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                                                    }
                                                                    popup.addButtons([buttonOne])
                                                                    self.present(popup, animated: true, completion: nil)
                                                                }else if(data.TimeFrom != "" &&  data.TimeTo != ""){
                                                                    //NOT GOLIVE
                                                                    let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                                    }
                                                                    let buttonOne = CancelButton(title: "OK") {
                                                                        //let newViewController = CustomerCreditNoCardViewControllerV2()
                                                                        let newViewController = CustomerCreditNoCardViewControllerV3()
                                                                        newViewController.ocfdFFriend = data
                                                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                                                    }
                                                                    popup.addButtons([buttonOne])
                                                                    self.present(popup, animated: true, completion: nil)
                                                                }else{
                                                                    let title = "THÔNG BÁO"
                                                                    let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                                                                    let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                                    }
                                                                    let buttonOne = DefaultButton(title: "OK") {
                                                                        //NOT GOLIVE
                                                                        let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                                        }
                                                                        let buttonOne = CancelButton(title: "OK") {
                                                                            //let newViewController = CustomerCreditNoCardViewControllerV2()
                                                                            let newViewController = CustomerCreditNoCardViewControllerV3()
                                                                            newViewController.ocfdFFriend = data
                                                                            self.navigationController?.pushViewController(newViewController, animated: true)
                                                                        }
                                                                        popup.addButtons([buttonOne])
                                                                        self.present(popup, animated: true, completion: nil)
                                                                    }
                                                                    popup.addButtons([buttonOne])
                                                                    self.present(popup, animated: true, completion: nil)
                                                                }
                                                            }else{
                                                                let title = "THÔNG BÁO"
                                                                let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                                                                let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                                }
                                                                let buttonOne = DefaultButton(title: "OK") {
                                                                    //NOT GOLIVE
                                                                    let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                                    }
                                                                    let buttonOne = CancelButton(title: "OK") {
                                                                        //let newViewController = CustomerCreditNoCardViewControllerV2()
                                                                        let newViewController = CustomerCreditNoCardViewControllerV3()
                                                                        newViewController.ocfdFFriend = data
                                                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                                                    }
                                                                    popup.addButtons([buttonOne])
                                                                    self.present(popup, animated: true, completion: nil)
                                                                }
                                                                popup.addButtons([buttonOne])
                                                                self.present(popup, animated: true, completion: nil)
                                                            }
                                                        }
                                                        if(data.Is_AllowCreateCust){
                                                            popup.addButtons([buttonOne,buttonTow])
                                                        }else{
                                                            popup.addButtons([buttonOne])
                                                        }
                                                        
                                                        self.present(popup, animated: true, completion: nil)
                                                    }
                                                })
                                            }
                                            dialog.show()
                                        }
                                        
                                    }else{
                                        if(err.count > 0){
                                            self.tfName.text = ""
                                            self.tfPhone.text = ""
                                            self.tfCompany.text = ""
                                            self.tfType.text = ""
                                            self.tfUnusedAmount.text = ""
                                            self.tfUsedAmount.text = ""
                                            self.tfStatus.text = ""
                                            self.tfCallLogTT.text = ""
                                            self.tfCallLogUQTN.text = ""
                                            self.lbTextStatusCallLog.text = ""
                                            self.btCreateOrder.frame.size.height = 0
                                            self.lbUpdate.frame.size.height = 0
                                            self.lbUpdate.frame.origin.y = self.btCreateOrder.frame.size.height + self.btCreateOrder.frame.origin.y
                                            
                                            self.viewInfoInstallment.frame.size.height =  self.lbUpdate.frame.size.height +  self.lbUpdate.frame.origin.y + Common.Size(s:20)
                                            self.webView.frame.origin.y = self.viewInfoInstallment.frame.size.height + self.viewInfoInstallment.frame.origin.y + Common.Size(s: 5)
                                            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.webView.frame.origin.y + self.webView.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                                            
                                            // Prepare the popup
                                            let title = "THÔNG BÁO"
                                            // Create the dialog
                                            let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                print("Completed")
                                            }
                                            // Create first button
                                            let buttoTwo = CancelButton(title: "OK") {
                                                
                                            }
                                            // Add buttons to dialog
                                            popup.addButtons([buttoTwo])
                                            
                                            // Present dialog
                                            self.present(popup, animated: true, completion: nil)
                                        }else{
                                            self.tfName.text = ""
                                            self.tfPhone.text = ""
                                            self.tfCompany.text = ""
                                            self.tfType.text = ""
                                            self.tfUnusedAmount.text = ""
                                            self.tfUsedAmount.text = ""
                                            self.tfStatus.text = ""
                                            self.tfCallLogTT.text = ""
                                            self.tfCallLogUQTN.text = ""
                                            self.lbTextStatusCallLog.text = ""
                                            self.btCreateOrder.frame.size.height = 0
                                            self.lbUpdate.frame.size.height = 0
                                            self.lbUpdate.frame.origin.y = self.btCreateOrder.frame.size.height + self.btCreateOrder.frame.origin.y
                                            
                                            self.viewInfoInstallment.frame.size.height =  self.lbUpdate.frame.size.height +  self.lbUpdate.frame.origin.y + Common.Size(s:20)
                                            self.webView.frame.origin.y = self.viewInfoInstallment.frame.size.height + self.viewInfoInstallment.frame.origin.y + Common.Size(s: 5)
                                            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.webView.frame.origin.y + self.webView.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                                            

                                            let cmnd = self.tfCMND.text
                                            self.newCustomer(cmnd: cmnd!,hinhthucmua:"1")
                                        }
                                        
                                    }
                                    
                                    
                                }
                            })
                            
                        }
                        let buttonTwo = CancelButton(title: "Trả thẳng") {
                            if(results[0].TraThang != ""){
                                let alert = UIAlertController(title: "Thông báo", message: results[0].FlagTraGop, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                                    
                                })
                                self.present(alert, animated: true)
                                return
                            }
                 
                            self.hinhthucmua = "3"
                            if(self.FtelCustomer != nil){
                                self.isQrCode = "1"
                            }
                            let newViewController = LoadingViewController()
                            newViewController.content = "Đang kiểm tra thông tin KH..."
                            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                            self.navigationController?.present(newViewController, animated: true, completion: nil)
                            let nc = NotificationCenter.default
                            MPOSAPIManager.getOCRDFFriend(cmnd: cmnd,HinhThucMua:"3",MaShop:Cache.user!.ShopCode,isQrCode:"\(self.isQrCode)", handler: { [weak self](results, err) in
                                guard let self = self else {return}
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                let when = DispatchTime.now() + 0.5
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    if(results.count > 0){
                                        if(results.count == 1){
                                            let data = results[0]
                                            self.ocfdFFriend = data
                                            self.tfName.text = data.CardName
                                            self.tfPhone.text = data.SDT
                                            self.tfCompany.text = data.Name
                                            self.tfType.text = data.TenHinhThucMuaHang
                                            self.tfUnusedAmount.text = Common.convertCurrencyFloatV2(value: data.HanMucSoTien)
                                            self.tfUsedAmount.text = Common.convertCurrencyFloatV2(value: data.HanMucConLai)
                                            self.tfStatus.text = data.TTHanMuc
                                            self.tfCallLogTT.text = data.IDCLDuyetTK
                                            self.tfCallLogUQTN.text = data.IDCLDuyetCT
                                            self.lbTextStatusCallLog.text = data.TTCalllogChungTu
                                            
                                            self.btCreateOrder.frame.size.height = Common.Size(s: 40) * 1.2
                                            self.lbUpdate.frame.size.height = Common.Size(s: 40)
                                            self.lbUpdate.frame.origin.y = self.btCreateOrder.frame.size.height + self.btCreateOrder.frame.origin.y + Common.Size(s: 10)
                                            self.viewInfoInstallment.frame.size.height =  self.lbUpdate.frame.size.height +  self.lbUpdate.frame.origin.y + Common.Size(s:20)
                          self.webView.frame.origin.y = self.viewInfoInstallment.frame.size.height + self.viewInfoInstallment.frame.origin.y + Common.Size(s: 5)
                                                           self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.webView.frame.origin.y + self.webView.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                                            
                                            if(data.Message_InfoScoring != ""){
                                                let title = "Thông báo"
                                                let popup = PopupDialog(title: title, message: data.Message_InfoScoring, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                    print("Completed")
                                                }
                                                let buttonOne = CancelButton(title: "OK") {
                                                    
                                                }
                                                popup.addButtons([buttonOne])
                                                self.present(popup, animated: true, completion: nil)
                                            }
                                            if(data.Knox.count > 0){
                                                let title = "Thông báo"
                                                let popup = PopupDialog(title: title, message: data.Knox, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                    print("Completed")
                                                }
                                                let buttonOne = CancelButton(title: "OK") {
                                                    
                                                }
                                                popup.addButtons([buttonOne])
                                                self.present(popup, animated: true, completion: nil)
                                            }
                                            if(data.NoteCredit.count > 0){
                                                let title = "THÔNG BÁO"
                                                let message = "\(data.NoteCredit)"
                                                let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                }
                                                let buttonOne = DefaultButton(title: "Đóng") {
                                                    
                                                }
                                                let buttonTow = DefaultButton(title: "Tiếp tục") {
                                                    //                                    let nc = NotificationCenter.default
                                                    //                                    nc.addObserver(self, selector: #selector(self.autoLoadCMND), name: Notification.Name("AutoLoadCMND"), object: nil)
                                                    if(data.CMND != "" && data.CardName != "" && data.SDT != ""){
                                                        if(data.OtherTime != ""){
                                                            //NOT GOLIVE
                                                            let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                            }
                                                            let buttonOne = CancelButton(title: "OK") {
                                                                //let newViewController = CustomerCreditNoCardViewControllerV2()
                                                                let newViewController = CustomerCreditNoCardViewControllerV3()
                                                                newViewController.ocfdFFriend = data
                                                                self.navigationController?.pushViewController(newViewController, animated: true)
                                                            }
                                                            popup.addButtons([buttonOne])
                                                            self.present(popup, animated: true, completion: nil)
                                                        }else if(data.TimeFrom != "" &&  data.TimeTo != ""){
                                                            //NOT GOLIVE
                                                            let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                            }
                                                            let buttonOne = CancelButton(title: "OK") {
                                                                //let newViewController = CustomerCreditNoCardViewControllerV2()
                                                                let newViewController = CustomerCreditNoCardViewControllerV3()
                                                                newViewController.ocfdFFriend = data
                                                                self.navigationController?.pushViewController(newViewController, animated: true)
                                                            }
                                                            popup.addButtons([buttonOne])
                                                            self.present(popup, animated: true, completion: nil)
                                                        }else{
                                                            let title = "THÔNG BÁO"
                                                            let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                                                            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                            }
                                                            let buttonOne = DefaultButton(title: "OK") {
                                                                //NOT GOLIVE
                                                                let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                                }
                                                                let buttonOne = CancelButton(title: "OK") {
                                                                    //let newViewController = CustomerCreditNoCardViewControllerV2()
                                                                    let newViewController = CustomerCreditNoCardViewControllerV3()
                                                                    newViewController.ocfdFFriend = data
                                                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                                                }
                                                                popup.addButtons([buttonOne])
                                                                self.present(popup, animated: true, completion: nil)
                                                            }
                                                            popup.addButtons([buttonOne])
                                                            self.present(popup, animated: true, completion: nil)
                                                        }
                                                    }else{
                                                        let title = "THÔNG BÁO"
                                                        let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                                                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                        }
                                                        let buttonOne = DefaultButton(title: "OK") {
                                                            //NOT GOLIVE
                                                            let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                            }
                                                            let buttonOne = CancelButton(title: "OK") {
                                                                //let newViewController = CustomerCreditNoCardViewControllerV2()
                                                                let newViewController = CustomerCreditNoCardViewControllerV3()
                                                                newViewController.ocfdFFriend = data
                                                                self.navigationController?.pushViewController(newViewController, animated: true)
                                                            }
                                                            popup.addButtons([buttonOne])
                                                            self.present(popup, animated: true, completion: nil)
                                                        }
                                                        popup.addButtons([buttonOne])
                                                        self.present(popup, animated: true, completion: nil)
                                                    }
                                                }
                                                if(data.Is_AllowCreateCust){
                                                    popup.addButtons([buttonOne,buttonTow])
                                                }else{
                                                    popup.addButtons([buttonOne])
                                                }
                                                
                                                self.present(popup, animated: true, completion: nil)
                                            }
                                        }else{
                                            self.tfName.text = ""
                                            self.tfPhone.text = ""
                                            self.tfCompany.text = ""
                                            self.tfType.text = ""
                                            self.tfUnusedAmount.text = ""
                                            self.tfUsedAmount.text = ""
                                            self.tfStatus.text = ""
                                            self.tfCallLogTT.text = ""
                                            self.tfCallLogUQTN.text = ""
                                            self.lbTextStatusCallLog.text = ""
                                            
                                            self.btCreateOrder.frame.size.height = 0
                                            self.lbUpdate.frame.size.height = 0
                                            self.lbUpdate.frame.origin.y = self.btCreateOrder.frame.size.height + self.btCreateOrder.frame.origin.y
                                            
                                            self.viewInfoInstallment.frame.size.height =  self.lbUpdate.frame.size.height +  self.lbUpdate.frame.origin.y + Common.Size(s:20)
                                            self.webView.frame.origin.y = self.viewInfoInstallment.frame.size.height + self.viewInfoInstallment.frame.origin.y + Common.Size(s: 5)
                                            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.webView.frame.origin.y + self.webView.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                                            
                                            let dialog = SelectionDialog(title: "Chọn doanh nghiệp", closeButtonTitle: "Huỷ")
                                            for data in results {
                                                dialog.addItem(item: "\(data.TenCongTy)", didTapHandler: { () in
                                                    print("Item didTap! \(data.TenCongTy)")
                                                    self.ocfdFFriend = data
                                                    self.tfName.text = data.CardName
                                                    self.tfPhone.text = data.SDT
                                                    self.tfCompany.text = data.Name
                                                    self.tfType.text = data.TenHinhThucMuaHang
                                                    self.tfUnusedAmount.text = Common.convertCurrencyFloatV2(value: data.HanMucSoTien)
                                                    self.tfUsedAmount.text = Common.convertCurrencyFloatV2(value: data.HanMucConLai)
                                                    self.tfStatus.text = data.TTHanMuc
                                                    self.tfCallLogTT.text = data.IDCLDuyetTK
                                                    self.tfCallLogUQTN.text = data.IDCLDuyetCT
                                                    self.lbTextStatusCallLog.text = data.TTCalllogChungTu
                                                    
                                                    self.btCreateOrder.frame.size.height = Common.Size(s: 40) * 1.2
                                                    self.lbUpdate.frame.size.height = Common.Size(s: 40)
                                                    self.lbUpdate.frame.origin.y = self.btCreateOrder.frame.size.height + self.btCreateOrder.frame.origin.y + Common.Size(s: 10)
                                                    if(data.FlagEdit == 0){
                                                        self.lbUpdate.frame.size.height = 0
                                                    }
                                                    self.viewInfoInstallment.frame.size.height =  self.lbUpdate.frame.size.height +  self.lbUpdate.frame.origin.y + Common.Size(s:20)
                                                    self.webView.frame.origin.y = self.viewInfoInstallment.frame.size.height + self.viewInfoInstallment.frame.origin.y + Common.Size(s: 5)
                                                    self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.webView.frame.origin.y + self.webView.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                                                    
                                                    dialog.close()
                                                    
                                                    if(data.Knox.count > 0){
                                                        let title = "Thông báo"
                                                        let popup = PopupDialog(title: title, message: data.Knox, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                            print("Completed")
                                                        }
                                                        let buttonOne = CancelButton(title: "OK") {
                                                            
                                                        }
                                                        popup.addButtons([buttonOne])
                                                        self.present(popup, animated: true, completion: nil)
                                                    }
                                                    if(data.NoteCredit.count > 0){
                                                        let title = "THÔNG BÁO"
                                                        let message = "\(data.NoteCredit)"
                                                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                        }
                                                        let buttonOne = DefaultButton(title: "Đóng") {
                                                            
                                                        }
                                                        let buttonTow = DefaultButton(title: "Tiếp tục") {
                                                            //                                            let nc = NotificationCenter.default
                                                            //                                            nc.addObserver(self, selector: #selector(self.autoLoadCMND), name: Notification.Name("AutoLoadCMND"), object: nil)
                                                            if(data.CMND != "" && data.CardName != "" && data.SDT != ""){
                                                                if(data.OtherTime != ""){
                                                                    //NOT GOLIVE
                                                                    let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                                    }
                                                                    let buttonOne = CancelButton(title: "OK") {
                                                                  
                                                                        let newViewController = CustomerCreditNoCardViewControllerV3()
                                                                        newViewController.ocfdFFriend = data
                                                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                                                    }
                                                                    popup.addButtons([buttonOne])
                                                                    self.present(popup, animated: true, completion: nil)
                                                                }else if(data.TimeFrom != "" &&  data.TimeTo != ""){
                                                                    //NOT GOLIVE
                                                                    let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                                    }
                                                                    let buttonOne = CancelButton(title: "OK") {
                                                                
                                                                        let newViewController = CustomerCreditNoCardViewControllerV3()
                                                                        newViewController.ocfdFFriend = data
                                                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                                                    }
                                                                    popup.addButtons([buttonOne])
                                                                    self.present(popup, animated: true, completion: nil)
                                                                }else{
                                                                    let title = "THÔNG BÁO"
                                                                    let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                                                                    let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                                    }
                                                                    let buttonOne = DefaultButton(title: "OK") {
                                                                        //NOT GOLIVE
                                                                        let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                                        }
                                                                        let buttonOne = CancelButton(title: "OK") {
                                                                    
                                                                            let newViewController = CustomerCreditNoCardViewControllerV3()
                                                                            newViewController.ocfdFFriend = data
                                                                            self.navigationController?.pushViewController(newViewController, animated: true)
                                                                        }
                                                                        popup.addButtons([buttonOne])
                                                                        self.present(popup, animated: true, completion: nil)
                                                                    }
                                                                    popup.addButtons([buttonOne])
                                                                    self.present(popup, animated: true, completion: nil)
                                                                }
                                                            }else{
                                                                let title = "THÔNG BÁO"
                                                                let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                                                                let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                                }
                                                                let buttonOne = DefaultButton(title: "OK") {
                                                                    //NOT GOLIVE
                                                                    let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                                    }
                                                                    let buttonOne = CancelButton(title: "OK") {
                                                                    
                                                                        let newViewController = CustomerCreditNoCardViewControllerV3()
                                                                        newViewController.ocfdFFriend = data
                                                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                                                    }
                                                                    popup.addButtons([buttonOne])
                                                                    self.present(popup, animated: true, completion: nil)
                                                                }
                                                                popup.addButtons([buttonOne])
                                                                self.present(popup, animated: true, completion: nil)
                                                            }
                                                        }
                                                        if(data.Is_AllowCreateCust){
                                                            popup.addButtons([buttonOne,buttonTow])
                                                        }else{
                                                            popup.addButtons([buttonOne])
                                                        }
                                                        
                                                        self.present(popup, animated: true, completion: nil)
                                                    }
                                                })
                                            }
                                            dialog.show()
                                        }
                                        
                                    }else{
                                        if(err.count > 0){
                                            self.tfName.text = ""
                                            self.tfPhone.text = ""
                                            self.tfCompany.text = ""
                                            self.tfType.text = ""
                                            self.tfUnusedAmount.text = ""
                                            self.tfUsedAmount.text = ""
                                            self.tfStatus.text = ""
                                            self.tfCallLogTT.text = ""
                                            self.tfCallLogUQTN.text = ""
                                            self.lbTextStatusCallLog.text = ""
                                            self.btCreateOrder.frame.size.height = 0
                                            self.lbUpdate.frame.size.height = 0
                                            self.lbUpdate.frame.origin.y = self.btCreateOrder.frame.size.height + self.btCreateOrder.frame.origin.y
                                            
                                            self.viewInfoInstallment.frame.size.height =  self.lbUpdate.frame.size.height +  self.lbUpdate.frame.origin.y + Common.Size(s:20)
               self.webView.frame.origin.y = self.viewInfoInstallment.frame.size.height + self.viewInfoInstallment.frame.origin.y + Common.Size(s: 5)
                                                           self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.webView.frame.origin.y + self.webView.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                                            
                                            // Prepare the popup
                                            let title = "THÔNG BÁO"
                                            // Create the dialog
                                            let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                print("Completed")
                                            }
                                            // Create first button
                                            let buttoTwo = CancelButton(title: "OK") {
                                                
                                            }
                                            // Add buttons to dialog
                                            popup.addButtons([buttoTwo])
                                            
                                            // Present dialog
                                            self.present(popup, animated: true, completion: nil)
                                        }else{
                                            self.tfName.text = ""
                                            self.tfPhone.text = ""
                                            self.tfCompany.text = ""
                                            self.tfType.text = ""
                                            self.tfUnusedAmount.text = ""
                                            self.tfUsedAmount.text = ""
                                            self.tfStatus.text = ""
                                            self.tfCallLogTT.text = ""
                                            self.tfCallLogUQTN.text = ""
                                            self.lbTextStatusCallLog.text = ""
                                            self.btCreateOrder.frame.size.height = 0
                                            self.lbUpdate.frame.size.height = 0
                                            self.lbUpdate.frame.origin.y = self.btCreateOrder.frame.size.height + self.btCreateOrder.frame.origin.y
                                            
                                            self.viewInfoInstallment.frame.size.height =  self.lbUpdate.frame.size.height +  self.lbUpdate.frame.origin.y + Common.Size(s:20)
                                            self.webView.frame.origin.y = self.viewInfoInstallment.frame.size.height + self.viewInfoInstallment.frame.origin.y + Common.Size(s: 5)
                                            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.webView.frame.origin.y + self.webView.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                                            
                                            let cmnd = self.tfCMND.text
                                            self.newCustomer(cmnd: cmnd!,hinhthucmua:"3")

                                        }
                                        
                                    }
                                    
                                    
                                }
                            })
                        }
                        popup.addButtons([buttonOne,buttonTwo])
                        self.present(popup, animated: true, completion: nil)
                        
                        
                        
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                }
            }

            

            
        }else{
            self.tfName.text = ""
            self.tfPhone.text = ""
            self.tfCompany.text = ""
            self.tfType.text = ""
            self.tfUnusedAmount.text = ""
            self.tfUsedAmount.text = ""
            self.tfStatus.text = ""
            self.tfCallLogTT.text = ""
            self.tfCallLogUQTN.text = ""
            self.lbTextStatusCallLog.text = ""
            self.btCreateOrder.frame.size.height = 0
            self.lbUpdate.frame.size.height = 0
            self.lbUpdate.frame.origin.y = self.btCreateOrder.frame.size.height + self.btCreateOrder.frame.origin.y
            self.viewInfoInstallment.frame.size.height =  self.lbUpdate.frame.size.height +  self.lbUpdate.frame.origin.y + Common.Size(s:20)
            self.webView.frame.origin.y = self.viewInfoInstallment.frame.size.height + self.viewInfoInstallment.frame.origin.y + Common.Size(s: 5)
            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.webView.frame.origin.y + self.webView.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        }
    }
    @objc func actionUpdate(){
        if (ocfdFFriend != nil){
          
            if(self.hinhthucmua == "1"){
                if(self.ocfdFFriend!.IsKHTT == 1){
                    
           
                    
                    let title = "THÔNG BÁO"
                    let popup = PopupDialog(title: title, message: "Doanh nghiệp không được cập nhật thông tin", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    }
                    let buttonOne = CancelButton(title: "OK") {
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }else{
                    let newViewController = UpdateCustomerInstallmentViewController()
                    newViewController.ocfdFFriend = self.ocfdFFriend
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
      
            }else{
                if(self.ocfdFFriend!.IsKHTT == 1){
                    

                    
                    let title = "THÔNG BÁO"
                    let popup = PopupDialog(title: title, message: "Doanh nghiệp không được cập nhật thông tin", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    }
                    let buttonOne = CancelButton(title: "OK") {
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }else{
                    let newViewController = UpdateCustomerPayDirectlyViewController()
                    newViewController.ocfdFFriend = self.ocfdFFriend
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
                
            }
            


        }
    }
    @objc func actionCreateOrder(){
        if (self.ocfdFFriend != nil){
            if(self.ocfdFFriend!.Message.count > 0){
                let title = "THÔNG BÁO"
                let popup = PopupDialog(title: title, message: self.ocfdFFriend!.Message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                }
                let buttonOne = CancelButton(title: "OK") {
                    
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
                return
            }
            if (self.ocfdFFriend!.Message_TG.count > 0){
                if(self.ocfdFFriend?.LoaiKH == 0 || self.ocfdFFriend?.LoaiKH == 1){
                    if (self.ocfdFFriend!.HanMucConLai <= 0){
//                        let nc = NotificationCenter.default
//                        nc.addObserver(self, selector: #selector(self.autoLoadCMND), name: Notification.Name("AutoLoadCMND"), object: nil)
                        let title = "THÔNG BÁO"
                        let message = "Vui lòng chọn loại đơn hàng muốn tạo?"
                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        }
                        let buttonTwo = CancelButton(title: "Trả thẳng") {
                            
                            if(self.ocfdFFriend!.Message_TT.count > 0){
                                let title = "THÔNG BÁO"
                                let popup = PopupDialog(title: title, message: self.ocfdFFriend!.Message_TT, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                                return
                            }
                            
                            let newViewController = InputEcomNumFFViewController()
                            
                            newViewController.ocfdFFriend = self.ocfdFFriend
                            newViewController.typeOrder = 0
                            Cache.ocfdFFriend = self.ocfdFFriend
                            Cache.typeOrder = "10"
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }
                        let buttonThree = CancelButton(title: "Trả góp credit") {
                            //MOI
                            //
                            let popup1 = PopupDialog(title: "THÔNG BÁO", message: "Vui lòng chọn loại KH Credit muốn tạo", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne1 = CancelButton(title: "Credit có thẻ") {
                                if(self.ocfdFFriend!.CMND != "" && self.ocfdFFriend!.CardName != "" && self.ocfdFFriend!.SDT != "" && self.ocfdFFriend!.CreditCard != "" && self.ocfdFFriend!.MaCongTy != ""){

                                     let newViewController = InputEcomNumFFViewController()
                            
                                    newViewController.ocfdFFriend = self.ocfdFFriend
                                    Cache.ocfdFFriend = self.ocfdFFriend
                                    Cache.typeOrder = "20"
                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                }else{
                                    let title = "THÔNG BÁO"
                                    let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                                    let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    }
                                    let buttonOne = DefaultButton(title: "OK") {
                                        let newViewController =  UpdateCustomerCreditViewController()
                                        newViewController.ocfdFFriend = self.ocfdFFriend
                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                }
                            }

                 
                            popup1.addButtons([buttonOne1])
                            self.present(popup1, animated: true, completion: nil)
                            

                        }
                        popup.addButtons([buttonTwo,buttonThree])
                        self.present(popup, animated: true, completion: nil)
                        return
                    }
                }
            }
            
            if(self.ocfdFFriend?.LoaiKH == 0 || self.ocfdFFriend?.LoaiKH == 1){
                if(self.ocfdFFriend!.CMND != "" && self.ocfdFFriend!.NgayCapCMND != "" && self.ocfdFFriend!.NoiCapCMND != 0){
                    if(self.ocfdFFriend!.MaHTThanhToan == "BANK"){
                        if(self.ocfdFFriend!.SoTKNH != "" && self.ocfdFFriend!.IdBank != 0 && self.ocfdFFriend!.ChiNhanhNH != 0){
                            
                            if(self.ocfdFFriend?.TraThang == 0){

                                let title = "THÔNG BÁO"
                                let message = "Vui lòng chọn loại đơn hàng muốn tạo?"
                                let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                }
                                let buttonOne = CancelButton(title: "Trả góp") {
                                    
                                    if(self.ocfdFFriend!.Message_TG.count > 0){
                                        let title = "THÔNG BÁO"
                                        let popup = PopupDialog(title: title, message: self.ocfdFFriend!.Message_TG, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        }
                                        let buttonOne = CancelButton(title: "OK") {
                                        }
                                        popup.addButtons([buttonOne])
                                        self.present(popup, animated: true, completion: nil)
                                        return
                                    }
                                    
                                    if(self.ocfdFFriend!.CMND_TinhThanhPho != 0 && self.ocfdFFriend!.CMND_QuanHuyen != 0 && self.ocfdFFriend!.CMND_PhuongXa != "" && self.ocfdFFriend!.NguoiLienHe != "" && self.ocfdFFriend!.SDT_NguoiLienHe != "" && self.ocfdFFriend!.QuanHeVoiNguoiLienHe != 0 && self.ocfdFFriend!.NguoiLienHe_2 != "" && self.ocfdFFriend!.SDT_NguoiLienHe_2 != "" && self.ocfdFFriend!.QuanHeVoiNguoiLienHe_2 != 0){
                                        
                                         let newViewController = InputEcomNumFFViewController()
                            
                                        newViewController.ocfdFFriend = self.ocfdFFriend
                                        newViewController.typeOrder = 0
                                        Cache.ocfdFFriend = self.ocfdFFriend
                                        Cache.typeOrder = "09"
                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                        
                                    }else{
                                        let title = "THÔNG BÁO"
                                        let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        }
                                        let buttonOne = DefaultButton(title: "OK") {
                                            let newViewController =  UpdateCustomerInstallmentViewController()
                                            newViewController.ocfdFFriend = self.ocfdFFriend
                                            self.navigationController?.pushViewController(newViewController, animated: true)
                                        }
                                        popup.addButtons([buttonOne])
                                        self.present(popup, animated: true, completion: nil)
                                    }
                                    
                                    
                                }
                                let buttonTwo = CancelButton(title: "Trả thẳng") {
                                    
                                    if(self.ocfdFFriend!.Message_TT.count > 0){
                                        let title = "THÔNG BÁO"
                                        let popup = PopupDialog(title: title, message: self.ocfdFFriend!.Message_TT, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        }
                                        let buttonOne = CancelButton(title: "OK") {
                                        }
                                        popup.addButtons([buttonOne])
                                        self.present(popup, animated: true, completion: nil)
                                        return
                                    }
                                    
                                     let newViewController = InputEcomNumFFViewController()
                            
                                    newViewController.ocfdFFriend = self.ocfdFFriend
                                    newViewController.typeOrder = 0
                                    Cache.ocfdFFriend = self.ocfdFFriend
                                    Cache.typeOrder = "10"
                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                }
                           
                               // popup.addButtons([buttonOne,buttonTwo,buttonThree])
                                popup.addButtons([buttonOne,buttonTwo])
                                self.present(popup, animated: true, completion: nil)
                            } else if(self.ocfdFFriend?.TraThang == 2){
                                if(self.ocfdFFriend!.Message_TG.count > 0){
                                    let title = "THÔNG BÁO"
                                    let popup = PopupDialog(title: title, message: self.ocfdFFriend!.Message_TG, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    }
                                    let buttonOne = CancelButton(title: "OK") {
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                    return
                                }
                                let title = "THÔNG BÁO"
                                let message = "Vui lòng chọn loại đơn hàng muốn tạo?"
                                let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                }
                                let buttonOne = CancelButton(title: "Trả góp") {
                                    
                                    if(self.ocfdFFriend!.Message_TG.count > 0){
                                        let title = "THÔNG BÁO"
                                        let popup = PopupDialog(title: title, message: self.ocfdFFriend!.Message_TG, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        }
                                        let buttonOne = CancelButton(title: "OK") {
                                        }
                                        popup.addButtons([buttonOne])
                                        self.present(popup, animated: true, completion: nil)
                                        return
                                    }
                                    if(self.ocfdFFriend!.CMND_TinhThanhPho != 0 && self.ocfdFFriend!.CMND_QuanHuyen != 0 && self.ocfdFFriend!.CMND_PhuongXa != "" && self.ocfdFFriend!.NguoiLienHe != "" && self.ocfdFFriend!.SDT_NguoiLienHe != "" && self.ocfdFFriend!.QuanHeVoiNguoiLienHe != 0 && self.ocfdFFriend!.NguoiLienHe_2 != "" && self.ocfdFFriend!.SDT_NguoiLienHe_2 != "" && self.ocfdFFriend!.QuanHeVoiNguoiLienHe_2 != 0){
                                        
                                         let newViewController = InputEcomNumFFViewController()
                            
                                        newViewController.ocfdFFriend = self.ocfdFFriend
                                        newViewController.typeOrder = 0
                                        Cache.ocfdFFriend = self.ocfdFFriend
                                        Cache.typeOrder = "09"
                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                        
                                    }else{
                                        let title = "THÔNG BÁO"
                                        let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        }
                                        let buttonOne = DefaultButton(title: "OK") {
                                            let newViewController =  UpdateCustomerInstallmentViewController()
                                            newViewController.ocfdFFriend = self.ocfdFFriend
                                            self.navigationController?.pushViewController(newViewController, animated: true)
                                        }
                                        popup.addButtons([buttonOne])
                                        self.present(popup, animated: true, completion: nil)
                                    }
                                }
                                let buttonThree = CancelButton(title: "Trả góp credit") {
                                    //MOI
                                    
                                    let popup1 = PopupDialog(title: "THÔNG BÁO", message: "Vui lòng chọn loại KH Credit muốn tạo", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        print("Completed")
                                    }
                                    let buttonOne1 = CancelButton(title: "Credit có thẻ") {
                                        if(self.ocfdFFriend!.CMND != "" && self.ocfdFFriend!.CardName != "" && self.ocfdFFriend!.SDT != "" && self.ocfdFFriend!.CreditCard != "" && self.ocfdFFriend!.MaCongTy != ""){

                                             let newViewController = InputEcomNumFFViewController()
                            
                                            newViewController.ocfdFFriend = self.ocfdFFriend
                                            Cache.ocfdFFriend = self.ocfdFFriend
                                            Cache.typeOrder = "20"
                                            self.navigationController?.pushViewController(newViewController, animated: true)
                                        }else{
                                            let title = "THÔNG BÁO"
                                            let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                                            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                            }
                                            let buttonOne = DefaultButton(title: "OK") {
                                                let newViewController =  UpdateCustomerCreditViewController()
                                                newViewController.ocfdFFriend = self.ocfdFFriend
                                                self.navigationController?.pushViewController(newViewController, animated: true)
                                            }
                                            popup.addButtons([buttonOne])
                                            self.present(popup, animated: true, completion: nil)
                                        }
                                    }

                       
                                    popup1.addButtons([buttonOne1])
                                    self.present(popup1, animated: true, completion: nil)
                                    
                           

                                }
                                popup.addButtons([buttonOne,buttonThree])
                                self.present(popup, animated: true, completion: nil)
                                

                            }else{
                                if(self.ocfdFFriend!.Message_TT.count > 0){
                                    let title = "THÔNG BÁO"
                                    let popup = PopupDialog(title: title, message: self.ocfdFFriend!.Message_TT, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    }
                                    let buttonOne = CancelButton(title: "OK") {
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                    return
                                }
                                
                                 let newViewController = InputEcomNumFFViewController()
                            
                                newViewController.ocfdFFriend = self.ocfdFFriend
                                newViewController.typeOrder = 0
                                Cache.ocfdFFriend = self.ocfdFFriend
                                Cache.typeOrder = "10"
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }
                        }else{
                            let title = "THÔNG BÁO"
                            let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            }
                            let buttonOne = DefaultButton(title: "OK") {
                                let newViewController =  UpdateCustomerInstallmentViewController()
                                newViewController.ocfdFFriend = self.ocfdFFriend
                                if(self.ocfdFFriend!.SoTKNH == ""){
                                    newViewController.inputSoTKNH = true
                                }
                                if(self.ocfdFFriend!.IdBank == 0){
                                    newViewController.inputIdBank = true
                                }
                                if(self.ocfdFFriend!.ChiNhanhNH == 0){
                                    newViewController.inputChiNhanhNH = true
                                }
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    }else{
                        
                        if(self.ocfdFFriend?.TraThang == 0){
                            

                            let title = "THÔNG BÁO"
                            let message = "Vui lòng chọn loại đơn hàng muốn tạo?"
                            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            }
                            let buttonOne = CancelButton(title: "Trả góp") {
                                
                                if(self.ocfdFFriend!.Message_TG.count > 0){
                                    let title = "THÔNG BÁO"
                                    let popup = PopupDialog(title: title, message: self.ocfdFFriend!.Message_TG, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    }
                                    let buttonOne = CancelButton(title: "OK") {
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                    return
                                }
                                
                                if(self.ocfdFFriend!.CMND_TinhThanhPho != 0 && self.ocfdFFriend!.CMND_QuanHuyen != 0 && self.ocfdFFriend!.CMND_PhuongXa != "" && self.ocfdFFriend!.NguoiLienHe != "" && self.ocfdFFriend!.SDT_NguoiLienHe != "" && self.ocfdFFriend!.QuanHeVoiNguoiLienHe != 0 && self.ocfdFFriend!.NguoiLienHe_2 != "" && self.ocfdFFriend!.SDT_NguoiLienHe_2 != "" && self.ocfdFFriend!.QuanHeVoiNguoiLienHe_2 != 0){
                                    
                                     let newViewController = InputEcomNumFFViewController()
                            
                                    newViewController.ocfdFFriend = self.ocfdFFriend
                                    newViewController.typeOrder = 0
                                    Cache.ocfdFFriend = self.ocfdFFriend
                                    Cache.typeOrder = "09"
                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                    
                                }else{
                                    let title = "THÔNG BÁO"
                                    let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                                    let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    }
                                    let buttonOne = DefaultButton(title: "OK") {
                                        let newViewController =  UpdateCustomerInstallmentViewController()
                                        newViewController.ocfdFFriend = self.ocfdFFriend
                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                }
                                
                            }
                            let buttonTwo = CancelButton(title: "Trả thẳng") {
                                
                                
                                if(self.ocfdFFriend!.Message_TT.count > 0){
                                    let title = "THÔNG BÁO"
                                    let popup = PopupDialog(title: title, message: self.ocfdFFriend!.Message_TT, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    }
                                    let buttonOne = CancelButton(title: "OK") {
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                    return
                                }
                                
                                 let newViewController = InputEcomNumFFViewController()
                            
                                newViewController.ocfdFFriend = self.ocfdFFriend
                                newViewController.typeOrder = 0
                                Cache.ocfdFFriend = self.ocfdFFriend
                                Cache.typeOrder = "10"
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }
                            let buttonThree = CancelButton(title: "Trả góp credit") {
                                //MOI
                                
                                let popup1 = PopupDialog(title: "THÔNG BÁO", message: "Vui lòng chọn loại KH Credit muốn tạo", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let buttonOne1 = CancelButton(title: "Credit có thẻ") {
                                    if(self.ocfdFFriend!.CMND != "" && self.ocfdFFriend!.CardName != "" && self.ocfdFFriend!.SDT != "" && self.ocfdFFriend!.CreditCard != "" && self.ocfdFFriend!.MaCongTy != ""){

                                         let newViewController = InputEcomNumFFViewController()
                            
                                        newViewController.ocfdFFriend = self.ocfdFFriend
                                        Cache.ocfdFFriend = self.ocfdFFriend
                                        Cache.typeOrder = "20"
                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                    }else{
                                        let title = "THÔNG BÁO"
                                        let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        }
                                        let buttonOne = DefaultButton(title: "OK") {
                                            let newViewController =  UpdateCustomerCreditViewController()
                                            newViewController.ocfdFFriend = self.ocfdFFriend
                                            self.navigationController?.pushViewController(newViewController, animated: true)
                                        }
                                        popup.addButtons([buttonOne])
                                        self.present(popup, animated: true, completion: nil)
                                    }
                                }

            
                                popup1.addButtons([buttonOne1])
                                self.present(popup1, animated: true, completion: nil)

                            }
                            popup.addButtons([buttonOne,buttonTwo,buttonThree])
                            self.present(popup, animated: true, completion: nil)
                        }else if(self.ocfdFFriend?.TraThang == 2){
                            if(self.ocfdFFriend!.Message_TG.count > 0){
                                let title = "THÔNG BÁO"
                                let popup = PopupDialog(title: title, message: self.ocfdFFriend!.Message_TG, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                                return
                            }
                            

                            let title = "THÔNG BÁO"
                            let message = "Vui lòng chọn loại đơn hàng muốn tạo?"
                            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            }
                            let buttonOne = CancelButton(title: "Trả góp") {
                                
                                if(self.ocfdFFriend!.Message_TG.count > 0){
                                    let title = "THÔNG BÁO"
                                    let popup = PopupDialog(title: title, message: self.ocfdFFriend!.Message_TG, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    }
                                    let buttonOne = CancelButton(title: "OK") {
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                    return
                                }
                                
                                if(self.ocfdFFriend!.CMND_TinhThanhPho != 0 && self.ocfdFFriend!.CMND_QuanHuyen != 0 && self.ocfdFFriend!.CMND_PhuongXa != "" && self.ocfdFFriend!.NguoiLienHe != "" && self.ocfdFFriend!.SDT_NguoiLienHe != "" && self.ocfdFFriend!.QuanHeVoiNguoiLienHe != 0 && self.ocfdFFriend!.NguoiLienHe_2 != "" && self.ocfdFFriend!.SDT_NguoiLienHe_2 != "" && self.ocfdFFriend!.QuanHeVoiNguoiLienHe_2 != 0){
                                    
                                     let newViewController = InputEcomNumFFViewController()
                            
                                    newViewController.ocfdFFriend = self.ocfdFFriend
                                    newViewController.typeOrder = 0
                                    Cache.ocfdFFriend = self.ocfdFFriend
                                    Cache.typeOrder = "09"
                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                    
                                }else{
                                    let title = "THÔNG BÁO"
                                    let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                                    let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    }
                                    let buttonOne = DefaultButton(title: "OK") {
                                        let newViewController =  UpdateCustomerInstallmentViewController()
                                        newViewController.ocfdFFriend = self.ocfdFFriend
                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                }
                            }
                            let buttonThree = CancelButton(title: "Trả góp credit") {
                                //MOI
                                
                                let popup1 = PopupDialog(title: "THÔNG BÁO", message: "Vui lòng chọn loại KH Credit muốn tạo", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let buttonOne1 = CancelButton(title: "Credit có thẻ") {
                                    if(self.ocfdFFriend!.CMND != "" && self.ocfdFFriend!.CardName != "" && self.ocfdFFriend!.SDT != "" && self.ocfdFFriend!.CreditCard != "" && self.ocfdFFriend!.MaCongTy != ""){

                                         let newViewController = InputEcomNumFFViewController()
                            
                                        newViewController.ocfdFFriend = self.ocfdFFriend
                                        Cache.ocfdFFriend = self.ocfdFFriend
                                        Cache.typeOrder = "20"
                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                    }else{
                                        let title = "THÔNG BÁO"
                                        let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        }
                                        let buttonOne = DefaultButton(title: "OK") {
                                            let newViewController =  UpdateCustomerCreditViewController()
                                            newViewController.ocfdFFriend = self.ocfdFFriend
                                            self.navigationController?.pushViewController(newViewController, animated: true)
                                        }
                                        popup.addButtons([buttonOne])
                                        self.present(popup, animated: true, completion: nil)
                                    }
                                }

             
                                popup1.addButtons([buttonOne1])
                                self.present(popup1, animated: true, completion: nil)

                            }
                            popup.addButtons([buttonOne,buttonThree])
                            self.present(popup, animated: true, completion: nil)
                            
                            
                        }else{
                            if(self.ocfdFFriend!.Message_TT.count > 0){
                                let title = "THÔNG BÁO"
                                let popup = PopupDialog(title: title, message: self.ocfdFFriend!.Message_TT, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                                return
                            }
//                            let nc = NotificationCenter.default
//                            nc.addObserver(self, selector: #selector(self.autoLoadCMND), name: Notification.Name("AutoLoadCMND"), object: nil)
                            let title = "THÔNG BÁO"
                            let message = "Vui lòng chọn loại đơn hàng muốn tạo?"
                            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            }
                            let buttonTwo = CancelButton(title: "Trả thẳng") {
                                
                                if(self.ocfdFFriend!.Message_TT.count > 0){
                                    let title = "THÔNG BÁO"
                                    let popup = PopupDialog(title: title, message: self.ocfdFFriend!.Message_TT, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    }
                                    let buttonOne = CancelButton(title: "OK") {
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                    return
                                }
                                
                                 let newViewController = InputEcomNumFFViewController()
                            
                                newViewController.ocfdFFriend = self.ocfdFFriend
                                newViewController.typeOrder = 0
                                Cache.ocfdFFriend = self.ocfdFFriend
                                Cache.typeOrder = "10"
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }
                            let buttonThree = CancelButton(title: "Trả góp credit") {
                                //MOI
                                
                                let popup1 = PopupDialog(title: "THÔNG BÁO", message: "Vui lòng chọn loại KH Credit muốn tạo", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let buttonOne1 = CancelButton(title: "Credit có thẻ") {
                                    if(self.ocfdFFriend!.CMND != "" && self.ocfdFFriend!.CardName != "" && self.ocfdFFriend!.SDT != "" && self.ocfdFFriend!.CreditCard != "" && self.ocfdFFriend!.MaCongTy != ""){

                                         let newViewController = InputEcomNumFFViewController()
                            
                                        newViewController.ocfdFFriend = self.ocfdFFriend
                                        Cache.ocfdFFriend = self.ocfdFFriend
                                        Cache.typeOrder = "20"
                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                    }else{
                                        let title = "THÔNG BÁO"
                                        let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        }
                                        let buttonOne = DefaultButton(title: "OK") {
                                            let newViewController =  UpdateCustomerCreditViewController()
                                            newViewController.ocfdFFriend = self.ocfdFFriend
                                            self.navigationController?.pushViewController(newViewController, animated: true)
                                        }
                                        popup.addButtons([buttonOne])
                                        self.present(popup, animated: true, completion: nil)
                                    }
                                }

                    
                                popup1.addButtons([buttonOne1])
                                self.present(popup1, animated: true, completion: nil)

                            }
                            popup.addButtons([buttonTwo,buttonThree])
                            self.present(popup, animated: true, completion: nil)
                        }
                    }
                }else{
                    let title = "THÔNG BÁO"
                    let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                    let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    }
                    let buttonOne = DefaultButton(title: "OK") {
                        let newViewController =  UpdateCustomerInstallmentViewController()
                        newViewController.ocfdFFriend = self.ocfdFFriend
                        if(self.ocfdFFriend!.DiaChiHoKhau == ""){
                            newViewController.inputAddressCMND = true
                        }
                        if(self.ocfdFFriend!.NgayCapCMND == "" || self.ocfdFFriend!.NgayCapCMND == "01/01/1970"){
                            newViewController.inputDateCMND = true
                        }
                        if(self.ocfdFFriend!.NoiCapCMND == 0){
                            newViewController.inputPlaceCMND = true
                        }
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
            }else if(self.ocfdFFriend?.LoaiKH == 4 || self.ocfdFFriend?.LoaiKH == 5){
                
                if(self.ocfdFFriend?.LoaiKH == 4){
                    if(self.ocfdFFriend!.CMND != "" && self.ocfdFFriend!.CardName != "" && self.ocfdFFriend!.SDT != "" && self.ocfdFFriend!.CreditCard != "" && self.ocfdFFriend!.MaCongTy != ""){
                        if(self.ocfdFFriend!.Message_TT.count > 0){
                            let title = "THÔNG BÁO"
                            let popup = PopupDialog(title: title, message: self.ocfdFFriend!.Message_TT, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            }
                            let buttonOne = CancelButton(title: "OK") {
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                            return
                        }
                        

                         let newViewController = InputEcomNumFFViewController()
                        
                        newViewController.ocfdFFriend = self.ocfdFFriend
                        Cache.ocfdFFriend = self.ocfdFFriend
                        Cache.typeOrder = "20"
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }else{
                        let title = "THÔNG BÁO"
                        let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        }
                        let buttonOne = DefaultButton(title: "OK") {
                            let newViewController =  UpdateCustomerCreditViewController()
                            newViewController.ocfdFFriend = self.ocfdFFriend
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }else{
                    

                    if(self.ocfdFFriend!.CMND != "" && self.ocfdFFriend!.CardName != "" && self.ocfdFFriend!.SDT != ""){
                        if(self.ocfdFFriend!.OtherTime != ""){
                            if(self.ocfdFFriend!.HanMucConLai > 0.0){

                                 let newViewController = InputEcomNumFFViewController()
                            
                                newViewController.ocfdFFriend = self.ocfdFFriend
                                Cache.ocfdFFriend = self.ocfdFFriend
                                Cache.typeOrder = "20"
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }else{
                                let title = "THÔNG BÁO"
                                let popup = PopupDialog(title: title, message: "Khách hàng không có đủ hạn mức còn lại để tạo đơn hàng!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }
                        }else if(self.ocfdFFriend!.TimeFrom != "" &&  self.ocfdFFriend!.TimeTo != ""){
                            if(self.ocfdFFriend!.HanMucConLai > 0.0){

                                 let newViewController = InputEcomNumFFViewController()
                            
                                newViewController.ocfdFFriend = self.ocfdFFriend
                                Cache.ocfdFFriend = self.ocfdFFriend
                                Cache.typeOrder = "20"
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }else{
                                let title = "THÔNG BÁO"
                                let popup = PopupDialog(title: title, message: "Khách hàng không có đủ hạn mức còn lại để tạo đơn hàng!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }
                        }else{
                            let title = "THÔNG BÁO"
                            let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            }
                            let buttonOne = DefaultButton(title: "OK") {
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
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    }else{
                        let title = "THÔNG BÁO"
                        let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        }
                        let buttonOne = DefaultButton(title: "OK") {
                            //NOT GOLIVE
                            let popup = PopupDialog(title: "Thông báo", message: "Vì doanh nghiệp của KH chưa cung cấp thông tin của KH cho phòng Dự án kiểm tra trước nên thời gian mở thẻ của Anh/chị khoảng 5-7 ngày làm việc", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            }
                            let buttonOne = CancelButton(title: "OK") {
                         
                                let newViewController = CustomerCreditNoCardViewControllerV3()
                                newViewController.ocfdFFriend = self.ocfdFFriend
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }

                }
                
            }else if(self.ocfdFFriend?.LoaiKH == 2){
                if(self.ocfdFFriend!.Message_TT.count > 0){
                    let title = "THÔNG BÁO"
                    let popup = PopupDialog(title: title, message: self.ocfdFFriend!.Message_TT, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    }
                    let buttonOne = CancelButton(title: "OK") {
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    return
                }
//                let nc = NotificationCenter.default
//                nc.addObserver(self, selector: #selector(self.autoLoadCMND), name: Notification.Name("AutoLoadCMND"), object: nil)
                let title = "THÔNG BÁO"
                let message = "Vui lòng chọn loại đơn hàng muốn tạo?"
                let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                }
                let buttonTwo = CancelButton(title: "Trả thẳng") {
                    
                    if(self.ocfdFFriend!.Message_TT.count > 0){
                        let title = "THÔNG BÁO"
                        let popup = PopupDialog(title: title, message: self.ocfdFFriend!.Message_TT, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        }
                        let buttonOne = CancelButton(title: "OK") {
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                        return
                    }
                    
                     let newViewController = InputEcomNumFFViewController()
                    
                    newViewController.ocfdFFriend = self.ocfdFFriend
                    newViewController.typeOrder = 0
                    Cache.ocfdFFriend = self.ocfdFFriend
                    Cache.typeOrder = "10"
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
                let buttonThree = CancelButton(title: "Trả góp credit") {
                    //MOI
                    
                    let popup1 = PopupDialog(title: "THÔNG BÁO", message: "Vui lòng chọn loại KH Credit muốn tạo", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne1 = CancelButton(title: "Credit có thẻ") {
                        if(self.ocfdFFriend!.CMND != "" && self.ocfdFFriend!.CardName != "" && self.ocfdFFriend!.SDT != "" && self.ocfdFFriend!.CreditCard != "" && self.ocfdFFriend!.MaCongTy != ""){

                             let newViewController = InputEcomNumFFViewController()
                            
                            newViewController.ocfdFFriend = self.ocfdFFriend
                            Cache.ocfdFFriend = self.ocfdFFriend
                            Cache.typeOrder = "20"
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }else{
                            let title = "THÔNG BÁO"
                            let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            }
                            let buttonOne = DefaultButton(title: "OK") {
                                let newViewController =  UpdateCustomerCreditViewController()
                                newViewController.ocfdFFriend = self.ocfdFFriend
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    }

         
                    popup1.addButtons([buttonOne1])
                    self.present(popup1, animated: true, completion: nil)

                }
                popup.addButtons([buttonTwo,buttonThree])
                self.present(popup, animated: true, completion: nil)
            }
        }
    }
    @objc func actionCreateNew(){
        newCustomer(cmnd: "",hinhthucmua:"")
   
    }
    func newCustomer(cmnd:String,hinhthucmua:String){
        if(hinhthucmua == "1"){
            let newViewController =  CustomerInstallmentViewController()
            newViewController.cmnd = cmnd
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else{
            if(self.FtelCustomer != nil){
                let newViewController =  CreateFtelFFriendViewController()
                newViewController.FtelCustomer = self.FtelCustomer
                self.navigationController?.pushViewController(newViewController, animated: true)
            }else{
                let newViewController =  CustomerPayDirectlyViewController()
                newViewController.cmnd = cmnd
                self.navigationController?.pushViewController(newViewController, animated: true)
            }

        }

        
    }
    @objc func tapShowCheckCredit(sender:UITapGestureRecognizer) {
        
        //                let newViewController = CheckCreditViewController()
        let newViewController = SearchVendorViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    func tapShowCheckCreditNoCard(sender:UITapGestureRecognizer) {

        
    }
    @objc func tapShowDetailCustomer(sender:UITapGestureRecognizer) {
        print("tapShowDetailCustomer")
        if(viewInfoCustomer.frame.size.height == 0){
            viewInfoCustomer.frame.size.height = tfCompany.frame.size.height + tfCompany.frame.origin.y
            
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString = NSAttributedString(string: "Ẩn chi tiết", attributes: underlineAttribute)
            lbInfoCustomerMore.attributedText = underlineAttributedString
            
        }else{
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString = NSAttributedString(string: "Hiện chi tiết", attributes: underlineAttribute)
            lbInfoCustomerMore.attributedText = underlineAttributedString
            viewInfoCustomer.frame.size.height = 0
        }
        viewInfoInstallment.frame.origin.y = viewInfoCustomer.frame.origin.y + viewInfoCustomer.frame.size.height
      self.webView.frame.origin.y = self.viewInfoInstallment.frame.size.height + self.viewInfoInstallment.frame.origin.y + Common.Size(s: 5)
        self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.webView.frame.origin.y + self.webView.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        
    }
    @objc func tapShowDetailCallLog(sender:UITapGestureRecognizer) {
        print("tapShowDetailCustomer")
        if(viewInfoCallLog.frame.size.height == 0){
            viewInfoCallLog.frame.size.height = lbTextStatusCallLog.frame.size.height + lbTextStatusCallLog.frame.origin.y
            lbInfoHistoryMore.frame.origin.y = viewInfoCallLog.frame.origin.y + viewInfoCallLog.frame.size.height + Common.Size(s:15)
            btCreateOrder.frame.origin.y = lbInfoHistoryMore.frame.size.height + lbInfoHistoryMore.frame.origin.y + Common.Size(s: 20)
            
            lbUpdate.frame.origin.y = btCreateOrder.frame.origin.y + btCreateOrder.frame.size.height + Common.Size(s:10)
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString = NSAttributedString(string: "Ẩn CallLog", attributes: underlineAttribute)
            lbInfoCallLogMore.attributedText = underlineAttributedString
            
        }else{
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString = NSAttributedString(string: "Hiện CallLog", attributes: underlineAttribute)
            lbInfoCallLogMore.attributedText = underlineAttributedString
            viewInfoCallLog.frame.size.height = 0
            lbInfoHistoryMore.frame.origin.y = viewInfoCallLog.frame.origin.y + viewInfoCallLog.frame.size.height + Common.Size(s:15)
            btCreateOrder.frame.origin.y = lbInfoHistoryMore.frame.size.height + lbInfoHistoryMore.frame.origin.y + Common.Size(s: 20)
            
            lbUpdate.frame.origin.y = btCreateOrder.frame.origin.y + btCreateOrder.frame.size.height + Common.Size(s:10)
        }
        
        viewInfoInstallment.frame.size.height = lbUpdate.frame.size.height + lbUpdate.frame.origin.y + Common.Size(s:20)
        
        self.webView.frame.origin.y = self.viewInfoInstallment.frame.size.height + self.viewInfoInstallment.frame.origin.y + Common.Size(s: 5)
                       self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.webView.frame.origin.y + self.webView.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        
    }
    @objc func checkCallLogCIC(){
        if (ocfdFFriend != nil){
            if(self.ocfdFFriend!.MessageQRCode != ""){
                let alert = UIAlertController(title: "Thông báo", message: self.ocfdFFriend!.MessageQRCode, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra thông tin KH..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            
            MPOSAPIManager.sp_mpos_InstallCustInfo_CalllogCIC_CheckAndCreate(IDCardCode: "\(self.ocfdFFriend!.IDcardCode)") { [weak self](results, err) in
                guard let self = self else {return}
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        if(results[0].Result == 1){
                            if(results[0].Message == ""){
                                let isTraGop = results[0].IsTGTT + results[0].IsTGKnox
                                self.actionCreateOrderV2(isTraGop: isTraGop, isTraThang: results[0].IsTT)
                            }else{
                                let alert = UIAlertController(title: "Thông báo", message: results[0].Message, preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: "OK", style: .destructive) { _ in
                                    let isTraGop = results[0].IsTGTT + results[0].IsTGKnox
                                    self.actionCreateOrderV2(isTraGop: isTraGop, isTraThang: results[0].IsTT)
                                })
                                self.present(alert, animated: true)
                            }
                            
                        }else{
                            if(results[0].Message != ""){
                                let alert = UIAlertController(title: "Thông báo", message: results[0].Message, preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: "OK", style: .destructive) { _ in
                                    let isTraGop = results[0].IsTGTT + results[0].IsTGKnox
                                    self.actionCreateOrderV2(isTraGop: isTraGop, isTraThang: results[0].IsTT)
                                })
                                self.present(alert, animated: true)
                            }else{
                                let isTraGop = results[0].IsTGTT + results[0].IsTGKnox
                                self.actionCreateOrderV2(isTraGop: isTraGop, isTraThang: results[0].IsTT)
                            }
                            
                            
                        }
                        
                        
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                }
            }
        }
        
    }
    func actionCreateOrderV2(isTraGop:Int,isTraThang:Int){
        let title = "THÔNG BÁO"
        let message = "Vui lòng chọn loại đơn hàng muốn tạo?"
        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
        }
        let buttonOne = CancelButton(title: "Trả góp") {
            
            if(self.ocfdFFriend!.Message_TG.count > 0){
                let title = "THÔNG BÁO"
                let popup = PopupDialog(title: title, message: self.ocfdFFriend!.Message_TG, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                }
                let buttonOne = CancelButton(title: "OK") {
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
                return
            }
            if(self.ocfdFFriend!.CMND_TinhThanhPho != 0 && self.ocfdFFriend!.CMND_QuanHuyen != 0 && self.ocfdFFriend!.CMND_PhuongXa != ""){
                if(self.ocfdFFriend!.Is_FRT != 1){
                    if(self.ocfdFFriend!.NguoiLienHe != "" && self.ocfdFFriend!.SDT_NguoiLienHe != "" && self.ocfdFFriend!.QuanHeVoiNguoiLienHe != 0 && self.ocfdFFriend!.NguoiLienHe_2 != "" && self.ocfdFFriend!.SDT_NguoiLienHe_2 != "" && self.ocfdFFriend!.QuanHeVoiNguoiLienHe_2 != 0){
                        
                        let newViewController = InputEcomNumFFViewController()
                        
                        newViewController.ocfdFFriend = self.ocfdFFriend
                        newViewController.typeOrder = 0
                        Cache.ocfdFFriend = self.ocfdFFriend
                        Cache.typeOrder = "09"
                        self.navigationController?.pushViewController(newViewController, animated: true)
                        
                        
                    }else{
                        let title = "THÔNG BÁO"
                        let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        }
                        let buttonOne = DefaultButton(title: "OK") {
                            let newViewController =  UpdateCustomerInstallmentViewController()
                            newViewController.ocfdFFriend = self.ocfdFFriend
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                    
                }else{
                    let newViewController = InputEcomNumFFViewController()
                              
                    newViewController.ocfdFFriend = self.ocfdFFriend
                    newViewController.typeOrder = 0
                    Cache.ocfdFFriend = self.ocfdFFriend
                    Cache.typeOrder = "09"
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
                
          
                
            }else{
                let title = "THÔNG BÁO"
                let message = "Vui lòng cập nhật các thông tin màu đỏ trước khi tạo đơn hàng"
                let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                }
                let buttonOne = DefaultButton(title: "OK") {
                    let newViewController =  UpdateCustomerInstallmentViewController()
                    newViewController.ocfdFFriend = self.ocfdFFriend
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }
        }
        let buttonTwo = CancelButton(title: "Trả thẳng") {
            
            if(self.ocfdFFriend!.Message_TT.count > 0){
                let title = "THÔNG BÁO"
                let popup = PopupDialog(title: title, message: self.ocfdFFriend!.Message_TT, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                }
                let buttonOne = CancelButton(title: "OK") {
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
                return
            }
            
            let newViewController = InputEcomNumFFViewController()
            
            newViewController.ocfdFFriend = self.ocfdFFriend
            newViewController.typeOrder = 0
            Cache.ocfdFFriend = self.ocfdFFriend
            Cache.typeOrder = "10"
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        if(isTraGop > 0 && isTraThang > 0){
             popup.addButtons([buttonOne,buttonTwo])
             self.present(popup, animated: true, completion: nil)
        }
        if(isTraGop == 0 && isTraThang > 0){
             popup.addButtons([buttonTwo])
             self.present(popup, animated: true, completion: nil)
        }
        if(isTraGop > 0 && isTraThang == 0){
            popup.addButtons([buttonOne])
             self.present(popup, animated: true, completion: nil)
        }
       
     
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func scanQRCode(code:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin KH..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.Get_Info_FF_From_QRCode(input_qrcode:code) {[weak self] (result, err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(result!.Result == 1){
                        self.FtelCustomer = result
                        self.tfCMND.text = result!.IdCard
                        if(result!.IdCard == ""){
                            let newViewController =  CreateFtelFFriendViewController()
                            newViewController.FtelCustomer = self.FtelCustomer
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }else{
                            self.checkCMND(cmnd: result!.IdCard)
                        }
                        
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: result?.Messages, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                       
                    }
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    
}
