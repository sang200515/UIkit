//
//  DetailSOFFriendViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import DLRadioButton
import PopupDialog
import ActionSheetPicker_3_0
class DetailSOFFriendViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate{
    
    var historyFFriend:HistoryFFriend?
    var ocfdFFriend:OCRDFFriend?
    
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
    var listLimit:[KyHan] = []
    var limitCode:String = "0"
    var sumMoney:Float = 0
    
    var radioPayNow:DLRadioButton!
    var radioPayNotNow:DLRadioButton!
    var orderPayType:Int = -1
    var viewInfoTypeShip:UIView!
    
    var btPay,btUploadImgeDoiTra:UIButton!
    var lbInfoTypePayMore:UILabel!
    var lbImei: UILabel!
    var lineProduct: [LineProduct] = []
    
    var itemProduct:LineProduct!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chi tiết"
        self.view.backgroundColor = .white
        listImei = []
        lineProduct = []
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang load dữ liệu..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.getSODetailsFF(docEntry: "\((historyFFriend?.SOmPOS)!)") { (soDetail, String) in
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(soDetail != nil){
                    self.setupUI(soDetail: soDetail!)
                }
                
            }
        }
    }
    func setupUI(soDetail:SODetail) {
        lineProduct = soDetail.lineProduct!
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
        tfPhoneNumber.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhoneNumber.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhoneNumber.delegate = self
        tfPhoneNumber.text = "\(self.ocfdFFriend!.SDT)"
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
        tfUserName.clearButtonMode = UITextField.ViewMode.whileEditing
        tfUserName.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfUserName.delegate = self
        tfUserName.text = "\(self.ocfdFFriend!.CardName)"
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
        var sumSO:Float = 0.0
        var sumDiscount:Float = 0.0
        for item in soDetail.lineProduct!{
            num = num + 1
            sumSO = sumSO + (item.LineTotal)
            sumDiscount = sumDiscount + item.U_DisOther
            let soViewLine = UIView()
            soViewPhone.addSubview(soViewLine)
            soViewLine.frame = CGRect(x: 0, y: indexY, width: soViewPhone.frame.size.width, height: 50)
            let line3 = UIView(frame: CGRect(x: line1.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
            line3.backgroundColor = UIColor(netHex:0x47B054)
            soViewLine.addSubview(line3)
            
            let nameProduct = "\((item.Dscription))"
            let sizeNameProduct = nameProduct.height(withConstrainedWidth: soViewPhone.frame.size.width - line3.frame.origin.x, font: UIFont.systemFont(ofSize:  Common.Size(s:14)))
            let lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x +  Common.Size(s:5), y: 3, width: soViewPhone.frame.size.width - line3.frame.origin.x, height: sizeNameProduct))
            lbNameProduct.textAlignment = .left
            lbNameProduct.textColor = UIColor.black
            lbNameProduct.font = UIFont.systemFont(ofSize:  Common.Size(s:14))
            lbNameProduct.text = nameProduct
            lbNameProduct.numberOfLines = 3
            soViewLine.addSubview(lbNameProduct)
            
            let line4 = UIView(frame: CGRect(x: line3.frame.origin.x, y:0, width: soViewPhone.frame.size.width - line3.frame.origin.x - 1, height: 1))
            line4.backgroundColor = UIColor(netHex:0x47B054)
            soViewLine.addSubview(line4)
            
            let lbQuantityProduct = UILabel(frame: CGRect(x: lbNameProduct.frame.origin.x , y: lbNameProduct.frame.origin.y + lbNameProduct.frame.size.height +  Common.Size(s:5), width: lbNameProduct.frame.size.width, height:  Common.Size(s:14)))
            lbQuantityProduct.textAlignment = .left
            lbQuantityProduct.textColor = UIColor.black
            lbQuantityProduct.font = UIFont.systemFont(ofSize:  Common.Size(s:14))
            print("item.U_Imei \(item.U_Imei)")
            if (item.QLImei == "Y"){
                lbQuantityProduct.text = "IMEI: \((item.U_Imei))"
            }else{
                lbQuantityProduct.text = "Số lượng: \((item.Quantity))"
            }
            
            //            if (item.product.qlSerial == "Y"){
            //                lbQuantityProduct.text = "IMEI: \((item.imei))"
            //            }else{
            //                lbQuantityProduct.text = "Số lượng: \((item.quantity))"
            //            }
            listImei.append(lbQuantityProduct)
            
            lbQuantityProduct.numberOfLines = 1
            soViewLine.addSubview(lbQuantityProduct)
            
            let lbPriceProduct = UILabel(frame: CGRect(x: lbQuantityProduct.frame.origin.x , y: lbQuantityProduct.frame.origin.y + lbQuantityProduct.frame.size.height +  Common.Size(s:5), width: lbQuantityProduct.frame.size.width, height:  Common.Size(s:14)))
            lbPriceProduct.textAlignment = .left
            lbPriceProduct.textColor = UIColor(netHex:0xEF4A40)
            lbPriceProduct.font = UIFont.systemFont(ofSize:  Common.Size(s:14))
            lbPriceProduct.text = "Giá: \(Common.convertCurrencyFloat(value: (item.LineTotal + item.U_DisOther) /  Float(item.Quantity)))"
            lbPriceProduct.numberOfLines = 1
            soViewLine.addSubview(lbPriceProduct)
            
            
            let lbSttValue = UILabel(frame: CGRect(x: 0, y: 0, width: lbStt.frame.size.width, height: lbStt.frame.size.height))
            lbSttValue.textAlignment = .center
            lbSttValue.textColor = UIColor.black
            lbSttValue.font = UIFont.systemFont(ofSize:  Common.Size(s:14))
            lbSttValue.text = "\(num)"
            soViewLine.addSubview(lbSttValue)
            
            soViewLine.frame = CGRect(x: soViewLine.frame.origin.x, y: soViewLine.frame.origin.y, width: soViewLine.frame.size.width, height: lbPriceProduct.frame.origin.y + lbPriceProduct.frame.size.height +  Common.Size(s:5))
            line3.frame.size.height = soViewLine.frame.size.height
            
            indexHeight = indexHeight + soViewLine.frame.size.height
            indexY = indexY + soViewLine.frame.size.height + soViewLine.frame.origin.x
            
            soViewLine.tag = num - 1
            let gestureSwift2AndHigher = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
            soViewLine.addGestureRecognizer(gestureSwift2AndHigher)
        }
        soViewPhone.frame.size.height = indexHeight
        
        
        let soViewPromos = UIView()
        soViewPromos.frame = CGRect(x: soViewPhone.frame.origin.x, y: soViewPhone.frame.origin.y + soViewPhone.frame.size.height + Common.Size(s:20), width: soViewPhone.frame.size.width, height: 0)
        viewInfoDetail.addSubview(soViewPromos)
        
        var promos:[LinePromos] = []
        var sumPromos:Float = 0.0
        for item in soDetail.linePromos!{
            if (item.TienGiam <= 0){
                if (promos.count == 0){
                    promos.append(item)
                }else{
                    for pro in promos {
                        if (pro.SanPham_Tang == item.SanPham_Tang){
                            pro.SL_Tang =  pro.SL_Tang + item.SL_Tang
                        }else{
                            promos.append(item)
                        }
                    }
                }
            }else{
                sumPromos = sumPromos + item.TienGiam
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
        tfTotalSumMoney.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTotalSumMoney.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTotalSumMoney.delegate = self
        tfTotalSumMoney.textAlignment = .center
        viewInfoDetail.addSubview(tfTotalSumMoney)
        
        //         sumMoney = (totalPay - discountPay)
        
        tfTotalSumMoney.text = Common.convertCurrencyFloat(value: self.historyFFriend!.ThanhTien)
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
        tfMoneyBefore.clearButtonMode = UITextField.ViewMode.whileEditing
        tfMoneyBefore.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfMoneyBefore.delegate = self
        tfMoneyBefore.textAlignment = .center
        viewInfoDetail.addSubview(tfMoneyBefore)
        tfMoneyBefore.isEnabled = false
        tfMoneyBefore.text = Common.convertCurrencyFloat(value: self.historyFFriend!.SoTienTraTruoc)
        
        
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
        
        
        if(self.historyFFriend!.HinhThucThuTien == "M"){
            radioPayNow.isSelected = true
            orderPayType = 1
            radioPayNotNow.isEnabled = false
        }else{
            radioPayNotNow.isSelected = true
            orderPayType = 2
            radioPayNow.isEnabled = false
        }
        
        
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
        
        limitButton.text =  "\(self.historyFFriend!.KyHan) tháng"
        limitButton.isEnabled = false
        
        
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
        tfMoneyOfMonth.clearButtonMode = UITextField.ViewMode.whileEditing
        tfMoneyOfMonth.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfMoneyOfMonth.delegate = self
        viewInfoDetail.addSubview(tfMoneyOfMonth)
        tfMoneyOfMonth.isEnabled = false
        tfMoneyOfMonth.textAlignment = .center
        tfMoneyOfMonth.text = Common.convertCurrencyFloat(value: self.historyFFriend!.SoTienThanhToanHangThang.rounded(.awayFromZero))
        
        
        btPay = UIButton()
        btPay.frame = CGRect(x: tfMoneyOfMonth.frame.origin.x, y: tfMoneyOfMonth.frame.origin.y + tfMoneyOfMonth.frame.size.height + Common.Size(s:20), width: tfPhoneNumber.frame.size.width, height: tfPhoneNumber.frame.size.height * 1.2)
        btPay.backgroundColor = UIColor(netHex:0xEF4A40)
        btPay.addTarget(self, action: #selector(actionPay), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        
        //        if(self.historyFFriend!.Ecom == 1){
        //            btPay.setTitle("Upload PĐK", for: .normal)
        //        }else{
        //
        //        }
        
        viewInfoDetail.addSubview(btPay)
        //        viewInfoDetail.backgroundColor = .red
        
        
        
        
        //                if(self.historyFFriend!.Flag == "0,0,0,0"){
        //                    btPay.clipsToBounds = true
        //                    btPay.frame.size.height = 0
        //                }
        
        //        if(self.historyFFriend!.Flag_Ecom == 1){
        //            if(self.historyFFriend!.Flag == "0,0,0,0"){
        //                btPay.setTitle("Cập nhật IMEI", for: .normal)
        //            }else{
        //                btPay.setTitle("Upload PĐK & Update IMEI", for: .normal)
        //            }
        //        }else{
        //            if(self.historyFFriend!.Flag == "0,0,0,0"){
        //                btPay.clipsToBounds = true
        //                btPay.frame.size.height = 0
        //                btPay.setTitle("Upload PĐK", for: .normal)
        //            }else{
        //                                btPay.clipsToBounds = true
        //                                btPay.frame.size.height = 0
        //            }
        //        }
        if(self.historyFFriend!.Flag_Ecom == 0 || self.historyFFriend!.Flag_Ecom == 1){
            if(self.historyFFriend!.Flag == "0,0,0,0"){
                btPay.clipsToBounds = true
                btPay.frame.size.height = 0
            }
            btPay.setTitle("Upload PĐK", for: .normal)
        }else{
            btPay.setTitle("Cập nhật IMEI", for: .normal)
            if(self.historyFFriend!.Flag == "0,0,0,0"){
                //                btPay.clipsToBounds = true
                //                btPay.frame.size.height = 0
            }else{
                btPay.setTitle("Upload PĐK & Update IMEI", for: .normal)
            }
        }
        
        btUploadImgeDoiTra = UIButton()
        btUploadImgeDoiTra.frame = CGRect(x: tfMoneyOfMonth.frame.origin.x, y: btPay.frame.origin.y + btPay.frame.size.height + Common.Size(s:20), width: tfPhoneNumber.frame.size.width, height: tfPhoneNumber.frame.size.height * 1.2)
        btUploadImgeDoiTra.backgroundColor = UIColor(netHex:0xEF4A40)
        btUploadImgeDoiTra.addTarget(self, action: #selector(actionUploadCTDoiTra), for: .touchUpInside)
        btUploadImgeDoiTra.layer.borderWidth = 0.5
        btUploadImgeDoiTra.layer.borderColor = UIColor.white.cgColor
        btUploadImgeDoiTra.layer.cornerRadius = 5.0
        viewInfoDetail.addSubview(btUploadImgeDoiTra)
        btUploadImgeDoiTra.setTitle("Upload CT đổi trả", for: .normal)
        if(self.historyFFriend!.Flag_Image_ChungTuDoiTra == 0){
            btUploadImgeDoiTra.frame.size.height = 0
        }
        
        viewInfoDetail.frame.size.height = btUploadImgeDoiTra.frame.origin.y + btUploadImgeDoiTra.frame.size.height + Common.Size(s:20)
        scrollView.addSubview(viewInfoDetail)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetail.frame.origin.y + viewInfoDetail.frame.size.height + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        //((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        //hide keyboard
        self.hideKeyboardWhenTappedAround()

    }
    @objc func someAction(_ sender:UITapGestureRecognizer){
        // do other task
        let view:UIView = sender.view!
        self.lbImei = listImei[view.tag]
        self.itemProduct = lineProduct[view.tag]
        
        if (self.itemProduct.QLImei == "Y"){
            if(self.itemProduct.MaShop == "\(Cache.user!.ShopCode)"){
                loadImei()
            }else{
                let popup = PopupDialog(title: "THÔNG BÁO", message: "Đơn hàng Ecom đẩy về cho shop \(self.itemProduct.MaShop). Bạn không thuộc nhân viên shop nên không được phép cập nhật Imei trên đơn hàng.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
    }
    
    func loadImei(){
        let newViewController = LoadingViewController()
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(newViewController, animated: true, completion: nil)
        
        MPOSAPIManager.getImeiFF(productCode: "\(self.itemProduct.ItemCode)", shopCode: "\(Cache.user!.ShopCode)") { (result, err) in
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
                        for item in Cache.carts {
                            if (item.product.qlSerial == "Y"){
                                if item.imei == "\(String(describing: arr[0]))" {
                                    check = false
                                    break
                                }
                            }
                        }
                        if (check == true) {
                            self.itemProduct.U_Imei = arr[0]
                            self.itemProduct.WhsCode = whsCodes[0]
                            self.lbImei.text = "IMEI: \(self.itemProduct.U_Imei)"
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
                            for item in Cache.carts {
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
                                
                                self.itemProduct.U_Imei = arr[value]
                                self.itemProduct.WhsCode = whsCodes[value]
                                self.lbImei.text = "IMEI: \(self.itemProduct.U_Imei)"
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
                        //                        _ = self.navigationController?.popViewController(animated: true)
                        //                        self.dismiss(animated: true, completion: nil)
                    }
                    alertController.addAction(confirmAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    @objc func actionUploadCTDoiTra(sender: UIButton!) {
        let viewController = UploadChungTuDoiTraViewController()
        viewController.IDFinal = historyFFriend!.ID_Final
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    @objc func actionPay(sender: UIButton!) {
        var imei = ""
        var itemcode = ""
        var check = true
        for item in self.lineProduct{
            if(item.QLImei == "Y" && item.U_Imei == ""){
                check = false
            }
            if(item.QLImei == "Y" && item.U_Imei != ""){
                imei = item.U_Imei
                itemcode = item.ItemCode
            }
        }
        if(!check){
            let alertController = UIAlertController(title: "Thông báo", message: "Bạn phải chọn Imei sản phẩm!", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "Đồng ý", style: .default) { (_) in
            }
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if(self.historyFFriend!.Flag_Ecom == 0 || self.historyFFriend!.Flag_Ecom == 1){
            self.uploadPDK()
        }else{
            
            if(self.historyFFriend!.Flag == "0,0,0,0"){
                let newViewController1 = LoadingViewController()
                newViewController1.content = "Đang cập nhật IMEI sản phẩm..."
                newViewController1.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController1.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController1, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                MPOSAPIManager.mpos_sp_calllog_UpdateImei_Ecom(UserID: "\(Cache.user!.UserName)", Imei: imei, Itemcode: itemcode, IDFinal: "\(self.historyFFriend!.ID_Final)", handler: { (success, result, error) in
                    
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        if(error.count <= 0){
                            let title = "THÔNG BÁO"
                            let popup = PopupDialog(title: title, message: success, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                _ = self.navigationController?.popViewController(animated: true)
                                self.dismiss(animated: true, completion: nil)
                            }
                            let buttonOne = DefaultButton(title: "OK") {}
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }else{
                            let title = "THÔNG BÁO"
                            let popup = PopupDialog(title: title, message: error, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = DefaultButton(title: "OK") {}
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    }
                })
            }else{
                let newViewController1 = LoadingViewController()
                newViewController1.content = "Đang cập nhật IMEI sản phẩm..."
                newViewController1.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController1.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController1, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                MPOSAPIManager.mpos_sp_calllog_UpdateImei_Ecom(UserID: "\(Cache.user!.UserName)", Imei: imei, Itemcode: itemcode, IDFinal: "\(self.historyFFriend!.ID_Final)", handler: { (success, result, error) in
                    
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        if(error.count <= 0){
                            self.uploadPDK()
                        }else{
                            let title = "THÔNG BÁO"
                            let popup = PopupDialog(title: title, message: error, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = DefaultButton(title: "OK") {}
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    }
                })
            }
            
            
        }
        
        //        if(self.historyFFriend!.Flag_Ecom == 1){
        //            if(self.historyFFriend!.Flag == "0,0,0,0"){
        //
        //
        //            }else{
        //
        //                let newViewController1 = LoadingViewController()
        //                newViewController1.content = "Đang cập nhật IMEI sản phẩm..."
        //                newViewController1.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        //                newViewController1.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        //                self.navigationController?.present(newViewController1, animated: true, completion: nil)
        //                let nc = NotificationCenter.default
        //
        //                MPOSAPIManager.mpos_sp_calllog_UpdateImei_Ecom(UserID: "\(Cache.User!.UserName)", Imei: imei, Itemcode: itemcode, IDFinal: "\(self.historyFFriend!.ID_Final)", handler: { (success, result, error) in
        //
        //                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
        //                    let when = DispatchTime.now() + 1
        //                    DispatchQueue.main.asyncAfter(deadline: when) {
        //                        if(error.count <= 0){
        //                            self.uploadPDK()
        //                        }else{
        //                            let title = "THÔNG BÁO"
        //                            let popup = PopupDialog(title: title, message: error, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
        //                                print("Completed")
        //                            }
        //                            let buttonOne = DefaultButton(title: "OK") {}
        //                            popup.addButtons([buttonOne])
        //                            self.present(popup, animated: true, completion: nil)
        //                        }
        //                    }
        //                })
        //
        //            }
        //        }else{
        //            uploadPDK()
        //        }
    }
    func uploadPDK(){
        if (self.historyFFriend!.IDDK <= 0){
            let title = "THÔNG BÁO"
            let message = "Hệ thống mất kết nối với thông tin đơn hàng. Vui lòng đăng nhập vào và up hình lại!!!"
            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = DefaultButton(title: "OK") {}
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        
        if("\(self.historyFFriend!.HinhThucGH)" != "1"){
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
                MPOSAPIManager.mpos_sp_PrintPhieuDKPOS(IDCardCode: "\(self.ocfdFFriend!.IDcardCode)", UserID: "\(Cache.user!.UserName)", ID_Final: "\(self.historyFFriend!.ID_Final)", handler: { (success, err) in
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        if(err.count <= 0){
                            //heo thứ tự chữ ký, cmndmt,cmndms,chandung
                            let listImages = self.historyFFriend!.Flag.components(separatedBy: ",")
                            if(listImages.count == 4){
                                
                                let newViewController = UploadImageFFriendViewController()
                                newViewController.traTruoc = "\(Common.convertCurrencyFloat(value: self.historyFFriend!.SoTienTraTruoc))"
                                newViewController.tongDonHang = "\(Common.convertCurrencyFloat(value: self.historyFFriend!.ThanhTien))"
                                newViewController.conLai = "\(Common.convertCurrencyFloat(value: self.historyFFriend!.SoTienConNo))"
                                newViewController.idFinal = "\(self.historyFFriend!.ID_Final)"
                                newViewController.ocfdFFriend = self.ocfdFFriend!
                                newViewController.historyFFriend = self.historyFFriend
                                
                                if(listImages[0] == "0"){
                                    newViewController.isUploadSign = true
                                }
                                if(listImages[1] == "0"){
                                    newViewController.isUploadCMNDTruoc = true
                                }
                                if(listImages[2] == "0"){
                                    newViewController.isUploadCMNDSau = true
                                }
                                if(listImages[3] == "0"){
                                    newViewController.isUploadAvatar = true
                                }
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }
                        }else{
                            let title = "THÔNG BÁO"
                            let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            
                            let buttonOne = CancelButton(title: "OK") {
                                
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    }
                })
                
            }
            // Create first button
            let buttonTwo = CancelButton(title: "Bỏ qua") {
                //heo thứ tự chữ ký, cmndmt,cmndms,chandung
                let listImages = self.historyFFriend!.Flag.components(separatedBy: ",")
                if(listImages.count == 4){
                    
                    let newViewController = UploadImageFFriendViewController()
                    newViewController.traTruoc = "\(Common.convertCurrencyFloat(value: self.historyFFriend!.SoTienTraTruoc))"
                    newViewController.tongDonHang = "\(Common.convertCurrencyFloat(value: self.historyFFriend!.ThanhTien))"
                    newViewController.conLai = "\(Common.convertCurrencyFloat(value: self.historyFFriend!.SoTienConNo))"
                    newViewController.idFinal = "\(self.historyFFriend!.ID_Final)"
                    newViewController.ocfdFFriend = self.ocfdFFriend!
                    newViewController.historyFFriend = self.historyFFriend
                    
                    if(listImages[0] == "0"){
                        newViewController.isUploadSign = true
                    }
                    if(listImages[1] == "0"){
                        newViewController.isUploadCMNDTruoc = true
                    }
                    if(listImages[2] == "0"){
                        newViewController.isUploadCMNDSau = true
                    }
                    if(listImages[3] == "0"){
                        newViewController.isUploadAvatar = true
                    }
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
            }
            // Add buttons to dialog
            popup.addButtons([buttonOne,buttonTwo])
            
            // Present dialog
            self.present(popup, animated: true, completion: nil)
        }else{
            
            //heo thứ tự chữ ký, cmndmt,cmndms,chandung
            let listImages = self.historyFFriend!.Flag.components(separatedBy: ",")
            if(listImages.count == 4){
                
                let newViewController = UploadImageFFriendViewController()
                newViewController.traTruoc = "\(Common.convertCurrencyFloat(value: self.historyFFriend!.SoTienTraTruoc))"
                newViewController.tongDonHang = "\(Common.convertCurrencyFloat(value: self.historyFFriend!.ThanhTien))"
                newViewController.conLai = "\(Common.convertCurrencyFloat(value: self.historyFFriend!.SoTienConNo))"
                newViewController.idFinal = "\(self.historyFFriend!.ID_Final)"
                newViewController.ocfdFFriend = self.ocfdFFriend!
                newViewController.historyFFriend = self.historyFFriend
                
                if(listImages[0] == "0"){
                    newViewController.isUploadSign = true
                }
                if(listImages[1] == "0"){
                    newViewController.isUploadCMNDTruoc = true
                }
                if(listImages[2] == "0"){
                    newViewController.isUploadCMNDSau = true
                }
                if(listImages[3] == "0"){
                    newViewController.isUploadAvatar = true
                }
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
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
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
}

