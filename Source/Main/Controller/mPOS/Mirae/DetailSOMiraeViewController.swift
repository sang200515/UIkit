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
class DetailSOMiraeViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,UploadImageMiraeViewControllerDelegate{

    
    
    var historyUser:HistoryOrderByUser?
    var historyMirae:HistoryOrderByID?
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
    var lbKyHanValue:UILabel!
    var lbPhiBaoHiemValue:UILabel!
    var btHuy:UIButton!
       var btHoanTat:UIButton!
    var btUploadImage:UIButton!
    var btUpdateInfoCustomer:UIButton!
    var lbSoTienMoiKyValue:UILabel!
    var lbSoTienChenhLechValue:UILabel!
    var lbPhiThamgiaValue:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chi tiết: \(historyUser!.SoMPOS)"
        self.view.backgroundColor = .white
        listImei = []
        lineProduct = []
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.setupUI()
        
     
    }
    
    
    func setupUI() {
     
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
        tfPhoneNumber.text = historyMirae!.PhoneNumber
        
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
        tfCMND.text = historyMirae!.IDCard
        
        
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
        tfUserName.text = historyMirae!.FullName
        
        
        let lbDiaChi = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfUserName.frame.origin.y + tfUserName.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lbDiaChi.textAlignment = .left
        lbDiaChi.textColor = UIColor.black
        lbDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbDiaChi.text = "Địa Chỉ"
        scrollView.addSubview(lbDiaChi)
        
        //input name info
        tfDiaChi = UITextField(frame: CGRect(x: tfPhoneNumber.frame.origin.x, y: lbDiaChi.frame.origin.y + lbDiaChi.frame.size.height + Common.Size(s:10), width: tfPhoneNumber.frame.size.width , height: tfPhoneNumber.frame.size.height ));
        tfDiaChi.placeholder = "Địa Chỉ"
        tfDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDiaChi.borderStyle = UITextField.BorderStyle.roundedRect
        tfDiaChi.autocorrectionType = UITextAutocorrectionType.no
        tfDiaChi.keyboardType = UIKeyboardType.default
        tfDiaChi.returnKeyType = UIReturnKeyType.done
        tfDiaChi.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfDiaChi.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDiaChi.delegate = self
        
        scrollView.addSubview(tfDiaChi)
        tfDiaChi.isEnabled = false
        
        tfDiaChi.leftViewMode = UITextField.ViewMode.always
        let imageDiaChi = UIImageView(frame: CGRect(x: tfDiaChi.frame.size.height/4, y: tfDiaChi.frame.size.height/4, width: tfDiaChi.frame.size.height/2, height: tfDiaChi.frame.size.height/2))
        imageDiaChi.image = UIImage(named: "User-50")
        imageDiaChi.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewDiaChi = UIView()
        leftViewDiaChi.addSubview(imageDiaChi)
        leftViewDiaChi.frame = CGRect(x: 0, y: 0, width: tfDiaChi.frame.size.height, height: tfDiaChi.frame.size.height)
        tfDiaChi.leftView = leftViewDiaChi
        tfDiaChi.text  = historyMirae!.P_Address
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
        
        viewInfoDetail = UIView(frame: CGRect(x: 0, y: tfDiaChi.frame.origin.y  + tfDiaChi.frame.size.height, width: self.view.frame.size.width, height: 0))
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
  
        for item in lineProductMirae!{
            num = num + 1
            sumSO = sumSO + (item.Price)
           
            let soViewLine = UIView()
            soViewPhone.addSubview(soViewLine)
            soViewLine.frame = CGRect(x: 0, y: indexY, width: soViewPhone.frame.size.width, height: 50)
            let line3 = UIView(frame: CGRect(x: line1.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
            line3.backgroundColor = UIColor(netHex:0x47B054)
            soViewLine.addSubview(line3)
            
            let nameProduct = "\(item.ItemCode)-\(item.Dscription)"
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
            lbPriceProduct.text = "Giá: \(Common.convertCurrencyFloat(value: (item.Price ) *  Float(item.Quantity)))"
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
        
        if (self.linePromotionMirae!.count>0){
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
            for item in linePromotionMirae!{
                numPromos = numPromos + 1
                let soViewLine = UIView()
                soViewPromos.addSubview(soViewLine)
                soViewLine.frame = CGRect(x: 0, y: indexYPromos, width: soViewPhone.frame.size.width, height: 50)
                let line3 = UIView(frame: CGRect(x: line1Promos.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
                line3.backgroundColor = UIColor(netHex:0x47B054)
                soViewLine.addSubview(line3)
                
                let nameProduct = "\((item.Dscription))"
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
                lbQuantityProduct.text = "Số lượng: \((item.Quantity))"
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
        
        let lbGoiTraGop = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbTotal.frame.origin.y + lbTotal.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width - Common.Size(s:180), height: Common.Size(s:25)))
        lbGoiTraGop.textAlignment = .left
        lbGoiTraGop.textColor = UIColor.black
        lbGoiTraGop.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbGoiTraGop.text = "Gói trả góp:"
        viewInfoDetail.addSubview(lbGoiTraGop)
        
        
        let lbGoiTraGopValue = UILabel(frame: CGRect(x: lbGoiTraGop.frame.origin.x + lbGoiTraGop.frame.size.width, y: lbTotal.frame.origin.y + lbTotal.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width - Common.Size(s:78), height: Common.Size(s:25)))
        lbGoiTraGopValue.textAlignment = .left
        lbGoiTraGopValue.textColor = UIColor(netHex:0xEF4A40)
        lbGoiTraGopValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbGoiTraGopValue.text = "\(self.historyMirae!.SchemName)"
        viewInfoDetail.addSubview(lbGoiTraGopValue)
        
        let lbGoiTraGopValueHeight:CGFloat = lbGoiTraGopValue.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbGoiTraGopValue.optimalHeight
           lbGoiTraGopValue.numberOfLines = 0
           lbGoiTraGopValue.frame = CGRect(x: lbGoiTraGopValue.frame.origin.x, y: lbGoiTraGopValue.frame.origin.y, width: lbGoiTraGopValue.frame.width, height: lbGoiTraGopValueHeight)
        
        
        let lbLaiSuat = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbGoiTraGopValue.frame.origin.y + lbGoiTraGopValue.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbLaiSuat.textAlignment = .left
        lbLaiSuat.textColor = UIColor.black
        lbLaiSuat.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbLaiSuat.text = "Lãi suất:"
        viewInfoDetail.addSubview(lbLaiSuat)
        
        
        let lbLaiSuatValue = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbGoiTraGopValue.frame.origin.y + lbGoiTraGopValue.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbLaiSuatValue.textAlignment = .right
        lbLaiSuatValue.textColor = UIColor(netHex:0xEF4A40)
        lbLaiSuatValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbLaiSuatValue.text =  "\(self.historyMirae!.laisuat)%"
        viewInfoDetail.addSubview(lbLaiSuatValue)
        
        let lbTongDonHang = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbLaiSuat.frame.origin.y + lbLaiSuat.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbTongDonHang.textAlignment = .left
        lbTongDonHang.textColor = UIColor.black
        lbTongDonHang.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbTongDonHang.text = "Thành tiền:"
        viewInfoDetail.addSubview(lbTongDonHang)
        
        
        let lbTongDonHangValue = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbLaiSuat.frame.origin.y + lbLaiSuat.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbTongDonHangValue.textAlignment = .right
        lbTongDonHangValue.textColor = UIColor(netHex:0xEF4A40)
        lbTongDonHangValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbTongDonHangValue.text = Common.convertCurrencyFloat(value: self.historyMirae!.doctal_before_discount.rounded())
        viewInfoDetail.addSubview(lbTongDonHangValue)
        
        let lbSoTienTraTruoc = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbTongDonHang.frame.origin.y + lbTongDonHang.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbSoTienTraTruoc.textAlignment = .left
        lbSoTienTraTruoc.textColor = UIColor.black
        lbSoTienTraTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbSoTienTraTruoc.text = "Số tiền trả trước:"
        viewInfoDetail.addSubview(lbSoTienTraTruoc)
        
        
        let lbSoTienTraTruocValue = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbTongDonHang.frame.origin.y + lbTongDonHang.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbSoTienTraTruocValue.textAlignment = .right
        lbSoTienTraTruocValue.textColor = UIColor(netHex:0xEF4A40)
        lbSoTienTraTruocValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbSoTienTraTruocValue.text = Common.convertCurrencyFloat(value: self.historyMirae!.DownPaymentAmount.rounded())
        viewInfoDetail.addSubview(lbSoTienTraTruocValue)
 
        let lbSoTienVay = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbSoTienTraTruoc.frame.origin.y + lbSoTienTraTruoc.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbSoTienVay.textAlignment = .left
        lbSoTienVay.textColor = UIColor.black
        lbSoTienVay.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbSoTienVay.text = "Số tiền vay:"
        viewInfoDetail.addSubview(lbSoTienVay)
        
        
        let lbSoTienVayValue = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbSoTienTraTruoc.frame.origin.y + lbSoTienTraTruoc.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbSoTienVayValue.textAlignment = .right
        lbSoTienVayValue.textColor = UIColor(netHex:0xEF4A40)
        lbSoTienVayValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbSoTienVayValue.text = Common.convertCurrencyFloat(value: self.historyMirae!.LoanAmount.rounded())
        viewInfoDetail.addSubview(lbSoTienVayValue)
        
        let lbKyHan = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbSoTienVay.frame.origin.y + lbSoTienVay.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbKyHan.textAlignment = .left
        lbKyHan.textColor = UIColor.black
        lbKyHan.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbKyHan.text = "Kỳ Hạn:"
        viewInfoDetail.addSubview(lbKyHan)
        
        
        let lbKyHanValue = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbSoTienVay.frame.origin.y + lbSoTienVay.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbKyHanValue.textAlignment = .right
        lbKyHanValue.textColor = UIColor(netHex:0xEF4A40)
        lbKyHanValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbKyHanValue.text = "\(self.historyMirae!.TenureOfLoan) tháng"
        viewInfoDetail.addSubview(lbKyHanValue)
        
        let lbPhiBaoHiem = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbKyHan.frame.origin.y + lbKyHan.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbPhiBaoHiem.textAlignment = .left
        lbPhiBaoHiem.textColor = UIColor.black
        lbPhiBaoHiem.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbPhiBaoHiem.text = "Phí bảo hiểm:"
        viewInfoDetail.addSubview(lbPhiBaoHiem)
        
        
        let lbPhiBaoHiemValue = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbKyHan.frame.origin.y + lbKyHan.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbPhiBaoHiemValue.textAlignment = .right
        lbPhiBaoHiemValue.textColor = UIColor(netHex:0xEF4A40)
        lbPhiBaoHiemValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbPhiBaoHiemValue.text = "\(Common.convertCurrencyFloat(number: self.historyMirae!.protectionfee.rounded()))đ"
        viewInfoDetail.addSubview(lbPhiBaoHiemValue)
        
        let lbPhiThamgia = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbPhiBaoHiem.frame.origin.y + lbPhiBaoHiem.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbPhiThamgia.textAlignment = .left
        lbPhiThamgia.textColor = UIColor.black
        lbPhiThamgia.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbPhiThamgia.text = "Phí tham gia:"
        viewInfoDetail.addSubview(lbPhiThamgia)
        
        
        let lbPhiThamgiaValue = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbPhiBaoHiem.frame.origin.y + lbPhiBaoHiem.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbPhiThamgiaValue.textAlignment = .right
        lbPhiThamgiaValue.textColor = UIColor(netHex:0xEF4A40)
        lbPhiThamgiaValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbPhiThamgiaValue.text = "\(Common.convertCurrencyFloat(number: self.historyMirae?.ParticipationFee.rounded(.toNearestOrEven) ?? 0.0))đ"
        viewInfoDetail.addSubview(lbPhiThamgiaValue)
        
        let lbGiamGiam = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbPhiThamgia.frame.origin.y + lbPhiThamgia.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbGiamGiam.textAlignment = .left
        lbGiamGiam.textColor = UIColor.black
        lbGiamGiam.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbGiamGiam.text = "Giảm giá:"
        viewInfoDetail.addSubview(lbGiamGiam)
        
        
        let lbGiamGiamValue = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbPhiThamgia.frame.origin.y + lbPhiThamgia.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbGiamGiamValue.textAlignment = .right
        lbGiamGiamValue.textColor = UIColor(netHex:0xEF4A40)
        lbGiamGiamValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbGiamGiamValue.text = "\(Common.convertCurrencyFloat(number: self.historyMirae!.discount_amount.rounded()))đ"
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
        lbPayValue.text = Common.convertCurrencyFloat(value: self.historyMirae!.TongTienThanhToan.rounded())
        viewInfoDetail.addSubview(lbPayValue)
        
        let lbSoTienChenhLech = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbPayValue.frame.origin.y + lbPayValue.frame.size.height, width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbSoTienChenhLech.textAlignment = .left
        lbSoTienChenhLech.textColor = UIColor.black
        lbSoTienChenhLech.font = UIFont.systemFont(ofSize: 16)
        lbSoTienChenhLech.text = "Số tiền chênh lệch:"
        viewInfoDetail.addSubview(lbSoTienChenhLech)
        
        lbSoTienChenhLechValue = UILabel(frame: CGRect(x: lbSoTienChenhLech.frame.origin.x, y: lbPayValue.frame.origin.y + lbPayValue.frame.size.height , width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbSoTienChenhLechValue.textAlignment = .right
        lbSoTienChenhLechValue.textColor = UIColor(netHex:0xEF4A40)
        lbSoTienChenhLechValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbSoTienChenhLechValue.text = Common.convertCurrencyFloat(value: self.historyMirae!.Sotienchenhlech.rounded())
        viewInfoDetail.addSubview(lbSoTienChenhLechValue)
        
        let lbSoTienMoiKy = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lbSoTienChenhLech.frame.origin.y + lbSoTienChenhLech.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbSoTienMoiKy.textAlignment = .left
        lbSoTienMoiKy.textColor = UIColor.black
        lbSoTienMoiKy.font = UIFont.systemFont(ofSize: 16)
        lbSoTienMoiKy.text = "Tiền tạm ứng hàng tháng:"
        viewInfoDetail.addSubview(lbSoTienMoiKy)
        
        lbSoTienMoiKyValue = UILabel(frame: CGRect(x: lbSoTienMoiKy.frame.origin.x, y: lbSoTienChenhLech.frame.origin.y + lbSoTienChenhLech.frame.size.height + Common.Size(s:10) , width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbSoTienMoiKyValue.textAlignment = .right
        lbSoTienMoiKyValue.textColor = UIColor(netHex:0xEF4A40)
        lbSoTienMoiKyValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        
        if(self.historyMirae!.TenureOfLoan > 0){
            let sum = historyMirae!.LoanAmount + historyMirae!.Sotienchenhlech
            lbSoTienMoiKyValue.text = Common.convertCurrencyFloat(value: Float(( sum / Float(self.historyMirae!.TenureOfLoan) ).round()))
        }
       
        viewInfoDetail.addSubview(lbSoTienMoiKyValue)

        
        btHuy = UIButton()
        btHuy.frame = CGRect(x: tfPhoneNumber.frame.origin.x, y: lbSoTienMoiKy.frame.origin.y + lbSoTienMoiKy.frame.size.height + Common.Size(s:20), width: UIScreen.main.bounds.size.width - Common.Size(s:180), height: Common.Size(s:40))
        btHuy.backgroundColor = UIColor(netHex:0xEF4A40)
        btHuy.addTarget(self, action: #selector(actionHuy), for: .touchUpInside)
        btHuy.layer.borderWidth = 0.5
        btHuy.layer.borderColor = UIColor.white.cgColor
        btHuy.layer.cornerRadius = 5.0
        btHuy.clipsToBounds = true
        viewInfoDetail.addSubview(btHuy)
        btHuy.setTitle("Hủy", for: .normal)
        
        btHoanTat = UIButton()
        btHoanTat.frame = CGRect(x: btHuy.frame.origin.x + btHuy.frame.size.width, y: lbSoTienMoiKy.frame.origin.y + lbSoTienMoiKy.frame.size.height + Common.Size(s:20), width: UIScreen.main.bounds.size.width - Common.Size(s:180), height: Common.Size(s:40))
        btHoanTat.backgroundColor = UIColor(netHex:0x00955E)
        btHoanTat.addTarget(self, action: #selector(actionHoanTat), for: .touchUpInside)
        btHoanTat.layer.borderWidth = 0.5
        btHoanTat.layer.borderColor = UIColor.white.cgColor
        btHoanTat.layer.cornerRadius = 5.0
        btHoanTat.clipsToBounds = true
        viewInfoDetail.addSubview(btHoanTat)
        btHoanTat.setTitle("Hoàn Tất", for: .normal)
        
        btUploadImage = UIButton()
        btUploadImage.frame = CGRect(x: tfPhoneNumber.frame.origin.x, y: btHuy.frame.origin.y + btHuy.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40), height: Common.Size(s:40))
        btUploadImage.backgroundColor = UIColor(netHex:0x00CC99)
        btUploadImage.addTarget(self, action: #selector(uploadImage), for: .touchUpInside)
        btUploadImage.layer.borderWidth = 0.5
        btUploadImage.layer.borderColor = UIColor.white.cgColor
        btUploadImage.layer.cornerRadius = 5.0
        btUploadImage.clipsToBounds = true
        viewInfoDetail.addSubview(btUploadImage)
        btUploadImage.setTitle("Upload hình ảnh", for: .normal)
        
        btUpdateInfoCustomer = UIButton()
        btUpdateInfoCustomer.frame = CGRect(x: tfPhoneNumber.frame.origin.x, y: btUploadImage.frame.origin.y + btUploadImage.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40), height: Common.Size(s:40))
        btUpdateInfoCustomer.backgroundColor = UIColor(netHex:0x00CC99)
        btUpdateInfoCustomer.addTarget(self, action: #selector(actionUpdateInfoKH), for: .touchUpInside)
        btUpdateInfoCustomer.layer.borderWidth = 0.5
        btUpdateInfoCustomer.layer.borderColor = UIColor.white.cgColor
        btUpdateInfoCustomer.layer.cornerRadius = 5.0
        viewInfoDetail.addSubview(btUpdateInfoCustomer)
        btUpdateInfoCustomer.setTitle("Thông tin Khách hàng", for: .normal)
      
        
        viewInfoDetail.frame.size.height = btUpdateInfoCustomer.frame.origin.y + btUpdateInfoCustomer.frame.size.height + Common.Size(s:20)
        scrollView.addSubview(viewInfoDetail)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetail.frame.origin.y + viewInfoDetail.frame.size.height + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        //((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        //hide keyboard
        self.hideKeyboardWhenTappedAround()
        if(self.historyUser!.TTbuttonHT == 1){ //TTbuttonHT
            if(self.historyUser!.TTbuttonHuy == 1){
                
            }else{
                btHuy.frame.size.height = 0
                btHuy.isEnabled = false
               // btHuy.setTitle("", for: .normal)
                btHoanTat.frame.size.width = UIScreen.main.bounds.size.width - Common.Size(s:40)
                btUploadImage.frame.origin.y = btHuy.frame.origin.y + btHuy.frame.size.height + Common.Size(s:10)
                btUpdateInfoCustomer.frame.origin.y = btUploadImage.frame.origin.y + btUploadImage.frame.size.height + Common.Size(s:10)
                scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetail.frame.origin.y + viewInfoDetail.frame.size.height + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
            }
        }else{
            
          
            
            if(self.historyUser!.TTbuttonHuy == 1){
                btHuy.frame.size.width = UIScreen.main.bounds.size.width - Common.Size(s:40)
               // btHoanTat.setTitle("", for: .normal)
                btHoanTat.frame.size.height = 0
                btHoanTat.isEnabled = false
                btUploadImage.frame.origin.y = btHuy.frame.origin.y + btHuy.frame.size.height + Common.Size(s:10)
                btUpdateInfoCustomer.frame.origin.y = btUploadImage.frame.origin.y + btUploadImage.frame.size.height + Common.Size(s:10)
                scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetail.frame.origin.y + viewInfoDetail.frame.size.height + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
            }else{
                btHuy.frame.size.height = 0
                btHuy.isEnabled = false
               // btHuy.setTitle("", for: .normal)
                //btHoanTat.setTitle("", for: .normal)
                btHoanTat.frame.size.height = 0
                btHoanTat.isEnabled = false
                btUploadImage.frame.origin.y = btHuy.frame.origin.y + btHuy.frame.size.height + Common.Size(s:10)
                btUpdateInfoCustomer.frame.origin.y = btUploadImage.frame.origin.y + btUploadImage.frame.size.height + Common.Size(s:10)
                scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetail.frame.origin.y + viewInfoDetail.frame.size.height + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
            }
      
        }
     
        self.actionLoadInfo()
        
    }
    
    func actionLoadInfo(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_FRT_SP_mirae_Getinfo_byContractNumber(IDMPOS: "\(self.historyMirae!.Docentry)") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(results != nil){
                        self.getinfo_byContractNumber = results
                        if(results!.Flag_Image_PDK == "0"){
                            self.btUploadImage.frame.size.height = 0
                            self.btUpdateInfoCustomer.frame.origin.y = self.btHuy.frame.origin.y + self.btHuy.frame.size.height + Common.Size(s:10)
                            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.viewInfoDetail.frame.origin.y + self.viewInfoDetail.frame.size.height + ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
                        }
                    }else{
//                        let alert = UIAlertController(title: "Thông báo", message: "Không lấy được thông tin KH, Info = null ", preferredStyle: .alert)
//
//                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                        })
//                        self.present(alert, animated: true)
                        
                    }
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err , preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        self.btUploadImage.frame.size.height = 0
                        self.btUpdateInfoCustomer.frame.origin.y = self.btHuy.frame.origin.y + self.btHuy.frame.size.height + Common.Size(s:10)
                        self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.viewInfoDetail.frame.origin.y + self.viewInfoDetail.frame.size.height + ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
                    })
                    self.present(alert, animated: true)
                    
                }
            }
        }
    }
    
    @objc func actionUpdateInfoKH(){
        if(self.getinfo_byContractNumber != nil){
            let newViewController = DetailInfoCustomerMiraeHistoryViewController()
            newViewController.historyMirae = self.historyMirae!
            newViewController.historyUser = self.historyUser!
            newViewController.getinfo_byContractNumber = getinfo_byContractNumber
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else{
            let newViewController = LoadingViewController()
            newViewController.content = "Đang lấy thông tin ..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            
            MPOSAPIManager.mpos_FRT_SP_mirae_Getinfo_byContractNumber(IDMPOS: "\(self.historyMirae!.Docentry)") { [weak self](results, err) in
                guard let self = self else {return}
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        if(results != nil){
                            let newViewController = DetailInfoCustomerMiraeHistoryViewController()
                            newViewController.historyMirae = self.historyMirae!
                            newViewController.historyUser = self.historyUser!
                            newViewController.getinfo_byContractNumber = results
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }else{
                            let alert = UIAlertController(title: "Thông báo", message: "Không lấy được thông tin KH, Info = null ", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                
                            })
                            self.present(alert, animated: true)
                        }
                        
                    }else{
                        //                    let newViewController = DetailInfoCustomerMiraeHistoryViewController()
                        //                    newViewController.historyMirae = self.historyMirae!
                        //                    self.navigationController?.pushViewController(newViewController, animated: true)
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                        
                    }
                }
            }
        }
        

    
    }

    @objc func uploadImage(){
        if(self.getinfo_byContractNumber != nil){
            let newViewController = UploadImageMiraeViewController()
            newViewController.delegate = self
            newViewController.historyMirae = self.historyMirae!
            newViewController.getinfo_byContractNumber = getinfo_byContractNumber
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else{
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang lấy thông tin ..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            
            MPOSAPIManager.mpos_FRT_SP_mirae_Getinfo_byContractNumber(IDMPOS: "\(self.historyMirae!.Docentry)") { (results, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        if(results != nil){
                            let newViewController = UploadImageMiraeViewController()
                             newViewController.delegate = self
                            newViewController.historyMirae = self.historyMirae!
                            newViewController.getinfo_byContractNumber = results
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }else{
                            let alert = UIAlertController(title: "Thông báo", message: "Không lấy được thông tin KH, Info = null ", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                
                            })
                            self.present(alert, animated: true)
                            
                        }
                        
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: err , preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                        
                    }
                }
            }
        }
        

        

    }
    @objc func actionHoanTat(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang hoàn tất hợp đồng..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_FRT_SP_mirae_finish_hopdong(IDMPOS:"\(self.historyUser!.Docentry)",Imei:"\(self.historyUser!.Imei)") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    
                    let alert = UIAlertController(title: "Thông báo", message: results[0].p_messagess, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        for vc in self.navigationController?.viewControllers ?? [] {
                            if vc is MiraeMenuViewController {
                                self.navigationController?.popToViewController(vc, animated: true)
                            }
                        }
                    })
                    self.present(alert, animated: true)
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    @objc func actionHuy(){
        let newViewController = HuyHopDongMiraeViewController()
        newViewController.history = self.historyUser!
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func someAction(_ sender:UITapGestureRecognizer){
        // do other task
        let view:UIView = sender.view!
        self.lbImei = listImei[view.tag]
        self.itemProduct = lineProductMirae![view.tag]
        self.loadImei()
//        if (self.itemProduct.QLImei == "Y"){
//            if(self.itemProduct.MaShop == "\(Cache.user!.ShopCode)"){
//                loadImei()
//            }else{
//                let popup = PopupDialog(title: "THÔNG BÁO", message: "Đơn hàng Ecom đẩy về cho shop \(self.itemProduct.MaShop). Bạn không thuộc nhân viên shop nên không được phép cập nhật Imei trên đơn hàng.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
//                    print("Completed")
//                }
//                // Create first button
//                let buttonOne = CancelButton(title: "OK") {
//
//                }
//                // Add buttons to dialog
//                popup.addButtons([buttonOne])
//
//                // Present dialog
//                self.present(popup, animated: true, completion: nil)
//            }
//        }
    }
    
    func loadImei(){
        var imeiOld:String = ""
        imeiOld = itemProduct.U_Imei
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
                       //     self.itemProduct.WhsCode = whsCodes[0]
                            self.lbImei.text = "IMEI: \(self.itemProduct.U_Imei)"
                            //replace imei
                    
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
                self.replaceImei(processID:"\(self.historyUser!.processId_Mirae)",activityId:"\(self.historyMirae!.activityId_Mirae)",Imei_old:"\(imeiOld)",imei_new:"\(self.itemProduct.U_Imei)",IDmpos:"\(self.historyMirae!.Docentry)")
                    
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
                                //self.itemProduct.WhsCode = whsCodes[value]
                                self.lbImei.text = "IMEI: \(self.itemProduct.U_Imei)"
                                self.replaceImei(processID:"\(self.historyUser!.processId_Mirae)",activityId:"\(self.historyMirae!.activityId_Mirae)",Imei_old:"\(imeiOld)",imei_new:"\(self.itemProduct.U_Imei)",IDmpos:"\(self.historyMirae!.Docentry)")
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

        
    }
    func replaceImei(processID:String,activityId:String,Imei_old:String,imei_new:String,IDmpos:String){
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang thay đổi imei..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_Mirae_UpdateImei(processID:processID,activityId:activityId,Imei_old:Imei_old,imei_new:imei_new,IDmpos:IDmpos) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    let alert = UIAlertController(title: "Thông báo", message: results[0].p_messagess, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                    
                    
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
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
    func backSuccess() {
        self.navigationController?.popViewController(animated: true)
    }
}

