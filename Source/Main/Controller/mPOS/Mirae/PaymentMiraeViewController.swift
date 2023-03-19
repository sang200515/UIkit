//
//  PaymentMiraeViewController.swift
//  fptshop
//
//  Created by tan on 5/29/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import DLRadioButton
import PopupDialog
import ActionSheetPicker_3_0
import AVFoundation
class PaymentMiraeViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,ChooseInstallmentPlanViewControllerDelegate{
    
    var scrollView:UIScrollView!
    var tfPhoneNumber:UITextField!
    var tfCMND:UITextField!
    var tfDiaChi:UITextField!
    var tfUserName:UITextField!
    
    
    var listImei:[UILabel] = []
    
    var lbPayType:UILabel!
    
    var viewInstallment:UIView!
    var viewInstallmentHeight: CGFloat = 0.0
    
    var viewInfoDetail: UIView!
    
    var promotionsMirae: [String:NSMutableArray] = [:]
    var groupMirae: [String] = []
    
    var viewToshibaPoint:UIView!
    var viewBelowToshibaPoint:UIView!
    var lbFPoint,lbFCoin,lbRanking:UILabel!
    var infoCustomer: InfoCustomerMirae?
    
    var lbSendOTP:UILabel!
    var sendOTPSuccess:Bool = false
    
    var skuList:String = ""
    var checkTotal:Float = 0.0
    var tfkyHan:SearchTextField!
    var tfSoTienTraTruoc:UITextField!
    var tfGoiTraGop:SearchTextField!
    var selectKyHan:String = ""
    var selectGoi:String = ""
    var listKyHan:[KyHanMirae] = []
    var listGoi:[LaiSuatMirae] = []
    var lbSoTienVayValue:UILabel!
    var lbPhiBaoHiemValue:UILabel!
    var lbDiscountValue:UILabel!
    var lbPayValue:UILabel!
    var sotientratruoc:Float = 0
    var totalPay:Float = 0.0
    var discountPay:Float = 0.0
    var lbSoTienTraTruocValue:UILabel!
    var lbMoTaGoiCuoc:UILabel!
    var viewVoucher,viewVoucherLine :UIView!
    var lbAddVoucherMore:UILabel!
    var tfSoTienCoc:UITextField!
    var schemecode:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "Đơn hàng"
        checkTotal = 0.0
     
        skuList = ""
        sendOTPSuccess = false
        self.infoCustomer = Cache.infoCustomerMirae
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(PaymentMiraeViewController.actionBack), for: UIControl.Event.touchUpInside)
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
        
        viewVoucher = UIView(frame: CGRect(x:0,y:tfDiaChi.frame.origin.y + tfDiaChi.frame.size.height + Common.Size(s:10),width:self.view.frame.size.width,height:100))
        //        viewVoucher.backgroundColor = .yellow
        scrollView.addSubview(viewVoucher)
        
        let  lbVoucher = UILabel(frame: CGRect(x: tfDiaChi.frame.origin.x, y: Common.Size(s:0), width: tfDiaChi.frame.size.width, height: Common.Size(s:18)))
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
        
        viewVoucherLine = UIView(frame: CGRect(x:Common.Size(s:20),y:lbVoucher.frame.origin.y + lbVoucher.frame.size.height + Common.Size(s:10),width:self.view.frame.size.width - Common.Size(s:40),height:100))
        viewVoucher.addSubview(viewVoucherLine)
        
        let line1Voucher = UIView(frame: CGRect(x: viewVoucherLine.frame.size.width * 1.3/10, y: 0, width: 1, height: Common.Size(s:25)))
        line1Voucher.backgroundColor = UIColor(netHex:0x04AB6E)
        viewVoucherLine.addSubview(line1Voucher)
        let line2Voucher = UIView(frame: CGRect(x: 0, y:line1Voucher.frame.origin.y + line1Voucher.frame.size.height, width: viewVoucherLine.frame.size.width, height: 1))
        line2Voucher.backgroundColor =  UIColor(netHex:0x04AB6E)
        viewVoucherLine.addSubview(line2Voucher)
        
        let lbSttVoucher = UILabel(frame: CGRect(x: 0, y: line1Voucher.frame.origin.y, width: line1Voucher.frame.origin.x, height: line1Voucher.frame.size.height))
        lbSttVoucher.textAlignment = .center
        lbSttVoucher.textColor =  UIColor(netHex:0x04AB6E)
        lbSttVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbSttVoucher.text = "STT"
        viewVoucherLine.addSubview(lbSttVoucher)
        
        let lbInfoVoucher = UILabel(frame: CGRect(x: line1Voucher.frame.origin.x, y: line1Voucher.frame.origin.y, width: viewVoucherLine.frame.size.width - line1Voucher.frame.origin.x, height: line1Voucher.frame.size.height))
        lbInfoVoucher.textAlignment = .center
        lbInfoVoucher.textColor =  UIColor(netHex:0x04AB6E)
        lbInfoVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbInfoVoucher.text = "Mã voucher"
        viewVoucherLine.addSubview(lbInfoVoucher)
        
        var indexYVoucher = line2Voucher.frame.origin.y
        var indexHeightVoucher: CGFloat = line2Voucher.frame.origin.y + line2Voucher.frame.size.height
        var numVoucher = 0
        for item in Cache.listVoucher{
            numVoucher = numVoucher + 1
            let soViewLine = UIView()
            viewVoucherLine.addSubview(soViewLine)
            soViewLine.frame = CGRect(x: 0, y: indexYVoucher, width: viewVoucherLine.frame.size.width, height: Common.Size(s:40))
            
            let imageDelete = UIImageView(frame: CGRect(x: soViewLine.frame.size.width - soViewLine.frame.size.height, y: 0, width: soViewLine.frame.size.height - Common.Size(s:20), height: soViewLine.frame.size.height))
            imageDelete.image = #imageLiteral(resourceName: "delete_red")
            imageDelete.contentMode = UIView.ContentMode.scaleAspectFit
            soViewLine.addSubview(imageDelete)
            
            let line3 = UIView(frame: CGRect(x: line1Voucher.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
            line3.backgroundColor = UIColor(netHex:0x04AB6E)
            soViewLine.addSubview(line3)
            
            let nameProduct = "\(item)"
            //            let sizeNameProduct = nameProduct.height(withConstrainedWidth: viewVoucherLine.frame.size.width - line3.frame.origin.x, font: UIFont.systemFont(ofSize: Common.Size(s:14)))
            let lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: 0, width: viewVoucherLine.frame.size.width - line3.frame.origin.x -  soViewLine.frame.size.height, height: Common.Size(s:40)))
            lbNameProduct.textAlignment = .left
            lbNameProduct.textColor = UIColor.black
            lbNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbNameProduct.text = nameProduct
            lbNameProduct.numberOfLines = 3
            soViewLine.addSubview(lbNameProduct)
            
            let line4 = UIView(frame: CGRect(x: line3.frame.origin.x, y:0, width: viewVoucherLine.frame.size.width - line3.frame.origin.x - 1, height: 1))
            line4.backgroundColor =  UIColor(netHex:0x04AB6E)
            soViewLine.addSubview(line4)
            
            let lbSttValue = UILabel(frame: CGRect(x: 0, y: 0, width: lbSttVoucher.frame.size.width, height: Common.Size(s:40)))
            lbSttValue.textAlignment = .center
            lbSttValue.textColor = UIColor.black
            lbSttValue.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbSttValue.text = "\(numVoucher)"
            soViewLine.addSubview(lbSttValue)
            
            indexHeightVoucher = indexHeightVoucher + soViewLine.frame.size.height
            indexYVoucher = indexYVoucher + soViewLine.frame.size.height + soViewLine.frame.origin.x
            
            soViewLine.tag = numVoucher - 1
            let gestureSwift2AndHigher = UITapGestureRecognizer(target: self, action:  #selector (self.someActionVoucher (_:)))
            soViewLine.addGestureRecognizer(gestureSwift2AndHigher)
        }
        viewVoucherLine.frame.size.height = indexHeightVoucher
        if(Cache.listVoucher.count == 0){
            viewVoucherLine.frame.size.height = 0
            viewVoucherLine.clipsToBounds = true
        }
        lbAddVoucherMore = UILabel(frame: CGRect(x: scrollView.frame.size.width/2, y: viewVoucherLine.frame.size.height + viewVoucherLine.frame.origin.y, width: scrollView.frame.size.width/2 - Common.Size(s:15), height: Common.Size(s: 14)))
        lbAddVoucherMore.textAlignment = .right
        lbAddVoucherMore.textColor = UIColor(netHex:0x04AB6E)
        lbAddVoucherMore.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Thêm mã voucher", attributes: underlineAttribute)
        lbAddVoucherMore.attributedText = underlineAttributedString
        viewVoucher.addSubview(lbAddVoucherMore)
        let tapShowAddVoucher = UITapGestureRecognizer(target: self, action: #selector(PaymentMiraeViewController.tapShowAddVoucher))
        lbAddVoucherMore.isUserInteractionEnabled = true
        lbAddVoucherMore.addGestureRecognizer(tapShowAddVoucher)
        
        viewVoucher.frame.size.height =  lbAddVoucherMore.frame.size.height + lbAddVoucherMore.frame.origin.y
        
        viewBelowToshibaPoint = UIView(frame: CGRect(x: 0, y: viewVoucher.frame.origin.y + viewVoucher.frame.size.height, width: scrollView.frame.size.width, height: Common.Size(s:40)))
        
        viewInfoDetail = UIView(frame: CGRect(x: 0, y: Common.Size(s: 10), width: self.view.frame.size.width, height: 0))
        
        let soViewPhone = UIView()
        viewInfoDetail.addSubview(soViewPhone)
        soViewPhone.frame = CGRect(x: tfUserName.frame.origin.x, y:  Common.Size(s:10), width: tfUserName.frame.size.width, height: 100)
        
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
      
        for item in Cache.cartsMirae{
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
     
        Cache.itemsPromotionTempMirae.removeAll()
        
        for item in Cache.itemsPromotionMirae{
            
            let it = item
            if (it.TienGiam <= 0){
                if (promos.count == 0){
                    promos.append(it)
                    Cache.itemsPromotionTempMirae.append(item)
                }else{
                    for pro in promos {
                        if (pro.SanPham_Tang == it.SanPham_Tang){
                            pro.SL_Tang =  pro.SL_Tang + item.SL_Tang
                        }else{
                            promos.append(it)
                            Cache.itemsPromotionTempMirae.append(item)
                        }
                    }
                }
            }else{
                Cache.itemsPromotionTempMirae.append(item)
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
        
        let lbTotal = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: soViewPromos.frame.origin.y + soViewPromos.frame.size.height + Common.Size(s:20), width: tfUserName.frame.size.width, height: Common.Size(s:20)))
        lbTotal.textAlignment = .left
        lbTotal.textColor = UIColor(netHex:0x47B054)
        lbTotal.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbTotal.text = "THÔNG TIN THANH TOÁN"
        viewInfoDetail.addSubview(lbTotal)
        
        let lblGoiTraGop = UILabel(frame: CGRect(x: Common.Size(s:20), y: lbTotal.frame.origin.y + lbTotal.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lblGoiTraGop.textAlignment = .left
        lblGoiTraGop.textColor = UIColor.black
        lblGoiTraGop.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblGoiTraGop.text = "Gói Trả Góp"
        viewInfoDetail.addSubview(lblGoiTraGop)
        
        tfGoiTraGop = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lblGoiTraGop.frame.origin.y + lblGoiTraGop.frame.size.height + Common.Size(s:10), width: lblGoiTraGop.frame.size.width , height: Common.Size(s:40) ));
        tfGoiTraGop.placeholder = "Chọn Gói Trả Góp"
        tfGoiTraGop.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfGoiTraGop.borderStyle = UITextField.BorderStyle.roundedRect
        tfGoiTraGop.autocorrectionType = UITextAutocorrectionType.no
        tfGoiTraGop.keyboardType = UIKeyboardType.default
        tfGoiTraGop.returnKeyType = UIReturnKeyType.done
        tfGoiTraGop.clearButtonMode = UITextField.ViewMode.whileEditing
        tfGoiTraGop.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfGoiTraGop.delegate = self
        viewInfoDetail.addSubview(tfGoiTraGop)
        
        // Start visible - Default: false
        tfGoiTraGop.startVisible = true
        tfGoiTraGop.theme.bgColor = UIColor.white
        tfGoiTraGop.theme.fontColor = UIColor.black
        tfGoiTraGop.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfGoiTraGop.theme.cellHeight = Common.Size(s:40)
        tfGoiTraGop.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        tfGoiTraGop.leftViewMode = UITextField.ViewMode.always
        
        let viewFocusGoiTraGop = UIView(frame: tfGoiTraGop.frame);
        viewInfoDetail.addSubview(viewFocusGoiTraGop)
        
        let gestureGoiTraGop = UITapGestureRecognizer(target: self, action:  #selector(self.actionGoiTraGop))
        viewFocusGoiTraGop.addGestureRecognizer(gestureGoiTraGop)
  
//        tfGoiTraGop.itemSelectionHandler = { filteredResults, itemPosition in
//            let item = filteredResults[itemPosition]
//            self.tfGoiTraGop.text = item.title
//            let obj =  self.listGoi.filter{ $0.Name == "\(item.title)" }.first
//            if let obj = obj?.laisuat {
//                self.selectGoi = "\(obj)"
//            }
//            if let idgoi = obj?.Code {
//                Cache.infoCustomerMirae!.idgoi = idgoi
//            }
//            Cache.infoCustomerMirae!.goi = self.tfGoiTraGop.text!
//            Cache.infoCustomerMirae!.selectGoi = self.selectGoi
//
//            self.tfSoTienTraTruoc.becomeFirstResponder()
//            self.lbMoTaGoiCuoc.text = "Mô tả: \(obj!.mota)"
//            self.schemecode = "\(obj!.Code)"
//
//            MPOSAPIManager.mpos_FRT_SP_Mirae_LoadKyHan(xmlSP:self.parseXMLKyHan().toBase64(),IDMPOS: "\(self.infoCustomer!.IDMPOS)",schemecode: "\(Cache.infoCustomerMirae!.idgoi )") { (results, err) in
//                let when = DispatchTime.now() + 0.5
//                DispatchQueue.main.asyncAfter(deadline: when) {
//
//                    if(err.count <= 0){
//                        self.listKyHan = results
//                        var list:[String] = []
//                        for item in results {
//                            list.append(item.Name)
//                        }
//                        self.tfkyHan.filterStrings(list)
//
//
//                    }else{
//
//                    }
//                }
//            }
//        }
        
        lbMoTaGoiCuoc = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfGoiTraGop.frame.origin.y + tfGoiTraGop.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:50)))
        lbMoTaGoiCuoc.textAlignment = .left
        lbMoTaGoiCuoc.textColor = UIColor.black
        lbMoTaGoiCuoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbMoTaGoiCuoc.text = "Mô tả:"
        
        lbMoTaGoiCuoc.numberOfLines = 0
        lbMoTaGoiCuoc.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        lbMoTaGoiCuoc.minimumScaleFactor = 0.8
        
        viewInfoDetail.addSubview(lbMoTaGoiCuoc)
        
        let lblSoTienCoc = UILabel(frame: CGRect(x: Common.Size(s:20), y: lbMoTaGoiCuoc.frame.origin.y + lbMoTaGoiCuoc.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lblSoTienCoc.textAlignment = .left
        lblSoTienCoc.textColor = UIColor.black
        lblSoTienCoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSoTienCoc.text = "Số Tiền Cọc Máy Cũ"
        viewInfoDetail.addSubview(lblSoTienCoc)
        
        tfSoTienCoc = UITextField(frame: CGRect(x: Common.Size(s:20), y: lblSoTienCoc.frame.origin.y + lblSoTienCoc.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:70) , height: Common.Size(s:40)));
        tfSoTienCoc.placeholder = "Số Tiền Cọc Máy Cũ"
        tfSoTienCoc.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSoTienCoc.borderStyle = UITextField.BorderStyle.roundedRect
        tfSoTienCoc.autocorrectionType = UITextAutocorrectionType.no
        tfSoTienCoc.keyboardType = UIKeyboardType.numberPad
        tfSoTienCoc.returnKeyType = UIReturnKeyType.done
        tfSoTienCoc.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSoTienCoc.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSoTienCoc.delegate = self
        tfSoTienCoc.isUserInteractionEnabled = false
        viewInfoDetail.addSubview(tfSoTienCoc)
        tfSoTienCoc.text = Common.convertCurrencyFloat(number: Cache.soTienCocMirae)
        
        let btnScan = UIImageView(frame:CGRect(x: tfSoTienCoc.frame.size.width + tfSoTienCoc.frame.origin.x + Common.Size(s: 10) , y:  tfSoTienCoc.frame.origin.y, width: Common.Size(s:30), height: tfSoTienCoc.frame.size.height));
        btnScan.image = #imageLiteral(resourceName: "MaGD")
        btnScan.contentMode = .scaleAspectFit
        viewInfoDetail.addSubview(btnScan)
        
        let tapScan = UITapGestureRecognizer(target: self, action: #selector(actionInputCT(_:)))
        btnScan.isUserInteractionEnabled = true
        btnScan.addGestureRecognizer(tapScan)
        
        
        let lblSoTienTraTruoc = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfSoTienCoc.frame.origin.y + tfSoTienCoc.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lblSoTienTraTruoc.textAlignment = .left
        lblSoTienTraTruoc.textColor = UIColor.black
        lblSoTienTraTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSoTienTraTruoc.text = "Số Tiền Trả Trước Nhập Thêm"
        viewInfoDetail.addSubview(lblSoTienTraTruoc)
        
        tfSoTienTraTruoc = UITextField(frame: CGRect(x: Common.Size(s:20), y: lblSoTienTraTruoc.frame.origin.y + lblSoTienTraTruoc.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfSoTienTraTruoc.placeholder = "Số Tiền Trả Trước"
        tfSoTienTraTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSoTienTraTruoc.borderStyle = UITextField.BorderStyle.roundedRect
        tfSoTienTraTruoc.autocorrectionType = UITextAutocorrectionType.no
        tfSoTienTraTruoc.keyboardType = UIKeyboardType.numberPad
        tfSoTienTraTruoc.returnKeyType = UIReturnKeyType.done
        tfSoTienTraTruoc.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSoTienTraTruoc.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSoTienTraTruoc.delegate = self
        viewInfoDetail.addSubview(tfSoTienTraTruoc)
        tfSoTienTraTruoc.addTarget(self, action: #selector(textFieldDidChangeMoney(_:)), for: .editingChanged)
        
        
      
        
        let lblKyHan = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfSoTienTraTruoc.frame.origin.y + tfSoTienTraTruoc.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lblKyHan.textAlignment = .left
        lblKyHan.textColor = UIColor.black
        lblKyHan.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblKyHan.text = "Kỳ hạn"
        viewInfoDetail.addSubview(lblKyHan)
        
        tfkyHan = SearchTextField(frame: CGRect(x: Common.Size(s:20), y: lblKyHan.frame.origin.y + lblKyHan.frame.size.height + Common.Size(s:10), width: lblKyHan.frame.size.width , height: Common.Size(s:40) ));
        tfkyHan.placeholder = "Chọn kỳ hạn"
        tfkyHan.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfkyHan.borderStyle = UITextField.BorderStyle.roundedRect
        tfkyHan.autocorrectionType = UITextAutocorrectionType.no
        tfkyHan.keyboardType = UIKeyboardType.default
        tfkyHan.returnKeyType = UIReturnKeyType.done
        tfkyHan.clearButtonMode = UITextField.ViewMode.whileEditing
        tfkyHan.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfkyHan.delegate = self
        viewInfoDetail.addSubview(tfkyHan)
        
        // Start visible - Default: false
        tfkyHan.startVisible = true
        tfkyHan.theme.bgColor = UIColor.white
        tfkyHan.theme.fontColor = UIColor.black
        tfkyHan.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfkyHan.theme.cellHeight = Common.Size(s:40)
        tfkyHan.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        tfkyHan.leftViewMode = UITextField.ViewMode.always
        
        tfkyHan.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.tfkyHan.text = item.title
            let obj =  self.listKyHan.filter{ $0.Name == "\(item.title)" }.first
            if let obj = obj?.ID {
                self.selectKyHan = "\(obj)"
            }
            Cache.phithamgia = obj?.ParticipationFeeRate ?? 0
            Cache.infoCustomerMirae!.selectKyhan =    self.selectKyHan
            Cache.infoCustomerMirae!.kyhan = self.tfkyHan.text!
        }
        
        
        //        let totalPay = total()
        //        let discountPay = discount()
        
        let lbTotalText = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: tfkyHan.frame.origin.y + tfkyHan.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbTotalText.textAlignment = .left
        lbTotalText.textColor = UIColor.black
        lbTotalText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbTotalText.text = "Thành tiền:"
        viewInfoDetail.addSubview(lbTotalText)
        
        
        let lbTotalValue = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: tfkyHan.frame.origin.y + tfkyHan.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbTotalValue.textAlignment = .right
        lbTotalValue.textColor = UIColor(netHex:0xEF4A40)
        lbTotalValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbTotalValue.text = Common.convertCurrencyFloat(value: totalPay)
        viewInfoDetail.addSubview(lbTotalValue)
        
        let lbSoTienTraTruocText = UILabel(frame: CGRect(x: lbTotalText.frame.origin.x, y: lbTotalText.frame.origin.y + lbTotalText.frame.size.height, width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbSoTienTraTruocText.textAlignment = .left
        lbSoTienTraTruocText.textColor = UIColor.black
        lbSoTienTraTruocText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbSoTienTraTruocText.text = "Số tiền trả trước:"
        viewInfoDetail.addSubview(lbSoTienTraTruocText)
        
        lbSoTienTraTruocValue = UILabel(frame: CGRect(x: lbSoTienTraTruocText.frame.origin.x, y: lbTotalText.frame.origin.y + lbTotalText.frame.size.height, width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbSoTienTraTruocValue.textAlignment = .right
        lbSoTienTraTruocValue.textColor = UIColor(netHex:0xEF4A40)
        lbSoTienTraTruocValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbSoTienTraTruocValue.text = Common.convertCurrencyFloat(value: discountPay)
        viewInfoDetail.addSubview(lbSoTienTraTruocValue)
        
        let lbSoTienVayText = UILabel(frame: CGRect(x: lbTotalText.frame.origin.x, y: lbSoTienTraTruocText.frame.origin.y + lbSoTienTraTruocText.frame.size.height, width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbSoTienVayText.textAlignment = .left
        lbSoTienVayText.textColor = UIColor.black
        lbSoTienVayText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbSoTienVayText.text = "Số tiền vay:"
        viewInfoDetail.addSubview(lbSoTienVayText)
        
        lbSoTienVayValue = UILabel(frame: CGRect(x: lbSoTienVayText.frame.origin.x, y: lbSoTienTraTruocText.frame.origin.y + lbSoTienTraTruocText.frame.size.height , width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbSoTienVayValue.textAlignment = .right
        lbSoTienVayValue.textColor = UIColor(netHex:0xEF4A40)
        lbSoTienVayValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbSoTienVayValue.text = Common.convertCurrencyFloat(value: discountPay)
        viewInfoDetail.addSubview(lbSoTienVayValue)
        
        let lbPhiBaoHiemText = UILabel(frame: CGRect(x: lbTotalText.frame.origin.x, y: lbSoTienVayText.frame.origin.y + lbSoTienVayText.frame.size.height, width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbPhiBaoHiemText.textAlignment = .left
        lbPhiBaoHiemText.textColor = UIColor.black
        lbPhiBaoHiemText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbPhiBaoHiemText.text = "Phí bảo hiểm:"
        viewInfoDetail.addSubview(lbPhiBaoHiemText)
        
        lbPhiBaoHiemValue = UILabel(frame: CGRect(x: lbPhiBaoHiemText.frame.origin.x, y: lbSoTienVayText.frame.origin.y + lbSoTienVayText.frame.size.height , width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbPhiBaoHiemValue.textAlignment = .right
        lbPhiBaoHiemValue.textColor = UIColor(netHex:0xEF4A40)
        lbPhiBaoHiemValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        //var phibaohiem:Float = 0
        //phibaohiem =  Cache.infoCustomerMirae!.sotienvay * 0.055
       // phibaohiem =  Cache.infoCustomerMirae!.sotienvay * (Cache.infoCustomerMirae!.fee_insurance / 100)
        //lbPhiBaoHiemValue.text = Common.convertCurrencyFloat(value: phibaohiem)
        viewInfoDetail.addSubview(lbPhiBaoHiemValue)
        
        let lbDiscountText = UILabel(frame: CGRect(x: lbTotalText.frame.origin.x, y: lbPhiBaoHiemText.frame.origin.y + lbPhiBaoHiemText.frame.size.height, width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbDiscountText.textAlignment = .left
        lbDiscountText.textColor = UIColor.black
        lbDiscountText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbDiscountText.text = "Giảm giá:"
        viewInfoDetail.addSubview(lbDiscountText)
        
        lbDiscountValue = UILabel(frame: CGRect(x: lbTotalValue.frame.origin.x, y: lbDiscountText.frame.origin.y , width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbDiscountValue.textAlignment = .right
        lbDiscountValue.textColor = UIColor(netHex:0xEF4A40)
        lbDiscountValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbDiscountValue.text = Common.convertCurrencyFloat(value: discountPay)
        viewInfoDetail.addSubview(lbDiscountValue)
        
        let lbPayText = UILabel(frame: CGRect(x: lbDiscountText.frame.origin.x, y: lbDiscountText.frame.origin.y + lbDiscountText.frame.size.height, width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbPayText.textAlignment = .left
        lbPayText.textColor = UIColor.black
        lbPayText.font = UIFont.boldSystemFont(ofSize: 16)
        lbPayText.text = "Tổng thanh toán:"
        viewInfoDetail.addSubview(lbPayText)
        
        lbPayValue = UILabel(frame: CGRect(x: lbPayText.frame.origin.x, y: lbPayText.frame.origin.y , width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbPayValue.textAlignment = .right
        lbPayValue.textColor = UIColor(netHex:0xEF4A40)
        lbPayValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))
        lbPayValue.text = Common.convertCurrencyFloat(value: (totalPay - discountPay))
        viewInfoDetail.addSubview(lbPayValue)
        
        checkTotal = (totalPay - discountPay)
        

        let btPay = UIButton()
        btPay.frame = CGRect(x: tfUserName.frame.origin.x, y: lbPayText.frame.origin.y + lbPayText.frame.size.height + Common.Size(s:20), width: tfUserName.frame.size.width, height: tfUserName.frame.size.height * 1.2)
        btPay.backgroundColor = UIColor(netHex:0xEF4A40)
        btPay.setTitle("Kiểm tra KM", for: .normal)
        
        btPay.addTarget(self, action: #selector(actionPay), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        
        viewInfoDetail.addSubview(btPay)
        viewInfoDetail.frame.size.height = btPay.frame.origin.y + btPay.frame.size.height + Common.Size(s:20)
        //        scrollView.addSubview(viewInfoDetail)
        
        viewBelowToshibaPoint.addSubview(viewInfoDetail)
        viewBelowToshibaPoint.frame.size.height = viewInfoDetail.frame.size.height + viewInfoDetail.frame.origin.y + Common.Size(s: 5)
        scrollView.addSubview(viewBelowToshibaPoint)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewBelowToshibaPoint.frame.origin.y + viewBelowToshibaPoint.frame.size.height + Common.Size(s: 20 + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
        //+ ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        //hide keyboard
        self.hideKeyboardWhenTappedAround()
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin  ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_FRT_SP_Mirae_laythongtinkhachhang_order(IDMPOS: "\(self.infoCustomer!.IDMPOS)") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(results.count > 0){
                        
                        self.tfPhoneNumber.text = results[0].PhoneNumber
                        self.tfCMND.text = results[0].IDCard
                        self.tfDiaChi.text = results[0].P_Address
                        self.tfUserName.text =  results[0].FullName
                        
                        Cache.infoCustomerMirae!.hoten = results[0].FullName
                        Cache.infoCustomerMirae!.sdt = results[0].PhoneNumber
                        Cache.infoCustomerMirae!.diachi = results[0].P_Address
                        Cache.infoCustomerMirae!.cmnd =  results[0].IDCard
                        self.showPopUpVoucherDefault()
                    }
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }

        let rDR1 = Cache().parseXMLProduct().toBase64()
        MPOSAPIManager.mpos_FRT_SP_Mirae_loadscheme(RDR1:"\(rDR1)",partnerId: PARTNERIDORDER) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                
                if(err.count <= 0){
                    self.listGoi = results
                    var list:[String] = []
                    for item in results {
                        list.append(item.Name)
                    }
                    self.tfGoiTraGop.filterStrings(list)
                    
                    
                }else{
                    
                }
            }
        }
  
        
    }
    func returnInstallmentPlan(item:LaiSuatMirae,ind:Int){
 
        self.tfGoiTraGop.text = item.Name
        let obj =  self.listGoi.filter{ $0.Name == "\(item.Name)" }.first
        if let obj = obj?.laisuat {
            self.selectGoi = "\(obj)"
        }
        if let idgoi = obj?.Code {
            Cache.infoCustomerMirae!.idgoi = idgoi
        }
        Cache.infoCustomerMirae!.goi = self.tfGoiTraGop.text!
        Cache.infoCustomerMirae!.selectGoi = self.selectGoi
        
        self.tfSoTienTraTruoc.becomeFirstResponder()
        
        self.tfSoTienTraTruoc.text = ""
        self.lbSoTienTraTruocValue.text = ""
        self.lbSoTienVayValue.text = ""
        self.lbPhiBaoHiemValue.text = ""
        self.lbPayValue.text = ""
        
        self.lbMoTaGoiCuoc.text = "Mô tả: \(obj!.mota)"
        self.schemecode = "\(obj!.Code)"
        Cache.infoCustomerMirae!.fee_insurance =  obj!.fee_insurance
        
        MPOSAPIManager.mpos_FRT_SP_Mirae_LoadKyHan(xmlSP:self.parseXMLKyHan().toBase64(),IDMPOS: "\(self.infoCustomer!.IDMPOS)",schemecode: "\(Cache.infoCustomerMirae!.idgoi )",partnerId: PARTNERIDORDER) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                
                if(err.count <= 0){
                    self.listKyHan.removeAll()
                    self.listKyHan = results
                    var list:[String] = []
                    for item in results {
                        list.append(item.Name)
                    }
                    self.tfkyHan.text = ""
                    self.tfkyHan.filterStrings(list)
                    
                    
                }else{
                    
                }
            }
        }
    }
    
    func parseXMLKyHan()->String{
        var rs:String = "<Data>"
        for item in Cache.cartsMirae {
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
            
            rs = rs + "<row ItemCode=\"\(item.product.sku)\"/>"
        }
        rs = rs + "</Data>"
        print(rs)
        return rs
    }
    @objc func actionGoiTraGop(sender : UITapGestureRecognizer) {
        let myVC = ChooseInstallmentPlanViewController()
        myVC.delegate = self
        myVC.ind = 0
        myVC.items = self.listGoi
        let navController = UINavigationController(rootViewController: myVC)
        self.navigationController?.present(navController, animated:false, completion: nil)
    }
    
    

    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    func actionOpenMenuLeft() {
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func actionInputCT(_: UITapGestureRecognizer){
        
        showInputDialog(title: "Nhập số chứng từ Máy Cũ POS",
                        subtitle: "Vui lòng nhập số chứng từ",
                        actionTitle: "Xác nhận",
                        cancelTitle: "Cancel",
                        inputPlaceholder: "số chứng từ",
                        inputKeyboardType: UIKeyboardType.numberPad, actionHandler:
                            { (input:String?) in
                                print("The pass input is \(input ?? "")")
                                // call api
                                //self.checkAPIPassCode(pass: input!)
                                if(input == ""){
                                    let title = "THÔNG BÁO"
                                    let popup = PopupDialog(title: title, message: "Vui lòng nhập số chứng từ máy cũ !!!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        print("Completed")
                                    }
                                    let buttonOne = CancelButton(title: "OK") {
                                        
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                    return
                                }
                                self.actionGuiCTMayCu(CTmayCu: input!)
                            })
    }
 
    
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.numberPad,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
            textField.isSecureTextEntry = false
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
    func actionGuiCTMayCu(CTmayCu:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang tìm chứng từ máy cũ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_FRT_SP_Mirae_loadTienCTMayCu(CTmayCu: "\(CTmayCu)") { (results, err) in
             nc.post(name: Notification.Name("dismissLoading"), object: nil)
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                if(err.count <= 0){
                    self.tfSoTienCoc.text = Common.convertCurrencyFloat(value: results)
                    Cache.soTienCocMirae = results
                    
                    var sotientratruocStr:String = "0"
                    if(self.tfSoTienTraTruoc.text! != ""){
                      sotientratruocStr = self.tfSoTienTraTruoc.text!
                    }
                    
                    sotientratruocStr = sotientratruocStr.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                    Cache.infoCustomerMirae!.sotientratruocInput = Float(sotientratruocStr)!
                    self.sotientratruoc = Float(sotientratruocStr)! + Cache.soTienCocMirae
                    self.lbSoTienTraTruocValue.text =  Common.convertCurrencyFloat(value: self.sotientratruoc)
                    var khoanvay:Float = 0
                    khoanvay = self.totalPay - self.sotientratruoc
                    self.lbSoTienVayValue.text = Common.convertCurrencyFloat(value: khoanvay)
                    Cache.infoCustomerMirae!.sotienvay = khoanvay
                    var phibaohiem:Float = 0
                    //phibaohiem = khoanvay * 0.055
                    phibaohiem = khoanvay * ( Cache.infoCustomerMirae!.fee_insurance / 100 )
                    self.lbPhiBaoHiemValue.text = Common.convertCurrencyFloat(value: phibaohiem)
                    Cache.infoCustomerMirae!.phibaohiem = phibaohiem
                    var tongkhoanvay:Float = 0
                    tongkhoanvay = khoanvay + phibaohiem
                    var tongdonhang:Float = 0
                    tongdonhang = tongkhoanvay - self.discountPay
                    self.lbPayValue.text = Common.convertCurrencyFloat(value: tongdonhang)
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
        }
    }
    
    @objc func tapShowAddVoucher(sender:UITapGestureRecognizer) {
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
                Cache.listVoucherMirae.append("\(fNameField.text!)")
                self.viewVoucherLine.subviews.forEach { $0.removeFromSuperview() }
                
                let line1Voucher = UIView(frame: CGRect(x: self.viewVoucherLine.frame.size.width * 1.3/10, y: 0, width: 1, height: Common.Size(s:25)))
                line1Voucher.backgroundColor = UIColor(netHex:0x04AB6E)
                self.viewVoucherLine.addSubview(line1Voucher)
                let line2Voucher = UIView(frame: CGRect(x: 0, y:line1Voucher.frame.origin.y + line1Voucher.frame.size.height, width: self.viewVoucherLine.frame.size.width, height: 1))
                line2Voucher.backgroundColor = UIColor(netHex:0x04AB6E)
                self.viewVoucherLine.addSubview(line2Voucher)
                
                let lbSttVoucher = UILabel(frame: CGRect(x: 0, y: line1Voucher.frame.origin.y, width: line1Voucher.frame.origin.x, height: line1Voucher.frame.size.height))
                lbSttVoucher.textAlignment = .center
                lbSttVoucher.textColor = UIColor(netHex:0x04AB6E)
                lbSttVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
                lbSttVoucher.text = "STT"
                self.viewVoucherLine.addSubview(lbSttVoucher)
                
                let lbInfoVoucher = UILabel(frame: CGRect(x: line1Voucher.frame.origin.x, y: line1Voucher.frame.origin.y, width: self.viewVoucherLine.frame.size.width - line1Voucher.frame.origin.x, height: line1Voucher.frame.size.height))
                lbInfoVoucher.textAlignment = .center
                lbInfoVoucher.textColor = UIColor(netHex:0x04AB6E)
                lbInfoVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
                lbInfoVoucher.text = "Mã voucher"
                self.viewVoucherLine.addSubview(lbInfoVoucher)
                
                var indexYVoucher = line2Voucher.frame.origin.y
                var indexHeightVoucher: CGFloat = line2Voucher.frame.origin.y + line2Voucher.frame.size.height
                var numVoucher = 0
                for item in Cache.listVoucherMirae{
                    numVoucher = numVoucher + 1
                    let soViewLine = UIView()
                    self.viewVoucherLine.addSubview(soViewLine)
                    soViewLine.frame = CGRect(x: 0, y: indexYVoucher, width: self.viewVoucherLine.frame.size.width, height: Common.Size(s:40))
                    
                    let imageDelete = UIImageView(frame: CGRect(x: soViewLine.frame.size.width - soViewLine.frame.size.height, y: 0, width: soViewLine.frame.size.height - Common.Size(s:20), height: soViewLine.frame.size.height))
                    imageDelete.image = #imageLiteral(resourceName: "delete_red")
                    imageDelete.contentMode = UIView.ContentMode.scaleAspectFit
                    soViewLine.addSubview(imageDelete)
                    
                    let line3 = UIView(frame: CGRect(x: line1Voucher.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
                    line3.backgroundColor = UIColor(netHex:0x04AB6E)
                    soViewLine.addSubview(line3)
                    
                    let nameProduct = "\(item)"
                    
                    let lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: 0, width: self.viewVoucherLine.frame.size.width - line3.frame.origin.x, height: Common.Size(s:40)))
                    lbNameProduct.textAlignment = .left
                    lbNameProduct.textColor = UIColor.black
                    lbNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                    lbNameProduct.text = nameProduct
                    lbNameProduct.numberOfLines = 3
                    soViewLine.addSubview(lbNameProduct)
                    
                    let line4 = UIView(frame: CGRect(x: line3.frame.origin.x, y:0, width: self.viewVoucherLine.frame.size.width - line3.frame.origin.x - 1, height: 1))
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
                    
                    soViewLine.tag = numVoucher - 1
                    let gestureSwift2AndHigher = UITapGestureRecognizer(target: self, action:  #selector (self.someActionVoucher (_:)))
                    soViewLine.addGestureRecognizer(gestureSwift2AndHigher)
                }
                self.viewVoucherLine.frame.size.height = indexHeightVoucher
                if(Cache.listVoucherMirae.count == 0){
                    self.viewVoucherLine.frame.size.height = 0
                    self.viewVoucherLine.clipsToBounds = true
                }
                self.lbAddVoucherMore.frame.origin.y = self.viewVoucherLine.frame.size.height + self.viewVoucherLine.frame.origin.y
                self.viewVoucher.frame.size.height =  self.lbAddVoucherMore.frame.size.height + self.lbAddVoucherMore.frame.origin.y
                self.viewBelowToshibaPoint.frame.origin.y = self.viewVoucher.frame.origin.y  + self.viewVoucher.frame.size.height + Common.Size(s:20)
              
         
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.viewBelowToshibaPoint.frame.origin.y + self.viewBelowToshibaPoint.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
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
    func showPopUpVoucherDefault(){
      let alertController = UIAlertController(title: "Thêm voucher", message: nil, preferredStyle: .alert)
      
      alertController.addAction(UIAlertAction(title: "Huỷ", style: .default, handler: {
          alert -> Void in
          self.dismiss(animated: true, completion: nil)
      }))
        alertController.addAction(UIAlertAction(title: "Quét mã", style: .default, handler: {
            alert -> Void in
            self.dismiss(animated: true, completion: nil)
            self.actionIntentBarcodeVoucherKhongGia()
        }))
      alertController.addAction(UIAlertAction(title: "Lưu", style: .cancel, handler: {
          alert -> Void in
          let fNameField = alertController.textFields![0] as UITextField
          if fNameField.text != ""{
              self.dismiss(animated: true, completion: nil)
              Cache.listVoucherMirae.append("\(fNameField.text!)")
              self.viewVoucherLine.subviews.forEach { $0.removeFromSuperview() }
              
              let line1Voucher = UIView(frame: CGRect(x: self.viewVoucherLine.frame.size.width * 1.3/10, y: 0, width: 1, height: Common.Size(s:25)))
              line1Voucher.backgroundColor = UIColor(netHex:0x04AB6E)
              self.viewVoucherLine.addSubview(line1Voucher)
              let line2Voucher = UIView(frame: CGRect(x: 0, y:line1Voucher.frame.origin.y + line1Voucher.frame.size.height, width: self.viewVoucherLine.frame.size.width, height: 1))
              line2Voucher.backgroundColor = UIColor(netHex:0x04AB6E)
              self.viewVoucherLine.addSubview(line2Voucher)
              
              let lbSttVoucher = UILabel(frame: CGRect(x: 0, y: line1Voucher.frame.origin.y, width: line1Voucher.frame.origin.x, height: line1Voucher.frame.size.height))
              lbSttVoucher.textAlignment = .center
              lbSttVoucher.textColor = UIColor(netHex:0x04AB6E)
              lbSttVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
              lbSttVoucher.text = "STT"
              self.viewVoucherLine.addSubview(lbSttVoucher)
              
              let lbInfoVoucher = UILabel(frame: CGRect(x: line1Voucher.frame.origin.x, y: line1Voucher.frame.origin.y, width: self.viewVoucherLine.frame.size.width - line1Voucher.frame.origin.x, height: line1Voucher.frame.size.height))
              lbInfoVoucher.textAlignment = .center
              lbInfoVoucher.textColor = UIColor(netHex:0x04AB6E)
              lbInfoVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
              lbInfoVoucher.text = "Mã voucher"
              self.viewVoucherLine.addSubview(lbInfoVoucher)
              
              var indexYVoucher = line2Voucher.frame.origin.y
              var indexHeightVoucher: CGFloat = line2Voucher.frame.origin.y + line2Voucher.frame.size.height
              var numVoucher = 0
              for item in Cache.listVoucherMirae{
                  numVoucher = numVoucher + 1
                  let soViewLine = UIView()
                  self.viewVoucherLine.addSubview(soViewLine)
                  soViewLine.frame = CGRect(x: 0, y: indexYVoucher, width: self.viewVoucherLine.frame.size.width, height: Common.Size(s:40))
                  
                  let imageDelete = UIImageView(frame: CGRect(x: soViewLine.frame.size.width - soViewLine.frame.size.height, y: 0, width: soViewLine.frame.size.height - Common.Size(s:20), height: soViewLine.frame.size.height))
                  imageDelete.image = #imageLiteral(resourceName: "delete_red")
                  imageDelete.contentMode = UIView.ContentMode.scaleAspectFit
                  soViewLine.addSubview(imageDelete)
                  
                  let line3 = UIView(frame: CGRect(x: line1Voucher.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
                  line3.backgroundColor = UIColor(netHex:0x04AB6E)
                  soViewLine.addSubview(line3)
                  
                  let nameProduct = "\(item)"
                  
                  let lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: 0, width: self.viewVoucherLine.frame.size.width - line3.frame.origin.x, height: Common.Size(s:40)))
                  lbNameProduct.textAlignment = .left
                  lbNameProduct.textColor = UIColor.black
                  lbNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                  lbNameProduct.text = nameProduct
                  lbNameProduct.numberOfLines = 3
                  soViewLine.addSubview(lbNameProduct)
                  
                  let line4 = UIView(frame: CGRect(x: line3.frame.origin.x, y:0, width: self.viewVoucherLine.frame.size.width - line3.frame.origin.x - 1, height: 1))
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
                  
                soViewLine.tag = numVoucher - 1
               
                  let gestureSwift2AndHigher = UITapGestureRecognizer(target: self, action:  #selector (self.someActionVoucher (_:)))
                  soViewLine.addGestureRecognizer(gestureSwift2AndHigher)
              }
              self.viewVoucherLine.frame.size.height = indexHeightVoucher
              if(Cache.listVoucherMirae.count == 0){
                  self.viewVoucherLine.frame.size.height = 0
                  self.viewVoucherLine.clipsToBounds = true
              }
              self.lbAddVoucherMore.frame.origin.y = self.viewVoucherLine.frame.size.height + self.viewVoucherLine.frame.origin.y
              self.viewVoucher.frame.size.height =  self.lbAddVoucherMore.frame.size.height + self.lbAddVoucherMore.frame.origin.y
              self.viewBelowToshibaPoint.frame.origin.y = self.viewVoucher.frame.origin.y  + self.viewVoucher.frame.size.height + Common.Size(s:20)
            
       
              self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.viewBelowToshibaPoint.frame.origin.y + self.viewBelowToshibaPoint.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
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
    @objc func someActionVoucher(_ sender:UITapGestureRecognizer){
        let view:UIView = sender.view!
        print("\(view.tag)")
        let aa = Cache.listVoucherMirae[view.tag]
        
        
        let alert = UIAlertController(title: "THÔNG BÁO", message: "Bạn muốn xoá voucher \(aa)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Xoá", style: .destructive) { _ in
            Cache.listVoucherMirae.remove(at: view.tag)
            
            self.viewVoucherLine.subviews.forEach { $0.removeFromSuperview() }
            
            let line1Voucher = UIView(frame: CGRect(x: self.viewVoucherLine.frame.size.width * 1.3/10, y: 0, width: 1, height: Common.Size(s:25)))
            line1Voucher.backgroundColor = UIColor(netHex:0xEF4A40)
            self.viewVoucherLine.addSubview(line1Voucher)
            let line2Voucher = UIView(frame: CGRect(x: 0, y:line1Voucher.frame.origin.y + line1Voucher.frame.size.height, width: self.viewVoucherLine.frame.size.width, height: 1))
            line2Voucher.backgroundColor = UIColor(netHex:0xEF4A40)
            self.viewVoucherLine.addSubview(line2Voucher)
            
            let lbSttVoucher = UILabel(frame: CGRect(x: 0, y: line1Voucher.frame.origin.y, width: line1Voucher.frame.origin.x, height: line1Voucher.frame.size.height))
            lbSttVoucher.textAlignment = .center
            lbSttVoucher.textColor = UIColor(netHex:0xEF4A40)
            lbSttVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbSttVoucher.text = "STT"
            self.viewVoucherLine.addSubview(lbSttVoucher)
            
            let lbInfoVoucher = UILabel(frame: CGRect(x: line1Voucher.frame.origin.x, y: line1Voucher.frame.origin.y, width: self.viewVoucherLine.frame.size.width - line1Voucher.frame.origin.x, height: line1Voucher.frame.size.height))
            lbInfoVoucher.textAlignment = .center
            lbInfoVoucher.textColor = UIColor(netHex:0xEF4A40)
            lbInfoVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbInfoVoucher.text = "Mã voucher"
            self.viewVoucherLine.addSubview(lbInfoVoucher)
            
            var indexYVoucher = line2Voucher.frame.origin.y
            var indexHeightVoucher: CGFloat = line2Voucher.frame.origin.y + line2Voucher.frame.size.height
            var numVoucher = 0
            for item in Cache.listVoucherMirae{
                numVoucher = numVoucher + 1
                let soViewLine = UIView()
                self.viewVoucherLine.addSubview(soViewLine)
                soViewLine.frame = CGRect(x: 0, y: indexYVoucher, width: self.viewVoucherLine.frame.size.width, height: Common.Size(s:40))
                
                let imageDelete = UIImageView(frame: CGRect(x: soViewLine.frame.size.width - soViewLine.frame.size.height, y: 0, width: soViewLine.frame.size.height - Common.Size(s:20), height: soViewLine.frame.size.height))
                imageDelete.image = #imageLiteral(resourceName: "delete_red")
                imageDelete.contentMode = UIView.ContentMode.scaleAspectFit
                soViewLine.addSubview(imageDelete)
                
                let line3 = UIView(frame: CGRect(x: line1Voucher.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
                line3.backgroundColor = UIColor(netHex:0xEF4A40)
                soViewLine.addSubview(line3)
                
                let nameProduct = "\(item)"
                
                let lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: 0, width: self.viewVoucherLine.frame.size.width - line3.frame.origin.x, height: Common.Size(s:40)))
                lbNameProduct.textAlignment = .left
                lbNameProduct.textColor = UIColor.black
                lbNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbNameProduct.text = nameProduct
                lbNameProduct.numberOfLines = 3
                soViewLine.addSubview(lbNameProduct)
                
                let line4 = UIView(frame: CGRect(x: line3.frame.origin.x, y:0, width: self.viewVoucherLine.frame.size.width - line3.frame.origin.x - 1, height: 1))
                line4.backgroundColor = UIColor(netHex:0xEF4A40)
                soViewLine.addSubview(line4)
                
                let lbSttValue = UILabel(frame: CGRect(x: 0, y: 0, width: lbSttVoucher.frame.size.width, height: Common.Size(s:40)))
                lbSttValue.textAlignment = .center
                lbSttValue.textColor = UIColor.black
                lbSttValue.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbSttValue.text = "\(numVoucher)"
                soViewLine.addSubview(lbSttValue)
                
                indexHeightVoucher = indexHeightVoucher + soViewLine.frame.size.height
                indexYVoucher = indexYVoucher + soViewLine.frame.size.height + soViewLine.frame.origin.x
                
                soViewLine.tag = numVoucher - 1
                let gestureSwift2AndHigher = UITapGestureRecognizer(target: self, action:  #selector (self.someActionVoucher (_:)))
                soViewLine.addGestureRecognizer(gestureSwift2AndHigher)
            }
            self.viewVoucherLine.frame.size.height = indexHeightVoucher
            if(Cache.listVoucherMirae.count == 0){
                self.viewVoucherLine.frame.size.height = 0
                self.viewVoucherLine.clipsToBounds = true
            }
            self.lbAddVoucherMore.frame.origin.y = self.viewVoucherLine.frame.size.height + self.viewVoucherLine.frame.origin.y
            self.viewVoucher.frame.size.height =  self.lbAddVoucherMore.frame.size.height + self.lbAddVoucherMore.frame.origin.y
            self.viewBelowToshibaPoint.frame.origin.y = self.viewVoucher.frame.origin.y  + self.viewVoucher.frame.size.height + Common.Size(s:20)

            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.viewBelowToshibaPoint.frame.origin.y + self.viewBelowToshibaPoint.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        })
        
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
    
    @objc func actionIntentBarcodeVoucherKhongGia(){
      
        
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { code in
            if(code != "SELECT_VOUCHER_KHONG_GIA"){
                Cache.listVoucherMirae.append("\(code)")
                self.viewVoucherLine.subviews.forEach { $0.removeFromSuperview() }
                
                let line1Voucher = UIView(frame: CGRect(x: self.viewVoucherLine.frame.size.width * 1.3/10, y: 0, width: 1, height: Common.Size(s:25)))
                line1Voucher.backgroundColor =  UIColor(netHex:0x04AB6E)
                self.viewVoucherLine.addSubview(line1Voucher)
                let line2Voucher = UIView(frame: CGRect(x: 0, y:line1Voucher.frame.origin.y + line1Voucher.frame.size.height, width: self.viewVoucherLine.frame.size.width, height: 1))
                line2Voucher.backgroundColor =  UIColor(netHex:0x04AB6E)
                self.viewVoucherLine.addSubview(line2Voucher)
                
                let lbSttVoucher = UILabel(frame: CGRect(x: 0, y: line1Voucher.frame.origin.y, width: line1Voucher.frame.origin.x, height: line1Voucher.frame.size.height))
                lbSttVoucher.textAlignment = .center
                lbSttVoucher.textColor =  UIColor(netHex:0x04AB6E)
                lbSttVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
                lbSttVoucher.text = "STT"
                self.viewVoucherLine.addSubview(lbSttVoucher)
                
                let lbInfoVoucher = UILabel(frame: CGRect(x: line1Voucher.frame.origin.x, y: line1Voucher.frame.origin.y, width: self.viewVoucherLine.frame.size.width - line1Voucher.frame.origin.x, height: line1Voucher.frame.size.height))
                lbInfoVoucher.textAlignment = .center
                lbInfoVoucher.textColor =  UIColor(netHex:0x04AB6E)
                lbInfoVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
                lbInfoVoucher.text = "Mã voucher"
                self.viewVoucherLine.addSubview(lbInfoVoucher)
                
                var indexYVoucher = line2Voucher.frame.origin.y
                var indexHeightVoucher: CGFloat = line2Voucher.frame.origin.y + line2Voucher.frame.size.height
                var numVoucher = 0
                for item in Cache.listVoucherMirae{
                    numVoucher = numVoucher + 1
                    let soViewLine = UIView()
                    self.viewVoucherLine.addSubview(soViewLine)
                    soViewLine.frame = CGRect(x: 0, y: indexYVoucher, width: self.viewVoucherLine.frame.size.width, height: Common.Size(s:40))
                    
                    let imageDelete = UIImageView(frame: CGRect(x: soViewLine.frame.size.width - soViewLine.frame.size.height, y: 0, width: soViewLine.frame.size.height - Common.Size(s:20), height: soViewLine.frame.size.height))
                    imageDelete.image = #imageLiteral(resourceName: "delete_red")
                    imageDelete.contentMode = UIView.ContentMode.scaleAspectFit
                    soViewLine.addSubview(imageDelete)
                    
                    let line3 = UIView(frame: CGRect(x: line1Voucher.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
                    line3.backgroundColor =  UIColor(netHex:0x04AB6E)
                    soViewLine.addSubview(line3)
                    
                    let nameProduct = "\(item)"
                    
                    let lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: 0, width: self.viewVoucherLine.frame.size.width - line3.frame.origin.x, height: Common.Size(s:40)))
                    lbNameProduct.textAlignment = .left
                    lbNameProduct.textColor = UIColor.black
                    lbNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                    lbNameProduct.text = nameProduct
                    lbNameProduct.numberOfLines = 3
                    soViewLine.addSubview(lbNameProduct)
                    
                    let line4 = UIView(frame: CGRect(x: line3.frame.origin.x, y:0, width: self.viewVoucherLine.frame.size.width - line3.frame.origin.x - 1, height: 1))
                    line4.backgroundColor =  UIColor(netHex:0x04AB6E)
                    soViewLine.addSubview(line4)
                    
                    let lbSttValue = UILabel(frame: CGRect(x: 0, y: 0, width: lbSttVoucher.frame.size.width, height: Common.Size(s:40)))
                    lbSttValue.textAlignment = .center
                    lbSttValue.textColor = UIColor.black
                    lbSttValue.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                    lbSttValue.text = "\(numVoucher)"
                    soViewLine.addSubview(lbSttValue)
                    
                    indexHeightVoucher = indexHeightVoucher + soViewLine.frame.size.height
                    indexYVoucher = indexYVoucher + soViewLine.frame.size.height + soViewLine.frame.origin.x
                    
                    soViewLine.tag = numVoucher - 1
                    let gestureSwift2AndHigher = UITapGestureRecognizer(target: self, action:  #selector (self.someActionVoucher (_:)))
                    soViewLine.addGestureRecognizer(gestureSwift2AndHigher)
                }
                self.viewVoucherLine.frame.size.height = indexHeightVoucher
                if(Cache.listVoucherMirae.count == 0){
                    self.viewVoucherLine.frame.size.height = 0
                    self.viewVoucherLine.clipsToBounds = true
                }
                self.lbAddVoucherMore.frame.origin.y = self.viewVoucherLine.frame.size.height + self.viewVoucherLine.frame.origin.y
                self.viewVoucher.frame.size.height =  self.lbAddVoucherMore.frame.size.height + self.lbAddVoucherMore.frame.origin.y
        
                self.viewBelowToshibaPoint.frame.origin.y = self.viewVoucher.frame.origin.y + self.viewVoucher.frame.size.height
                self.viewBelowToshibaPoint.frame.size.height = self.viewInfoDetail.frame.size.height + self.viewInfoDetail.frame.origin.y + Common.Size(s: 5)
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.viewBelowToshibaPoint.frame.origin.y + self.viewBelowToshibaPoint.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
            }
        }
        self.present(viewController, animated: false, completion: nil)
    }
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        // do other task
        let view:UIView = sender.view!
        let itemCart = Cache.cartsMirae[view.tag]
        let lbImei: UILabel = listImei[view.tag]
        if(itemCart.product.qlSerial == "Y"){
            let newViewController = LoadingViewController()
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(newViewController, animated: true, completion: nil)
            
            MPOSAPIManager.getImeiFF(productCode: "\(itemCart.product.sku)", shopCode: "\(Cache.user!.ShopCode)") { (result, err) in
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
                            for item in Cache.cartsMirae {
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
                                for item in Cache.cartsMirae {
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
                            var checkDatCoc:Bool = false
                            if(Cache.listDatCocMirae.count > 0){
                                for itemDatCoc in Cache.listDatCocMirae{
                                    if(itemDatCoc.sku == itemCart.sku ){
                                        checkDatCoc = true
                                        break
                                    }
                                }
                            }
                            if(checkDatCoc == true){
                                _ = self.navigationController?.popToRootViewController(animated: true)
                                self.dismiss(animated: true, completion: nil)
                                let nc = NotificationCenter.default
                                nc.post(name: Notification.Name("SearchCMNDMirae"), object: nil)
                            }else{
                                _ = self.navigationController?.popViewController(animated: true)
                                self.dismiss(animated: true, completion: nil)
                            }
                       
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
        for item in Cache.itemsPromotionMirae{
            sum = sum + item.TienGiam
        }
        return sum
    }
    func total() ->Float{
        var sum: Float = 0
        for item in Cache.cartsMirae {
            sum = sum + Float(item.quantity) * item.product.price
        }
        return sum
    }
    
    @objc func textFieldDidChangeMoney(_ textField: UITextField) {
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
            self.tfSoTienTraTruoc.text = str
            var sotientratruocStr:String = tfSoTienTraTruoc.text!
          
            sotientratruocStr = sotientratruocStr.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
            Cache.infoCustomerMirae!.sotientratruocInput = Float(sotientratruocStr)!
            sotientratruoc = Float(sotientratruocStr)! + Cache.soTienCocMirae
            self.lbSoTienTraTruocValue.text =  Common.convertCurrencyFloat(value: sotientratruoc)
            var khoanvay:Float = 0
            khoanvay = totalPay - sotientratruoc
            self.lbSoTienVayValue.text = Common.convertCurrencyFloat(value: khoanvay)
            Cache.infoCustomerMirae!.sotienvay = khoanvay
            var phibaohiem:Float = 0
            //phibaohiem = khoanvay * 0.055
            phibaohiem = khoanvay * (Cache.infoCustomerMirae!.fee_insurance / 100)
            self.lbPhiBaoHiemValue.text = Common.convertCurrencyFloat(value: phibaohiem)
            Cache.infoCustomerMirae!.phibaohiem = phibaohiem
            var tongkhoanvay:Float = 0
            tongkhoanvay = khoanvay + phibaohiem
            var tongdonhang:Float = 0
            tongdonhang = tongkhoanvay - discountPay
            self.lbPayValue.text = Common.convertCurrencyFloat(value: tongdonhang)
            
            
        }else{
            textField.text = ""
            self.tfSoTienTraTruoc.text = ""
             self.lbSoTienTraTruocValue.text = ""
            self.lbSoTienVayValue.text = ""
            self.lbPhiBaoHiemValue.text = ""
            self.lbPayValue.text = ""
        }
        
    }
    
    @objc func actionPay() {
        

        
        Cache.promotionsMirae.removeAll()
        Cache.groupMirae = []
        Cache.itemsPromotionFF.removeAll()
        self.promotionsMirae.removeAll()
        self.groupMirae.removeAll()
        
        // check phone
        let phone = tfPhoneNumber.text!
//        if (phone.hasPrefix("01") && phone.count == 11){
//
//        }else if (phone.hasPrefix("0") && !phone.hasPrefix("01") && phone.count == 10){
//
//        }else{
//
//            let alert = UIAlertController(title: "Thông báo", message: "Số điện thoại không hợp lệ!", preferredStyle: .alert)
//
//            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
//
//            })
//            self.present(alert, animated: true)
//            return
//        }
        // check user name
        let name = tfUserName.text!
        if name.count > 0 {
            
        }else{
            let alert = UIAlertController(title: "Thông báo", message: "Tên không được để trống!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        for item in Cache.cartsMirae {
            if (item.product.qlSerial == "Y"){
                if item.imei == "N/A" {
                    let alert = UIAlertController(title: "Thông báo", message: "\(item.product.name) chưa chọn IMEI.", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                        
                    })
                    self.present(alert, animated: true)
                    return
                }
            }
        }
     
        if(self.selectGoi == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa chọn gói trả góp", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        if(self.selectKyHan == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa chọN kỳ hạn!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        var voucher = ""
        if(Cache.listVoucherMirae.count > 0){
            voucher = "<line>"
            for item in Cache.listVoucherMirae{
                voucher  = voucher + "<item voucher=\"\(item)\" />"
            }
            voucher = voucher + "</line>"
        }
        Cache.voucherMirae = voucher
        let nc = NotificationCenter.default
        let newViewController = LoadingViewController()
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(newViewController, animated: true, completion: nil)
      
        let u_cardCode = UserDefaults.standard.string(forKey: "TenCTyTraGop") ?? ""
        MPOSAPIManager.checkPromotionMirae(  u_CrdCod: "\(Cache.infoCustomerMirae!.cmnd)", sdt: "\(phone)", LoaiDonHang: "02", LoaiTraGop: "02", LaiSuat: Float(self.selectGoi)!, SoTienTraTruoc: sotientratruoc,voucher:voucher, kyhan: "\(Cache.infoCustomerMirae!.selectKyhan)", U_cardcode: u_cardCode, HDNum: "\(Cache.infoCustomerMirae!.IDMPOS)",Docentry: "\(Cache.infoCustomerMirae!.pre_docentry)",schemecode:self.schemecode) { (promotion, err) in
            if(promotion != nil){
                //
                let carts = Cache.cartsMirae
                for item2 in carts{
                    item2.inStock = -1
                }
                if let instock = promotion?.productInStock {
                    
                    if instock.count > 0 {
                        
                        for item1 in instock{
                            for item2 in carts{
                                if(item1.MaSP == item2.sku){
                                    item2.inStock = item1.TonKho
                                }
                            }
                        }
                        // het hang
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            //
                            let alert = UIAlertController(title: "Thông báo", message: "Hết hàng ! Vui lòng chọn sản phẩm khác", preferredStyle: .alert)

                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                _ = self.navigationController?.popViewController(animated: true)
                                self.dismiss(animated: true, completion: nil)
                            })
                            self.present(alert, animated: true)
                            //
                      
                        }
                    }else{
                        Cache.infoCustomerMirae!.sotientratruoc = self.sotientratruoc
                        if ((promotion?.productPromotions?.count)! > 0){
                            for item in (promotion?.productPromotions)! {
                                
                                if let val:NSMutableArray = self.promotionsMirae["Nhóm \(item.Nhom)"] {
                                    val.add(item)
                                    self.promotionsMirae.updateValue(val, forKey: "Nhóm \(item.Nhom)")
                                } else {
                                    let arr: NSMutableArray = NSMutableArray()
                                    arr.add(item)
                                    self.promotionsMirae.updateValue(arr, forKey: "Nhóm \(item.Nhom)")
                                    self.groupMirae.append("Nhóm \(item.Nhom)")
                                }
                            }
                            Cache.promotionsMirae = self.promotionsMirae
                            Cache.groupMirae = self.groupMirae
                            
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                let newViewController = PromotionMiraeViewController()
                                Cache.cartsTemp = Cache.cartsMirae
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
                                let newViewController = ReadSOMiraeDetailViewController()
                                newViewController.carts = Cache.cartsMirae
                                newViewController.itemsPromotion = Cache.itemsPromotion
                                
                                self.navigationController?.pushViewController(newViewController, animated: true)
                                
                                
                            }
                        }
                    }
                }else{
                    Cache.infoCustomerMirae!.sotientratruoc = self.sotientratruoc
                    if ((promotion?.productPromotions?.count)! > 0){
                        for item in (promotion?.productPromotions)! {
                            
                            if let val:NSMutableArray = self.promotionsMirae["Nhóm \(item.Nhom)"] {
                                val.add(item)
                                self.promotionsMirae.updateValue(val, forKey: "Nhóm \(item.Nhom)")
                            } else {
                                let arr: NSMutableArray = NSMutableArray()
                                arr.add(item)
                                self.promotionsMirae.updateValue(arr, forKey: "Nhóm \(item.Nhom)")
                                self.groupMirae.append("Nhóm \(item.Nhom)")
                            }
                        }
                        Cache.promotionsMirae = self.promotionsMirae
                        Cache.groupMirae = self.groupMirae
                        
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            let newViewController = PromotionMiraeViewController()
                            Cache.cartsTemp = Cache.cartsMirae
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
                            let newViewController = ReadSOMiraeDetailViewController()
                            newViewController.carts = Cache.cartsMirae
                            newViewController.itemsPromotion = Cache.itemsPromotion
                            
                            self.navigationController?.pushViewController(newViewController, animated: true)
                            
                            
                        }
                    }
                }
                //
         
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
    
    func updateTotal() ->String{
        var sum: Float = 0
        for item in Cache.cartsMirae {
            sum = sum + Float(item.quantity) * item.product.price
        }
        return Common.convertCurrencyFloat(value: sum)
    }
    
}
