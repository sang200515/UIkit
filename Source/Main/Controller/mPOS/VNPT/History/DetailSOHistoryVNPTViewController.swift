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
class DetailSOHistoryVNPTViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,UploadImageMiraeViewControllerDelegate{

    
    
    
    var historyVNPT:HistoryVNPT?
    var lineProductMirae:[LineProductMirae]?
    var linePromotionMirae:[LinePromotionMirae]?
    var getinfo_byContractNumber:Getinfo_byContractNumber?

    
    var phone: String = ""
    var name: String = ""
    
    var scrollView:UIScrollView!

    
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
    
    var itemProduct:LineProductMirae!
    
    var tfPhoneNumber:UITextField!
    var tfCMND:UITextField!
    var tfDiaChi:UITextField!
    var tfUserName:UITextField!
    
    var lbGoiTraGopValue:UILabel!
    var lbLaiSuatValue:UILabel!
    var lbTongDonHangValue:UILabel!
    var lbSoTienTraTruocValue:UILabel!
    var lbSoTienVayValue:UILabel!
   
    var btUploadChanDung:UIButton!
    var btUploadAll:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chi tiết: \(historyVNPT!.SOMPOS)"
        self.view.backgroundColor = .white
        listImei = []
        lineProduct = []
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        //self.setupUI()
        MPOSAPIManager.getSODetails(docEntry: "\((historyVNPT!.SOMPOS))") { (soDetail, String) in
            if(soDetail != nil){
                self.setupUI(soDetail: soDetail!)
            }
        }
        
        
    }
    func setupUI(soDetail:SODetail) {
     
        let lbUserInfo = UILabel(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:20)))
        lbUserInfo.textAlignment = .left
        lbUserInfo.textColor = UIColor(netHex:0x47B054)
        lbUserInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbUserInfo.text = "THÔNG TIN KHÁCH HÀNG"
        scrollView.addSubview(lbUserInfo)
        
        let lbPhoneNumber = UILabel(frame: CGRect(x: Common.Size(s:20), y: lbUserInfo.frame.origin.y + lbUserInfo.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lbPhoneNumber.textAlignment = .left
        lbPhoneNumber.textColor = UIColor.black
        lbPhoneNumber.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPhoneNumber.text = "Số điện thoại"
        scrollView.addSubview(lbPhoneNumber)
        //input phone number
        tfPhoneNumber = UITextField(frame: CGRect(x: Common.Size(s:20), y: lbPhoneNumber.frame.origin.y + lbPhoneNumber.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfPhoneNumber.placeholder = "Số điện thoại"
        tfPhoneNumber.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhoneNumber.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhoneNumber.autocorrectionType = UITextAutocorrectionType.no
        tfPhoneNumber.keyboardType = UIKeyboardType.numberPad
        tfPhoneNumber.returnKeyType = UIReturnKeyType.done
        tfPhoneNumber.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPhoneNumber.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhoneNumber.delegate = self
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
        tfPhoneNumber.text = historyVNPT!.SDT
        
        let lbCMND = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfPhoneNumber.frame.origin.y + tfPhoneNumber.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lbCMND.textAlignment = .left
        lbCMND.textColor = UIColor.black
        lbCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMND.text = "CMND"
        scrollView.addSubview(lbCMND)
        
        tfCMND = UITextField(frame: CGRect(x: Common.Size(s:20), y: lbCMND.frame.origin.y + lbCMND.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfCMND.placeholder = "CMND"
        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMND.autocorrectionType = UITextAutocorrectionType.no
        tfCMND.keyboardType = UIKeyboardType.numberPad
        tfCMND.returnKeyType = UIReturnKeyType.done
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMND.delegate = self
        
        scrollView.addSubview(tfCMND)
        tfCMND.isEnabled = false
        
        tfCMND.leftViewMode = UITextField.ViewMode.always
        let imageCMND = UIImageView(frame: CGRect(x: tfCMND.frame.size.height/4, y: tfCMND.frame.size.height/4, width: tfCMND.frame.size.height/2, height: tfCMND.frame.size.height/2))
        imageCMND.image = UIImage(named: "Phone-50")
        imageCMND.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewCMND = UIView()
        leftViewCMND.addSubview(imageCMND)
        leftViewCMND.frame = CGRect(x: 0, y: 0, width: tfCMND.frame.size.height, height: tfPhoneNumber.frame.size.height)
        tfCMND.leftView = leftViewCMND
        tfCMND.text = historyVNPT!.CMND
        
        
        let lbUserName = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfCMND.frame.origin.y + tfCMND.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lbUserName.textAlignment = .left
        lbUserName.textColor = UIColor.black
        lbUserName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbUserName.text = "Tên khách hàng"
        scrollView.addSubview(lbUserName)
        
        //input name info
        tfUserName = UITextField(frame: CGRect(x: tfPhoneNumber.frame.origin.x, y: lbUserName.frame.origin.y + lbUserName.frame.size.height + Common.Size(s:10), width: tfPhoneNumber.frame.size.width , height: tfPhoneNumber.frame.size.height ));
        tfUserName.placeholder = "Tên khách hàng"
        tfUserName.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfUserName.borderStyle = UITextField.BorderStyle.roundedRect
        tfUserName.autocorrectionType = UITextAutocorrectionType.no
        tfUserName.keyboardType = UIKeyboardType.default
        tfUserName.returnKeyType = UIReturnKeyType.done
        tfUserName.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfUserName.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfUserName.delegate = self
        
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
        tfUserName.text = historyVNPT!.TenKH
        
        

        
  
//
//        let lbInfoUploadMore = UILabel(frame: CGRect(x: tfDiaChi.frame.origin.x, y: tfDiaChi.frame.size.height + tfDiaChi.frame.origin.y + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 14)))
//        lbInfoUploadMore.textAlignment = .right
//        lbInfoUploadMore.textColor = UIColor(netHex:0x0000FF)
//        lbInfoUploadMore.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
//        let underlineAttribute1 = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
//        let underlineAttributedString1 = NSAttributedString(string: "Xem chi tiết", attributes: underlineAttribute1)
//        lbInfoUploadMore.attributedText = underlineAttributedString1
//        scrollView.addSubview(lbInfoUploadMore)
//        let tapShowUploadMore = UITapGestureRecognizer(target: self, action: #selector(DetailSOMiraeViewController.tapXemChiTiet))
//        lbInfoUploadMore.isUserInteractionEnabled = true
//        lbInfoUploadMore.addGestureRecognizer(tapShowUploadMore)
        
        viewInfoDetail = UIView(frame: CGRect(x: 0, y: tfUserName.frame.origin.y  + tfUserName.frame.size.height, width: self.view.frame.size.width, height: 0))
        viewInfoDetail.clipsToBounds = true
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
            sumSO = sumSO + (item.Price)
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
//            if (item.QLImei == "Y"){
//                lbQuantityProduct.text = "IMEI: \((item.U_Imei))"
//            }else{
//                lbQuantityProduct.text = "Số lượng: \((item.Quantity))"
//            }
            
               lbQuantityProduct.text = "IMEI: \((item.U_Imei))"
          //  lbQuantityProduct.text = "Số lượng: \((item.Quantity))"
         

            
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
            lbPriceProduct.text = "Giá: \(Common.convertCurrencyFloat(value: (item.Price ) /  Float(item.Quantity)))"
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
//            let gestureSwift2AndHigher = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
//            soViewLine.addGestureRecognizer(gestureSwift2AndHigher)
        }
        soViewPhone.frame.size.height = indexHeight
        
        
        let soViewPromos = UIView()
        soViewPromos.frame = CGRect(x: soViewPhone.frame.origin.x, y: soViewPhone.frame.origin.y + soViewPhone.frame.size.height + Common.Size(s:20), width: soViewPhone.frame.size.width, height: 0)
        viewInfoDetail.addSubview(soViewPromos)
        
    
//        for item in linePromotionMirae!{
//            if (item.TienGiam <= 0){
//                if (promos.count == 0){
//                    promos.append(item)
//                }else{
//                    for pro in promos {
//                        if (pro.SanPham_Tang == item.SanPham_Tang){
//                            pro.SL_Tang =  pro.SL_Tang + item.SL_Tang
//                        }else{
//                            promos.append(item)
//                        }
//                    }
//                }
//            }else{
//                sumPromos = sumPromos + item.TienGiam
//            }
//        }
        
        if (soDetail.linePromos!.count>0){
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
            for item in soDetail.linePromos!{
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
        
      
        
        let lbTongDonHang = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbTotal.frame.origin.y + lbTotal.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbTongDonHang.textAlignment = .left
        lbTongDonHang.textColor = UIColor.black
        lbTongDonHang.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbTongDonHang.text = "Thành tiền:"
        viewInfoDetail.addSubview(lbTongDonHang)
        
        
        let lbTongDonHangValue = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbTotal.frame.origin.y + lbTotal.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbTongDonHangValue.textAlignment = .right
        lbTongDonHangValue.textColor = UIColor(netHex:0xEF4A40)
        lbTongDonHangValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
    lbTongDonHangValue.text = Common.convertCurrencyFloat(value: sumSO + sumDiscount)
        viewInfoDetail.addSubview(lbTongDonHangValue)
        
     
 
        

  
        
        let lbGiamGiam = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbTongDonHang.frame.origin.y + lbTongDonHang.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbGiamGiam.textAlignment = .left
        lbGiamGiam.textColor = UIColor.black
        lbGiamGiam.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbGiamGiam.text = "Giảm giá:"
        viewInfoDetail.addSubview(lbGiamGiam)
        
        
        let lbGiamGiamValue = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbTongDonHang.frame.origin.y + lbTongDonHang.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbGiamGiamValue.textAlignment = .right
        lbGiamGiamValue.textColor = UIColor(netHex:0xEF4A40)
        lbGiamGiamValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
     lbGiamGiamValue.text = Common.convertCurrencyFloat(value: sumDiscount)
        viewInfoDetail.addSubview(lbGiamGiamValue)
        
        
        let lbPayText = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbGiamGiam.frame.origin.y + lbGiamGiam.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbPayText.textAlignment = .left
        lbPayText.textColor = UIColor.black
        lbPayText.font = UIFont.boldSystemFont(ofSize: 16)
        lbPayText.text = "Tổng đơn hàng:"
        viewInfoDetail.addSubview(lbPayText)
        
        let lbPayValue = UILabel(frame: CGRect(x: lbPayText.frame.origin.x, y: lbGiamGiam.frame.origin.y + lbGiamGiam.frame.size.height + Common.Size(s:10) , width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbPayValue.textAlignment = .right
        lbPayValue.textColor = UIColor(netHex:0xEF4A40)
        lbPayValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))
     lbPayValue.text = Common.convertCurrencyFloat(value: sumSO)
        viewInfoDetail.addSubview(lbPayValue)
        
       
        


        
        btUploadChanDung = UIButton()
        btUploadChanDung.frame = CGRect(x: tfPhoneNumber.frame.origin.x, y: lbPayText.frame.origin.y + lbPayText.frame.size.height + Common.Size(s:20), width: UIScreen.main.bounds.size.width - Common.Size(s:40), height: Common.Size(s:40))
        btUploadChanDung.backgroundColor = UIColor(netHex:0xEF4A40)
        btUploadChanDung.addTarget(self, action: #selector(actionUploadChanDung), for: .touchUpInside)
        btUploadChanDung.layer.borderWidth = 0.5
        btUploadChanDung.layer.borderColor = UIColor.white.cgColor
        btUploadChanDung.layer.cornerRadius = 5.0
        btUploadChanDung.clipsToBounds = true
        viewInfoDetail.addSubview(btUploadChanDung)
        btUploadChanDung.setTitle("Upload Chân Dung", for: .normal)
        
        btUploadAll = UIButton()
        btUploadAll.frame = CGRect(x: tfPhoneNumber.frame.origin.x , y: btUploadChanDung.frame.origin.y + btUploadChanDung.frame.size.height + Common.Size(s:20), width: UIScreen.main.bounds.size.width - Common.Size(s:40), height: Common.Size(s:40))
        btUploadAll.backgroundColor = UIColor(netHex:0x00955E)
        btUploadAll.addTarget(self, action: #selector(actionReUp), for: .touchUpInside)
        btUploadAll.layer.borderWidth = 0.5
        btUploadAll.layer.borderColor = UIColor.white.cgColor
        btUploadAll.layer.cornerRadius = 5.0
        btUploadAll.clipsToBounds = true
        viewInfoDetail.addSubview(btUploadAll)
        btUploadAll.setTitle("Cập nhật hình ảnh", for: .normal)
        
   
      
        
        viewInfoDetail.frame.size.height = btUploadAll.frame.origin.y + btUploadAll.frame.size.height + Common.Size(s:20)
        scrollView.addSubview(viewInfoDetail)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetail.frame.origin.y + viewInfoDetail.frame.size.height + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        //((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        //hide keyboard

        if(self.historyVNPT!.TTEdit == "N"){
            btUploadAll.frame.size.height = 0
            btUploadAll.isEnabled = false
            
            viewInfoDetail.frame.size.height = btUploadAll.frame.origin.y + btUploadAll.frame.size.height + Common.Size(s:20)
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetail.frame.origin.y + viewInfoDetail.frame.size.height + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        }
        if(self.historyVNPT!.TTuploadAnhKH == "N"){
            btUploadChanDung.frame.size.height = 0
            btUploadChanDung.isEnabled = false
            
            btUploadAll.frame.origin.y = btUploadChanDung.frame.size.height + btUploadChanDung.frame.origin.y + Common.Size(s:10)
            viewInfoDetail.frame.size.height = btUploadAll.frame.origin.y + btUploadAll.frame.size.height + Common.Size(s:20)
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetail.frame.origin.y + viewInfoDetail.frame.size.height + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
            
        }
 
        
    }
    
    
    
    
    @objc func actionReUp(){
        let newViewController = UpdateImageVNPTViewController()
        newViewController.historyVNPT = self.historyVNPT
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func actionUploadChanDung(){
        let newViewController = UploadImageHistoryVNPTViewController()
        newViewController.historyVNPT = self.historyVNPT
        self.navigationController?.pushViewController(newViewController, animated: true)
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
    func backSuccess() {
        self.navigationController?.popViewController(animated: true)
    }
}

