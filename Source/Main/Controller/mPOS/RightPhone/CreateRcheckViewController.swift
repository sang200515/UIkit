//
//  CreateRcheckViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import DLRadioButton
class CreateRcheckViewController: UIViewController,UITextFieldDelegate,ChooseBankRightPhoneViewControllerDelegate {
    func returnService(item: BankRP) {
        self.bank = item
        self.tfTypeCardBank.isEnabled = true
        //self.tfBankNumber.isEnabled = true
        self.tfBank.text = item.name
        self.tfCard.isEnabled = true
        
        radCard.isSelected = true
        self.viewTheDetail.isHidden = false
        viewTheDetail.frame = CGRect(x: 0, y: viewTheDetail.frame.origin.y, width: viewTheDetail.frame.width, height: tfCard.frame.origin.y + tfCard.frame.size.height + Common.Size(s:10))
        btConfirm.frame.origin.y = viewTheDetail.frame.size.height + viewTheDetail.frame.origin.y + Common.Size(s:10)
        viewPayment.frame.size.height = btConfirm.frame.size.height + btConfirm.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewPayment.frame.origin.y + viewPayment.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    
    
    var scrollView:UIScrollView!
    var tfIMEI:UITextField!
    var tfItemName:UITextField!
    var tfColor:UITextField!
    var tfBranch:UITextField!
    var bank:BankRP?
    var tfName:UITextField!
    var tfMail:UITextField!
    var tfPhone:UITextField!

    var radCard:DLRadioButton!
    var tfCash:UITextField!
    var tfCard:UITextField!
    var tfTypeCardBank:SearchTextField!
    var lstTypeCardBank:[CardBankRP] = []
    var itemTypeCard: CardBankRP?
    var feeAmount:Int = 0
    var tfBankNumber:UITextField!
    var tfBank:SearchTextField!
    var amount:Int = 0
    var viewTheDetail: UIView!
    let btConfirm = UIButton()
    let viewPayment = UIView()
    var lblFeeValue: UILabel!
    var lblSumValue: UILabel!
    let PASSWORD_PATTERN = "((?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{6,20})"
    
    override func viewDidLoad() {
        self.title = "Thông tin chi tiết"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(CreateRcheckViewController.actionBack), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.clipsToBounds = true
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let label = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label.text = "THÔNG TIN SẢN PHẨM"
        label.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label)
        
        let viewProduct = UIView()
        viewProduct.frame = CGRect(x: 0, y: label.frame.size.height + label.frame.origin.y  , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewProduct.backgroundColor = UIColor.white
        scrollView.addSubview(viewProduct)
                
        let lblImei = Common.tileLabel(x:  Common.Size(s:10), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "IMEI(*)")
        viewProduct.addSubview(lblImei)
        
        tfIMEI = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblImei.frame.origin.y + lblImei.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfIMEI.placeholder = "Nhập IMEI KH"
        tfIMEI.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfIMEI.borderStyle = UITextField.BorderStyle.roundedRect
        tfIMEI.autocorrectionType = UITextAutocorrectionType.no
        tfIMEI.keyboardType = UIKeyboardType.default
        tfIMEI.returnKeyType = UIReturnKeyType.done
        tfIMEI.clearButtonMode = UITextField.ViewMode.whileEditing
        tfIMEI.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfIMEI.delegate = self
        tfIMEI.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        viewProduct.addSubview(tfIMEI)
        
        let lblItemName = UILabel(frame: CGRect(x: Common.Size(s:10), y:tfIMEI.frame.size.height + tfIMEI.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblItemName.textAlignment = .left
        lblItemName.textColor = UIColor.black
        lblItemName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblItemName.text = "Tên Sản Phẩm(*)"
        viewProduct.addSubview(lblItemName)
        
        tfItemName = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblItemName.frame.origin.y + lblItemName.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfItemName.placeholder = "Nhập tên SP"
        tfItemName.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfItemName.borderStyle = UITextField.BorderStyle.roundedRect
        tfItemName.autocorrectionType = UITextAutocorrectionType.no
        tfItemName.keyboardType = UIKeyboardType.default
        tfItemName.returnKeyType = UIReturnKeyType.done
        tfItemName.clearButtonMode = UITextField.ViewMode.whileEditing
        tfItemName.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfItemName.delegate = self
        viewProduct.addSubview(tfItemName)
        
        let lblColor = Common.tileLabel(x: Common.Size(s:10), y: tfItemName.frame.size.height + tfItemName.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Màu sản phẩm(*)")
        viewProduct.addSubview(lblColor)
        
        tfColor = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblColor.frame.origin.y + lblColor.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfColor.placeholder = "Nhập màu SP"
        tfColor.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfColor.borderStyle = UITextField.BorderStyle.roundedRect
        tfColor.autocorrectionType = UITextAutocorrectionType.no
        tfColor.keyboardType = UIKeyboardType.default
        tfColor.returnKeyType = UIReturnKeyType.done
        tfColor.clearButtonMode = UITextField.ViewMode.whileEditing
        tfColor.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfColor.delegate = self
        viewProduct.addSubview(tfColor)
        
        let lblBranch = Common.tileLabel(x: Common.Size(s:10), y: tfColor.frame.size.height + tfColor.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Hãng(*)")
        viewProduct.addSubview(lblBranch)
        
        tfBranch = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblBranch.frame.origin.y + lblBranch.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfBranch.placeholder = "Hãng SP"
        tfBranch.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfBranch.borderStyle = UITextField.BorderStyle.roundedRect
        tfBranch.autocorrectionType = UITextAutocorrectionType.no
        tfBranch.keyboardType = UIKeyboardType.default
        tfBranch.returnKeyType = UIReturnKeyType.done
        tfBranch.clearButtonMode = UITextField.ViewMode.whileEditing
        tfBranch.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfBranch.delegate = self
        viewProduct.addSubview(tfBranch)
        
        viewProduct.frame.size.height = tfBranch.frame.size.height + tfBranch.frame.origin.y + Common.Size(s:10)
        
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewProduct.frame.size.height + viewProduct.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "THÔNG TIN NGƯỜI ĐĂNG KÝ RCHECK"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        let viewRcheckInfo = UIView()
        viewRcheckInfo.frame = CGRect(x: 0, y: label1.frame.size.height + label1.frame.origin.y  , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewRcheckInfo.backgroundColor = UIColor.white
        scrollView.addSubview(viewRcheckInfo)
        
        
        let lblName = Common.tileLabel(x: Common.Size(s:10), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Tên(*)")
        viewRcheckInfo.addSubview(lblName)
        
        tfName = Common.inputTextTextField(x: Common.Size(s:10), y: lblName.frame.origin.y + lblName.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40), placeholder: "Nhập Tên KH", fontSize: Common.Size(s:15))
        tfName.delegate = self
        viewRcheckInfo.addSubview(tfName)
        
        
        let lblPhone = UILabel(frame: CGRect(x: Common.Size(s:10), y: tfName.frame.size.height + tfName.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblPhone.textAlignment = .left
        lblPhone.textColor = UIColor.black
        lblPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPhone.text = "SĐT(*)"
        viewRcheckInfo.addSubview(lblPhone)
        
        tfPhone = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblPhone.frame.origin.y + lblPhone.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfPhone.placeholder = "Nhập SĐT KH"
        tfPhone.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhone.autocorrectionType = UITextAutocorrectionType.no
        tfPhone.keyboardType = UIKeyboardType.numberPad
        tfPhone.returnKeyType = UIReturnKeyType.done
        tfPhone.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhone.delegate = self
        viewRcheckInfo.addSubview(tfPhone)
        
        
        let lblEmail = UILabel(frame: CGRect(x: Common.Size(s:10), y: tfPhone.frame.size.height + tfPhone.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblEmail.textAlignment = .left
        lblEmail.textColor = UIColor.black
        lblEmail.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblEmail.text = "Email(*)"
        viewRcheckInfo.addSubview(lblEmail)
        
        tfMail = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblEmail.frame.origin.y + lblEmail.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfMail.placeholder = "Nhập Email KH"
        tfMail.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfMail.borderStyle = UITextField.BorderStyle.roundedRect
        tfMail.autocorrectionType = UITextAutocorrectionType.no
        tfMail.keyboardType = UIKeyboardType.default
        tfMail.returnKeyType = UIReturnKeyType.done
        tfMail.clearButtonMode = UITextField.ViewMode.whileEditing
        tfMail.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfMail.delegate = self
        viewRcheckInfo.addSubview(tfMail)
        viewRcheckInfo.frame.size.height = tfMail.frame.size.height + tfMail.frame.origin.y + Common.Size(s:10)
        
        let label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewRcheckInfo.frame.size.height + viewRcheckInfo.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label2.text = "HÌNH THỨC THANH TOÁN"
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label2)
        
        viewPayment.frame = CGRect(x: 0, y: label2.frame.size.height + label2.frame.origin.y  , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewPayment.backgroundColor = UIColor.white
        scrollView.addSubview(viewPayment)
        
        let lblIncomeCash = UILabel(frame: CGRect(x: Common.Size(s:10), y:  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblIncomeCash.textAlignment = .left
        lblIncomeCash.textColor = UIColor.black
        lblIncomeCash.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lblIncomeCash.text = "Số tiền cần thu"
        viewPayment.addSubview(lblIncomeCash)
        
        let lblIncomeCashValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblIncomeCash.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblIncomeCashValue.textAlignment = .right
        lblIncomeCashValue.textColor = UIColor.black
        lblIncomeCashValue.font =  UIFont.boldSystemFont(ofSize: Common.Size(s:12))
     
        viewPayment.addSubview(lblIncomeCashValue)
        
        let lblFee = UILabel(frame: CGRect(x: Common.Size(s:10), y:lblIncomeCash.frame.size.height + lblIncomeCash.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblFee.textAlignment = .left
        lblFee.textColor = UIColor.black
        lblFee.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblFee.text = "Phí"
        viewPayment.addSubview(lblFee)
        
        lblFeeValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblFee.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblFeeValue.textAlignment = .right
        lblFeeValue.textColor = UIColor.black
        lblFeeValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblFeeValue.text = "0%"
        viewPayment.addSubview(lblFeeValue)
        
        let lblSum = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblFee.frame.size.height + lblFee.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblSum.textAlignment = .left
        lblSum.textColor = UIColor.red
        lblSum.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        lblSum.text = "Tổng tiền"
        viewPayment.addSubview(lblSum)
        
        lblSumValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblSum.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblSumValue.textAlignment = .right
        lblSumValue.textColor = UIColor.red
        lblSumValue.font =  UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        viewPayment.addSubview(lblSumValue)
        
        
        radCard = createRadioButtonLoaiThueBao(CGRect(x: Common.Size(s:10),y:lblSum.frame.origin.y + lblSum.frame.size.height + Common.Size(s:10) , width: lblIncomeCash.frame.size.width/2, height: Common.Size(s:20)), title: "Thẻ", color: UIColor.black);
        viewPayment.addSubview(radCard)
        
        viewTheDetail = UIView(frame: CGRect(x: 0, y: radCard.frame.size.height + radCard.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width, height: Common.Size(s:100)))
        viewTheDetail.backgroundColor = UIColor.white
        viewPayment.addSubview(viewTheDetail)
        
        //----------Loại Thẻ, ngân hàng
        let lblBankTitle = UILabel(frame: CGRect(x: Common.Size(s:10), y: 0, width: viewTheDetail.frame.size.width , height: Common.Size(s:14)))
        lblBankTitle.textAlignment = .left
        lblBankTitle.textColor = UIColor.black
        lblBankTitle.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBankTitle.text = "Ngân hàng"
        viewTheDetail.addSubview(lblBankTitle)
        
        
        tfBank = SearchTextField(frame: CGRect(x: Common.Size(s:10), y: lblBankTitle.frame.origin.y + lblBankTitle.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        
        tfBank.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfBank.borderStyle = UITextField.BorderStyle.roundedRect
        tfBank.autocorrectionType = UITextAutocorrectionType.no
        tfBank.keyboardType = UIKeyboardType.default
        tfBank.returnKeyType = UIReturnKeyType.done
        tfBank.clearButtonMode = UITextField.ViewMode.whileEditing
        tfBank.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfBank.delegate = self
        tfBank.isEnabled = false
        viewTheDetail.addSubview(tfBank)
        
        let lblTypeBankTitle = UILabel(frame: CGRect(x: Common.Size(s:10), y:   tfBank.frame.size.height + tfBank.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblTypeBankTitle.textAlignment = .left
        lblTypeBankTitle.textColor = UIColor.black
        lblTypeBankTitle.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTypeBankTitle.text = "Chọn loại thẻ"
        viewTheDetail.addSubview(lblTypeBankTitle)
        
        
        tfTypeCardBank = SearchTextField(frame: CGRect(x: Common.Size(s:10), y: lblTypeBankTitle.frame.origin.y + lblTypeBankTitle.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfTypeCardBank.placeholder = "Chọn loại thẻ"
        tfTypeCardBank.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTypeCardBank.borderStyle = UITextField.BorderStyle.roundedRect
        tfTypeCardBank.autocorrectionType = UITextAutocorrectionType.no
        tfTypeCardBank.keyboardType = UIKeyboardType.default
        tfTypeCardBank.returnKeyType = UIReturnKeyType.done
        tfTypeCardBank.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTypeCardBank.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTypeCardBank.delegate = self
        viewTheDetail.addSubview(tfTypeCardBank)
        tfTypeCardBank.isEnabled = false
        // Start visible - Default: false
        tfTypeCardBank.startVisible = true
        tfTypeCardBank.theme.bgColor = UIColor.white
        tfTypeCardBank.theme.fontColor = UIColor.black
        tfTypeCardBank.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTypeCardBank.theme.cellHeight = Common.Size(s:40)
        tfTypeCardBank.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        tfTypeCardBank.leftViewMode = UITextField.ViewMode.always
        tfTypeCardBank.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.itemTypeCard =  self.lstTypeCardBank.filter{ $0.CardName == "\(item.title)" }.first
            self.feeAmount = Int((Float(self.itemTypeCard!.PercentFee) * Float(self.amount))/100)
            self.tfTypeCardBank.text = self.itemTypeCard?.CardName
            self.lblFeeValue.text = "\(self.itemTypeCard?.PercentFee ?? 0)%"
            let tongTien = (self.feeAmount + self.amount)
            self.lblSumValue.text = Common.convertCurrencyV2(value: tongTien)
            self.tfCash.text = Common.convertCurrencyV2(value:  self.amount)
            self.tfCard.text = ""
        }
        //------------------------fix
        
        let lblCashTitle = UILabel(frame: CGRect(x: Common.Size(s:10), y:tfTypeCardBank.frame.origin.y + tfTypeCardBank.frame.height + Common.Size(s:10), width: viewTheDetail.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblCashTitle.textAlignment = .left
        lblCashTitle.textColor = UIColor.black
        lblCashTitle.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblCashTitle.text = "Tiền mặt"
        viewTheDetail.addSubview(lblCashTitle)
        
        
        tfCash = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblCashTitle.frame.origin.y + lblCashTitle.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        
        tfCash.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCash.borderStyle = UITextField.BorderStyle.roundedRect
        tfCash.autocorrectionType = UITextAutocorrectionType.no
        tfCash.keyboardType = UIKeyboardType.numberPad
        tfCash.returnKeyType = UIReturnKeyType.done
        tfCash.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCash.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCash.delegate = self
        tfCash.isEnabled = false
        //tfCash.text = "\(Common.convertCurrencyFloat(value: self.detailAfterSaleRP!.SoTienConLai))"
        viewTheDetail.addSubview(tfCash)
        
        let lblCardTitle = UILabel(frame: CGRect(x: Common.Size(s:10), y:   tfCash.frame.size.height + tfCash.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblCardTitle.textAlignment = .left
        lblCardTitle.textColor = UIColor.black
        lblCardTitle.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblCardTitle.text = "Tiền thẻ"
        viewTheDetail.addSubview(lblCardTitle)
        
        
        tfCard = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblCardTitle.frame.origin.y + lblCardTitle.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        
        tfCard.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCard.borderStyle = UITextField.BorderStyle.roundedRect
        tfCard.autocorrectionType = UITextAutocorrectionType.no
        tfCard.keyboardType = UIKeyboardType.numberPad
        tfCard.returnKeyType = UIReturnKeyType.done
        tfCard.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCard.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCard.delegate = self
        tfCard.isEnabled = false
        viewTheDetail.addSubview(tfCard)
        tfCard.addTarget(self, action: #selector(textFieldDidChangeMoneyTienThe(_:)), for: .editingChanged)
        
        ///Số thẻ----fix-------------------------
        
//        let lblBankNumberTitle = UILabel(frame: CGRect(x: Common.Size(s:10), y:   tfCard.frame.size.height + tfCard.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
//        lblBankNumberTitle.textAlignment = .left
//        lblBankNumberTitle.textColor = UIColor.black
//        lblBankNumberTitle.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lblBankNumberTitle.text = "Số thẻ"
//        viewTheDetail.addSubview(lblBankNumberTitle)
//
//
//        tfBankNumber = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblBankNumberTitle.frame.origin.y + lblBankNumberTitle.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
//
//        tfBankNumber.font = UIFont.systemFont(ofSize: Common.Size(s:15))
//        tfBankNumber.borderStyle = UITextField.BorderStyle.roundedRect
//        tfBankNumber.autocorrectionType = UITextAutocorrectionType.no
//        tfBankNumber.keyboardType = UIKeyboardType.numberPad
//        tfBankNumber.returnKeyType = UIReturnKeyType.done
//        tfBankNumber.clearButtonMode = UITextField.ViewMode.whileEditing
//        tfBankNumber.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
//        tfBankNumber.delegate = self
//        tfBankNumber.isEnabled = false
//        viewTheDetail.addSubview(tfBankNumber)
        
        viewTheDetail.frame = CGRect(x: 0, y: viewTheDetail.frame.origin.y, width: viewTheDetail.frame.width, height: tfCard.frame.origin.y + tfCard.frame.size.height + Common.Size(s:10))
        
        if radCard.isSelected {
            viewTheDetail.isHidden = false
            viewTheDetail.frame = CGRect(x: 0, y: viewTheDetail.frame.origin.y, width: viewTheDetail.frame.width, height: tfCard.frame.origin.y + tfCard.frame.size.height + Common.Size(s:10))
        } else {
            viewTheDetail.isHidden = true
            viewTheDetail.frame = CGRect(x: 0, y: viewTheDetail.frame.origin.y, width: viewTheDetail.frame.width, height: 0)
        }
        
        btConfirm.frame = CGRect(x: Common.Size(s:10), y:viewTheDetail.frame.size.height + viewTheDetail.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width  - Common.Size(s:30), height: Common.Size(s:40) * 1.2)
        btConfirm.backgroundColor = UIColor(netHex:0x00955E)
        btConfirm.setTitle("Hoàn tất", for: .normal)
        btConfirm.addTarget(self, action: #selector(actionComplete), for: .touchUpInside)
        btConfirm.layer.borderWidth = 0.5
        btConfirm.layer.borderColor = UIColor.white.cgColor
        btConfirm.layer.cornerRadius = 3
        viewPayment.addSubview(btConfirm)
        
        viewPayment.frame.size.height = btConfirm.frame.size.height + btConfirm.frame.origin.y + Common.Size(s:10)
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewPayment.frame.origin.y + viewPayment.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        
        MPOSAPIManager.mpos_FRT_SP_SK_Load_TienRcheck() { (result, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.amount = result
                lblIncomeCashValue.text = Common.convertCurrencyFloatV2(value: Float(self.amount))
                self.tfCash.text = Common.convertCurrencyFloatV2(value: Float(self.amount))
                
                let sum = self.amount + self.feeAmount
                self.lblSumValue.text = "\(Common.convertCurrencyV2(value: sum))"
            }
        }
        MPOSAPIManager.mpos_FRT_SP_SK_nganhang_type() { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                
                self.lstTypeCardBank = results
                var list:[String] = []
                for item in results {
                    list.append(item.CardName)
                }
                self.tfTypeCardBank.filterStrings(list)
            }
        }
    }
    
    @objc func actionBack(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
  
    fileprivate func createRadioButtonLoaiThueBao(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
          let radioButton = DLRadioButton(frame: frame);
          radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:13));
          radioButton.setTitle(title, for: UIControl.State());
          radioButton.setTitleColor(color, for: UIControl.State());
          radioButton.iconColor = color;
          radioButton.indicatorColor = color;
          radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
          radioButton.addTarget(self, action: #selector(CreateRcheckViewController.logSelectedButtonLoaiThueBao), for: UIControl.Event.touchUpInside);
          self.view.addSubview(radioButton);
          
          return radioButton;
      }
    @objc @IBAction fileprivate func logSelectedButtonLoaiThueBao(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radCard.isSelected = false
            switch temp {
            case "Tiền mặt":
                
                
                break
            case "Thẻ":
                let newViewController = ChooseBankRightPhoneViewController()
                newViewController.delegate = self
                let navController = UINavigationController(rootViewController: newViewController)
                self.navigationController?.present(navController, animated:false, completion: nil)
                
                break
            default:
                
                break
            }
        }
    }
    @objc func textFieldDidChangeMoneyTienThe(_ textField: UITextField) {
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
            str = str.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
       
            let totalWithoutFee = self.amount - Int(str)!
         
            self.tfCash.text = Common.convertCurrencyV2(value: totalWithoutFee)
            
            if (self.tfCash.text?.hasPrefix("-"))! {
                let alert = UIAlertController(title: "Thông báo", message: "Số tiền thanh toán không được âm !", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .default) { _ in
                    self.tfCard.text = ""
                    self.tfCash.text = Common.convertCurrencyV2(value: self.amount + self.feeAmount)
                })
                self.present(alert, animated: true)
            }
        }else{
            
        }
        
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField == tfIMEI){
            if(tfIMEI.text! == ""){
                showDialog(message: "Vui lòng nhập Imei !")
            }
         
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra thông tin Imei..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            MPOSAPIManager.mpos_FRT_SP_SK_Load_default_imei(Imei:self.tfIMEI.text!) { (results, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        if(results.count > 0){
                            self.tfItemName.text = results[0].phone_pet_name
                            self.tfBranch.text! = results[0].phone_manufacturer
                            self.tfColor.text! = results[0].phone_color
                            self.tfName.text! = results[0].seller_name
                            self.tfPhone.text! = results[0].seller_phone
                            self.tfMail.text! = results[0].seller_email
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
    @objc func actionComplete(){
        if(self.tfIMEI.text! == ""){
            showDialog(message: "Vui lòng nhập IMEI !")
            return
        }
        
        if(self.tfItemName.text! == ""){
            showDialog(message: "Vui lòng nhập tên sản phẩm!")
            return
        }
        
        if(self.tfColor.text! == ""){
            showDialog(message: "Vui lòng màu sản phẩm!")
            return
        }
        
        if(self.tfBranch.text! == ""){
            showDialog(message: "Vui lòng nhập hãng sản phẩm!")
            return
        }
        
        if(self.tfName.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập tên KH!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
            })
            self.present(alert, animated: true)
            return
        }
        
        guard let sdt = self.tfPhone.text, !sdt.isEmpty else {
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập SĐT KH !", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
            })
            self.present(alert, animated: true)
            return
        }
        
        if (sdt.hasPrefix("01")) || (sdt.count != 10) {
            showDialog(message: "SĐT nhà KH không hợp lệ!")
            return
        }
        
        guard let email = self.tfMail.text, !email.isEmpty else {
            showDialog(message: "Vui lòng nhập Email !")
            return
        }
        
        guard isValidEmail(testStr: email) == true else {
            showDialog(message: "Vui lòng nhập đúng định dạng Email!")
            return
        }
        
        if(self.radCard.isSelected == true){
            if (self.tfCard.text == "") {
                showDialog(message: "Bạn phải nhập tiền thẻ !")
                return
            }
            if(self.tfTypeCardBank.text == ""){
                showDialog(message: "Chưa chọn loại thẻ !")
                return
            }
        }
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra giao dịch..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.mpos_FRT_SP_SK_TaoPhieuRcheck(Imei:self.tfIMEI.text!,phone:self.tfPhone.text!,mail:self.tfMail.text!,name:self.tfName.text!,TenSP:self.tfItemName.text!,NhanDT:self.tfBranch.text!,mausac:self.tfColor.text!,xmlpay:"\(self.parseXML())") { (p_status,p_message, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(p_status == 1){
                        let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            _ = self.navigationController?.popToRootViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                            let nc = NotificationCenter.default
                            nc.post(name: Notification.Name("rightPhoneTabNotification"), object: nil)
                        })
                        self.present(alert, animated: true)
                    }else{
                        self.showDialog(message: p_message)
                    }
                    
                }else{
                    self.showDialog(message: err)
                }
            }
        }
    }
    func parseXML()->String{
        var rs:String = "<line>"
        
        if(self.radCard.isSelected == false){
            rs = rs + "<item totalcash=\"\(self.amount)\"  Totalcredit=\"\("0")\" numbercredit=\"\("")\"  IDBank=\"\("")\" typebank=\"\("")\" feebank=\"\("")\"/>"
        }
        
        if(self.radCard.isSelected == true){
            if(self.tfCash.text != ""){
                let moneyStringCash = self.tfCash.text!.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                let moneyStringCard = self.tfCard.text!.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                
                var tienMatBanDau = Int(moneyStringCash)!
                if tienMatBanDau < 0 {
                    tienMatBanDau = 0
                }
                debugPrint("tienMatBanDau: \(tienMatBanDau)")
                
                rs = rs + "<item totalcash=\"\(tienMatBanDau)\"  Totalcredit=\"\("0")\" numbercredit=\"\("")\"  IDBank=\"\("")\" typebank=\"\("")\" feebank=\"\("")\"/>"
                
                rs = rs + "<item totalcash=\"\(0)\"  Totalcredit=\"\(moneyStringCard)\" numbercredit=\"\("\("")")\"  IDBank=\"\("\(self.bank!.code)")\"  typebank=\"\("\(self.itemTypeCard!.CreditCard)")\" feebank=\"\("\(self.feeAmount)")\"/>"
            }else{
                let moneyStringCard = self.tfCard.text!.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                rs = rs + "<item totalcash=\"\(0)\"  Totalcredit=\"\("0")\" numbercredit=\"\("")\"  IDBank=\"\("")\" typebank=\"\("")\" feebank=\"\("")\"/>"
                
                rs = rs + "<item totalcash=\"\(0)\"  Totalcredit=\"\(moneyStringCard)\" numbercredit=\"\("\("")")\"  IDBank=\"\("\(self.bank!.code)")\"  typebank=\"\("\(self.itemTypeCard!.CreditCard)")\" feebank=\"\("\(self.feeAmount)")\"/>"
            }
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
}
