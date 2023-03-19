//
//  PaymentCustomerFtelViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 1/8/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Toaster
import PopupDialog
class PaymentCustomerFtelViewController: UIViewController,UITextFieldDelegate{
    var parentNavigationController : UINavigationController?
    var province:Int = 0
    var ValuePromotion:Int = 0
    var phone:String = ""
    var ftelBillCustomer:FtelBillCustomer?
    var Contract:String = ""
    var address:String = ""
    var cardTypeFromPOSResult:CardTypeFromPOSResult?
    var cashValueCashTopup:Int = 0
    var cardValueCardTopup:Int = 0
    var phoneView:UIView!
    var tfPhoneNumber:UITextField!
    //----
    var tfOTP:UITextField!
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
    var viewBottomVoucher:UIView!
    var typeCard:UIView!
    var typeCash:UIView!
    var lbTypeCash:UILabel!
    var lbTypeCard:UILabel!
    var typeCashPayment:Bool = false
    var typeCardPayment:Bool = false
    var promotionView:UIView!
    var typePaymentView:UIView!
    var tfCash:UITextField!
    var tfCard:UITextField!
    var total:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.initNavigationBar()
        self.title = "Thanh toán"
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(PaymentCustomerFtelViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        self.view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView = UIScrollView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - Common.Size(s: 123) - ((parentNavigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: scrollView.frame.size.height)
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let footer = UIView()
        footer.frame = CGRect(x: 0, y:self.view.frame.size.height - Common.Size(s: 123) - ((parentNavigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height) , width: self.view.frame.size.width, height: Common.Size(s: 123))
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
        
        btNext.setTitle("THANH TOÁN",for: .normal)
        
        
        let lbTotal = UILabel(frame: CGRect(x: btNext.frame.origin.x, y: btNext.frame.origin.y - Common.Size(s: 10) - Common.Size(s: 16), width: btNext.frame.size.width/2, height: Common.Size(s:16)))
        lbTotal.textAlignment = .left
        lbTotal.textColor = UIColor.black
        lbTotal.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTotal.text = "Tổng tiền thanh toán"
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
        lbTotalVoucherValue.text = "+0đ"
        
        let lbTotalSum = UILabel(frame: CGRect(x: lbTotalVoucher.frame.origin.x, y: lbTotalVoucher.frame.origin.y - Common.Size(s: 5) - Common.Size(s: 16), width: btNext.frame.size.width/2, height: Common.Size(s:16)))
        lbTotalSum.textAlignment = .left
        lbTotalSum.textColor = UIColor.black
        lbTotalSum.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTotalSum.text = "Tổng tiền"
        footer.addSubview(lbTotalSum)
        
        lbTotalSumValue = UILabel(frame: CGRect(x: lbTotalSum.frame.origin.x + lbTotalSum.frame.size.width, y: lbTotalSum.frame.origin.y, width: lbTotalSum.frame.size.width, height: lbTotalSum.frame.size.height))
        lbTotalSumValue.textAlignment = .right
        lbTotalSumValue.textColor = .black
        lbTotalSumValue.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        footer.addSubview(lbTotalSumValue)
        lbTotalSumValue.text = "0đ"
        //--
        total = updatePrice()
        
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
        lbValueTelecom.text = "\(Contract)"
        lbValueTelecom.textColor = UIColor.black
        lbValueTelecom.textAlignment = .right
        lbValueTelecom.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbValueTelecom)
        
        let lbPriceCard = UILabel(frame: CGRect(x: lbTelecom.frame.origin.x, y: lbTelecom.frame.origin.y + lbTelecom.frame.size.height + Common.Size(s: 5), width: lbTelecom.frame.size.width, height: lbTelecom.frame.size.height))
        lbPriceCard.text = "Tên KH"
        lbPriceCard.textColor = UIColor.lightGray
        lbPriceCard.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbPriceCard)
        
        let lbValuePriceCard = UILabel(frame: CGRect(x: lbPriceCard.frame.size.width + lbPriceCard.frame.origin.x, y: lbPriceCard.frame.origin.y, width: lbValueTelecom.frame.size.width, height: lbValueTelecom.frame.size.height))
        lbValuePriceCard.text = "\(ftelBillCustomer!.CustomerNameFtel)"
        lbValuePriceCard.textColor = UIColor.black
        lbValuePriceCard.textAlignment = .right
        lbValuePriceCard.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbValuePriceCard)
        
        let lbPrice = UILabel(frame: CGRect(x: lbPriceCard.frame.origin.x, y: lbPriceCard.frame.origin.y + lbPriceCard.frame.size.height + Common.Size(s: 5), width: lbPriceCard.frame.size.width, height: lbPriceCard.frame.size.height))
        lbPrice.text = "SĐT"
        lbPrice.textColor = UIColor.lightGray
        lbPrice.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbPrice)
        
        let lbValuePrice = UILabel(frame: CGRect(x: lbPrice.frame.size.width + lbPrice.frame.origin.x, y: lbPrice.frame.origin.y, width: lbPrice.frame.size.width, height: lbValuePriceCard.frame.size.height))
        lbValuePrice.text = "\(phone)"
        lbValuePrice.textColor = UIColor.black
        lbValuePrice.textAlignment = .right
        lbValuePrice.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbValuePrice)
        if(phone == ""){
            lbValuePrice.text = "Chưa cập nhật"
        }
        
        
        detailView.frame.size.height = lbPrice.frame.size.height + lbPrice.frame.origin.y + Common.Size(s: 10)
        
        voucherView = UIView()
        voucherView.frame = CGRect(x: 0, y:detailView.frame.origin.y + detailView.frame.size.height , width: scrollView.frame.size.width, height: 0)
        voucherView.backgroundColor = UIColor.clear
        scrollView.addSubview(voucherView)
        promotionView = UIView()
        if(listVoucher.count > 0){
            let label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
            label2.text = "MÃ GIẢM GIÁ"
            label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
            voucherView.addSubview(label2)
            
            
            listVoucherView = UIView()
            listVoucherView.frame = CGRect(x: 0, y: label2.frame.origin.y + label2.frame.size.height, width: voucherView.frame.size.width, height: 100)
            listVoucherView.backgroundColor = .white
            voucherView.addSubview(listVoucherView)
            
            var yValue:CGFloat = Common.Size(s: 10)
            var stt:Int = 1
            for item in listVoucher {
                let voucher = UIView()
                voucher.frame = CGRect(x: Common.Size(s: 15), y: yValue, width: listVoucherView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 30))
                voucher.backgroundColor = UIColor.white
                listVoucherView.addSubview(voucher)
                
                let lbSTT = UILabel(frame: CGRect(x: 0, y: 0, width: voucher.frame.size.height, height: voucher.frame.size.height))
                lbSTT.text = "\(stt)"
                lbSTT.textColor = UIColor.black
                lbSTT.textAlignment = .center
                lbSTT.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
                voucher.addSubview(lbSTT)
                
                let line = UIView()
                line.frame = CGRect(x: lbSTT.frame.origin.x + lbSTT.frame.size.width, y: 0, width: 1, height: voucher.frame.size.height)
                line.backgroundColor = UIColor.lightGray
                voucher.addSubview(line)
                
                let lbVoucher = UILabel(frame: CGRect(x: line.frame.origin.x + line.frame.size.width + Common.Size(s: 5), y: 0, width: (voucher.frame.size.width - (voucher.frame.size.height * 2))/2 - Common.Size(s: 5), height: voucher.frame.size.height))
                lbVoucher.text = "\(item.voucher)"
                lbVoucher.textColor = UIColor.black
                lbVoucher.textAlignment = .left
                lbVoucher.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
                voucher.addSubview(lbVoucher)
                
                let lbPrice = UILabel(frame: CGRect(x: lbVoucher.frame.origin.x + lbVoucher.frame.size.width, y: 0, width: (voucher.frame.size.width - (voucher.frame.size.height))/2 + Common.Size(s: 10), height: voucher.frame.size.height))
                lbPrice.text = "-\(Common.convertCurrency(value: item.voucherprice))"
                lbPrice.textColor = UIColor.red
                lbPrice.textAlignment = .right
                lbPrice.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
                voucher.addSubview(lbPrice)
                
                
                yValue = yValue + voucher.frame.size.height + 1
                stt = stt + 1
            }
            listVoucherView.frame.size.height = yValue + Common.Size(s: 10)
            voucherView.frame.size.height = listVoucherView.frame.size.height + listVoucherView.frame.origin.y
        }
        promotionView = UIView()
        promotionView.frame = CGRect(x: 0, y:voucherView.frame.origin.y + voucherView.frame.size.height , width: scrollView.frame.size.width, height: 0)
        promotionView.backgroundColor = UIColor.clear
        scrollView.addSubview(promotionView)
        
        if(ValuePromotion > 0){
            let label3 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
            label3.text = "KHUYẾN MÃI"
            label3.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
            promotionView.addSubview(label3)
            
            let viewPro = UIView()
            viewPro.frame = CGRect(x: 0, y: label3.frame.size.height + label3.frame.origin.y, width: promotionView.frame.size.width, height: Common.Size(s: 50))
            viewPro.backgroundColor = UIColor.white
            promotionView.addSubview(viewPro)
            
            let lbPromotion = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: viewPro.frame.size.width/2 - Common.Size(s: 15), height: Common.Size(s: 25)))
            lbPromotion.text = "Giá trị khuyến mãi"
            lbPromotion.textColor = UIColor.lightGray
            lbPromotion.textAlignment = .left
            lbPromotion.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
            viewPro.addSubview(lbPromotion)
            
            let lbValuePromotion = UILabel(frame: CGRect(x: lbPromotion.frame.origin.x + lbPromotion.frame.size.width, y: lbPromotion.frame.origin.y , width: viewPro.frame.size.width/2  - Common.Size(s: 15), height: lbPromotion.frame.size.height))
            lbValuePromotion.text = "-\(Common.convertCurrency(value: ValuePromotion))"
            lbValuePromotion.textColor = UIColor.red
            lbValuePromotion.textAlignment = .right
            lbValuePromotion.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
            viewPro.addSubview(lbValuePromotion)
            
            let viewOTP = UIView(frame: CGRect(x: Common.Size(s: 15), y:  lbPromotion.frame.origin.y + lbPromotion.frame.size.height, width: promotionView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 30)))
            viewPro.addSubview(viewOTP)
            
            let lbOTP = UILabel(frame: CGRect(x: 0, y: 0, width: viewOTP.frame.size.width/3, height: viewOTP.frame.size.height))
            lbOTP.textAlignment = .left
            lbOTP.textColor = UIColor.lightGray
            lbOTP.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbOTP.text = "Mã OTP"
            viewOTP.addSubview(lbOTP)
            
            tfOTP = UITextField(frame: CGRect(x: lbOTP.frame.origin.x + lbOTP.frame.size.width, y: 0, width: viewOTP.frame.size.width * 2/3 , height: Common.Size(s:30)))
            tfOTP.placeholder = ""
            tfOTP.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            tfOTP.borderStyle = UITextField.BorderStyle.roundedRect
            tfOTP.autocorrectionType = UITextAutocorrectionType.no
            tfOTP.keyboardType = UIKeyboardType.numberPad
            tfOTP.returnKeyType = UIReturnKeyType.done
            tfOTP.clearButtonMode = UITextField.ViewMode.whileEditing;
            tfOTP.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            tfOTP.delegate = self
            viewOTP.addSubview(tfOTP)
            
            
            viewPro.frame.size.height = viewOTP.frame.size.height + viewOTP.frame.origin.y + Common.Size(s: 10)
            promotionView.frame.size.height = viewPro.frame.size.height + viewPro.frame.origin.y
            
        }
        typePaymentView = UIView()
        typePaymentView.frame = CGRect(x: 0, y: promotionView.frame.origin.y + promotionView.frame.size.height , width: scrollView.frame.size.width, height: 0)
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
            tfCash.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
            
            
            
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
            
            if(total > 0){
                let characters = Array("\(total)")
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
                    tfCard.text = "0"
                }
            }
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
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: phoneView.frame.size.height + phoneView.frame.origin.y + Common.Size(s: 10))
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
        var sum:Int =  0
        for item in ftelBillCustomer!.ListBill {
            sum = sum + item.Amount
        }
        var sumCardType:Double =  0
        if(typeCardPayment){
            //var moneyString:String = "\(total)"
            var moneyString:String = "\(sum)"
            if(tfCard != nil){
                moneyString = tfCard.text!
            }
            moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            if(moneyString.isEmpty){
                moneyString = "0"
            }
            if(cardTypeFromPOSResult != nil){
                sumCardType = (Double(moneyString)! * cardTypeFromPOSResult!.PercentFee)/100
            }else{
                sumCardType = 0
            }
        }
        let s:Double = Double(sum) + sumCardType
        self.lbTotalVoucherValue.text = "\(Common.convertCurrencyDouble(value: sumCardType.rounded(.up)))"
        self.lbTotalValue.text = "\(Common.convertCurrencyDouble(value: Double(s.rounded(.up))))"
        
        self.lbTotalSumValue.text = "\(Common.convertCurrencyDouble(value: Double(sum)))"
        
        return Int(s.rounded(.up))
    }
    @objc func payAction(_ sender:UITapGestureRecognizer){
        
        let phone = tfPhoneNumber.text!
        if(phone.isEmpty){
            Toast.init(text: "Bạn phải nhập SĐT khách hàng.").show()
            return
        }
        if (phone.hasPrefix("01") && phone.count == 11){
            
        }else if (phone.hasPrefix("0") && !phone.hasPrefix("01") && phone.count == 10){
            
        }else{
            Toast.init(text: "Số điện thoại không hợp lệ!").show()
            return
        }
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang thanh toán..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.parentNavigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        let xml = self.parseXML()
        let listBill = self.parseXMLBill()
        var sum:Int =  0
        for item in ftelBillCustomer!.ListBill {
            sum = sum + item.Amount
        }
        
        MPOSAPIManager.GetPaymentFtelV2(MaNV: "\(Cache.user!.UserName)", MaShop: "\(Cache.user!.ShopCode)", DaGoiService: "0", Province: "\(province)", SoTien: "\(sum)", MaKHFtel: "\(Contract)", CustomerNameFtel: "\(ftelBillCustomer!.CustomerNameFtel)", UserName: "\(ftelBillCustomer!.UserName)", FtelBillList: "\(ftelBillCustomer!.FtelBillList)", FtelAmountList: "\(ftelBillCustomer!.FtelAmountList)", FtelBillDate: "\(ftelBillCustomer!.FtelBillDate)", BillDescription: "\(ftelBillCustomer!.BillDescription)", ListBill: listBill, devicetype: "2", version: "\(Common.versionApp())", codecrm: "\(crm ?? "")", MaGDFRT: "", xmlstringpay: "\(xml)", sdt: "\(phone)", Diachi: "\(address)") { (result, err) in
            
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(result != nil){
                    if(result!.ReturnCode == 0){
                        let vc = ViewPaymentCustomerFtelViewController()
                        vc.parentNavigationController = self.parentNavigationController
                        vc.province = self.province
                        vc.ValuePromotion = self.ValuePromotion
                        vc.phone = phone
                        vc.ftelBillCustomer = self.ftelBillCustomer
                        vc.Contract = self.Contract
                        vc.address = self.address
                        vc.cardTypeFromPOSResult = self.cardTypeFromPOSResult
                        vc.cashValueCashTopup = self.cashValueCashTopup
                        vc.cardValueCardTopup = self.cardValueCardTopup
                        vc.paymentFtelResult = result!
                        vc.typeCashPayment = self.typeCashPayment
                        vc.typeCardPayment = self.typeCardPayment
                        self.parentNavigationController?.pushViewController(vc, animated: true)
                    }else{
                        let popup = PopupDialog(title: "Thông báo", message: result!.Description, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        }
                        let buttonOne = CancelButton(title: "OK") {
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }else{
                    let popup = PopupDialog(title: "Thông báo", message: "HĐ: \(self.Contract)\r\nDV: FPT Telecom\r\nShop: \(Cache.user!.ShopCode)/r/nNV: \(Cache.user!.UserName) /r/n\(err)" , buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
    
    func parseXML()->String{
        var rs:String = "<line>"
        if(typeCashPayment){
            var moneyString:String = "\(total)"
            if(tfCash != nil){
                moneyString = tfCash.text!
            }
            moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            if(moneyString.isEmpty){
                moneyString = "0"
            }
            rs = rs + "<item Totalcash=\"\(moneyString)\"  Totalcardcredit=\"\("")\" Numcard=\"\("")\"  IDBankCard=\"\("")\" Numvoucher=\"\("")\" TotalVoucher=\"\("0")\" Namevoucher=\"\("")\"/>"
           self.cashValueCashTopup = Int(moneyString)!
        }
        if(typeCardPayment){
            var moneyString:String = "\(total)"
            if(tfCard != nil){
                moneyString = tfCard.text!
            }
            moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            if(moneyString.isEmpty){
                moneyString = "0"
            }
            var theName = self.cardTypeFromPOSResult!.Text
            theName = theName.replace(target: "&", withString:"&#38;")
            theName = theName.replace(target: "<", withString:"&#60;")
            theName = theName.replace(target: ">", withString:"&#62;")
            theName = theName.replace(target: "\"", withString:"&#34;")
            theName = theName.replace(target: "'", withString:"&#39;")
            
            var sumCardType:Double =  0
            if(cardTypeFromPOSResult != nil){
                sumCardType = (Double(moneyString)! * cardTypeFromPOSResult!.PercentFee)/100
            }else{
                sumCardType = 0
            }
            sumCardType = sumCardType.rounded(.up)
            rs = rs + "<item Totalcash=\"\("")\"  Totalcardcredit=\"\(moneyString)\" Numcard=\"\("")\"  IDBankCard=\"\(cardTypeFromPOSResult!.Value)\" Numvoucher=\"\("")\" TotalVoucher=\"\("0")\" Namevoucher=\"\("")\" cardfee=\"\(cardTypeFromPOSResult!.PercentFee)\" namecard=\"\(theName)\" totalcardfee=\"\(Int(sumCardType))\"/>"
             self.cardValueCardTopup = Int(moneyString)!
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
    func parseXMLBill()->String{
        var rs:String = "<line>"
        for item in ftelBillCustomer!.ListBill {
            rs = rs + "<item RowID=\"\(item.RowID)\"  Bill=\"\(item.Bill)\" Amount=\"\(item.Amount)\"  BillDate=\"\(item.BillDate)\" Description=\"\(item.Description)\"/>"
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
