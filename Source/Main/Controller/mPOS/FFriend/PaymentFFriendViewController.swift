//
//  PaymentFFriendViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/13/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import DLRadioButton
import PopupDialog
import ActionSheetPicker_3_0
import AVFoundation
class PaymentFFriendViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    var scrollView:UIScrollView!
    var tfPhoneNumber:UITextField!
    var tfUserName:UITextField!
    
    
    var listImei:[UILabel] = []
    
    var lbPayType:UILabel!
    
    var viewInstallment:UIView!
    var viewInstallmentHeight: CGFloat = 0.0
    
    var viewInfoDetail: UIView!
    
    var promotionsFF: [String:NSMutableArray] = [:]
    var groupFF: [String] = []
    
    var viewToshibaPoint:UIView!
    var viewBelowToshibaPoint:UIView!
    var lbFPoint,lbFCoin,lbRanking:UILabel!
    var ocfdFFriend: OCRDFFriend?
    
    var lbSendOTP:UILabel!
    var sendOTPSuccess:Bool = false
    
    var skuList:String = ""
    var checkTotal:Float = 0.0
    var viewVoucher:UIView!
    var viewsumDH:UIView!
    var tableViewVoucherNoPrice: UITableView = UITableView()
    var cellHeight:CGFloat = 0
    var lbAddVoucherMore:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "Đơn hàng"
        checkTotal = 0.0
        ocfdFFriend = Cache.ocfdFFriend!
        skuList = ""
        sendOTPSuccess = false
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(PaymentFFriendViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        listImei = []
        
        //        let btDeleteIcon = UIButton.init(type: .custom)
        //        btDeleteIcon.setImage(#imageLiteral(resourceName: "Delete"), for: UIControl.State.normal)
        //        btDeleteIcon.imageView?.contentMode = .scaleAspectFit
        //        btDeleteIcon.addTarget(self, action: #selector(PaymentViewController.actionDelete), for: UIControl.Event.touchUpInside)
        //        btDeleteIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        //        let barDelete = UIBarButtonItem(customView: btDeleteIcon)
        
        //        let btRightIcon = UIButton.init(type: .custom)
        //        btRightIcon.setImage(#imageLiteral(resourceName: "Home"), for: UIControl.State.normal)
        //        btRightIcon.imageView?.contentMode = .scaleAspectFit
        //        btRightIcon.addTarget(self, action: #selector(PaymentViewController.actionHome), for: UIControl.Event.touchUpInside)
        //        btRightIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        //        let barRight = UIBarButtonItem(customView: btRightIcon)
        //
        //        self.navigationItem.rightBarButtonItems = [barRight]
        
        
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let lbUserInfo = UILabel(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:20)))
        lbUserInfo.textAlignment = .left
        lbUserInfo.textColor = UIColor(netHex:0x04AB6E)
        lbUserInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbUserInfo.text = "THÔNG TIN KHÁCH HÀNG"
        scrollView.addSubview(lbUserInfo)
        
        //input phone number
        tfPhoneNumber = UITextField(frame: CGRect(x: Common.Size(s:20), y: lbUserInfo.frame.origin.y + lbUserInfo.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfPhoneNumber.placeholder = "Số điện thoại"
        tfPhoneNumber.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhoneNumber.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhoneNumber.autocorrectionType = UITextAutocorrectionType.no
        tfPhoneNumber.keyboardType = UIKeyboardType.numberPad
        tfPhoneNumber.returnKeyType = UIReturnKeyType.done
        tfPhoneNumber.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPhoneNumber.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhoneNumber.delegate = self
        tfPhoneNumber.text = "\(ocfdFFriend!.SDT)"
        scrollView.addSubview(tfPhoneNumber)
        tfPhoneNumber.isEnabled = false
        
        tfPhoneNumber.leftViewMode = UITextField.ViewMode.always
        let imagePhone = UIImageView(frame: CGRect(x: tfPhoneNumber.frame.size.height/4, y: tfPhoneNumber.frame.size.height/4, width: tfPhoneNumber.frame.size.height/2, height: tfPhoneNumber.frame.size.height/2))
        imagePhone.image = UIImage(named: "Phone-50")
        imagePhone.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewPhone = UIView()
        leftViewPhone.addSubview(imagePhone)
        leftViewPhone.frame = CGRect(x: 0, y: 0, width: tfPhoneNumber.frame.size.height, height: tfPhoneNumber.frame.size.height)
        tfPhoneNumber.leftView = leftViewPhone
        
        //input name info
        tfUserName = UITextField(frame: CGRect(x: tfPhoneNumber.frame.origin.x, y: tfPhoneNumber.frame.origin.y + tfPhoneNumber.frame.size.height + Common.Size(s:10), width: tfPhoneNumber.frame.size.width , height: tfPhoneNumber.frame.size.height ));
        tfUserName.placeholder = "Tên khách hàng"
        tfUserName.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfUserName.borderStyle = UITextField.BorderStyle.roundedRect
        tfUserName.autocorrectionType = UITextAutocorrectionType.no
        tfUserName.keyboardType = UIKeyboardType.default
        tfUserName.returnKeyType = UIReturnKeyType.done
        tfUserName.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfUserName.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfUserName.delegate = self
        tfUserName.text = "\(ocfdFFriend!.CardName)"
        scrollView.addSubview(tfUserName)
        tfUserName.isEnabled = false
        
        tfUserName.leftViewMode = UITextField.ViewMode.always
        let imageUser = UIImageView(frame: CGRect(x: tfUserName.frame.size.height/4, y: tfUserName.frame.size.height/4, width: tfPhoneNumber.frame.size.height/2, height: tfUserName.frame.size.height/2))
        imageUser.image = UIImage(named: "User-50")
        imageUser.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewUser = UIView()
        leftViewUser.addSubview(imageUser)
        leftViewUser.frame = CGRect(x: 0, y: 0, width: tfUserName.frame.size.height, height: tfUserName.frame.size.height)
        tfUserName.leftView = leftViewUser
        

        
        viewInfoDetail = UIView(frame: CGRect(x: 0, y: tfUserName.frame.size.height + tfUserName.frame.origin.y + Common.Size(s: 10), width: self.view.frame.size.width, height: 0))
        scrollView.addSubview(viewInfoDetail)
        let soViewPhone = UIView()
        viewInfoDetail.addSubview(soViewPhone)
        soViewPhone.frame = CGRect(x: tfUserName.frame.origin.x, y:  Common.Size(s:10), width: tfUserName.frame.size.width, height: 100)
        
        let lbSODetail = UILabel(frame: CGRect(x: 0, y: 0, width: soViewPhone.frame.size.width, height: Common.Size(s:20)))
        lbSODetail.textAlignment = .left
         lbSODetail.textColor = UIColor(netHex:0x04AB6E)
        lbSODetail.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbSODetail.text = "THÔNG TIN ĐƠN HÀNG"
        soViewPhone.addSubview(lbSODetail)
        
        let line1 = UIView(frame: CGRect(x: soViewPhone.frame.size.width * 1.3/10, y:lbSODetail.frame.origin.y + lbSODetail.frame.size.height + Common.Size(s:10), width: 1, height: Common.Size(s:25)))
        line1.backgroundColor = UIColor(netHex:0x47B054)
        soViewPhone.addSubview(line1)
        let line2 = UIView(frame: CGRect(x: 0, y:line1.frame.origin.y + line1.frame.size.height, width: soViewPhone.frame.size.width, height: 1))
        line2.backgroundColor = UIColor(netHex:0x47B054)
        soViewPhone.addSubview(line2)
        
        let lbStt = UILabel(frame: CGRect(x: 0, y: line1.frame.origin.y, width: line1.frame.origin.x, height: line1.frame.size.height))
        lbStt.textAlignment = .center
        lbStt.textColor = UIColor(netHex:0x47B054)
        lbStt.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbStt.text = "STT"
        soViewPhone.addSubview(lbStt)
        
        let lbInfo = UILabel(frame: CGRect(x: line1.frame.origin.x, y: line1.frame.origin.y, width: lbSODetail.frame.size.width - line1.frame.origin.x, height: line1.frame.size.height))
        lbInfo.textAlignment = .center
        lbInfo.textColor = UIColor(netHex:0x47B054)
        lbInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbInfo.text = "Sản phẩm"
        soViewPhone.addSubview(lbInfo)
        
        var indexY = line2.frame.origin.y
        var indexHeight: CGFloat = line2.frame.origin.y + line2.frame.size.height
        var num = 0
        var totalPay:Float = 0.0
        for item in Cache.cartsFF{
            if(skuList == ""){
                skuList = "\(item.product.sku)"
            }else{
                skuList = skuList + ",\(item.product.sku)"
            }
            
            num = num + 1
            totalPay = totalPay + (item.product.price * Float(item.quantity))
            let soViewLine = UIView()
            soViewPhone.addSubview(soViewLine)
            soViewLine.frame = CGRect(x: 0, y: indexY, width: soViewPhone.frame.size.width, height: 50)
            let line3 = UIView(frame: CGRect(x: line1.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
            line3.backgroundColor = UIColor(netHex:0x47B054)
            soViewLine.addSubview(line3)
            
            let nameProduct = "\(item.product.name)"
            let sizeNameProduct = nameProduct.height(withConstrainedWidth: soViewPhone.frame.size.width - line3.frame.origin.x, font: UIFont.systemFont(ofSize: Common.Size(s:14)))
            let lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: 3, width: soViewPhone.frame.size.width - line3.frame.origin.x, height: sizeNameProduct))
            lbNameProduct.textAlignment = .left
            lbNameProduct.textColor = UIColor.black
            lbNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbNameProduct.text = nameProduct
            lbNameProduct.numberOfLines = 3
            soViewLine.addSubview(lbNameProduct)
            
            let line4 = UIView(frame: CGRect(x: line3.frame.origin.x, y:0, width: soViewPhone.frame.size.width - line3.frame.origin.x - 1, height: 1))
            line4.backgroundColor = UIColor(netHex:0x47B054)
            soViewLine.addSubview(line4)
            
            let lbQuantityProduct = UILabel(frame: CGRect(x: lbNameProduct.frame.origin.x , y: lbNameProduct.frame.origin.y + lbNameProduct.frame.size.height + Common.Size(s:5), width: lbNameProduct.frame.size.width, height: Common.Size(s:14)))
            lbQuantityProduct.textAlignment = .left
            lbQuantityProduct.textColor = UIColor.black
            lbQuantityProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            if (item.product.qlSerial == "Y"){
                lbQuantityProduct.text = "IMEI: \((item.imei))"
            }else{
                lbQuantityProduct.text = "Số lượng: \((item.quantity))"
            }
            listImei.append(lbQuantityProduct)
            
            lbQuantityProduct.numberOfLines = 1
            soViewLine.addSubview(lbQuantityProduct)
            
            let lbPriceProduct = UILabel(frame: CGRect(x: lbQuantityProduct.frame.origin.x , y: lbQuantityProduct.frame.origin.y + lbQuantityProduct.frame.size.height + Common.Size(s:5), width: lbQuantityProduct.frame.size.width, height: Common.Size(s:14)))
            lbPriceProduct.textAlignment = .left
            lbPriceProduct.textColor = UIColor(netHex:0xEF4A40)
            lbPriceProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbPriceProduct.text = "Giá: \(Common.convertCurrencyFloat(value: (item.product.price)))"
            lbPriceProduct.numberOfLines = 1
            soViewLine.addSubview(lbPriceProduct)
            
            
            let lbSttValue = UILabel(frame: CGRect(x: 0, y: 0, width: lbStt.frame.size.width, height: lbStt.frame.size.height))
            lbSttValue.textAlignment = .center
            lbSttValue.textColor = UIColor.black
            lbSttValue.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbSttValue.text = "\(num)"
            soViewLine.addSubview(lbSttValue)
            
            soViewLine.frame = CGRect(x: soViewLine.frame.origin.x, y: soViewLine.frame.origin.y, width: soViewLine.frame.size.width, height: lbPriceProduct.frame.origin.y + lbPriceProduct.frame.size.height + Common.Size(s:5))
            line3.frame.size.height = soViewLine.frame.size.height
            
            indexHeight = indexHeight + soViewLine.frame.size.height
            indexY = indexY + soViewLine.frame.size.height + soViewLine.frame.origin.x
            
            
            soViewLine.tag = num - 1
            let gestureSwift2AndHigher = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
            soViewLine.addGestureRecognizer(gestureSwift2AndHigher)
        }
        
//        if(skuList.count >= 1){
//            skuList =  skuList.dropLast
//        }
        soViewPhone.frame.size.height = indexHeight
        
        
        let soViewPromos = UIView()
        soViewPromos.frame = CGRect(x: soViewPhone.frame.origin.x, y: soViewPhone.frame.origin.y + soViewPhone.frame.size.height + Common.Size(s:20), width: soViewPhone.frame.size.width, height: 0)
        viewInfoDetail.addSubview(soViewPromos)
        
        var promos:[ProductPromotions] = []
        var discountPay:Float = 0.0
        Cache.itemsPromotionTempFF.removeAll()
        
        for item in Cache.itemsPromotionFF{
            
            let it = item
            if (it.TienGiam <= 0){
                if (promos.count == 0){
                    promos.append(it)
                    Cache.itemsPromotionTempFF.append(item)
                }else{
                    for pro in promos {
                        if (pro.SanPham_Tang == it.SanPham_Tang){
                            pro.SL_Tang =  pro.SL_Tang + item.SL_Tang
                        }else{
                            promos.append(it)
                            Cache.itemsPromotionTempFF.append(item)
                        }
                    }
                }
            }else{
                Cache.itemsPromotionTempFF.append(item)
                discountPay = discountPay + it.TienGiam
            }
        }
        
        
        if (promos.count>0){
            let lbSOPromos = UILabel(frame: CGRect(x: 0, y: 0, width: soViewPhone.frame.size.width, height: Common.Size(s:20)))
            lbSOPromos.textAlignment = .left
            lbSOPromos.textColor = UIColor(netHex:0x47B054)
            lbSOPromos.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
            lbSOPromos.text = "THÔNG TIN KHUYẾN MÃI"
            soViewPromos.addSubview(lbSOPromos)
            
            let line1Promos = UIView(frame: CGRect(x: soViewPromos.frame.size.width * 1.3/10, y:lbSOPromos.frame.origin.y + lbSOPromos.frame.size.height + Common.Size(s:10), width: 1, height: Common.Size(s:25)))
            line1Promos.backgroundColor = UIColor(netHex:0x47B054)
            soViewPromos.addSubview(line1Promos)
            let line2Promos = UIView(frame: CGRect(x: 0, y:line1Promos.frame.origin.y + line1Promos.frame.size.height, width: soViewPromos.frame.size.width, height: 1))
            line2Promos.backgroundColor = UIColor(netHex:0x47B054)
            soViewPromos.addSubview(line2Promos)
            
            let lbSttPromos = UILabel(frame: CGRect(x: 0, y: line1Promos.frame.origin.y, width: line1Promos.frame.origin.x, height: line1Promos.frame.size.height))
            lbSttPromos.textAlignment = .center
            lbSttPromos.textColor = UIColor(netHex:0x47B054)
            lbSttPromos.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbSttPromos.text = "STT"
            soViewPromos.addSubview(lbSttPromos)
            
            let lbInfoPromos = UILabel(frame: CGRect(x: line1Promos.frame.origin.x, y: line1Promos.frame.origin.y, width: lbSOPromos.frame.size.width - line1Promos.frame.origin.x, height: line1Promos.frame.size.height))
            lbInfoPromos.textAlignment = .center
            lbInfoPromos.textColor = UIColor(netHex:0x47B054)
            lbInfoPromos.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbInfoPromos.text = "Khuyến mãi"
            soViewPromos.addSubview(lbInfoPromos)
            
            var numPromos = 0
            var indexYPromos = line2Promos.frame.origin.y
            var indexHeightPromos: CGFloat = line2Promos.frame.origin.y + line2Promos.frame.size.height
            for item in promos{
                numPromos = numPromos + 1
                let soViewLine = UIView()
                soViewPromos.addSubview(soViewLine)
                soViewLine.frame = CGRect(x: 0, y: indexYPromos, width: soViewPhone.frame.size.width, height: 50)
                let line3 = UIView(frame: CGRect(x: line1Promos.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
                line3.backgroundColor = UIColor(netHex:0x47B054)
                soViewLine.addSubview(line3)
                
                let nameProduct = "\((item.TenSanPham_Tang))"
                let sizeNameProduct = nameProduct.height(withConstrainedWidth: soViewPhone.frame.size.width - line3.frame.origin.x, font: UIFont.systemFont(ofSize: Common.Size(s:14)))
                let lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: 3, width: soViewPhone.frame.size.width - line3.frame.origin.x, height: sizeNameProduct))
                lbNameProduct.textAlignment = .left
                lbNameProduct.textColor = UIColor.black
                lbNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbNameProduct.text = nameProduct
                lbNameProduct.numberOfLines = 3
                soViewLine.addSubview(lbNameProduct)
                
                let line4 = UIView(frame: CGRect(x: line3.frame.origin.x, y:0, width: soViewPhone.frame.size.width - line3.frame.origin.x - 1, height: 1))
                line4.backgroundColor = UIColor(netHex:0x47B054)
                soViewLine.addSubview(line4)
                
                let lbQuantityProduct = UILabel(frame: CGRect(x: lbNameProduct.frame.origin.x , y: lbNameProduct.frame.origin.y + lbNameProduct.frame.size.height + Common.Size(s:5), width: lbNameProduct.frame.size.width, height: Common.Size(s:14)))
                lbQuantityProduct.textAlignment = .left
                lbQuantityProduct.textColor = UIColor.black
                lbQuantityProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbQuantityProduct.text = "Số lượng: \((item.SL_Tang))"
                lbQuantityProduct.numberOfLines = 1
                soViewLine.addSubview(lbQuantityProduct)
                
                let lbSttValue = UILabel(frame: CGRect(x: 0, y: 0, width: lbStt.frame.size.width, height: lbStt.frame.size.height))
                lbSttValue.textAlignment = .center
                lbSttValue.textColor = UIColor.black
                lbSttValue.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbSttValue.text = "\(numPromos)"
                soViewLine.addSubview(lbSttValue)
                
                soViewLine.frame = CGRect(x: soViewLine.frame.origin.x, y: soViewLine.frame.origin.y, width: soViewLine.frame.size.width, height: lbQuantityProduct.frame.origin.y + lbQuantityProduct.frame.size.height + Common.Size(s:5))
                line3.frame.size.height = soViewLine.frame.size.height
                
                indexHeightPromos = indexHeightPromos + soViewLine.frame.size.height
                indexYPromos = indexYPromos + soViewLine.frame.size.height + soViewLine.frame.origin.x
            }
            soViewPromos.frame.size.height = indexHeightPromos
        }
        viewInfoDetail.frame.size.height = soViewPromos.frame.origin.y + soViewPromos.frame.size.height + Common.Size(s:10)
        
        viewVoucher = UIView(frame: CGRect(x:0,y:viewInfoDetail.frame.origin.y + viewInfoDetail.frame.size.height + Common.Size(s:10),width:viewInfoDetail.frame.size.width,height:100))
        //        viewVoucher.backgroundColor = .yellow
        scrollView.addSubview(viewVoucher)
        
        let  lbVoucher = UILabel(frame: CGRect(x: tfPhoneNumber.frame.origin.x, y: Common.Size(s:0), width: tfPhoneNumber.frame.size.width, height: Common.Size(s:18)))
        lbVoucher.textAlignment = .left
        lbVoucher.textColor = UIColor(netHex:0x04AB6E)
        lbVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbVoucher.text = "VOUCHER KHÔNG GIÁ"
        viewVoucher.addSubview(lbVoucher)
        //
        let imgScanBarcodeVoucherKG = UIImageView(frame: CGRect(x: lbVoucher.frame.origin.x+Common.Size(s: 70), y: Common.Size(s: 0), width: lbVoucher.frame.size.width, height: lbVoucher.frame.size.height))
        imgScanBarcodeVoucherKG.image = #imageLiteral(resourceName: "scan_barcode_1")
        imgScanBarcodeVoucherKG.contentMode = UIView.ContentMode.scaleAspectFit
        //action intent barcode voucher activity
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(actionIntentBarcodeVoucherKhongGia))
        imgScanBarcodeVoucherKG.addGestureRecognizer(tap1)
        imgScanBarcodeVoucherKG.isUserInteractionEnabled = true
        
        
        viewVoucher.addSubview(imgScanBarcodeVoucherKG)
        
        
        
        //
        
        tableViewVoucherNoPrice.frame = CGRect(x: tfPhoneNumber.frame.origin.x, y:lbVoucher.frame.size.height + lbVoucher.frame.origin.y + Common.Size(s:10), width: self.view.frame.size.width, height: 0)
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        tableViewVoucherNoPrice.dataSource = self
        tableViewVoucherNoPrice.delegate = self
        tableViewVoucherNoPrice.register(ItemVoucherNoPriceTableViewCell.self, forCellReuseIdentifier: "ItemVoucherNoPriceTableViewCell")
        tableViewVoucherNoPrice.tableFooterView = UIView()
        tableViewVoucherNoPrice.backgroundColor = UIColor.white
        viewVoucher.addSubview(tableViewVoucherNoPrice)
        
        if(Cache.listVoucherNoPriceFF.count > 0){
            tableViewVoucherNoPrice.reloadData()
            tableViewVoucherNoPrice.layoutIfNeeded()
            tableViewVoucherNoPrice.frame.size.height = tableViewVoucherNoPrice.contentSize.height
        }
        
        lbAddVoucherMore = UILabel(frame: CGRect(x: scrollView.frame.size.width/2, y: tableViewVoucherNoPrice.frame.size.height + tableViewVoucherNoPrice.frame.origin.y + Common.Size(s:15), width: scrollView.frame.size.width/2 - Common.Size(s:15), height: Common.Size(s: 14)))
        lbAddVoucherMore.textAlignment = .right
        lbAddVoucherMore.textColor = UIColor(netHex:0x04AB6E)
        lbAddVoucherMore.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Thêm mã voucher", attributes: underlineAttribute)
        lbAddVoucherMore.attributedText = underlineAttributedString
        viewVoucher.addSubview(lbAddVoucherMore)
        let tapShowAddVoucher = UITapGestureRecognizer(target: self, action: #selector(PaymentViewController.tapShowAddVoucher))
        lbAddVoucherMore.isUserInteractionEnabled = true
        lbAddVoucherMore.addGestureRecognizer(tapShowAddVoucher)
        
        viewVoucher.frame.size.height =  lbAddVoucherMore.frame.size.height + lbAddVoucherMore.frame.origin.y
        
        viewsumDH = UIView(frame: CGRect(x:0,y:viewVoucher.frame.origin.y + viewVoucher.frame.size.height + Common.Size(s:20),width:viewInfoDetail.frame.size.width,height:100))
        //        viewVoucher.backgroundColor = .yellow
        scrollView.addSubview(viewsumDH)
        
        let lbTotal = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y:0, width: tfUserName.frame.size.width, height: Common.Size(s:20)))
        lbTotal.textAlignment = .left
        lbTotal.textColor = UIColor(netHex:0x04AB6E)
        lbTotal.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbTotal.text = "THÔNG TIN THANH TOÁN"
        viewsumDH.addSubview(lbTotal)
        
        
        
        
        //        let totalPay = total()
        //        let discountPay = discount()
        
        let lbTotalText = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbTotal.frame.origin.y + lbTotal.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbTotalText.textAlignment = .left
        lbTotalText.textColor = UIColor.black
        lbTotalText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbTotalText.text = "Tổng đơn hàng:"
        viewsumDH.addSubview(lbTotalText)
        
        
        let lbTotalValue = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbTotal.frame.origin.y + lbTotal.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbTotalValue.textAlignment = .right
        lbTotalValue.textColor = UIColor(netHex:0xEF4A40)
        lbTotalValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbTotalValue.text = Common.convertCurrencyFloat(value: totalPay)
        viewsumDH.addSubview(lbTotalValue)
        
        let lbDiscountText = UILabel(frame: CGRect(x: lbTotalText.frame.origin.x, y: lbTotalText.frame.origin.y + lbTotalText.frame.size.height, width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbDiscountText.textAlignment = .left
        lbDiscountText.textColor = UIColor.black
        lbDiscountText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbDiscountText.text = "Giảm giá:"
        viewsumDH.addSubview(lbDiscountText)
        
        let lbDiscountValue = UILabel(frame: CGRect(x: lbTotalValue.frame.origin.x, y: lbDiscountText.frame.origin.y , width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbDiscountValue.textAlignment = .right
        lbDiscountValue.textColor = UIColor(netHex:0xEF4A40)
        lbDiscountValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbDiscountValue.text = Common.convertCurrencyFloat(value: discountPay)
        viewsumDH.addSubview(lbDiscountValue)
        
        let lbPayText = UILabel(frame: CGRect(x: lbDiscountText.frame.origin.x, y: lbDiscountText.frame.origin.y + lbDiscountText.frame.size.height, width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbPayText.textAlignment = .left
        lbPayText.textColor = UIColor.black
        lbPayText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbPayText.text = "Tổng thanh toán:"
        viewsumDH.addSubview(lbPayText)
        
        let lbPayValue = UILabel(frame: CGRect(x: lbPayText.frame.origin.x, y: lbPayText.frame.origin.y , width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbPayValue.textAlignment = .right
        lbPayValue.textColor = UIColor(netHex:0xEF4A40)
        lbPayValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))
        lbPayValue.text = Common.convertCurrencyFloat(value: (totalPay - discountPay))
        viewsumDH.addSubview(lbPayValue)
        
        checkTotal = (totalPay - discountPay)
        
     
        
        let btPay = UIButton()
        btPay.frame = CGRect(x: tfUserName.frame.origin.x, y: lbPayText.frame.origin.y + lbPayText.frame.size.height + Common.Size(s:20), width: tfUserName.frame.size.width, height: tfUserName.frame.size.height * 1.2)
        btPay.backgroundColor = UIColor(netHex:0xEF4A40)
        if(Cache.typeOrder == "20"){
            btPay.setTitle("Kiểm tra KM", for: .normal)
        }else{
            btPay.setTitle("Gởi OTP & Kiểm tra KM", for: .normal)
        }
        
        btPay.addTarget(self, action: #selector(actionPay), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        
        viewsumDH.addSubview(btPay)
        viewsumDH.frame.size.height = btPay.frame.origin.y + btPay.frame.size.height + Common.Size(s:20)
 
        //        scrollView.addSubview(viewInfoDetail)
        
    
  
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewsumDH.frame.origin.y + viewsumDH.frame.size.height + Common.Size(s: 20 + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
        //+ ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        //hide keyboard
        self.hideKeyboardWhenTappedAround()

    }
    func actionSendOTP(){
        //
        //        if(!self.sendOTPSuccess){
        
        let nc = NotificationCenter.default
        let newViewController = LoadingViewController()
        newViewController.content = "Đang gửi mã OTP..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(newViewController, animated: true, completion: nil)
        
        MPOSAPIManager.mpos_sp_SendOTPCustomerFriend(UserID: "\(Cache.user!.UserName)", ListSP: "\(skuList)", IDcardCode: "\(self.ocfdFFriend!.IDcardCode)",Doctype:Cache.typeOrder,xml_sp: parseXMLProductOTP().toBase64()) { [weak self] (result,status, err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(Cache.typeOrder == "09"){
                        let title = "THÔNG BÁO"
                        let message = "Đã gửi mã OTP đến số điện thoại: \r\n\(self.ocfdFFriend!.SDT)"
                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        }
                        let buttonOne = DefaultButton(title: "OK") {
                            self.sendOTPSuccess = true
                            self.actionPay()
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }else{
                        let title = "THÔNG BÁO"
                      //  let message = "Đã gửi mã OTP đến số email: \r\n\(self.ocfdFFriend!.Email)"
                        let popup = PopupDialog(title: title, message: result, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        }
                        let buttonOne = DefaultButton(title: "OK") {
                            self.sendOTPSuccess = true
                            self.actionPay()
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                    
                }else{
                    if(status == 1){
                        let title = "THÔNG BÁO"
                        let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        }
                        let buttonOne = DefaultButton(title: "OK") {
                            self.sendOTPSuccess = true
                            self.actionPay()
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }else{
                        let title = "THÔNG BÁO"
                        let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        }
                        let buttonOne = DefaultButton(title: "OK") {
                            self.sendOTPSuccess = false
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    func actionOpenMenuLeft() {
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        // do other task
        let view:UIView = sender.view!
        let itemCart = Cache.cartsFF[view.tag]
        let lbImei: UILabel = listImei[view.tag]
        if(itemCart.product.qlSerial == "Y"){
            let newViewController = LoadingViewController()
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(newViewController, animated: true, completion: nil)
            
            MPOSAPIManager.getImeiFF(productCode: "\(itemCart.product.sku)", shopCode: "\(Cache.user!.ShopCode)") {[weak self] (result, err) in
                guard let self = self else {return}
                let nc = NotificationCenter.default
                if (result.count > 0){
                    var arr:[String] = []
                    var arrDate:[String] = []
                    var whsCodes:[String] = []
                    for item in result {
                        arr.append("\(item.DistNumber)")
                        if let theDate = Date(jsonDate: "\(item.CreateDate)") {
                            let dayTimePeriodFormatter = DateFormatter()
                            dayTimePeriodFormatter.dateFormat = "dd/MM/YY"
                            let dateString = dayTimePeriodFormatter.string(from: theDate)
                            arrDate.append("\(item.DistNumber)-\(dateString)")
                        } else {
                            arrDate.append("\(item.DistNumber)")
                        }
                        
                        whsCodes.append("\(item.WhsCode)")
                    }
                    if(arr.count == 1){
                        let when = DispatchTime.now() + 1
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            
                            var check: Bool = true
                            for item in Cache.cartsFF {
                                if (item.product.qlSerial == "Y"){
                                    if item.imei == "\(String(describing: arr[0]))" {
                                        check = false
                                        break
                                    }
                                }
                            }
                            if (check == true) {
                                itemCart.imei = arr[0]
                                itemCart.whsCode = whsCodes[0]
                                lbImei.text = "IMEI: \(itemCart.imei)"
                            }else{
                                // Prepare the popup
                                let title = "CHÚ Ý"
                                let message = "Bạn chọn IMEI máy bị trùng!"
                                
                                // Create the dialog
                                let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                
                                // Create first button
                                let buttonOne = CancelButton(title: "OK") {
                                    
                                }
                                // Add buttons to dialog
                                popup.addButtons([buttonOne])
                                
                                // Present dialog
                                self.present(popup, animated: true, completion: nil)
                            }
                            
                        }
                        
                    }else{
                        let when = DispatchTime.now() + 1
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            ActionSheetStringPicker.show(withTitle: "Chọn IMEI", rows: arrDate, initialSelection: 0, doneBlock: {
                                picker, value, index1 in
                                nc.post(name: Notification.Name("updateTotal"), object: nil)
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                
                                
                                var check: Bool = true
                                for item in Cache.cartsFF {
                                    if (item.product.qlSerial == "Y"){
                                        if item.imei == "\(String(describing: arr[value]))" {
                                            check = false
                                            break
                                        }
                                    }
                                }
                                if (check == true) {
                                    
                                    let dateChoose = arrDate[value].components(separatedBy: "-")
                                    let dateDefault = arrDate[0].components(separatedBy: "-")
                                    if(dateChoose.count == 2 && dateDefault.count == 2){
                                        if (dateChoose[1] != dateDefault[1]){
                                            // Prepare the popup
                                            let title = "CHÚ Ý"
                                            let message = "Bạn chọn IMEI sai FIFO"
                                            
                                            // Create the dialog
                                            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                print("Completed")
                                            }
                                            
                                            // Create first button
                                            let buttonOne = CancelButton(title: "OK") {
                                                
                                            }
                                            
                                            // Add buttons to dialog
                                            popup.addButtons([buttonOne])
                                            
                                            // Present dialog
                                            self.present(popup, animated: true, completion: nil)
                                        }
                                    }
                                    
                                    itemCart.imei = "\(arr[value])"
                                    itemCart.whsCode = whsCodes[value]
                                    lbImei.text = "IMEI: \(itemCart.imei)"
                                }else{
                                    // Prepare the popup
                                    let title = "CHÚ Ý"
                                    let message = "Bạn chọn IMEI máy bị trùng!"
                                    
                                    // Create the dialog
                                    let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        print("Completed")
                                    }
                                    
                                    // Create first button
                                    let buttonOne = CancelButton(title: "OK") {
                                        
                                    }
                                    
                                    // Add buttons to dialog
                                    popup.addButtons([buttonOne])
                                    
                                    // Present dialog
                                    self.present(popup, animated: true, completion: nil)
                                }
                                return
                            }, cancel: { ActionStringCancelBlock in
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                return
                            }, origin: self.view)
                        }
                        
                    }
                }else{
                    
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        let alertController = UIAlertController(title: "HẾT HÀNG", message: "Sản phẩm bạn chọn đã hết hàng tại shop!", preferredStyle: .alert)
                        
                        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                            itemCart.inStock = 0
                            _ = self.navigationController?.popViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                        }
                        alertController.addAction(confirmAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                    
                }
            }
        }
        
    }
    func actionHome(){
        _ = self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    func discount() ->Float{
        var sum:Float = 0.0
        for item in Cache.itemsPromotionFF{
            sum = sum + item.TienGiam
        }
        return sum
    }
    func total() ->Float{
        var sum: Float = 0
        for item in Cache.cartsFF {
            sum = sum + Float(item.quantity) * item.product.price
        }
        return sum
    }
    
    @objc func actionPay() {
        
        if(self.ocfdFFriend!.LoaiKH == 5 && checkTotal < self.ocfdFFriend!.HanMucConLai){
            
            let title = "THÔNG BÁO"
            let message = "Tổng đơn hàng phải lớn hơn hoặc bằng hạn mức còn lại!"
            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            }
            let buttonTow = CancelButton(title: "Đóng") {
            }
            popup.addButtons([buttonTow])
            self.present(popup, animated: true, completion: nil)
            return
        }
        
        Cache.promotionsFF.removeAll()
        Cache.groupFF = []
        Cache.itemsPromotionFF.removeAll()
        self.promotionsFF.removeAll()
        self.groupFF.removeAll()
        
        // check phone
        let phone = tfPhoneNumber.text!
        if (phone.hasPrefix("01") && phone.count == 11){
            
        }else if (phone.hasPrefix("0") && !phone.hasPrefix("01") && phone.count == 10){
            
        }else{

            self.showDialog(text: "Số điện thoại không hợp lệ!")
            return
        }
        // check user name
        let name = tfUserName.text!
        if name.count > 0 {
            
        }else{
         
            self.showDialog(text: "Tên không được để trống!")
            return
        }
        for item in Cache.cartsFF {
            if (item.product.qlSerial == "Y"){
                if item.imei == "N/A" {
                
                    self.showDialog(text: "\(item.product.name) chưa chọn IMEI.")
                    return
                }
            }
        }
        if(Cache.typeOrder != "20"){
            if(!sendOTPSuccess){
                let title = "THÔNG BÁO"
                let message = "Bạn phải gửi OTP xác nhận khách hàng!"
                let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                }
                let buttonOne = DefaultButton(title: "Gửi OTP") {
                    self.actionSendOTP()
                }
                let buttonTow = CancelButton(title: "Đóng") {
                }
                popup.addButtons([buttonOne,buttonTow])
                self.present(popup, animated: true, completion: nil)
                return
            }
        }
        var voucher = ""
         if(Cache.listVoucherNoPriceFF.count > 0){
             voucher = "<line>"
             for item in Cache.listVoucherNoPriceFF{
                 if(item.isSelected == true){
                     voucher  = voucher + "<item voucher=\"\(item.VC_Code)\" />"
                 }
                 
             }
             voucher = voucher + "</line>"
         }
        let nc = NotificationCenter.default
        let newViewController = LoadingViewController()
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(newViewController, animated: true, completion: nil)
        
        MPOSAPIManager.checkPromotionFF(u_CrdCod: "0", sdt: "\(phone)", LoaiDonHang: Cache.typeOrder, LoaiTraGop: "0", LaiSuat: 0, SoTienTraTruoc: 0, voucher: voucher, IDCardcode: "\(self.ocfdFFriend!.IDcardCode)",Docentry: "\(Cache.depositEcomNumFF)") { (promotion, err) in
            if(promotion != nil){
                
                if ((promotion?.productPromotions?.count)! > 0){
                    for item in (promotion?.productPromotions)! {
                        
                        if let val:NSMutableArray = self.promotionsFF["Nhóm \(item.Nhom)"] {
                            val.add(item)
                            self.promotionsFF.updateValue(val, forKey: "Nhóm \(item.Nhom)")
                        } else {
                            let arr: NSMutableArray = NSMutableArray()
                            arr.add(item)
                            self.promotionsFF.updateValue(arr, forKey: "Nhóm \(item.Nhom)")
                            self.groupFF.append("Nhóm \(item.Nhom)")
                        }
                    }
                    Cache.promotionsFF = self.promotionsFF
                    Cache.groupFF = self.groupFF
                    
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        let newViewController = PromotionFFriendViewController()
                        Cache.cartsTemp = Cache.cartsFF
                        Cache.phoneTemp = phone
                        Cache.nameTemp = name
                        newViewController.productPromotions = (promotion?.productPromotions)!
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }
                    // chuyen qua khuyen main
                    
                }else{
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        
                        if(Cache.typeOrder == "09"){
                            let newViewController = ReadSOFFriendDetailViewController()
                            newViewController.carts = Cache.cartsFF
                            newViewController.itemsPromotion = Cache.itemsPromotion
                            newViewController.phone = phone
                            newViewController.name = name
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }else if(Cache.typeOrder == "10"){
                            let newViewController = ReadSOPayDirectlyFFriendDetailViewController()
                            newViewController.carts = Cache.cartsFF
                            newViewController.itemsPromotion = Cache.itemsPromotion
                            newViewController.phone = phone
                            newViewController.name = name
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }else if(Cache.typeOrder == "20"){
                            let newViewController = ReadSOCreditFFriendViewController()
                            newViewController.carts = Cache.cartsFF
                            newViewController.itemsPromotion = Cache.itemsPromotion
                            newViewController.phone = phone
                            newViewController.name = name
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }
                        
                    }
                }
            }else{
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let errorAlert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                        alert -> Void in
                        
                    }))
                    self.present(errorAlert, animated: true, completion: nil)
                }
            }
            
        }
    }
    func parseXMLProductOTP()->String{
        var rs:String = "<line>"
          for item in Cache.cartsFF {
              var name = item.product.name
              name = name.replace(target: "&", withString:"&#38;")
              name = name.replace(target: "<", withString:"&#60;")
              name = name.replace(target: ">", withString:"&#62;")
              name = name.replace(target: "\"", withString:"&#34;")
              name = name.replace(target: "'", withString:"&#39;")
              
              item.imei = item.imei.replace(target: "&", withString:"&#38;")
              item.imei = item.imei.replace(target: "<", withString:"&#60;")
              item.imei = item.imei.replace(target: ">", withString:"&#62;")
              item.imei = item.imei.replace(target: "\"", withString:"&#34;")
              item.imei = item.imei.replace(target: "'", withString:"&#39;")
            let thanhtien = item.product.price * Float(item.quantity)
              
              rs = rs + "<item MaSP=\"\(item.product.sku)\" SoLuong=\"\(item.quantity)\"  ThanhTien=\"\(String(format: "%.6f", thanhtien))\"/>"
          }
          rs = rs + "</line>"
          print(rs)
          return rs
    }
    func parseXMLPromotion()->String{
        var rs:String = "<line>"
        for item in Cache.itemsPromotionFF {
            var tenCTKM = item.TenCTKM
            tenCTKM = tenCTKM.replace(target: "&", withString:"&#38;")
            tenCTKM = tenCTKM.replace(target: "<", withString:"&#60;")
            tenCTKM = tenCTKM.replace(target: ">", withString:"&#62;")
            tenCTKM = tenCTKM.replace(target: "\"", withString:"&#34;")
            tenCTKM = tenCTKM.replace(target: "'", withString:"&#39;")
            
            var tenSanPham_Tang = item.TenSanPham_Tang
            tenSanPham_Tang = tenSanPham_Tang.replace(target: "&", withString:"&#38;")
            tenSanPham_Tang = tenSanPham_Tang.replace(target: "<", withString:"&#60;")
            tenSanPham_Tang = tenSanPham_Tang.replace(target: ">", withString:"&#62;")
            tenSanPham_Tang = tenSanPham_Tang.replace(target: "\"", withString:"&#34;")
            tenSanPham_Tang = tenSanPham_Tang.replace(target: "'", withString:"&#39;")
            
            rs = rs + "<item SanPham_Mua=\"\(item.SanPham_Mua)\" TienGiam=\"\(String(format: "%.6f", item.TienGiam))\" LoaiKM=\"\(item.Loai_KM)\" SanPham_Tang=\"\(item.SanPham_Tang)\" TenSanPham_Tang=\"\(tenSanPham_Tang)\" SL_Tang=\"\(item.SL_Tang)\" Nhom=\"\(item.Nhom)\" MaCTKM=\"\(item.MaCTKM)\" TenCTKM=\"\(tenCTKM)\"/>"
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
    func parseXMLProduct()->String{
        var rs:String = "<line>"
        for item in Cache.cartsFF {
            var name = item.product.name
            name = name.replace(target: "&", withString:"&#38;")
            name = name.replace(target: "<", withString:"&#60;")
            name = name.replace(target: ">", withString:"&#62;")
            name = name.replace(target: "\"", withString:"&#34;")
            name = name.replace(target: "'", withString:"&#39;")
            
            item.imei = item.imei.replace(target: "&", withString:"&#38;")
            item.imei = item.imei.replace(target: "<", withString:"&#60;")
            item.imei = item.imei.replace(target: ">", withString:"&#62;")
            item.imei = item.imei.replace(target: "\"", withString:"&#34;")
            item.imei = item.imei.replace(target: "'", withString:"&#39;")
            
            rs = rs + "<item U_ItmCod=\"\(item.product.sku)\" U_Imei=\"\(item.imei)\" U_Quantity=\"\(item.quantity)\"  U_Price=\"\(String(format: "%.6f", item.product.price))\" U_WhsCod=\"\(Cache.user!.ShopCode)010\" U_ItmName=\"\(name)\"/>"
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
    func updateTotal() ->String{
        var sum: Float = 0
        for item in Cache.cartsFF {
            sum = sum + Float(item.quantity) * item.product.price
        }
        return Common.convertCurrencyFloat(value: sum)
    }
    @objc func actionIntentBarcodeVoucherKhongGia(){
        if(tfPhoneNumber.text! == ""){
            self.showDialog(text: "Bạn chưa nhập số điện thoại khách hàng !!!")
            return
        }
        
        
        
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { code in
            let newViewController = LoadingViewController()
             newViewController.content = "Đang kiểm tra thông tin..."
             newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
             newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
             self.navigationController?.present(newViewController, animated: true, completion: nil)
             let nc = NotificationCenter.default
             
             MPOSAPIManager.mpos_FRT_SP_check_VC_crm(voucher:"\(code)",sdt:"\(self.tfPhoneNumber.text!)",doctype:"\(Cache.typeOrder)") { (p_status,p_message,err) in
                 let when = DispatchTime.now() + 0.5
                 DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        if(p_status == 2){
                            Cache.listVoucherNoPriceFF = []
                            let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                 
                             })
                             self.present(alert, animated: true)
                             return
                         }
                         if(p_status == 1){//1
                            
                            let voucherObject = VoucherNoPrice(VC_Code: code, VC_Name: "", Endate: "", U_OTPcheck: "", STT: 0, isSelected: true)
                            Cache.listVoucherNoPriceFF.append(voucherObject)
                            self.tableViewVoucherNoPrice.reloadData()
                            self.autoSizeView()
                        }
                         if(p_status == 0){//0
                             
                             let voucherObject = VoucherNoPrice(VC_Code: code, VC_Name: "", Endate: "", U_OTPcheck: "", STT: 0, isSelected: true)
                             Cache.listVoucherNoPriceFF.append(voucherObject)
                             self.tableViewVoucherNoPrice.reloadData()
                             self.autoSizeView()
                             
                             
                             
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
        self.present(viewController, animated: false, completion: nil)
     }
    func showDialog(text:String){
        let alert = UIAlertController(title: "Thông báo", message: text, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
            
        })
        self.present(alert, animated: true)
    }
    @objc func tapShowAddVoucher(sender:UITapGestureRecognizer) {
        if(tfPhoneNumber.text! == ""){
            self.showDialog(text: "Bạn chưa nhập số điện thoại khách hàng !!!")
            return
        }
   
        let alertController = UIAlertController(title: "Thêm voucher", message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Huỷ", style: .default, handler: {
            alert -> Void in
            self.dismiss(animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: "Lưu", style: .cancel, handler: {
            alert -> Void in
            let fNameField = alertController.textFields![0] as UITextField
            if fNameField.text != ""{
                self.dismiss(animated: true, completion: nil)

                let newViewController = LoadingViewController()
                newViewController.content = "Đang kiểm tra thông tin..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                
                
                MPOSAPIManager.mpos_FRT_SP_check_VC_crm(voucher:"\(fNameField.text!)",sdt:"\(self.tfPhoneNumber.text!)",doctype:"\(Cache.typeOrder)") { (p_status,p_message,err) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            Cache.listVoucherNoPriceFF = [] //rule add 1 voucher
                            if(p_status == 2){
                                let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                    
                                })
                                self.present(alert, animated: true)
                                return
                            }
                            if(p_status == 1){//1
                                let voucherObject = VoucherNoPrice(VC_Code: fNameField.text!, VC_Name: "", Endate: "", U_OTPcheck: "", STT: 0, isSelected: true)
                                Cache.listVoucherNoPriceFF.append(voucherObject)
                                self.tableViewVoucherNoPrice.reloadData()
                                self.autoSizeView()
                                
                            }
                            if(p_status == 0){//0
                                
                                let voucherObject = VoucherNoPrice(VC_Code: fNameField.text!, VC_Name: "", Endate: "", U_OTPcheck: "", STT: 0, isSelected: true)
                                Cache.listVoucherNoPriceFF.append(voucherObject)
                                self.tableViewVoucherNoPrice.reloadData()
                                self.autoSizeView()

                            }
                            
                        }else{
                            let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                
                            })
                            self.present(alert, animated: true)
                        }
                    }
                    
                }
                
            } else {
                let errorAlert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập mã voucher!", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                    alert -> Void in
                    self.present(alertController, animated: true, completion: nil)
                }))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }))
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Nhập mã voucher..."
            textField.textAlignment = .center
            textField.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        })
        self.present(alertController, animated: true, completion: nil)
        
    }
}

extension PaymentFFriendViewController:UITableViewDataSource,UITableViewDelegate,ItemVoucherNoPriceTableViewCellDelegate{
    func autoSizeView(){
        
        self.tableViewVoucherNoPrice.layoutIfNeeded()
        self.tableViewVoucherNoPrice.frame.size.height = self.tableViewVoucherNoPrice.contentSize.height + Common.Size(s: 10)
        self.lbAddVoucherMore.frame.origin.y = self.tableViewVoucherNoPrice.frame.size.height + self.tableViewVoucherNoPrice.frame.origin.y + Common.Size(s: 15)
        self.viewVoucher.frame.size.height =  self.lbAddVoucherMore.frame.size.height + self.lbAddVoucherMore.frame.origin.y
        self.viewsumDH.frame.origin.y = self.viewVoucher.frame.origin.y + self.viewVoucher.frame.size.height + Common.Size(s:20)
     
        self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.viewsumDH.frame.origin.y + self.viewsumDH.frame.size.height + Common.Size(s: 20 + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
    }
    func tabReloadViewRemoveVoucher(indexNum: Int) {
        Cache.listVoucherNoPriceFF.remove(at: indexNum)
        self.tableViewVoucherNoPrice.reloadData()
        self.autoSizeView()
    }
    
    func tabClickView(voucher: VoucherNoPrice) {
       
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_FRT_SP_check_VC_crm(voucher:"\(voucher.VC_Code)",sdt:"\(self.tfPhoneNumber.text!)",doctype:"\(Cache.typeOrder)") { (p_status,p_message,err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(p_status == 2){
                        let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                        return
                    }
                    if(p_status == 1){//1
                        for item in Cache.listVoucherNoPriceFF{
                            if(item.VC_Code == voucher.VC_Code){
                                item.isSelected = true
                                break
                            }
                        }
                        self.tableViewVoucherNoPrice.reloadData()
                        self.autoSizeView()
                    }
                    if(p_status == 0){//0
                        
                        for item in Cache.listVoucherNoPriceFF{
                            if(item.VC_Code == voucher.VC_Code){
                                item.isSelected = true
                                break
                            }
                        }
                        self.tableViewVoucherNoPrice.reloadData()
                        self.autoSizeView()
   
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cache.listVoucherNoPriceFF.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ItemVoucherNoPriceTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemVoucherNoPriceTableViewCell")
        let item:VoucherNoPrice = Cache.listVoucherNoPriceFF[indexPath.row]
        cell.setup(so: item,indexNum: indexPath.row,readOnly:false)
        cell.selectionStyle = .none
        cell.delegate = self
        self.cellHeight = cell.estimateCellHeight
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
     }
     
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         return true
     }
    
    
}
