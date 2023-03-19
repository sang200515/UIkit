//
//  ViewSODetailViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/7/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import DLRadioButton
import SkyFloatingLabelTextField
class ViewSODetailViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate{
    
    var carts:[Cart] = []
    var itemsPromotion: [ProductPromotions] = []
    var phone: String = ""
    var name: String = ""
    var address: String = ""
    var email: String = ""
    var note: String = ""
    var type: String = ""
    var payment: String = ""
    var docEntry: String = ""
    var phoneNumberBookSim = ""
    var gender:Int = 0
    var birthday:String = ""
    
    var scrollView:UIScrollView!
    var tfPhoneNumber:SkyFloatingLabelTextFieldWithIcon!
    var tfUserName:SkyFloatingLabelTextFieldWithIcon!
    var tfUserAddress:SkyFloatingLabelTextFieldWithIcon!
    var tfUserEmail:SkyFloatingLabelTextFieldWithIcon!
    
    var taskNotes: UITextView!
    var placeholderLabel : UILabel!
    
    var orderType:Int = -1
    var orderPayType:Int = -1
    var orderPayInstallment:Int = -1
    
    var radioAtTheCounter:DLRadioButton!
    var radioInstallment:DLRadioButton!
    var radioDeposit:DLRadioButton!
    var radioPayNow:DLRadioButton!
    var radioPayNotNow:DLRadioButton!
    
    var radioPayInstallmentCom:DLRadioButton!
    var radioPayInstallmentCard:DLRadioButton!
    
    var listImei:[UILabel] = []
    
    var lbPayType:UILabel!
    
    var viewInstallment:UIView!
    var viewInstallmentHeight: CGFloat = 0.0
    
    var viewInfoDetail: UIView!
    
    var tfInterestRate:UITextField!
    var tfPrepay:UITextField!
    
    var valueInterestRate:Float = 0
    var valuePrepay:Float = 0
    
    var tfVoucher:UITextField!
    
    var isActiveSim:Bool = false
    var isBookSim:Bool = false
    var debitCustomer:DebitCustomer?
    
    var viewInstallmentCard:UIView!
    var viewInstallmentCom:UIView!
    var companyButton: SearchTextField!
    
    var tfPrepayCom,tfContractNumber,tfCMND,tfInterestRateCom,tfLimit:UITextField!
    
    var radioMan:DLRadioButton!
    var radioWoman:DLRadioButton!
    var tfUserBirthday:SkyFloatingLabelTextFieldWithIcon!
    override func viewDidLoad() {
        super.viewDidLoad()
        isActiveSim = false
        self.view.backgroundColor = .white
        self.title = "Đơn hàng \(docEntry)"
        self.initNavigationBar()
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        self.setupUI()
        
        
    }
    func setupUI() {
        
        
        let lbUserInfo = UILabel(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:18)))
        lbUserInfo.textAlignment = .left
        lbUserInfo.textColor = UIColor(netHex:0x04AB6E)
        lbUserInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbUserInfo.text = "THÔNG TIN KHÁCH HÀNG"
        scrollView.addSubview(lbUserInfo)
        
        //input phone number
        tfPhoneNumber = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:20), y: lbUserInfo.frame.origin.y + lbUserInfo.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)), iconType: .image)
        tfPhoneNumber.placeholder = "Nhập số điện thoại"
        tfPhoneNumber.title = "Số điện thoại"
        tfPhoneNumber.iconImage = UIImage(named: "phone_number")
        tfPhoneNumber.tintColor = UIColor(netHex:0x04AB6E)
        tfPhoneNumber.lineColor = UIColor.gray
        tfPhoneNumber.selectedTitleColor = UIColor(netHex:0x04AB6E)
        tfPhoneNumber.selectedLineColor = UIColor(netHex:0x04AB6E)
        tfPhoneNumber.lineHeight = 0.5
        tfPhoneNumber.selectedLineHeight = 0.5
        tfPhoneNumber.clearButtonMode = .whileEditing
        tfPhoneNumber.delegate = self
        tfPhoneNumber.text = phone
        scrollView.addSubview(tfPhoneNumber)
        tfPhoneNumber.isUserInteractionEnabled = false
        
        //input name info
        tfUserName = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: tfPhoneNumber.frame.origin.x, y: tfPhoneNumber.frame.origin.y + tfPhoneNumber.frame.size.height + Common.Size(s:10), width: tfPhoneNumber.frame.size.width , height: tfPhoneNumber.frame.size.height ), iconType: .image);
        tfUserName.placeholder = "Nhập họ tên"
        tfUserName.title = "Tên khách hàng"
        tfUserName.iconImage = UIImage(named: "name")
        tfUserName.tintColor = UIColor(netHex:0x04AB6E)
        tfUserName.lineColor = UIColor.gray
        tfUserName.selectedTitleColor = UIColor(netHex:0x04AB6E)
        tfUserName.selectedLineColor = UIColor(netHex:0x04AB6E)
        tfUserName.lineHeight = 0.5
        tfUserName.selectedLineHeight = 0.5
        tfUserName.clearButtonMode = .whileEditing
        tfUserName.delegate = self
        tfUserName.text = name
        scrollView.addSubview(tfUserName)
        tfUserName.isUserInteractionEnabled = false
        
        //input address
        tfUserAddress = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: tfUserName.frame.origin.x, y: tfUserName.frame.origin.y + tfUserName.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width , height: tfUserName.frame.size.height ), iconType: .image);
        tfUserAddress.placeholder = "Nhập địa chỉ"
        tfUserAddress.title = "Địa chỉ"
        tfUserAddress.iconImage = UIImage(named: "address")
        tfUserAddress.tintColor = UIColor(netHex:0x04AB6E)
        tfUserAddress.lineColor = UIColor.gray
        tfUserAddress.selectedTitleColor = UIColor(netHex:0x04AB6E)
        tfUserAddress.selectedLineColor = UIColor(netHex:0x04AB6E)
        tfUserAddress.lineHeight = 0.5
        tfUserAddress.selectedLineHeight = 0.5
        tfUserAddress.clearButtonMode = .whileEditing
        tfUserAddress.delegate = self
        scrollView.addSubview(tfUserAddress)
        tfUserAddress.text = address
        tfUserAddress.isUserInteractionEnabled = false
        
        //input email
        tfUserEmail = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: tfUserAddress.frame.origin.x, y: tfUserAddress.frame.origin.y + tfUserAddress.frame.size.height + Common.Size(s:10), width: tfUserAddress.frame.size.width , height: tfUserAddress.frame.size.height ), iconType: .image);
        tfUserEmail.placeholder = "Nhập email"
        tfUserEmail.title = "Email"
        tfUserEmail.iconImage = UIImage(named: "email")
        tfUserEmail.tintColor = UIColor(netHex:0x04AB6E)
        tfUserEmail.lineColor = UIColor.gray
        tfUserEmail.selectedTitleColor = UIColor(netHex:0x04AB6E)
        tfUserEmail.selectedLineColor = UIColor(netHex:0x04AB6E)
        tfUserEmail.lineHeight = 0.5
        tfUserEmail.selectedLineHeight = 0.5
        tfUserEmail.clearButtonMode = .whileEditing
        tfUserEmail.delegate = self
        scrollView.addSubview(tfUserEmail)
        tfUserEmail.text = email
        tfUserEmail.isUserInteractionEnabled = false
        
        
        //input email
        tfUserBirthday = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: tfUserAddress.frame.origin.x, y: tfUserEmail.frame.origin.y + tfUserEmail.frame.size.height + Common.Size(s:10), width: tfUserAddress.frame.size.width , height: tfUserAddress.frame.size.height ), iconType: .image);
        tfUserBirthday.placeholder = "Nhập ngày sinh"
        tfUserBirthday.title = "Ngày sinh"
        tfUserBirthday.iconImage = UIImage(named: "birthday")
        tfUserBirthday.tintColor = UIColor(netHex:0x04AB6E)
        tfUserBirthday.lineColor = UIColor.gray
        tfUserBirthday.selectedTitleColor = UIColor(netHex:0x04AB6E)
        tfUserBirthday.selectedLineColor = UIColor(netHex:0x04AB6E)
        tfUserBirthday.lineHeight = 0.5
        tfUserBirthday.selectedLineHeight = 0.5
        tfUserBirthday.clearButtonMode = .whileEditing
        tfUserBirthday.delegate = self
        scrollView.addSubview(tfUserBirthday)
        tfUserBirthday.text = birthday
        tfUserBirthday.isUserInteractionEnabled = false
        
        let lbGenderText = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: tfUserBirthday.frame.origin.y + tfUserBirthday.frame.size.height + Common.Size(s:10), width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbGenderText.textAlignment = .left
        lbGenderText.textColor = UIColor.black
        lbGenderText.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbGenderText.text = "Giới tính"
        scrollView.addSubview(lbGenderText)
        
        radioMan = createRadioButtonGender(CGRect(x: lbGenderText.frame.origin.x,y:lbGenderText.frame.origin.y + lbGenderText.frame.size.height + Common.Size(s:5) , width: lbGenderText.frame.size.width/3, height: Common.Size(s:20)), title: "Nam", color: UIColor.black);
        scrollView.addSubview(radioMan)
        
        radioWoman = createRadioButtonGender(CGRect(x: radioMan.frame.origin.x + radioMan.frame.size.width ,y:radioMan.frame.origin.y, width: radioMan.frame.size.width, height: radioMan.frame.size.height), title: "Nữ", color: UIColor.black);
        scrollView.addSubview(radioWoman)
        
        if (gender == 1){
            radioMan.isSelected = true
            radioWoman.isEnabled = false
        }else if (gender == 0){
            radioWoman.isSelected = true
            radioMan.isEnabled = false
        }else{
            radioMan.isEnabled = false
            radioWoman.isEnabled = false
        }
        //tilte choose type
        let lbCartType = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: radioMan.frame.origin.y + radioMan.frame.size.height+Common.Size(s:20), width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbCartType.textAlignment = .left
        lbCartType.textColor = UIColor(netHex:0x04AB6E)
        lbCartType.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbCartType.text = "LOẠI ĐƠN HÀNG"
        scrollView.addSubview(lbCartType)
        
        radioAtTheCounter = createRadioButton(CGRect(x: lbCartType.frame.origin.x, y: lbCartType.frame.origin.y + lbCartType.frame.size.height+Common.Size(s:10), width: lbCartType.frame.size.width/3, height: Common.Size(s:18)), title: "Tại quầy", color: UIColor.black);
        scrollView.addSubview(radioAtTheCounter)
        
        radioInstallment = createRadioButton(CGRect(x: radioAtTheCounter.frame.origin.x + radioAtTheCounter.frame.size.width, y: radioAtTheCounter.frame.origin.y , width: radioAtTheCounter.frame.size.width, height: radioAtTheCounter.frame.size.height), title: "Trả góp", color: UIColor.black);
        scrollView.addSubview(radioInstallment)
        
        radioDeposit = createRadioButton(CGRect(x: radioInstallment.frame.origin.x + radioInstallment.frame.size.width, y: radioAtTheCounter.frame.origin.y , width: radioInstallment.frame.size.width, height: radioInstallment.frame.size.height), title: "Đặt cọc", color: UIColor.black);
        scrollView.addSubview(radioDeposit)
        
        if (orderType == 1){
            radioAtTheCounter.isSelected = true
            orderType = 1
            radioInstallment.isEnabled = false
            radioDeposit.isEnabled = false
        }else if (orderType == 2){
            radioInstallment.isSelected = true
            orderType = 2
            radioAtTheCounter.isEnabled = false
            radioDeposit.isEnabled = false
        }else if (orderType == 3){
            radioDeposit.isSelected = true
            orderType = 3
            radioAtTheCounter.isEnabled = false
            radioInstallment.isEnabled = false
        }
        
        
        
        viewInstallment = UIView(frame: CGRect(x: tfUserEmail.frame.origin.x, y: radioAtTheCounter.frame.origin.y  + radioAtTheCounter.frame.size.height + Common.Size(s:20), width: tfUserEmail.frame.size.width, height: 0))
        
        //tilte choose type pay
        let lbPayInstallment = UILabel(frame: CGRect(x: 0, y: 0, width: viewInstallment.frame.size.width, height: Common.Size(s:18)))
        lbPayInstallment.textAlignment = .left
        lbPayInstallment.textColor = UIColor(netHex:0x04AB6E)
        lbPayInstallment.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbPayInstallment.text = "LOẠI CHƯƠNG TRÌNH"
        viewInstallment.addSubview(lbPayInstallment)
        
        radioPayInstallmentCom = createRadioButtonPayInstallment(CGRect(x: 0 ,y:lbPayInstallment.frame.origin.y + lbPayInstallment.frame.size.height + Common.Size(s:10) , width: viewInstallment.frame.size.width/2, height: radioInstallment.frame.size.height), title: "Nhà trả góp", color: UIColor.black);
        viewInstallment.addSubview(radioPayInstallmentCom)
        
        radioPayInstallmentCard = createRadioButtonPayInstallment(CGRect(x: viewInstallment.frame.size.width/2,y:lbPayInstallment.frame.origin.y + lbPayInstallment.frame.size.height + Common.Size(s:10) , width: lbPayInstallment.frame.size.width/2, height: radioAtTheCounter.frame.size.height), title: "Thẻ", color: UIColor.black);
        viewInstallment.addSubview(radioPayInstallmentCard)
        
        
        viewInstallmentCom = UIView(frame: CGRect(x:0,y:radioPayInstallmentCom.frame.size.height + radioPayInstallmentCom.frame.origin.y + Common.Size(s: 10),width:viewInstallment.frame.size.width,height:0))
        viewInstallmentCom.backgroundColor = .white
        viewInstallmentCom.clipsToBounds = true
        viewInstallment.addSubview(viewInstallmentCom)
        
        let lbTextCompany = UILabel(frame: CGRect(x: 0, y: 0, width: viewInstallmentCom.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCompany.textAlignment = .left
        lbTextCompany.textColor = UIColor.black
        lbTextCompany.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbTextCompany.text = "Nhà trả góp"
        viewInstallmentCom.addSubview(lbTextCompany)
        
        companyButton = SearchTextField(frame: CGRect(x: lbTextCompany.frame.origin.x, y: lbTextCompany.frame.origin.y + lbTextCompany.frame.size.height + Common.Size(s:10), width: viewInstallmentCom.frame.size.width, height: Common.Size(s:40)));
        
        companyButton.placeholder = "Chọn nhà trả góp"
        companyButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.borderStyle = UITextField.BorderStyle.roundedRect
        companyButton.autocorrectionType = UITextAutocorrectionType.no
        companyButton.keyboardType = UIKeyboardType.default
        companyButton.returnKeyType = UIReturnKeyType.done
        companyButton.clearButtonMode = UITextField.ViewMode.whileEditing
        companyButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        companyButton.delegate = self
        viewInstallmentCom.addSubview(companyButton)
        
        if let debitCustomer = debitCustomer{
            companyButton.text = debitCustomer.TenCty
        }
        companyButton.isEnabled = false
        companyButton.startVisible = true
        companyButton.theme.bgColor = UIColor.white
        companyButton.theme.fontColor = UIColor.black
        companyButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.theme.cellHeight = Common.Size(s:40)
        companyButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        let lbTextLimit = UILabel(frame: CGRect(x: 0, y: companyButton.frame.size.height + companyButton.frame.origin.y + Common.Size(s:10), width: (viewInstallmentCom.frame.size.width - Common.Size(s:20))/2, height: Common.Size(s:14)))
        lbTextLimit.textAlignment = .left
        lbTextLimit.textColor = UIColor.black
        lbTextLimit.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbTextLimit.text = "Kỳ hạn"
        viewInstallmentCom.addSubview(lbTextLimit)
        
        tfLimit = UITextField(frame: CGRect(x:0, y: lbTextLimit.frame.size.height + lbTextLimit.frame.origin.y + Common.Size(s:5), width: lbTextLimit.frame.size.width, height: Common.Size(s:40)))
        tfLimit.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfLimit.borderStyle = UITextField.BorderStyle.roundedRect
        tfLimit.autocorrectionType = UITextAutocorrectionType.no
        tfLimit.keyboardType = UIKeyboardType.numberPad
        tfLimit.returnKeyType = UIReturnKeyType.done
        tfLimit.clearButtonMode = UITextField.ViewMode.whileEditing
        tfLimit.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfLimit.delegate = self
        tfLimit.placeholder = "Nhập kỳ hạn"
        viewInstallmentCom.addSubview(tfLimit)
        
        if let debitCustomer = debitCustomer{
            tfLimit.text = "\(debitCustomer.TenureOfLoan)"
        }
        tfLimit.isEnabled = false
        let lbTextInterestRate = UILabel(frame: CGRect(x: viewInstallmentCom.frame.size.width/2 + Common.Size(s:10) , y: lbTextLimit.frame.origin.y, width: (viewInstallmentCom.frame.size.width - Common.Size(s:20))/2, height: Common.Size(s:14)))
        lbTextInterestRate.textAlignment = .left
        lbTextInterestRate.textColor = UIColor.black
        lbTextInterestRate.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbTextInterestRate.text = "Lãi suất"
        viewInstallmentCom.addSubview(lbTextInterestRate)
        
        tfInterestRateCom = UITextField(frame: CGRect(x:lbTextInterestRate.frame.origin.x, y: lbTextLimit.frame.size.height + lbTextLimit.frame.origin.y + Common.Size(s:5), width: lbTextLimit.frame.size.width, height: Common.Size(s:40)))
        tfInterestRateCom.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfInterestRateCom.borderStyle = UITextField.BorderStyle.roundedRect
        tfInterestRateCom.autocorrectionType = UITextAutocorrectionType.no
        tfInterestRateCom.keyboardType = UIKeyboardType.decimalPad
        tfInterestRateCom.returnKeyType = UIReturnKeyType.done
        tfInterestRateCom.clearButtonMode = UITextField.ViewMode.whileEditing
        tfInterestRateCom.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfInterestRateCom.delegate = self
        tfInterestRateCom.placeholder = "Nhập lãi suất"
        viewInstallmentCom.addSubview(tfInterestRateCom)
        
        if let debitCustomer = debitCustomer{
            tfInterestRateCom.text = "\(debitCustomer.Interestrate)"
        }
        tfInterestRateCom.isEnabled = false
        
        let lbTextCMND = UILabel(frame: CGRect(x: 0, y: tfLimit.frame.size.height + tfLimit.frame.origin.y + Common.Size(s:10), width: tfLimit.frame.size.width, height: Common.Size(s:14)))
        lbTextCMND.textAlignment = .left
        lbTextCMND.textColor = UIColor.black
        lbTextCMND.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbTextCMND.text = "CMND"
        viewInstallmentCom.addSubview(lbTextCMND)
        
        
        tfCMND = UITextField(frame: CGRect(x:0, y: lbTextCMND.frame.size.height + lbTextCMND.frame.origin.y + Common.Size(s:5), width: lbTextCMND.frame.size.width, height: Common.Size(s:40)))
        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMND.autocorrectionType = UITextAutocorrectionType.no
        tfCMND.keyboardType = UIKeyboardType.numberPad
        tfCMND.returnKeyType = UIReturnKeyType.done
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMND.delegate = self
        tfCMND.placeholder = "Nhập CMND"
        viewInstallmentCom.addSubview(tfCMND)
        
        
        if let debitCustomer = debitCustomer{
            tfCMND.text = "\(debitCustomer.CustomerIdCard)"
        }
        tfCMND.isEnabled = false
        
        let lbTextContractNumber = UILabel(frame: CGRect(x: lbTextInterestRate.frame.origin.x, y: lbTextCMND.frame.origin.y, width: lbTextCMND.frame.size.width, height: Common.Size(s:14)))
        lbTextContractNumber.textAlignment = .left
        lbTextContractNumber.textColor = UIColor.black
        lbTextContractNumber.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbTextContractNumber.text = "Số hợp đồng"
        viewInstallmentCom.addSubview(lbTextContractNumber)
        
        tfContractNumber = UITextField(frame: CGRect(x:lbTextContractNumber.frame.origin.x, y:tfCMND.frame.origin.y , width: tfCMND.frame.size.width, height: Common.Size(s:40)))
        tfContractNumber.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        tfContractNumber.borderStyle = UITextField.BorderStyle.roundedRect
        tfContractNumber.autocorrectionType = UITextAutocorrectionType.no
        tfContractNumber.keyboardType = UIKeyboardType.default
        tfContractNumber.returnKeyType = UIReturnKeyType.done
        tfContractNumber.clearButtonMode = UITextField.ViewMode.whileEditing
        tfContractNumber.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfContractNumber.delegate = self
        tfContractNumber.placeholder = "Nhập số HĐ"
        viewInstallmentCom.addSubview(tfContractNumber)
        tfContractNumber.isEnabled = false
        
        if let debitCustomer = debitCustomer{
            tfContractNumber.text = "\(debitCustomer.ContractNo_AgreementNo)"
        }
        
        let lbTextPrepay = UILabel(frame: CGRect(x: 0, y: tfContractNumber.frame.origin.y + tfContractNumber.frame.size.height + Common.Size(s:10), width: viewInstallmentCom.frame.size.width, height: Common.Size(s:14)))
        lbTextPrepay.textAlignment = .left
        lbTextPrepay.textColor = UIColor.black
        lbTextPrepay.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbTextPrepay.text = "Số tiền trả trước"
        viewInstallmentCom.addSubview(lbTextPrepay)
        
        tfPrepayCom = UITextField(frame: CGRect(x:0, y:lbTextPrepay.frame.origin.y + lbTextPrepay.frame.size.height + Common.Size(s:5), width: viewInstallmentCom.frame.size.width, height: Common.Size(s:40)))
        tfPrepayCom.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPrepayCom.borderStyle = UITextField.BorderStyle.roundedRect
        tfPrepayCom.autocorrectionType = UITextAutocorrectionType.no
        tfPrepayCom.keyboardType = UIKeyboardType.numberPad
        tfPrepayCom.returnKeyType = UIReturnKeyType.done
        tfPrepayCom.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPrepayCom.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPrepayCom.delegate = self
        tfPrepayCom.placeholder = "Nhập số tiền trả trước"
        viewInstallmentCom.addSubview(tfPrepayCom)
        tfPrepayCom.isEnabled = false
        
        if let debitCustomer = debitCustomer{
            tfPrepayCom.text = "\(Common.convertCurrencyFloatV2(value: debitCustomer.DownPaymentAmount))"
        }
        
        viewInstallmentCard = UIView(frame: CGRect(x:0,y:radioPayInstallmentCom.frame.size.height + radioPayInstallmentCom.frame.origin.y + Common.Size(s: 10),width:viewInstallment.frame.size.width,height:0))
        viewInstallment.addSubview(viewInstallmentCard)
        viewInstallmentCard.clipsToBounds = true
        
        tfInterestRate = UITextField(frame: CGRect(x: 0, y: Common.Size(s:10), width: tfUserAddress.frame.size.width , height: tfUserAddress.frame.size.height ));
        tfInterestRate.placeholder = "Lãi suất"
        tfInterestRate.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfInterestRate.borderStyle = UITextField.BorderStyle.roundedRect
        tfInterestRate.autocorrectionType = UITextAutocorrectionType.no
        tfInterestRate.keyboardType = UIKeyboardType.decimalPad
        tfInterestRate.returnKeyType = UIReturnKeyType.done
        tfInterestRate.clearButtonMode = UITextField.ViewMode.whileEditing
        tfInterestRate.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfInterestRate.delegate = self
        viewInstallmentCard.addSubview(tfInterestRate)
        tfInterestRate.text = "\(valueInterestRate)"
        
        tfPrepay = UITextField(frame: CGRect(x: 0, y: tfInterestRate.frame.origin.y + tfInterestRate.frame.size.height + Common.Size(s:10), width: tfUserAddress.frame.size.width , height: tfUserAddress.frame.size.height ));
        tfPrepay.placeholder = "Trả trước"
        tfPrepay.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPrepay.borderStyle = UITextField.BorderStyle.roundedRect
        tfPrepay.autocorrectionType = UITextAutocorrectionType.no
        tfPrepay.keyboardType = UIKeyboardType.decimalPad
        tfPrepay.returnKeyType = UIReturnKeyType.done
        tfPrepay.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPrepay.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPrepay.delegate = self
        viewInstallmentCard.addSubview(tfPrepay)
        tfPrepay.text = "\(valuePrepay)"
        
        if(orderPayInstallment == 0){
            radioPayInstallmentCom.isSelected = true
            radioPayInstallmentCard.isEnabled = false
            viewInstallmentCom.frame.size.height = tfPrepayCom.frame.size.height + tfPrepayCom.frame.origin.y + Common.Size(s:20)
            viewInstallment.frame.size.height = viewInstallmentCom.frame.size.height + viewInstallmentCom.frame.origin.y
            
        }else if (orderPayInstallment == 1){
            radioPayInstallmentCard.isSelected = true
            radioPayInstallmentCom.isEnabled = false
            viewInstallmentCard.frame.size.height = tfPrepay.frame.size.height + tfPrepay.frame.origin.y + Common.Size(s:20)
            viewInstallment.frame.size.height = viewInstallmentCard.frame.size.height + viewInstallmentCard.frame.origin.y
        }
        
        
        viewInstallmentHeight = viewInstallment.frame.size.height
        scrollView.addSubview(viewInstallment)
        viewInstallment.clipsToBounds = true
        if (orderType != 2){
            viewInstallment.frame.size.height = 0
        }
        viewInfoDetail = UIView(frame: CGRect(x: 0, y: viewInstallment.frame.origin.y  + viewInstallment.frame.size.height, width: self.view.frame.size.width, height: 0))
        
        //tilte choose type pay
        lbPayType = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: 0, width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbPayType.textAlignment = .left
        lbPayType.textColor = UIColor(netHex:0x04AB6E)
        lbPayType.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbPayType.text = "LOẠI THANH TOÁN"
        viewInfoDetail.addSubview(lbPayType)
        
        radioPayNow = createRadioButtonPayType(CGRect(x: radioAtTheCounter.frame.origin.x,y:lbPayType.frame.origin.y + lbPayType.frame.size.height + Common.Size(s:10) , width: lbPayType.frame.size.width/2, height: radioAtTheCounter.frame.size.height), title: "Trực tiếp", color: UIColor.black);
        viewInfoDetail.addSubview(radioPayNow)
        
        radioPayNotNow = createRadioButtonPayType(CGRect(x: radioInstallment.frame.origin.x ,y:radioPayNow.frame.origin.y, width: radioPayNow.frame.size.width, height: radioPayNow.frame.size.height), title: "Khác", color: UIColor.black);
        viewInfoDetail.addSubview(radioPayNotNow)
        
        if (orderPayType == 1){
            radioPayNow.isSelected = true
            radioPayNotNow.isEnabled = false
        }else if (orderPayType == 2){
            radioPayNotNow.isSelected = true
            radioPayNow.isEnabled = false
        }
        let viewVoucher = UIView(frame: CGRect(x:0,y:radioPayNotNow.frame.origin.y + radioPayNotNow.frame.size.height + Common.Size(s:10),width:viewInfoDetail.frame.size.width,height:100))
        
        viewInfoDetail.addSubview(viewVoucher)
        
        let  lbVoucher = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: Common.Size(s:0), width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbVoucher.textAlignment = .left
        lbVoucher.textColor = UIColor(netHex:0x04AB6E)
        lbVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbVoucher.text = "VOUCHER KHÔNG GIÁ"
        viewVoucher.addSubview(lbVoucher)
        
        let viewVoucherLine = UIView(frame: CGRect(x:Common.Size(s:20),y:lbVoucher.frame.origin.y + lbVoucher.frame.size.height + Common.Size(s:10),width:viewInfoDetail.frame.size.width - Common.Size(s:40),height:100))
        viewVoucher.addSubview(viewVoucherLine)
        
        let line1Voucher = UIView(frame: CGRect(x: viewVoucherLine.frame.size.width * 1.3/10, y: 0, width: 1, height: Common.Size(s:25)))
        line1Voucher.backgroundColor = UIColor(netHex:0x04AB6E)
        viewVoucherLine.addSubview(line1Voucher)
        let line2Voucher = UIView(frame: CGRect(x: 0, y:line1Voucher.frame.origin.y + line1Voucher.frame.size.height, width: viewVoucherLine.frame.size.width, height: 1))
        line2Voucher.backgroundColor = UIColor(netHex:0x04AB6E)
        viewVoucherLine.addSubview(line2Voucher)
        
        let lbSttVoucher = UILabel(frame: CGRect(x: 0, y: line1Voucher.frame.origin.y, width: line1Voucher.frame.origin.x, height: line1Voucher.frame.size.height))
        lbSttVoucher.textAlignment = .center
        lbSttVoucher.textColor = UIColor(netHex:0x04AB6E)
        lbSttVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbSttVoucher.text = "STT"
        viewVoucherLine.addSubview(lbSttVoucher)
        
        let lbInfoVoucher = UILabel(frame: CGRect(x: line1Voucher.frame.origin.x, y: line1Voucher.frame.origin.y, width: viewVoucherLine.frame.size.width - line1Voucher.frame.origin.x, height: line1Voucher.frame.size.height))
        lbInfoVoucher.textAlignment = .center
        lbInfoVoucher.textColor = UIColor(netHex:0x04AB6E)
        lbInfoVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbInfoVoucher.text = "Mã voucher"
        viewVoucherLine.addSubview(lbInfoVoucher)
        
        var indexYVoucher = line2Voucher.frame.origin.y
        var indexHeightVoucher: CGFloat = line2Voucher.frame.origin.y + line2Voucher.frame.size.height
        var numVoucher = 0
        for item in Cache.listVoucherTemp{
            numVoucher = numVoucher + 1
            let soViewLine = UIView()
            viewVoucherLine.addSubview(soViewLine)
            soViewLine.frame = CGRect(x: 0, y: indexYVoucher, width: viewVoucherLine.frame.size.width, height: Common.Size(s:40))
            
            let line3 = UIView(frame: CGRect(x: line1Voucher.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
            line3.backgroundColor = UIColor(netHex:0x04AB6E)
            soViewLine.addSubview(line3)
            
            let nameProduct = "\(item)"
            let lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: 0, width: viewVoucherLine.frame.size.width - line3.frame.origin.x -  soViewLine.frame.size.height, height: Common.Size(s:40)))
            lbNameProduct.textAlignment = .left
            lbNameProduct.textColor = UIColor.black
            lbNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbNameProduct.text = nameProduct
            lbNameProduct.numberOfLines = 3
            soViewLine.addSubview(lbNameProduct)
            
            let line4 = UIView(frame: CGRect(x: line3.frame.origin.x, y:0, width: viewVoucherLine.frame.size.width - line3.frame.origin.x - 1, height: 1))
            line4.backgroundColor = UIColor(netHex:0x04AB6E)
            soViewLine.addSubview(line4)
            
            let lbSttValue = UILabel(frame: CGRect(x: 0, y: 0, width: lbSttVoucher.frame.size.width, height: Common.Size(s:40)))
            lbSttValue.textAlignment = .center
            lbSttValue.textColor = UIColor.black
            lbSttValue.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbSttValue.text = "\(numVoucher)"
            soViewLine.addSubview(lbSttValue)
            
            indexHeightVoucher = indexHeightVoucher + soViewLine.frame.size.height
            indexYVoucher = indexYVoucher + soViewLine.frame.size.height + soViewLine.frame.origin.x
            
        }
        viewVoucherLine.frame.size.height = indexHeightVoucher
        if(Cache.listVoucherTemp.count == 0){
            viewVoucherLine.frame.size.height = 0
            viewVoucherLine.clipsToBounds = true
        }
        
        
        viewVoucher.frame.size.height =  viewVoucherLine.frame.size.height + viewVoucherLine.frame.origin.y
        
        let lbNotes = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: viewVoucher.frame.origin.y  + viewVoucher.frame.size.height + Common.Size(s:20), width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbNotes.textAlignment = .left
        lbNotes.textColor = UIColor(netHex:0x04AB6E)
        lbNotes.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbNotes.text = "GHI CHÚ"
        viewInfoDetail.addSubview(lbNotes)
        
        taskNotes = UITextView(frame: CGRect(x: radioAtTheCounter.frame.origin.x , y: lbNotes.frame.origin.y  + lbNotes.frame.size.height + Common.Size(s:10), width: lbCartType.frame.size.width, height: tfUserEmail.frame.size.height * 2 ))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        taskNotes.layer.borderWidth = 0.5
        taskNotes.layer.borderColor = borderColor.cgColor
        taskNotes.layer.cornerRadius = 5.0
        taskNotes.delegate = self
        taskNotes.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        viewInfoDetail.addSubview(taskNotes)
        taskNotes.text = "\(note)"
        taskNotes.isEditable = false
        placeholderLabel = UILabel()
        placeholderLabel.text = "Ghi chú đơn hàng"
        placeholderLabel.font = UIFont.systemFont(ofSize: (taskNotes.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        taskNotes.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (taskNotes.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !taskNotes.text.isEmpty
        
        let soViewPhone = UIView()
        viewInfoDetail.addSubview(soViewPhone)
        soViewPhone.frame = CGRect(x: taskNotes.frame.origin.x, y: taskNotes.frame.origin.y + taskNotes.frame.size.height + Common.Size(s:20), width: taskNotes.frame.size.width, height: 100)
        
        let lbSODetail = UILabel(frame: CGRect(x: 0, y: 0, width: soViewPhone.frame.size.width, height: Common.Size(s:18)))
        lbSODetail.textAlignment = .left
        lbSODetail.textColor = UIColor(netHex:0x04AB6E)
        lbSODetail.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbSODetail.text = "THÔNG TIN ĐƠN HÀNG"
        soViewPhone.addSubview(lbSODetail)
        
        let line1 = UIView(frame: CGRect(x: soViewPhone.frame.size.width * 1.3/10, y:lbSODetail.frame.origin.y + lbSODetail.frame.size.height + Common.Size(s:10), width: 1, height: Common.Size(s:25)))
        line1.backgroundColor = UIColor(netHex:0x04AB6E)
        soViewPhone.addSubview(line1)
        let line2 = UIView(frame: CGRect(x: 0, y:line1.frame.origin.y + line1.frame.size.height, width: soViewPhone.frame.size.width, height: 1))
        line2.backgroundColor = UIColor(netHex:0x04AB6E)
        soViewPhone.addSubview(line2)
        
        let lbStt = UILabel(frame: CGRect(x: 0, y: line1.frame.origin.y, width: line1.frame.origin.x, height: line1.frame.size.height))
        lbStt.textAlignment = .center
        lbStt.textColor = UIColor(netHex:0x04AB6E)
        lbStt.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbStt.text = "STT"
        soViewPhone.addSubview(lbStt)
        
        let lbInfo = UILabel(frame: CGRect(x: line1.frame.origin.x, y: line1.frame.origin.y, width: lbSODetail.frame.size.width - line1.frame.origin.x, height: line1.frame.size.height))
        lbInfo.textAlignment = .center
        lbInfo.textColor = UIColor(netHex:0x04AB6E)
        lbInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbInfo.text = "Sản phẩm"
        soViewPhone.addSubview(lbInfo)
        
        var indexY = line2.frame.origin.y
        var indexHeight: CGFloat = line2.frame.origin.y + line2.frame.size.height
        var num = 0
        var totalPay:Float = 0.0
        for item in carts{
            num = num + 1
            totalPay = totalPay + (item.product.price * Float(item.quantity))
            let soViewLine = UIView()
            soViewPhone.addSubview(soViewLine)
            soViewLine.frame = CGRect(x: 0, y: indexY, width: soViewPhone.frame.size.width, height: 50)
            let line3 = UIView(frame: CGRect(x: line1.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
            line3.backgroundColor = UIColor(netHex:0x04AB6E)
            soViewLine.addSubview(line3)
            
            let nameProduct = "\(item.product.name)"
            let sizeNameProduct = nameProduct.height(withConstrainedWidth: soViewPhone.frame.size.width - line3.frame.origin.x, font: UIFont.systemFont(ofSize: Common.Size(s:14)))
            let lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: 3, width: soViewPhone.frame.size.width - line3.frame.origin.x, height: sizeNameProduct))
            lbNameProduct.textAlignment = .left
            lbNameProduct.textColor = UIColor.black
            lbNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbNameProduct.text = nameProduct
            lbNameProduct.numberOfLines = 3
            soViewLine.addSubview(lbNameProduct)
            
            let line4 = UIView(frame: CGRect(x: line3.frame.origin.x, y:0, width: soViewPhone.frame.size.width - line3.frame.origin.x - 1, height: 1))
            line4.backgroundColor = UIColor(netHex:0x04AB6E)
            soViewLine.addSubview(line4)
            
            let lbQuantityProduct = UILabel(frame: CGRect(x: lbNameProduct.frame.origin.x , y: lbNameProduct.frame.origin.y + lbNameProduct.frame.size.height + Common.Size(s:5), width: lbNameProduct.frame.size.width, height: Common.Size(s:14)))
            lbQuantityProduct.textAlignment = .left
            lbQuantityProduct.textColor = UIColor.black
            lbQuantityProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            if (item.product.qlSerial == "Y"){
                lbQuantityProduct.text = "IMEI: \((item.imei))"
            }else{
                if (item.product.id == 2 || item.product.id == 3){
                    lbQuantityProduct.text = "IMEI: \((item.imei))"
                }else{
                    lbQuantityProduct.text = "Số lượng: \((item.quantity))"
                }
            }
            if(item.sku == "00503355"){
                lbQuantityProduct.text = "SĐT: \((phoneNumberBookSim))"
                isBookSim = true
            }
            listImei.append(lbQuantityProduct)
            
            lbQuantityProduct.numberOfLines = 1
            soViewLine.addSubview(lbQuantityProduct)
            
            let lbPriceProduct = UILabel(frame: CGRect(x: lbQuantityProduct.frame.origin.x , y: lbQuantityProduct.frame.origin.y + lbQuantityProduct.frame.size.height + Common.Size(s:5), width: lbQuantityProduct.frame.size.width, height: Common.Size(s:14)))
            lbPriceProduct.textAlignment = .left
            lbPriceProduct.textColor = UIColor(netHex:0xEF4A40)
            lbPriceProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbPriceProduct.text = "Giá: \(Common.convertCurrencyFloat(value: (item.product.price)))"
            lbPriceProduct.numberOfLines = 1
            soViewLine.addSubview(lbPriceProduct)
            
            
            let lbSttValue = UILabel(frame: CGRect(x: 0, y: 0, width: lbStt.frame.size.width, height: lbStt.frame.size.height))
            lbSttValue.textAlignment = .center
            lbSttValue.textColor = UIColor.black
            lbSttValue.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbSttValue.text = "\(num)"
            soViewLine.addSubview(lbSttValue)
            
            soViewLine.frame = CGRect(x: soViewLine.frame.origin.x, y: soViewLine.frame.origin.y, width: soViewLine.frame.size.width, height: lbPriceProduct.frame.origin.y + lbPriceProduct.frame.size.height + Common.Size(s:5))
            line3.frame.size.height = soViewLine.frame.size.height
            
            indexHeight = indexHeight + soViewLine.frame.size.height
            indexY = indexY + soViewLine.frame.size.height + soViewLine.frame.origin.x
        }
        
        soViewPhone.frame.size.height = indexHeight
        
        
        let soViewPromos = UIView()
        soViewPromos.frame = CGRect(x: soViewPhone.frame.origin.x, y: soViewPhone.frame.origin.y + soViewPhone.frame.size.height + Common.Size(s:20), width: soViewPhone.frame.size.width, height: 0)
        viewInfoDetail.addSubview(soViewPromos)
        
        var promos:[ProductPromotions] = []
        var discountPay:Float = 0.0
        Cache.itemsPromotionTemp.removeAll()
        
        for item in itemsPromotion{
            
            let it = item
            if (it.TienGiam <= 0){
                if (promos.count == 0){
                    promos.append(it)
                }else{
                    for pro in promos {
                        if (pro.SanPham_Tang == it.SanPham_Tang){
                            pro.SL_Tang =  pro.SL_Tang + item.SL_Tang
                        }else{
                            promos.append(it)
                            break
                        }
                    }
                }
            }else{
                discountPay = discountPay + it.TienGiam
            }
        }
        
        if (promos.count>0){
            let lbSOPromos = UILabel(frame: CGRect(x: 0, y: 0, width: soViewPhone.frame.size.width, height: Common.Size(s:18)))
            lbSOPromos.textAlignment = .left
            lbSOPromos.textColor = UIColor(netHex:0x04AB6E)
            lbSOPromos.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbSOPromos.text = "THÔNG TIN KHUYẾN MÃI"
            soViewPromos.addSubview(lbSOPromos)
            
            let line1Promos = UIView(frame: CGRect(x: soViewPromos.frame.size.width * 1.3/10, y:lbSOPromos.frame.origin.y + lbSOPromos.frame.size.height + Common.Size(s:10), width: 1, height: Common.Size(s:25)))
            line1Promos.backgroundColor = UIColor(netHex:0x04AB6E)
            soViewPromos.addSubview(line1Promos)
            let line2Promos = UIView(frame: CGRect(x: 0, y:line1Promos.frame.origin.y + line1Promos.frame.size.height, width: soViewPromos.frame.size.width, height: 1))
            line2Promos.backgroundColor = UIColor(netHex:0x04AB6E)
            soViewPromos.addSubview(line2Promos)
            
            let lbSttPromos = UILabel(frame: CGRect(x: 0, y: line1Promos.frame.origin.y, width: line1Promos.frame.origin.x, height: line1Promos.frame.size.height))
            lbSttPromos.textAlignment = .center
            lbSttPromos.textColor = UIColor(netHex:0x04AB6E)
            lbSttPromos.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbSttPromos.text = "STT"
            soViewPromos.addSubview(lbSttPromos)
            
            let lbInfoPromos = UILabel(frame: CGRect(x: line1Promos.frame.origin.x, y: line1Promos.frame.origin.y, width: lbSOPromos.frame.size.width - line1Promos.frame.origin.x, height: line1Promos.frame.size.height))
            lbInfoPromos.textAlignment = .center
            lbInfoPromos.textColor = UIColor(netHex:0x04AB6E)
            lbInfoPromos.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbInfoPromos.text = "Khuyến mãi"
            soViewPromos.addSubview(lbInfoPromos)
            
            var numPromos = 0
            var indexYPromos = line2Promos.frame.origin.y
            var indexHeightPromos: CGFloat = line2Promos.frame.origin.y + line2Promos.frame.size.height
            for item in promos{
                numPromos = numPromos + 1
                let soViewLine = UIView()
                soViewPromos.addSubview(soViewLine)
                soViewLine.frame = CGRect(x: 0, y: indexYPromos, width: soViewPhone.frame.size.width, height: 50)
                let line3 = UIView(frame: CGRect(x: line1Promos.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
                line3.backgroundColor = UIColor(netHex:0x04AB6E)
                soViewLine.addSubview(line3)
                
                let nameProduct = "\((item.TenSanPham_Tang))"
                let sizeNameProduct = nameProduct.height(withConstrainedWidth: soViewPhone.frame.size.width - line3.frame.origin.x, font: UIFont.systemFont(ofSize: Common.Size(s:14)))
                let lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: 3, width: soViewPhone.frame.size.width - line3.frame.origin.x, height: sizeNameProduct))
                lbNameProduct.textAlignment = .left
                lbNameProduct.textColor = UIColor.black
                lbNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbNameProduct.text = nameProduct
                lbNameProduct.numberOfLines = 3
                soViewLine.addSubview(lbNameProduct)
                
                let line4 = UIView(frame: CGRect(x: line3.frame.origin.x, y:0, width: soViewPhone.frame.size.width - line3.frame.origin.x - 1, height: 1))
                line4.backgroundColor = UIColor(netHex:0x04AB6E)
                soViewLine.addSubview(line4)
                
                let lbQuantityProduct = UILabel(frame: CGRect(x: lbNameProduct.frame.origin.x , y: lbNameProduct.frame.origin.y + lbNameProduct.frame.size.height + Common.Size(s:5), width: lbNameProduct.frame.size.width, height: Common.Size(s:14)))
                lbQuantityProduct.textAlignment = .left
                lbQuantityProduct.textColor = UIColor.black
                lbQuantityProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbQuantityProduct.text = "Số lượng: \((item.SL_Tang))"
                lbQuantityProduct.numberOfLines = 1
                soViewLine.addSubview(lbQuantityProduct)
                
                let lbSttValue = UILabel(frame: CGRect(x: 0, y: 0, width: lbStt.frame.size.width, height: lbStt.frame.size.height))
                lbSttValue.textAlignment = .center
                lbSttValue.textColor = UIColor.black
                lbSttValue.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbSttValue.text = "\(numPromos)"
                soViewLine.addSubview(lbSttValue)
                
                soViewLine.frame = CGRect(x: soViewLine.frame.origin.x, y: soViewLine.frame.origin.y, width: soViewLine.frame.size.width, height: lbQuantityProduct.frame.origin.y + lbQuantityProduct.frame.size.height + Common.Size(s:5))
                line3.frame.size.height = soViewLine.frame.size.height
                
                indexHeightPromos = indexHeightPromos + soViewLine.frame.size.height
                indexYPromos = indexYPromos + soViewLine.frame.size.height + soViewLine.frame.origin.x
            }
            soViewPromos.frame.size.height = indexHeightPromos
        }
        
        let lbTotal = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: soViewPromos.frame.origin.y + soViewPromos.frame.size.height + Common.Size(s:20), width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbTotal.textAlignment = .left
        lbTotal.textColor = UIColor(netHex:0x04AB6E)
        lbTotal.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbTotal.text = "THÔNG TIN THANH TOÁN"
        viewInfoDetail.addSubview(lbTotal)
        
        
        //        let totalPay = total()
        //        let discountPay = discount()
        
        let lbTotalText = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: lbTotal.frame.origin.y + lbTotal.frame.size.height + Common.Size(s:10), width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbTotalText.textAlignment = .left
        lbTotalText.textColor = UIColor.black
        lbTotalText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbTotalText.text = "Tổng đơn hàng:"
        viewInfoDetail.addSubview(lbTotalText)
        
        
        let lbTotalValue = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: lbTotal.frame.origin.y + lbTotal.frame.size.height + Common.Size(s:10), width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbTotalValue.textAlignment = .right
        lbTotalValue.textColor = UIColor(netHex:0xEF4A40)
        lbTotalValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbTotalValue.text = Common.convertCurrencyFloat(value: totalPay)
        viewInfoDetail.addSubview(lbTotalValue)
        
        let lbDiscountText = UILabel(frame: CGRect(x: lbTotalText.frame.origin.x, y: lbTotalText.frame.origin.y + lbTotalText.frame.size.height, width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbDiscountText.textAlignment = .left
        lbDiscountText.textColor = UIColor.black
        lbDiscountText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbDiscountText.text = "Giảm giá:"
        viewInfoDetail.addSubview(lbDiscountText)
        
        let lbDiscountValue = UILabel(frame: CGRect(x: lbTotalValue.frame.origin.x, y: lbDiscountText.frame.origin.y , width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbDiscountValue.textAlignment = .right
        lbDiscountValue.textColor = UIColor(netHex:0xEF4A40)
        lbDiscountValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbDiscountValue.text = Common.convertCurrencyFloat(value: discountPay)
        viewInfoDetail.addSubview(lbDiscountValue)
        
        let lbPayText = UILabel(frame: CGRect(x: lbDiscountText.frame.origin.x, y: lbDiscountText.frame.origin.y + lbDiscountText.frame.size.height, width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbPayText.textAlignment = .left
        lbPayText.textColor = UIColor.black
        lbPayText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbPayText.text = "Tổng thanh toán:"
        viewInfoDetail.addSubview(lbPayText)
        
        let lbPayValue = UILabel(frame: CGRect(x: lbPayText.frame.origin.x, y: lbPayText.frame.origin.y , width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbPayValue.textAlignment = .right
        lbPayValue.textColor = UIColor(netHex:0xEF4A40)
        lbPayValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))
        lbPayValue.text = Common.convertCurrencyFloat(value: (totalPay - discountPay))
        viewInfoDetail.addSubview(lbPayValue)
        
        //again
        let lbAgain = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: lbPayValue.frame.origin.y + lbPayValue.frame.size.height + Common.Size(s:20), width: tfUserEmail.frame.size.width, height: Common.Size(s: 40)))
        lbAgain.textAlignment = .center
        lbAgain.textColor = UIColor(netHex:0x47B054)
        lbAgain.layer.cornerRadius = 10.0
        lbAgain.layer.borderColor = UIColor(netHex:0x47B054).cgColor
        lbAgain.layer.borderWidth = 0.5
        lbAgain.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        lbAgain.text = "Xoá đơn hàng"
        lbAgain.numberOfLines = 1
        viewInfoDetail.addSubview(lbAgain)
        
        let tapAgain = UITapGestureRecognizer(target: self, action: #selector(ViewSODetailViewController.functionRemove))
        lbAgain.isUserInteractionEnabled = true
        lbAgain.addGestureRecognizer(tapAgain)
        
        
        let btPay = UIButton()
        btPay.frame = CGRect(x: tfUserEmail.frame.origin.x, y: lbAgain.frame.origin.y + lbAgain.frame.size.height + Common.Size(s:10), width: tfUserEmail.frame.size.width, height: tfUserEmail.frame.size.height * 1.2)
        btPay.backgroundColor = UIColor(netHex:0xD0021B)
        btPay.setTitle("ĐÓNG", for: .normal)
        btPay.addTarget(self, action: #selector(actionClose), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        
        viewInfoDetail.addSubview(btPay)
        viewInfoDetail.frame.size.height = btPay.frame.origin.y + btPay.frame.size.height + Common.Size(s:20)
        scrollView.addSubview(viewInfoDetail)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetail.frame.origin.y + viewInfoDetail.frame.size.height  + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    fileprivate func createRadioButtonGender(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        //        radioButton.addTarget(self, action: #selector(PaymentViewController.logSelectedButtonGender), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    @objc func functionRemove(sender:UITapGestureRecognizer) {
        // Prepare the popup
        let title = "XOÁ ĐƠN HÀNG"
        let message = "Bạn có chắc xoá đơn hàng \(self.docEntry) không?"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Xoá", style: .destructive) { _ in
            MPOSAPIManager.removeSO(docEntry: "\(self.docEntry)", handler: { (result, err) in
                if(result == 1){
                    let alert = UIAlertController(title: "Thông báo", message: "Xoá đơn hàng \(self.docEntry) thành công", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                        self.dismiss(animated: true, completion: nil)
                    })
                    self.present(alert, animated: true)
                }else if(result == 0){
                    let alertController = UIAlertController(title: "XOÁ ĐƠN HÀNG", message: err, preferredStyle: .alert)
                    
                    let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                        self.dismiss(animated: true, completion: nil)
                    }
                    alertController.addAction(confirmAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    let alertController = UIAlertController(title: "XOÁ ĐƠN HÀNG", message: "\(err)", preferredStyle: .alert)
                    
                    let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                        self.dismiss(animated: true, completion: nil)
                    }
                    alertController.addAction(confirmAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        })
        
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
        
        
    }
    
    @objc func actionClose() {
        if(isActiveSim){
            
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("showActiveSim"), object: nil)
            
        }
        if(isBookSim == true){
            let newViewController = DanhSachSimBookV2GioHangViewController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    fileprivate func createRadioButton(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        //        radioButton.addTarget(self, action: #selector(PayViewController.logSelectedButton), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    fileprivate func createRadioButtonPayType(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        //        radioButton.addTarget(self, action: #selector(PayViewController.logSelectedButtonPayType), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    fileprivate func createRadioButtonPayInstallment(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        
        return radioButton;
    }
    
}
