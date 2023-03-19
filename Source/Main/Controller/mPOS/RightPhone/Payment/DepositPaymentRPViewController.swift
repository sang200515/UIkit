//
//  PaymentRightPhoneViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/16/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import DLRadioButton

class DepositPaymentRPViewController: UIViewController,ChooseBankRightPhoneViewControllerDelegate,UITextFieldDelegate,UITextViewDelegate {
    
    func returnService(item: BankRP) {
        
        self.bank = item
        self.tfTypeCardBank.isEnabled = true
        self.tfBankNumber.isEnabled = true
        self.tfBank.text = item.name
        self.tfCard.isEnabled = true
        self.radCard.isSelected = true
        self.viewTheDetail.frame.size.height = self.heightCardView
        self.viewOTP.frame.origin.y = viewTheDetail.frame.size.height + viewTheDetail.frame.origin.y + Common.Size(s:10)
        viewPayment.frame.size.height = viewOTP.frame.size.height + viewOTP.frame.origin.y + Common.Size(s: 10)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewPayment.frame.origin.y + viewPayment.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    
    
    var scrollView:UIScrollView!
    var tfOTP:UITextField!
    var bank:BankRP?
    var detailAfterSaleRP:DetailAfterSaleRP?
    var itemRPOnProgress:ItemRPOnProgress?
    var radCash:DLRadioButton!
    var radCard:DLRadioButton!
    var tfCash:UITextField!
    var tfCard:UITextField!
    var tfTypeCardBank:SearchTextField!
    var tfNote:UITextView!
    var lstTypeCardBank:[CardBankRP] = []
    var feeAmount:Float = 0
    var tfBankNumber:UITextField!
    var tfBank:SearchTextField!
    var lblFeeValue:UILabel!
    var itemTypeCard: CardBankRP?
    var viewTheDetail: UIView!
    var viewOTP:UIView!
    var heightCardView:CGFloat = 0.0
    var lblSumValue:UILabel!
    var viewPayment:UIView!
    override func viewDidLoad() {
        self.title = "Thanh toán"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(DepositPaymentRPViewController.backButton), for: UIControl.Event.touchUpInside)
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
        
        let lblMposNum = UILabel(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblMposNum.textAlignment = .left
        lblMposNum.textColor = UIColor.black
        lblMposNum.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lblMposNum.text = "Số Mpos: \(self.itemRPOnProgress?.docentry ?? 0)"
        viewProduct.addSubview(lblMposNum)
        
        let lblNameProduct = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblMposNum.frame.size.height + lblMposNum.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblNameProduct.textAlignment = .left
        lblNameProduct.textColor = UIColor.black
        lblNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lblNameProduct.text = "Tên SP: \(self.itemRPOnProgress!.nameProduct)"
        viewProduct.addSubview(lblNameProduct)
        
        
        let lblImei = UILabel(frame: CGRect(x: Common.Size(s:10), y:lblNameProduct.frame.size.height + lblNameProduct.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblImei.textAlignment = .left
        lblImei.textColor = UIColor(netHex:0x00955E)
        lblImei.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        lblImei.text = "Imei: \(self.detailAfterSaleRP!.IMEI)"
        viewProduct.addSubview(lblImei)
        
        
        let lblColorProduct = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblImei.frame.size.height + lblImei.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblColorProduct.textAlignment = .left
        lblColorProduct.textColor = UIColor.black
        lblColorProduct.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblColorProduct.text = "Màu sắc: \(self.detailAfterSaleRP!.color)"
        viewProduct.addSubview(lblColorProduct)
        
        
        let lblBranch = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblImei.frame.size.height + lblImei.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblBranch.textAlignment = .right
        lblBranch.textColor = UIColor.black
        lblBranch.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBranch.text = "Hãng: \(self.detailAfterSaleRP!.manufacturer)"
        viewProduct.addSubview(lblBranch)
        
        
        
        
        
        let lblMemory = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblColorProduct.frame.size.height + lblColorProduct.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblMemory.textAlignment = .left
        lblMemory.textColor = UIColor.black
        lblMemory.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblMemory.text = "Memory: \(self.detailAfterSaleRP!.memory)"
        viewProduct.addSubview(lblMemory)
        
        viewProduct.frame.size.height = lblMemory.frame.size.height + lblMemory.frame.origin.y + Common.Size(s: 10)
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewProduct.frame.size.height + viewProduct.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "THÔNG TIN NGƯỜI BÁN"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        let viewSeller = UIView()
        viewSeller.frame = CGRect(x: 0, y: label1.frame.size.height + label1.frame.origin.y  , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewSeller.backgroundColor = UIColor.white
        scrollView.addSubview(viewSeller)
        
        let lblSellerName = UILabel(frame: CGRect(x: Common.Size(s:10), y:   Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblSellerName.textAlignment = .left
        lblSellerName.textColor = UIColor.black
        lblSellerName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSellerName.text = "Khách bán"
        viewSeller.addSubview(lblSellerName)
        
        let lblSellerNameValue = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblSellerName.frame.origin.y, width: scrollView.frame.size.width  - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblSellerNameValue.textAlignment = .right
        lblSellerNameValue.textColor = UIColor.black
        lblSellerNameValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSellerNameValue.text = "\(self.detailAfterSaleRP!.Sale_Name)"
        viewSeller.addSubview(lblSellerNameValue)
        
        let lblSellerPhone = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblSellerName.frame.size.height + lblSellerName.frame.origin.y +   Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblSellerPhone.textAlignment = .left
        lblSellerPhone.textColor = UIColor.black
        lblSellerPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSellerPhone.text = "SĐT"
        viewSeller.addSubview(lblSellerPhone)
        
        let lblSellerPhoneValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblSellerPhone.frame.origin.y, width: scrollView.frame.size.width  - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblSellerPhoneValue.textAlignment = .right
        lblSellerPhoneValue.textColor = UIColor.black
        lblSellerPhoneValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSellerPhoneValue.text = "\(self.detailAfterSaleRP!.Sale_phone)"
        viewSeller.addSubview(lblSellerPhoneValue)
        
        let lblDateSell = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblSellerPhone.frame.size.height + lblSellerPhone.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblDateSell.textAlignment = .left
        lblDateSell.textColor = UIColor.black
        lblDateSell.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDateSell.text = "Ngày bán"
        viewSeller.addSubview(lblDateSell)
        
        let lblDateSellValue = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblDateSell.frame.origin.y , width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblDateSellValue.textAlignment = .right
        lblDateSellValue.textColor = UIColor.black
        lblDateSellValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDateSellValue.text = "\(self.detailAfterSaleRP!.NgayDang)"
        viewSeller.addSubview(lblDateSellValue)
        
        let lblEmailSell = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblDateSell.frame.size.height + lblDateSell.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblEmailSell.textAlignment = .left
        lblEmailSell.textColor = UIColor.black
        lblEmailSell.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblEmailSell.text = "Email bán"
        viewSeller.addSubview(lblEmailSell)
        
        let lblEmailSellValue = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblEmailSell.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblEmailSellValue.textAlignment = .right
        lblEmailSellValue.textColor = UIColor.black
        lblEmailSellValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblEmailSellValue.text = "\(self.detailAfterSaleRP!.Sale_mail)"
        viewSeller.addSubview(lblEmailSellValue)
        
        let lblPriceSell = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblEmailSell.frame.size.height + lblEmailSell.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblPriceSell.textAlignment = .left
        lblPriceSell.textColor = UIColor.black
        lblPriceSell.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        lblPriceSell.text = "Giá bán"
        viewSeller.addSubview(lblPriceSell)
        
        let lblPriceSellValue = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblPriceSell.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblPriceSellValue.textAlignment = .right
        lblPriceSellValue.textColor = UIColor.black
        lblPriceSellValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        lblPriceSellValue.text = "\(Common.convertCurrencyFloat(number: self.detailAfterSaleRP!.Sale_price))"
        viewSeller.addSubview(lblPriceSellValue)
        
        
        let lblShop = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblPriceSell.frame.size.height + lblPriceSell.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblShop.textAlignment = .left
        lblShop.textColor = UIColor.black
        lblShop.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblShop.text = "Shop giữ hàng"
        viewSeller.addSubview(lblShop)
        
        let llblShopValue = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblShop.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
        llblShopValue.textAlignment = .right
        llblShopValue.textColor = UIColor.black
        llblShopValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        llblShopValue.text = "\(Cache.user!.ShopName)"
        viewSeller.addSubview(llblShopValue)
        
        
        let lblNote = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblShop.frame.size.height + lblShop.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblNote.textAlignment = .left
        lblNote.textColor = UIColor.black
        lblNote.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNote.text = "Note bán"
        viewSeller.addSubview(lblNote)
        
        let lblNoteValue = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblNote.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblNoteValue.textAlignment = .right
        lblNoteValue.textColor = UIColor.black
        lblNoteValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNoteValue.text = "\(self.detailAfterSaleRP!.NgayDang)"
        viewSeller.addSubview(lblNoteValue)
        
        viewSeller.frame.size.height = lblNote.frame.size.height + lblNote.frame.origin.y + Common.Size(s:10)
        
        let label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewSeller.frame.size.height + viewSeller.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label2.text = "THÔNG TIN NGƯỜI MUA"
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label2)
        
        let viewBuyer = UIView()
        viewBuyer.frame = CGRect(x: 0, y: label2.frame.size.height + label2.frame.origin.y  , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewBuyer.backgroundColor = UIColor.white
        scrollView.addSubview(viewBuyer)
        
        let lblBuyerName = UILabel(frame: CGRect(x: Common.Size(s:10), y:   Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblBuyerName.textAlignment = .left
        lblBuyerName.textColor = UIColor.black
        lblBuyerName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBuyerName.text = "Người mua "
        viewBuyer.addSubview(lblBuyerName)
        
        let lblBuyerNameValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblBuyerName.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblBuyerNameValue.textAlignment = .right
        lblBuyerNameValue.textColor = UIColor.black
        lblBuyerNameValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBuyerNameValue.text = "\(self.detailAfterSaleRP!.Sale_Name)"
        viewBuyer.addSubview(lblBuyerNameValue)
        
        
        let lblBuyerPhone = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblBuyerName.frame.size.height + lblBuyerName.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblBuyerPhone.textAlignment = .left
        lblBuyerPhone.textColor = UIColor.black
        lblBuyerPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBuyerPhone.text = "SĐT mua"
        viewBuyer.addSubview(lblBuyerPhone)
        
        let lblBuyerPhoneValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblBuyerPhone.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblBuyerPhoneValue.textAlignment = .right
        lblBuyerPhoneValue.textColor = UIColor.black
        lblBuyerPhoneValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBuyerPhoneValue.text = "\(self.detailAfterSaleRP!.Buy_phone)"
        viewBuyer.addSubview(lblBuyerPhoneValue)
        
        
        let lblDateBuy = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblBuyerPhone.frame.size.height + lblBuyerPhone.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblDateBuy.textAlignment = .left
        lblDateBuy.textColor = UIColor.black
        lblDateBuy.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDateBuy.text = "Ngày mua"
        viewBuyer.addSubview(lblDateBuy)
        
        let lblDateBuyValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblDateBuy.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblDateBuyValue.textAlignment = .right
        lblDateBuyValue.textColor = UIColor.black
        lblDateBuyValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDateBuyValue.text = "\(self.detailAfterSaleRP!.Sale_Name)"
        viewBuyer.addSubview(lblDateBuyValue)
        
        
        let lblEmailBuyer = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblDateBuy.frame.size.height + lblDateBuy.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblEmailBuyer.textAlignment = .left
        lblEmailBuyer.textColor = UIColor.black
        lblEmailBuyer.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblEmailBuyer.text = "Email mua"
        viewBuyer.addSubview(lblEmailBuyer)
        
        let lblEmailBuyerValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblEmailBuyer.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblEmailBuyerValue.textAlignment = .right
        lblEmailBuyerValue.textColor = UIColor.black
        lblEmailBuyerValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblEmailBuyerValue.text = "\(self.detailAfterSaleRP!.Buy_mail)"
        viewBuyer.addSubview(lblEmailBuyerValue)
        
        
        let lblPriceBuy = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblEmailBuyer.frame.size.height + lblEmailBuyer.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblPriceBuy.textAlignment = .left
        lblPriceBuy.textColor = UIColor.red
        lblPriceBuy.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        lblPriceBuy.text = "Giá mua"
        viewBuyer.addSubview(lblPriceBuy)
        
        let lblPriceBuyValue = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblPriceBuy.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblPriceBuyValue.textAlignment = .right
        lblPriceBuyValue.textColor = UIColor.red
        lblPriceBuyValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        lblPriceBuyValue.text = "\(Common.convertCurrencyFloat(number: self.detailAfterSaleRP!.Sale_price))"
        viewBuyer.addSubview(lblPriceBuyValue)
        
        let lblCodeRightPhone = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblPriceBuy.frame.size.height + lblPriceBuy.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblCodeRightPhone.textAlignment = .left
        lblCodeRightPhone.textColor = UIColor.black
        lblCodeRightPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblCodeRightPhone.text = "Mã RightPhone"
        viewBuyer.addSubview(lblCodeRightPhone)
        
        let lblCodeRightPhoneValue = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblCodeRightPhone.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblCodeRightPhoneValue.textAlignment = .right
        lblCodeRightPhoneValue.textColor = UIColor.black
        lblCodeRightPhoneValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        
        viewBuyer.addSubview(lblCodeRightPhoneValue)
        
        
        let lblDateArrivedShop = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblCodeRightPhone.frame.size.height + lblCodeRightPhone.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblDateArrivedShop.textAlignment = .left
        lblDateArrivedShop.textColor = UIColor.black
        lblDateArrivedShop.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDateArrivedShop.text = "Ngày đến shop"
        viewBuyer.addSubview(lblDateArrivedShop)
        
        let lblDateArrivedShopValue = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblDateArrivedShop.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblDateArrivedShopValue.textAlignment = .right
        lblDateArrivedShopValue.textColor = UIColor.black
        lblDateArrivedShopValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDateArrivedShopValue.text = "\(self.detailAfterSaleRP!.NgayDenShop)"
        viewBuyer.addSubview(lblDateArrivedShopValue)
        
        
        viewBuyer.frame.size.height = lblDateArrivedShop.frame.size.height + lblDateArrivedShop.frame.origin.y + Common.Size(s: 10)
        
        
        let label3 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewBuyer.frame.size.height + viewBuyer.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label3.text = "THÔNG TIN THANH TOÁN"
        label3.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label3)
        
        viewPayment = UIView()
        viewPayment.frame = CGRect(x: 0, y: label3.frame.size.height + label3.frame.origin.y  , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewPayment.backgroundColor = UIColor.white
        scrollView.addSubview(viewPayment)
        
        let lblDepositCash = UILabel(frame: CGRect(x: Common.Size(s:10), y:  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblDepositCash.textAlignment = .left
        lblDepositCash.textColor = UIColor.black
        lblDepositCash.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDepositCash.text = "Số tiền cọc"
        viewPayment.addSubview(lblDepositCash)
        
        let lblDepositCashValue = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblDepositCash.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblDepositCashValue.textAlignment = .right
        lblDepositCashValue.textColor = UIColor.black
        lblDepositCashValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDepositCashValue.text = "\(Common.convertCurrencyFloat(value: self.detailAfterSaleRP!.Sotiencoc))"
        viewPayment.addSubview(lblDepositCashValue)
        
        let lblIncomeCash = UILabel(frame: CGRect(x: Common.Size(s:10), y:lblDepositCash.frame.size.height + lblDepositCash.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblIncomeCash.textAlignment = .left
        lblIncomeCash.textColor = UIColor.black
        lblIncomeCash.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblIncomeCash.text = "Số tiền cần thu"
        viewPayment.addSubview(lblIncomeCash)
        
        let lblIncomeCashValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblIncomeCash.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblIncomeCashValue.textAlignment = .right
        lblIncomeCashValue.textColor = UIColor.black
        lblIncomeCashValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblIncomeCashValue.text = Common.convertCurrencyFloat(value: self.detailAfterSaleRP!.SoTienConLai)
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
        let sum = self.detailAfterSaleRP!.Sotiencoc + self.detailAfterSaleRP!.SoTienConLai + self.feeAmount
        lblSumValue.text = "\(Common.convertCurrencyFloat(value: sum))"
        viewPayment.addSubview(lblSumValue)
        
        radCard = createRadioButtonLoaiThueBao(CGRect(x: Common.Size(s:10),y:lblSum.frame.origin.y + lblSum.frame.size.height + Common.Size(s:10) , width: lblIncomeCash.frame.size.width/2, height: Common.Size(s:20)), title: "Thẻ", color: UIColor.black);
        viewPayment.addSubview(radCard)
        
      
        
        viewTheDetail = UIView(frame: CGRect(x: 0, y: radCard.frame.size.height + radCard.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width, height: Common.Size(s:100)))
        viewTheDetail.backgroundColor = UIColor.white
        viewTheDetail.clipsToBounds = true
        viewPayment.addSubview(viewTheDetail)
        
        let lblBankTitle = UILabel(frame: CGRect(x: Common.Size(s:10), y:  Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
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
            self.feeAmount = (Float(self.itemTypeCard!.PercentFee) * Float(self.detailAfterSaleRP!.SoTienConLai))/100
            self.lblFeeValue.text = "\(self.itemTypeCard!.PercentFee)%"
            self.tfTypeCardBank.text = self.itemTypeCard!.CardName
            
            let tongTien = (self.feeAmount + self.detailAfterSaleRP!.SoTienConLai)
            self.lblSumValue.text = Common.convertCurrencyFloat(value: tongTien)
            self.tfCash.text = Common.convertCurrencyFloat(value: tongTien)
            self.tfCard.text = ""
        }
        
        let lblCashTitle = UILabel(frame: CGRect(x: Common.Size(s:10), y:   tfTypeCardBank.frame.size.height + tfTypeCardBank.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
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
        tfCash.text = "\(Common.convertCurrencyFloat(value: self.detailAfterSaleRP!.SoTienConLai))"
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
        
        let lblBankNumberTitle = UILabel(frame: CGRect(x: Common.Size(s:10), y:   tfCard.frame.size.height + tfCard.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblBankNumberTitle.textAlignment = .left
        lblBankNumberTitle.textColor = UIColor.black
        lblBankNumberTitle.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBankNumberTitle.text = "Số thẻ"
        viewTheDetail.addSubview(lblBankNumberTitle)
        
        
        tfBankNumber = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblBankNumberTitle.frame.origin.y + lblBankNumberTitle.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        
        tfBankNumber.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfBankNumber.borderStyle = UITextField.BorderStyle.roundedRect
        tfBankNumber.autocorrectionType = UITextAutocorrectionType.no
        tfBankNumber.keyboardType = UIKeyboardType.numberPad
        tfBankNumber.returnKeyType = UIReturnKeyType.done
        tfBankNumber.clearButtonMode = UITextField.ViewMode.whileEditing
        tfBankNumber.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfBankNumber.delegate = self
        tfBankNumber.isEnabled = false
        viewTheDetail.addSubview(tfBankNumber)
        
        viewTheDetail.frame.size.height = tfBankNumber.frame.size.height + tfBankNumber.frame.origin.y + Common.Size(s:10)
        self.heightCardView = viewTheDetail.frame.size.height
        viewTheDetail.frame.size.height = 0
        
        
        viewOTP = UIView(frame: CGRect(x: 0, y: viewTheDetail.frame.size.height + viewTheDetail.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width, height: Common.Size(s:100)))
        viewOTP.backgroundColor = UIColor.white
        viewOTP.clipsToBounds = true
        viewPayment.addSubview(viewOTP)
        
        let lblOTPTitle = UILabel(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblOTPTitle.textAlignment = .left
        lblOTPTitle.textColor = UIColor.black
        lblOTPTitle.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblOTPTitle.text = "Nhập OTP SMS"
        viewOTP.addSubview(lblOTPTitle)
        
        
        
        tfOTP = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblOTPTitle.frame.origin.y + lblOTPTitle.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:160) , height: Common.Size(s:40)));
        tfOTP.placeholder = "Nhập OTP KH"
        tfOTP.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfOTP.borderStyle = UITextField.BorderStyle.roundedRect
        tfOTP.autocorrectionType = UITextAutocorrectionType.no
        tfOTP.keyboardType = UIKeyboardType.numberPad
        tfOTP.returnKeyType = UIReturnKeyType.done
        tfOTP.clearButtonMode = UITextField.ViewMode.whileEditing
        tfOTP.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfOTP.delegate = self
        viewOTP.addSubview(tfOTP)
        
        let btOTP = UIButton()
        btOTP.frame = CGRect(x:tfOTP.frame.size.width + tfOTP.frame.origin.x + Common.Size(s:10), y: tfOTP.frame.origin.y , width: scrollView.frame.size.width  - Common.Size(s:200), height: Common.Size(s:40) )
        btOTP.backgroundColor = UIColor(netHex:0x00955E)
        btOTP.setTitle("Gửi OTP", for: .normal)
        btOTP.addTarget(self, action: #selector(actionOTP), for: .touchUpInside)
        btOTP.layer.borderWidth = 0.5
        btOTP.layer.borderColor = UIColor.white.cgColor
        btOTP.layer.cornerRadius = 3
        viewOTP.addSubview(btOTP)
        
        
        let lblNoteTitle = UILabel(frame: CGRect(x: Common.Size(s:10), y:   tfOTP.frame.size.height + tfOTP.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblNoteTitle.textAlignment = .left
        lblNoteTitle.textColor = UIColor.black
        lblNoteTitle.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNoteTitle.text = "Ghi chú"
        viewOTP.addSubview(lblNoteTitle)
        
        
        tfNote = UITextView(frame: CGRect(x: lblNoteTitle.frame.origin.x , y: lblNoteTitle.frame.origin.y  + lblNoteTitle.frame.size.height + Common.Size(s:10), width: lblNoteTitle.frame.size.width - Common.Size(s: 30), height: tfOTP.frame.size.height * 2 ))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        tfNote.layer.borderWidth = 0.5
        tfNote.layer.borderColor = borderColor.cgColor
        tfNote.layer.cornerRadius = 5.0
        tfNote.delegate = self
        tfNote.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        viewOTP.addSubview(tfNote)
        
        
        let btConfirm = UIButton()
        btConfirm.frame = CGRect(x: Common.Size(s:10), y: tfNote.frame.size.height + tfNote.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width  - Common.Size(s:170), height: Common.Size(s:40))
        btConfirm.backgroundColor = UIColor(netHex:0x00955E)
        btConfirm.setTitle("Hoàn tất cọc", for: .normal)
        btConfirm.addTarget(self, action: #selector(actionComplete), for: .touchUpInside)
        btConfirm.layer.borderWidth = 0.5
        btConfirm.layer.borderColor = UIColor.white.cgColor
        btConfirm.layer.cornerRadius = 3
        viewOTP.addSubview(btConfirm)
        
        let btReject = UIButton()
        btReject.frame = CGRect(x: btConfirm.frame.size.width + btConfirm.frame.origin.x + Common.Size(s:10), y:tfNote.frame.size.height + tfNote.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width  - Common.Size(s:180), height: Common.Size(s:40) )
        btReject.backgroundColor = .red
        btReject.setTitle("Hủy", for: .normal)
        btReject.addTarget(self, action: #selector(actionReject), for: .touchUpInside)
        btReject.layer.borderWidth = 0.5
        btReject.layer.borderColor = UIColor.white.cgColor
        btReject.layer.cornerRadius = 3
        viewOTP.addSubview(btReject)
        
        viewOTP.frame.size.height = btConfirm.frame.size.height + btConfirm.frame.origin.y + Common.Size(s: 10)
        viewPayment.frame.size.height = viewOTP.frame.size.height + viewOTP.frame.origin.y + Common.Size(s: 10)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewPayment.frame.origin.y + viewPayment.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
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
    
    fileprivate func createRadioButtonLoaiThueBao(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:13));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(DepositPaymentRPViewController.logSelectedButtonLoaiThueBao), for: UIControl.Event.touchUpInside);
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
    
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func actionOTP(){
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang gửi mã OTP ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_FRT_SP_SK_Send_OTP(sdt: "\(self.detailAfterSaleRP!.Buy_phone)",docentry:"\(self.detailAfterSaleRP!.docentry)") { (p_status,p_message, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(p_status == 1){
                        let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
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
    @objc func actionReject(){
        let newViewController = RejectPaymentRPViewController()
        newViewController.detailAfterSaleRP = self.detailAfterSaleRP
        newViewController.itemRPOnProgress = self.itemRPOnProgress
        self.navigationController?.pushViewController(newViewController, animated: true)
    }

    @objc func actionComplete(){
        if(self.radCard.isSelected == true){
            if(self.tfCard.text! == ""){
                let alert = UIAlertController(title: "Thông báo", message: "Chưa nhập số tiền thanh toán thẻ !", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
         
          
        }
        if(self.tfOTP.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Chưa nhập OTP !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        let newViewController = LoadingViewController()
        newViewController.content = "Đang hoàn tất đơn hàng ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_FRT_SP_SK_confirm_book_order(Type:"0",otp:"\(self.tfOTP.text!)",docentry:"\(self.detailAfterSaleRP!.docentry)",xmlpay:self.parseXML(),note:self.tfNote.text!,imei:self.detailAfterSaleRP!.IMEI,price:"\(Int(self.detailAfterSaleRP!.Sale_price))",phone:"\(self.detailAfterSaleRP!.Buy_phone)") { (p_status,p_message, err) in
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
                        let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
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
            let tongTien = (self.feeAmount + self.detailAfterSaleRP!.SoTienConLai)
            self.tfCash.text = Common.convertCurrencyV2(value: Int(tongTien) - Int(str)!)
            if (self.tfCash.text?.hasPrefix("-"))! {
                let alert = UIAlertController(title: "Thông báo", message: "Số tiền thanh toán không được âm !", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .default) { _ in
                    self.tfCard.text = ""
                    self.tfCash.text = Common.convertCurrencyV2(value: Int(tongTien))
                })
                self.present(alert, animated: true)
            }
        }else{
              let tongTien = (self.feeAmount + self.detailAfterSaleRP!.SoTienConLai)
            self.tfCard.text = ""
            self.tfCash.text = Common.convertCurrencyV2(value: Int(tongTien))
        }
        
    }
    func parseXML()->String{
        var rs:String = "<line>"
        
        if(self.radCard.isSelected == false){
            
            rs = rs + "<item totalcash=\"\(Int(self.detailAfterSaleRP!.SoTienConLai))\"  Totalcredit=\"\("0")\" numbercredit=\"\("")\"  IDBank=\"\("")\" typebank=\"\("")\" feebank=\"\("")\"/>"
            
        }
        if(self.radCard.isSelected == true){
            if(self.tfCash.text != ""){
               
                 let moneyStringCard = self.tfCard.text!.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                
                    rs = rs + "<item totalcash=\"\(Int(self.detailAfterSaleRP!.SoTienConLai))\"  Totalcredit=\"\("0")\" numbercredit=\"\("")\"  IDBank=\"\("")\" typebank=\"\("")\" feebank=\"\("")\"/>"
                
                    rs = rs + "<item totalcash=\"\(0)\"  Totalcredit=\"\(moneyStringCard)\" numbercredit=\"\("\(self.tfBankNumber.text!)")\"  IDBank=\"\("\(self.bank!.code)")\"  typebank=\"\("\(self.itemTypeCard!.CreditCard)")\" feebank=\"\("\(Int(self.feeAmount))")\"/>"
            }else{
                
                
                let moneyStringCard = self.tfCard.text!.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                     rs = rs + "<item totalcash=\"\(0)\"  Totalcredit=\"\("0")\" numbercredit=\"\("")\"  IDBank=\"\("")\" typebank=\"\("")\" feebank=\"\("")\"/>"
                
                rs = rs + "<item totalcash=\"\(0)\"  Totalcredit=\"\(moneyStringCard)\" numbercredit=\"\("\(self.tfBankNumber.text!)")\"  IDBank=\"\("\(self.bank!.code)")\"  typebank=\"\("\(self.itemTypeCard!.CreditCard)")\" feebank=\"\("\(Int(self.feeAmount))")\"/>"
            }
            
            
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
}
