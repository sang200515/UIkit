//
//  DetailBillViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/30/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Toaster
import PopupDialog
class DetailBillViewController: UIViewController,UITextFieldDelegate,ListCardViewControllerDelegate,ListPaymentPeriodPayooViewControllerDelegate{

    
    var parentNavigationController : UINavigationController?
    var phone:String = ""
    var total:Int = 0
    //----
    var thuHoBill:ThuHoBill?
    var thuHoService: ThuHoService?
    var thuHoProvider: ThuHoProvider?
    var contractCode: String = ""
    
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
    var viewBottomVoucher:UIView!
    var typeCard:UIView!
    var typeCash:UIView!
    var lbTypeCash:UILabel!
    var lbTypeCard:UILabel!
    var typeCashPayment:Bool = false
    var typeCardPayment:Bool = false
    
    var cardTypeFromPOSResult:CardTypeFromPOSResult?
    var sumAll:Int = 0
    
    var lbValueKyTT:UILabel!
    var lbValueTotal:UILabel!
    var itemThuHoSmartpayCheckInfo: CheckInfoTHSmartPay?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.initNavigationBar()
        listVoucher = []
        typeCashPayment = true
        sumAll = 0
        //---
        for item in (thuHoBill?.ListDetailPayoo ?? []) {
            if(item.IsCheck == "true" || item.IsCheck == "True"){
                self.ListDetailPayooSelect.append(item)
            }
        }
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
        lbValuePriceCard.text = "\(thuHoService?.PaymentBillServiceName ?? "")"
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
        
        let lbValueQuantity = UILabel(frame: CGRect(x: detailView.frame.size.width/3, y: lbQuantity.frame.origin.y, width: detailView.frame.size.width * 2/3 - lbPrice.frame.origin.x, height: lbValuePriceCard.frame.size.height))
        lbValueQuantity.text = "\(thuHoBill?.CustomerName ?? "")"
        lbValueQuantity.textColor = UIColor.black
        lbValueQuantity.textAlignment = .right
        lbValueQuantity.lineBreakMode = .byTruncatingHead
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
//        total = updatePrice()
        
        let labelMoreInfo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: detailView.frame.size.height + detailView.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labelMoreInfo.text = "THÔNG TIN THÊM"
        labelMoreInfo.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(labelMoreInfo)
        
        
        let viewMoreInfo = UIView()
        viewMoreInfo.frame = CGRect(x: 0, y:labelMoreInfo.frame.origin.y + labelMoreInfo.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewMoreInfo.backgroundColor = UIColor.white
        scrollView.addSubview(viewMoreInfo)
        
        let lbInfoMore = UILabel(frame: CGRect(x: lbPrice.frame.origin.x, y: Common.Size(s: 10), width: lbPrice.frame.size.width, height: lbPrice.frame.size.height))
        lbInfoMore.text = "Thông tin thêm"
        lbInfoMore.textColor = UIColor.lightGray
        lbInfoMore.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        viewMoreInfo.addSubview(lbInfoMore)
        
        let lbValueInfoMore = UILabel(frame: CGRect(x: detailView.frame.size.width/3, y: lbInfoMore.frame.origin.y, width: viewMoreInfo.frame.size.width * 2/3 - lbInfoMore.frame.origin.x, height: lbValuePriceCard.frame.size.height))
        lbValueInfoMore.text = "\(thuHoBill?.CustomerInfo ?? "")"
        lbValueInfoMore.textColor = UIColor.black
        lbValueInfoMore.textAlignment = .right
        lbValueInfoMore.lineBreakMode = .byTruncatingHead
        lbValueInfoMore.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        viewMoreInfo.addSubview(lbValueInfoMore)
        
        let lbValueInfoMoreHeight:CGFloat = lbValueInfoMore.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbValueInfoMore.optimalHeight
        lbValueInfoMore.numberOfLines = 0
        lbValueInfoMore.frame = CGRect(x: lbValueInfoMore.frame.origin.x, y: lbValueInfoMore.frame.origin.y, width: lbValueInfoMore.frame.width, height: lbValueInfoMoreHeight)
        var lstPaymentRange = [String]()
        let paymentRange = self.thuHoBill?.PaymentRange ?? ""
        if(paymentRange != ""){
            lstPaymentRange = paymentRange.components(separatedBy: "-")
        }
        
        let lbInfoPaymentRange = UILabel(frame: CGRect(x: lbPrice.frame.origin.x, y: lbValueInfoMore.frame.size.height + lbValueInfoMore.frame.origin.y + Common.Size(s:10), width: self.view.frame.size.width - Common.Size(s: 10), height: lbPrice.frame.size.height))
        if(lstPaymentRange.count == 2){
            lbInfoPaymentRange.text = "Quý khách có thể thay đổi số tiền thanh toán, giời hạn từ \(lstPaymentRange[0]) đến \(lstPaymentRange[1])"
        }
        
        lbInfoPaymentRange.textColor = UIColor.lightGray
        lbInfoPaymentRange.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        viewMoreInfo.addSubview(lbInfoPaymentRange)
        
        let lbInfoPaymentRangeHeight:CGFloat = lbInfoPaymentRange.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbInfoPaymentRange.optimalHeight
        lbInfoPaymentRange.numberOfLines = 0
        lbInfoPaymentRange.frame = CGRect(x: lbInfoPaymentRange.frame.origin.x, y: lbInfoPaymentRange.frame.origin.y, width: lbInfoPaymentRange.frame.width, height: lbInfoPaymentRangeHeight)
        
        viewMoreInfo.frame.size.height = lbInfoPaymentRange.frame.size.height + lbInfoPaymentRange.frame.origin.y + Common.Size(s:10)
        //------------
        if self.thuHoProvider?.PartnerUserCode.trim() == "0051" { //smartpay
            labelMoreInfo.isHidden = true
            viewMoreInfo.isHidden = true
            labelMoreInfo.frame = CGRect(x: labelMoreInfo.frame.origin.x, y: detailView.frame.size.height + detailView.frame.origin.y, width: labelMoreInfo.frame.width, height: 0)
            
            viewMoreInfo.frame = CGRect(x: viewMoreInfo.frame.origin.x, y: labelMoreInfo.frame.origin.y + labelMoreInfo.frame.size.height, width: viewMoreInfo.frame.width, height: 0)
        } else {
            labelMoreInfo.isHidden = false
            viewMoreInfo.isHidden = false
            
            labelMoreInfo.frame = CGRect(x: labelMoreInfo.frame.origin.x, y: detailView.frame.size.height + detailView.frame.origin.y, width: labelMoreInfo.frame.width, height: Common.Size(s: 35))
            
            viewMoreInfo.frame = CGRect(x: viewMoreInfo.frame.origin.x, y: labelMoreInfo.frame.origin.y + labelMoreInfo.frame.size.height, width: viewMoreInfo.frame.width, height: lbInfoPaymentRange.frame.size.height + lbInfoPaymentRange.frame.origin.y + Common.Size(s:10))
        }
        //-----------------
        
        let label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewMoreInfo.frame.origin.y + viewMoreInfo.frame.size.height, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
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
        
        lbValueKyTT = UILabel(frame: CGRect(x: voucherView.frame.size.width - voucherView.frame.size.height - voucherView.frame.size.height, y: 0, width: voucherView.frame.size.height, height: voucherView.frame.size.height))
        lbValueKyTT.textAlignment = .right
        lbValueKyTT.textColor = UIColor.black
        lbValueKyTT.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbValueKyTT.text = "\(ListDetailPayooSelect.count) kỳ"
        voucherView.addSubview(lbValueKyTT)
        
        let imageView = UIImageView(frame: CGRect(x: voucherView.frame.size.width - voucherView.frame.size.height, y: voucherView.frame.size.height/2 - (voucherView.frame.size.height/2)/2, width: voucherView.frame.size.height, height: voucherView.frame.size.height/2));
        imageView.contentMode = .scaleAspectFit;
        imageView.image = #imageLiteral(resourceName: "More")
        voucherView.addSubview(imageView)
        
        let gestureList = UITapGestureRecognizer(target: self, action:  #selector(self.viewList))
        voucherView.addGestureRecognizer(gestureList)
        
        //--------------
        
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
        
        viewBottomVoucher = UIView()
        viewBottomVoucher.frame = CGRect(x: 0, y: voucherView.frame.size.height + voucherView.frame.origin.y, width: voucherView.frame.size.width, height: 0)
        scrollView.addSubview(viewBottomVoucher)
        viewBottomVoucher.backgroundColor = .clear
        
        let label4 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label4.text = "THANH TOÁN"
        label4.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewBottomVoucher.addSubview(label4)
        
        let viewPayment = UIView()
        viewPayment.frame = CGRect(x: 0, y: label4.frame.size.height + label4.frame.origin.y, width: viewBottomVoucher.frame.size.width, height: Common.Size(s: 50))
        viewBottomVoucher.addSubview(viewPayment)
        viewPayment.backgroundColor = .white
        
        let lbTotalAll = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 5), width: (viewPayment.frame.size.width - Common.Size(s: 30))/3, height: Common.Size(s: 20)))
        lbTotalAll.text = "Tổng"
        lbTotalAll.textColor = UIColor.lightGray
        lbTotalAll.textAlignment = .left
        lbTotalAll.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        viewPayment.addSubview(lbTotalAll)
        
        
        lbValueTotal = UILabel(frame: CGRect(x: lbTotalAll.frame.size.width + lbTotalAll.frame.origin.x, y: lbTotalAll.frame.origin.y , width: (viewPayment.frame.size.width - Common.Size(s: 30)) * 2/3, height: lbTotalAll.frame.size.height))
        lbValueTotal.text = "0đ"
        lbValueTotal.textColor = UIColor.black
        lbValueTotal.textAlignment = .right
        lbValueTotal.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        viewPayment.addSubview(lbValueTotal)
        
        let line = UIView()
        line.frame = CGRect(x: Common.Size(s: 15), y: lbTotalAll.frame.size.height + lbTotalAll.frame.origin.y + Common.Size(s: 5), width: viewPayment.frame.size.width - Common.Size(s: 30), height: 1)
        viewPayment.addSubview(line)
        line.backgroundColor = UIColor(netHex: 0xEEEEEE)
        
        let lbPhone = UILabel(frame: CGRect(x: Common.Size(s: 15), y: line.frame.origin.y + line.frame.size.height + Common.Size(s: 10), width: viewPayment.frame.size.width/3 - Common.Size(s: 15), height: Common.Size(s:30)))
        lbPhone.textAlignment = .left
        lbPhone.textColor = UIColor.black
        lbPhone.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbPhone.text = "Thanh toán"
        viewPayment.addSubview(lbPhone)
        
        tfPhoneNumber = UITextField(frame: CGRect(x: lbPhone.frame.origin.x + lbPhone.frame.size.width, y: lbPhone.frame.origin.y, width: viewPayment.frame.size.width * 2/3 - Common.Size(s: 15) , height: Common.Size(s:30)))
        tfPhoneNumber.placeholder = ""
        tfPhoneNumber.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfPhoneNumber.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhoneNumber.autocorrectionType = UITextAutocorrectionType.no
        tfPhoneNumber.keyboardType = UIKeyboardType.numberPad
        tfPhoneNumber.returnKeyType = UIReturnKeyType.done
        tfPhoneNumber.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPhoneNumber.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhoneNumber.delegate = self
        tfPhoneNumber.textAlignment = .right
        viewPayment.addSubview(tfPhoneNumber)
        tfPhoneNumber.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        var sum:Int = 0
        if self.thuHoProvider?.PartnerUserCode.trim() == "0051" { //smartpay
            sum = Int(self.itemThuHoSmartpayCheckInfo?.overdueAmount ?? "0") ?? 0
            self.lbValueTotal.text = self.convertTypeMoneyString(number: self.itemThuHoSmartpayCheckInfo?.overdueAmount ?? "0")
        } else {
            for item in ListDetailPayooSelect {
                sum = sum + item.TotalAmount
            }
        }
        
        let characters = Array("\(sum)")
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
            tfPhoneNumber.text = str
        }else{
            tfPhoneNumber.text = ""
        }
        
        if(thuHoBill?.PaymentRule == 1){
            lbTotalAll.text = "Loại TT"
            lbValueTotal.text = "Tất cả"
            tfPhoneNumber.isEnabled = false
        }else if(thuHoBill?.PaymentRule == 2){
            lbTotalAll.text = "Loại TT"
            lbValueTotal.text = "Cũ nhất hoặc tất cả"
            tfPhoneNumber.isEnabled = false
        }else if(thuHoBill?.PaymentRule == 3){
            lbTotalAll.text = "Loại TT"
            lbValueTotal.text = "Hoá đơn bất kỳ"
            tfPhoneNumber.isEnabled = false
        }else if(thuHoBill?.PaymentRule == 5){
            lbTotalAll.text = "Tổng"
            lbValueTotal.text =  "0đ"
            tfPhoneNumber.isEnabled = true
        }
        
        viewPayment.frame.size.height = tfPhoneNumber.frame.origin.y + tfPhoneNumber.frame.size.height + Common.Size(s: 10)
        
        
        let label3 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewPayment.frame.origin.y + viewPayment.frame.size.height, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
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
        
        _ = updatePrice()
        
        if self.thuHoProvider?.PartnerUserCode.trim() == "0051" { //smartpay
            lbValueQuantity.text = "\(self.itemThuHoSmartpayCheckInfo?.customerName ?? "")"
        }
    }
    
    func convertTypeMoneyString(number: String) -> String {
        var moneyString = number
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
            return str
        }else{
            return ""
        }
    }
    
    @objc func viewList(sender : UITapGestureRecognizer) {
        let vc = ListPaymentPeriodPayooViewController()
        vc.thuHoBill = thuHoBill
        vc.ListDetailPayooSelect = ListDetailPayooSelect
        vc.delegate = self
        self.parentNavigationController?.pushViewController(vc, animated: true)
    }
    func returnSelectListPayment(item: [ItemDetailPayoo]) {
        self.ListDetailPayooSelect = item
        _ = updatePrice()
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
        _ = updatePrice()
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        var moneyString:String = textField.text ?? ""
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
        _ = updatePrice()
    }
    func returnCard(item: CardTypeFromPOSResult, ind: Int) {
        self.cardTypeFromPOSResult = item
        _ = updatePrice()
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
        _ = updatePrice()
    }
    func updatePrice() -> Int{
        lbValueKyTT.text = "\(ListDetailPayooSelect.count) kỳ"
        
        var sum:Int = 0
        var sumPhiThuHo:Int = 0
        if self.thuHoProvider?.PartnerUserCode.trim() == "0051" { //smartpay
            var payAmoutStr = self.tfPhoneNumber.text ?? "0"
            payAmoutStr = payAmoutStr.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            sum = Int(payAmoutStr) ?? 0
        } else {
            for item in ListDetailPayooSelect {
                sum = sum + item.TotalAmount
                if(thuHoBill?.PaymentFeeType == 2){
                    if(sumPhiThuHo == 0){
                        sumPhiThuHo = sumPhiThuHo + item.PaymentFee
                    }
                }else{
                    sumPhiThuHo = sumPhiThuHo + item.PaymentFee
                }
            }
        }
        
        self.lbTotalSumValue.text = "\(Common.convertCurrency(value: sumPhiThuHo))"
        
        var moneyString:String = "0"
        if(thuHoBill?.PaymentRule == 5){
            self.lbValueTotal.text = "\(Common.convertCurrency(value: sum))"
            if(tfPhoneNumber != nil){
                moneyString = tfPhoneNumber.text ?? ""
            }
            moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            if(moneyString.isEmpty){
                moneyString = "0"
            }
        }else{
            moneyString = "\(sum)"
            let characters = Array("\(sum)")
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
                tfPhoneNumber.text = str
            }else{
                tfPhoneNumber.text = ""
            }
        }
        sumAll = (Int(moneyString) ?? 0) + sumPhiThuHo
        
        var sumPhiCaThe:Double = 0
        if(cardTypeFromPOSResult != nil){
            sumPhiCaThe = cardTypeFromPOSResult?.PercentFee ?? 0
        }
        
        let ptPhiCathe:Double = (Double(sumAll) * sumPhiCaThe)/100
        let phiCaTheAmount = Int(ptPhiCathe.rounded(.up))
        self.lbTotalVoucherValue.text = "\(Common.convertCurrency(value: phiCaTheAmount))"
        
        
        let sumAllUI:Int =  (Int(moneyString) ?? 0) + sumPhiThuHo + phiCaTheAmount
        self.lbTotalValue.text = "\(Common.convertCurrency(value: sumAllUI))"
        
        return sum
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
    }
    @objc func deleteTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let pos: Int = tappedImage.tag
        listVoucher.remove(at: pos)
        updateUIVoucher()
    }
    @objc func payAction(_ sender:UITapGestureRecognizer){
        /*
        if(thuHoBill!.PaymentRule == 5){
            var moneyString:String = "0"
            if(tfPhoneNumber != nil){
                moneyString = tfPhoneNumber.text!
            }
            moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            if(moneyString.isEmpty){
                moneyString = "0"
            }
            let sumInput:Int = Int(moneyString)!
            var sum:Int = 0
            for item in ListDetailPayooSelect {
                sum = sum + item.TotalAmount
            }
            if(sumInput > sum){
                let popup = PopupDialog(title: "Thông báo", message: "Số tiền thanh toán phải nhỏ hơn hoặc bằng số tiền của hoá đơn.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "OK") {
                }
                
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
                return
            }
        }
 */
        
        
        
        if self.thuHoProvider?.PartnerUserCode.trim() == "0051" { //smartpay
            var payAmoutStr = self.tfPhoneNumber.text ?? "0"
            if !payAmoutStr.isEmpty {
                payAmoutStr = payAmoutStr.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
                let payAmount = Int(payAmoutStr) ?? 0
//                let overAmount = Int(self.itemThuHoSmartpayCheckInfo?.overdueAmount ?? "0")
//                let minAmount = Int(self.itemThuHoSmartpayCheckInfo?.minAmount ?? "0")
//                if (payAmount >= (minAmount ?? 0)) && (payAmount <= (overAmount ?? 0)) {
//
//
//
//                } else {
//                    let alert = UIAlertController(title: "Thông báo", message: "Số tiền thanh toán không hợp lệ! Vui lòng nhập số tiền trong khoảng \(self.convertTypeMoneyString(number: "\(minAmount ?? 0)"))đ đến \(self.convertTypeMoneyString(number: "\(overAmount ?? 0)"))đ", preferredStyle: .alert)
//                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                    alert.addAction(action)
//                    self.present(alert, animated: true, completion: nil)
//                    return
//                }
                let vc = PaymentPayooViewController()
                vc.thuHoBill = thuHoBill
                vc.thuHoService = thuHoService
                vc.thuHoProvider = thuHoProvider
                vc.contractCode = contractCode
                vc.cardTypeFromPOSResult = cardTypeFromPOSResult
                vc.typeCashPayment = typeCashPayment
                vc.typeCardPayment = typeCardPayment
                vc.parentNavigationController = parentNavigationController
                vc.total = sumAll
                vc.realSmartPayAmount = payAmount
                vc.ListDetailPayooSelect = []
                vc.itemThuHoSmartpayCheckInfo = self.itemThuHoSmartpayCheckInfo
                self.parentNavigationController?.pushViewController(vc, animated: true)
            } else {
                let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập số tiền thanh toán!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            
        } else {
            let vc = PaymentPayooViewController()
            vc.thuHoBill = thuHoBill
            vc.thuHoService = thuHoService
            vc.thuHoProvider = thuHoProvider
            vc.contractCode = contractCode
            vc.cardTypeFromPOSResult = cardTypeFromPOSResult
            vc.typeCashPayment = typeCashPayment
            vc.typeCardPayment = typeCardPayment
            vc.parentNavigationController = parentNavigationController
            vc.total = sumAll
            vc.ListDetailPayooSelect = ListDetailPayooSelect
            vc.itemThuHoSmartpayCheckInfo = self.itemThuHoSmartpayCheckInfo
            self.parentNavigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
