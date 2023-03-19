//
//  ReadSOMiraeDetailViewController.swift
//  fptshop
//
//  Created by tan on 6/4/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import DLRadioButton
import PopupDialog
import DLRadioButton
class ReadSOMiraeDetailViewController:  UIViewController,UITextFieldDelegate,UITextViewDelegate {
    var carts:[Cart] = []
    var itemsPromotion: [ProductPromotions] = []
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
    var tfSoTienCoc:UITextField!
    

    var typeCode:String!
    
    var tienTraTruoc:Float = 0
    // var listLimit:[KyHan] = []
 
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
    
    var tfPhoneNumber:UITextField!
    var tfCMND:UITextField!
    var tfDiaChi:UITextField!
    var tfUserName:UITextField!
    
    var tfkyHan:SearchTextField!
    var tfSoTienTraTruoc:UITextField!
    var tfGoiTraGop:SearchTextField!
    
    var lbSoTienVayValue:UILabel!
    var lbPhiBaoHiemValue:UILabel!
    var lbDiscountValue:UILabel!
    var lbPayValue:UILabel!
    var lbSoTienMoiKyValue:UILabel!
    var lbSoTienChenhLechValue:UILabel!
    var lbPhiThamgiaValue:UILabel!
    var phithamgiaValue: Float = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Thanh toán"
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00955E)
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        skuList = ""
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(ReadSOMiraeDetailViewController.actionBack), for: UIControl.Event.touchUpInside)
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
        tfPhoneNumber.text = Cache.infoCustomerMirae!.sdt
        
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
        tfCMND.text = Cache.infoCustomerMirae!.cmnd
        
        
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
        tfUserName.text = Cache.infoCustomerMirae!.hoten
        
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
        tfDiaChi.text = Cache.infoCustomerMirae!.diachi
        
        let viewVoucher = UIView(frame: CGRect(x:0,y:tfDiaChi.frame.origin.y + tfDiaChi.frame.size.height + Common.Size(s:10),width: self.view.frame.size.width,height:100))
        
        scrollView.addSubview(viewVoucher)
        
        let  lbVoucher = UILabel(frame: CGRect(x: tfDiaChi.frame.origin.x, y: Common.Size(s:0), width: tfDiaChi.frame.size.width, height: Common.Size(s:18)))
        lbVoucher.textAlignment = .left
        lbVoucher.textColor = UIColor(netHex:0x04AB6E)
        lbVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbVoucher.text = "VOUCHER KHÔNG GIÁ"
        viewVoucher.addSubview(lbVoucher)
        
        let viewVoucherLine = UIView(frame: CGRect(x:Common.Size(s:20),y:lbVoucher.frame.origin.y + lbVoucher.frame.size.height + Common.Size(s:10),width: self.view.frame.size.width - Common.Size(s:40),height:100))
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
        for item in Cache.listVoucherMirae{
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
    
        
        viewInfoDetail = UIView(frame: CGRect(x: 0, y: viewVoucher.frame.origin.y  + viewVoucher.frame.size.height, width: self.view.frame.size.width, height: 0))
        
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
        for item in Cache.cartsMirae{
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
        Cache.itemsPromotionTempMirae.removeAll()
        
        for item in Cache.itemsPromotionMirae{
            
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
        
        let lblGoiTraGop = UILabel(frame: CGRect(x: Common.Size(s:20), y: lbTotal.frame.origin.y + lbTotal.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lblGoiTraGop.textAlignment = .left
        lblGoiTraGop.textColor = UIColor.black
        lblGoiTraGop.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblGoiTraGop.text = "Gói Trả Góp"
        viewInfoDetail.addSubview(lblGoiTraGop)
        
        tfGoiTraGop = SearchTextField(frame: CGRect(x: Common.Size(s:20), y: lblGoiTraGop.frame.origin.y + lblGoiTraGop.frame.size.height + Common.Size(s:10), width: lblGoiTraGop.frame.size.width , height: Common.Size(s:40) ));
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
        tfGoiTraGop.text = Cache.infoCustomerMirae!.goi
        tfGoiTraGop.isUserInteractionEnabled = false
//        tfGoiTraGop.itemSelectionHandler = { filteredResults, itemPosition in
//            let item = filteredResults[itemPosition]
//            self.tfGoiTraGop.text = item.title
//            let obj =  self.listGoi.filter{ $0.Name == "\(item.title)" }.first
//            if let obj = obj?.laisuat {
//                self.selectGoi = "\(obj)"
//            }
//        }
        
        let lblSoTienCoc = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfGoiTraGop.frame.origin.y + tfGoiTraGop.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lblSoTienCoc.textAlignment = .left
        lblSoTienCoc.textColor = UIColor.black
        lblSoTienCoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSoTienCoc.text = "Số Tiền Cọc Máy Cũ"
        viewInfoDetail.addSubview(lblSoTienCoc)
        
        tfSoTienCoc = UITextField(frame: CGRect(x: Common.Size(s:20), y: lblSoTienCoc.frame.origin.y + lblSoTienCoc.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
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
        
        let lblSoTienTraTruoc = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfSoTienCoc.frame.origin.y + tfSoTienCoc.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lblSoTienTraTruoc.textAlignment = .left
        lblSoTienTraTruoc.textColor = UIColor.black
        lblSoTienTraTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSoTienTraTruoc.text = "Số Tiền Trả Trước Nhập Thêm"
        viewInfoDetail.addSubview(lblSoTienTraTruoc)
        
        tfSoTienTraTruoc = UITextField(frame: CGRect(x: Common.Size(s:20), y: lblSoTienTraTruoc.frame.origin.y + lblSoTienTraTruoc.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfSoTienTraTruoc.placeholder = "Số Tiền Trả Trước Nhập Thêm"
        tfSoTienTraTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSoTienTraTruoc.borderStyle = UITextField.BorderStyle.roundedRect
        tfSoTienTraTruoc.autocorrectionType = UITextAutocorrectionType.no
        tfSoTienTraTruoc.keyboardType = UIKeyboardType.numberPad
        tfSoTienTraTruoc.returnKeyType = UIReturnKeyType.done
        tfSoTienTraTruoc.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSoTienTraTruoc.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSoTienTraTruoc.delegate = self
        viewInfoDetail.addSubview(tfSoTienTraTruoc)
        tfSoTienTraTruoc.isUserInteractionEnabled = false
        tfSoTienTraTruoc.text = Common.convertCurrencyFloat(value: Cache.infoCustomerMirae!.sotientratruocInput)
        //tfSoTienTraTruoc.addTarget(self, action: #selector(textFieldDidChangeMoney(_:)), for: .editingChanged)
        
        let lblKyHan = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfSoTienTraTruoc.frame.origin.y + tfSoTienTraTruoc.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
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
        tfkyHan.text = Cache.infoCustomerMirae!.kyhan
        tfkyHan.isUserInteractionEnabled = false
        
//        tfkyHan.itemSelectionHandler = { filteredResults, itemPosition in
//            let item = filteredResults[itemPosition]
//            self.tfkyHan.text = item.title
//            let obj =  self.listKyHan.filter{ $0.Name == "\(item.title)" }.first
//            if let obj = obj?.ID {
//                self.selectKyHan = "\(obj)"
//            }
//        }
        
        
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
        
        let lbSoTienTraTruocValue = UILabel(frame: CGRect(x: lbSoTienTraTruocText.frame.origin.x, y: lbTotalText.frame.origin.y + lbTotalText.frame.size.height, width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbSoTienTraTruocValue.textAlignment = .right
        lbSoTienTraTruocValue.textColor = UIColor(netHex:0xEF4A40)
        lbSoTienTraTruocValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbSoTienTraTruocValue.text = Common.convertCurrencyFloat(value: Cache.infoCustomerMirae!.sotientratruoc)
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
        //
        var khoanvay:Float = 0
        khoanvay = totalPay - Cache.infoCustomerMirae!.sotientratruoc
        Cache.infoCustomerMirae!.sotienvay = khoanvay - discountPay
        //
        lbSoTienVayValue.text = Common.convertCurrencyFloat(value: Cache.infoCustomerMirae!.sotienvay)
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
        var phibaohiem:Float = 0
        //phibaohiem =  Cache.infoCustomerMirae!.sotienvay * 0.055
        phibaohiem =  Cache.infoCustomerMirae!.sotienvay * (Cache.infoCustomerMirae!.fee_insurance / 100)
        Cache.infoCustomerMirae!.phibaohiem = phibaohiem
        lbPhiBaoHiemValue.text = Common.convertCurrencyFloat(value: Cache.infoCustomerMirae!.phibaohiem)
        viewInfoDetail.addSubview(lbPhiBaoHiemValue)
        
        let lbPhiThamgia = UILabel(frame: CGRect(x: lbTotalText.frame.origin.x, y: lbPhiBaoHiemText.frame.origin.y + lbPhiBaoHiemText.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbPhiThamgia.textAlignment = .left
        lbPhiThamgia.textColor = UIColor.black
        lbPhiThamgia.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbPhiThamgia.text = "Phí tham gia:"
        viewInfoDetail.addSubview(lbPhiThamgia)
        
        phithamgiaValue = (totalPay - discountPay) * Cache.phithamgia / 100 // giá máy sau km * %phi tham gia
        
        
        lbPhiThamgiaValue = UILabel(frame: CGRect(x: lbPhiBaoHiemText.frame.origin.x, y: lbPhiBaoHiemText.frame.origin.y + lbPhiBaoHiemText.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbPhiThamgiaValue.textAlignment = .right
        lbPhiThamgiaValue.textColor = UIColor(netHex:0xEF4A40)
        lbPhiThamgiaValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbPhiThamgiaValue.text = Common.convertCurrencyFloat(value: floor(phithamgiaValue))
        viewInfoDetail.addSubview(lbPhiThamgiaValue)
        
        let lbDiscountText = UILabel(frame: CGRect(x: lbTotalText.frame.origin.x, y: lbPhiThamgia.frame.origin.y + lbPhiThamgia.frame.size.height, width: tfUserName.frame.size.width, height: Common.Size(s:25)))
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
        
        var tongkhoanvay:Float = 0
        let sotienvayDiscount = Cache.infoCustomerMirae!.sotienvay
        tongkhoanvay = sotienvayDiscount + Cache.infoCustomerMirae!.phibaohiem
        
        let lbPayText = UILabel(frame: CGRect(x: lbDiscountText.frame.origin.x, y: lbDiscountText.frame.origin.y + lbDiscountText.frame.size.height, width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbPayText.textAlignment = .left
        lbPayText.textColor = UIColor.black
        lbPayText.font = UIFont.boldSystemFont(ofSize: 17)
        lbPayText.text = "Tổng thanh toán:"
        viewInfoDetail.addSubview(lbPayText)
        
        lbPayValue = UILabel(frame: CGRect(x: lbPayText.frame.origin.x, y: lbPayText.frame.origin.y , width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbPayValue.textAlignment = .right
        lbPayValue.textColor = UIColor(netHex:0xEF4A40)
        lbPayValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))
        lbPayValue.text = Common.convertCurrencyFloat(value: (tongkhoanvay))
        viewInfoDetail.addSubview(lbPayValue)
        self.sumMoney = tongkhoanvay - discountPay
        
        let lbSoTienChenhLech = UILabel(frame: CGRect(x: lbDiscountText.frame.origin.x, y: lbPayValue.frame.origin.y + lbPayValue.frame.size.height, width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbSoTienChenhLech.textAlignment = .left
        lbSoTienChenhLech.textColor = UIColor.black
        lbSoTienChenhLech.font = UIFont.systemFont(ofSize: 16)
        lbSoTienChenhLech.text = "Số tiền chênh lệch:"
        viewInfoDetail.addSubview(lbSoTienChenhLech)
        
        lbSoTienChenhLechValue = UILabel(frame: CGRect(x: lbSoTienChenhLech.frame.origin.x, y: lbPayValue.frame.origin.y + lbPayValue.frame.size.height , width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbSoTienChenhLechValue.textAlignment = .right
        lbSoTienChenhLechValue.text = "0đ"
        lbSoTienChenhLechValue.textColor = UIColor(netHex:0xEF4A40)
        lbSoTienChenhLechValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        viewInfoDetail.addSubview(lbSoTienChenhLechValue)
        
        
        let lbSoTienMoiKy = UILabel(frame: CGRect(x: lbDiscountText.frame.origin.x, y: lbSoTienChenhLechValue.frame.origin.y + lbSoTienChenhLechValue.frame.size.height, width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbSoTienMoiKy.textAlignment = .left
        lbSoTienMoiKy.textColor = UIColor.black
        lbSoTienMoiKy.font = UIFont.systemFont(ofSize: 16)
        lbSoTienMoiKy.text = "Tiền tạm ứng hàng tháng:"
        viewInfoDetail.addSubview(lbSoTienMoiKy)
        
        lbSoTienMoiKyValue = UILabel(frame: CGRect(x: lbSoTienMoiKy.frame.origin.x, y: lbSoTienChenhLechValue.frame.origin.y + lbSoTienChenhLechValue.frame.size.height , width: tfUserName.frame.size.width, height: Common.Size(s:25)))
        lbSoTienMoiKyValue.textAlignment = .right
        lbSoTienMoiKyValue.textColor = UIColor(netHex:0xEF4A40)
        lbSoTienMoiKyValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        
        lbSoTienMoiKyValue.text = Common.convertCurrencyFloat(value: Float(((Cache.infoCustomerMirae!.sotienvay) / Float(Cache.infoCustomerMirae!.selectKyhan)! ).round()))
        viewInfoDetail.addSubview(lbSoTienMoiKyValue)
 

        //        viewInfoTypeShip.frame.size.height = tfAddressDelivery.frame.size.height + tfAddressDelivery.frame.origin.y
        
        btPay = UIButton()
        btPay.frame = CGRect(x: tfPhoneNumber.frame.origin.x, y: lbSoTienMoiKy.frame.origin.y + lbSoTienMoiKy.frame.size.height + Common.Size(s:20), width: tfPhoneNumber.frame.size.width, height: tfPhoneNumber.frame.size.height * 1.2)
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
        
        let rdr1Str = Cache().parseXMLProduct().toBase64()
            MPOSAPIManager.mpos_FRT_SP_mirae_tinhsotienchenhlech(rdr1:rdr1Str,schemecode:"\(Cache.infoCustomerMirae!.idgoi)",Sotienvay:"\(String(format:"%.2f", Cache.infoCustomerMirae!.sotienvay))",kyhan:"\(Cache.infoCustomerMirae!.selectKyhan)",IDmpos:"\(Cache.infoCustomerMirae!.IDMPOS)") {[weak self] (result, err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                if(err.count <= 0){
                    
                    self.lbSoTienChenhLechValue.text = Common.convertCurrencyFloat(value: result)
                    let sum:Float = Cache.infoCustomerMirae!.sotienvay + result
                    self.lbSoTienMoiKyValue.text = Common.convertCurrencyFloat(value: Float(((sum) / Float(Cache.infoCustomerMirae!.selectKyhan)! ).round()) )
                }else{
                    self.showDialog(message: err)
                }
            }
            
            
        }
  

        //self.actionLoadKyHan()
   
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
        for item in Cache.cartsMirae {
            if(skuList == ""){
                skuList = "\(item.product.sku)"
            }else{
                skuList = "\(skuList),\(item.product.sku)"
            }
        }
        var voucher = ""
        if(Cache.listVoucherMirae.count > 0){
            voucher = "<line>"
            for item in Cache.listVoucherMirae{
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
                var tenCtytragop = ""
                tenCtytragop = UserDefaults.standard.string(forKey: "TenCTyTraGop") ?? ""
                MPOSAPIManager.mpos_sp_insert_order_mirae(phone:"\(Cache.infoCustomerMirae!.sdt)",cmnd: "\(Cache.infoCustomerMirae!.cmnd)", CardName: "\(Cache.infoCustomerMirae!.hoten)", U_EplCod: "\(Cache.user!.UserName)", ShopCode: "\(Cache.user!.ShopCode)", Sotientratruoc: "\(String(format: "%.6f", Cache.infoCustomerMirae!.sotientratruoc))", Doctype: "\(02)", U_des: "", RDR1: rDR1, PROMOS: pROMOS, LoaiTraGop: "02", LaiSuat: "\(Cache.infoCustomerMirae!.selectGoi)", voucher: "", otp: "", NgayDenShopMua: "", HinhThucGH: "", DiaChi: "\(Cache.infoCustomerMirae!.diachi)", magioithieu: "", kyhan: "\(Cache.infoCustomerMirae!.selectKyhan)", Thanhtien: "\(String(format:"%.2f", sumMoney))", IDcardcode: "\(Cache.infoCustomerMirae!.IDMPOS)", HinhThucThuTien: "\(hinhThucThuTien)", soHDtragop: "\(Cache.infoCustomerMirae!.processId)", IsSkip: "\(IsCheck)", AuthenBy: "\(AuthenBy)",chemecode: "\(Cache.infoCustomerMirae!.idgoi)",pre_docentry: "\(Cache.infoCustomerMirae!.pre_docentry)",tenCtyTraGop: tenCtytragop, handler: { (returnCode, docentry, returnMessage)  in
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        //-----
                        
                        if (returnCode == 0){
                            Cache.itemsPromotionTempMirae.removeAll()
                            Cache.cartsMirae.removeAll()
                            Cache.listVoucherMirae = []
                 
                            
                            let alert = UIAlertController(title: "Thông báo", message: returnMessage, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
//                                _ = self.navigationController?.popToRootViewController(animated: true)
//                                self.dismiss(animated: true, completion: nil)
//                                let nc = NotificationCenter.default
//                                nc.post(name: Notification.Name("showDetailSO"), object: nil)
                                
                                _ = self.navigationController?.popToRootViewController(animated: true)
                                self.dismiss(animated: true, completion: nil)
                                let nc = NotificationCenter.default
                                nc.post(name: Notification.Name("SearchCMNDMirae"), object: nil)
                            })
                            self.present(alert, animated: true)
                        }else{
                            self.buttonSaveAction = false
                            let alert = UIAlertController(title: "Thông báo", message: "\(returnMessage) \r\n User: \(Cache.user!.UserName) \r\n ShopCode: \(Cache.user!.ShopCode) \r\n Số HĐ:\(Cache.infoCustomerMirae!.processId)", preferredStyle: .alert)
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
        for item in Cache.itemsPromotionMirae {
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
            
            rs = rs + "<item U_ItmCod=\"\(item.sku)\" U_Imei=\"\(item.imei)\" U_Quantity=\"\(item.quantity)\"  U_Price=\"\(String(format: "%.6f", item.product.price))\" U_WhsCod=\"\(Cache.user!.ShopCode)010\" U_ItmName=\"\(name)\"/>"
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
