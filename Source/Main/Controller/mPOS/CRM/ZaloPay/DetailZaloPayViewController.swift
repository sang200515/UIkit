//
//  DetailZaloPayViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 29/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Toaster
class DetailZaloPayViewController: UIViewController {
    var orderId: String?
    var safeArea: UILayoutGuide!
    var scrollView = UIScrollView()
    var lbNo = UILabel()
    var lbTime = UILabel()
    var lbShop = UILabel()
    var lbUser = UILabel()
    var lbStatus = UILabel()
    var lbProductCustomerName = UILabel()
    var lbProductCustomerPhoneNumber = UILabel()
    var lbCustomerName = UILabel()
    var lbCustomerPhoneNumber = UILabel()
    var lbPaymentMethod = UILabel()
    var lbTotalFee = UILabel()
    let lbTotalAmount = UILabel()
    let lbTotalAmountIncludingFee = UILabel()
    var isCreated: Bool = false
    var detailData: DetailOrderZaloPay?
    var btnPrint = UIButton()
    let viewInfoPayment = UIView()
    
    var productSOM: ProductSOM?
    var providerSOM: ProviderSOM?
    var isHistory: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        safeArea = view.layoutMarginsGuide
        self.title = "Chi Tiết Giao Dịch"
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(self.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        initUI()
        loadData()
    }
    
    func initUI(){
        scrollView.backgroundColor = .clear
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
        let lbTextHeaderInfoTransaction = UILabel()
        lbTextHeaderInfoTransaction.text = "THÔNG TIN GIAO DỊCH"
        lbTextHeaderInfoTransaction.textColor = UIColor(netHex:0x00955E)
        lbTextHeaderInfoTransaction.backgroundColor = .clear
        lbTextHeaderInfoTransaction.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        scrollView.addSubview(lbTextHeaderInfoTransaction)
        lbTextHeaderInfoTransaction.translatesAutoresizingMaskIntoConstraints = false
        lbTextHeaderInfoTransaction.leadingAnchor.constraint(equalTo:scrollView.leadingAnchor,constant: Common.Size(s: 10)).isActive = true
        lbTextHeaderInfoTransaction.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: Common.Size(s: 5)).isActive = true
        lbTextHeaderInfoTransaction.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: Common.Size(s: -10)).isActive = true
        lbTextHeaderInfoTransaction.heightAnchor.constraint(equalToConstant: Common.Size(s: 20)).isActive = true
        lbTextHeaderInfoTransaction.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: Common.Size(s: -20)).isActive = true
        
        let viewInfoTransaction = UIView()
        viewInfoTransaction.backgroundColor = .white
        scrollView.addSubview(viewInfoTransaction)

        viewInfoTransaction.translatesAutoresizingMaskIntoConstraints = false
        viewInfoTransaction.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        viewInfoTransaction.topAnchor.constraint(equalTo: lbTextHeaderInfoTransaction.bottomAnchor,constant: Common.Size(s: 5)).isActive = true
        viewInfoTransaction.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
//        viewInfoTransaction.heightAnchor.constraint(equalToConstant: Common.Size(s: 100)).isActive = true
        viewInfoTransaction.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let lbTextNo = UILabel()
        lbTextNo.translatesAutoresizingMaskIntoConstraints = false
        viewInfoTransaction.addSubview(lbTextNo)
        lbTextNo.leftAnchor.constraint(equalTo: viewInfoTransaction.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextNo.topAnchor.constraint(equalTo: viewInfoTransaction.topAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextNo.widthAnchor.constraint(equalTo: viewInfoTransaction.widthAnchor, multiplier: 1/4).isActive = true

        lbTextNo.textAlignment = .left
        lbTextNo.textColor = UIColor.black
        lbTextNo.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextNo.text = "Số phiếu:"
        
        lbNo.translatesAutoresizingMaskIntoConstraints = false
        viewInfoTransaction.addSubview(lbNo)
        lbNo.leftAnchor.constraint(equalTo: lbTextNo.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbNo.topAnchor.constraint(equalTo: lbTextNo.topAnchor).isActive = true
        lbNo.rightAnchor.constraint(equalTo: viewInfoTransaction.rightAnchor, constant: Common.Size(s: -10)).isActive = true
        lbNo.textAlignment = .right
        lbNo.textColor = UIColor.black
        lbNo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbNo.text = ""
        
        let lbTextTime = UILabel()
        lbTextTime.translatesAutoresizingMaskIntoConstraints = false
        viewInfoTransaction.addSubview(lbTextTime)
        lbTextTime.leftAnchor.constraint(equalTo: lbTextNo.leftAnchor).isActive = true
        lbTextTime.topAnchor.constraint(equalTo: lbTextNo.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextTime.widthAnchor.constraint(equalTo: lbTextNo.widthAnchor).isActive = true

        lbTextTime.textAlignment = .left
        lbTextTime.textColor = UIColor.black
        lbTextTime.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTime.text = "Thời gian:"
        
        lbTime.translatesAutoresizingMaskIntoConstraints = false
        viewInfoTransaction.addSubview(lbTime)
        lbTime.leftAnchor.constraint(equalTo: lbTextTime.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbTime.topAnchor.constraint(equalTo: lbTextTime.topAnchor).isActive = true
        lbTime.rightAnchor.constraint(equalTo: lbNo.rightAnchor).isActive = true
        lbTime.textAlignment = .right
        lbTime.textColor = UIColor.black
        lbTime.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        
        let lbTextShop = UILabel()
        lbTextShop.translatesAutoresizingMaskIntoConstraints = false
        viewInfoTransaction.addSubview(lbTextShop)
        lbTextShop.leftAnchor.constraint(equalTo: lbTextTime.leftAnchor).isActive = true
        lbTextShop.topAnchor.constraint(equalTo: lbTextTime.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextShop.widthAnchor.constraint(equalTo: viewInfoTransaction.widthAnchor, multiplier: 1/7).isActive = true

        lbTextShop.textAlignment = .left
        lbTextShop.textColor = UIColor.black
        lbTextShop.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextShop.text = "Shop:"
        
        lbShop.translatesAutoresizingMaskIntoConstraints = false
        viewInfoTransaction.addSubview(lbShop)
        lbShop.leftAnchor.constraint(equalTo: lbTextShop.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbShop.topAnchor.constraint(equalTo: lbTextShop.topAnchor).isActive = true
        lbShop.rightAnchor.constraint(equalTo: lbNo.rightAnchor).isActive = true
        lbShop.textAlignment = .right
        lbShop.textColor = UIColor.black
        lbShop.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        
        let lbTextUser = UILabel()
        lbTextUser.translatesAutoresizingMaskIntoConstraints = false
        viewInfoTransaction.addSubview(lbTextUser)
        lbTextUser.leftAnchor.constraint(equalTo: lbTextShop.leftAnchor).isActive = true
        lbTextUser.topAnchor.constraint(equalTo: lbTextShop.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextUser.widthAnchor.constraint(equalTo: viewInfoTransaction.widthAnchor, multiplier: 1/3.5).isActive = true

        lbTextUser.textAlignment = .left
        lbTextUser.textColor = UIColor.black
        lbTextUser.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextUser.text = "NV giao dịch:"
        
        lbUser.translatesAutoresizingMaskIntoConstraints = false
        viewInfoTransaction.addSubview(lbUser)
        lbUser.leftAnchor.constraint(equalTo: lbTextUser.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbUser.topAnchor.constraint(equalTo: lbTextUser.topAnchor).isActive = true
        lbUser.rightAnchor.constraint(equalTo: lbNo.rightAnchor).isActive = true
        lbUser.textAlignment = .right
        lbUser.textColor = UIColor.black
        lbUser.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        
        let lbTextStatus = UILabel()
        lbTextStatus.translatesAutoresizingMaskIntoConstraints = false
        viewInfoTransaction.addSubview(lbTextStatus)
        lbTextStatus.leftAnchor.constraint(equalTo: lbTextUser.leftAnchor).isActive = true
        lbTextStatus.topAnchor.constraint(equalTo: lbTextUser.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextStatus.widthAnchor.constraint(equalTo: viewInfoTransaction.widthAnchor, multiplier: 1/4).isActive = true

        lbTextStatus.textAlignment = .left
        lbTextStatus.textColor = UIColor.black
        lbTextStatus.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextStatus.text = "Trạng thái:"
        
        lbStatus.translatesAutoresizingMaskIntoConstraints = false
        viewInfoTransaction.addSubview(lbStatus)
        lbStatus.leftAnchor.constraint(equalTo: lbTextStatus.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbStatus.topAnchor.constraint(equalTo: lbTextStatus.topAnchor).isActive = true
        lbStatus.rightAnchor.constraint(equalTo: lbNo.rightAnchor).isActive = true
        lbStatus.textAlignment = .right
        lbStatus.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbStatus.bottomAnchor.constraint(equalTo: viewInfoTransaction.bottomAnchor,constant: Common.Size(s: -10)).isActive = true
        
        let lbTextHeaderInfoCustomer = UILabel()
        lbTextHeaderInfoCustomer.text = "THÔNG TIN KHÁCH HÀNG"
        lbTextHeaderInfoCustomer.textColor = UIColor(netHex:0x00955E)
        lbTextHeaderInfoCustomer.backgroundColor = .clear
        lbTextHeaderInfoCustomer.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        scrollView.addSubview(lbTextHeaderInfoCustomer)
        lbTextHeaderInfoCustomer.translatesAutoresizingMaskIntoConstraints = false
        lbTextHeaderInfoCustomer.leadingAnchor.constraint(equalTo:scrollView.leadingAnchor,constant: Common.Size(s: 10)).isActive = true
        lbTextHeaderInfoCustomer.topAnchor.constraint(equalTo: viewInfoTransaction.bottomAnchor,constant: Common.Size(s: 5)).isActive = true
        lbTextHeaderInfoCustomer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: Common.Size(s: -10)).isActive = true
        lbTextHeaderInfoCustomer.heightAnchor.constraint(equalToConstant: Common.Size(s: 20)).isActive = true
        lbTextHeaderInfoCustomer.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: Common.Size(s: -20)).isActive = true
        
        let viewInfoCustomer = UIView()
        viewInfoCustomer.backgroundColor = .white
        scrollView.addSubview(viewInfoCustomer)

        viewInfoCustomer.translatesAutoresizingMaskIntoConstraints = false
        viewInfoCustomer.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        viewInfoCustomer.topAnchor.constraint(equalTo: lbTextHeaderInfoCustomer.bottomAnchor,constant: Common.Size(s: 5)).isActive = true
        viewInfoCustomer.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
//        viewInfoCustomer.heightAnchor.constraint(equalToConstant: Common.Size(s: 100)).isActive = true
        viewInfoCustomer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let lbTextProductCustomerName = UILabel()
        lbTextProductCustomerName.translatesAutoresizingMaskIntoConstraints = false
        viewInfoCustomer.addSubview(lbTextProductCustomerName)
        lbTextProductCustomerName.leftAnchor.constraint(equalTo: viewInfoCustomer.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextProductCustomerName.topAnchor.constraint(equalTo: viewInfoCustomer.topAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextProductCustomerName.widthAnchor.constraint(equalTo: viewInfoCustomer.widthAnchor, multiplier: 1/3).isActive = true
        
        lbTextProductCustomerName.textAlignment = .left
        lbTextProductCustomerName.textColor = UIColor.black
        lbTextProductCustomerName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextProductCustomerName.text = "Chủ tài khoản:"
        
        lbProductCustomerName.translatesAutoresizingMaskIntoConstraints = false
        viewInfoCustomer.addSubview(lbProductCustomerName)
        lbProductCustomerName.leftAnchor.constraint(equalTo: lbTextProductCustomerName.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbProductCustomerName.topAnchor.constraint(equalTo: lbTextProductCustomerName.topAnchor).isActive = true
        lbProductCustomerName.rightAnchor.constraint(equalTo: viewInfoCustomer.rightAnchor, constant: Common.Size(s: -10)).isActive = true
        lbProductCustomerName.textAlignment = .right
        lbProductCustomerName.textColor = UIColor.black
        lbProductCustomerName.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        
        let lbTextProductCustomerPhone = UILabel()
        lbTextProductCustomerPhone.translatesAutoresizingMaskIntoConstraints = false
        viewInfoCustomer.addSubview(lbTextProductCustomerPhone)
        lbTextProductCustomerPhone.leftAnchor.constraint(equalTo: lbTextProductCustomerName.leftAnchor).isActive = true
        lbTextProductCustomerPhone.topAnchor.constraint(equalTo: lbTextProductCustomerName.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextProductCustomerPhone.widthAnchor.constraint(equalTo: viewInfoCustomer.widthAnchor, multiplier: 1/3).isActive = true
        
        lbTextProductCustomerPhone.textAlignment = .left
        lbTextProductCustomerPhone.textColor = UIColor.black
        lbTextProductCustomerPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextProductCustomerPhone.text = "Số điện thoại:"
        
        lbProductCustomerPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        viewInfoCustomer.addSubview(lbProductCustomerPhoneNumber)
        lbProductCustomerPhoneNumber.leftAnchor.constraint(equalTo: lbTextProductCustomerPhone.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbProductCustomerPhoneNumber.topAnchor.constraint(equalTo: lbTextProductCustomerPhone.topAnchor).isActive = true
        lbProductCustomerPhoneNumber.rightAnchor.constraint(equalTo: lbProductCustomerName.rightAnchor).isActive = true
        lbProductCustomerPhoneNumber.textAlignment = .right
        lbProductCustomerPhoneNumber.textColor = UIColor.black
        lbProductCustomerPhoneNumber.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
       
        let lbTextCustomerName = UILabel()
        lbTextCustomerName.translatesAutoresizingMaskIntoConstraints = false
        viewInfoCustomer.addSubview(lbTextCustomerName)
        lbTextCustomerName.leftAnchor.constraint(equalTo: lbTextProductCustomerPhone.leftAnchor).isActive = true
        lbTextCustomerName.topAnchor.constraint(equalTo: lbTextProductCustomerPhone.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextCustomerName.widthAnchor.constraint(equalTo: viewInfoCustomer.widthAnchor, multiplier: 1/3).isActive = true
        
        lbTextCustomerName.textAlignment = .left
        lbTextCustomerName.textColor = UIColor.black
        lbTextCustomerName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCustomerName.text = "Người thanh toán:"
        
        lbCustomerName.translatesAutoresizingMaskIntoConstraints = false
        viewInfoCustomer.addSubview(lbCustomerName)
        lbCustomerName.leftAnchor.constraint(equalTo: lbTextCustomerName.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbCustomerName.topAnchor.constraint(equalTo: lbTextCustomerName.topAnchor).isActive = true
        lbCustomerName.rightAnchor.constraint(equalTo: lbProductCustomerName.rightAnchor).isActive = true
        lbCustomerName.textAlignment = .right
        lbCustomerName.textColor = UIColor.black
        lbCustomerName.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        
        let lbTextCustomerPhone = UILabel()
        lbTextCustomerPhone.translatesAutoresizingMaskIntoConstraints = false
        viewInfoCustomer.addSubview(lbTextCustomerPhone)
        lbTextCustomerPhone.leftAnchor.constraint(equalTo: lbTextCustomerName.leftAnchor).isActive = true
        lbTextCustomerPhone.topAnchor.constraint(equalTo: lbTextCustomerName.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextCustomerPhone.widthAnchor.constraint(equalTo: viewInfoCustomer.widthAnchor, multiplier: 1/3).isActive = true
        
        lbTextCustomerPhone.textAlignment = .left
        lbTextCustomerPhone.textColor = UIColor.black
        lbTextCustomerPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCustomerPhone.text = "Số điện thoại:"
        
        lbCustomerPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        viewInfoCustomer.addSubview(lbCustomerPhoneNumber)
        lbCustomerPhoneNumber.leftAnchor.constraint(equalTo: lbTextCustomerPhone.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbCustomerPhoneNumber.topAnchor.constraint(equalTo: lbTextCustomerPhone.topAnchor).isActive = true
        lbCustomerPhoneNumber.rightAnchor.constraint(equalTo: lbProductCustomerName.rightAnchor).isActive = true
        lbCustomerPhoneNumber.textAlignment = .right
        lbCustomerPhoneNumber.textColor = UIColor.black
        lbCustomerPhoneNumber.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbCustomerPhoneNumber.bottomAnchor.constraint(equalTo: viewInfoCustomer.bottomAnchor, constant: Common.Size(s: -10)).isActive = true
        
        
        let lbTextHeaderPaymentMethod = UILabel()
        lbTextHeaderPaymentMethod.text = "HÌNH THỨC THANH TOÁN"
        lbTextHeaderPaymentMethod.textColor = UIColor(netHex:0x00955E)
        lbTextHeaderPaymentMethod.backgroundColor = .clear
        lbTextHeaderPaymentMethod.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        scrollView.addSubview(lbTextHeaderPaymentMethod)
        lbTextHeaderPaymentMethod.translatesAutoresizingMaskIntoConstraints = false
        lbTextHeaderPaymentMethod.leadingAnchor.constraint(equalTo:scrollView.leadingAnchor,constant: Common.Size(s: 10)).isActive = true
        lbTextHeaderPaymentMethod.topAnchor.constraint(equalTo: viewInfoCustomer.bottomAnchor,constant: Common.Size(s: 5)).isActive = true
        lbTextHeaderPaymentMethod.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: Common.Size(s: -10)).isActive = true
        lbTextHeaderPaymentMethod.heightAnchor.constraint(equalToConstant: Common.Size(s: 20)).isActive = true
        lbTextHeaderPaymentMethod.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: Common.Size(s: -20)).isActive = true
        
        let viewPaymentMethod = UIView()
        viewPaymentMethod.backgroundColor = .white
        scrollView.addSubview(viewPaymentMethod)

        viewPaymentMethod.translatesAutoresizingMaskIntoConstraints = false
        viewPaymentMethod.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        viewPaymentMethod.topAnchor.constraint(equalTo: lbTextHeaderPaymentMethod.bottomAnchor,constant: Common.Size(s: 5)).isActive = true
        viewPaymentMethod.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
//        viewPaymentMethod.heightAnchor.constraint(equalToConstant: Common.Size(s: 100)).isActive = true
        viewPaymentMethod.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let lbTextPaymentMethod = UILabel()
        lbTextPaymentMethod.translatesAutoresizingMaskIntoConstraints = false
        viewPaymentMethod.addSubview(lbTextPaymentMethod)
        lbTextPaymentMethod.leftAnchor.constraint(equalTo: viewPaymentMethod.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextPaymentMethod.topAnchor.constraint(equalTo: viewPaymentMethod.topAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextPaymentMethod.widthAnchor.constraint(equalTo: viewPaymentMethod.widthAnchor, multiplier: 1/3).isActive = true
        
        lbTextPaymentMethod.textAlignment = .left
        lbTextPaymentMethod.textColor = UIColor.black
        lbTextPaymentMethod.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPaymentMethod.text = "Tiền mặt:"
        
        lbPaymentMethod.translatesAutoresizingMaskIntoConstraints = false
        viewPaymentMethod.addSubview(lbPaymentMethod)
        lbPaymentMethod.leftAnchor.constraint(equalTo: lbTextPaymentMethod.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbPaymentMethod.topAnchor.constraint(equalTo: lbTextPaymentMethod.topAnchor).isActive = true
        lbPaymentMethod.rightAnchor.constraint(equalTo: viewPaymentMethod.rightAnchor, constant: Common.Size(s: -10)).isActive = true
        lbPaymentMethod.textAlignment = .right
        lbPaymentMethod.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbPaymentMethod.bottomAnchor.constraint(equalTo: viewPaymentMethod.bottomAnchor, constant: Common.Size(s: -10)).isActive = true
        lbPaymentMethod.textColor = UIColor(netHex:0x00955E)
        
        let lbTextHeaderInfoPayment = UILabel()
        lbTextHeaderInfoPayment.text = "THÔNG TIN THANH TOÁN"
        lbTextHeaderInfoPayment.textColor = UIColor(netHex:0x00955E)
        lbTextHeaderInfoPayment.backgroundColor = .clear
        lbTextHeaderInfoPayment.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        scrollView.addSubview(lbTextHeaderInfoPayment)
        lbTextHeaderInfoPayment.translatesAutoresizingMaskIntoConstraints = false
        lbTextHeaderInfoPayment.leadingAnchor.constraint(equalTo:scrollView.leadingAnchor,constant: Common.Size(s: 10)).isActive = true
        lbTextHeaderInfoPayment.topAnchor.constraint(equalTo: viewPaymentMethod.bottomAnchor,constant: Common.Size(s: 5)).isActive = true
        lbTextHeaderInfoPayment.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: Common.Size(s: -10)).isActive = true
        lbTextHeaderInfoPayment.heightAnchor.constraint(equalToConstant: Common.Size(s: 20)).isActive = true
        lbTextHeaderInfoPayment.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: Common.Size(s: -20)).isActive = true
        

        viewInfoPayment.backgroundColor = .white
        scrollView.addSubview(viewInfoPayment)

        viewInfoPayment.translatesAutoresizingMaskIntoConstraints = false
        viewInfoPayment.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        viewInfoPayment.topAnchor.constraint(equalTo: lbTextHeaderInfoPayment.bottomAnchor,constant: Common.Size(s: 5)).isActive = true
        viewInfoPayment.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
//        viewInfoPayment.heightAnchor.constraint(equalToConstant: Common.Size(s: 100)).isActive = true
        viewInfoPayment.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let lbTextTotalFee = UILabel()
        lbTextTotalFee.translatesAutoresizingMaskIntoConstraints = false
        viewInfoPayment.addSubview(lbTextTotalFee)
        lbTextTotalFee.leftAnchor.constraint(equalTo: viewInfoPayment.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextTotalFee.topAnchor.constraint(equalTo: viewInfoPayment.topAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextTotalFee.widthAnchor.constraint(equalTo: viewInfoPayment.widthAnchor, multiplier: 1/3).isActive = true
        
        lbTextTotalFee.textAlignment = .left
        lbTextTotalFee.textColor = UIColor.black
        lbTextTotalFee.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTotalFee.text = "Tổng tiền phí:"
        
        lbTotalFee.translatesAutoresizingMaskIntoConstraints = false
        viewInfoPayment.addSubview(lbTotalFee)
        lbTotalFee.leftAnchor.constraint(equalTo: lbTextTotalFee.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbTotalFee.topAnchor.constraint(equalTo: lbTextTotalFee.topAnchor).isActive = true
        lbTotalFee.rightAnchor.constraint(equalTo: viewInfoPayment.rightAnchor, constant: Common.Size(s: -10)).isActive = true
        lbTotalFee.textAlignment = .right
        lbTotalFee.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbTotalFee.textColor = .red
        
        let lbTextTotalAmount = UILabel()
        lbTextTotalAmount.translatesAutoresizingMaskIntoConstraints = false
        viewInfoPayment.addSubview(lbTextTotalAmount)
        lbTextTotalAmount.leftAnchor.constraint(equalTo: lbTextTotalFee.leftAnchor).isActive = true
        lbTextTotalAmount.topAnchor.constraint(equalTo: lbTextTotalFee.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextTotalAmount.widthAnchor.constraint(equalTo: viewInfoPayment.widthAnchor, multiplier: 1/3).isActive = true
        
        lbTextTotalAmount.textAlignment = .left
        lbTextTotalAmount.textColor = UIColor.black
        lbTextTotalAmount.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTotalAmount.text = "Tổng tiền nạp:"
        
        lbTotalAmount.translatesAutoresizingMaskIntoConstraints = false
        viewInfoPayment.addSubview(lbTotalAmount)
        lbTotalAmount.leftAnchor.constraint(equalTo: lbTextTotalAmount.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbTotalAmount.topAnchor.constraint(equalTo: lbTextTotalAmount.topAnchor).isActive = true
        lbTotalAmount.rightAnchor.constraint(equalTo: lbTotalFee.rightAnchor).isActive = true
        lbTotalAmount.textAlignment = .right
        lbTotalAmount.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbTotalAmount.textColor = .red
        
        let lbTextTotalAmountIncludingFee = UILabel()
        lbTextTotalAmountIncludingFee.translatesAutoresizingMaskIntoConstraints = false
        viewInfoPayment.addSubview(lbTextTotalAmountIncludingFee)
        lbTextTotalAmountIncludingFee.leftAnchor.constraint(equalTo: lbTextTotalAmount.leftAnchor).isActive = true
        lbTextTotalAmountIncludingFee.topAnchor.constraint(equalTo: lbTextTotalAmount.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextTotalAmountIncludingFee.widthAnchor.constraint(equalTo: viewInfoPayment.widthAnchor, multiplier: 1/2).isActive = true
        
        lbTextTotalAmountIncludingFee.textAlignment = .left
        lbTextTotalAmountIncludingFee.textColor = UIColor.black
        lbTextTotalAmountIncludingFee.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTotalAmountIncludingFee.text = "Tổng tiền thanh toán:"
        
        lbTotalAmountIncludingFee.translatesAutoresizingMaskIntoConstraints = false
        viewInfoPayment.addSubview(lbTotalAmountIncludingFee)
        lbTotalAmountIncludingFee.leftAnchor.constraint(equalTo: lbTextTotalAmountIncludingFee.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbTotalAmountIncludingFee.topAnchor.constraint(equalTo: lbTextTotalAmountIncludingFee.topAnchor).isActive = true
        lbTotalAmountIncludingFee.rightAnchor.constraint(equalTo: lbTotalAmount.rightAnchor).isActive = true
        lbTotalAmountIncludingFee.textAlignment = .right
        lbTotalAmountIncludingFee.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbTotalAmountIncludingFee.textColor = .red
        
        btnPrint.setTitle("IN", for: .normal)
        btnPrint.backgroundColor = UIColor(netHex:0x00955E)
        btnPrint.setTitleColor(.white, for: .normal)
        btnPrint.layer.cornerRadius = 10
        viewInfoPayment.addSubview(btnPrint)
        btnPrint.translatesAutoresizingMaskIntoConstraints = false
        btnPrint.topAnchor.constraint(equalTo: lbTotalAmountIncludingFee.bottomAnchor, constant: Common.Size(s: 25)).isActive = true
        btnPrint.leftAnchor.constraint(equalTo: viewInfoPayment.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        btnPrint.rightAnchor.constraint(equalTo: viewInfoPayment.rightAnchor, constant: Common.Size(s: -10)).isActive = true
        btnPrint.heightAnchor.constraint(equalToConstant: Common.Size(s: 30)).isActive = true
        btnPrint.bottomAnchor.constraint(equalTo: viewInfoPayment.bottomAnchor, constant: Common.Size(s: -10)).isActive = true
        btnPrint.addTarget(self, action: #selector(printAction), for: .touchUpInside)
        
    }
    @objc func printAction(sender: UIButton!) {
   
        if let detailData = detailData {
            if(detailData.orderStatus == .PROCESSING || detailData.orderStatus == .SUCCESS || detailData.orderStatus == .CREATE){
                print("IN")
                getVoucher(detailData: detailData)
            }
        }
    }
    
    func getVoucher(detailData: DetailOrderZaloPay){
        ZaloPayServiceImpl.getVoucher(id: "\(detailData.id)", providerName: "\(providerSOM!.name)") { response in
            if let response = response{
                if(response.status == "SUCCESS"){
                    var voucher = response.message
                    if(!voucher.isEmpty){
                        voucher = voucher.replacingOccurrences(of: "|-|", with: ";")
                    }
                    self.printData(detailData: detailData,voucher: voucher)
                }else{
                    self.printData(detailData: detailData,voucher: "")
                }
            }else{
                self.printData(detailData: detailData,voucher: "")
            }
        }
    }
    func printData(detailData: DetailOrderZaloPay, voucher: String){
        let header = RequestHeaderPrintBill(BillCode: detailData.billNo, TransactionCode: detailData.orderTransactionDtos[0].transactionCode ?? "", TongTienThanhToan: "\((detailData.orderTransactionDtos[0].totalAmountIncludingFee ?? 0).clean)", ServiceName: detailData.orderTransactionDtos[0].productName ?? "", ProVideName: "\(providerSOM!.name)", Employname: detailData.employeeName, Createby: detailData.creationBy, ShopAddress: detailData.warehouseAddress, ThoiGianXuat: self.convertDate(dateString: detailData.creationTime), MaVoucher: voucher)
        
        let item1 = RequestItemBodyPrintBill(STT: "1", Name: "Số ĐT KH", Value: "\(detailData.customerPhoneNumber)")
        let item2 = RequestItemBodyPrintBill(STT: "2", Name: "Tên KH", Value: "\(detailData.customerName)".uppercased())
        let item3 = RequestItemBodyPrintBill(STT: "3", Name: "Tổng tiền nạp ví", Value: "\(Common.convertCurrencyDouble(value: (detailData.orderTransactionDtos[0].totalAmountIncludingFee ?? 0)))")
        let arr: [RequestItemBodyPrintBill] = [item1,item2,item3]
        
        let body = RequestBodyPrintBill(Detail: arr, Header: header)
 
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(body) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                let requestBody = RequestPrintBill(message: RequestMessagePrintBill(title: "In ZaloPay", body: jsonString, id: "POS", key: "pos_thuho_v2"))
                ZaloPayServiceImpl.printBill(param: requestBody) { result in
                    if let result = result{
                        if(result.result == "OK"){
                            Toast.init(text: "In bill thành công.").show()
                            self.navigationController?.popToViewController(ofClass: ZaloPayViewController.self)
                        }else{
                            Toast.init(text: "In bill thất bại.").show()
                        }
                    }
                }
            }
        }
    }
    
    
    func loadData(){
        ZaloPayServiceImpl.detailOrder(id: self.orderId!) { detailOrder in
            if let detail = detailOrder {
                self.detailData = detail
                self.lbNo.text = "\(detail.billNo)"
                self.lbTime.text = self.convertDate(dateString: detail.creationTime)
                self.lbShop.text = "\(detail.warehouseAddress)"
                self.lbUser.text = "\(detail.employeeName)"
                self.lbStatus.text = "\(detail.orderStatus.name)"
                self.lbStatus.textColor = detail.orderStatus.color
                
                if(detail.orderTransactionDtos.count > 0){
                    let transaction = detail.orderTransactionDtos[0]
                    self.lbProductCustomerName.text = transaction.productCustomerName
                    self.lbProductCustomerPhoneNumber.text = transaction.productCustomerPhoneNumber
                    self.lbTotalFee.text = "\(Common.convertCurrencyDoubleV2(value: transaction.totalFee ?? 0.0)) VNĐ"
                    self.lbTotalAmount.text = "\(Common.convertCurrencyDoubleV2(value: transaction.totalAmount ?? 0.0)) VNĐ"
                    self.lbTotalAmountIncludingFee.text = "\(Common.convertCurrencyDoubleV2(value: transaction.totalAmountIncludingFee ?? 0.0)) VNĐ"
                }
                self.lbCustomerName.text = detail.customerName
                self.lbCustomerPhoneNumber.text = detail.customerPhoneNumber
                
                if(detail.payments.count > 0){
                    self.lbPaymentMethod.text = "\(Common.convertCurrencyDoubleV2(value: detail.payments[0].paymentValue)) VNĐ"
                }
                if(detail.orderStatus == .PROCESSING || detail.orderStatus == .SUCCESS || detail.orderStatus == .CREATE){
                    self.btnPrint.backgroundColor = UIColor(netHex:0x00955E)
                }else{
                    self.btnPrint.backgroundColor = UIColor.gray
                }
                if(!self.isHistory && detail.orderHistories.count > 0){
                    if(detail.orderStatus == .FAILED){
                        let item = detail.orderHistories[0]
                        if(!item.description.isEmpty){
                            self.showPopUp(item.description, "Thông báo", buttonTitle: "OK") {

                            }
                        }
                    }
                }
            }
        }
    }
    func convertDate(dateString: String) -> String {
        let dateFormatterGetWithMs = DateFormatter()
        let dateFormatterGetNoMs = DateFormatter()
        let dateFormatterGetWithMs2 = DateFormatter()
        let dateFormatterGetNoMs2 = DateFormatter()
        dateFormatterGetWithMs.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatterGetNoMs.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatterGetWithMs2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatterGetNoMs2.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        var date: Date? = dateFormatterGetWithMs.date(from: dateString)
        if (date == nil){
            date = dateFormatterGetNoMs.date(from: dateString)
        }
        if (date == nil){
            date = dateFormatterGetWithMs2.date(from: dateString)
        }
        if (date == nil){
            date = dateFormatterGetNoMs2.date(from: dateString)
        }
        if(date != nil){
            return  dateFormatterPrint.string(from: date!)
        }
        return ""
    }
    @objc func actionBack() {
  
        if(isCreated){
            self.navigationController?.popToViewController(ofClass: ZaloPayViewController.self)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
}
extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
