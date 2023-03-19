//
//  RPDetailCompleteProgressViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/7/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class RPDetailCompleteProgressViewController: UIViewController {
    
    var scrollView:UIScrollView!
    var headerCompleteDetailRP:HeaderCompleteDetailRP?
    var itemRPOnProgress:ItemRPOnProgress?
    override func viewDidLoad() {
        self.title = "Chi tiết giao dịch"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(RPDetailCompleteProgressViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let lblMposNumber = UILabel(frame: CGRect(x: Common.Size(s:15), y:  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblMposNumber.textAlignment = .left
        lblMposNumber.textColor = UIColor(netHex:0x00955E)
        lblMposNumber.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        lblMposNumber.text = "MPOS: \(self.headerCompleteDetailRP!.docentry)"
        scrollView.addSubview(lblMposNumber)
        
        
        let lblDate = UILabel(frame: CGRect(x: Common.Size(s:10), y:  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblDate.textAlignment = .right
        lblDate.textColor = UIColor.black
        lblDate.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        lblDate.text = "\(self.headerCompleteDetailRP!.NgayDang)"
        scrollView.addSubview(lblDate)
        
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblMposNumber.frame.size.height + lblMposNumber.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "THÔNG TIN NGƯỜI BÁN" //Outbound
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        let viewSeller = UIView()
        viewSeller.frame = CGRect(x: 0, y: label1.frame.size.height + label1.frame.origin.y , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewSeller.backgroundColor = UIColor.white
        scrollView.addSubview(viewSeller)
        
        let lblPhieuThuSeller = UILabel(frame: CGRect(x: Common.Size(s:10), y:  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblPhieuThuSeller.textAlignment = .left
        lblPhieuThuSeller.textColor = UIColor.black
        lblPhieuThuSeller.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPhieuThuSeller.text = "Phiếu thu \(self.headerCompleteDetailRP!.SoPhieuThu)"
        viewSeller.addSubview(lblPhieuThuSeller)
        
        let lblPhieuChiSeller = UILabel(frame: CGRect(x: Common.Size(s:10), y:  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblPhieuChiSeller.textAlignment = .right
        lblPhieuChiSeller.textColor = UIColor.black
        lblPhieuChiSeller.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPhieuChiSeller.text = "Phiếu chi \(self.headerCompleteDetailRP!.SoPhieuChi)"
        viewSeller.addSubview(lblPhieuChiSeller)
        
        let lblSellerName = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblPhieuThuSeller.frame.size.height + lblPhieuThuSeller.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblSellerName.textAlignment = .left
        lblSellerName.textColor = UIColor.black
        lblSellerName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSellerName.text = "Họ tên"
        viewSeller.addSubview(lblSellerName)
        
        let lblSellerNameValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblSellerName.frame.origin.y , width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:14)))
        lblSellerNameValue.textAlignment = .right
        lblSellerNameValue.textColor = UIColor.black
        lblSellerNameValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSellerNameValue.text = "\(self.headerCompleteDetailRP!.Sale_Name)"
        viewSeller.addSubview(lblSellerNameValue)
        
        let lblSellerPhone = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblSellerName.frame.size.height + lblSellerName.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblSellerPhone.textAlignment = .left
        lblSellerPhone.textColor = UIColor.black
        lblSellerPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSellerPhone.text = "SDT"
        viewSeller.addSubview(lblSellerPhone)
        
        let lblSellerPhoneValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblSellerPhone.frame.origin.y , width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:14)))
        lblSellerPhoneValue.textAlignment = .right
        lblSellerPhoneValue.textColor = UIColor.black
        lblSellerPhoneValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSellerPhoneValue.text = "\(self.headerCompleteDetailRP!.Sale_phone)"
        viewSeller.addSubview(lblSellerPhoneValue)
        
        
        let lblSellerMail = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblSellerPhone.frame.size.height + lblSellerPhone.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblSellerMail.textAlignment = .left
        lblSellerMail.textColor = UIColor.black
        lblSellerMail.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSellerMail.text = "Mail"
        viewSeller.addSubview(lblSellerMail)
        
        
        let lblSellerMailValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblSellerMail.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:14)))
        lblSellerMailValue.textAlignment = .right
        lblSellerMailValue.textColor = UIColor.black
        lblSellerMailValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSellerMailValue.text = "\(self.headerCompleteDetailRP!.Sale_mail)"
        viewSeller.addSubview(lblSellerMailValue)
        
        
        let lblShopRegisterSeller = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblSellerMail.frame.size.height + lblSellerMail.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblShopRegisterSeller.textAlignment = .left
        lblShopRegisterSeller.textColor = UIColor.black
        lblShopRegisterSeller.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblShopRegisterSeller.text = "Shop Nhận đăng ký"
        viewSeller.addSubview(lblShopRegisterSeller)
        
        
        let lblShopRegisterSellerValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblShopRegisterSeller.frame.origin.y , width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblShopRegisterSellerValue.textAlignment = .right
        lblShopRegisterSellerValue.textColor = UIColor.black
        lblShopRegisterSellerValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblShopRegisterSellerValue.text = "\(self.headerCompleteDetailRP!.TenShopDK)"
        viewSeller.addSubview(lblShopRegisterSellerValue)
        
        let lblDateRegisterSeller = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblShopRegisterSeller.frame.size.height + lblShopRegisterSeller.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblDateRegisterSeller.textAlignment = .left
        lblDateRegisterSeller.textColor = UIColor.black
        lblDateRegisterSeller.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDateRegisterSeller.text = "Ngày đăng ký"
        viewSeller.addSubview(lblDateRegisterSeller)
        
        
        let lblDateRegisterSellerValue = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblDateRegisterSeller.frame.origin.y , width: scrollView.frame.size.width  - Common.Size(s: 30), height: Common.Size(s:14)))
        lblDateRegisterSellerValue.textAlignment = .right
        lblDateRegisterSellerValue.textColor = UIColor.black
        lblDateRegisterSellerValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDateRegisterSellerValue.text = "\(self.headerCompleteDetailRP!.NgayDenShop)"
        viewSeller.addSubview(lblDateRegisterSellerValue)
        
        viewSeller.frame.size.height = lblDateRegisterSeller.frame.size.height + lblDateRegisterSeller.frame.origin.y + Common.Size(s: 10)
        
        
        let label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewSeller.frame.size.height + viewSeller.frame.origin.y , width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label2.text = "THÔNG TIN NGƯỜI MUA" //Outbound
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label2)
        
        
        let viewBuyer = UIView()
        viewBuyer.frame = CGRect(x: 0, y: label2.frame.size.height + label2.frame.origin.y , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewBuyer.backgroundColor = UIColor.white
        scrollView.addSubview(viewBuyer)
        
        
    
        
        let lblBuyerName = UILabel(frame: CGRect(x: Common.Size(s:10), y:  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblBuyerName.textAlignment = .left
        lblBuyerName.textColor = UIColor.black
        lblBuyerName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBuyerName.text = "Họ tên"
        viewBuyer.addSubview(lblBuyerName)
        
        let lblBuyerNameValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblBuyerName.frame.origin.y , width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblBuyerNameValue.textAlignment = .right
        lblBuyerNameValue.textColor = UIColor.black
        lblBuyerNameValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBuyerNameValue.text = "\(self.headerCompleteDetailRP!.Buy_Name)"
        viewBuyer.addSubview(lblBuyerNameValue)
        
        let lblBuyerPhone = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblBuyerName.frame.size.height + lblBuyerName.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblBuyerPhone.textAlignment = .left
        lblBuyerPhone.textColor = UIColor.black
        lblBuyerPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBuyerPhone.text = "SDT"
        viewBuyer.addSubview(lblBuyerPhone)
        
        
        let lblBuyerPhoneValue = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblBuyerPhone.frame.origin.y , width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblBuyerPhoneValue.textAlignment = .right
        lblBuyerPhoneValue.textColor = UIColor.black
        lblBuyerPhoneValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBuyerPhoneValue.text = "\(self.headerCompleteDetailRP!.Buy_phone)"
        viewBuyer.addSubview(lblBuyerPhoneValue)
        
        
        let lblBuyerMail = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblBuyerPhone.frame.size.height + lblBuyerPhone.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblBuyerMail.textAlignment = .left
        lblBuyerMail.textColor = UIColor.black
        lblBuyerMail.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBuyerMail.text = "Mail"
        viewBuyer.addSubview(lblBuyerMail)
        
        let lblBuyerMailValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:lblBuyerMail.frame.origin.y , width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblBuyerMailValue.textAlignment = .right
        lblBuyerMailValue.textColor = UIColor.black
        lblBuyerMailValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBuyerMailValue.text = "\(self.headerCompleteDetailRP!.Buy_mail)"
        viewBuyer.addSubview(lblBuyerMailValue)
        
        
        let lblShopRegisterBuyer = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblBuyerMail.frame.size.height + lblBuyerMail.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblShopRegisterBuyer.textAlignment = .left
        lblShopRegisterBuyer.textColor = UIColor.black
        lblShopRegisterBuyer.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblShopRegisterBuyer.text = "Shop bán"
        viewBuyer.addSubview(lblShopRegisterBuyer)
        
        
        let lblShopRegisterBuyerValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblShopRegisterBuyer.frame.origin.y , width: scrollView.frame.size.width  - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblShopRegisterBuyerValue.textAlignment = .right
        lblShopRegisterBuyerValue.textColor = UIColor.black
        lblShopRegisterBuyerValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblShopRegisterBuyerValue.text = "\(self.headerCompleteDetailRP!.TenShopDK)"
        viewBuyer.addSubview(lblShopRegisterBuyerValue)
        
        let lblDateRegisterBuyer = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblShopRegisterBuyer.frame.size.height + lblShopRegisterBuyer.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width  - Common.Size(s: 30), height: Common.Size(s:14)))
        lblDateRegisterBuyer.textAlignment = .left
        lblDateRegisterBuyer.textColor = UIColor.black
        lblDateRegisterBuyer.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDateRegisterBuyer.text = "Ngày bán"
        viewBuyer.addSubview(lblDateRegisterBuyer)
        
        
        let lblDateRegisterBuyerValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblDateRegisterBuyer.frame.origin.y , width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblDateRegisterBuyerValue.textAlignment = .right
        lblDateRegisterBuyerValue.textColor = UIColor.black
        lblDateRegisterBuyerValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDateRegisterBuyerValue.text = "\(self.headerCompleteDetailRP!.buy_date)"
        viewBuyer.addSubview(lblDateRegisterBuyerValue)
        viewBuyer.frame.size.height = lblDateRegisterBuyer.frame.size.height + lblDateRegisterBuyer.frame.origin.y + Common.Size(s:10)
        
        let labelProduct = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewBuyer.frame.size.height + viewBuyer.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labelProduct.text = "THÔNG TIN SẢN PHẨM"
        labelProduct.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(labelProduct)
        
        
        let viewProduct = UIView()
        viewProduct.frame = CGRect(x: 0, y: labelProduct.frame.size.height + labelProduct.frame.origin.y, width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewProduct.backgroundColor = UIColor.white
        scrollView.addSubview(viewProduct)
        
        
        let lblNameProduct = UILabel(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblNameProduct.textAlignment = .left
        lblNameProduct.textColor = UIColor.black
        lblNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNameProduct.text = "Tên SP"
        viewProduct.addSubview(lblNameProduct)
        
        
        let lblNameProductValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblNameProduct.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblNameProductValue.textAlignment = .right
        lblNameProductValue.textColor = UIColor.black
        lblNameProductValue.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lblNameProductValue.text = "\(self.headerCompleteDetailRP!.ItemName)"
        viewProduct.addSubview(lblNameProductValue)
        
        
        let lblPrice = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblNameProduct.frame.size.height + lblNameProduct.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblPrice.textAlignment = .left
        lblPrice.textColor = UIColor.black
        lblPrice.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPrice.text = "Giá SP"
        viewProduct.addSubview(lblPrice)
        
        let lblPriceValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblPrice.frame.origin.y , width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblPriceValue.textAlignment = .right
        lblPriceValue.textColor = UIColor.black
        lblPriceValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        lblPriceValue.text = "\(Common.convertCurrencyFloat(value: self.headerCompleteDetailRP!.Sale_price))"
        viewProduct.addSubview(lblPriceValue)
        
        
        let lblImei = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblPrice.frame.size.height + lblPrice.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblImei.textAlignment = .left
        lblImei.textColor = UIColor.black
        lblImei.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblImei.text = "Imei"
        viewProduct.addSubview(lblImei)
        
        
        let lblImeiValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:lblImei.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblImeiValue.textAlignment = .right
        lblImeiValue.textColor = UIColor.black
        lblImeiValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblImeiValue.text = "\(self.headerCompleteDetailRP!.IMEI)"
        viewProduct.addSubview(lblImeiValue)
        
        

        
        let lblPhieuLCNB = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblImei.frame.size.height + lblImei.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblPhieuLCNB.textAlignment = .left
        lblPhieuLCNB.textColor = UIColor.black
        lblPhieuLCNB.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPhieuLCNB.text = "Phiếu LCNB"
        viewProduct.addSubview(lblPhieuLCNB)
        
        
        let lblPhieuLCNBValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblPhieuLCNB.frame.origin.y , width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblPhieuLCNBValue.textAlignment = .left
        lblPhieuLCNBValue.textColor = UIColor.black
        lblPhieuLCNBValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPhieuLCNBValue.text = "\(self.headerCompleteDetailRP!.LCNB_number)"
        viewProduct.addSubview(lblPhieuLCNBValue)
        
        
        
        let lblStatusLCNB = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblPhieuLCNB.frame.size.height + lblPhieuLCNB.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblStatusLCNB.textAlignment = .left
        lblStatusLCNB.textColor = UIColor.black
        lblStatusLCNB.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblStatusLCNB.text = "Tình trạng LCNB"
        viewProduct.addSubview(lblStatusLCNB)
        
        
        let lblStatusLCNBValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblStatusLCNB.frame.origin.y , width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblStatusLCNBValue.textAlignment = .left
        lblStatusLCNBValue.textColor = UIColor.black
        lblStatusLCNBValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblStatusLCNBValue.text = "\(self.headerCompleteDetailRP!.LCNB_TrangThai)"
        viewProduct.addSubview(lblStatusLCNBValue)
        
  
        
        let lblNote = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblStatusLCNB.frame.size.height + lblStatusLCNB.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width  - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblNote.textAlignment = .left
        lblNote.textColor = UIColor.black
        lblNote.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNote.text = "Ghi chú"
        viewProduct.addSubview(lblNote)
        
        
        let lblNoteValue = UILabel(frame: CGRect(x:lblNote.frame.size.width + lblNote.frame.origin.x, y: lblNote.frame.origin.y, width: self.view.frame.width - Common.Size(s: 100), height: Common.Size(s: 20)))
        
        lblNoteValue.textAlignment = .right
        
        lblNoteValue.textColor = UIColor(netHex:0x00955E)
        lblNoteValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lblNoteValue.text = self.headerCompleteDetailRP!.Note
        viewProduct.addSubview(lblNoteValue)
        
        let lblNoteValueHeight:CGFloat = lblNoteValue.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lblNoteValue.optimalHeight
        lblNoteValue.numberOfLines = 0
        lblNoteValue.frame = CGRect(x: lblNoteValue.frame.origin.x, y: lblNoteValue.frame.origin.y, width: lblNoteValue.frame.width, height: lblNoteValueHeight)
        
        
        
        viewProduct.frame.size.height = lblNoteValue.frame.size.height + lblNoteValue.frame.origin.y + Common.Size(s: 10)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewProduct.frame.origin.y + viewProduct.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        
        
    }
    
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
}
