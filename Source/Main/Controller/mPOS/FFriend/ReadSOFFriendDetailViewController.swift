//
//  ReadSOFFriendDetailViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/13/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import DLRadioButton
import PopupDialog
import DLRadioButton
class ReadSOFFriendDetailViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate{
    
    var carts:[Cart] = []
    var itemsPromotion: [ProductPromotions] = []
    var phone: String = ""
    var name: String = ""
    
    var scrollView:UIScrollView!
    var tfPhoneNumber:UITextField!
    var tfUserName:UITextField!
    
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
    
    var tfTotalSumMoney:UITextField!
    var tfMoneyBefore:UITextField!
    var  tfMoneyOfMonth:UITextField!
    var  tfDateDelivery:UITextField!
    var tfAddressDelivery:UITextField!
    var limitButton: SearchTextField!
    var typePayButton: SearchTextField!
    var tfOTP: UITextField!
    var tfCode: UITextField!
    
    var listHinhThucGiaoHangFFriend:[HinhThucGiaoHangFFriend]!
    var typeCode:String!
    
    var tienTraTruoc:Float = 0
   // var listLimit:[KyHan] = []
    var listLimit:[ScoringKyHan] = []
    var limitCode:String = "0"
    var sumMoney:Float = 0
    
    var radioPayNow:DLRadioButton!
    var radioPayNotNow:DLRadioButton!
    var orderPayType:Int = -1
    var viewInfoTypeShip:UIView!
    
    var btPay :UIButton!
    var lbInfoTypePayMore:UILabel!
    var skuList:String = ""
    
    var userSM:String = ""
    var passSM:String = ""
    var IsCheck = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Thanh toán"
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x47B054)
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        skuList = ""
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(ReadSOFFriendDetailViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        buttonSaveAction = false
        self.setupUI()
        
        
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    func actionOpenMenuLeft() {
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    func setupUI() {
        
        let lbUserInfo = UILabel(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:20)))
        lbUserInfo.textAlignment = .left
        lbUserInfo.textColor = UIColor(netHex:0x47B054)
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
        tfPhoneNumber.text = phone
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
        tfUserName.text = name
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
        
        viewInfoDetail = UIView(frame: CGRect(x: 0, y: tfUserName.frame.origin.y  + tfUserName.frame.size.height, width: self.view.frame.size.width, height: 0))
        
        let soViewPhone = UIView()
        viewInfoDetail.addSubview(soViewPhone)
        soViewPhone.frame = CGRect(x: tfUserName.frame.origin.x, y:  Common.Size(s:20), width: tfUserName.frame.size.width, height: 100)
        
        let lbSODetail = UILabel(frame: CGRect(x: 0, y: 0, width: soViewPhone.frame.size.width, height: Common.Size(s:20)))
        lbSODetail.textAlignment = .left
        lbSODetail.textColor = UIColor(netHex:0x47B054)
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
        }
        
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
                            break
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
        
        let lbTotal = UILabel(frame: CGRect(x: tfPhoneNumber.frame.origin.x, y: soViewPromos.frame.origin.y + soViewPromos.frame.size.height + Common.Size(s:20), width: tfPhoneNumber.frame.size.width, height: Common.Size(s:20)))
        lbTotal.textAlignment = .left
        lbTotal.textColor = UIColor(netHex:0x47B054)
        lbTotal.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbTotal.text = "THÔNG TIN THANH TOÁN"
        viewInfoDetail.addSubview(lbTotal)
        
        let lbTextTotalSumMoney = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbTotal.frame.size.height + lbTotal.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextTotalSumMoney.textAlignment = .left
        lbTextTotalSumMoney.textColor = UIColor.black
        lbTextTotalSumMoney.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTotalSumMoney.text = "Thành tiền"
        viewInfoDetail.addSubview(lbTextTotalSumMoney)
        
        tfTotalSumMoney = UITextField(frame: CGRect(x: Common.Size(s:20), y: lbTextTotalSumMoney.frame.origin.y + lbTextTotalSumMoney.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfTotalSumMoney.placeholder = "Thành tiền sau KM của đơn hàng"
        tfTotalSumMoney.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTotalSumMoney.borderStyle = UITextField.BorderStyle.roundedRect
        tfTotalSumMoney.autocorrectionType = UITextAutocorrectionType.no
        tfTotalSumMoney.keyboardType = UIKeyboardType.numberPad
        tfTotalSumMoney.returnKeyType = UIReturnKeyType.done
        tfTotalSumMoney.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfTotalSumMoney.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTotalSumMoney.delegate = self
        tfTotalSumMoney.textAlignment = .center
        viewInfoDetail.addSubview(tfTotalSumMoney)
        
        sumMoney = (totalPay - discountPay)
        
        tfTotalSumMoney.text = Common.convertCurrencyFloat(value: sumMoney)
        tfTotalSumMoney.isEnabled = false
        
        let lbTextMoneyBefore = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfTotalSumMoney.frame.size.height + tfTotalSumMoney.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lbTextMoneyBefore.textAlignment = .left
        lbTextMoneyBefore.textColor = UIColor.black
        lbTextMoneyBefore.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextMoneyBefore.text = "Số tiền trả trước"
        viewInfoDetail.addSubview(lbTextMoneyBefore)
        
        tfMoneyBefore = UITextField(frame: CGRect(x: Common.Size(s:20), y: lbTextMoneyBefore.frame.origin.y + lbTextMoneyBefore.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfMoneyBefore.placeholder = "Số tiền trả trước"
        tfMoneyBefore.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfMoneyBefore.borderStyle = UITextField.BorderStyle.roundedRect
        tfMoneyBefore.autocorrectionType = UITextAutocorrectionType.no
        tfMoneyBefore.keyboardType = UIKeyboardType.decimalPad
        tfMoneyBefore.returnKeyType = UIReturnKeyType.done
        tfMoneyBefore.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfMoneyBefore.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfMoneyBefore.delegate = self
        tfMoneyBefore.textAlignment = .center
        viewInfoDetail.addSubview(tfMoneyBefore)
        tfMoneyBefore.addTarget(self, action: #selector(textFieldDidChangeTF(_:)), for: .editingChanged)
        tfMoneyBefore.addTarget(self, action: #selector(checkMoney(_:)), for: .editingDidEnd)
        if (sumMoney > Cache.ocfdFFriend!.HanMucConLai){
            tienTraTruoc = sumMoney - Cache.ocfdFFriend!.HanMucConLai
            tfMoneyBefore.text = String(format: "%.0f", tienTraTruoc)
        }else{
            tienTraTruoc = 0
            tfMoneyBefore.text = "0"
        }
        
        //tilte choose type pay
        let  lbPayType = UILabel(frame: CGRect(x: tfMoneyBefore.frame.origin.x, y: tfMoneyBefore.frame.size.height + tfMoneyBefore.frame.origin.y + Common.Size(s:10) , width: tfMoneyBefore.frame.size.width, height: Common.Size(s:14)))
        lbPayType.textAlignment = .left
        lbPayType.textColor = UIColor.black
        lbPayType.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbPayType.text = "Hình thức thanh toán"
        viewInfoDetail.addSubview(lbPayType)
        
        radioPayNow = createRadioButtonPayType(CGRect(x: lbPayType.frame.origin.x,y:lbPayType.frame.origin.y + lbPayType.frame.size.height + Common.Size(s:5) , width: tfMoneyBefore.frame.size.width/2, height: Common.Size(s:40)), title: "Tiền mặt", color: UIColor.black);
        viewInfoDetail.addSubview(radioPayNow)
        
        radioPayNotNow = createRadioButtonPayType(CGRect(x: radioPayNow.frame.origin.x + radioPayNow.frame.size.width ,y:radioPayNow.frame.origin.y, width: radioPayNow.frame.size.width, height: radioPayNow.frame.size.height), title: "Khác", color: UIColor.black);
        viewInfoDetail.addSubview(radioPayNotNow)
        
        radioPayNow.isSelected = true
        orderPayType = 1
        
        
        
        let lbTextLimit = UILabel(frame: CGRect(x: Common.Size(s:20), y: radioPayNow.frame.size.height + radioPayNow.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lbTextLimit.textAlignment = .left
        lbTextLimit.textColor = UIColor.black
        lbTextLimit.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextLimit.text = "Kì hạn trả góp"
        viewInfoDetail.addSubview(lbTextLimit)
        
        limitButton = SearchTextField(frame: CGRect(x: lbTextLimit.frame.origin.x, y: lbTextLimit.frame.origin.y + lbTextLimit.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40) , height: Common.Size(s:40) ));
        
        limitButton.placeholder = "Chọn kì hạn"
        limitButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        limitButton.borderStyle = UITextField.BorderStyle.roundedRect
        limitButton.autocorrectionType = UITextAutocorrectionType.no
        limitButton.keyboardType = UIKeyboardType.default
        limitButton.returnKeyType = UIReturnKeyType.done
        limitButton.clearButtonMode = UITextField.ViewMode.whileEditing
        limitButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        limitButton.delegate = self
        viewInfoDetail.addSubview(limitButton)
        limitButton.startVisible = true
        limitButton.theme.bgColor = UIColor.white
        limitButton.theme.fontColor = UIColor.black
        limitButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        limitButton.theme.cellHeight = Common.Size(s:40)
        limitButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        limitButton.textAlignment = .center
        
        
        
        let lbTextMoneyOfMonth = UILabel(frame: CGRect(x: Common.Size(s:20), y: limitButton.frame.size.height + limitButton.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lbTextMoneyOfMonth.textAlignment = .left
        lbTextMoneyOfMonth.textColor = UIColor.black
        lbTextMoneyOfMonth.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextMoneyOfMonth.text = "Số tiền/tháng"
        viewInfoDetail.addSubview(lbTextMoneyOfMonth)
        
        tfMoneyOfMonth = UITextField(frame: CGRect(x: Common.Size(s:20), y: lbTextMoneyOfMonth.frame.origin.y + lbTextMoneyOfMonth.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfMoneyOfMonth.placeholder = "Số tiền/tháng"
        tfMoneyOfMonth.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfMoneyOfMonth.borderStyle = UITextField.BorderStyle.roundedRect
        tfMoneyOfMonth.autocorrectionType = UITextAutocorrectionType.no
        tfMoneyOfMonth.keyboardType = UIKeyboardType.numberPad
        tfMoneyOfMonth.returnKeyType = UIReturnKeyType.done
        tfMoneyOfMonth.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfMoneyOfMonth.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfMoneyOfMonth.delegate = self
        viewInfoDetail.addSubview(tfMoneyOfMonth)
        tfMoneyOfMonth.isEnabled = false
        tfMoneyOfMonth.textAlignment = .center
        
        let lbTextOTP = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfMoneyOfMonth.frame.size.height + tfMoneyOfMonth.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lbTextOTP.textAlignment = .left
        lbTextOTP.textColor = UIColor.black
        lbTextOTP.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextOTP.text = "Mã xác nhận OTP"
        viewInfoDetail.addSubview(lbTextOTP)
        
        tfOTP = UITextField(frame: CGRect(x: Common.Size(s:20), y: lbTextOTP.frame.origin.y + lbTextOTP.frame.size.height + Common.Size(s:5), width: (scrollView.frame.size.width * 2/3) - Common.Size(s:20) , height: Common.Size(s:40)));
        
        tfOTP.placeholder = "Nhập mã xác nhận OTP"
        tfOTP.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfOTP.borderStyle = UITextField.BorderStyle.roundedRect
        tfOTP.autocorrectionType = UITextAutocorrectionType.no
        tfOTP.keyboardType = UIKeyboardType.numberPad
        tfOTP.returnKeyType = UIReturnKeyType.done
        tfOTP.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfOTP.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfOTP.delegate = self
        viewInfoDetail.addSubview(tfOTP)
        
        let btSkipOTP = UIButton()
        btSkipOTP.frame = CGRect(x: tfOTP.frame.origin.x + tfOTP.frame.size.width + Common.Size(s: 5), y: tfOTP.frame.origin.y, width: (scrollView.frame.size.width/3) - Common.Size(s:25), height: 0)
        btSkipOTP.backgroundColor = UIColor(netHex:0xEF4A40)
        btSkipOTP.setTitle("Mã SM", for: .normal)
        btSkipOTP.addTarget(self, action: #selector(actionSM), for: .touchUpInside)
        btSkipOTP.layer.borderWidth = 0.5
        btSkipOTP.layer.borderColor = UIColor.white.cgColor
        btSkipOTP.layer.cornerRadius = 5.0
        btSkipOTP.clipsToBounds = true
        viewInfoDetail.addSubview(btSkipOTP)
        
        
        let lbTextCode = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfOTP.frame.size.height + tfOTP.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lbTextCode.textAlignment = .left
        lbTextCode.textColor = UIColor.black
        lbTextCode.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCode.text = "Mã giới thiệu mua hàng (nếu có)"
        viewInfoDetail.addSubview(lbTextCode)
        
        tfCode = UITextField(frame: CGRect(x: Common.Size(s:20), y: lbTextCode.frame.origin.y + lbTextCode.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfCode.placeholder = "Nhập mã giới thiệu mua hàng"
        tfCode.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCode.borderStyle = UITextField.BorderStyle.roundedRect
        tfCode.autocorrectionType = UITextAutocorrectionType.no
        tfCode.keyboardType = UIKeyboardType.default
        tfCode.returnKeyType = UIReturnKeyType.done
        tfCode.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfCode.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCode.delegate = self
        viewInfoDetail.addSubview(tfCode)
        
        let lbTextTypePay = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfCode.frame.size.height + tfCode.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:24)))
        lbTextTypePay.textAlignment = .left
        lbTextTypePay.textColor = UIColor.black
        lbTextTypePay.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTypePay.text = "Hình thức giao hàng"
        viewInfoDetail.addSubview(lbTextTypePay)
        
        lbInfoTypePayMore = UILabel(frame: CGRect(x: scrollView.frame.size.width/2, y: tfCode.frame.size.height + tfCode.frame.origin.y + Common.Size(s: 5), width: scrollView.frame.size.width/2 - Common.Size(s:15), height: Common.Size(s: 24)))
        lbInfoTypePayMore.textAlignment = .right
        lbInfoTypePayMore.textColor = UIColor(netHex:0x47B054)
        lbInfoTypePayMore.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Hiện chi tiết", attributes: underlineAttribute)
        lbInfoTypePayMore.attributedText = underlineAttributedString
        viewInfoDetail.addSubview(lbInfoTypePayMore)
        
        let tapShowDetailTypePay = UITapGestureRecognizer(target: self, action: #selector(ReadSOFFriendDetailViewController.tapShowDetailTypePay))
        lbInfoTypePayMore.isUserInteractionEnabled = true
        lbInfoTypePayMore.addGestureRecognizer(tapShowDetailTypePay)
        
        viewInfoTypeShip = UIView(frame: CGRect(x:0,y: lbTextTypePay.frame.origin.y + lbTextTypePay.frame.size.height,width:scrollView.frame.size.width, height: 0))
        viewInfoDetail.addSubview(viewInfoTypeShip)
        viewInfoTypeShip.clipsToBounds = true
        typePayButton = SearchTextField(frame: CGRect(x: lbTextLimit.frame.origin.x, y:0, width: scrollView.frame.size.width - Common.Size(s:40) , height: Common.Size(s:40) ));
        
        typePayButton.placeholder = "Chọn hình thức"
        typePayButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        typePayButton.borderStyle = UITextField.BorderStyle.roundedRect
        typePayButton.autocorrectionType = UITextAutocorrectionType.no
        typePayButton.keyboardType = UIKeyboardType.default
        typePayButton.returnKeyType = UIReturnKeyType.done
        typePayButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        typePayButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        typePayButton.delegate = self
        viewInfoTypeShip.addSubview(typePayButton)
        
        typePayButton.startVisible = true
        typePayButton.theme.bgColor = UIColor.white
        typePayButton.theme.fontColor = UIColor.black
        typePayButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        typePayButton.theme.cellHeight = Common.Size(s:40)
        typePayButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        let lbTextDateDelivery = UILabel(frame: CGRect(x: Common.Size(s:20), y: typePayButton.frame.size.height + typePayButton.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lbTextDateDelivery.textAlignment = .left
        lbTextDateDelivery.textColor = UIColor.black
        lbTextDateDelivery.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextDateDelivery.text = "Ngày giao hàng"
        viewInfoTypeShip.addSubview(lbTextDateDelivery)
        
        tfDateDelivery = UITextField(frame: CGRect(x: Common.Size(s:20), y: lbTextDateDelivery.frame.origin.y + lbTextDateDelivery.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfDateDelivery.placeholder = "Nhập ngày giao hàng"
        tfDateDelivery.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDateDelivery.borderStyle = UITextField.BorderStyle.roundedRect
        tfDateDelivery.autocorrectionType = UITextAutocorrectionType.no
        tfDateDelivery.keyboardType = UIKeyboardType.numberPad
        tfDateDelivery.returnKeyType = UIReturnKeyType.done
        tfDateDelivery.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfDateDelivery.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDateDelivery.delegate = self
        viewInfoTypeShip.addSubview(tfDateDelivery)
        
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let someDateTime = formatter.string(from: currentDate)
        tfDateDelivery.text = someDateTime
        
        let lbTextAddressDelivery = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfDateDelivery.frame.size.height + tfDateDelivery.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lbTextAddressDelivery.textAlignment = .left
        lbTextAddressDelivery.textColor = UIColor.black
        lbTextAddressDelivery.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextAddressDelivery.text = "Địa chỉ giao hàng"
        viewInfoTypeShip.addSubview(lbTextAddressDelivery)
        
        tfAddressDelivery = UITextField(frame: CGRect(x: Common.Size(s:20), y: lbTextAddressDelivery.frame.origin.y + lbTextAddressDelivery.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfAddressDelivery.placeholder = "Địa chỉ giao hàng"
        tfAddressDelivery.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfAddressDelivery.borderStyle = UITextField.BorderStyle.roundedRect
        tfAddressDelivery.autocorrectionType = UITextAutocorrectionType.no
        tfAddressDelivery.keyboardType = UIKeyboardType.default
        tfAddressDelivery.returnKeyType = UIReturnKeyType.done
        tfAddressDelivery.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfAddressDelivery.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfAddressDelivery.delegate = self
        viewInfoTypeShip.addSubview(tfAddressDelivery)
        
        //        viewInfoTypeShip.frame.size.height = tfAddressDelivery.frame.size.height + tfAddressDelivery.frame.origin.y
        
        btPay = UIButton()
        btPay.frame = CGRect(x: tfPhoneNumber.frame.origin.x, y: viewInfoTypeShip.frame.origin.y + viewInfoTypeShip.frame.size.height + Common.Size(s:20), width: tfPhoneNumber.frame.size.width, height: tfPhoneNumber.frame.size.height * 1.2)
        btPay.backgroundColor = UIColor(netHex:0xEF4A40)
        btPay.setTitle("Lưu đơn hàng", for: .normal)
        btPay.addTarget(self, action: #selector(actionPay), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        
        viewInfoDetail.addSubview(btPay)
        viewInfoDetail.frame.size.height = btPay.frame.origin.y + btPay.frame.size.height + Common.Size(s:20)
        scrollView.addSubview(viewInfoDetail)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetail.frame.origin.y + viewInfoDetail.frame.size.height + Common.Size(s: 20) + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        //((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        //hide keyboard
        self.hideKeyboardWhenTappedAround()

        
        typePayButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.typePayButton.text = item.title
            let obj =  self.listHinhThucGiaoHangFFriend.filter{ $0.Name == "\(item.title)" }.first
            if let code = obj?.ID {
                self.typeCode = "\(code)"
                if(code == 1){
                    self.tfAddressDelivery.text = "\(Cache.user!.ShopName)"
                }else if(code == 2){
                    self.tfAddressDelivery.text = "\(Cache.ocfdFFriend!.DiaChiDN)"
                }else if(code == 3){
                    self.tfAddressDelivery.text = ""
                }else{
                    self.tfAddressDelivery.text = ""
                }
            }
        }
        MPOSAPIManager.getHinhThucGiaoHangFFriend { (results, err) in
            if(err.count<=0){
                var listTypes: [String] = []
                self.listHinhThucGiaoHangFFriend = results
                for item in results {
                    listTypes.append("\(item.Name)")
                    if("\(item.ID)" == "1"){
                        self.typePayButton.text = "\(item.Name)"
                        self.typeCode = "\(item.ID)"
                        self.tfAddressDelivery.text = "\(Cache.user!.ShopName)"
                    }
                }
                self.typePayButton.filterStrings(listTypes)
            }else{
                
            }
        }
        limitButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.limitButton.text = item.title
            let obj =  self.listLimit.filter{ $0.KyHan == "\(item.title)" }.first
            let thang = obj?.ID
            if let code = obj?.ID {
                self.limitCode = "\(code)"
                let id = Float(code)
                var sum:Float = 0
                var traTruoc = self.tfMoneyBefore.text!
                if(traTruoc == ""){
                    traTruoc = "0"
                }
                if (id! > Float(0)){
                    sum = (self.sumMoney - Float(traTruoc)!) / id!
                }
                self.tfMoneyOfMonth.text = "\(Common.convertCurrency(value: sum.round()))"
            }
            //
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra kỳ hạn..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            
            MPOSAPIManager.sp_mpos_CheckHanMucKH(IdCardCode: "\(Cache.ocfdFFriend!.IDcardCode)", KyHan: "\(thang!)") { (result,message, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        if(result == 0){
                            self.limitButton.text  = ""
                             self.tfMoneyOfMonth.text = ""
                             self.limitCode = ""
//                            let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
//
//                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                            })
//                            self.present(alert, animated: true)
                            let popup = PopupDialog(title: "Thông báo", message: "\(message)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = DefaultButton(title: "Đóng") {
                                self.btPay.isEnabled = true
                                self.buttonSaveAction = false
                            }
                            let buttonTwo = DefaultButton(title: "Tạo mới UQTN") {
                                //chuyển về màn hình upload ủy quyền trích nợ đồng thời gọi api này trước khi chuyển                       màn hình nhé
                                MPOSAPIManager.sp_mpos_HuyCalllog_UQTN_HetHan(IDCardCode: "\(Cache.ocfdFFriend!.IDcardCode)", UserID: "\(Cache.user!.UserName)", DeviceType: "2", handler: { (resultCode, message,MsgUQTN, error) in
                                    if(MsgUQTN != ""){
                                        let title = "THÔNG BÁO"
                                        let message = MsgUQTN
                                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                            print("Completed")
                                        }
                                        let buttonOne = CancelButton(title: "OK") {
                                            let newViewController =  UploadUQTNViewController()
                                            newViewController.idCardCode = "\(Cache.ocfdFFriend!.IDcardCode)"
                                            newViewController.cmnd = "\(Cache.ocfdFFriend!.CMND)"
                                            newViewController.name = "\(Cache.ocfdFFriend!.CardName)"
                                            newViewController.nameBank = ""
                                            //
                                            self.navigationController?.pushViewController(newViewController, animated: true)
                                        }
                                        let buttonTwo = CancelButton(title: "Cancel") {
                                         
                                        }
                                  
                                        popup.addButtons([buttonOne,buttonTwo])
                                        self.present(popup, animated: true, completion: nil)
                                        
                                    }else{
                                        if resultCode == 1{
                                            
                                            let newViewController =  UploadUQTNViewController()
                                            newViewController.idCardCode = "\(Cache.ocfdFFriend!.IDcardCode)"
                                            newViewController.cmnd = "\(Cache.ocfdFFriend!.CMND)"
                                            newViewController.name = "\(Cache.ocfdFFriend!.CardName)"
                                            newViewController.nameBank = ""
                                            //
                                            self.navigationController?.pushViewController(newViewController, animated: true)
                                        }else {
                                            self.showDialog(message: message)
                                            self.buttonSaveAction = false
                                        }
                                    }
                                    
                                
                                })
                            }
                            popup.addButtons([buttonOne, buttonTwo])
                            self.present(popup, animated: true, completion: nil)
                        }
                    }
                }
                
            }
            //
        }
//        MPOSAPIManager.getVendorFFriend(LoaiDN: "\(Cache.ocfdFFriend!.LoaiKH)", handler: { (results, err) in
//            if(err.count<=0){
//                var listLimit: [String] = []
//
//                for item in results {
//
//                    if(item.ID == Cache.ocfdFFriend!.MaCongTy){
//                        self.listLimit = item.KyHanTra
//                        for it in item.KyHanTra {
//                            listLimit.append("\(it.kyHan)")
//                        }
//                        if(listLimit.count > 0){
//                            self.limitButton.text = item.KyHanTra[0].kyHan
//                            self.limitCode = item.KyHanTra[0].id
//
//                            let id = Float(item.KyHanTra[0].id)!
//                            var sum:Float = 0
//                            var traTruoc = self.tfMoneyBefore.text!
//                            if(traTruoc == ""){
//                                traTruoc = "0"
//                            }
//                            if (id > Float(0)){
//                                sum = (self.sumMoney - Float(traTruoc)!) / id
//                            }
//                            self.tfMoneyOfMonth.text = "\(Common.convertCurrency(value: sum.round()))"
//                        }
//                        break
//                    }
//                }
//                self.limitButton.filterStrings(listLimit)
//            }else{
//
//            }
//        })
        self.actionLoadKyHan()
        MPOSAPIManager.sp_mpos_CheckAccount_SkipOTP_ShopApDung { (result, err) in
            if(result == 1){
                btSkipOTP.frame.size.height = self.tfOTP.frame.size.height
            }
        }
    }
    func actionLoadKyHan(){
//        let newViewController = LoadingViewController()
//        newViewController.content = "Đang lấy kỳ hạn..."
//        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        self.navigationController?.present(newViewController, animated: true, completion: nil)
//        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.sp_mpos_Scoring_LoadKyHanTraGop(IDCardCode: "\(Cache.ocfdFFriend!.IDcardCode)") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
               // nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.listLimit = []
                    var listLimitString: [String] = []
                    self.listLimit = results
                    for item in results{
                        listLimitString.append(item.KyHan)
                    }
                    
//                    self.limitButton.text = self.listLimit[0].KyHan
//                    self.limitCode = "\(self.listLimit[0].ID)"
                    
//                    let id = Float(self.listLimit[0].ID)
//                    let thang = self.listLimit[0].ID
//                    var sum:Float = 0
//                    var traTruoc = self.tfMoneyBefore.text!
//                    if(traTruoc == ""){
//                        traTruoc = "0"
//                    }
//                    if (id > Float(0)){
//                        sum = (self.sumMoney - Float(traTruoc)!) / id
//                    }
               //     self.tfMoneyOfMonth.text = "\(Common.convertCurrency(value: sum.round()))"
                      self.limitButton.filterStrings(listLimitString)
                    //
//                    MPOSAPIManager.sp_mpos_CheckHanMucKH(IdCardCode: "\(Cache.ocfdFFriend!.IDcardCode)", KyHan: "\(thang)") { (result,message, err) in
//                        let when = DispatchTime.now() + 0.5
//                        DispatchQueue.main.asyncAfter(deadline: when) {
//                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
//                            if(err.count <= 0){
//                                if(result == 0){
//                                    self.tfMoneyOfMonth.text = ""
//                                    self.limitCode = ""
//                                    self.limitButton.text  = ""
//                                    self.tfMoneyOfMonth.text = ""
//                                    self.limitCode = ""
//                                    let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
//
//                                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                                    })
//                                    self.present(alert, animated: true)
//                                }
//                            }
//                        }
//
//                    }
                    //
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    @objc func actionSM(sender: UIButton!) {
        let alertController = UIAlertController(title: "Dùng mã SM", message: "Vui lòng nhập username và password của SM vào bên dưới!", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Xác nhận", style: .default) { (_) in
            self.userSM = (alertController.textFields?[0].text)!
            self.passSM = (alertController.textFields?[1].text)!
            
            if(!self.userSM.isEmpty && !self.passSM.isEmpty){
                MPOSAPIManager.CheckAccount_SkipOTP(UserID: self.userSM, PassWord: self.passSM, handler: { (result, message, err) in
                    if(err.count <= 0 ){
                        self.IsCheck = result
                        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            alertController.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                })
            }else{
                let alert = UIAlertController(title: "Thông báo", message: "Bạn phải nhập đủ thông tin!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Huỷ", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Nhập username"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Nhập password"
            textField.isSecureTextEntry = true
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tapShowDetailTypePay(sender:UITapGestureRecognizer) {
        print("tapShowDetailTypePay")
        if(viewInfoTypeShip.frame.size.height == 0){
            viewInfoTypeShip.frame.size.height = tfAddressDelivery.frame.size.height + tfAddressDelivery.frame.origin.y
            btPay.frame.origin.y = viewInfoTypeShip.frame.size.height + viewInfoTypeShip.frame.origin.y + Common.Size(s:20)
            viewInfoDetail.frame.size.height = btPay.frame.origin.y + btPay.frame.size.height + Common.Size(s:20)
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetail.frame.origin.y + viewInfoDetail.frame.size.height + Common.Size(s: 20) + (self.navigationController?.navigationBar.frame.size.height)!)
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString = NSAttributedString(string: "Ẩn chi tiết", attributes: underlineAttribute)
            lbInfoTypePayMore.attributedText = underlineAttributedString
            
            
        }else{
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString = NSAttributedString(string: "Hiện chi tiết", attributes: underlineAttribute)
            lbInfoTypePayMore.attributedText = underlineAttributedString
            viewInfoTypeShip.frame.size.height = 0
            btPay.frame.origin.y = viewInfoTypeShip.frame.size.height + viewInfoTypeShip.frame.origin.y + Common.Size(s:20)
            viewInfoDetail.frame.size.height = btPay.frame.origin.y + btPay.frame.size.height + Common.Size(s:20)
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetail.frame.origin.y + viewInfoDetail.frame.size.height + Common.Size(s: 20) + (self.navigationController?.navigationBar.frame.size.height)!)
        }
        
    }
    fileprivate func createRadioButtonPayType(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(logSelectedButtonPayType), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonPayType(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioPayNow.isSelected = false
            radioPayNotNow.isSelected = false
            switch temp {
            case "Tiền mặt":
                orderPayType = 1
                radioPayNow.isSelected = true
                break
            case "Khác":
                orderPayType = 2
                radioPayNotNow.isSelected = true
                break
            default:
                orderPayType = -1
                break
            }
        }
    }
    @objc func checkMoney(_ textField: UITextField) {
        
        var money = tfMoneyBefore.text!
        if(money == ""){
            money = "0"
        }
        if(self.tienTraTruoc > 0 && Float(money)! < self.tienTraTruoc){
            let title = "THÔNG BÁO"
            let popup = PopupDialog(title: title, message: "Số tiền khách hàng trả trước không được nhỏ hơn \(Common.convertCurrencyFloatV2(value: self.tienTraTruoc))", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            }
            let buttonOne = CancelButton(title: "OK") {
                self.tfMoneyBefore.text = String(format: "%.0f", self.tienTraTruoc)
                var sum:Float = 0
                if (Float(self.limitCode)! > Float(0)){
                    sum = (self.sumMoney - self.tienTraTruoc) / Float(self.limitCode)!
                }
                
                self.tfMoneyOfMonth.text = "\(Common.convertCurrency(value: sum.round()))"
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
    }
    @objc func textFieldDidChangeTF(_ textField: UITextField) {
        var money = textField.text!
        if(money == ""){
            money = "0"
        }
        var sum:Float = 0
        if (Float(limitCode)! > Float(0)){
            sum = (self.sumMoney - Float(money)!) / Float(limitCode)!
        }
        
        self.tfMoneyOfMonth.text = "\(Common.convertCurrency(value: sum.round()))"
    }
    @objc func actionPay(sender: UIButton!) {
       // skuList = ""
        for item in Cache.cartsFF {
            if(skuList == ""){
                skuList = "\(item.product.sku)"
            }else{
                skuList = "\(skuList),\(item.product.sku)"
            }
        }
        
        if (buttonSaveAction == false){
//            skuList = ""
//            for item in Cache.cartsFF {
//                if(skuList == ""){
//                    skuList = "\(item.product.sku)"
//                }else{
//                    skuList = "\(skuList),\(item.product.sku)"
//                }
//            }
            
            
            if(Cache.ocfdFFriend!.HanMucConLai <= 0 ){
                let title = "THÔNG BÁO"
                let popup = PopupDialog(title: title, message: "Khách hàng không có đủ hạn mức còn lại để tạo đơn hàng!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                }
                let buttonOne = CancelButton(title: "OK") {
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
                return
            }
            var traTruoc = self.tfMoneyBefore.text!
            if(traTruoc == ""){
                traTruoc = "0"
            }
            let iTraTruoc = Float(traTruoc)!
            
            if(self.tienTraTruoc > 0 && iTraTruoc < self.tienTraTruoc){
                let title = "THÔNG BÁO"
                let popup = PopupDialog(title: title, message: "Số tiền khách hàng trả trước không được nhỏ hơn \(Common.convertCurrencyFloatV2(value: self.tienTraTruoc))", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                }
                let buttonOne = CancelButton(title: "OK") {
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
                return
            }
            
            let otp = self.tfOTP.text!
            let datePay = self.tfDateDelivery.text!
            let address = self.tfAddressDelivery.text!
            let code = self.tfCode.text!
            
            if(otp == "" && IsCheck == 0){
                self.showDialog(message: "Bạn chưa nhập mã OTP")
                return
            }
            if (datePay.count > 0){
                if (!checkDate(stringDate: datePay)){
                    self.showDialog(message: "Ngày giao hàng sai định dạng!")
                    return
                }
            }else{
                self.showDialog(message: "Bạn chưa nhập ngày giao hàng!")
                return
            }
            if(address == ""){
                self.showDialog(message: "Bạn chưa nhập địa chỉ giao hàng")
                return
            }
            
            //            if (sumMoney > Cache.ocfdFFriend!.HanMucConLai){
            //               let check = sumMoney - Cache.ocfdFFriend!.HanMucConLai
            //                if (check > 0 && self.tienTraTruoc < check){
            //                    if(address == ""){
            //                        self.showDialog(message: "Bạn phải nhập số tiền trả trước")
            //                        return
            //                    }
            //                }
            //            }
//            if(self.limitCode == "0" ){
//                self.showDialog(message: "Bạn phải chọn kỳ hạ")
//                return
//            }
            if(sumMoney - self.tienTraTruoc <= 0 ){
                self.showDialog(message: "Số tiền trả trước lớn hơn tổng tiền")
                return
            }
            
            buttonSaveAction = true
            let newViewController = LoadingViewController()
            newViewController.content = "Đang lưu đơn hàng..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            if(isConntectStatus != .notReachable){
                
                let rDR1 = parseXMLProduct().toBase64()
                let pROMOS = parseXMLPromotion().toBase64()
                var hinhThucThuTien:String = "M"
                if(orderPayType == 1){
                    hinhThucThuTien = "M"
                }else{
                    hinhThucThuTien = "O"
                }
                var AuthenBy = ""
                if(IsCheck == 1){
                    AuthenBy = self.userSM
                }
                MPOSAPIManager.mpos_sp_insert_order_ffriend(cmnd: "\(Cache.ocfdFFriend!.CMND)", CardName: "\(Cache.ocfdFFriend!.CardName)", U_EplCod: "\(Cache.user!.UserName)", ShopCode: "\(Cache.user!.ShopCode)", Sotientratruoc: "\(String(format:"%.2f", iTraTruoc))", Doctype: "\(Cache.typeOrder)", U_des: "", RDR1: rDR1, PROMOS: pROMOS, LoaiTraGop: "0", LaiSuat: "0", voucher: "", otp: otp, NgayDenShopMua: datePay, HinhThucGH: "\(self.typeCode!)", DiaChi: "\(address)", magioithieu: code, kyhan: "\(self.limitCode)", Thanhtien: "\(String(format:"%.2f", sumMoney))", IDcardcode: "\(Cache.ocfdFFriend!.IDcardCode)", HinhThucThuTien: "\(hinhThucThuTien)", ListSP: "\(skuList)", IsSkip: "\(IsCheck)", AuthenBy: "\(AuthenBy)",TransactionID:Cache.ocfdFFriend!.TransactionID,p_docentry: "\(Cache.depositEcomNumFF)", handler: { (results,IdFinal,IdFromDK,IsExpired_CL_UQTN, err)  in
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        //-----
                        if IsExpired_CL_UQTN == "1"{
                            //hien popup dong& tao moi UQTN
                            let popup = PopupDialog(title: "Thông báo", message: "\(err)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = DefaultButton(title: "Đóng") {
                                self.btPay.isEnabled = true
                                self.buttonSaveAction = false
                            }
                            let buttonTwo = DefaultButton(title: "Tạo mới UQTN") {
                                //chuyển về màn hình upload ủy quyền trích nợ đồng thời gọi api này trước khi chuyển                       màn hình nhé
                                MPOSAPIManager.sp_mpos_HuyCalllog_UQTN_HetHan(IDCardCode: "\(Cache.ocfdFFriend!.IDcardCode)", UserID: "\(Cache.user!.UserName)", DeviceType: "2", handler: { (resultCode, message,MsgUQTN, error) in
                                    
                                    if resultCode == 1{
                                        
                                        let newViewController =  UploadUQTNViewController()
                                        newViewController.idCardCode = "\(Cache.ocfdFFriend!.IDcardCode)"
                                        newViewController.cmnd = "\(Cache.ocfdFFriend!.CMND)"
                                        newViewController.name = "\(Cache.ocfdFFriend!.CardName)"
                                        newViewController.nameBank = ""
                                        //
                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                    }else {
                                        self.showDialog(message: message)
                                        self.buttonSaveAction = false
                                    }
                                })
                            }
                            popup.addButtons([buttonOne, buttonTwo])
                            self.present(popup, animated: true, completion: nil)
//                            self.buttonSaveAction = true
                            
                        }else {// IsExpired_CL_UQTN == "0"
                            
                            
                            if(results == "true"){
                                
                                if("\(self.typeCode!)" != "1"){
                                    // Prepare the popup
                                    let title = "THÔNG BÁO"
                                    let message = "Lưu đơn hàng thành công.\r\nBạn có muốn in phiếu đăng ký không?"
                                    
                                    // Create the dialog
                                    let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        print("Completed")
                                    }
                                    
                                    // Create first button
                                    let buttonOne = DefaultButton(title: "In ấn") {
                                        let newViewController1 = LoadingViewController()
                                        newViewController1.content = "Đang in UQTN..."
                                        newViewController1.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                                        newViewController1.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                                        self.navigationController?.present(newViewController1, animated: true, completion: nil)
                                        let nc = NotificationCenter.default
                                        MPOSAPIManager.mpos_sp_PrintPhieuDKPOS(IDCardCode: "\(Cache.ocfdFFriend!.IDcardCode)", UserID: "\(Cache.user!.UserName)", ID_Final: "\(results)", handler: { (success, err) in
                                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                            let when = DispatchTime.now() + 0.5
                                            DispatchQueue.main.asyncAfter(deadline: when) {
                                                if(err.count <= 0 ){
                                                    self.buttonSaveAction = false
                                                    let newViewController = UploadImageFFriendViewController()
                                                    newViewController.traTruoc = "\(Common.convertCurrencyFloat(value: iTraTruoc))"
                                                    newViewController.tongDonHang = "\(Common.convertCurrencyFloat(value: self.sumMoney))"
                                                    newViewController.conLai = "\(Common.convertCurrencyFloat(value: self.sumMoney-iTraTruoc))"
//                                                    newViewController.idFinal = "\(results)"
                                                    newViewController.idFinal = "\(IdFinal)"
                                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                                }else{
                                                    let title = "THÔNG BÁO"
                                                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                        print("Completed")
                                                    }
                                                    
                                                    let buttonOne = CancelButton(title: "OK") {
                                                        self.buttonSaveAction = false
                                                        let newViewController = UploadImageFFriendViewController()
                                                        newViewController.traTruoc = "\(Common.convertCurrencyFloat(value: iTraTruoc))"
                                                        newViewController.tongDonHang = "\(Common.convertCurrencyFloat(value: self.sumMoney))"
                                                        newViewController.conLai = "\(Common.convertCurrencyFloat(value: self.sumMoney-iTraTruoc))"
//                                                        newViewController.idFinal = "\(results)"
                                                        newViewController.idFinal = "\(IdFinal)"
                                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                                    }
                                                    popup.addButtons([buttonOne])
                                                    self.present(popup, animated: true, completion: nil)
                                                }
                                                
                                            }
                                        })
                                        
                                    }
                                    // Create first button
                                    let buttonTwo = CancelButton(title: "Bỏ qua") {
                                        self.buttonSaveAction = false
                                        let newViewController = UploadImageFFriendViewController()
                                        newViewController.traTruoc = "\(Common.convertCurrencyFloat(value: iTraTruoc))"
                                        newViewController.tongDonHang = "\(Common.convertCurrencyFloat(value: self.sumMoney))"
                                        newViewController.conLai = "\(Common.convertCurrencyFloat(value: self.sumMoney-iTraTruoc))"
//                                        newViewController.idFinal = "\(results)"
                                        newViewController.idFinal = "\(IdFinal)"
                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                    }
                                    // Add buttons to dialog
                                    popup.addButtons([buttonOne,buttonTwo])
                                    
                                    // Present dialog
                                    self.present(popup, animated: true, completion: nil)
                                }else{
                                    
                                    self.buttonSaveAction = false
                                    let newViewController = UploadImageFFriendViewController()
                                    newViewController.traTruoc = "\(Common.convertCurrencyFloat(value: iTraTruoc))"
                                    newViewController.tongDonHang = "\(Common.convertCurrencyFloat(value: self.sumMoney))"
                                    newViewController.conLai = "\(Common.convertCurrencyFloat(value: self.sumMoney-iTraTruoc))"
//                                    newViewController.idFinal = "\(results)"
                                    newViewController.idFinal = "\(IdFinal)"
                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                    
                                    self.showDialog(message: "Lưu đơn hàng thành công")
                                }
                                Cache.itemsPromotionTempFF.removeAll()
                                Cache.cartsFF.removeAll()
                                Cache.depositEcomNumFF = ""
                                
                                _ = self.navigationController?.popToRootViewController(animated: true)
                                self.dismiss(animated: true, completion: nil)
                                
                                let myDict = ["CMND": ""]
                                let nc = NotificationCenter.default
                                nc.post(name: Notification.Name("AutoLoadCMND"), object: myDict)
                                
                                
                            }else{
                                //
                                self.buttonSaveAction = false
                                
                                //Cache.itemsPromotionTempFF.removeAll()
                                //Cache.cartsFF.removeAll()
                                self.showDialog(message: err)
                            }
                        }
                    }
                })
            }else{
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.showDialog(message: "Vui lòng kiểm tra lại kết nối mạng!")
                    self.buttonSaveAction = false
                }
            }
        }
    }
    func checkDate(stringDate:String) -> Bool{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yyyy"
        
        if let _ = dateFormatterGet.date(from: stringDate) {
            return true
        } else {
            return false
        }
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
    
    
    func actionClose() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
}

