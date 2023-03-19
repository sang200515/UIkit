//
//  PaymentCardViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/22/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//


import Foundation
import UIKit
import Toaster
import PopupDialog
import DLRadioButton
class PaymentCardViewController: UIViewController,UITextFieldDelegate{
    var parentNavigationController : UINavigationController?
    var type:Int = 0 // 0: THE 1: TOPUP
    var itemPrice:ItemPrice?
    var quantityValue:Int = 1
    var phone:String = ""
    var ValuePromotion:Int = 0
    var cardPrice: Int = 0
    var cardValue: Int = 0
    var isPromotion = false
    var promotionActivedSim: PromotionActivedSim?
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
    var invoiceView:UIView!
    
    var radioInvoiceCompany:DLRadioButton!
    
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
        btBackIcon.addTarget(self, action: #selector(PaymentCardViewController.actionBack), for: UIControl.Event.touchUpInside)
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
        btNext.setTitle("HOÀN TẤT",for: .normal)
        
        
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
        
        if isPromotion {
            let cashValue = promotionActivedSim?.Price == 0 ? promotionActivedSim?.CardValue : promotionActivedSim!.Price
            lbTotalValue.text = Common.convertCurrency(value: cashValue!)
            
        } else {
            lbTotalValue.text = "0đ"
        }
        
        
        let lbTotalVoucher = UILabel(frame: CGRect(x: lbTotal.frame.origin.x, y: lbTotal.frame.origin.y - Common.Size(s: 5) - Common.Size(s: 16), width: btNext.frame.size.width/2, height: Common.Size(s:16)))
        lbTotalVoucher.textAlignment = .left
        lbTotalVoucher.textColor = UIColor.black
        lbTotalVoucher.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTotalVoucher.text = "Giảm giá"
        footer.addSubview(lbTotalVoucher)
        
        lbTotalVoucherValue = UILabel(frame: CGRect(x: lbTotalVoucher.frame.origin.x + lbTotalVoucher.frame.size.width, y: lbTotalVoucher.frame.origin.y, width: lbTotalVoucher.frame.size.width, height: lbTotalVoucher.frame.size.height))
        lbTotalVoucherValue.textAlignment = .right
        lbTotalVoucherValue.textColor = UIColor(netHex:0xD0021B)
        lbTotalVoucherValue.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        footer.addSubview(lbTotalVoucherValue)
        //        lbTotalVoucherValue.text = "-0đ"
        lbTotalVoucherValue.text = "-\(Common.convertCurrency(value: ValuePromotion))"
        
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
        //        lbTotalSumValue.text = "0đ"
        lbTotalSumValue.text = "\(Common.convertCurrency(value: cardValue))"
        //--
        total = updatePrice()
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "CHI TIẾT GIAO DỊCH"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        detailView = UIView()
        detailView.frame = CGRect(x: 0, y:label1.frame.origin.y + label1.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        detailView.backgroundColor = UIColor.white
        scrollView.addSubview(detailView)
        
        let lbTelecom = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: detailView.frame.width/2 - Common.Size(s: 15), height: Common.Size(s: 18)))
        lbTelecom.text = "Nhà mạng"
        lbTelecom.textColor = UIColor.lightGray
        lbTelecom.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbTelecom)
        
        let lbValueTelecom = UILabel(frame: CGRect(x: lbTelecom.frame.size.width + lbTelecom.frame.origin.x, y: lbTelecom.frame.origin.y, width: detailView.frame.width/2 - Common.Size(s: 15), height: lbTelecom.frame.size.height))
        lbValueTelecom.text = "\(itemPrice!.TelecomName)"
        lbValueTelecom.textColor = UIColor.black
        lbValueTelecom.textAlignment = .right
        lbValueTelecom.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbValueTelecom)
        
        let lbPriceCard = UILabel(frame: CGRect(x: lbTelecom.frame.origin.x, y: lbTelecom.frame.origin.y + lbTelecom.frame.size.height + Common.Size(s: 5), width: lbTelecom.frame.size.width, height: lbTelecom.frame.size.height))
        lbPriceCard.text = "Mệnh giá"
        lbPriceCard.textColor = UIColor.lightGray
        lbPriceCard.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbPriceCard)
        
        let lbValuePriceCard = UILabel(frame: CGRect(x: lbPriceCard.frame.size.width + lbPriceCard.frame.origin.x, y: lbPriceCard.frame.origin.y, width: lbValueTelecom.frame.size.width, height: lbValueTelecom.frame.size.height))
        
        //
        if isPromotion {
            lbValuePriceCard.text = "\(Common.convertCurrency(value: promotionActivedSim?.CardValue ?? 0))"
        } else {
            lbValuePriceCard.text = "\(Common.convertCurrency(value: itemPrice!.PriceCard))"
        }
        //
        
        //        lbValuePriceCard.text = "\(Common.convertCurrency(value: itemPrice!.PriceCard))"
        lbValuePriceCard.textColor = UIColor.black
        lbValuePriceCard.textAlignment = .right
        lbValuePriceCard.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbValuePriceCard)
        
        let lbPrice = UILabel(frame: CGRect(x: lbPriceCard.frame.origin.x, y: lbPriceCard.frame.origin.y + lbPriceCard.frame.size.height + Common.Size(s: 5), width: lbPriceCard.frame.size.width, height: lbPriceCard.frame.size.height))
        lbPrice.text = "Giá bán"
        lbPrice.textColor = UIColor.lightGray
        lbPrice.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbPrice)
        
        let lbValuePrice = UILabel(frame: CGRect(x: lbPrice.frame.size.width + lbPrice.frame.origin.x, y: lbPrice.frame.origin.y, width: lbPrice.frame.size.width, height: lbValuePriceCard.frame.size.height))
        
        //
        if isPromotion {
            lbValuePrice.text = "\(Common.convertCurrency(value: promotionActivedSim?.CardValue ?? 0))"
        } else {
            lbValuePrice.text = "\(Common.convertCurrency(value: itemPrice!.Price))"
        }
        //
        
        //        lbValuePrice.text = "\(Common.convertCurrency(value: itemPrice!.Price))"
        lbValuePrice.textColor = UIColor.black
        lbValuePrice.textAlignment = .right
        lbValuePrice.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbValuePrice)
        
        let lbQuantity = UILabel(frame: CGRect(x: lbPrice.frame.origin.x, y: lbPrice.frame.origin.y + lbPrice.frame.size.height + Common.Size(s: 5), width: lbPrice.frame.size.width, height: lbPrice.frame.size.height))
        lbQuantity.text = "Số lượng"
        lbQuantity.textColor = UIColor.lightGray
        lbQuantity.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbQuantity)
        
        let lbValueQuantity = UILabel(frame: CGRect(x: lbQuantity.frame.size.width + lbQuantity.frame.origin.x, y: lbQuantity.frame.origin.y, width: lbPrice.frame.size.width, height: lbValuePriceCard.frame.size.height))
        lbValueQuantity.text = "\(quantityValue)"
        lbValueQuantity.textColor = UIColor.black
        lbValueQuantity.textAlignment = .right
        lbValueQuantity.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbValueQuantity)
        
        let lbNCC = UILabel(frame: CGRect(x: lbQuantity.frame.origin.x, y: lbQuantity.frame.origin.y + lbQuantity.frame.size.height + Common.Size(s: 5), width: lbPrice.frame.size.width, height: lbPrice.frame.size.height))
        lbNCC.text = "NCC"
        lbNCC.textColor = UIColor.lightGray
        lbNCC.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbNCC)
        
        let lbValueNCC = UILabel(frame: CGRect(x: lbNCC.frame.size.width + lbNCC.frame.origin.x, y: lbNCC.frame.origin.y, width: lbPrice.frame.size.width, height: lbValuePriceCard.frame.size.height))
        lbValueNCC.text = "\(itemPrice!.TypeNCC)"
        lbValueNCC.textColor = UIColor.black
        lbValueNCC.textAlignment = .right
        lbValueNCC.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbValueNCC)
        
        if(phone != ""){
            let lbPhone = UILabel(frame: CGRect(x: lbNCC.frame.origin.x, y: lbNCC.frame.origin.y + lbNCC.frame.size.height + Common.Size(s: 5), width: lbPriceCard.frame.size.width, height: lbPriceCard.frame.size.height))
            lbPhone.text = "SĐT khách hàng"
            lbPhone.textColor = UIColor.lightGray
            lbPhone.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
            detailView.addSubview(lbPhone)
            
            let lbValuePhone = UILabel(frame: CGRect(x: lbPhone.frame.size.width + lbPhone.frame.origin.x, y: lbPhone.frame.origin.y, width: lbPrice.frame.size.width, height: lbValuePriceCard.frame.size.height))
            lbValuePhone.text = "\(phone)"
            lbValuePhone.textColor = UIColor.black
            lbValuePhone.textAlignment = .right
            lbValuePhone.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
            detailView.addSubview(lbValuePhone)
            
            detailView.frame.size.height = lbPhone.frame.size.height + lbPhone.frame.origin.y + Common.Size(s: 10)
        }else{
            detailView.frame.size.height = lbNCC.frame.size.height + lbNCC.frame.origin.y + Common.Size(s: 10)
        }
        
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
            
            //            let viewOTP = UIView(frame: CGRect(x: Common.Size(s: 15), y:  lbPromotion.frame.origin.y + lbPromotion.frame.size.height, width: promotionView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 30)))
            //            viewPro.addSubview(viewOTP)
            //
            //            let lbOTP = UILabel(frame: CGRect(x: 0, y: 0, width: viewOTP.frame.size.width/3, height: viewOTP.frame.size.height))
            //            lbOTP.textAlignment = .left
            //            lbOTP.textColor = UIColor.lightGray
            //            lbOTP.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            //            lbOTP.text = "Mã OTP"
            //            viewOTP.addSubview(lbOTP)
            //
            //            tfOTP = UITextField(frame: CGRect(x: lbOTP.frame.origin.x + lbOTP.frame.size.width, y: 0, width: viewOTP.frame.size.width * 2/3 , height: Common.Size(s:30)))
            //            tfOTP.placeholder = ""
            //            tfOTP.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            //            tfOTP.borderStyle = UITextField.BorderStyle.roundedRect
            //            tfOTP.autocorrectionType = UITextAutocorrectionType.no
            //            tfOTP.keyboardType = UIKeyboardType.numberPad
            //            tfOTP.returnKeyType = UIReturnKeyType.done
            //            tfOTP.clearButtonMode = UITextField.ViewMode.whileEditing;
            //            tfOTP.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            //            tfOTP.delegate = self
            //            viewOTP.addSubview(tfOTP)
            
            
            //            viewPro.frame.size.height = viewOTP.frame.size.height + viewOTP.frame.origin.y + Common.Size(s: 10)
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
        
        invoiceView = UIView()
        invoiceView.frame = CGRect(x: 0, y: typePaymentView.frame.origin.y + typePaymentView.frame.size.height , width: scrollView.frame.size.width, height: 0)
        invoiceView.backgroundColor = UIColor.clear
        scrollView.addSubview(invoiceView)
        
        let label5 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label5.text = "HOÁ ĐƠN"
        label5.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        invoiceView.addSubview(label5)
        
        let viewInvoice = UIView()
        viewInvoice.frame = CGRect(x: 0, y: label4.frame.size.height + label4.frame.origin.y, width: invoiceView.frame.size.width, height: Common.Size(s: 50))
        invoiceView.addSubview(viewInvoice)
        viewInvoice.backgroundColor = .white
        
        radioInvoiceCompany = createRadioButton(CGRect(x: Common.Size(s: 15), y: 0, width: viewInvoice.frame.size.width - Common.Size(s: 30), height: viewInvoice.frame.size.height), title: "Xuất hóa đơn Công ty", color: UIColor.black);
        viewInvoice.addSubview(radioInvoiceCompany)
        
        invoiceView.frame.size.height = viewInvoice.frame.size.height + viewInvoice.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: invoiceView.frame.size.height + invoiceView.frame.origin.y + Common.Size(s: 10))
        
    }
    fileprivate func createRadioButton(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:14));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(.black, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.isIconSquare = true
        radioButton.isMultipleSelectionEnabled = true
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        
        return radioButton;
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
        }
    }
    
    func updatePrice() -> Int{
        
        var sum:Int = 0
        var voucher:Int = self.ValuePromotion
        if isPromotion {
            sum = quantityValue * (promotionActivedSim?.CardValue)!
            voucher = promotionActivedSim?.ValuePromotion ?? 0
        } else {
            sum = quantityValue * itemPrice!.Price
        }
        self.lbTotalSumValue.text = "\(Common.convertCurrency(value: sum))"
        for item in listVoucher {
            voucher = voucher + item.voucherprice
        }
        self.lbTotalVoucherValue.text = "-\(Common.convertCurrency(value: voucher))"
        var total:Int = sum - voucher
        if(total < 0){
            total = 0
        }
        self.lbTotalValue.text = "\(Common.convertCurrency(value: total))"
        return total
    }
    
    @objc func payAction(_ sender:UITapGestureRecognizer){
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        var OTPNumber:String = ""
        var is_HeThongHD = 0
        if(radioInvoiceCompany.isSelected){
            is_HeThongHD = 1;
        }
        if(tfOTP != nil && self.ValuePromotion > 0){
            let tex = self.tfOTP.text!
            if(!tex.isEmpty){
                OTPNumber = tex
            }else{
                Toast.init(text: "Bạn chưa nhập OTP của KH.").show()
                return
            }
        }
        if(type == 0){//THE CAO
            let xml = self.parseXML()
            if((Cache.cashValueCardTopup + Cache.cardValueCardTopup) > total){
                
                let popup = PopupDialog(title: "Thông báo", message: "Số tiền bạn nhập không được lớn hơn tổng tiền cần thanh toán.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                }
                let buttonOne = CancelButton(title: "OK") {
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
                
                return
            }
            let newViewController = LoadingViewController()
            newViewController.content = "Đang thanh toán..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            MPOSAPIManager.GetPayCodePrice(providerId: "\(itemPrice!.TelecomName)", cardValue: "\(itemPrice!.PriceCard)") { (resultPY, err) in
                if(err.count <= 0){
                    let sumPurchasing = resultPY!.PurchasingPrice * self.quantityValue
                    var isCheckPromotion = "0"
                    if(self.ValuePromotion > 0){
                        isCheckPromotion = "1"
                    }
                    if(self.itemPrice!.TypeNCC == "Viettel"){
                        MPOSAPIManager.GetViettelPayResult(UserID: "\(Cache.user!.UserName)", ShopCode: "\(Cache.user!.ShopCode)", CardValue: "\(self.itemPrice!.PriceCard)", ProviderId: "\(self.itemPrice!.TelecomName)", Quantity: "\(self.quantityValue)", TotalPurchasingAmount: "\(sumPurchasing)", TotalReferAmount: "\(self.total)", PhoneNumber: "\(self.phone)", xmlstringpay: "\(xml)", devicetype: "2", version: Common.versionApp(), codecrm: "\(crm ?? "")",isCheckPromotion:isCheckPromotion,OTPNumber:"\(OTPNumber)",ValuePromotion:"\(self.ValuePromotion)",is_HeThongHD:is_HeThongHD) { (result, err) in
                            
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                if(err.count <= 0){
                                    
                                    Cache.itemPriceCardTopup = self.itemPrice
                                    Cache.listVoucherCardTopup = self.listVoucher
                                    Cache.typeCashPaymentCardTopup = self.typeCashPayment
                                    Cache.typeCardPaymentCardTopup = self.typeCardPayment
                                    Cache.ValuePromotionCardTopup = self.ValuePromotion
                                    Cache.quantityValueCardTopup = self.quantityValue
                                    Cache.phoneCardTopup = self.phone
                                    Cache.typeCardTopup = self.type
                                    Cache.viettelPayCodeResult = result
                                    
                                    _ = self.navigationController?.popToRootViewController(animated: true)
                                    self.dismiss(animated: true, completion: nil)
                                    let nc = NotificationCenter.default
                                    nc.post(name: Notification.Name("showDetailSOCardTopup"), object: nil)
                                }else{
                                    let popup = PopupDialog(title: "Thông báo", message: "\(err)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    }
                                    let buttonOne = CancelButton(title: "OK") {
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                }
                            }
                        }
                    }else if(self.itemPrice!.TypeNCC == "PAYOO"){
                        MPOSAPIManager.GetPayooPayResult(UserID: "\(Cache.user!.UserName)", ShopCode: "\(Cache.user!.ShopCode)", CardValue: "\(self.itemPrice!.PriceCard)", ProviderId: "\(self.itemPrice!.TelecomName)", Quantity: "\(self.quantityValue)", TotalPurchasingAmount: "\(sumPurchasing)", TotalReferAmount: "\(self.total)", PhoneNumber: "\(self.phone)", xmlstringpay: "\(xml)", devicetype: "2", version: Common.versionApp(), codecrm: "\(crm ?? "")",isCheckPromotion:isCheckPromotion,OTPNumber:"\(OTPNumber)",ValuePromotion:"\(self.ValuePromotion)",is_HeThongHD:is_HeThongHD) { (result, resultHeader, err) in
                            
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                if(err.count <= 0){
                                    
                                    Cache.itemPriceCardTopup = self.itemPrice
                                    Cache.listVoucherCardTopup = self.listVoucher
                                    Cache.typeCashPaymentCardTopup = self.typeCashPayment
                                    Cache.typeCardPaymentCardTopup = self.typeCardPayment
                                    Cache.ValuePromotionCardTopup = self.ValuePromotion
                                    Cache.quantityValueCardTopup = self.quantityValue
                                    Cache.phoneCardTopup = self.phone
                                    Cache.typeCardTopup = self.type
                                    Cache.payooPayCodeResult = result
                                    Cache.payooPayCodeHeaderResult = resultHeader
                                    
                                    _ = self.navigationController?.popToRootViewController(animated: true)
                                    self.dismiss(animated: true, completion: nil)
                                    let nc = NotificationCenter.default
                                    nc.post(name: Notification.Name("showDetailSOCardTopup"), object: nil)
                                }else{
                                    let popup = PopupDialog(title: "Thông báo", message: "\(err)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    }
                                    let buttonOne = CancelButton(title: "OK") {
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                }
                            }
                        }
                    }else{
                        MPOSAPIManager.GetVietNamMobileTheCaoPayResult(UserID: "\(Cache.user!.UserName)", ShopCode: "\(Cache.user!.ShopCode)", CardValue: "\(self.itemPrice!.PriceCard)", ProviderId: "\(self.itemPrice!.TelecomName)", Quantity: "\(self.quantityValue)", TotalPurchasingAmount: "\(sumPurchasing)", TotalReferAmount: "\(self.total)", PhoneNumber: "\(self.phone)", xmlstringpay: "\(xml)", devicetype: "2", version: Common.versionApp(), codecrm: "\(crm ?? "")",is_HeThongHD:is_HeThongHD, handler: { (result, resultHeader, err) in
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                if(err.count <= 0){
                                    
                                    Cache.itemPriceCardTopup = self.itemPrice
                                    Cache.listVoucherCardTopup = self.listVoucher
                                    Cache.typeCashPaymentCardTopup = self.typeCashPayment
                                    Cache.typeCardPaymentCardTopup = self.typeCardPayment
                                    Cache.ValuePromotionCardTopup = self.ValuePromotion
                                    Cache.quantityValueCardTopup = self.quantityValue
                                    Cache.phoneCardTopup = self.phone
                                    Cache.typeCardTopup = self.type
                                    Cache.theCaoVietNamMobile = result
                                    Cache.theCaoVietNamMobileHeaders = resultHeader
                                    
                                    _ = self.navigationController?.popToRootViewController(animated: true)
                                    self.dismiss(animated: true, completion: nil)
                                    let nc = NotificationCenter.default
                                    nc.post(name: Notification.Name("showDetailSOCardTopup"), object: nil)
                                }else{
                                    let popup = PopupDialog(title: "Thông báo", message: "\(err)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    }
                                    let buttonOne = CancelButton(title: "OK") {
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                }
                            }
                        })
                    }
                }else{
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    }
                }
            }
        }else{//TOPUP
            
            
            let xml = self.parseXML()
            
            if((Cache.cashValueCardTopup + Cache.cardValueCardTopup) > total){
                
                let popup = PopupDialog(title: "Thông báo", message: "Số tiền bạn nhập không được lớn hơn tổng tiền cần thanh toán.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                }
                let buttonOne = CancelButton(title: "OK") {
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
                
                return
            }
            
            let popup = PopupDialog(title: "Thông báo", message: "Bạn có muốn thanh toán \(Common.convertCurrencyV2(value: total)) VNĐ vào số điện thoại \(phone) không?", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            
            let buttonOne = CancelButton(title: "Huỷ bỏ") {
                
            }
            let buttonTwo = DefaultButton(title: "Đồng ý thanh toán"){
                //
                let newViewController = LoadingViewController()
                newViewController.content = "Đang thanh toán..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                
                //
                if("\(self.itemPrice!.TypeNCC)" == "PAYOO" || "\(self.itemPrice!.TypeNCC)" == "EPAY"){
                    
                    MPOSAPIManager.GetTopUpPrice(phoneNumber: "\(self.phone)", cardValue: "\(self.itemPrice!.PriceCard)") { (result, err) in
                        if(result != nil){
                            let sumPurchasing = result!.PurchasingPrice
                            var isCheckPromotion = "0"
                            if(self.ValuePromotion > 0){
                                isCheckPromotion = "1"
                            }
                            MPOSAPIManager.GetPayooTopup(UserID: "\(Cache.user!.UserName)", ShopCode: "\(Cache.user!.ShopCode)", CardValue: "\(self.itemPrice!.PriceCard)", TotalPurchasingAmount: "\(sumPurchasing)", TotalReferAmount: "\(self.total)", PhoneNumber: "\(self.phone)", xmlstringpay: xml, devicetype: "2", version: Common.versionApp(), codecrm: "\(crm ?? "")",isCheckPromotion:isCheckPromotion,OTPNumber:"\(OTPNumber)",ValuePromotion:"\(self.ValuePromotion)", ProviderId: "\(self.itemPrice!.TelecomName)",is_HeThongHD:is_HeThongHD, handler: { (result, resultHeader, err) in
                                
                                let when = DispatchTime.now() + 0.5
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    
                                    if(err.count <= 0){
                                        Cache.itemPriceCardTopup = self.itemPrice
                                        Cache.listVoucherCardTopup = self.listVoucher
                                        Cache.typeCashPaymentCardTopup = self.typeCashPayment
                                        Cache.typeCardPaymentCardTopup = self.typeCardPayment
                                        Cache.ValuePromotionCardTopup = self.ValuePromotion
                                        Cache.quantityValueCardTopup = self.quantityValue
                                        Cache.phoneCardTopup = self.phone
                                        Cache.typeCardTopup = self.type
                                        Cache.payooTopupResultCardTopup = result
                                        Cache.payooPayCodeHeaderResult = resultHeader
                                        
                                        _ = self.navigationController?.popToRootViewController(animated: true)
                                        self.dismiss(animated: true, completion: nil)
                                        let nc = NotificationCenter.default
                                        nc.post(name: Notification.Name("showDetailSOCardTopup"), object: nil)
                                    }else{
                                        let popup = PopupDialog(title: "Thông báo", message: "\(err)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        }
                                        let buttonOne = CancelButton(title: "OK") {
                                        }
                                        popup.addButtons([buttonOne])
                                        self.present(popup, animated: true, completion: nil)
                                    }
                                    
                                }
                            })
                        }else{
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                let popup = PopupDialog(title: "Thông báo", message: "\(err)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }
                        }
                    }
                    
                }else if("\(self.itemPrice!.TypeNCC)" == "Viettel"){
                    let sumPurchasing = self.itemPrice!.Price
                    var isCheckPromotion = "0"
                    if(self.ValuePromotion > 0){
                        isCheckPromotion = "1"
                    }
                    //
                    let dateFormatter : DateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyyMMddHHmss"
                    let date = Date()
                    let dateString = dateFormatter.string(from: date)
                    
                    MPOSAPIManager.GetPayTeleChargeVTInfo(DocEntry:"mpos-getpay-\(Cache.user!.UserName)-\(dateString)",PhoneNumber:self.phone,SubId:"23", handler: { (resultCode, err) in
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            
                            
                            if(err.count <= 0){
                                if(resultCode == "K82"){
                                    MPOSAPIManager.getViettelPayTopup(UserID: "\(Cache.user!.UserName)", ShopCode: "\(Cache.user!.ShopCode)", CardValue: "\(self.itemPrice!.PriceCard)", ProviderId: "\(self.itemPrice!.TelecomName)", Quantity: "1", TotalPurchasingAmount: "\(sumPurchasing)", TotalReferAmount: "\(self.total)", PhoneNumber: "\(self.phone)", xmlstringpay: xml, devicetype: "2", version: Common.versionApp(), codecrm: "\(crm ?? "")", isCheckPromotion: isCheckPromotion, OTPNumber: "\(OTPNumber)", ValuePromotion: "\(self.ValuePromotion)", is_HeThongHD: is_HeThongHD, handler: { (result, err) in
                                        let when = DispatchTime.now() + 0.5
                                        DispatchQueue.main.asyncAfter(deadline: when) {
                                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                            
                                            if(err.count <= 0){
                                                Cache.itemPriceCardTopup = self.itemPrice
                                                Cache.listVoucherCardTopup = self.listVoucher
                                                Cache.typeCashPaymentCardTopup = self.typeCashPayment
                                                Cache.typeCardPaymentCardTopup = self.typeCardPayment
                                                Cache.ValuePromotionCardTopup = self.ValuePromotion
                                                Cache.quantityValueCardTopup = self.quantityValue
                                                Cache.phoneCardTopup = self.phone
                                                Cache.typeCardTopup = self.type
                                                Cache.viettelTopup = result
                                                
                                                _ = self.navigationController?.popToRootViewController(animated: true)
                                                self.dismiss(animated: true, completion: nil)
                                                let nc = NotificationCenter.default
                                                nc.post(name: Notification.Name("showDetailSOCardTopup"), object: nil)
                                            }else{
                                                let popup = PopupDialog(title: "Thông báo", message: "\(err)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                }
                                                let buttonOne = CancelButton(title: "OK") {
                                                }
                                                popup.addButtons([buttonOne])
                                                self.present(popup, animated: true, completion: nil)
                                            }
                                        }
                                    })
                                }else{
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    let popup = PopupDialog(title: "Thông báo", message: "Thuê bao trả sau Viettel không được TOPUP.  Vui lòng vào màn hình thu hộ thanh toán!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    }
                                    let buttonOne = CancelButton(title: "OK") {
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                }
                                
                                
                            }else{
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                let popup = PopupDialog(title: "Thông báo", message: "\(err)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }
                        }
                    })
                }else{
                    let sumPurchasing = self.itemPrice!.Price
                    var isCheckPromotion = "0"
                    if(self.ValuePromotion > 0){
                        isCheckPromotion = "1"
                    }
                    
                    MPOSAPIManager.GetTopupVNM(UserID: "\(Cache.user!.UserName)", ShopCode: "\(Cache.user!.ShopCode)", ProviderId: "\(self.itemPrice!.TelecomName)", CardValue: "\(self.itemPrice!.PriceCard)", TotalPurchasingAmount: "\(sumPurchasing)", TotalReferAmount: "\(self.total)", PhoneNumber: "\(self.phone)", xmlstringpay: xml, devicetype: "2", version: Common.versionApp(), codecrm: "\(crm ?? "")",isCheckPromotion:isCheckPromotion,OTPNumber:"\(OTPNumber)",ValuePromotion:"\(self.ValuePromotion)",is_HeThongHD:is_HeThongHD, handler: { (result, resultHeader, err) in
                        
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            if(err.count > 0){
                                let popup = PopupDialog(title: "Thông báo", message: "\(err)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }else{
                                Cache.itemPriceCardTopup = self.itemPrice
                                Cache.listVoucherCardTopup = self.listVoucher
                                Cache.typeCashPaymentCardTopup = self.typeCashPayment
                                Cache.typeCardPaymentCardTopup = self.typeCardPayment
                                Cache.ValuePromotionCardTopup = self.ValuePromotion
                                Cache.quantityValueCardTopup = self.quantityValue
                                Cache.phoneCardTopup = self.phone
                                Cache.typeCardTopup = self.type
                                Cache.payooTopupResultCardTopup = result
                                Cache.payooPayCodeHeaderResult = resultHeader
                                
                                _ = self.navigationController?.popToRootViewController(animated: true)
                                self.dismiss(animated: true, completion: nil)
                                let nc = NotificationCenter.default
                                nc.post(name: Notification.Name("showDetailSOCardTopup"), object: nil)
                            }
                            
                            
                        }
                    })
                }
            }
            popup.addButtons([buttonOne,buttonTwo])
            self.present(popup, animated: true, completion: nil)
        }
    }
    func parseXML()->String{
        var rs:String = "<line>"
        if(listVoucher.count > 0){
            for item in listVoucher {
                var name = item.u_VchName
                name = name.replace(target: "&", withString:"&#38;")
                name = name.replace(target: "<", withString:"&#60;")
                name = name.replace(target: ">", withString:"&#62;")
                name = name.replace(target: "\"", withString:"&#34;")
                name = name.replace(target: "'", withString:"&#39;")
                
                var num  = item.voucher
                num = num.replace(target: "&", withString:"&#38;")
                num = num.replace(target: "<", withString:"&#60;")
                num = num.replace(target: ">", withString:"&#62;")
                num = num.replace(target: "\"", withString:"&#34;")
                num = num.replace(target: "'", withString:"&#39;")
                
                var sPrice  = String(item.voucherprice)
                sPrice = sPrice.replace(target: "&", withString:"&#38;")
                sPrice = sPrice.replace(target: "<", withString:"&#60;")
                sPrice = sPrice.replace(target: ">", withString:"&#62;")
                sPrice = sPrice.replace(target: "\"", withString:"&#34;")
                sPrice = sPrice.replace(target: "'", withString:"&#39;")
                
                rs = rs + "<item Totalcash=\"\("")\"  Totalcardcredit=\"\("")\" Numcard=\"\("")\"  IDBankCard=\"\("")\" Numvoucher=\"\(num)\" TotalVoucher=\"\(sPrice)\" Namevoucher=\"\(name)\"/>"
            }
        }
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
            Cache.cashValueCardTopup = Int(moneyString)!
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
            rs = rs + "<item Totalcash=\"\("")\"  Totalcardcredit=\"\(moneyString)\" Numcard=\"\("")\"  IDBankCard=\"\("")\" Numvoucher=\"\("")\" TotalVoucher=\"\("0")\" Namevoucher=\"\("")\"/>"
            Cache.cardValueCardTopup = Int(moneyString)!
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
    
    @objc func actionBack() {
        Cache.cashValueCardTopup = 0
        Cache.cardValueCardTopup = 0
        self.navigationController?.popViewController(animated: true)
    }
}
