//
//  NapTienViettelPayViewControllerV2.swift
//  fptshop
//
//  Created by DiemMy Le on 3/2/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import DLRadioButton
class NapTienViettelPayViewControllerV2:  UIViewController,UITextFieldDelegate,UITextViewDelegate{
    
    // MARK: - Properties
    
    private var scrollView:UIScrollView!
    
    private var viewChuTK:UIView!
    private var viewNTT:UIView!
    private var viewTTNT:UIView!
    private var tfPhone: UITextField!
    private var tfHoTenCTK:UITextField!
    private var tfHoTenNTT:UITextField!
    private var tfPhoneNguoiTT: UITextField!
    private var tfMoney:UITextField!

    private var tfGhiChu:UITextView!
    private var btOTP:UIButton!
    private var lbHoTenCTK:UILabel!
    private var lbHoTenNTT:UILabel!

    private var label3:UILabel!
    private var btFee:UIButton!
    private var otp:String = ""
    private var key_otp:String = ""
    private var lblOTP:UILabel!
    private var tfOTP:UITextField!
    private var lbResendOTP:UILabel!
    private var label2:UILabel!
    private var config:RechargeMoneyViettelPayConfiguration = .everyone
    private var radCheck:DLRadioButton = {
        let radio = DLRadioButton()
        radio.titleLabel!.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        radio.setTitleColor(UIColor.black, for: UIControl.State())
        radio.iconColor = UIColor.black
        radio.indicatorColor = UIColor.black
        radio.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        radio.setTitle("Nạp cho chính mình", for: UIControl.State())
        radio.addTarget(self, action: #selector(handleCheck), for: UIControl.Event.touchUpInside);
        return radio
    }()

    //SOM
    var itemViettelPaySOMInfo: ViettelPayNccInfo?
    //-------
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        self.title = "Nạp Tiền ViettelPay"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "THÔNG TIN CHỦ TÀI KHOẢN VIETTEL PAY"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        viewChuTK = UIView()
        viewChuTK.frame = CGRect(x: 0, y:label1.frame.origin.y + label1.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewChuTK.backgroundColor = UIColor.white
         viewChuTK.clipsToBounds = true
        scrollView.addSubview(viewChuTK)
        
        let lbTextPhone = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhone.textAlignment = .left
        lbTextPhone.textColor = UIColor.black
        lbTextPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhone.text = "Số điện thoại"
        viewChuTK.addSubview(lbTextPhone)
        
        tfPhone = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhone.frame.origin.y + lbTextPhone.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfPhone.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhone.autocorrectionType = UITextAutocorrectionType.no
        tfPhone.keyboardType = UIKeyboardType.numberPad
        tfPhone.returnKeyType = UIReturnKeyType.done
        tfPhone.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhone.delegate = self
         tfPhone.addTarget(self, action: #selector(textFieldDidChangPhone(_:)), for: .editingChanged)
        viewChuTK.addSubview(tfPhone)
        
        lbHoTenCTK = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhone.frame.origin.y + tfPhone.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: 0))
        lbHoTenCTK.textAlignment = .left
        lbHoTenCTK.textColor = UIColor.black
        lbHoTenCTK.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHoTenCTK.text = "Họ tên"
       
        viewChuTK.addSubview(lbHoTenCTK)

        tfHoTenCTK = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbHoTenCTK.frame.origin.y + lbHoTenCTK.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height:  0))
        tfHoTenCTK.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfHoTenCTK.borderStyle = UITextField.BorderStyle.roundedRect
        tfHoTenCTK.autocorrectionType = UITextAutocorrectionType.no
        tfHoTenCTK.keyboardType = UIKeyboardType.numberPad
        tfHoTenCTK.returnKeyType = UIReturnKeyType.done
        tfHoTenCTK.clearButtonMode = UITextField.ViewMode.whileEditing
        tfHoTenCTK.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfHoTenCTK.delegate = self
        viewChuTK.addSubview(tfHoTenCTK)
        
        viewChuTK.addSubview(radCheck)
        radCheck.frame = CGRect(x: Common.Size(s:15), y: tfHoTenCTK.frame.size.height + tfHoTenCTK.frame.origin.y , width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 35))
   

        viewChuTK.frame.size.height = radCheck.frame.origin.y + radCheck.frame.size.height +  Common.Size(s:10)
        
        label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewChuTK.frame.origin.y + viewChuTK.frame.size.height , width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label2.text = "THÔNG TIN NGƯỜI THANH TOÁN"
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label2)
        
        
        viewNTT = UIView()
        viewNTT.frame = CGRect(x: 0, y:label2.frame.origin.y + label2.frame.size.height, width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewNTT.backgroundColor = UIColor.white
        scrollView.addSubview(viewNTT)
        
        let lbTextPhone2 = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhone2.textAlignment = .left
        lbTextPhone2.textColor = UIColor.black
        lbTextPhone2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhone2.text = "Số điện thoại"
        viewNTT.addSubview(lbTextPhone2)
        
        tfPhoneNguoiTT = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhone2.frame.origin.y + lbTextPhone2.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfPhoneNguoiTT.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhoneNguoiTT.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhoneNguoiTT.autocorrectionType = UITextAutocorrectionType.no
        tfPhoneNguoiTT.keyboardType = UIKeyboardType.numberPad
        tfPhoneNguoiTT.returnKeyType = UIReturnKeyType.done
        tfPhoneNguoiTT.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhoneNguoiTT.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhoneNguoiTT.delegate = self
    
        viewNTT.addSubview(tfPhoneNguoiTT)
        
        lbHoTenNTT = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhoneNguoiTT.frame.origin.y + tfPhoneNguoiTT.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 14)))
        lbHoTenNTT.textAlignment = .left
        lbHoTenNTT.textColor = UIColor.black
        lbHoTenNTT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHoTenNTT.text = "Họ tên"
        viewNTT.addSubview(lbHoTenNTT)
        
        tfHoTenNTT = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbHoTenNTT.frame.origin.y + lbHoTenNTT.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s: 35)))
        tfHoTenNTT.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfHoTenNTT.borderStyle = UITextField.BorderStyle.roundedRect
        tfHoTenNTT.autocorrectionType = UITextAutocorrectionType.no
        tfHoTenNTT.keyboardType = UIKeyboardType.default
        tfHoTenNTT.returnKeyType = UIReturnKeyType.done
        tfHoTenNTT.clearButtonMode = UITextField.ViewMode.whileEditing
        tfHoTenNTT.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfHoTenNTT.delegate = self
        viewNTT.addSubview(tfHoTenNTT)
        
        viewNTT.frame.size.height = tfHoTenNTT.frame.origin.y + tfHoTenNTT.frame.size.height +  Common.Size(s:10)
        
        label3 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewNTT.frame.origin.y + viewNTT.frame.size.height , width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label3.text = "THÔNG TIN NẠP TIỀN"
        label3.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label3)
        
        
        viewTTNT = UIView()
        viewTTNT.frame = CGRect(x: 0, y:label3.frame.origin.y + label3.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewTTNT.backgroundColor = UIColor.white
        scrollView.addSubview(viewTTNT)
        
        
        let lbTextMoney = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextMoney.textAlignment = .left
        lbTextMoney.textColor = UIColor.black
        lbTextMoney.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextMoney.text = "Số tiền"
        viewTTNT.addSubview(lbTextMoney)
        
        tfMoney = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextMoney.frame.origin.y + lbTextMoney.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfMoney.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfMoney.borderStyle = UITextField.BorderStyle.roundedRect
        tfMoney.autocorrectionType = UITextAutocorrectionType.no
        tfMoney.keyboardType = UIKeyboardType.numberPad
        tfMoney.returnKeyType = UIReturnKeyType.done
        tfMoney.clearButtonMode = UITextField.ViewMode.whileEditing
        tfMoney.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfMoney.delegate = self
        tfMoney.addTarget(self, action: #selector(textFieldDidChangeMoney(_:)), for: .editingChanged)
        viewTTNT.addSubview(tfMoney)
        
        let lbTextGhiChu = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfMoney.frame.origin.y + tfMoney.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextGhiChu.textAlignment = .left
        lbTextGhiChu.textColor = UIColor.black
        lbTextGhiChu.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextGhiChu.text = "Ghi chú"
        viewTTNT.addSubview(lbTextGhiChu)
        
        tfGhiChu = UITextView(frame: CGRect(x: lbTextGhiChu.frame.origin.x , y: lbTextGhiChu.frame.origin.y  + lbTextGhiChu.frame.size.height + Common.Size(s:10), width: tfMoney.frame.size.width, height: tfMoney.frame.size.height * 2 ))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        tfGhiChu.layer.borderWidth = 0.5
        tfGhiChu.layer.borderColor = borderColor.cgColor
        tfGhiChu.layer.cornerRadius = 5.0
        tfGhiChu.delegate = self
        tfGhiChu.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        viewTTNT.addSubview(tfGhiChu)
        
        lblOTP = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfGhiChu.frame.origin.y + tfGhiChu.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: 0))
        lblOTP.textAlignment = .left
        lblOTP.textColor = UIColor.black
        lblOTP.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblOTP.text = "OTP"
        viewTTNT.addSubview(lblOTP)
        
        tfOTP = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblOTP.frame.origin.y + lblOTP.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:120) , height: 0))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfOTP.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfOTP.borderStyle = UITextField.BorderStyle.roundedRect
        tfOTP.autocorrectionType = UITextAutocorrectionType.no
        tfOTP.keyboardType = UIKeyboardType.numberPad
        tfOTP.returnKeyType = UIReturnKeyType.done
        tfOTP.clearButtonMode = UITextField.ViewMode.whileEditing
        tfOTP.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfOTP.delegate = self
        viewTTNT.addSubview(tfOTP)
        
        lbResendOTP = UILabel(frame: CGRect(x: tfOTP.frame.origin.x + tfOTP.frame.size.width + Common.Size(s: 5) , y: tfOTP.frame.origin.y  + Common.Size(s:30), width: scrollView.frame.size.width - Common.Size(s:30), height: 0))
        lbResendOTP.textAlignment = .left
        lbResendOTP.textColor = UIColor(netHex:0x04AB6E)
        lbResendOTP.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttributeHistory = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedStringHistory = NSAttributedString(string: "Gửi lại OTP", attributes: underlineAttributeHistory)
        lbResendOTP.attributedText = underlineAttributedStringHistory
        viewTTNT.addSubview(lbResendOTP)
        
        let tapResendOTP = UITapGestureRecognizer(target: self, action: #selector(actionResendOTP))
        lbResendOTP.isUserInteractionEnabled = true
        lbResendOTP.addGestureRecognizer(tapResendOTP)
        
        btOTP = UIButton()
        btOTP.frame = CGRect(x: tfGhiChu.frame.origin.x, y:tfOTP.frame.size.height + tfOTP.frame.origin.y + Common.Size(s:10), width: tfMoney.frame.size.width, height: tfMoney.frame.size.height * 1.2)
        btOTP.backgroundColor = UIColor(netHex:0x00955E)
        btOTP.setTitle("Lấy Phí", for: .normal)
        btOTP.addTarget(self, action: #selector(actionRequestOTP), for: .touchUpInside)
        btOTP.layer.borderWidth = 0.5
        btOTP.layer.borderColor = UIColor.white.cgColor
        btOTP.layer.cornerRadius = 3
        btOTP.clipsToBounds = true
        viewTTNT.addSubview(btOTP)
     

        viewTTNT.frame.size.height = btOTP.frame.size.height + btOTP.frame.origin.y + Common.Size(s: 10)
        

        viewTTNT.frame.size.height = btOTP.frame.size.height + btOTP.frame.origin.y + Common.Size(s: 10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTTNT.frame.origin.y + viewTTNT.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:45))
        
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "") {
            CRMAPIManager.ViettelPay_SOM_GetMainInfo { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs != nil {
                            self.itemViettelPaySOMInfo = rs
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "Không có data ViettelPay SOM!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    func getFee(phoneCTK: String, nameNguoiTT: String, phoneNguoiTT: String, soTien: String, otp: String, keyOtpFee: String) {
        
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang lấy phí...") {
            CRMAPIManager.ViettelPay_SOM_GetFee(senderName: "\(nameNguoiTT)", senderPhone: "\(phoneNguoiTT)", amount: "\(soTien)", subject: "\(phoneCTK)", providerId: self.itemViettelPaySOMInfo?.details.providerId ?? "", productId: self.itemViettelPaySOMInfo?.id ?? "", otp: "\(otp)", keyOtpFee: "\(keyOtpFee)") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs != nil {
                            
                            let vc = RechargeMoneyViettelPayFeeViewController()
                            vc.phoneCTK = rs?.subject.phoneNumber ?? ""
                            vc.hotenCTK = rs?.subject.name ?? ""
                            vc.phoneNTT = phoneNguoiTT
                            vc.hotenNTT = nameNguoiTT
                            vc.otp = self.otp
                            vc.keyotp = self.key_otp
                            vc.fee = rs?.fee ?? 0
                            vc.note = self.tfGhiChu.text ?? ""
                            vc.itemViettelPaySOMInfo = self.itemViettelPaySOMInfo
                            vc.itemViettelPayNapTienResult = rs
                            
                            let moneyText = (self.tfMoney.text ?? "").replace(target: ".", withString: "")
                            let moneyAmount = Double(moneyText)
                            vc.money = moneyAmount ?? 0
                            
                            if self.config == .yourself {
                                vc.isSwitch = true
                            }else{
                                vc.isSwitch = false
                            }
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "Không có data lấy phí!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    
    func getOTP(phoneCTK: String, nameNguoiTT: String, phoneNguoiTT: String, soTien: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang lấy OTP...") {
            CRMAPIManager.ViettelPay_SOM_GetOTP_NapChinhMinh(senderName: "\(nameNguoiTT)", senderPhone: "\(phoneNguoiTT)", amount: "\(soTien)", subject: "\(phoneCTK)", providerId: self.itemViettelPaySOMInfo?.details.providerId ?? "", productId: self.itemViettelPaySOMInfo?.id ?? "") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs != nil {
                            self.key_otp = rs?.keyOtpFee ?? ""
                            debugPrint("keyOtpFee: \(self.key_otp)")
                            
                            self.checkOTP()
                            self.tfPhone.isEnabled = false
                            self.lbHoTenCTK.frame.size.height = Common.Size(s: 14)
                            self.tfHoTenCTK.frame.size.height = Common.Size(s:35)
                            self.tfHoTenCTK.text = rs?.subject.name ?? ""
                            self.tfHoTenNTT.text = rs?.subject.name ?? ""
                            self.tfHoTenCTK.isEnabled = false
                            self.tfHoTenNTT.isEnabled = false
                            
                            self.tfHoTenCTK.frame.origin.y = self.lbHoTenCTK.frame.size.height + self.lbHoTenCTK.frame.origin.y + Common.Size(s: 10)
                            
                            self.radCheck.frame.origin.y =  self.tfHoTenCTK.frame.size.height + self.tfHoTenCTK.frame.origin.y
                            
                            self.viewChuTK.frame.size.height = self.radCheck.frame.origin.y + self.radCheck.frame.size.height +  Common.Size(s:10)
                            
                            self.label2.frame.origin.y = self.viewChuTK.frame.origin.y + self.viewChuTK.frame.size.height

                            self.viewNTT.frame.origin.y = self.label2.frame.origin.y + self.label2.frame.size.height

                            self.lbHoTenNTT.frame.size.height = Common.Size(s: 14)
                            self.tfHoTenNTT.frame.origin.y = self.lbHoTenNTT.frame.size.height + self.lbHoTenNTT.frame.origin.y + Common.Size(s: 10)
                            self.tfHoTenNTT.frame.size.height = Common.Size(s: 35)
                            
                            self.viewNTT.frame.size.height = self.tfHoTenNTT.frame.origin.y + self.tfHoTenNTT.frame.size.height +  Common.Size(s:10)
                            self.label3.frame.origin.y = self.viewNTT.frame.origin.y + self.viewNTT.frame.size.height
                            self.viewTTNT.frame.origin.y = self.label3.frame.origin.y + self.label3.frame.size.height
                            self.tfMoney.isEnabled = false
                            self.tfGhiChu.isEditable = false
                            
                            self.btOTP.setTitle("Lấy Phí", for: .normal)
                            
                            self.viewTTNT.frame.size.height = self.btOTP.frame.size.height + self.btOTP.frame.origin.y + Common.Size(s: 10)
                            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.viewTTNT.frame.origin.y + self.viewTTNT.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:45))

                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "Get OTP fail!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    // MARK: - Selectors
    
    @objc func handleCheck (_ radioButton : DLRadioButton){
        if (!radioButton.isMultipleSelectionEnabled) {
            if config == .everyone {
                checkConfigRecharge(config: .yourself)
            }else {
                checkConfigRecharge(config: .everyone)
            }

        }
    }
    
    func checkConfigRecharge(config: RechargeMoneyViettelPayConfiguration){
        self.config = config
        switch config {
        case .yourself:
            radCheck.isSelected = true
            btOTP.setTitle("Lấy OTP", for: .normal)
            lbHoTenNTT.frame.size.height = 0
            tfHoTenNTT.frame.size.height = 0
            tfPhoneNguoiTT.text = tfPhone.text
            tfPhoneNguoiTT.isUserInteractionEnabled = false
            reloadUI()
            
        case .everyone:
            radCheck.isSelected = false
            btOTP.setTitle("Lấy Phí", for: .normal)
            lbHoTenNTT.frame.size.height = Common.Size(s: 14)
            tfHoTenNTT.frame.size.height = Common.Size(s: 35)
            tfPhoneNguoiTT.text = ""
            tfPhoneNguoiTT.isUserInteractionEnabled = true
            reloadUI()
        }
    }
    
    func reloadUI(){
        tfHoTenNTT.frame.origin.y = lbHoTenNTT.frame.origin.y + lbHoTenNTT.frame.size.height + Common.Size(s:5)
        viewNTT.frame.size.height = tfHoTenNTT.frame.origin.y + tfHoTenNTT.frame.size.height +  Common.Size(s:10)
        label3.frame.origin.y = viewNTT.frame.origin.y + viewNTT.frame.size.height
        viewTTNT.frame.origin.y =  label3.frame.origin.y + label3.frame.size.height
   
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTTNT.frame.origin.y + viewTTNT.frame.size.height  + Common.Size(s:50))
    }

    
    @objc func actionRequestOTP(){
        guard let sdtChuTK = self.tfPhone.text, !sdtChuTK.isEmpty else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập số điện thoại chủ tài khoản ViettelPay!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let sdtNguoiTT = self.tfPhoneNguoiTT.text, !sdtNguoiTT.isEmpty else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập số điện thoại người thanh toán!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let soTienText = self.tfMoney.text, !soTienText.isEmpty else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập số tiền!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let ghiChuText = self.tfGhiChu.text, !ghiChuText.isEmpty else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập nội dung ghi chú!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let amountValue = soTienText.replace(target: ".", withString: "")
        if(config == .yourself){
            if btOTP.currentTitle == "Lấy Phí"{
                self.getFee(phoneCTK: sdtChuTK, nameNguoiTT: "\(self.tfHoTenCTK.text ?? "unknow")", phoneNguoiTT: sdtNguoiTT, soTien: amountValue, otp: "\(self.otp)", keyOtpFee: "\(self.key_otp)")
            }else{
                self.getOTP(phoneCTK: sdtChuTK, nameNguoiTT: "unknow", phoneNguoiTT: sdtNguoiTT, soTien: amountValue)
            }
        
        }else{
            guard let nameNguoiTT = self.tfHoTenNTT.text, !nameNguoiTT.isEmpty else {
                let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập họ tên người thanh toán!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.getFee(phoneCTK: sdtChuTK, nameNguoiTT: nameNguoiTT, phoneNguoiTT: sdtNguoiTT, soTien: amountValue, otp: "", keyOtpFee: "")
        }

    }
    @objc func actionResendOTP(){
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        var money = tfMoney.text!
        money = money.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang gửi OTP  ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.otpCashInVTPayEx(order_id: "frt-otpcashin-\(dateString)",trans_date:dateString,service_code: "TRANSFER",ben_bank_code:"VTT",sender_name:"FRT",sender_msisdn:"\(self.tfPhoneNguoiTT.text!)",receiver_msisdn:"\(self.tfPhone.text!)",amount: money) { [weak self] (results, err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
            
                    
                    self.checkOTP()
 
                    
                }else{
           
                    self.showPopUp(err, "Thông báo", buttonTitle: "OK")
                }
            }
        }
    }
   
    
    
    func checkOTP(){
        showInputDialog(title: "Xác Nhận",
                        subtitle: "Nhập mã OTP được gửi về máy khách hàng",
                        actionTitle: "Gửi lại mã OTP",
                        cancelTitle: "Xác Nhận",
                        inputPlaceholder: "",
                        inputKeyboardType: UIKeyboardType.numberPad, actionHandler:
                            {[weak self] (input:String?) in
                                guard let self = self else {return}
                                print("The pass input is \(input ?? "")")
                                // call api
                                //self.checkAPIPassCode(pass: input!)
                                if(input == ""){
                                    
                                    self.showPopUp("Vui lòng nhập mã OTP ???", "Thông báo", buttonTitle: "OK")
                                    return
                                }
                                self.otp = input ?? ""
                                if(self.tfOTP.frame.height > 0){
                                    self.tfOTP.text = input ?? ""
                                }
                                
                                
                            })
    }
    
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
            textField.isSecureTextEntry = false
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
            self.actionResendOTP()
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
 
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func textFieldDidChangeMoney(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s).\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
            self.tfMoney.text = str
        }else{
            textField.text = ""
            self.tfMoney.text = ""
        }
        
    }
    @objc func textFieldDidChangPhone(_ textField: UITextField) {
        self.tfPhoneNguoiTT.text = ""
    }
    @objc func actionGetFee(){
        if(self.tfOTP.frame.height > 0){
            self.otp = self.tfOTP.text!
        }
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        var money = tfMoney.text ?? ""
        money = money.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy phí ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.getFeeCashInEx(order_id:"frt-getfee-\(dateString)",trans_date: dateString,sender_name:"\(self.tfHoTenNTT.text!)",sender_msisdn:"\(self.tfPhoneNguoiTT.text!)",receiver_msisdn:self.tfPhone.text!,amount:money,key_otp_fee:"\(self.key_otp)",otp:"\(self.otp)",trans_content:"\(self.tfGhiChu.text!)") {[weak self] (results, err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    
                    let newViewController = RechargeMoneyViettelPayFeeViewController()
                    newViewController.phoneCTK = results.phoneReceiver
                    newViewController.hotenCTK = results.nameReceiver
                    newViewController.phoneNTT = results.phoneSender
                    newViewController.hotenNTT = results.nameSender
                    newViewController.otp = self.otp
                    newViewController.keyotp = self.key_otp
                    newViewController.fee = Double(results.trans_fee) ?? 0
                    newViewController.note = self.tfGhiChu.text ?? ""
                    newViewController.money = Double(results.amount) ?? 0
                    
                    if self.config == .yourself{
                        newViewController.isSwitch = true
                    }else{
                        newViewController.isSwitch = false
                    }
        
                    newViewController.fee = Double(results.trans_fee) ?? 0
                  
                    self.navigationController?.pushViewController(newViewController, animated: true)
                    
                    
                    
                    
                }else{
                 
                    self.showPopUp(err, "Thông báo", buttonTitle: "OK")
                }
            }
        }
    }
    
}
// MARK: - RechargeMoneyViettelPayConfiguration

enum RechargeMoneyViettelPayConfiguration{
    case yourself
    case everyone
}
