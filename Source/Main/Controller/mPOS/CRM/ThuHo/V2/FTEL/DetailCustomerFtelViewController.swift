//
//  DetailCustomerFtelViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 1/8/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Toaster
import PopupDialog
class DetailCustomerFtelViewController: UIViewController,UITextFieldDelegate,ListCardViewControllerDelegate{
  
    var province:Int = 0
    var parentNavigationController : UINavigationController?
    var phone:String = ""
    var ftelBillCustomer:FtelBillCustomer?
    var Contract:String = ""
    var address:String = ""
   
    var phoneView:UIView!
    var tfPhoneNumber:UITextField!
    var cardTypeFromPOSResult:CardTypeFromPOSResult?
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
        btBackIcon.addTarget(self, action: #selector(DetailCustomerFtelViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        self.title = "Chi tiết"
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
        lbValueKyTT.text = "\(ftelBillCustomer!.ListBill.count) kỳ"
        voucherView.addSubview(lbValueKyTT)
        
        
        
//        let imageView = UIImageView(frame: CGRect(x: voucherView.frame.size.width - voucherView.frame.size.height, y: voucherView.frame.size.height/2 - (voucherView.frame.size.height/2)/2, width: voucherView.frame.size.height, height: voucherView.frame.size.height/2));
//        imageView.contentMode = .scaleAspectFit;
//        imageView.image = #imageLiteral(resourceName: "More")
//        voucherView.addSubview(imageView)
//
//        let gestureList = UITapGestureRecognizer(target: self, action:  #selector(self.viewList))
//        voucherView.addGestureRecognizer(gestureList)
        
        
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
    @objc func viewList(sender : UITapGestureRecognizer) {
//        let vc = ListPaymentPeriodViewController()
//        vc.thuHoBill = thuHoBill
//        self.parentNavigationController?.pushViewController(vc, animated: true)
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
            typeCard.layer.borderWidth = 2
            typeCard.layer.borderColor = UIColor(netHex: 0x00955E).cgColor
            
            let vc = ListCardViewController()
            vc.delegate = self
            self.parentNavigationController?.pushViewController(vc, animated: true)
        }else{
            typeCard.backgroundColor = .white
            lbTypeCard.textColor = .black
            typeCard.layer.borderWidth = 1
            typeCard.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
            self.cardTypeFromPOSResult = nil
        }
        updatePrice()
    }
    func returnCard(item: CardTypeFromPOSResult, ind: Int) {
        self.cardTypeFromPOSResult = item
        updatePrice()
    }
    
    func returnClose() {
        typeCardPayment = !typeCardPayment
        if(typeCardPayment){
            typeCard.layer.borderWidth = 2
            typeCard.layer.borderColor = UIColor(netHex: 0x00955E).cgColor
            
            let vc = ListCardViewController()
            vc.delegate = self
            self.parentNavigationController?.pushViewController(vc, animated: true)
        }else{
            typeCard.backgroundColor = .white
            lbTypeCard.textColor = .black
            typeCard.layer.borderWidth = 1
            typeCard.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
            self.cardTypeFromPOSResult = nil
        }
        updatePrice()
    }
    func updatePrice(){
        var sum:Int =  0
        for item in ftelBillCustomer!.ListBill {
            sum = sum + item.Amount
        }
        var sumCardType:Double =  0
        if(cardTypeFromPOSResult != nil){
//            sumCardType = (Double(sum) * cardTypeFromPOSResult!.PercentFee)/100
            sumCardType = cardTypeFromPOSResult!.PercentFee
        }else{
            sumCardType = 0
        }
       self.lbTotalVoucherValue.text = "\(sumCardType) %"
//        self.lbTotalVoucherValue.text = "\(Common.convertCurrencyDouble(value: sumCardType.rounded(.up)))"
        self.lbTotalValue.text = "\(Common.convertCurrencyDouble(value: (Double(sum) + sumCardType).rounded(.up)))"
        
         self.lbTotalSumValue.text = "\(Common.convertCurrencyDouble(value: Double(sum)))"
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
        let vc = PaymentCustomerFtelViewController()
        vc.typeCashPayment = typeCashPayment
        vc.typeCardPayment = typeCardPayment
        vc.ValuePromotion = 0
        vc.phone = phone
        vc.cardTypeFromPOSResult = cardTypeFromPOSResult
        vc.parentNavigationController = parentNavigationController
        vc.ftelBillCustomer = ftelBillCustomer
        vc.Contract = Contract
        vc.province = province
        vc.address  = address
        self.parentNavigationController?.pushViewController(vc, animated: true)
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

