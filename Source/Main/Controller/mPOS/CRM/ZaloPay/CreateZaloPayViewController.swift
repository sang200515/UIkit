//
//  CreateZaloPayViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 28/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Toaster
class CreateZaloPayViewController: UIViewController,UITextFieldDelegate {
    var safeArea: UILayoutGuide!
    var scrollView = UIScrollView()
    var tfProductCustomerName = UITextField()
    var tfProductCustomerPhone = UITextField()
    var tfSearchPhone = UITextField()
    var tfCustomerName = UITextField()
    var tfCustomerPhone = UITextField()
    var tfMoney = UITextField()
    var tfContent = UITextField()
    var lbTotalPayment = UILabel()
    
    var productSOM: ProductSOM?
    var providerSOM: ProviderSOM?
    var m_u_id:String = ""
    
    var phoneValid = ["086", "096", "097", "098", "032", "033", "034", "035", "036", "037", "038", "039", "089", "090", "093", "070", "079", "077", "076", "078", "088", "091", "094", "083", "084", "085", "081", "082", "092", "056", "058", "099", "059","052"]
    
    let icBarcode = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        safeArea = view.layoutMarginsGuide
        self.title = "Nạp tiền Zalo Pay"
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(self.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        intervalTime = 1
        m_u_id = ""
        initUI()
    }
    func initUI(){
        scrollView.backgroundColor = .clear
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        let lbTextHeaderInfoProductCustomerName = UILabel()
        lbTextHeaderInfoProductCustomerName.text = "THÔNG TIN CHỦ TÀI KHOẢN"
        lbTextHeaderInfoProductCustomerName.textColor = UIColor(netHex:0x00955E)
        lbTextHeaderInfoProductCustomerName.backgroundColor = .clear
        lbTextHeaderInfoProductCustomerName.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        scrollView.addSubview(lbTextHeaderInfoProductCustomerName)
        lbTextHeaderInfoProductCustomerName.translatesAutoresizingMaskIntoConstraints = false
        lbTextHeaderInfoProductCustomerName.leadingAnchor.constraint(equalTo:scrollView.leadingAnchor,constant: Common.Size(s: 10)).isActive = true
        lbTextHeaderInfoProductCustomerName.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: Common.Size(s: 5)).isActive = true
        lbTextHeaderInfoProductCustomerName.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: Common.Size(s: -10)).isActive = true
        lbTextHeaderInfoProductCustomerName.heightAnchor.constraint(equalToConstant: Common.Size(s: 20)).isActive = true
        lbTextHeaderInfoProductCustomerName.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: Common.Size(s: -20)).isActive = true
        
        let viewInfoProductCustomerName = UIView()
        viewInfoProductCustomerName.backgroundColor = .white
        scrollView.addSubview(viewInfoProductCustomerName)
        
        viewInfoProductCustomerName.translatesAutoresizingMaskIntoConstraints = false
        viewInfoProductCustomerName.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        viewInfoProductCustomerName.topAnchor.constraint(equalTo: lbTextHeaderInfoProductCustomerName.bottomAnchor,constant: Common.Size(s: 5)).isActive = true
        viewInfoProductCustomerName.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        //        viewInfoProductCustomerName.heightAnchor.constraint(equalToConstant: Common.Size(s: 100)).isActive = true
        viewInfoProductCustomerName.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let lbTextSearchPhone = UILabel()
        lbTextSearchPhone.translatesAutoresizingMaskIntoConstraints = false
        viewInfoProductCustomerName.addSubview(lbTextSearchPhone)
        lbTextSearchPhone.leftAnchor.constraint(equalTo: viewInfoProductCustomerName.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextSearchPhone.topAnchor.constraint(equalTo: viewInfoProductCustomerName.topAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextSearchPhone.widthAnchor.constraint(equalTo: viewInfoProductCustomerName.widthAnchor, constant: Common.Size(s: -20)).isActive = true
        
        lbTextSearchPhone.textAlignment = .left
        lbTextSearchPhone.textColor = UIColor.black
        lbTextSearchPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSearchPhone.text = "Số điện thoại ví Zalo Pay"
        
        tfSearchPhone.placeholder = "Nhập số điện thoại"
        tfSearchPhone.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        tfSearchPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfSearchPhone.autocorrectionType = UITextAutocorrectionType.no
        tfSearchPhone.keyboardType = UIKeyboardType.numberPad
        tfSearchPhone.returnKeyType = UIReturnKeyType.done
        tfSearchPhone.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSearchPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        viewInfoProductCustomerName.addSubview(tfSearchPhone)
        tfSearchPhone.translatesAutoresizingMaskIntoConstraints = false
        tfSearchPhone.leftAnchor.constraint(equalTo: viewInfoProductCustomerName.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        tfSearchPhone.topAnchor.constraint(equalTo: lbTextSearchPhone.bottomAnchor, constant: Common.Size(s: 5)).isActive = true
        tfSearchPhone.widthAnchor.constraint(equalTo: viewInfoProductCustomerName.widthAnchor, constant: Common.Size(s: -60)).isActive = true
        tfSearchPhone.heightAnchor.constraint(equalToConstant: Common.Size(s: 30)).isActive = true
        tfSearchPhone.addTarget(self, action: #selector(CreateZaloPayViewController.textFieldDidChange(_:)),
                                for: .editingChanged)
        tfSearchPhone.delegate = self
        tfSearchPhone.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        
        
        
        icBarcode.image = #imageLiteral(resourceName: "barcode")
        icBarcode.contentMode = .scaleAspectFit
        viewInfoProductCustomerName.addSubview(icBarcode)
        
        icBarcode.translatesAutoresizingMaskIntoConstraints = false
        icBarcode.leftAnchor.constraint(equalTo: tfSearchPhone.rightAnchor, constant: Common.Size(s: 10)).isActive = true
        icBarcode.topAnchor.constraint(equalTo: tfSearchPhone.topAnchor).isActive = true
        icBarcode.widthAnchor.constraint(equalTo: tfSearchPhone.heightAnchor).isActive = true
        icBarcode.heightAnchor.constraint(equalTo: tfSearchPhone.heightAnchor).isActive = true
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.scanBarcode))
        icBarcode.addGestureRecognizer(tap)
        icBarcode.isUserInteractionEnabled = true
        
        let lbTextName = UILabel()
        lbTextName.translatesAutoresizingMaskIntoConstraints = false
        viewInfoProductCustomerName.addSubview(lbTextName)
        lbTextName.leftAnchor.constraint(equalTo: lbTextSearchPhone.leftAnchor).isActive = true
        lbTextName.topAnchor.constraint(equalTo: tfSearchPhone.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextName.rightAnchor.constraint(equalTo: lbTextSearchPhone.rightAnchor).isActive = true
        
        lbTextName.textAlignment = .left
        lbTextName.textColor = UIColor.black
        lbTextName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextName.text = "Tên khách hàng"
        
        tfProductCustomerName.placeholder = "Tên khách hàng"
        tfProductCustomerName.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        tfProductCustomerName.borderStyle = UITextField.BorderStyle.roundedRect
        tfProductCustomerName.autocorrectionType = UITextAutocorrectionType.no
        tfProductCustomerName.keyboardType = UIKeyboardType.default
        tfProductCustomerName.returnKeyType = UIReturnKeyType.done
        tfProductCustomerName.clearButtonMode = UITextField.ViewMode.whileEditing
        tfProductCustomerName.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        viewInfoProductCustomerName.addSubview(tfProductCustomerName)
        tfProductCustomerName.translatesAutoresizingMaskIntoConstraints = false
        tfProductCustomerName.leftAnchor.constraint(equalTo: viewInfoProductCustomerName.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        tfProductCustomerName.topAnchor.constraint(equalTo: lbTextName.bottomAnchor, constant: Common.Size(s: 5)).isActive = true
        tfProductCustomerName.widthAnchor.constraint(equalTo: viewInfoProductCustomerName.widthAnchor, constant: Common.Size(s: -20)).isActive = true
        tfProductCustomerName.heightAnchor.constraint(equalToConstant: Common.Size(s: 30)).isActive = true
        tfProductCustomerName.isUserInteractionEnabled = false
        
        
        let lbTextPhone = UILabel()
        lbTextPhone.translatesAutoresizingMaskIntoConstraints = false
        viewInfoProductCustomerName.addSubview(lbTextPhone)
        lbTextPhone.leftAnchor.constraint(equalTo: lbTextSearchPhone.leftAnchor).isActive = true
        lbTextPhone.topAnchor.constraint(equalTo: tfProductCustomerName.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextPhone.rightAnchor.constraint(equalTo: lbTextSearchPhone.rightAnchor).isActive = true
        
        lbTextPhone.textAlignment = .left
        lbTextPhone.textColor = UIColor.black
        lbTextPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhone.text = "Số điện thoại"
        
        tfProductCustomerPhone.placeholder = "Nhập số điện thoại"
        tfProductCustomerPhone.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        tfProductCustomerPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfProductCustomerPhone.autocorrectionType = UITextAutocorrectionType.no
        tfProductCustomerPhone.keyboardType = UIKeyboardType.default
        tfProductCustomerPhone.returnKeyType = UIReturnKeyType.done
        tfProductCustomerPhone.clearButtonMode = UITextField.ViewMode.whileEditing
        tfProductCustomerPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        viewInfoProductCustomerName.addSubview(tfProductCustomerPhone)
        tfProductCustomerPhone.translatesAutoresizingMaskIntoConstraints = false
        tfProductCustomerPhone.leftAnchor.constraint(equalTo: tfProductCustomerName.leftAnchor).isActive = true
        tfProductCustomerPhone.topAnchor.constraint(equalTo: lbTextPhone.bottomAnchor, constant: Common.Size(s: 5)).isActive = true
        tfProductCustomerPhone.rightAnchor.constraint(equalTo: tfProductCustomerName.rightAnchor).isActive = true
        tfProductCustomerPhone.heightAnchor.constraint(equalToConstant: Common.Size(s: 30)).isActive = true
        tfProductCustomerPhone.bottomAnchor.constraint(equalTo: viewInfoProductCustomerName.bottomAnchor, constant: Common.Size(s: -10)).isActive = true
        tfProductCustomerPhone.isUserInteractionEnabled = false
        
        let lbTextHeaderInfoCustomerName = UILabel()
        lbTextHeaderInfoCustomerName.text = "THÔNG TIN NGƯỜI THANH TOÁN"
        lbTextHeaderInfoCustomerName.textColor = UIColor(netHex:0x00955E)
        lbTextHeaderInfoCustomerName.backgroundColor = .clear
        lbTextHeaderInfoCustomerName.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        scrollView.addSubview(lbTextHeaderInfoCustomerName)
        lbTextHeaderInfoCustomerName.translatesAutoresizingMaskIntoConstraints = false
        lbTextHeaderInfoCustomerName.leadingAnchor.constraint(equalTo:scrollView.leadingAnchor,constant: Common.Size(s: 10)).isActive = true
        lbTextHeaderInfoCustomerName.topAnchor.constraint(equalTo: viewInfoProductCustomerName.bottomAnchor,constant: Common.Size(s: 5)).isActive = true
        lbTextHeaderInfoCustomerName.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: Common.Size(s: -10)).isActive = true
        lbTextHeaderInfoCustomerName.heightAnchor.constraint(equalToConstant: Common.Size(s: 20)).isActive = true
        lbTextHeaderInfoCustomerName.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: Common.Size(s: -20)).isActive = true
        
        let viewInfoCustomerName = UIView()
        viewInfoCustomerName.backgroundColor = .white
        scrollView.addSubview(viewInfoCustomerName)
        
        viewInfoCustomerName.translatesAutoresizingMaskIntoConstraints = false
        viewInfoCustomerName.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        viewInfoCustomerName.topAnchor.constraint(equalTo: lbTextHeaderInfoCustomerName.bottomAnchor,constant: Common.Size(s: 5)).isActive = true
        viewInfoCustomerName.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        //        viewInfoCustomerName.heightAnchor.constraint(equalToConstant: Common.Size(s: 100)).isActive = true
        viewInfoCustomerName.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let lbTextCustomerName = UILabel()
        lbTextCustomerName.translatesAutoresizingMaskIntoConstraints = false
        viewInfoCustomerName.addSubview(lbTextCustomerName)
        lbTextCustomerName.leftAnchor.constraint(equalTo: viewInfoCustomerName.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextCustomerName.topAnchor.constraint(equalTo: viewInfoCustomerName.topAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextCustomerName.rightAnchor.constraint(equalTo: viewInfoCustomerName.rightAnchor, constant: Common.Size(s: -10)).isActive = true
        
        lbTextCustomerName.textAlignment = .left
        lbTextCustomerName.textColor = UIColor.black
        lbTextCustomerName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCustomerName.text = "Tên khách hàng"
        
        tfCustomerName.placeholder = "Tên khách hàng"
        tfCustomerName.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        tfCustomerName.borderStyle = UITextField.BorderStyle.roundedRect
        tfCustomerName.autocorrectionType = UITextAutocorrectionType.no
        tfCustomerName.keyboardType = UIKeyboardType.default
        tfCustomerName.returnKeyType = UIReturnKeyType.done
        tfCustomerName.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCustomerName.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        viewInfoCustomerName.addSubview(tfCustomerName)
        tfCustomerName.translatesAutoresizingMaskIntoConstraints = false
        tfCustomerName.leftAnchor.constraint(equalTo: viewInfoCustomerName.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        tfCustomerName.topAnchor.constraint(equalTo: lbTextCustomerName.bottomAnchor, constant: Common.Size(s: 5)).isActive = true
        tfCustomerName.rightAnchor.constraint(equalTo: viewInfoCustomerName.rightAnchor, constant: Common.Size(s: -10)).isActive = true
        tfCustomerName.heightAnchor.constraint(equalToConstant: Common.Size(s: 30)).isActive = true
        
        let lbTextCustomerPhone = UILabel()
        lbTextCustomerPhone.translatesAutoresizingMaskIntoConstraints = false
        viewInfoCustomerName.addSubview(lbTextCustomerPhone)
        lbTextCustomerPhone.leftAnchor.constraint(equalTo: tfCustomerName.leftAnchor).isActive = true
        lbTextCustomerPhone.topAnchor.constraint(equalTo: tfCustomerName.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextCustomerPhone.rightAnchor.constraint(equalTo: tfCustomerName.rightAnchor).isActive = true
        
        lbTextCustomerPhone.textAlignment = .left
        lbTextCustomerPhone.textColor = UIColor.black
        lbTextCustomerPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCustomerPhone.text = "Số điện thoại"
        
        tfCustomerPhone.placeholder = "Nhập số điện thoại"
        tfCustomerPhone.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        tfCustomerPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfCustomerPhone.autocorrectionType = UITextAutocorrectionType.no
        tfCustomerPhone.keyboardType = UIKeyboardType.phonePad
        tfCustomerPhone.returnKeyType = UIReturnKeyType.done
        tfCustomerPhone.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCustomerPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        viewInfoCustomerName.addSubview(tfCustomerPhone)
        tfCustomerPhone.translatesAutoresizingMaskIntoConstraints = false
        tfCustomerPhone.leftAnchor.constraint(equalTo: lbTextCustomerPhone.leftAnchor).isActive = true
        tfCustomerPhone.topAnchor.constraint(equalTo: lbTextCustomerPhone.bottomAnchor, constant: Common.Size(s: 5)).isActive = true
        tfCustomerPhone.rightAnchor.constraint(equalTo: lbTextCustomerPhone.rightAnchor).isActive = true
        tfCustomerPhone.heightAnchor.constraint(equalToConstant: Common.Size(s: 30)).isActive = true
        tfCustomerPhone.bottomAnchor.constraint(equalTo: viewInfoCustomerName.bottomAnchor, constant: Common.Size(s: -10)).isActive = true
        tfCustomerPhone.delegate = self
        
        let lbTextHeaderInfoMoney = UILabel()
        lbTextHeaderInfoMoney.text = "THÔNG TIN NẠP TIỀN"
        lbTextHeaderInfoMoney.textColor = UIColor(netHex:0x00955E)
        lbTextHeaderInfoMoney.backgroundColor = .clear
        lbTextHeaderInfoMoney.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        scrollView.addSubview(lbTextHeaderInfoMoney)
        lbTextHeaderInfoMoney.translatesAutoresizingMaskIntoConstraints = false
        lbTextHeaderInfoMoney.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: Common.Size(s: 10)).isActive = true
        lbTextHeaderInfoMoney.topAnchor.constraint(equalTo: viewInfoCustomerName.bottomAnchor,constant: Common.Size(s: 5)).isActive = true
        lbTextHeaderInfoMoney.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: Common.Size(s: -10)).isActive = true
        lbTextHeaderInfoMoney.heightAnchor.constraint(equalToConstant: Common.Size(s: 20)).isActive = true
        lbTextHeaderInfoMoney.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: Common.Size(s: -20)).isActive = true
        
        
        let viewInfoMoney = UIView()
        viewInfoMoney.backgroundColor = .white
        scrollView.addSubview(viewInfoMoney)
        
        viewInfoMoney.translatesAutoresizingMaskIntoConstraints = false
        viewInfoMoney.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        viewInfoMoney.topAnchor.constraint(equalTo: lbTextHeaderInfoMoney.bottomAnchor,constant: Common.Size(s: 5)).isActive = true
        viewInfoMoney.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        //        viewInfoMoney.heightAnchor.constraint(equalToConstant: Common.Size(s: 100)).isActive = true
        viewInfoMoney.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let lbTextMoney = UILabel()
        lbTextMoney.translatesAutoresizingMaskIntoConstraints = false
        viewInfoMoney.addSubview(lbTextMoney)
        lbTextMoney.leftAnchor.constraint(equalTo: viewInfoMoney.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextMoney.topAnchor.constraint(equalTo: viewInfoMoney.topAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextMoney.rightAnchor.constraint(equalTo: viewInfoMoney.rightAnchor, constant: Common.Size(s: -10)).isActive = true
        
        lbTextMoney.textAlignment = .left
        lbTextMoney.textColor = UIColor.black
        lbTextMoney.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextMoney.text = "Tiền"
        
        tfMoney.placeholder = "Nhập số tiền"
        tfMoney.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        tfMoney.borderStyle = UITextField.BorderStyle.roundedRect
        tfMoney.autocorrectionType = UITextAutocorrectionType.no
        tfMoney.keyboardType = UIKeyboardType.numberPad
        tfMoney.returnKeyType = UIReturnKeyType.done
        tfMoney.clearButtonMode = UITextField.ViewMode.whileEditing
        tfMoney.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        viewInfoMoney.addSubview(tfMoney)
        tfMoney.translatesAutoresizingMaskIntoConstraints = false
        tfMoney.leftAnchor.constraint(equalTo: lbTextMoney.leftAnchor).isActive = true
        tfMoney.topAnchor.constraint(equalTo: lbTextMoney.bottomAnchor, constant: Common.Size(s: 5)).isActive = true
        tfMoney.rightAnchor.constraint(equalTo: lbTextMoney.rightAnchor).isActive = true
        tfMoney.heightAnchor.constraint(equalToConstant: Common.Size(s: 30)).isActive = true
        tfMoney.addTarget(self, action: #selector(CreateZaloPayViewController.textFieldDidChange(_:)),
                          for: .editingChanged)
        tfMoney.delegate = self
        
        let lbTextContent = UILabel()
        lbTextContent.translatesAutoresizingMaskIntoConstraints = false
        viewInfoMoney.addSubview(lbTextContent)
        lbTextContent.leftAnchor.constraint(equalTo: tfMoney.leftAnchor).isActive = true
        lbTextContent.topAnchor.constraint(equalTo: tfMoney.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextContent.rightAnchor.constraint(equalTo: tfMoney.rightAnchor).isActive = true
        
        lbTextContent.textAlignment = .left
        lbTextContent.textColor = UIColor.black
        lbTextContent.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextContent.text = "Nội dung"
        
        tfContent.placeholder = "Nhập nội dung"
        tfContent.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        tfContent.borderStyle = UITextField.BorderStyle.roundedRect
        tfContent.autocorrectionType = UITextAutocorrectionType.no
        tfContent.keyboardType = UIKeyboardType.default
        tfContent.returnKeyType = UIReturnKeyType.done
        tfContent.clearButtonMode = UITextField.ViewMode.whileEditing
        tfContent.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        viewInfoMoney.addSubview(tfContent)
        tfContent.translatesAutoresizingMaskIntoConstraints = false
        tfContent.leftAnchor.constraint(equalTo: lbTextContent.leftAnchor).isActive = true
        tfContent.topAnchor.constraint(equalTo: lbTextContent.bottomAnchor, constant: Common.Size(s: 5)).isActive = true
        tfContent.rightAnchor.constraint(equalTo: lbTextContent.rightAnchor).isActive = true
        tfContent.heightAnchor.constraint(equalToConstant: Common.Size(s: 30)).isActive = true
        tfContent.bottomAnchor.constraint(equalTo: viewInfoMoney.bottomAnchor, constant: Common.Size(s: -10)).isActive = true
        
        let lbTextHeaderPayment = UILabel()
        lbTextHeaderPayment.text = "THANH TOÁN"
        lbTextHeaderPayment.textColor = UIColor(netHex:0x00955E)
        lbTextHeaderPayment.backgroundColor = .clear
        lbTextHeaderPayment.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        scrollView.addSubview(lbTextHeaderPayment)
        lbTextHeaderPayment.translatesAutoresizingMaskIntoConstraints = false
        lbTextHeaderPayment.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: Common.Size(s: 10)).isActive = true
        lbTextHeaderPayment.topAnchor.constraint(equalTo: viewInfoMoney.bottomAnchor,constant: Common.Size(s: 5)).isActive = true
        lbTextHeaderPayment.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: Common.Size(s: -10)).isActive = true
        lbTextHeaderPayment.heightAnchor.constraint(equalToConstant: Common.Size(s: 20)).isActive = true
        lbTextHeaderPayment.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: Common.Size(s: -20)).isActive = true
        
        let viewInfoPayment = UIView()
        viewInfoPayment.backgroundColor = .white
        scrollView.addSubview(viewInfoPayment)
        
        viewInfoPayment.translatesAutoresizingMaskIntoConstraints = false
        viewInfoPayment.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        viewInfoPayment.topAnchor.constraint(equalTo: lbTextHeaderPayment.bottomAnchor,constant: Common.Size(s: 5)).isActive = true
        viewInfoPayment.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        //        viewInfoPayment.heightAnchor.constraint(equalToConstant: Common.Size(s: 100)).isActive = true
        viewInfoPayment.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let lbTextPayment = UILabel()
        lbTextPayment.translatesAutoresizingMaskIntoConstraints = false
        viewInfoPayment.addSubview(lbTextPayment)
        lbTextPayment.leftAnchor.constraint(equalTo: viewInfoPayment.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextPayment.topAnchor.constraint(equalTo: viewInfoPayment.topAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextPayment.widthAnchor.constraint(equalTo: viewInfoPayment.widthAnchor,multiplier: 1/2).isActive = true
        
        lbTextPayment.textAlignment = .left
        lbTextPayment.textColor = UIColor.black
        lbTextPayment.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPayment.text = "Tiền mặt"
        
        
        lbTotalPayment.translatesAutoresizingMaskIntoConstraints = false
        viewInfoPayment.addSubview(lbTotalPayment)
        lbTotalPayment.leftAnchor.constraint(equalTo: lbTextPayment.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbTotalPayment.topAnchor.constraint(equalTo: lbTextPayment.topAnchor).isActive = true
        lbTotalPayment.rightAnchor.constraint(equalTo: viewInfoPayment.rightAnchor, constant: Common.Size(s: -10)).isActive = true
        lbTotalPayment.textAlignment = .right
        lbTotalPayment.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbTotalPayment.textColor = .red
        lbTotalPayment.text = "0 VNĐ"
        
        let btnCreate = UIButton()
        btnCreate.setTitle("THANH TOÁN", for: .normal)
        btnCreate.backgroundColor = UIColor(netHex:0x00955E)
        btnCreate.setTitleColor(.white, for: .normal)
        btnCreate.layer.cornerRadius = 10
        viewInfoPayment.addSubview(btnCreate)
        btnCreate.translatesAutoresizingMaskIntoConstraints = false
        btnCreate.topAnchor.constraint(equalTo: lbTextPayment.bottomAnchor, constant: Common.Size(s: 20)).isActive = true
        btnCreate.leftAnchor.constraint(equalTo: lbTextPayment.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        btnCreate.rightAnchor.constraint(equalTo: lbTotalPayment.rightAnchor, constant: Common.Size(s: -10)).isActive = true
        btnCreate.heightAnchor.constraint(equalToConstant: Common.Size(s: 30)).isActive = true
        btnCreate.bottomAnchor.constraint(equalTo: viewInfoPayment.bottomAnchor, constant: Common.Size(s: -10)).isActive = true
        btnCreate.addTarget(self, action: #selector(createAction), for: .touchUpInside)
        viewInfoPayment.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: Common.Size(s: -10)).isActive = true
        
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if(textField == tfSearchPhone){
            if  let phone = textField.text {
                if(phone.hasPrefix("0")){
                    self.tfSearchPhone.layer.borderColor = UIColor.clear.cgColor
                    if(phone.count == 10){
                        searchPhone(phone:phone)
                    }
                }else{
                    self.tfSearchPhone.layer.borderColor = UIColor.red.cgColor
                    self.tfSearchPhone.layer.borderWidth = 1
                    if(phone.count == 0){
                        cleanData()
                    }
                }
            }
        }else if(textField == tfMoney){
            var money = tfMoney.text ?? ""
            money = money.trim()
            var numMoney = 0.0
            if(money == "" || money == "0"){
                self.tfMoney.layer.borderColor = UIColor.red.cgColor
                self.tfMoney.layer.borderWidth = 1
                self.lbTotalPayment.text =  "0 VNĐ"
                return
            }else{
                let replaced = money.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: "").replacingOccurrences(of: " ", with: "")
                numMoney =  Double(replaced) ?? 0
                if(numMoney < 10000){
                    self.tfMoney.layer.borderColor = UIColor.red.cgColor
                    self.tfMoney.layer.borderWidth = 1
                    self.lbTotalPayment.text =  "0 VNĐ"
                    return
                }
                self.tfMoney.layer.borderColor = UIColor.clear.cgColor
            }
            self.tfMoney.text = "\(Common.convertCurrencyDoubleV2(value: numMoney))"
            self.lbTotalPayment.text =  "\(Common.convertCurrencyDoubleV2(value: numMoney)) VNĐ"
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == tfSearchPhone || textField == tfMoney || textField == tfCustomerPhone){
            let MAX_LENGTH = 10
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }
        return true
    }
    func cleanData(){
        self.tfProductCustomerName.text = ""
        self.tfProductCustomerPhone.text = ""
        self.tfCustomerName.text = ""
        self.tfCustomerPhone.text = ""
        self.lbTotalPayment.text = "0 VNĐ"
        self.tfMoney.text = "0"
        self.tfMoney.isUserInteractionEnabled = true
        self.m_u_id = ""
        self.tfSearchPhone.text = ""
        self.tfSearchPhone.isEnabled = true
        self.icBarcode.isUserInteractionEnabled = true
        self.tfContent.isEnabled = true
        self.tfContent.text = ""
        self.tfProductCustomerName.isEnabled = true
        self.tfProductCustomerPhone.isEnabled = true
    }
    @objc func doneButtonClicked(_ sender: Any) {
        self.view.endEditing(true)
        if  let phone = tfSearchPhone.text {
            if(phone.hasPrefix("0") && phone.count == 10){
                self.tfSearchPhone.layer.borderColor = UIColor.clear.cgColor 
                searchPhone(phone:phone)
            }else{
                self.tfSearchPhone.layer.borderColor = UIColor.red.cgColor
                self.tfSearchPhone.layer.borderWidth = 1
                if(phone.count == 0){
                    cleanData()
                }
                Toast.init(text: "Số điện thoại không đúng định dạng.").show()
            }
        }
    }
    func searchPhone(phone: String){
        self.view.endEditing(true)
        
        let index = phone.index(phone.startIndex, offsetBy: 3)
        let prefixPhone = phone.prefix(upTo: index)
        let prefixPhoneString = String(prefixPhone)
        
        if !phoneValid.contains(prefixPhoneString) {
            Toast.init(text: "Số điện thoại không đúng định dạng.").show()
            self.tfSearchPhone.layer.borderColor = UIColor.red.cgColor
            self.tfSearchPhone.layer.borderWidth = 1
            if(phone.count == 0){
                cleanData()
            }
            return
        }
        let newViewController = LoadingViewController();
        newViewController.content = "Đang truy vấn..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        ZaloPayServiceImpl.userByPhone(phone: phone) { (response,error) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if let customer = response {
                    if(customer.sub_return_code == "-101"){
                        self.showPopUp( customer.sub_return_message ?? "Số điện thoại không sử dụng dịch vụ. Vui lòng kiểm tra lại.", "Thông báo", buttonTitle: "OK") {
                            self.cleanData()
                        }
                        return
                    }
                    if let data = customer.data {
                        var phone = data.phone
                        if(phone.hasPrefix("84")){
                            let index = phone.index(phone.endIndex, offsetBy: -9)
                            phone = "0\(phone.suffix(from: index))"
                        }
                        self.tfSearchPhone.text = phone
                        self.tfProductCustomerName.text = data.name
                        self.tfProductCustomerPhone.text = phone
                        self.tfCustomerName.text = data.name
                        self.tfCustomerPhone.text = phone
                        self.lbTotalPayment.text = "\(Common.convertCurrencyDoubleV2(value: data.amount ?? 0)) VNĐ"
                        self.tfMoney.text = "\(Common.convertCurrencyDoubleV2(value: data.amount ?? 0))"
                        self.tfMoney.isUserInteractionEnabled = true
                        self.m_u_id = data.m_u_id
                        self.tfSearchPhone.isEnabled = false
                        self.icBarcode.isUserInteractionEnabled = false
                        self.tfContent.isEnabled = true
                        
                        self.tfProductCustomerName.isEnabled = false
                        self.tfProductCustomerPhone.isEnabled = false
                    }else{
                        self.showPopUp(customer.sub_return_message ?? "Có lỗi xẩy ra.", "Thông báo", buttonTitle: "OK") {
                            self.cleanData()
                        }
                    }
                }else{
                    if let error = error {
                        self.showPopUp(error.error.message , "Thông báo", buttonTitle: "OK") {
                            
                        }
                    }
                    self.m_u_id = ""
                    self.cleanData()
                }
                
            }
            
            
        }
    }
    
    @objc func createAction(sender: UIButton!) {
        
        
        
        let productCustomerName = tfProductCustomerName.text ?? ""
        let productCustomerPhone = tfProductCustomerPhone.text ?? ""
        var customerName = tfCustomerName.text ?? ""
        var customerPhone = tfCustomerPhone.text ?? ""
        var money = tfMoney.text ?? ""
        var content = tfContent.text ?? ""
        if(productCustomerName == ""){
            self.tfProductCustomerName.layer.borderColor = UIColor.red.cgColor
            self.tfProductCustomerName.layer.borderWidth = 1
            return
        }else{
            self.tfProductCustomerName.layer.borderColor = UIColor.clear.cgColor
        }
        if(productCustomerPhone == ""){
            self.tfProductCustomerPhone.layer.borderColor = UIColor.red.cgColor
            self.tfProductCustomerPhone.layer.borderWidth = 1
            return
        }else{
            self.tfProductCustomerPhone.layer.borderColor = UIColor.clear.cgColor
        }
        customerName = customerName.trim()
        if(customerName == ""){
            self.tfCustomerName.layer.borderColor = UIColor.red.cgColor
            self.tfCustomerName.layer.borderWidth = 1
            return
        }else{
            self.tfCustomerName.layer.borderColor = UIColor.clear.cgColor
        }
        customerPhone = customerPhone.trim()
        if(customerPhone == "" || customerPhone.count != 10 || !customerPhone.hasPrefix("0")){
            self.tfCustomerPhone.layer.borderColor = UIColor.red.cgColor
            self.tfCustomerPhone.layer.borderWidth = 1
            return
        }else{
            self.tfCustomerPhone.layer.borderColor = UIColor.clear.cgColor
        }
        money = money.trim()
        var numMoney = 0.0
        if(money == "" || money == "0"){
            self.tfMoney.layer.borderColor = UIColor.red.cgColor
            self.tfMoney.layer.borderWidth = 1
            Toast.init(text: "Số tiền tối thiểu 10.000VNĐ").show()
            return
        }else{
            let replaced = money.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: "").replacingOccurrences(of: " ", with: "")
            numMoney =  Double(replaced) ?? 0
            if(numMoney < 10000){
                self.tfMoney.layer.borderColor = UIColor.red.cgColor
                self.tfMoney.layer.borderWidth = 1
                Toast.init(text: "Số tiền tối thiểu 10.000VNĐ").show()
                return
            }
            self.tfMoney.layer.borderColor = UIColor.clear.cgColor
        }
        content = content.trim()
        //        if(content == ""){
        //            self.tfContent.layer.borderColor = UIColor.red.cgColor
        //            self.tfContent.layer.borderWidth = 1
        //            return
        //        }else{
        //            self.tfContent.layer.borderColor = UIColor.clear.cgColor
        //        }
        let payment = RequestOrderPaymentZaloPay(paymentType: 1, paymentValue: numMoney, paymentExtraFee: 0.0, paymentPercentFee: 0.0)
        let trans = RequestOrderTransactionZaloPay(productId: productSOM!.id, providerId: providerSOM!.id, providerName: providerSOM!.name, productName: productSOM!.name, price:  numMoney, quantity: 1.0, totalAmount: numMoney, totalAmountIncludingFee:  numMoney, productCustomerCode: self.m_u_id, productCustomerName: productCustomerName, productCustomerPhoneNumber: productCustomerPhone, description: content)
        
        let requestParam = RequestCreateOrderZaloPay(customerName: customerName, customerPhoneNumber: customerPhone, creationBy: "\(Cache.user!.UserName)", warehouseCode: "\(Cache.user!.ShopCode)", referenceSystem: "MPOS", payments: [payment], orderTransactionDtos: [trans])
        
        
        let newViewController = LoadingViewController();
        newViewController.content = "Đang tạo giao dịch..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        ZaloPayServiceImpl.createOrder(param: requestParam) { response in
            if let response = response {
                if(response.id != ""){
                    self.checkStatus(id: response.id)
                }
            }else{
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    self.showPopUp("Có lỗi xẩy ra!", "Thông báo", buttonTitle: "OK") {
                        
                    }
                }
            }
            
        }
    }
    var intervalTime = 1.0
    var countCheckStatus = 0
    func checkStatus(id: String){
        let nc = NotificationCenter.default
        let when = DispatchTime.now() + 0.5
        if let product = self.productSOM {
            if(!product.configs.isEmpty){
                let integratedGroupCode = product.configs[0].integratedGroupCode
                ZaloPayServiceImpl.checkStatusOrder(orderId: id, integratedGroupCode: integratedGroupCode ?? "") { response in
                    self.countCheckStatus = self.countCheckStatus + 1
                    if let response = response {
                        if(response.orderStatus == OrderStatus.CREATE){
                            if(self.countCheckStatus == 5){
                                self.intervalTime = 5
                            }
                            if(self.countCheckStatus == 10){
                                
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    self.goDetail(id: id)
                                }
                            }else{
                                DispatchQueue.main.asyncAfter(deadline: .now() + self.intervalTime) {
                                    self.checkStatus(id: id)
                                }
                            }
                        }else if(response.orderStatus == OrderStatus.SUCCESS){
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                self.showPopUp("Thanh toán thành công", "Thông báo", buttonTitle: "OK") {
                                    self.goDetail(id: id)
                                }
                            }
                        }else if(response.orderStatus == OrderStatus.FAILED){
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                self.showPopUp("Thanh toán thất bại", "Thông báo", buttonTitle: "OK") {
                                    self.goDetail(id: id)
                                }
                            }
                        }else{
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                self.goDetail(id: id)
                            }
                        }
                    }else{
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            self.goDetail(id: id)
                        }
                    }
                }
            }
        }
    }
    func goDetail(id: String){
        let newViewController = DetailZaloPayViewController()
        newViewController.orderId = id
        newViewController.isCreated =  true
        newViewController.productSOM = self.productSOM
        newViewController.providerSOM = self.providerSOM
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func scanBarcode()
    {
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { text in
            self.scanSuccess(text: text)
        }
        self.present(viewController, animated: false, completion: nil)
    }
    func scanSuccess(text: String) {
        self.view.endEditing(true)
        let newViewController = LoadingViewController();
        newViewController.content = "Đang truy vấn..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        ZaloPayServiceImpl.userByQR(qr: text) { (result, error) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if let customer = result {
                    if(customer.sub_return_code == "-401"){
                        self.showPopUp(customer.sub_return_message ?? "Có lỗi xẩy ra!", "Thông báo", buttonTitle: "OK") {
                            self.cleanData()
                        }
                        return
                    }
                    if let data = customer.data {
                        if(data.amount ?? 0 == 0){
                            self.showPopUp("QR code chưa nhập số tiền", "Thông báo", buttonTitle: "OK") {
                                self.cleanData()
                            }
                            return
                        }
                        if(data.amount ?? 0 < 10000){
                            self.showPopUp("Số tiền tối thiểu 10.000VNĐ", "Thông báo", buttonTitle: "OK") {
                                self.cleanData()
                            }
                            return
                        }
                        var phone = data.phone
                        if(phone.hasPrefix("84")){
                            let index = phone.index(phone.endIndex, offsetBy: -9)
                            phone = "0\(phone.suffix(from: index))"
                        }
                        self.tfSearchPhone.text = phone
                        self.tfProductCustomerName.text = data.name
                        self.tfProductCustomerPhone.text = phone
                        self.tfCustomerName.text = data.name
                        self.tfCustomerPhone.text = phone
                        self.lbTotalPayment.text = "\(Common.convertCurrencyDoubleV2(value: data.amount ?? 0)) VNĐ"
                        self.tfMoney.text = "\(Common.convertCurrencyDoubleV2(value: data.amount ?? 0))"
                        self.tfMoney.isUserInteractionEnabled = false
                        self.tfSearchPhone.layer.borderColor = UIColor.clear.cgColor
                        self.m_u_id = data.m_u_id
                        self.tfContent.text = data.description ?? ""
                        
                        self.tfSearchPhone.isEnabled = false
                        self.icBarcode.isUserInteractionEnabled = false
                        self.tfMoney.isEnabled = false
                        self.tfContent.isEnabled = false
                        self.tfProductCustomerName.isEnabled = false
                        self.tfProductCustomerPhone.isEnabled = false
                    }else{
                        
                        self.showPopUp(customer.sub_return_message ?? "Có lỗi xẩy ra!", "Thông báo", buttonTitle: "OK") {
                            self.cleanData()
                        }
                    }
                }else{
                    if let error = error {
                        self.showPopUp(error.error.message , "Thông báo", buttonTitle: "OK") {
                            
                        }
                    }
                    self.m_u_id = ""
                }
                
            }
        }
    }
    
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
