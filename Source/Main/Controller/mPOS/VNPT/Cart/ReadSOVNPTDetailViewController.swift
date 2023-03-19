//
//  ReadSODetailViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import DLRadioButton
import SkyFloatingLabelTextField
import PopupDialog
import ActionSheetPicker_3_0
import Toaster
import KeychainSwift
class ReadSOVNPTDetailViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate{
    
    var carts:[Cart] = []
    var itemsPromotion: [ProductPromotions] = []
    var phone: String = ""
    var name: String = ""
    var address: String = ""
    var email: String = ""
    var note: String = ""
    var type: String = ""
    var payment: String = ""
    var docEntry: String = ""
    var birthday:String = ""
    var gender:Int = 0
    var debitCustomer:DebitCustomer?
    
    var scrollView:UIScrollView!
    var tfPhoneNumber:SkyFloatingLabelTextFieldWithIcon!
    var tfUserName:SkyFloatingLabelTextFieldWithIcon!
    var tfUserAddress:SkyFloatingLabelTextFieldWithIcon!
    var tfUserEmail:SkyFloatingLabelTextFieldWithIcon!
    
    var tfVoucher:UITextField!
    
    var taskNotes: UITextView!
    var placeholderLabel : UILabel!
    
    var orderType:Int = -1
    var orderPayType:Int = -1
    var orderPayInstallment:Int = -1
    
    var radioAtTheCounter:DLRadioButton!
    var radioInstallment:DLRadioButton!
    var radioDeposit:DLRadioButton!
    var radioPayNow:DLRadioButton!
    var radioPayNotNow:DLRadioButton!
    
    var radioPayInstallmentCom:DLRadioButton!
    var radioPayInstallmentCard:DLRadioButton!
    
    var listImei:[UILabel] = []
    
    var lbPayType:UILabel!
    
    var viewInstallment:UIView!
    var viewInstallmentHeight: CGFloat = 0.0
    
    var viewInfoDetail: UIView!
    
    var tfInterestRate:UITextField!
    var tfPrepay:UITextField!
    
    var valueInterestRate:Float = 0
    var valuePrepay:Float = 0
    
    var buttonSaveAction:Bool = false
    
    var radioMan:DLRadioButton!
    var radioWoman:DLRadioButton!
    var tfUserBirthday:SkyFloatingLabelTextFieldWithIcon!
    
    var viewInstallmentCard:UIView!
    var viewInstallmentCom:UIView!
    var companyButton: SearchTextField!
    
    var tfPrepayCom,tfContractNumber,tfCMND,tfInterestRateCom,tfLimit:UITextField!
    var totalPayment:Int = 0
    //--
    var itemPromotion:ProductPromotions!
    var promos:[ProductPromotions] = []
    var lbImeiPro: UILabel!
    var is_DH_DuAn:String = ""
       var viewVoucher,viewVoucherLine :UIView!
     var listVoucher:[GenVoucher] = []
     var skuList:String = ""
      var sumMoney:Float = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        promos = []
        
        self.title = "Đơn hàng"
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x04AB6E)
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        buttonSaveAction = false
        self.setupUI()
        
        
    }
    func setupUI() {
        
        let lbUserInfo = UILabel(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:18)))
        lbUserInfo.textAlignment = .left
        lbUserInfo.textColor = UIColor(netHex:0x04AB6E)
        lbUserInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbUserInfo.text = "THÔNG TIN KHÁCH HÀNG"
        scrollView.addSubview(lbUserInfo)
        
        
        
        //input name info
        tfUserName = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x:Common.Size(s:20), y: lbUserInfo.frame.size.height + lbUserInfo.frame.origin.y + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40)  , height: Common.Size(s:40) ), iconType: .image);
        tfUserName.placeholder = "Nhập họ tên"
        tfUserName.title = "Tên khách hàng"
        tfUserName.iconImage = UIImage(named: "name")
        tfUserName.tintColor = UIColor(netHex:0x04AB6E)
        tfUserName.lineColor = UIColor.gray
        tfUserName.selectedTitleColor = UIColor(netHex:0x04AB6E)
        tfUserName.selectedLineColor = UIColor(netHex:0x04AB6E)
        tfUserName.lineHeight = 0.5
        tfUserName.selectedLineHeight = 0.5
        tfUserName.clearButtonMode = .whileEditing
        tfUserName.delegate = self
        tfUserName.text = name
        scrollView.addSubview(tfUserName)
        tfUserName.isUserInteractionEnabled = false
        tfUserName.text = Cache.infoCMNDVNPT!.TenKH
        
        //input phone number
        tfPhoneNumber = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:20), y: tfUserName.frame.origin.y + tfUserName.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)), iconType: .image)
        tfPhoneNumber.placeholder = "Nhập số điện thoại"
        tfPhoneNumber.title = "Số điện thoại"
        tfPhoneNumber.iconImage = UIImage(named: "phone_number")
        tfPhoneNumber.tintColor = UIColor(netHex:0x04AB6E)
        tfPhoneNumber.lineColor = UIColor.gray
        tfPhoneNumber.selectedTitleColor = UIColor(netHex:0x04AB6E)
        tfPhoneNumber.selectedLineColor = UIColor(netHex:0x04AB6E)
        tfPhoneNumber.lineHeight = 0.5
        tfPhoneNumber.selectedLineHeight = 0.5
        tfPhoneNumber.clearButtonMode = .whileEditing
        tfPhoneNumber.delegate = self
        tfPhoneNumber.text = phone
        scrollView.addSubview(tfPhoneNumber)
        tfPhoneNumber.isUserInteractionEnabled = false
        tfPhoneNumber.text = Cache.infoCMNDVNPT!.SDT

  
        
        //input email
        tfUserEmail = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: tfUserName.frame.origin.x, y: tfPhoneNumber.frame.origin.y + tfPhoneNumber.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width , height: tfUserName.frame.size.height ), iconType: .image);
        tfUserEmail.placeholder = "Nhập CMND"
        tfUserEmail.title = "CMND"
        tfUserEmail.iconImage = UIImage(named: "email")
        tfUserEmail.tintColor = UIColor(netHex:0x04AB6E)
        tfUserEmail.lineColor = UIColor.gray
        tfUserEmail.selectedTitleColor = UIColor(netHex:0x04AB6E)
        tfUserEmail.selectedLineColor = UIColor(netHex:0x04AB6E)
        tfUserEmail.lineHeight = 0.5
        tfUserEmail.selectedLineHeight = 0.5
        tfUserEmail.clearButtonMode = .whileEditing
        tfUserEmail.delegate = self
        scrollView.addSubview(tfUserEmail)
        tfUserEmail.text = email
        tfUserEmail.isUserInteractionEnabled = false
        tfUserEmail.text = Cache.infoCMNDVNPT!.CMND
       
  
        
    
        
        
        viewInfoDetail = UIView(frame: CGRect(x: 0, y: tfUserEmail.frame.origin.y  + tfUserEmail.frame.size.height, width: self.view.frame.size.width, height: 0))
        scrollView.addSubview(viewInfoDetail)
        
        
        viewVoucher = UIView(frame: CGRect(x:0,y: Common.Size(s:10),width:viewInfoDetail.frame.size.width,height:100))
        //        viewVoucher.backgroundColor = .yellow
        viewInfoDetail.addSubview(viewVoucher)
        
        let  lbVoucher = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: Common.Size(s:0), width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbVoucher.textAlignment = .left
        lbVoucher.textColor = UIColor(netHex:0x04AB6E)
        lbVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbVoucher.text = "VOUCHER KHÔNG GIÁ"
        viewVoucher.addSubview(lbVoucher)
        
        let viewVoucherLine = UIView(frame: CGRect(x:Common.Size(s:20),y:lbVoucher.frame.origin.y + lbVoucher.frame.size.height + Common.Size(s:10),width:viewInfoDetail.frame.size.width - Common.Size(s:40),height:100))
        viewVoucher.addSubview(viewVoucherLine)
        
        let line1Voucher = UIView(frame: CGRect(x: viewVoucherLine.frame.size.width * 1.3/10, y: 0, width: 1, height: Common.Size(s:25)))
        line1Voucher.backgroundColor = UIColor(netHex:0x04AB6E)
        viewVoucherLine.addSubview(line1Voucher)
        let line2Voucher = UIView(frame: CGRect(x: 0, y:line1Voucher.frame.origin.y + line1Voucher.frame.size.height, width: viewVoucherLine.frame.size.width, height: 1))
        line2Voucher.backgroundColor = UIColor(netHex:0x04AB6E)
        viewVoucherLine.addSubview(line2Voucher)
        
        let lbSttVoucher = UILabel(frame: CGRect(x: 0, y: line1Voucher.frame.origin.y, width: line1Voucher.frame.origin.x, height: line1Voucher.frame.size.height))
        lbSttVoucher.textAlignment = .center
        lbSttVoucher.textColor = UIColor(netHex:0x04AB6E)
        lbSttVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbSttVoucher.text = "STT"
        viewVoucherLine.addSubview(lbSttVoucher)
        
        let lbInfoVoucher = UILabel(frame: CGRect(x: line1Voucher.frame.origin.x, y: line1Voucher.frame.origin.y, width: viewVoucherLine.frame.size.width - line1Voucher.frame.origin.x, height: line1Voucher.frame.size.height))
        lbInfoVoucher.textAlignment = .center
        lbInfoVoucher.textColor = UIColor(netHex:0x04AB6E)
        lbInfoVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbInfoVoucher.text = "Mã voucher"
        viewVoucherLine.addSubview(lbInfoVoucher)
        
        var indexYVoucher = line2Voucher.frame.origin.y
        var indexHeightVoucher: CGFloat = line2Voucher.frame.origin.y + line2Voucher.frame.size.height
        var numVoucher = 0
        for item in Cache.listVoucherVNPT{
            numVoucher = numVoucher + 1
            let soViewLine = UIView()
            viewVoucherLine.addSubview(soViewLine)
            soViewLine.frame = CGRect(x: 0, y: indexYVoucher, width: viewVoucherLine.frame.size.width, height: Common.Size(s:40))
            
            let line3 = UIView(frame: CGRect(x: line1Voucher.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
            line3.backgroundColor = UIColor(netHex:0x04AB6E)
            soViewLine.addSubview(line3)
            
            let nameProduct = "\(item)"
            let lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: 0, width: viewVoucherLine.frame.size.width - line3.frame.origin.x -  soViewLine.frame.size.height, height: Common.Size(s:40)))
            lbNameProduct.textAlignment = .left
            lbNameProduct.textColor = UIColor.black
            lbNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbNameProduct.text = nameProduct
            lbNameProduct.numberOfLines = 3
            soViewLine.addSubview(lbNameProduct)
            
            let line4 = UIView(frame: CGRect(x: line3.frame.origin.x, y:0, width: viewVoucherLine.frame.size.width - line3.frame.origin.x - 1, height: 1))
            line4.backgroundColor = UIColor(netHex:0x04AB6E)
            soViewLine.addSubview(line4)
            
            let lbSttValue = UILabel(frame: CGRect(x: 0, y: 0, width: lbSttVoucher.frame.size.width, height: Common.Size(s:40)))
            lbSttValue.textAlignment = .center
            lbSttValue.textColor = UIColor.black
            lbSttValue.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbSttValue.text = "\(numVoucher)"
            soViewLine.addSubview(lbSttValue)
            
            indexHeightVoucher = indexHeightVoucher + soViewLine.frame.size.height
            indexYVoucher = indexYVoucher + soViewLine.frame.size.height + soViewLine.frame.origin.x
            
        }
        viewVoucherLine.frame.size.height = indexHeightVoucher
        if(Cache.listVoucher.count == 0){
            viewVoucherLine.frame.size.height = 0
            viewVoucherLine.clipsToBounds = true
        }
        
        
        viewVoucher.frame.size.height =  viewVoucherLine.frame.size.height + viewVoucherLine.frame.origin.y
        
  
        
        let soViewPhone = UIView()
        viewInfoDetail.addSubview(soViewPhone)
        soViewPhone.frame = CGRect(x: tfUserName.frame.origin.x, y: viewVoucher.frame.origin.y + viewVoucher.frame.size.height + Common.Size(s:20), width: tfUserName.frame.size.width, height: 100)
        
        
        let lbSODetail = UILabel(frame: CGRect(x: 0, y: 0, width: soViewPhone.frame.size.width, height: Common.Size(s:18)))
        lbSODetail.textAlignment = .left
        lbSODetail.textColor = UIColor(netHex:0x04AB6E)
        lbSODetail.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbSODetail.text = "THÔNG TIN ĐƠN HÀNG"
        soViewPhone.addSubview(lbSODetail)
        
        let line1 = UIView(frame: CGRect(x: soViewPhone.frame.size.width * 1.3/10, y:lbSODetail.frame.origin.y + lbSODetail.frame.size.height + Common.Size(s:10), width: 1, height: Common.Size(s:25)))
        line1.backgroundColor = UIColor(netHex:0x04AB6E)
        soViewPhone.addSubview(line1)
        let line2 = UIView(frame: CGRect(x: 0, y:line1.frame.origin.y + line1.frame.size.height, width: soViewPhone.frame.size.width, height: 1))
        line2.backgroundColor = UIColor(netHex:0x04AB6E)
        soViewPhone.addSubview(line2)
        
        let lbStt = UILabel(frame: CGRect(x: 0, y: line1.frame.origin.y, width: line1.frame.origin.x, height: line1.frame.size.height))
        lbStt.textAlignment = .center
        lbStt.textColor = UIColor(netHex:0x04AB6E)
        lbStt.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbStt.text = "STT"
        soViewPhone.addSubview(lbStt)
        
        let lbInfo = UILabel(frame: CGRect(x: line1.frame.origin.x, y: line1.frame.origin.y, width: lbSODetail.frame.size.width - line1.frame.origin.x, height: line1.frame.size.height))
        lbInfo.textAlignment = .center
        lbInfo.textColor = UIColor(netHex:0x04AB6E)
        lbInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbInfo.text = "Sản phẩm"
        soViewPhone.addSubview(lbInfo)
        
        var indexY = line2.frame.origin.y
        var indexHeight: CGFloat = line2.frame.origin.y + line2.frame.size.height
        var num = 0
        var totalPay:Int = 0
        for item in Cache.cartsVNPT{
            num = num + 1
//            totalPay = totalPay + (item.product.price * Float(item.quantity))
            var discountPay:Float = 0.0
            for it in self.itemsPromotion{
                if (it.TienGiam > 0 && item.sku == it.SanPham_Mua){
                    discountPay = discountPay + it.TienGiam
                }
            }
//            discountPay = discountPay +  Float(item.discount)
//            if((item.product.price != item.product.priceBeforeTax) || item.product.sku == Common.skuKHTT){
//                let sum = ((item.product.priceBeforeTax * Float(item.quantity)) - Float(item.discount))
//                print("\(String(format:"%.2f", sum))")
//                print("\(String(format:"%.6f", totalPay + ((sum * 1.1) - discountPay)))")
//                totalPay = totalPay + ((sum * 1.1) - discountPay).rounded(.toNearestOrAwayFromZero)
                
//                let sum = ((item.product.price * Float(item.quantity)) - Float(item.discount))
//                totalPay = totalPay + (sum - discountPay).rounded(.toNearestOrAwayFromZero)
//            }else{
//                let sum = ((item.product.price * Float(item.quantity)) - Float(item.discount) - discountPay)
//                totalPay = totalPay + sum.rounded(.toNearestOrEven)
//            }
            let sum = ((Int(item.product.price) * item.quantity) - item.discount)
            //totalPay = totalPay + (sum - Int(discountPay))
            totalPay = totalPay + sum
            let soViewLine = UIView()
            soViewPhone.addSubview(soViewLine)
            soViewLine.frame = CGRect(x: 0, y: indexY, width: soViewPhone.frame.size.width, height: 50)
            let line3 = UIView(frame: CGRect(x: line1.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
            line3.backgroundColor = UIColor(netHex:0x04AB6E)
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
            line4.backgroundColor = UIColor(netHex:0x04AB6E)
            soViewLine.addSubview(line4)
            
            let lbQuantityProduct = UILabel(frame: CGRect(x: lbNameProduct.frame.origin.x , y: lbNameProduct.frame.origin.y + lbNameProduct.frame.size.height + Common.Size(s:5), width: lbNameProduct.frame.size.width, height: Common.Size(s:14)))
            lbQuantityProduct.textAlignment = .left
            lbQuantityProduct.textColor = UIColor.black
            lbQuantityProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            if (item.product.qlSerial == "Y"){
                lbQuantityProduct.text = "IMEI: \((item.imei))"
            }else{
                if (item.product.id == 2 || item.product.id == 3){
                    lbQuantityProduct.text = "IMEI: \((item.imei))"
                }else{
                    lbQuantityProduct.text = "Số lượng: \((item.quantity))"
                }
            }
            if(item.sku == "00503355"){
                lbQuantityProduct.text = "SĐT: \((Cache.phoneNumberBookSim))"
            }
//            listImei.append(lbQuantityProduct)
            
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
            
            if item.product.p_matkinh == "Y" {
                let imgViewUpHinhPBH = UIImageView(frame: CGRect(x: 5, y: lbSttValue.frame.origin.y + lbSttValue.frame.size.height, width: lbSttValue.frame.size.width - 10, height: lbNameProduct.frame.size.height))
                imgViewUpHinhPBH.image = #imageLiteral(resourceName: "add-image-256")
                imgViewUpHinhPBH.contentMode = .scaleToFill
                soViewLine.addSubview(imgViewUpHinhPBH)
                
                soViewLine.tag = num - 1
                let tapUpHinhVC = UITapGestureRecognizer(target: self, action: #selector(showVCUpHinh(_:)))
                soViewLine.isUserInteractionEnabled = true
                soViewLine.addGestureRecognizer(tapUpHinhVC)
            }
            
            soViewLine.frame = CGRect(x: soViewLine.frame.origin.x, y: soViewLine.frame.origin.y, width: soViewLine.frame.size.width, height: lbPriceProduct.frame.origin.y + lbPriceProduct.frame.size.height + Common.Size(s:5))
            line3.frame.size.height = soViewLine.frame.size.height
            
            indexHeight = indexHeight + soViewLine.frame.size.height
            indexY = indexY + soViewLine.frame.size.height + soViewLine.frame.origin.x
        }
        
        soViewPhone.frame.size.height = indexHeight
        
        
        let soViewPromos = UIView()
        soViewPromos.frame = CGRect(x: soViewPhone.frame.origin.x, y: soViewPhone.frame.origin.y + soViewPhone.frame.size.height + Common.Size(s:20), width: soViewPhone.frame.size.width, height: 0)
        viewInfoDetail.addSubview(soViewPromos)
        
        var promos:[ProductPromotions] = []
        var discountPay:Float = 0.0
        Cache.itemsPromotionTempVNPT.removeAll()
        
        for item in self.itemsPromotion{
            
            let it = item
            if (it.TienGiam <= 0){
                if (promos.count == 0){
                    promos.append(it)
                    Cache.itemsPromotionTempVNPT.append(item)
                }else{
                    for pro in promos {
                        if (pro.SanPham_Tang == it.SanPham_Tang && pro.SanPham_Mua == it.SanPham_Mua){
                            pro.SL_Tang =  pro.SL_Tang + item.SL_Tang
                        }else{
                            promos.append(it)
                            Cache.itemsPromotionTempVNPT.append(item)
                            break
                        }
                    }
                }
            }else{
                Cache.itemsPromotionTempVNPT.append(item)
                discountPay = discountPay + it.TienGiam
            }
        }
        
        if (promos.count>0){
            let lbSOPromos = UILabel(frame: CGRect(x: 0, y: 0, width: soViewPhone.frame.size.width, height: Common.Size(s:18)))
            lbSOPromos.textAlignment = .left
            lbSOPromos.textColor = UIColor(netHex:0x04AB6E)
            lbSOPromos.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbSOPromos.text = "THÔNG TIN KHUYẾN MÃI"
            soViewPromos.addSubview(lbSOPromos)
            
            let line1Promos = UIView(frame: CGRect(x: soViewPromos.frame.size.width * 1.3/10, y:lbSOPromos.frame.origin.y + lbSOPromos.frame.size.height + Common.Size(s:10), width: 1, height: Common.Size(s:25)))
            line1Promos.backgroundColor = UIColor(netHex:0x04AB6E)
            soViewPromos.addSubview(line1Promos)
            let line2Promos = UIView(frame: CGRect(x: 0, y:line1Promos.frame.origin.y + line1Promos.frame.size.height, width: soViewPromos.frame.size.width, height: 1))
            line2Promos.backgroundColor = UIColor(netHex:0x04AB6E)
            soViewPromos.addSubview(line2Promos)
            
            let lbSttPromos = UILabel(frame: CGRect(x: 0, y: line1Promos.frame.origin.y, width: line1Promos.frame.origin.x, height: line1Promos.frame.size.height))
            lbSttPromos.textAlignment = .center
            lbSttPromos.textColor = UIColor(netHex:0x04AB6E)
            lbSttPromos.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbSttPromos.text = "STT"
            soViewPromos.addSubview(lbSttPromos)
            
            let lbInfoPromos = UILabel(frame: CGRect(x: line1Promos.frame.origin.x, y: line1Promos.frame.origin.y, width: lbSOPromos.frame.size.width - line1Promos.frame.origin.x, height: line1Promos.frame.size.height))
            lbInfoPromos.textAlignment = .center
            lbInfoPromos.textColor = UIColor(netHex:0x04AB6E)
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
                line3.backgroundColor = UIColor(netHex:0x04AB6E)
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
                line4.backgroundColor = UIColor(netHex:0x04AB6E)
                soViewLine.addSubview(line4)
                
                let lbQuantityProduct = UILabel(frame: CGRect(x: lbNameProduct.frame.origin.x , y: lbNameProduct.frame.origin.y + lbNameProduct.frame.size.height + Common.Size(s:5), width: lbNameProduct.frame.size.width, height: Common.Size(s:16)))
                lbQuantityProduct.textAlignment = .left
                lbQuantityProduct.textColor = UIColor.black
                lbQuantityProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                
                lbQuantityProduct.numberOfLines = 1
                soViewLine.addSubview(lbQuantityProduct)
                
                if(item.is_imei == "Y"){
                    lbQuantityProduct.text = "IMEI:"
                }else{
                    lbQuantityProduct.text = "Số lượng: \((item.SL_Tang))"
                }
                listImei.append(lbQuantityProduct)
                
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
                
                soViewLine.tag = numPromos - 1
                let gestureSwift2AndHigher = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
                soViewLine.addGestureRecognizer(gestureSwift2AndHigher)
            }
            soViewPromos.frame.size.height = indexHeightPromos
        }
        
        let lbTotal = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: soViewPromos.frame.origin.y + soViewPromos.frame.size.height + Common.Size(s:20), width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbTotal.textAlignment = .left
        lbTotal.textColor = UIColor(netHex:0x04AB6E)
        lbTotal.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbTotal.text = "THÔNG TIN THANH TOÁN"
        viewInfoDetail.addSubview(lbTotal)
        
        let lbThanhTien = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: lbTotal.frame.origin.y + lbTotal.frame.size.height + Common.Size(s:10), width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbThanhTien.textAlignment = .left
        lbThanhTien.textColor = UIColor.black
        lbThanhTien.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbThanhTien.text = "Tổng đơn hàng:"
        viewInfoDetail.addSubview(lbThanhTien)
        
        let lbThanhTienValue = UILabel(frame: CGRect(x: lbThanhTien.frame.origin.x, y: lbThanhTien.frame.origin.y , width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbThanhTienValue.textAlignment = .right
        lbThanhTienValue.textColor = UIColor(netHex:0xEF4A40)
        lbThanhTienValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))
        viewInfoDetail.addSubview(lbThanhTienValue)
        lbThanhTienValue.text = Common.convertCurrency(value: totalPay)
        
        let lbDiscount = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: lbThanhTien.frame.origin.y + lbThanhTien.frame.size.height + Common.Size(s:5), width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
         lbDiscount.textAlignment = .left
         lbDiscount.textColor = UIColor.black
         lbDiscount.font = UIFont.systemFont(ofSize: Common.Size(s:16))
         lbDiscount.text = "Giảm giá:"
         viewInfoDetail.addSubview(lbDiscount)
         
         let lbDiscountValue = UILabel(frame: CGRect(x: lbDiscount.frame.origin.x, y: lbDiscount.frame.origin.y , width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
         lbDiscountValue.textAlignment = .right
         lbDiscountValue.textColor = UIColor(netHex:0xEF4A40)
         lbDiscountValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))
            viewInfoDetail.addSubview(lbDiscountValue)
        lbDiscountValue.text = Common.convertCurrency(value: Int(discountPay))
        
        
        let lbPayText = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: lbDiscount.frame.origin.y + lbDiscount.frame.size.height + Common.Size(s:5), width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbPayText.textAlignment = .left
        lbPayText.textColor = UIColor.black
        lbPayText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbPayText.text = "Tổng thanh toán:"
        viewInfoDetail.addSubview(lbPayText)
        
        let lbPayValue = UILabel(frame: CGRect(x: lbPayText.frame.origin.x, y: lbPayText.frame.origin.y , width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbPayValue.textAlignment = .right
        lbPayValue.textColor = UIColor(netHex:0xEF4A40)
        lbPayValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))

        lbPayValue.text = Common.convertCurrency(value: totalPay - Int(discountPay))
        
        viewInfoDetail.addSubview(lbPayValue)
        totalPayment = totalPay - Int(discountPay)
        
        let btPay = UIButton()
        btPay.frame = CGRect(x: tfUserEmail.frame.origin.x, y: lbPayValue.frame.origin.y + lbPayValue.frame.size.height + Common.Size(s:15), width: tfUserEmail.frame.size.width, height: tfUserEmail.frame.size.height * 1.2)
        btPay.backgroundColor = UIColor(netHex:0xD0021B)
        btPay.setTitle("THANH TOÁN", for: .normal)
        btPay.addTarget(self, action: #selector(actionPay), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        
        viewInfoDetail.addSubview(btPay)
        viewInfoDetail.frame.size.height = btPay.frame.origin.y + btPay.frame.size.height + Common.Size(s:20)
        scrollView.addSubview(viewInfoDetail)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetail.frame.origin.y + viewInfoDetail.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        //hide keyboard
        self.hideKeyboardWhenTappedAround()

    }
   @objc func someAction(_ sender:UITapGestureRecognizer){
        let view:UIView = sender.view!
        itemPromotion = promos[view.tag]
        self.lbImeiPro = listImei[view.tag]
        if(itemPromotion.is_imei == "Y"){
            loadImei()
        }
    }
    
    
    
    func loadImei(){
        let newViewController = LoadingViewController()
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.checkPromotionImeis(ItemCode: "\(itemPromotion.SanPham_Tang)", Whscode: "\(itemPromotion.KhoTang)") { (results, err) in
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(results.count > 0){
                    //loc imei
                    var arr:[String] = []
                    for item in results {
                        arr.append("\(item.DistNumber)")
                    }
                    if(arr.count == 1){
                        var check: Bool = true
                        for item in self.promos {
                            if (item.is_imei == "Y"){
                                if (item.imei != "N/A") && (item.imei == "\(String(describing: arr[0]))") {
                                    check = false
                                    break
                                }
                            }
                        }
                        if (check == true) {
                            self.itemPromotion.imei = arr[0]
                            self.lbImeiPro.text = "IMEI: \(self.itemPromotion.imei)"
                        }else{
                            // Prepare the popup
                            let title = "CHÚ Ý"
                            let message = "Bạn chọn IMEI máy KM bị trùng!"
                            
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
                    }else{
                        ActionSheetStringPicker.show(withTitle: "Chọn IMEI", rows: arr, initialSelection: 0, doneBlock: {
                            picker, value, index1 in
                            var check: Bool = true
                            for item in self.promos {
                                if (item.is_imei == "Y"){
                                    if (item.imei != "N/A") && (item.imei == "\(String(describing: arr[0]))") {
                                        check = false
                                        break
                                    }
                                }
                            }
                            if (check == true) {
                                self.itemPromotion.imei = arr[value]
                                self.lbImeiPro.text = "IMEI: \(self.itemPromotion.imei)"
                            }else{
                                // Prepare the popup
                                let title = "CHÚ Ý"
                                let message = "Bạn chọn IMEI máy KM bị trùng!"
                                
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
                            return
                        }, origin: self.view)
                    }
                    
                }else{
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        let alertController = UIAlertController(title: "HẾT HÀNG", message: "Sản phẩm khuyến mãi (\(self.itemPromotion.SanPham_Tang)) đã hết hàng tại shop!", preferredStyle: .alert)
                        
                        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                            //                            _ = self.navigationController?.popViewController(animated: true)
                            //                            self.dismiss(animated: true, completion: nil)
                            self.itemPromotion.imei = "N/A"
                            self.lbImeiPro.text = "IMEI: Hết tồn kho"
                        }
                        alertController.addAction(confirmAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
      @objc func actionPay(sender: UIButton!) {
            // skuList = ""
            for item in Cache.cartsVNPT {
                if(skuList == ""){
                    skuList = "\(item.product.sku)"
                }else{
                    skuList = "\(skuList),\(item.product.sku)"
                }
            }
            var voucher = ""
            if(Cache.listVoucherVNPT.count > 0){
                voucher = "<line>"
                for item in Cache.listVoucherVNPT{
                    voucher  = voucher + "<item voucher=\"\(item)\" />"
                }
                voucher = voucher + "</line>"
            }
            
            if (buttonSaveAction == false){

         
                
        
                let newViewController = LoadingViewController()
                newViewController.content = "Đang lưu đơn hàng..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                if(isConntectStatus != .notReachable){
                    
                    let rDR1 = parseXMLProduct().toBase64()
                    let pROMOS = parseXMLPromotion().toBase64()
               
               
              
                    MPOSAPIManager.mpos_sp_insert_order_vnpt(phone:"\(Cache.infoCMNDVNPT!.SDT)",cmnd: "\(Cache.infoCMNDVNPT!.CMND)", CardName: "\(Cache.infoCMNDVNPT!.TenKH)", U_EplCod: "\(Cache.user!.UserName)", ShopCode: "\(Cache.user!.ShopCode)", Sotientratruoc: "0", Doctype: "03", U_des: "", RDR1: rDR1, PROMOS: pROMOS, LoaiTraGop: "0", LaiSuat: "0", voucher: "", otp: "", NgayDenShopMua: "", HinhThucGH: "", DiaChi: "", magioithieu: "", kyhan: "0", Thanhtien: "\(self.totalPayment)", IDcardcode: "", HinhThucThuTien: "", soHDtragop: "", IsSkip: "", AuthenBy: "",chemecode: "",pre_docentry: "\(Cache.infoCMNDVNPT!.Docentry)", handler: { (returnCode, docentry, returnMessage)  in
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            //-----
                            
                            if (returnCode == 0){
                                Cache.itemsPromotionTempVNPT.removeAll()
                                Cache.cartsVNPT.removeAll()
                                Cache.listVoucherVNPT = []
                     
                                
                                let alert = UIAlertController(title: "Thông báo", message: returnMessage, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Upload hình ảnh KH", style: .cancel) { _ in
    //                                _ = self.navigationController?.popToRootViewController(animated: true)
    //                                self.dismiss(animated: true, completion: nil)
    //                                let nc = NotificationCenter.default
    //                                nc.post(name: Notification.Name("showDetailSO"), object: nil)
                                    
//                                    _ = self.navigationController?.popToRootViewController(animated: true)
//                                    self.dismiss(animated: true, completion: nil)
//                                    let nc = NotificationCenter.default
//                                    nc.post(name: Notification.Name("SearchCMNDMirae"), object: nil)
                                    let newViewController = UploadImageVNPTViewController()
                                    newViewController.docentry = "\(docentry)"
                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                })
                                self.present(alert, animated: true)
                            }else{
                                self.buttonSaveAction = false
                                let alert = UIAlertController(title: "Thông báo", message: "\(returnMessage) \r\n User: \(Cache.user!.UserName) \r\n ShopCode: \(Cache.user!.ShopCode)", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                                    
                                })
                                self.present(alert, animated: true)
                            }
                        }
                    })
                }else{
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                     
                        let alert = UIAlertController(title: "Thông báo", message: "Vui lòng kiểm tra lại kết nối mạng!", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                        self.buttonSaveAction = false
                    }
                }
            }
        }
    
    func parseXMLPromotion()->String{
         var rs:String = "<line>"
         for item in Cache.itemsPromotionVNPT {
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
         for item in Cache.cartsVNPT {
             var name = item.product.name
             name = name.replace(target: "&", withString:"&#38;")
             name = name.replace(target: "<", withString:"&#60;")
             name = name.replace(target: ">", withString:"&#62;")
             name = name.replace(target: "\"", withString:"&#34;")
             name = name.replace(target: "'", withString:"&#39;")
             
             if(item.imei == "N/A"){
                 item.imei = ""
             }
             
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
 


    
    func functionRemove(sender:UITapGestureRecognizer) {
        
        
        let alert = UIAlertController(title: "XOÁ ĐƠN HÀNG", message: "Bạn có chắc xoá đơn hàng \(self.docEntry) không?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in

                MPOSAPIManager.removeSO(docEntry: "\(self.docEntry)", handler: { (result, err) in
                    if(result == 1){
                        let alert = UIAlertController(title: "Thông báo", message: "Xoá đơn hàng \(self.docEntry) thành công", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                             self.dismiss(animated: true, completion: nil)
                        })
                        self.present(alert, animated: true)
                        
                       
                    }else if(result == 0){
                        let alertController = UIAlertController(title: "XOÁ ĐƠN HÀNG", message: err, preferredStyle: .alert)
                        
                        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                            
                        }
                        alertController.addAction(confirmAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }else{
                        let alertController = UIAlertController(title: "XOÁ ĐƠN HÀNG", message: "\(err)", preferredStyle: .alert)
                        
                        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                            
                        }
                        alertController.addAction(confirmAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                })
        })
        
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
        
    }
    
    func actionClose() {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func createRadioButton(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        //        radioButton.addTarget(self, action: #selector(PayViewController.logSelectedButton), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    fileprivate func createRadioButtonPayType(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        //        radioButton.addTarget(self, action: #selector(PayViewController.logSelectedButtonPayType), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    fileprivate func createRadioButtonPayInstallment(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        
        return radioButton;
    }
    fileprivate func createRadioButtonGender(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        //        radioButton.addTarget(self, action: #selector(PaymentViewController.logSelectedButtonGender), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    
    @objc func showVCUpHinh(_ sender: UITapGestureRecognizer) {
        
        let view:UIView = sender.view!
        let item = Cache.carts[view.tag]
        if item.product.p_matkinh == "Y" {
            let vc = UpImgProductSaleViewController()
            vc.itemCart = item
            vc.phoneNumber = self.phone
//            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

//extension ReadSODetailViewController: UpImgProductSaleViewControllerDelegate {
//    func getListURLImg(arrURLImg: [String]) {
//        self.arrURLImg = arrURLImg
//    }
//}

