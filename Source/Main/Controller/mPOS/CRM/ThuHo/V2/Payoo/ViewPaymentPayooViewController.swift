//
//  ViewPaymentPayooViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 1/9/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Toaster
import PopupDialog
class ViewPaymentPayooViewController: UIViewController,UITextFieldDelegate{
    var parentNavigationController : UINavigationController?
    var type:Int = 0 // 0: THE 1: TOPUP
    var itemPrice:ItemPrice?
    var quantityValue:Int = 1
    var phone:String = ""
    var total:Int = 0
    //----
    var thuHoBill:ThuHoBill?
    var thuHoService: ThuHoService?
    var thuHoProvider: ThuHoProvider?
    var contractCode: String = ""
    var encashpayooResult:EncashpayooResult?
    var phoneView:UIView!
    var tfPhoneNumber:UITextField!
    var ListDetailPayooSelect: [ItemDetailPayoo] = []
    //----
    var lbTotalValue: UILabel!
    var scrollView:UIScrollView!
    var detailView:UIView!
    var voucherView:UIView!
    var listVoucherView:UIView!
    var boxVoucherView:UIView!
    var tfVoucher:UITextField!
    var listVoucher:[CheckVoucherResult] = []
    var lbTotalVoucherValue: UILabel!
    var lbTotalSumValue:UILabel!
    var typeCard:UIView!
    var typeCash:UIView!
    var lbTypeCash:UILabel!
    var lbTypeCard:UILabel!
    var typeCashPayment:Bool = false
    var typeCardPayment:Bool = false
    
    var cardTypeFromPOSResult:CardTypeFromPOSResult?
    var typePaymentView:UIView!
    var tfCash:UITextField!
    var tfCard:UITextField!
    var cashValueCashTopup:Int = 0
    var cardValueCardTopup:Int = 0
    
    var requestIDthuHoSmartpay = ""
    var transIDthuHoSmartpay = ""
    var itemThuHoSmartpayCheckInfo: CheckInfoTHSmartPay?
    var voucherSmartpay: RepaySmartpayVoucher?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.initNavigationBar()
        listVoucher = []
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(DetailCardViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        self.title = "Thành công \(encashpayooResult?.MaGDFRT ?? "")"
        //---
        self.view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView = UIScrollView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - Common.Size(s: 148) - ((parentNavigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: scrollView.frame.size.height)
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let footer = UIView()
        footer.frame = CGRect(x: 0, y:self.view.frame.size.height - Common.Size(s: 148) - ((parentNavigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height) , width: self.view.frame.size.width, height: Common.Size(s: 148))
        footer.backgroundColor = UIColor.white
        footer.layer.shadowColor = UIColor.gray.cgColor
        footer.layer.shadowOffset =  CGSize(width: 0, height: -1)
        footer.layer.shadowOpacity = 0.5
        self.view.addSubview(footer)
        
        let btNext = UIButton(frame: CGRect(x: Common.Size(s: 20), y: footer.frame.size.height - Common.Size(s: 45), width: footer.frame.size.width - Common.Size(s: 40), height: Common.Size(s: 35)))
        btNext.layer.cornerRadius = 5
        
        btNext.titleLabel?.font = UIFont.systemFont(ofSize: Common.Size(s: 16))
        btNext.backgroundColor = UIColor.init(netHex:0x00955E)
        footer.addSubview(btNext)
        btNext.addTarget(self, action:#selector(self.payAction), for: .touchUpInside)
        
        btNext.setTitle("IN",for: .normal)
        
        let lbPrint = UILabel(frame: CGRect(x: Common.Size(s: 0), y: footer.frame.size.height - Common.Size(s: 45) - Common.Size(s: 20), width: footer.frame.width, height: Common.Size(s: 15)))
//        lbPrint.text = "Chỉ nhấn IN khi cần thiết"
        lbPrint.textColor = UIColor(red: 37/255, green: 148/255, blue: 79/255, alpha: 1)
        lbPrint.font = UIFont.italicSystemFont(ofSize: 13)
        lbPrint.textAlignment = .center
        footer.addSubview(lbPrint)
        
        let lbTotal = UILabel(frame: CGRect(x: btNext.frame.origin.x, y: lbPrint.frame.origin.y - Common.Size(s: 10) - Common.Size(s: 16), width: btNext.frame.size.width/2, height: Common.Size(s:16)))
        lbTotal.textAlignment = .left
        lbTotal.textColor = UIColor.black
        lbTotal.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTotal.text = "Số tiền thanh toán"
        footer.addSubview(lbTotal)
        
        lbTotalValue = UILabel(frame: CGRect(x: lbTotal.frame.origin.x + lbTotal.frame.size.width, y: lbTotal.frame.origin.y, width: lbTotal.frame.size.width, height: lbTotal.frame.size.height))
        lbTotalValue.textAlignment = .right
        lbTotalValue.textColor = UIColor(netHex:0xD0021B)
        lbTotalValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        footer.addSubview(lbTotalValue)
        lbTotalValue.text = "0đ"
        
        let lbTotalVoucher = UILabel(frame: CGRect(x: lbTotal.frame.origin.x, y: lbTotal.frame.origin.y - Common.Size(s: 5) - Common.Size(s: 16), width: btNext.frame.size.width/2, height: Common.Size(s:16)))
        lbTotalVoucher.textAlignment = .left
        lbTotalVoucher.textColor = UIColor.black
        lbTotalVoucher.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTotalVoucher.text = "Phí cà thẻ"
        footer.addSubview(lbTotalVoucher)
        
        lbTotalVoucherValue = UILabel(frame: CGRect(x: lbTotalVoucher.frame.origin.x + lbTotalVoucher.frame.size.width, y: lbTotalVoucher.frame.origin.y, width: lbTotalVoucher.frame.size.width, height: lbTotalVoucher.frame.size.height))
        lbTotalVoucherValue.textAlignment = .right
        lbTotalVoucherValue.textColor = UIColor(netHex:0xD0021B)
        lbTotalVoucherValue.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        footer.addSubview(lbTotalVoucherValue)
        lbTotalVoucherValue.text = "-0đ"
        
        let lbTotalSum = UILabel(frame: CGRect(x: lbTotalVoucher.frame.origin.x, y: lbTotalVoucher.frame.origin.y - Common.Size(s: 5) - Common.Size(s: 16), width: btNext.frame.size.width/2, height: Common.Size(s:16)))
        lbTotalSum.textAlignment = .left
        lbTotalSum.textColor = UIColor.black
        lbTotalSum.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTotalSum.text = "Phí thu hộ"
        footer.addSubview(lbTotalSum)
        
        lbTotalSumValue = UILabel(frame: CGRect(x: lbTotalSum.frame.origin.x + lbTotalSum.frame.size.width, y: lbTotalSum.frame.origin.y, width: lbTotalSum.frame.size.width, height: lbTotalSum.frame.size.height))
        lbTotalSumValue.textAlignment = .right
        lbTotalSumValue.textColor = .black
        lbTotalSumValue.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        footer.addSubview(lbTotalSumValue)
        lbTotalSumValue.text = "0đ"
        //--
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "THÔNG TIN THANH TOÁN"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        detailView = UIView()
        detailView.frame = CGRect(x: 0, y:label1.frame.origin.y + label1.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        detailView.backgroundColor = UIColor.white
        scrollView.addSubview(detailView)
        
        let lbTelecom = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: detailView.frame.width/2 - Common.Size(s: 15), height: Common.Size(s: 18)))
        lbTelecom.text = "Mã hợp đồng"
        lbTelecom.textColor = UIColor.lightGray
        lbTelecom.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbTelecom)
        
        let lbValueTelecom = UILabel(frame: CGRect(x: lbTelecom.frame.size.width + lbTelecom.frame.origin.x, y: lbTelecom.frame.origin.y, width: detailView.frame.width/2 - Common.Size(s: 15), height: lbTelecom.frame.size.height))
        lbValueTelecom.text = "\(contractCode)"
        lbValueTelecom.textColor = UIColor.black
        lbValueTelecom.textAlignment = .right
        lbValueTelecom.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbValueTelecom)
        
        let lbPriceCard = UILabel(frame: CGRect(x: lbTelecom.frame.origin.x, y: lbTelecom.frame.origin.y + lbTelecom.frame.size.height + Common.Size(s: 5), width: lbTelecom.frame.size.width, height: lbTelecom.frame.size.height))
        lbPriceCard.text = "Loại dịch vụ"
        lbPriceCard.textColor = UIColor.lightGray
        lbPriceCard.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbPriceCard)
        
        let lbValuePriceCard = UILabel(frame: CGRect(x: lbPriceCard.frame.size.width + lbPriceCard.frame.origin.x, y: lbPriceCard.frame.origin.y, width: lbValueTelecom.frame.size.width, height: lbValueTelecom.frame.size.height))
        lbValuePriceCard.text = "\(thuHoService!.PaymentBillServiceName)"
        lbValuePriceCard.textColor = UIColor.black
        lbValuePriceCard.textAlignment = .right
        lbValuePriceCard.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbValuePriceCard)
        
        let lbPrice = UILabel(frame: CGRect(x: lbPriceCard.frame.origin.x, y: lbPriceCard.frame.origin.y + lbPriceCard.frame.size.height + Common.Size(s: 5), width: lbPriceCard.frame.size.width, height: lbPriceCard.frame.size.height))
        lbPrice.text = "Nhà cung cấp"
        lbPrice.textColor = UIColor.lightGray
        lbPrice.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbPrice)
        
        let lbValuePrice = UILabel(frame: CGRect(x: lbPrice.frame.size.width + lbPrice.frame.origin.x, y: lbPrice.frame.origin.y, width: lbPrice.frame.size.width, height: lbValuePriceCard.frame.size.height))
        lbValuePrice.text = "\(thuHoProvider?.PaymentBillProviderName ?? "")"
        lbValuePrice.textColor = UIColor.black
        lbValuePrice.textAlignment = .right
        lbValuePrice.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbValuePrice)
        
        let lbQuantity = UILabel(frame: CGRect(x: lbPrice.frame.origin.x, y: lbPrice.frame.origin.y + lbPrice.frame.size.height + Common.Size(s: 5), width: lbPrice.frame.size.width, height: lbPrice.frame.size.height))
        lbQuantity.text = "Tên KH"
        lbQuantity.textColor = UIColor.lightGray
        lbQuantity.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbQuantity)
        
        let lbValueQuantity = UILabel(frame: CGRect(x: lbQuantity.frame.size.width + lbQuantity.frame.origin.x, y: lbQuantity.frame.origin.y, width: lbPrice.frame.size.width, height: lbValuePriceCard.frame.size.height))
        lbValueQuantity.text = "\(thuHoBill?.CustomerName ?? "")"
        lbValueQuantity.textColor = UIColor.black
        lbValueQuantity.textAlignment = .right
        lbValueQuantity.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbValueQuantity)
        
        if("\(thuHoBill?.CompanyName ?? "")" != ""){
            let lbPhone = UILabel(frame: CGRect(x: lbQuantity.frame.origin.x, y: lbQuantity.frame.origin.y + lbQuantity.frame.size.height + Common.Size(s: 5), width: lbPriceCard.frame.size.width, height: lbPriceCard.frame.size.height))
            lbPhone.text = "Doanh nghiệp"
            lbPhone.textColor = UIColor.lightGray
            lbPhone.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
            detailView.addSubview(lbPhone)
            
            let lbValuePhone = UILabel(frame: CGRect(x: lbPhone.frame.size.width + lbPhone.frame.origin.x, y: lbPhone.frame.origin.y, width: lbPrice.frame.size.width, height: lbValuePriceCard.frame.size.height))
            lbValuePhone.text = "\(thuHoBill?.CompanyName ?? "")"
            lbValuePhone.textColor = UIColor.black
            lbValuePhone.textAlignment = .right
            lbValuePhone.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
            detailView.addSubview(lbValuePhone)
            
            detailView.frame.size.height = lbPhone.frame.size.height + lbPhone.frame.origin.y + Common.Size(s: 10)
        }else{
            detailView.frame.size.height = lbQuantity.frame.size.height + lbQuantity.frame.origin.y + Common.Size(s: 10)
        }
        
        let label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: detailView.frame.origin.y + detailView.frame.size.height, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label2.text = "KỲ THANH TOÁN"
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label2)
        
        voucherView = UIView()
        voucherView.frame = CGRect(x: 0, y:label2.frame.origin.y + label2.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 50))
        voucherView.backgroundColor = UIColor.white
        scrollView.addSubview(voucherView)
        
        let lbKyTT = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: voucherView.frame.size.width/2 - Common.Size(s: 15), height: voucherView.frame.size.height))
        lbKyTT.textAlignment = .left
        lbKyTT.textColor = UIColor.black
        lbKyTT.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbKyTT.text = "Số kỳ thanh toán"
        voucherView.addSubview(lbKyTT)
        
        let lbValueKyTT = UILabel(frame: CGRect(x: voucherView.frame.size.width - voucherView.frame.size.height - voucherView.frame.size.height, y: 0, width: voucherView.frame.size.height, height: voucherView.frame.size.height))
        lbValueKyTT.textAlignment = .right
        lbValueKyTT.textColor = UIColor.black
        lbValueKyTT.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbValueKyTT.text = "\(ListDetailPayooSelect.count) kỳ"
        voucherView.addSubview(lbValueKyTT)
        
        if self.thuHoProvider?.PartnerUserCode.trim() == "0051" { //smartpay
            label2.isHidden = true
            voucherView.isHidden = true
            
            label2.frame = CGRect(x: label2.frame.origin.x, y: label2.frame.origin.y, width: label2.frame.width, height: 0)
            voucherView.frame = CGRect(x: voucherView.frame.origin.x, y: label2.frame.origin.y + label2.frame.size.height, width: voucherView.frame.width, height: 0)
        } else {
            label2.isHidden = false
            voucherView.isHidden = false
            
            label2.frame = CGRect(x: label2.frame.origin.x, y: label2.frame.origin.y, width: label2.frame.width, height: Common.Size(s: 35))
            voucherView.frame = CGRect(x: voucherView.frame.origin.x, y: label2.frame.origin.y + label2.frame.size.height, width: voucherView.frame.width, height: Common.Size(s: 50))
        }
        
        typePaymentView = UIView()
        typePaymentView.frame = CGRect(x: 0, y: voucherView.frame.origin.y + voucherView.frame.size.height , width: scrollView.frame.size.width, height: 0)
        typePaymentView.backgroundColor = UIColor.clear
        scrollView.addSubview(typePaymentView)
        
        let label4 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label4.text = "THANH TOÁN"
        label4.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        typePaymentView.addSubview(label4)
        
        let viewPayment = UIView()
        viewPayment.frame = CGRect(x: 0, y: label4.frame.size.height + label4.frame.origin.y, width: typePaymentView.frame.size.width, height: Common.Size(s: 50))
        typePaymentView.addSubview(viewPayment)
        viewPayment.backgroundColor = .white
        
        if(typeCashPayment && typeCardPayment){
            
            let lbTotal = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 5), width: viewPayment.frame.size.width/2 - Common.Size(s: 15), height: Common.Size(s: 20)))
            lbTotal.text = "Tổng"
            lbTotal.textColor = UIColor.lightGray
            lbTotal.textAlignment = .left
            lbTotal.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
            viewPayment.addSubview(lbTotal)
            
            let lbValueTotal = UILabel(frame: CGRect(x: lbTotal.frame.origin.x + lbTotal.frame.size.width, y: lbTotal.frame.origin.y , width: viewPayment.frame.size.width/2  - Common.Size(s: 15), height: lbTotal.frame.size.height))
            lbValueTotal.text = "\(Common.convertCurrency(value: total))"
            lbValueTotal.textColor = UIColor.black
            lbValueTotal.textAlignment = .right
            lbValueTotal.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
            viewPayment.addSubview(lbValueTotal)
            
            let line = UIView()
            line.frame = CGRect(x: Common.Size(s: 15), y: lbTotal.frame.size.height + lbTotal.frame.origin.y + Common.Size(s: 5), width: viewPayment.frame.size.width - Common.Size(s: 30), height: 1)
            viewPayment.addSubview(line)
            line.backgroundColor = UIColor(netHex: 0xEEEEEE)
            
            let lbCash = UILabel(frame: CGRect(x: Common.Size(s: 15), y: line.frame.origin.y + line.frame.size.height + Common.Size(s: 10), width: viewPayment.frame.size.width/2 - Common.Size(s: 15), height: Common.Size(s: 30)))
            lbCash.text = "Tiền mặt"
            lbCash.textColor = UIColor.lightGray
            lbCash.textAlignment = .left
            lbCash.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
            viewPayment.addSubview(lbCash)
            
            tfCash = UITextField(frame: CGRect(x: lbCash.frame.origin.x + lbCash.frame.size.width, y: lbCash.frame.origin.y , width: viewPayment.frame.size.width/2  - Common.Size(s: 15), height: lbCash.frame.size.height))
            tfCash.placeholder = ""
            tfCash.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            tfCash.borderStyle = UITextField.BorderStyle.roundedRect
            tfCash.autocorrectionType = UITextAutocorrectionType.no
            tfCash.keyboardType = UIKeyboardType.numberPad
            tfCash.returnKeyType = UIReturnKeyType.done
            tfCash.clearButtonMode = UITextField.ViewMode.whileEditing
            tfCash.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            tfCash.delegate = self
            tfCash.textAlignment = .right
            viewPayment.addSubview(tfCash)
            
            let lbCard = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbCash.frame.origin.y + lbCash.frame.size.height + Common.Size(s: 10), width: viewPayment.frame.size.width/2 - Common.Size(s: 15), height: Common.Size(s: 30)))
            lbCard.text = "Thẻ"
            lbCard.textColor = UIColor.lightGray
            lbCard.textAlignment = .left
            lbCard.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
            viewPayment.addSubview(lbCard)
            
            tfCard = UITextField(frame: CGRect(x: lbCard.frame.origin.x + lbCard.frame.size.width, y: lbCard.frame.origin.y , width: viewPayment.frame.size.width/2  - Common.Size(s: 15), height: lbCard.frame.size.height))
            tfCard.placeholder = ""
            tfCard.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            tfCard.borderStyle = UITextField.BorderStyle.roundedRect
            tfCard.autocorrectionType = UITextAutocorrectionType.no
            tfCard.keyboardType = UIKeyboardType.numberPad
            tfCard.returnKeyType = UIReturnKeyType.done
            tfCard.clearButtonMode = UITextField.ViewMode.whileEditing
            tfCard.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            tfCard.delegate = self
            tfCard.textAlignment = .right
            tfCard.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            viewPayment.addSubview(tfCard)
            viewPayment.frame.size.height = lbCard.frame.size.height + lbCard.frame.origin.y + Common.Size(s: 10)
            
            let characters = Array("\(cashValueCashTopup)")
            if(characters.count > 0){
                var str = ""
                var count:Int = 0
                for index in 0...(characters.count - 1) {
                    let s = characters[(characters.count - 1) - index]
                    if(count % 3 == 0 && count != 0){
                        str = "\(s),\(str)"
                    }else{
                        str = "\(s)\(str)"
                    }
                    count = count + 1
                }
                tfCash.text = str
            }
            let characters2 = Array("\(cardValueCardTopup)")
            if(characters2.count > 0){
                var str = ""
                var count:Int = 0
                for index in 0...(characters2.count - 1) {
                    let s = characters2[(characters2.count - 1) - index]
                    if(count % 3 == 0 && count != 0){
                        str = "\(s),\(str)"
                    }else{
                        str = "\(s)\(str)"
                    }
                    count = count + 1
                }
                tfCard.text = str
            }
            tfCard.isEnabled = false
            tfCash.isEnabled = false
        }else if(typeCashPayment){
            
            let lbCash = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: viewPayment.frame.size.width/2 - Common.Size(s: 15), height: Common.Size(s: 30)))
            lbCash.text = "Tiền mặt"
            lbCash.textColor = UIColor.lightGray
            lbCash.textAlignment = .left
            lbCash.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
            viewPayment.addSubview(lbCash)
            
            let lbValueCash = UILabel(frame: CGRect(x: lbCash.frame.origin.x + lbCash.frame.size.width, y: lbCash.frame.origin.y , width: viewPayment.frame.size.width/2  - Common.Size(s: 15), height: lbCash.frame.size.height))
            lbValueCash.text = "\(Common.convertCurrency(value: total))"
            lbValueCash.textColor = UIColor.red
            lbValueCash.textAlignment = .right
            lbValueCash.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
            viewPayment.addSubview(lbValueCash)
            viewPayment.frame.size.height = lbCash.frame.size.height + lbCash.frame.origin.y + Common.Size(s: 10)
            
        }else if(typeCardPayment){
            let lbCard = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: viewPayment.frame.size.width/2 - Common.Size(s: 15), height: Common.Size(s: 30)))
            lbCard.text = "Thẻ"
            lbCard.textColor = UIColor.lightGray
            lbCard.textAlignment = .left
            lbCard.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
            viewPayment.addSubview(lbCard)
            
            let lbValueCard = UILabel(frame: CGRect(x: lbCard.frame.origin.x + lbCard.frame.size.width, y: lbCard.frame.origin.y , width: viewPayment.frame.size.width/2  - Common.Size(s: 15), height: lbCard.frame.size.height))
            lbValueCard.text = "\(Common.convertCurrency(value: total))"
            lbValueCard.textColor = UIColor.red
            lbValueCard.textAlignment = .right
            lbValueCard.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
            viewPayment.addSubview(lbValueCard)
            viewPayment.frame.size.height = lbCard.frame.size.height + lbCard.frame.origin.y + Common.Size(s: 10)
        }
        
        
        typePaymentView.frame.size.height = viewPayment.frame.size.height + viewPayment.frame.origin.y
        
        phoneView = UIView()
        phoneView.frame = CGRect(x: 0, y:typePaymentView.frame.origin.y + typePaymentView.frame.size.height + Common.Size(s: 10), width: scrollView.frame.size.width, height: Common.Size(s: 50))
        phoneView.backgroundColor = UIColor.white
        scrollView.addSubview(phoneView)
        
        let lbPhone = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: phoneView.frame.size.width/3 - Common.Size(s: 15), height: phoneView.frame.size.height))
        lbPhone.textAlignment = .left
        lbPhone.textColor = UIColor.black
        lbPhone.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbPhone.text = "Số điện thoại"
        phoneView.addSubview(lbPhone)
        
        tfPhoneNumber = UITextField(frame: CGRect(x: lbPhone.frame.origin.x + lbPhone.frame.size.width, y: Common.Size(s:10), width: phoneView.frame.size.width * 2/3 - Common.Size(s: 15) , height: Common.Size(s:30)))
        tfPhoneNumber.placeholder = ""
        tfPhoneNumber.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfPhoneNumber.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhoneNumber.autocorrectionType = UITextAutocorrectionType.no
        tfPhoneNumber.keyboardType = UIKeyboardType.numberPad
        tfPhoneNumber.returnKeyType = UIReturnKeyType.done
        tfPhoneNumber.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPhoneNumber.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhoneNumber.delegate = self
        phoneView.addSubview(tfPhoneNumber)
        tfPhoneNumber.textAlignment = .right
        if(phone != ""){
            tfPhoneNumber.text = phone
            tfPhoneNumber.isEnabled = false
        }
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: phoneView.frame.size.height + phoneView.frame.origin.y + Common.Size(s: 10))
        _ = updatePrice()
        
        if self.thuHoProvider?.PartnerUserCode.trim() == "0051" { //smartpay
            lbValueQuantity.text = "\(self.itemThuHoSmartpayCheckInfo?.customerName ?? "")"
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s),\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
        }else{
            textField.text = ""
        }
        if(textField == tfCash){
            var moneyString:String = textField.text!
            moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            if(moneyString.isEmpty){
                moneyString = "0"
            }
            if let moneyInt = Int(moneyString) {
                var money = total - moneyInt
                if(money < 0){
                    money = 0
                }
                let characters = Array("\(money)")
                if(characters.count > 0){
                    var str = ""
                    var count:Int = 0
                    for index in 0...(characters.count - 1) {
                        let s = characters[(characters.count - 1) - index]
                        if(count % 3 == 0 && count != 0){
                            str = "\(s),\(str)"
                        }else{
                            str = "\(s)\(str)"
                        }
                        count = count + 1
                    }
                    tfCard.text = str
                }else{
                    tfCard.text = ""
                }
            }
            _ = updatePrice()
        }else if(textField == tfCard){
            var moneyString:String = textField.text!
            moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            if(moneyString.isEmpty){
                moneyString = "0"
            }
            if let moneyInt = Int(moneyString) {
                var money = total - moneyInt
                if(money < 0){
                    money = 0
                }
                let characters = Array("\(money)")
                if(characters.count > 0){
                    var str = ""
                    var count:Int = 0
                    for index in 0...(characters.count - 1) {
                        let s = characters[(characters.count - 1) - index]
                        if(count % 3 == 0 && count != 0){
                            str = "\(s),\(str)"
                        }else{
                            str = "\(s)\(str)"
                        }
                        count = count + 1
                    }
                    tfCash.text = str
                }else{
                    tfCash.text = ""
                }
            }
            _ =  updatePrice()
        }
    }
    func updatePrice() -> Int{
        let sum:Int = total
        var sumPhiThuHo:Int = 0
        for item in ListDetailPayooSelect {
            if(thuHoBill?.PaymentFeeType == 2){
                if(sumPhiThuHo == 0){
                    sumPhiThuHo = sumPhiThuHo + item.PaymentFee
                }
            }else{
                sumPhiThuHo = sumPhiThuHo + item.PaymentFee
            }
        }
        self.lbTotalSumValue.text = "\(Common.convertCurrency(value: sumPhiThuHo))"
        
        var sumPhiCaThe:Double = 0
        if(cardTypeFromPOSResult != nil){
            sumPhiCaThe = cardTypeFromPOSResult!.PercentFee
        }
        var moneyString:String = "0"
        if(tfCard != nil){
            moneyString = tfCard.text!
        }else if(typeCardPayment){
            moneyString = "\(total)"
        }
        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        if(moneyString.isEmpty){
            moneyString = "0"
        }
        let sumCaThe:Double = (Double(moneyString)! * sumPhiCaThe)/100
        
        self.lbTotalVoucherValue.text = "\(Common.convertCurrency(value: Int(sumCaThe.rounded(.up))))"
        let sumAll = sum + Int(sumCaThe.rounded(.up))
        self.lbTotalValue.text = "\(Common.convertCurrency(value: sumAll))"
        
        return sum
    }
    
    
    @objc func payAction(_ sender:UITapGestureRecognizer){
        var sumCardType:Double =  0
        if(typeCardPayment){
            if(cardTypeFromPOSResult != nil){
                sumCardType = (Double(cardValueCardTopup) * cardTypeFromPOSResult!.PercentFee)/100
            }else{
                sumCardType = 0
            }
        }
        
        if self.thuHoProvider?.PartnerUserCode.trim() == "0051" { //SMARTPAY
            
            let printBillThuHo = PrintBillThuHo(BillCode:"\(self.requestIDthuHoSmartpay)", TransactionCode: "\(self.transIDthuHoSmartpay)", ServiceName:"\(thuHoProvider?.PaymentBillServiceName ?? "")", ProVideName:"\(thuHoProvider?.PaymentBillProviderName ?? "")", NhaCungCap: "\(thuHoProvider?.PaymentBillProviderName ?? "")", Customernamne:"\(self.itemThuHoSmartpayCheckInfo?.customerName ?? "")", Customerpayoo:"\(contractCode)", PayerMobiphone:"", Address:"", BillID:"", Month:"", TotalAmouth:"\(Common.FormatMoney(cost: self.total) ?? "0")", Paymentfee:"0", Employname:"\(Cache.user!.EmployeeName)", Createby:"\(Cache.user!.UserName)", ShopAddress:"\(Cache.user!.Address)",ThoiGianXuat:"\(self.itemThuHoSmartpayCheckInfo?.paymentDueDate ?? "")", MaVoucher: "\(self.voucherSmartpay?.voucher ?? "")", HanSuDung: "\(self.voucherSmartpay?.date_to ?? "")", PhiCaThe: "\(Common.FormatMoney(cost: Int(sumCardType)) ?? "0")")
            
            MPOSAPIManager.pushBillThuHo(printBill: printBillThuHo)
            self.parentNavigationController?.popToRootViewController(animated: true)
            Toast.init(text: "Đã gửi lệnh in").show()
            
        } else { //PAYOO
            let dateFormatter2 : DateFormatter = DateFormatter()
            dateFormatter2.dateFormat = "dd-MM-yyyy HH:mm:ss"
            let date = Date()
            let dateString2 = dateFormatter2.string(from: date)
            var MonthString =  ""
            for item in ListDetailPayooSelect {
                if(MonthString == ""){
                    MonthString = "\(item.Month)"
                }else{
                    MonthString = "\(MonthString),\(item.Month)"
                }
            }
            var sumPhiThuHo:Int = 0
            for item in ListDetailPayooSelect {
                if(thuHoBill!.PaymentFeeType == 2){
                    if(sumPhiThuHo == 0){
                        sumPhiThuHo = sumPhiThuHo + item.PaymentFee
                    }
                }else{
                    sumPhiThuHo = sumPhiThuHo + item.PaymentFee
                }
            }
            var totalSum = total - sumPhiThuHo
            if(totalSum < 0){
                totalSum = 0
            }
            let printBillThuHo = PrintBillThuHo(BillCode:"\(encashpayooResult!.BillCode)", TransactionCode: "\(encashpayooResult!.MaGDFRT)", ServiceName:"\(thuHoProvider!.PaymentBillServiceName)", ProVideName:"\(thuHoProvider!.PaymentBillProviderName)", NhaCungCap: "\(thuHoProvider!.PaymentBillProviderName)", Customernamne:"\(thuHoBill!.CustomerName)", Customerpayoo:"\(contractCode)", PayerMobiphone:"", Address:"", BillID:"", Month:MonthString, TotalAmouth:"\(Common.FormatMoney(cost: totalSum)!)", Paymentfee:"\(Common.FormatMoney(cost: Int(sumPhiThuHo))!)", Employname:"\(Cache.user!.EmployeeName)", Createby:"\(Cache.user!.UserName)", ShopAddress:"\(Cache.user!.Address)",ThoiGianXuat:"\(dateString2)", MaVoucher: "\(self.encashpayooResult!.u_vocher)", HanSuDung: "\(self.encashpayooResult!.Den_Ngay)", PhiCaThe: "\(Common.FormatMoney(cost: Int(sumCardType))!)")
            
            MPOSAPIManager.pushBillThuHo(printBill: printBillThuHo)
            self.parentNavigationController?.popToRootViewController(animated: true)
            Toast.init(text: "Đã gửi lệnh in").show()
        }
    }
    
    @objc func actionBack() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
