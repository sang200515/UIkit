//
//  DetailCardViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/21/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Toaster
import PopupDialog
class DetailCardViewController: UIViewController,UITextFieldDelegate{
    var parentNavigationController : UINavigationController?
    var type:Int = 0 // 0: THE 1: TOPUP
    var itemPrice:ItemPrice?
    var quantityValue:Int = 1
    var phone:String = ""
    var isTopUp = false
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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.initNavigationBar()
        listVoucher = []
        typeCashPayment = true
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
        if(type == 0){
            self.title = "Mã thẻ"
        }else{
            self.title = "Topup"
        }
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
        if(phone.isEmpty || isTopUp == false){
            btNext.setTitle("THANH TOÁN",for: .normal)
        }else{
            btNext.setTitle("KIỂM TRA KHUYẾN MÃI",for: .normal)
        }
        
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
        lbTotalVoucher.text = "Mã giảm giá"
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
        lbValuePriceCard.text = "\(Common.convertCurrency(value: itemPrice!.PriceCard))"
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
        lbValuePrice.text = "\(Common.convertCurrency(value: itemPrice!.Price))"
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
        
        if(type == 1){
            lbQuantity.frame.size.height = 0
            lbValueQuantity.frame.size.height = 0
            lbQuantity.frame.origin.y = lbPrice.frame.origin.y + lbPrice.frame.size.height
        }
        
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
        let label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: detailView.frame.origin.y + detailView.frame.size.height, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label2.text = "MÃ GIẢM GIÁ"
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label2)
        
        voucherView = UIView()
        voucherView.frame = CGRect(x: 0, y:label2.frame.origin.y + label2.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 150))
        voucherView.backgroundColor = UIColor.white
        scrollView.addSubview(voucherView)
        //--
        listVoucherView = UIView()
        listVoucherView.frame = CGRect(x: 0, y: 0, width: voucherView.frame.size.width, height: 0)
        voucherView.addSubview(listVoucherView)
        //--
        boxVoucherView = UIView()
        boxVoucherView.frame = CGRect(x: 0, y: listVoucherView.frame.size.height + listVoucherView.frame.origin.y + Common.Size(s: 10), width: voucherView.frame.size.width, height: Common.Size(s: 30))
        voucherView.addSubview(boxVoucherView)
        
        tfVoucher = UITextField(frame: CGRect(x: Common.Size(s: 15), y: 0, width: boxVoucherView.frame.size.width * 2/3 - Common.Size(s: 15) , height: boxVoucherView.frame.size.height))
        tfVoucher.placeholder = ""
        tfVoucher.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfVoucher.borderStyle = UITextField.BorderStyle.roundedRect
        tfVoucher.autocorrectionType = UITextAutocorrectionType.no
        tfVoucher.keyboardType = UIKeyboardType.default
        tfVoucher.returnKeyType = UIReturnKeyType.done
        tfVoucher.clearButtonMode = UITextField.ViewMode.whileEditing
        tfVoucher.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfVoucher.delegate = self
        boxVoucherView.addSubview(tfVoucher)
        
        let btCheckVoucher = UIButton(frame: CGRect(x: tfVoucher.frame.origin.x + tfVoucher.frame.size.width + Common.Size(s: 15), y: 0, width: boxVoucherView.frame.size.width - (tfVoucher.frame.origin.x + tfVoucher.frame.size.width + Common.Size(s: 15)) - Common.Size(s: 15), height: boxVoucherView.frame.size.height))
        btCheckVoucher.layer.cornerRadius = 5
        btCheckVoucher.setTitle("Áp dụng",for: .normal)
        btCheckVoucher.titleLabel?.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        btCheckVoucher.backgroundColor = UIColor.init(netHex: 0x00955E)
        boxVoucherView.addSubview(btCheckVoucher)
        btCheckVoucher.addTarget(self, action:#selector(self.checkVoucher), for: .touchUpInside)
        
        //--
        voucherView.frame.size.height = boxVoucherView.frame.size.height + boxVoucherView.frame.origin.y + Common.Size(s: 10)
        
        viewBottomVoucher = UIView()
        viewBottomVoucher.frame = CGRect(x: 0, y: voucherView.frame.size.height + voucherView.frame.origin.y, width: voucherView.frame.size.width, height: 0)
        scrollView.addSubview(viewBottomVoucher)
        viewBottomVoucher.backgroundColor = .clear
        
        let label3 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label3.text = "HÌNH THỨC THANH TOÁN"
        label3.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewBottomVoucher.addSubview(label3)
        
        let viewTypePayment = UIView()
        viewTypePayment.frame = CGRect(x: 0, y: label3.frame.size.height + label3.frame.origin.y, width: viewBottomVoucher.frame.size.width, height: Common.Size(s: 55))
        viewBottomVoucher.addSubview(viewTypePayment)
        viewTypePayment.backgroundColor = .white
        
        typeCash = UIView()
        typeCash.frame = CGRect(x: viewBottomVoucher.frame.size.width/10, y: Common.Size(s: 10), width: (viewBottomVoucher.frame.size.width * 7/10)/2, height: Common.Size(s: 35))
        typeCash.backgroundColor = UIColor.white
        typeCash.layer.masksToBounds = false
        typeCash.layer.cornerRadius = 5
        typeCash.layer.borderWidth = 1
        typeCash.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        typeCash.clipsToBounds = true
        viewTypePayment.addSubview(typeCash)
        
        lbTypeCash = UILabel(frame: CGRect(x: 0, y: 0, width: typeCash.frame.size.width, height: typeCash.frame.size.height))
        lbTypeCash.textAlignment = .center
        lbTypeCash.textColor = UIColor.black
        lbTypeCash.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTypeCash.text = "TIỀN MẶT"
        typeCash.addSubview(lbTypeCash)
        let tapCash = UITapGestureRecognizer(target: self, action: #selector(typeCashTapped(tapGestureRecognizer:)))
        typeCash.isUserInteractionEnabled = true
        typeCash.addGestureRecognizer(tapCash)
        
        if(typeCashPayment){
//            typeCash.backgroundColor = UIColor(netHex: 0x00955E)
//            lbTypeCash.textColor = .white
            typeCash.layer.borderWidth = 2
            typeCash.layer.borderColor = UIColor(netHex: 0x00955E).cgColor
        }
//        let triangle = TriangleView(frame: CGRect(x: -(typeCash.frame.size.height/4), y: typeCash.frame.size.height/2, width: typeCash.frame.size.height/2 , height: typeCash.frame.size.height/2))
//        triangle.backgroundColor = .white
//        typeCash.addSubview(triangle)

       typeCard = UIView()
        typeCard.frame = CGRect(x: typeCash.frame.origin.x + typeCash.frame.size.width + viewBottomVoucher.frame.size.width/10, y: Common.Size(s: 10), width: (viewBottomVoucher.frame.size.width * 7/10)/2, height: Common.Size(s: 35))
        typeCard.backgroundColor = UIColor.white
        typeCard.layer.masksToBounds = false
        typeCard.layer.cornerRadius = 5
        typeCard.layer.borderWidth = 1
        typeCard.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        typeCard.clipsToBounds = true
        viewTypePayment.addSubview(typeCard)
        
        let tapCard = UITapGestureRecognizer(target: self, action: #selector(typeCardTapped(tapGestureRecognizer:)))
        typeCard.isUserInteractionEnabled = true
        typeCard.addGestureRecognizer(tapCard)
        
        lbTypeCard = UILabel(frame: CGRect(x: 0, y: 0, width: typeCard.frame.size.width, height: typeCard.frame.size.height))
        lbTypeCard.textAlignment = .center
        lbTypeCard.textColor = UIColor.black
        lbTypeCard.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTypeCard.text = "THẺ"
        typeCard.addSubview(lbTypeCard)
        
        if(typeCardPayment){
            typeCard.backgroundColor = UIColor(netHex: 0x00955E)
            lbTypeCard.textColor = .white
            typeCard.layer.borderColor = UIColor.white.cgColor
        }
        
        viewBottomVoucher.frame.size.height = viewTypePayment.frame.size.height + viewTypePayment.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewBottomVoucher.frame.size.height + viewBottomVoucher.frame.origin.y + Common.Size(s: 10))
        
        updatePrice()
    }
    @objc func typeCashTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if((!typeCashPayment) == false && !typeCardPayment){
            return
        }
        typeCashPayment = !typeCashPayment
        if(typeCashPayment){
//            typeCash.backgroundColor = UIColor(netHex: 0x00955E)
//            lbTypeCash.textColor = .white
            typeCash.layer.borderWidth = 2
            typeCash.layer.borderColor = UIColor(netHex: 0x00955E).cgColor
        }else{
            typeCash.backgroundColor = UIColor.white
            lbTypeCash.textColor = .black
            typeCash.layer.borderWidth = 1
            typeCash.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        }
    }
    @objc func typeCardTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if((!typeCardPayment) == false && !typeCashPayment){
            return
        }
        typeCardPayment = !typeCardPayment
        if(typeCardPayment){
//            typeCard.backgroundColor = UIColor(netHex: 0x00955E)
//            lbTypeCard.textColor = .white
            typeCard.layer.borderWidth = 2
            typeCard.layer.borderColor = UIColor(netHex: 0x00955E).cgColor
        }else{
            typeCard.backgroundColor = .white
            lbTypeCard.textColor = .black
            typeCard.layer.borderWidth = 1
            typeCard.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        }
    }
    func updatePrice(){
        if(type == 0){
            let sum = quantityValue * itemPrice!.Price
            self.lbTotalSumValue.text = "\(Common.convertCurrency(value: sum))"
            var voucher:Int = 0
            for item in listVoucher {
                voucher = voucher + item.voucherprice
            }
            self.lbTotalVoucherValue.text = "-\(Common.convertCurrency(value: voucher))"
            var total:Int = sum - voucher
            if(total < 0){
                total = 0
            }
            self.lbTotalValue.text = "\(Common.convertCurrency(value: total))"
        }else{
             let sum = itemPrice!.Price
            
            self.lbTotalSumValue.text = "\(Common.convertCurrency(value: sum))"
            var voucher:Int = 0
            for item in listVoucher {
                voucher = voucher + item.voucherprice
            }
            self.lbTotalVoucherValue.text = "-\(Common.convertCurrency(value: voucher))"
            var total:Int = sum - voucher
            if(total < 0){
                total = 0
            }
            self.lbTotalValue.text = "\(Common.convertCurrency(value: total))"
        }
    }
    
    func updateUIVoucher(){
        self.tfVoucher.text = ""
        self.listVoucherView.subviews.forEach { $0.removeFromSuperview() }
        if(listVoucher.count > 0){
            listVoucherView.frame.origin.y = Common.Size(s: 10)
            var yValue:CGFloat = 0
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
                
                let lbPrice = UILabel(frame: CGRect(x: lbVoucher.frame.origin.x + lbVoucher.frame.size.width, y: 0, width: (voucher.frame.size.width - (voucher.frame.size.height * 2))/2 - Common.Size(s: 10), height: voucher.frame.size.height))
                lbPrice.text = "-\(Common.convertCurrency(value: item.voucherprice))"
                lbPrice.textColor = UIColor.red
                lbPrice.textAlignment = .right
                lbPrice.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
                voucher.addSubview(lbPrice)
                
                var iconDelete = UIImageView()
                iconDelete = UIImageView(frame: CGRect(x: lbPrice.frame.origin.x + lbPrice.frame.size.width + Common.Size(s: 10), y: voucher.frame.size.height/2 - (voucher.frame.size.height * 2/3)/2, width: voucher.frame.size.height, height: voucher.frame.size.height * 2/3))
                iconDelete.contentMode = .scaleAspectFit
                iconDelete.image = #imageLiteral(resourceName: "delete_red")
                voucher.addSubview(iconDelete)
                iconDelete.tag = stt - 1
                let tapDetete = UITapGestureRecognizer(target: self, action: #selector(deleteTapped(tapGestureRecognizer:)))
                iconDelete.isUserInteractionEnabled = true
                iconDelete.addGestureRecognizer(tapDetete)
  
                yValue = yValue + voucher.frame.size.height + 1
                stt = stt + 1
            }
            listVoucherView.frame.size.height = yValue
            boxVoucherView.frame.origin.y = listVoucherView.frame.size.height + listVoucherView.frame.origin.y + Common.Size(s: 10)
            voucherView.frame.size.height = boxVoucherView.frame.size.height + boxVoucherView.frame.origin.y + Common.Size(s: 10)
            viewBottomVoucher.frame.origin.y = voucherView.frame.size.height + voucherView.frame.origin.y
            
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewBottomVoucher.frame.size.height + viewBottomVoucher.frame.origin.y + Common.Size(s: 10))
        }else{
            listVoucherView.frame.origin.y = 0
            listVoucherView.frame.size.height = 0
            boxVoucherView.frame.origin.y = listVoucherView.frame.size.height + listVoucherView.frame.origin.y + Common.Size(s: 10)
            voucherView.frame.size.height = boxVoucherView.frame.size.height + boxVoucherView.frame.origin.y + Common.Size(s: 10)
            
            viewBottomVoucher.frame.origin.y = voucherView.frame.size.height + voucherView.frame.origin.y
                
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewBottomVoucher.frame.size.height + viewBottomVoucher.frame.origin.y + Common.Size(s: 10))
        }
        updatePrice()
    }
    @objc func deleteTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let pos: Int = tappedImage.tag
        listVoucher.remove(at: pos)
        updateUIVoucher()
    }
    @objc func payAction(_ sender:UITapGestureRecognizer){
        self.tfVoucher.text = ""
        self.tfVoucher.resignFirstResponder()
        if(phone.isEmpty || isTopUp == false){
            let vc = PaymentCardViewController()
            vc.isPromotion = false
            vc.itemPrice = itemPrice
            vc.listVoucher = listVoucher
            vc.typeCashPayment = typeCashPayment
            vc.typeCardPayment = typeCardPayment
            vc.ValuePromotion = 0
            vc.phone = phone
            vc.type = self.type
             vc.quantityValue = self.quantityValue
            vc.parentNavigationController = parentNavigationController
            self.parentNavigationController?.pushViewController(vc, animated: true)
        }else{
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra khuyến mãi.."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            MPOSAPIManager.checkpromotionActivedSim(Provider: "\(itemPrice!.TelecomName)", CardValue: "\(itemPrice!.PriceCard)", Phonenumber: phone, Quantityuse: "\(quantityValue)") { (results, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(results.count > 0){
                        let item = results[0]
                        if(item.Result == 1){
                            let popup = PopupDialog(title: "Thông báo", message: "\(item.Message)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                let vc = PaymentCardViewController()
                                vc.itemPrice = self.itemPrice
                                vc.listVoucher = self.listVoucher
                                vc.typeCashPayment = self.typeCashPayment
                                vc.typeCardPayment = self.typeCardPayment
                                vc.ValuePromotion = item.ValuePromotion
                                vc.quantityValue = self.quantityValue
                                //                                vc.cardPrice = item.Price
                                //                                vc.cardValue = item.CardValue
                                vc.phone = self.phone
                                vc.type = self.type
                                vc.isPromotion = true
                                Cache.isCardPromotionTopup = true
                                vc.promotionActivedSim = item
                                Cache.itemPromotionActivedSim = item
                                vc.parentNavigationController = self.parentNavigationController
                                self.parentNavigationController?.pushViewController(vc, animated: true)
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }else{ // Result == 0
                            if(item.Message != ""){
                                let popup = PopupDialog(title: "Thông báo", message: "\(item.Message)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                    let vc = PaymentCardViewController()
                                    vc.itemPrice = self.itemPrice
                                    vc.listVoucher = self.listVoucher
                                    vc.typeCashPayment = self.typeCashPayment
                                    vc.typeCardPayment = self.typeCardPayment
                                    vc.ValuePromotion = item.ValuePromotion
                                    vc.quantityValue = self.quantityValue
                                    //                            vc.cardPrice = item.Price
                                    //                            vc.cardValue = item.CardValue
                                    vc.phone = self.phone
                                    vc.type = self.type
                                    vc.isPromotion = false
                                    Cache.isCardPromotionTopup = false
                                    vc.promotionActivedSim = item
                                    Cache.itemPromotionActivedSim = item
                                    vc.parentNavigationController = self.parentNavigationController
                                    self.parentNavigationController?.pushViewController(vc, animated: true)
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }else{
                                let vc = PaymentCardViewController()
                                vc.itemPrice = self.itemPrice
                                vc.listVoucher = self.listVoucher
                                vc.typeCashPayment = self.typeCashPayment
                                vc.typeCardPayment = self.typeCardPayment
                                vc.ValuePromotion = item.ValuePromotion
                                vc.quantityValue = self.quantityValue
                                //                            vc.cardPrice = item.Price
                                //                            vc.cardValue = item.CardValue
                                vc.phone = self.phone
                                vc.type = self.type
                                vc.isPromotion = false
                                Cache.isCardPromotionTopup = false
                                vc.promotionActivedSim = item
                                Cache.itemPromotionActivedSim = item
                                vc.parentNavigationController = self.parentNavigationController
                                self.parentNavigationController?.pushViewController(vc, animated: true)
                            }
                        }
                    }else{
                        let popup = PopupDialog(title: "Thông báo", message: "Kiểm tra khuyến mãi thất bại.\r\nBạn vui lòng thử lại sau", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
    @objc func checkVoucher(_ sender:UITapGestureRecognizer){
        tfVoucher.resignFirstResponder()
        var voucher:String = tfVoucher.text!
        voucher = voucher.uppercased().trim()
        if(!voucher.isEmpty){
            var check:Bool = true
            if(listVoucher.count > 0){
                for item in listVoucher {
                    if(item.voucher == "\(voucher)"){
                        check = false
                        break
                    }
                }
            }
            if(!check){
                Toast(text: "Mã giảm giá đã tồn tại").show()
                return
            }
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra mã giảm giá..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            MPOSAPIManager.GetCheckVoucher(userID: "\(Cache.user!.UserName)", voucherNum: voucher) { (result, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(result != nil){
                        self.listVoucher.append(result!)
                        self.updateUIVoucher()
                    }else{
                        var msg = "Không tìm thấy thông tin mã giảm giá."
                        if(err.count > 0){
                            msg = err
                        }
                        let popup = PopupDialog(title: "Thông báo", message: msg, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
            }
        }else{
            Toast(text: "Bạn chưa nhập mã giảm giá").show()
        }
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
class TriangleView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
        context.closePath()
        
        context.setFillColor(UIColor(netHex: 0x00955E).cgColor)
        context.fillPath()
    }
}
