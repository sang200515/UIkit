//
//  DetailSOViewController.swift
//  mPOS
//
//  Created by MinhDH on 4/20/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import Foundation
import DLRadioButton
import PopupDialog
class DetailSOViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate{
    var window: UIWindow?
    var so: SOHeader?
    var indexRow:Int = -1
    var scrollView:UIScrollView!
    var tfPhoneNumber:UITextField!
    var tfUserName:UITextField!
    var tfUserAddress:UITextField!
    var tfUserEmail:UITextField!
    
    var taskNotes: UITextView!
    var placeholderLabel : UILabel!
    
    var orderType:Int = -1
    var orderPayType:Int = -1
    
    var radioAtTheCounter:DLRadioButton!
    var radioInstallment:DLRadioButton!
    var radioDeposit:DLRadioButton!
    var radioPayNow:DLRadioButton!
    var radioPayNotNow:DLRadioButton!
    
    var viewInstallment:UIView!
    var viewInstallmentHeight: CGFloat = 0.0
    
    var viewInfoDetail: UIView!
    
    var tfInterestRate:UITextField!
    var tfPrepay:UITextField!
    
    var radioPayInstallmentCom:DLRadioButton!
    var radioPayInstallmentCard:DLRadioButton!
    var lbPayType:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Chi tiết đơn hàng"
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        MPOSAPIManager.getSODetails(docEntry: "\((so?.DocEntry)!)") { (soDetail, String) in
            if(soDetail != nil){
                self.setupUI(soDetail: soDetail!)
            }
        }
    }
    func setupUI(soDetail:SODetail) {
        
        let btDeleteIcon = UIButton.init(type: .custom)
        btDeleteIcon.setImage(#imageLiteral(resourceName: "Delete"), for: UIControl.State.normal)
        btDeleteIcon.imageView?.contentMode = .scaleAspectFit
        btDeleteIcon.addTarget(self, action: #selector(DetailSOViewController.actionDelete), for: UIControl.Event.touchUpInside)
        btDeleteIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        let barDelete = UIBarButtonItem(customView: btDeleteIcon)
        self.navigationItem.rightBarButtonItem = barDelete
        
        
        let lbUserInfo = UILabel(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:20)))
        lbUserInfo.textAlignment = .left
        lbUserInfo.textColor = UIColor(netHex:0x47B054)
        lbUserInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbUserInfo.text = "THÔNG TIN KHÁCH HÀNG"
        scrollView.addSubview(lbUserInfo)
        
        //input phone number
        tfPhoneNumber = UITextField(frame: CGRect(x: Common.Size(s:20), y: lbUserInfo.frame.origin.y + lbUserInfo.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfPhoneNumber.placeholder = "Số điện thoại"
        tfPhoneNumber.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhoneNumber.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhoneNumber.autocorrectionType = UITextAutocorrectionType.no
        tfPhoneNumber.keyboardType = UIKeyboardType.numberPad
        tfPhoneNumber.returnKeyType = UIReturnKeyType.done
        tfPhoneNumber.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPhoneNumber.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhoneNumber.delegate = self
        tfPhoneNumber.text = so!.U_LicTrad
        scrollView.addSubview(tfPhoneNumber)
        
        tfPhoneNumber.isEnabled = false
        
        tfPhoneNumber.leftViewMode = UITextField.ViewMode.always
        let imagePhone = UIImageView(frame: CGRect(x: tfPhoneNumber.frame.size.height/4, y: tfPhoneNumber.frame.size.height/4, width: tfPhoneNumber.frame.size.height/2, height: tfPhoneNumber.frame.size.height/2))
        imagePhone.image = UIImage(named: "Phone-50")
        imagePhone.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewPhone = UIView()
        leftViewPhone.addSubview(imagePhone)
        leftViewPhone.frame = CGRect(x: 0, y: 0, width: tfPhoneNumber.frame.size.height, height: tfPhoneNumber.frame.size.height)
        tfPhoneNumber.leftView = leftViewPhone
        
        //input name info
        tfUserName = UITextField(frame: CGRect(x: tfPhoneNumber.frame.origin.x, y: tfPhoneNumber.frame.origin.y + tfPhoneNumber.frame.size.height + Common.Size(s:10), width: tfPhoneNumber.frame.size.width , height: tfPhoneNumber.frame.size.height ));
        tfUserName.placeholder = "Tên khách hàng"
        tfUserName.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfUserName.borderStyle = UITextField.BorderStyle.roundedRect
        tfUserName.autocorrectionType = UITextAutocorrectionType.no
        tfUserName.keyboardType = UIKeyboardType.default
        tfUserName.returnKeyType = UIReturnKeyType.done
        tfUserName.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfUserName.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfUserName.delegate = self
        tfUserName.text = so!.CardName
        scrollView.addSubview(tfUserName)
        tfUserName.isEnabled = false
        tfUserName.leftViewMode = UITextField.ViewMode.always
        let imageUser = UIImageView(frame: CGRect(x: tfUserName.frame.size.height/4, y: tfUserName.frame.size.height/4, width: tfPhoneNumber.frame.size.height/2, height: tfUserName.frame.size.height/2))
        imageUser.image = UIImage(named: "User-50")
        imageUser.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewUser = UIView()
        leftViewUser.addSubview(imageUser)
        leftViewUser.frame = CGRect(x: 0, y: 0, width: tfUserName.frame.size.height, height: tfUserName.frame.size.height)
        tfUserName.leftView = leftViewUser
        
        //input address
        tfUserAddress = UITextField(frame: CGRect(x: tfUserName.frame.origin.x, y: tfUserName.frame.origin.y + tfUserName.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width , height: tfUserName.frame.size.height ));
        tfUserAddress.placeholder = "Địa chỉ"
        tfUserAddress.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfUserAddress.borderStyle = UITextField.BorderStyle.roundedRect
        tfUserAddress.autocorrectionType = UITextAutocorrectionType.no
        tfUserAddress.keyboardType = UIKeyboardType.default
        tfUserAddress.returnKeyType = UIReturnKeyType.done
        tfUserAddress.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfUserAddress.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfUserAddress.delegate = self
        scrollView.addSubview(tfUserAddress)
        tfUserAddress.text = so!.U_Address1
        tfUserAddress.isEnabled = false
        tfUserAddress.leftViewMode = UITextField.ViewMode.always
        let imageAddress = UIImageView(frame: CGRect(x: tfUserAddress.frame.size.height/4, y: tfUserAddress.frame.size.height/4, width: tfUserAddress.frame.size.height/2, height: tfUserAddress.frame.size.height/2))
        imageAddress.image = UIImage(named: "Home-50-2")
        imageAddress.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewAddress = UIView()
        leftViewAddress.addSubview(imageAddress)
        leftViewAddress.frame = CGRect(x: 0, y: 0, width: tfUserAddress.frame.size.height, height: tfUserAddress.frame.size.height)
        tfUserAddress.leftView = leftViewAddress
        
        
        //input email
        tfUserEmail = UITextField(frame: CGRect(x: tfUserAddress.frame.origin.x, y: tfUserAddress.frame.origin.y + tfUserAddress.frame.size.height + Common.Size(s:10), width: tfUserAddress.frame.size.width , height: tfUserAddress.frame.size.height ));
        tfUserEmail.placeholder = "Email"
        tfUserEmail.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfUserEmail.borderStyle = UITextField.BorderStyle.roundedRect
        tfUserEmail.autocorrectionType = UITextAutocorrectionType.no
        tfUserEmail.keyboardType = UIKeyboardType.default
        tfUserEmail.returnKeyType = UIReturnKeyType.done
        tfUserEmail.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfUserEmail.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfUserEmail.delegate = self
        scrollView.addSubview(tfUserEmail)
        tfUserEmail.text = so!.U_Email
        tfUserEmail.isEnabled = false
        tfUserEmail.leftViewMode = UITextField.ViewMode.always
        let imageEmail = UIImageView(frame: CGRect(x: tfUserEmail.frame.size.height/4, y: tfUserEmail.frame.size.height/4, width: tfUserEmail.frame.size.height/2, height: tfUserEmail.frame.size.height/2))
        imageEmail.image = UIImage(named: "New Post-50")
        imageEmail.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewEmail = UIView()
        leftViewEmail.addSubview(imageEmail)
        leftViewEmail.frame = CGRect(x: 0, y: 0, width: tfUserEmail.frame.size.height, height: tfUserEmail.frame.size.height)
        tfUserEmail.leftView = leftViewEmail
        
        //tilte choose type
        let lbCartType = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: tfUserEmail.frame.origin.y + tfUserEmail.frame.size.height+Common.Size(s:20), width: tfUserEmail.frame.size.width, height: Common.Size(s:20)))
        lbCartType.textAlignment = .left
        lbCartType.textColor = UIColor(netHex:0x47B054)
        lbCartType.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbCartType.text = "LOẠI ĐƠN HÀNG"
        scrollView.addSubview(lbCartType)
        
        radioAtTheCounter = createRadioButton(CGRect(x: lbCartType.frame.origin.x, y: lbCartType.frame.origin.y + lbCartType.frame.size.height+Common.Size(s:10), width: lbCartType.frame.size.width/3, height: Common.Size(s:20)), title: "Tại quầy", color: UIColor.black);
        scrollView.addSubview(radioAtTheCounter)
        
        radioInstallment = createRadioButton(CGRect(x: radioAtTheCounter.frame.origin.x + radioAtTheCounter.frame.size.width, y: radioAtTheCounter.frame.origin.y , width: radioAtTheCounter.frame.size.width, height: radioAtTheCounter.frame.size.height), title: "Trả góp", color: UIColor.black);
        scrollView.addSubview(radioInstallment)
        
        radioDeposit = createRadioButton(CGRect(x: radioInstallment.frame.origin.x + radioInstallment.frame.size.width, y: radioAtTheCounter.frame.origin.y , width: radioInstallment.frame.size.width, height: radioInstallment.frame.size.height), title: "Đặt cọc", color: UIColor.black);
        scrollView.addSubview(radioDeposit)
        
        switch (so?.DocType)!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) {
        case "01":
            orderType = 1
            radioAtTheCounter.isSelected = true
            radioInstallment.isEnabled = false
            radioDeposit.isEnabled = false
        case "02":
            orderType = 2
            radioInstallment.isSelected = true
            radioAtTheCounter.isEnabled = false
            radioDeposit.isEnabled = false
        case "05":
            orderType = 3
            radioDeposit.isSelected = true
            radioAtTheCounter.isEnabled = false
            radioInstallment.isEnabled = false
        default:
            radioAtTheCounter.isSelected = true
            radioInstallment.isEnabled = false
            radioDeposit.isEnabled = false
        }
        
        viewInstallment = UIView(frame: CGRect(x: tfUserEmail.frame.origin.x, y: radioAtTheCounter.frame.origin.y  + radioAtTheCounter.frame.size.height + Common.Size(s:20), width: tfUserEmail.frame.size.width, height: 0))
        
        //tilte choose type pay
        let lbPayInstallment = UILabel(frame: CGRect(x: 0, y: 0, width: viewInstallment.frame.size.width, height: Common.Size(s:20)))
        lbPayInstallment.textAlignment = .left
        lbPayInstallment.textColor = UIColor(netHex:0x47B054)
        lbPayInstallment.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbPayInstallment.text = "LOẠI CHƯƠNG TRÌNH"
        viewInstallment.addSubview(lbPayInstallment)
        
        radioPayInstallmentCard = createRadioButtonPayInstallment(CGRect(x: 0,y:lbPayInstallment.frame.origin.y + lbPayInstallment.frame.size.height + Common.Size(s:10) , width: lbPayInstallment.frame.size.width/2, height: radioAtTheCounter.frame.size.height), title: "Thẻ", color: UIColor.black);
        viewInstallment.addSubview(radioPayInstallmentCard)
        
        radioPayInstallmentCom = createRadioButtonPayInstallment(CGRect(x: radioInstallment.frame.origin.x - tfUserEmail.frame.origin.x ,y:radioPayInstallmentCard.frame.origin.y, width: radioPayInstallmentCard.frame.size.width, height: radioPayInstallmentCard.frame.size.height), title: "Nhà trả góp", color: UIColor.black);
        viewInstallment.addSubview(radioPayInstallmentCom)
        
        if(so!.LoaiTraGop == 0){
            radioPayInstallmentCom.isSelected = true
            radioPayInstallmentCard.isEnabled = false
            
        }else if (so!.LoaiTraGop == 1){
            radioPayInstallmentCard.isSelected = true
            radioPayInstallmentCom.isEnabled = false
        }
        
        tfInterestRate = UITextField(frame: CGRect(x: 0, y: radioPayInstallmentCard.frame.origin.y + radioPayInstallmentCard.frame.size.height + Common.Size(s:10), width: tfUserAddress.frame.size.width , height: tfUserAddress.frame.size.height ));
        tfInterestRate.placeholder = "Lãi suất"
        tfInterestRate.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfInterestRate.borderStyle = UITextField.BorderStyle.roundedRect
        tfInterestRate.autocorrectionType = UITextAutocorrectionType.no
        tfInterestRate.keyboardType = UIKeyboardType.decimalPad
        tfInterestRate.returnKeyType = UIReturnKeyType.done
        tfInterestRate.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfInterestRate.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfInterestRate.delegate = self
        viewInstallment.addSubview(tfInterestRate)
        tfInterestRate.text = "\(so!.LaiSuat)"
        tfInterestRate.isEnabled = false
        tfInterestRate.leftViewMode = UITextField.ViewMode.always
        let imageInterestRate = UIImageView(frame: CGRect(x: tfInterestRate.frame.size.height/4, y: tfInterestRate.frame.size.height/4, width: tfInterestRate.frame.size.height/2, height: tfInterestRate.frame.size.height/2))
        imageInterestRate.image = UIImage(named: "Money Bag")
        imageInterestRate.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewInterestRate = UIView()
        leftViewInterestRate.addSubview(imageInterestRate)
        leftViewInterestRate.frame = CGRect(x: 0, y: 0, width: tfInterestRate.frame.size.height, height: tfInterestRate.frame.size.height)
        tfInterestRate.leftView = leftViewInterestRate
        
        tfPrepay = UITextField(frame: CGRect(x: 0, y: tfInterestRate.frame.origin.y + tfInterestRate.frame.size.height + Common.Size(s:10), width: tfUserAddress.frame.size.width , height: tfUserAddress.frame.size.height ));
        tfPrepay.placeholder = "Trả trước"
        tfPrepay.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPrepay.borderStyle = UITextField.BorderStyle.roundedRect
        tfPrepay.autocorrectionType = UITextAutocorrectionType.no
        tfPrepay.keyboardType = UIKeyboardType.decimalPad
        tfPrepay.returnKeyType = UIReturnKeyType.done
        tfPrepay.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPrepay.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPrepay.delegate = self
        viewInstallment.addSubview(tfPrepay)
        tfPrepay.text = "\(Common.convertCurrencyFloatV2(value: so!.SoTienTraTruoc))"
        tfPrepay.isEnabled = false
        tfPrepay.leftViewMode = UITextField.ViewMode.always
        let imagePrepay = UIImageView(frame: CGRect(x: tfPrepay.frame.size.height/4, y: tfPrepay.frame.size.height/4, width: tfPrepay.frame.size.height/2, height: tfPrepay.frame.size.height/2))
        imagePrepay.image = UIImage(named: "US Dollar-50-2")
        imagePrepay.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewPrepay = UIView()
        leftViewPrepay.addSubview(imagePrepay)
        leftViewPrepay.frame = CGRect(x: 0, y: 0, width: tfPrepay.frame.size.height, height: tfPrepay.frame.size.height)
        tfPrepay.leftView = leftViewPrepay
        
        
        viewInstallment.frame.size.height = tfPrepay.frame.size.height + tfPrepay.frame.origin.y + Common.Size(s:20)
        viewInstallmentHeight = viewInstallment.frame.size.height
        scrollView.addSubview(viewInstallment)
        viewInstallment.clipsToBounds = true
        if (orderType != 2){
            
            viewInstallment.frame.size.height = 0
        }
        viewInfoDetail = UIView(frame: CGRect(x: 0, y: viewInstallment.frame.origin.y  + viewInstallment.frame.size.height, width: self.view.frame.size.width, height: 0))
        
        //tilte choose type pay
        lbPayType = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: 0, width: tfUserEmail.frame.size.width, height: Common.Size(s:20)))
        lbPayType.textAlignment = .left
        lbPayType.textColor = UIColor(netHex:0x47B054)
        lbPayType.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbPayType.text = "LOẠI THANH TOÁN"
        viewInfoDetail.addSubview(lbPayType)
        
        radioPayNow = createRadioButtonPayType(CGRect(x: radioAtTheCounter.frame.origin.x,y:lbPayType.frame.origin.y + lbPayType.frame.size.height + Common.Size(s:10) , width: lbPayType.frame.size.width/2, height: radioAtTheCounter.frame.size.height), title: "Trực tiếp", color: UIColor.black);
        viewInfoDetail.addSubview(radioPayNow)
        
        radioPayNotNow = createRadioButtonPayType(CGRect(x: radioInstallment.frame.origin.x ,y:radioPayNow.frame.origin.y, width: radioPayNow.frame.size.width, height: radioPayNow.frame.size.height), title: "Khác", color: UIColor.black);
        viewInfoDetail.addSubview(radioPayNotNow)
        
        if((so?.Payment)!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "Y"){
            radioPayNow.isSelected = true
            radioPayNotNow.isEnabled = false
        }else{
            radioPayNotNow.isSelected = true
            radioPayNow.isEnabled = false
        }
        
        let lbNotes = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: radioPayNow.frame.origin.y  + radioPayNow.frame.size.height + Common.Size(s:20), width: tfUserEmail.frame.size.width, height: Common.Size(s:20)))
        lbNotes.textAlignment = .left
        lbNotes.textColor = UIColor(netHex:0x47B054)
        lbNotes.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
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
        taskNotes.isEditable = false
        taskNotes.text = "\(so!.Note)"
        
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
        
        let lbSODetail = UILabel(frame: CGRect(x: 0, y: 0, width: soViewPhone.frame.size.width, height: Common.Size(s:20)))
        lbSODetail.textAlignment = .left
        lbSODetail.textColor = UIColor(netHex:0x47B054)
        lbSODetail.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbSODetail.text = "THÔNG TIN ĐƠN HÀNG"
        soViewPhone.addSubview(lbSODetail)
        
        let line1 = UIView(frame: CGRect(x: soViewPhone.frame.size.width * 1.3/10, y:lbSODetail.frame.origin.y + lbSODetail.frame.size.height + Common.Size(s:10), width: 1, height: Common.Size(s:25)))
        line1.backgroundColor = UIColor(netHex:0x47B054)
        soViewPhone.addSubview(line1)
        let line2 = UIView(frame: CGRect(x: 0, y:line1.frame.origin.y + line1.frame.size.height, width: soViewPhone.frame.size.width, height: 1))
        line2.backgroundColor = UIColor(netHex:0x47B054)
        soViewPhone.addSubview(line2)
        
        let lbStt = UILabel(frame: CGRect(x: 0, y: line1.frame.origin.y, width: line1.frame.origin.x, height: line1.frame.size.height))
        lbStt.textAlignment = .center
        lbStt.textColor = UIColor(netHex:0x47B054)
        lbStt.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbStt.text = "STT"
        soViewPhone.addSubview(lbStt)
        
        let lbInfo = UILabel(frame: CGRect(x: line1.frame.origin.x, y: line1.frame.origin.y, width: lbSODetail.frame.size.width - line1.frame.origin.x, height: line1.frame.size.height))
        lbInfo.textAlignment = .center
        lbInfo.textColor = UIColor(netHex:0x47B054)
        lbInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbInfo.text = "Sản phẩm"
        soViewPhone.addSubview(lbInfo)
        
        var indexY = line2.frame.origin.y
        var indexHeight: CGFloat = line2.frame.origin.y + line2.frame.size.height
        var num = 0
        var sumSO:Float = 0.0
        var sumDiscount:Float = 0.0
        for item in soDetail.lineProduct!{
            num = num + 1
            sumSO = sumSO + (item.LineTotal)
            sumDiscount = sumDiscount + item.U_DisOther
            let soViewLine = UIView()
            soViewPhone.addSubview(soViewLine)
            soViewLine.frame = CGRect(x: 0, y: indexY, width: soViewPhone.frame.size.width, height: 50)
            let line3 = UIView(frame: CGRect(x: line1.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
            line3.backgroundColor = UIColor(netHex:0x47B054)
            soViewLine.addSubview(line3)
            
            let nameProduct = "\((item.Dscription))"
            let sizeNameProduct = nameProduct.height(withConstrainedWidth: soViewPhone.frame.size.width - line3.frame.origin.x, font: UIFont.systemFont(ofSize:  Common.Size(s:14)))
            let lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x +  Common.Size(s:5), y: 3, width: soViewPhone.frame.size.width - line3.frame.origin.x, height: sizeNameProduct))
            lbNameProduct.textAlignment = .left
            lbNameProduct.textColor = UIColor.black
            lbNameProduct.font = UIFont.systemFont(ofSize:  Common.Size(s:14))
            lbNameProduct.text = nameProduct
            lbNameProduct.numberOfLines = 3
            soViewLine.addSubview(lbNameProduct)
            
            let line4 = UIView(frame: CGRect(x: line3.frame.origin.x, y:0, width: soViewPhone.frame.size.width - line3.frame.origin.x - 1, height: 1))
            line4.backgroundColor = UIColor(netHex:0x47B054)
            soViewLine.addSubview(line4)
            
            let lbQuantityProduct = UILabel(frame: CGRect(x: lbNameProduct.frame.origin.x , y: lbNameProduct.frame.origin.y + lbNameProduct.frame.size.height +  Common.Size(s:5), width: lbNameProduct.frame.size.width, height:  Common.Size(s:14)))
            lbQuantityProduct.textAlignment = .left
            lbQuantityProduct.textColor = UIColor.black
            lbQuantityProduct.font = UIFont.systemFont(ofSize:  Common.Size(s:14))
            print("item.U_Imei \(item.U_Imei)")
            if (item.U_Imei != ""){
                lbQuantityProduct.text = "IMEI: \((item.U_Imei))"
            }else{
                lbQuantityProduct.text = "Số lượng: \((item.Quantity))"
            }
            lbQuantityProduct.numberOfLines = 1
            soViewLine.addSubview(lbQuantityProduct)
            
            let lbPriceProduct = UILabel(frame: CGRect(x: lbQuantityProduct.frame.origin.x , y: lbQuantityProduct.frame.origin.y + lbQuantityProduct.frame.size.height +  Common.Size(s:5), width: lbQuantityProduct.frame.size.width, height:  Common.Size(s:14)))
            lbPriceProduct.textAlignment = .left
            lbPriceProduct.textColor = UIColor(netHex:0xEF4A40)
            lbPriceProduct.font = UIFont.systemFont(ofSize:  Common.Size(s:14))
            lbPriceProduct.text = "Giá: \(Common.convertCurrencyFloat(value: (item.LineTotal + item.U_DisOther) /  Float(item.Quantity)))"
            lbPriceProduct.numberOfLines = 1
            soViewLine.addSubview(lbPriceProduct)
            
            
            let lbSttValue = UILabel(frame: CGRect(x: 0, y: 0, width: lbStt.frame.size.width, height: lbStt.frame.size.height))
            lbSttValue.textAlignment = .center
            lbSttValue.textColor = UIColor.black
            lbSttValue.font = UIFont.systemFont(ofSize:  Common.Size(s:14))
            lbSttValue.text = "\(num)"
            soViewLine.addSubview(lbSttValue)
            
            soViewLine.frame = CGRect(x: soViewLine.frame.origin.x, y: soViewLine.frame.origin.y, width: soViewLine.frame.size.width, height: lbPriceProduct.frame.origin.y + lbPriceProduct.frame.size.height +  Common.Size(s:5))
            line3.frame.size.height = soViewLine.frame.size.height
            
            indexHeight = indexHeight + soViewLine.frame.size.height
            indexY = indexY + soViewLine.frame.size.height + soViewLine.frame.origin.x
        }
        soViewPhone.frame.size.height = indexHeight
        
        
        let soViewPromos = UIView()
        soViewPromos.frame = CGRect(x: soViewPhone.frame.origin.x, y: soViewPhone.frame.origin.y + soViewPhone.frame.size.height + Common.Size(s:20), width: soViewPhone.frame.size.width, height: 0)
        viewInfoDetail.addSubview(soViewPromos)
        
        var promos:[LinePromos] = []
        var sumPromos:Float = 0.0
        for item in soDetail.linePromos!{
            
            if (item.TienGiam <= 0){
                if (promos.count == 0){
                    promos.append(item)
                    
                }else{
                    for pro in promos {
                        if (pro.SanPham_Tang == item.SanPham_Tang){
                            pro.SL_Tang =  pro.SL_Tang + item.SL_Tang
                        }else{
                            promos.append(item)
                            print("\(pro.SanPham_Tang) \(item.SanPham_Tang)")
                            break
                        }
                    }
                }
            }else{
                sumPromos = sumPromos + item.TienGiam
            }
        }
        
        if (promos.count>0){
            let lbSOPromos = UILabel(frame: CGRect(x: 0, y: 0, width: soViewPhone.frame.size.width, height: Common.Size(s:20)))
            lbSOPromos.textAlignment = .left
            lbSOPromos.textColor = UIColor(netHex:0x47B054)
            lbSOPromos.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
            lbSOPromos.text = "THÔNG TIN KHUYẾN MÃI"
            soViewPromos.addSubview(lbSOPromos)
            
            let line1Promos = UIView(frame: CGRect(x: soViewPromos.frame.size.width * 1.3/10, y:lbSOPromos.frame.origin.y + lbSOPromos.frame.size.height + Common.Size(s:10), width: 1, height: Common.Size(s:25)))
            line1Promos.backgroundColor = UIColor(netHex:0x47B054)
            soViewPromos.addSubview(line1Promos)
            let line2Promos = UIView(frame: CGRect(x: 0, y:line1Promos.frame.origin.y + line1Promos.frame.size.height, width: soViewPromos.frame.size.width, height: 1))
            line2Promos.backgroundColor = UIColor(netHex:0x47B054)
            soViewPromos.addSubview(line2Promos)
            
            let lbSttPromos = UILabel(frame: CGRect(x: 0, y: line1Promos.frame.origin.y, width: line1Promos.frame.origin.x, height: line1Promos.frame.size.height))
            lbSttPromos.textAlignment = .center
            lbSttPromos.textColor = UIColor(netHex:0x47B054)
            lbSttPromos.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbSttPromos.text = "STT"
            soViewPromos.addSubview(lbSttPromos)
            
            let lbInfoPromos = UILabel(frame: CGRect(x: line1Promos.frame.origin.x, y: line1Promos.frame.origin.y, width: lbSOPromos.frame.size.width - line1Promos.frame.origin.x, height: line1Promos.frame.size.height))
            lbInfoPromos.textAlignment = .center
            lbInfoPromos.textColor = UIColor(netHex:0x47B054)
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
                line3.backgroundColor = UIColor(netHex:0x47B054)
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
                line4.backgroundColor = UIColor(netHex:0x47B054)
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
        
        let lbTotal = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: soViewPromos.frame.origin.y + soViewPromos.frame.size.height + Common.Size(s:20), width: tfUserEmail.frame.size.width, height: Common.Size(s:20)))
        lbTotal.textAlignment = .left
        lbTotal.textColor = UIColor(netHex:0x47B054)
        lbTotal.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
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
        lbTotalValue.text = Common.convertCurrencyFloat(value: sumSO + sumDiscount)
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
        lbDiscountValue.text = Common.convertCurrencyFloat(value: sumDiscount)
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
        lbPayValue.text = Common.convertCurrencyFloat(value: sumSO)
        viewInfoDetail.addSubview(lbPayValue)
        
        viewInfoDetail.frame.size.height = lbPayValue.frame.origin.y + lbPayValue.frame.size.height + Common.Size(s:20)
        scrollView.addSubview(viewInfoDetail)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetail.frame.origin.y + viewInfoDetail.frame.size.height +  (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        
        //hide keyboard
        self.hideKeyboardWhenTappedAround()
    }
    
    fileprivate func createRadioButton(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize:  Common.Size(s:16));
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
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize:  Common.Size(s:16));
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
    @objc func actionDelete() {
        let alert = UIAlertController(title: "XOÁ ĐƠN HÀNG", message: "Bạn có chắc xoá đơn hàng \(self.so!.DocEntry) không?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
            MPOSAPIManager.removeSO(docEntry: "\(self.so!.DocEntry)", handler: { (result, err) in
                if(result == 1){
                    let alertController = UIAlertController(title: "", message: "Xoá đơn hàng \(self.so!.DocEntry) thành công", preferredStyle: .alert)
                    
                    let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                        
                    }
                    alertController.addAction(confirmAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }else if(result == 0){
                    let alertController = UIAlertController(title: "XOÁ ĐƠN HÀNG", message: err, preferredStyle: .alert)
                    
                    let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                        
                    }
                    alertController.addAction(confirmAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    let alertController = UIAlertController(title: "XOÁ ĐƠN HÀNG", message: "\(err)", preferredStyle: .alert)
                    
                    let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                        
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
    
}

