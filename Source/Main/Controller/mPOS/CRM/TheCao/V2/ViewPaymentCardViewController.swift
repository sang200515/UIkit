//
//  ViewPaymentCardViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/22/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Toaster
import PopupDialog
class ViewPaymentCardViewController: UIViewController,UITextFieldDelegate{
    var type:Int = 0 // 0: THE 1: TOPUP
    var itemPrice:ItemPrice?
    var quantityValue:Int = 1
    var phone:String = ""
    var ValuePromotion:Int = 0
    var cashValue:Int = 0
    var cardValue:Int = 0
    
    var payooPayCodeResult:PayooPayCodeResult?
    var payooPayCodeHeaderResult:PayooPayCodeHeaderResult?
    
    var theCaoVietNamMobile:TheCao_VietNamMobile?
    var theCaoVietNamMobileHeaders:TheCao_VietNamMobileHeaders?
    
    var payooTopupResult:PayooTopupResult?
    var viettelPayCodeResult:ViettelPayCodeResult?
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
    var promotionSimActive:PromotionActivedSim?
    var viettelTopup:ViettelPayTopup?
    var serialView:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.initNavigationBar()
        
        if(type == 0){
            if(itemPrice!.TypeNCC == "PAYOO"){
                self.title = "Thành công \(payooPayCodeResult!.SOMPOS)"
            }else if(itemPrice!.TypeNCC == "VNM"){
                self.title = "Thành công \(theCaoVietNamMobile!.DocEntry)"
            }else if(itemPrice!.TypeNCC == "Viettel"){
                self.title = "Thành công \(viettelPayCodeResult!.order_id)"
            }
        }else{
            if("\(self.itemPrice!.TypeNCC)" == "PAYOO" || "\(self.itemPrice!.TypeNCC)" == "EPAY"){
                self.title = "Thành công \(payooTopupResult!.SOMPOS)"
            }else if(itemPrice!.TypeNCC == "Viettel"){
                self.title = "Thành công \(viettelTopup!.order_id)"
            }else{
                if(theCaoVietNamMobile != nil){
                     self.title = "Thành công \(theCaoVietNamMobile!.DocEntry)"
                }
               
            }
        }
        
       
        
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(ViewPaymentCardViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        self.view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView = UIScrollView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - Common.Size(s: 123) - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: scrollView.frame.size.height)
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let footer = UIView()
        footer.frame = CGRect(x: 0, y:self.view.frame.size.height - Common.Size(s: 148) - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height) , width: self.view.frame.size.width, height: Common.Size(s: 148))
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
        
        //
        //lbIn
        let lbPrint = UILabel(frame: CGRect(x: Common.Size(s: 20), y: btNext.frame.origin.y - Common.Size(s: 5) - Common.Size(s: 20), width: footer.frame.size.width - Common.Size(s: 40), height: Common.Size(s: 15)))
//        lbPrint.text = "Chỉ nhấn IN khi cần thiết"
        lbPrint.textAlignment = .center
        lbPrint.font = UIFont.italicSystemFont(ofSize: 13)
        lbPrint.textColor = UIColor(red: 37/255, green: 146/255, blue: 75/255, alpha: 1)
        footer.addSubview(lbPrint)
        
        
        let lbTotal = UILabel(frame: CGRect(x: btNext.frame.origin.x, y: lbPrint.frame.origin.y - Common.Size(s: 10) - Common.Size(s: 16), width: btNext.frame.size.width/2, height: Common.Size(s:16)))
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
        lbTotalVoucher.text = "Giảm giá"
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
        if Cache.isCardPromotionTopup {
            lbValuePriceCard.text = "\(Common.convertCurrency(value: promotionSimActive!.CardValue))"
        } else {
            lbValuePriceCard.text = "\(Common.convertCurrency(value: itemPrice!.PriceCard))"
        }
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
        
        
        if Cache.isCardPromotionTopup {
            let cardPrice = promotionSimActive!.Price == 0 ? promotionSimActive?.CardValue : promotionSimActive!.Price
            lbValuePrice.text = "\(Common.convertCurrency(value: cardPrice!))"
        } else {
            lbValuePrice.text = "\(Common.convertCurrency(value: itemPrice!.Price))"
        }
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
            
            let lbPromotion = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: viewPro.frame.size.width/2 - Common.Size(s: 15), height: Common.Size(s: 30)))
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
            
            let characters = Array("\(cashValue)")
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
            let characters2 = Array("\(cardValue)")
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
        
        
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: typePaymentView.frame.size.height + typePaymentView.frame.origin.y + Common.Size(s: 10))
        
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
        if Cache.isCardPromotionTopup {
            sum = quantityValue * (promotionSimActive?.CardValue)!
        } else {
            sum = quantityValue * itemPrice!.Price
        }
        self.lbTotalSumValue.text = "\(Common.convertCurrency(value: sum))"
        var voucher:Int = promotionSimActive?.ValuePromotion ?? 0
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
        if(type == 0){
            if(itemPrice!.TypeNCC == "PAYOO"){
                if(self.payooPayCodeResult != nil && self.payooPayCodeHeaderResult != nil){
                    for item in self.payooPayCodeResult!.PayCodes {
                        let dateFormatter : DateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                        let date = Date()
                        let dateString = dateFormatter.string(from: date)
                        
                        var moneyString:String = "\(item.Expired)"
                        moneyString  = moneyString.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                        
                        let dateFormatter1 = DateFormatter()
                        dateFormatter1.dateFormat = "yyyy/MM/dd"
                        let dateEnd = dateFormatter1.date(from: moneyString)
                        dateFormatter1.dateFormat = "dd/MM/yyyy"
                        let dateEndString = dateFormatter1.string(from: dateEnd!)
                        
                        let printBillCard = PrintBillCard(Address:"\(Cache.user!.Address)", CardType: "\(self.payooPayCodeResult!.ProviderId)", FaceValue:"\(self.itemPrice!.PriceCard)", NumberCode:"\(item.CardId)", Serial: "\(item.SeriNumber)", ExpirationDate:"\(dateEndString)", ExportTime:"\(dateString)", SaleOrderCode:"\(self.payooPayCodeResult!.SOMPOS)", UserCode:"\(Cache.user!.UserName)", MaVoucher: "\(self.payooPayCodeHeaderResult!.u_vocher)", HanSuDung: "\(self.payooPayCodeHeaderResult!.Den_Ngay)")
                        MPOSAPIManager.pushBillCard(printBill: printBillCard)
                    }
                    Toast.init(text: "Đã gửi lệnh in!").show()
                }
            }else if(itemPrice!.TypeNCC == "VNM"){
                if(self.theCaoVietNamMobile != nil && self.theCaoVietNamMobileHeaders != nil){
                    
                    let dateFormatter : DateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                    let date = Date()
                    let dateString = dateFormatter.string(from: date)
                    
                    
                    let printBillCard = PrintBillCard(Address:"\(Cache.user!.Address)", CardType: "VietNamMobile", FaceValue:"\(self.itemPrice!.PriceCard)", NumberCode:"\(self.theCaoVietNamMobile!.Pin)", Serial: "\(self.theCaoVietNamMobile!.Serial)", ExpirationDate:"\(self.theCaoVietNamMobileHeaders!.Den_Ngay)", ExportTime:"\(dateString)", SaleOrderCode:"\(self.theCaoVietNamMobile!.DocEntry)", UserCode:"\(Cache.user!.UserName)", MaVoucher: "\(self.theCaoVietNamMobileHeaders!.u_vocher)", HanSuDung: "\(self.theCaoVietNamMobileHeaders!.Den_Ngay)")
                    MPOSAPIManager.pushBillCard(printBill: printBillCard)
                    
                    Toast.init(text: "Đã gửi lệnh in!").show()
                }
            }else if(itemPrice!.TypeNCC == "Viettel"){
                if(self.viettelPayCodeResult != nil ){
                    let dateFormatter : DateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                    let date = Date()
                    let dateString = dateFormatter.string(from: date)
                    
                    for item in viettelPayCodeResult!.billing_detail {
                        let printBillCard = PrintBillCard(Address:"\(Cache.user!.Address)", CardType: "\(self.itemPrice!.TelecomName)", FaceValue:"\(self.itemPrice!.PriceCard)", NumberCode:"\(item.pincode)", Serial: "\(item.serial)", ExpirationDate:"\(item.expire)", ExportTime:"\(dateString)", SaleOrderCode:"\(self.viettelPayCodeResult!.order_id)", UserCode:"\(Cache.user!.UserName)", MaVoucher: "\(self.viettelPayCodeResult!.u_vocher)", HanSuDung: "\(self.viettelPayCodeResult!.Den_Ngay)")
                        MPOSAPIManager.pushBillCard(printBill: printBillCard)
                    }

                    
                    
                    Toast.init(text: "Đã gửi lệnh in!").show()
                }
            }
            
        }else{
            if("\(self.itemPrice!.TypeNCC)" == "PAYOO" || "\(self.itemPrice!.TypeNCC)" == "EPAY"){
                let dateFormatter : DateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                let date = Date()
                let dateString = dateFormatter.string(from: date)
                
                let printBillCardTopUp = CardCodePayooTopUp(DiaChi: "\(Cache.user!.Address)",SoDienThoai: "\(payooTopupResult!.PrimaryAccount)",TenLoaiThe: "",MenhGiaThe: "\(payooTopupResult!.CardValue)",ThoiGianXuat: "\(dateString)",SoPhieuThu: "\(payooTopupResult!.InvoiceNo)", MaVoucher: "\(payooPayCodeHeaderResult!.u_vocher)",HanSuDung:"\(payooPayCodeHeaderResult!.Den_Ngay)")
                MPOSAPIManager.pushBillTopUpCard(printBill: printBillCardTopUp)
                
                Toast.init(text: "Đã gửi lệnh in!").show()
            }else if("\(self.itemPrice!.TypeNCC)" == "Viettel"){
                let dateFormatter : DateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                let date = Date()
                let dateString = dateFormatter.string(from: date)
                
                let printBillCardTopUp = CardCodePayooTopUp(DiaChi: "\(Cache.user!.Address)",SoDienThoai: "\(phone)",TenLoaiThe: "",MenhGiaThe: "\(viettelTopup!.amount)",ThoiGianXuat: "\(dateString)",SoPhieuThu: "\(viettelTopup!.order_id)", MaVoucher: "\(viettelTopup!.u_vocher)",HanSuDung:"\(viettelTopup!.Den_Ngay)")
                MPOSAPIManager.pushBillTopUpCard(printBill: printBillCardTopUp)
                
                Toast.init(text: "Đã gửi lệnh in!").show()
            }
        }
        Cache.itemPromotionActivedSim = nil
        Cache.itemPriceCardTopup = nil
        Cache.listVoucherCardTopup = []
        Cache.typeCashPaymentCardTopup = false
        Cache.typeCardPaymentCardTopup = false
        Cache.ValuePromotionCardTopup = 0
        Cache.quantityValueCardTopup = 0
        Cache.phoneCardTopup = ""
        Cache.typeCardTopup = 0
        Cache.payooPayCodeResult = nil
        Cache.payooPayCodeHeaderResult = nil
        Cache.cashValueCardTopup = 0
        Cache.cardValueCardTopup = 0
        Cache.theCaoVietNamMobile = nil
        Cache.theCaoVietNamMobileHeaders = nil
        Cache.payooTopupResultCardTopup = nil
         self.dismiss(animated: true, completion: nil)
    }

    @objc func actionBack() {
        self.dismiss(animated: true, completion: nil)
    }
}
