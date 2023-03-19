//
//  PaymentViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/30/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import DLRadioButton
import ActionSheetPicker_3_0
import SkyFloatingLabelTextField
import AVFoundation
import Toaster
class PaymentVNPTViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,ScanIMEIControllerDelegate,ScanVoucherKhongGiaControllerDelegate {
    

    var scrollView:UIScrollView!
    var tfPhoneNumber:SkyFloatingLabelTextFieldWithIcon!
    var tfUserName:SkyFloatingLabelTextFieldWithIcon!
    var tfUserAddress:SkyFloatingLabelTextFieldWithIcon!
    var tfUserEmail:SkyFloatingLabelTextFieldWithIcon!
    var tfUserBirthday:SkyFloatingLabelTextFieldWithIcon!
    var tfInterestRate:UITextField!
    var tfPrepay:UITextField!
    //    var tfVoucher:UITextField!
    
    var taskNotes: UITextView!
    var placeholderLabel : UILabel!
    var genderType:Int = -1
    var orderType:Int = -1
    var orderPayType:Int = -1
    var orderPayInstallment:Int = -1
    var radioAtTheCounter:DLRadioButton!
    var radioInstallment:DLRadioButton!
    var radioDeposit:DLRadioButton!
    var radioPayNow:DLRadioButton!
    var radioPayNotNow:DLRadioButton!
    
    var radioMan:DLRadioButton!
    var radioWoman:DLRadioButton!
    
    var radioPayInstallmentCom:DLRadioButton!
    var radioPayInstallmentCard:DLRadioButton!
    
    var listImei:[UILabel] = []
    
    var lbPayType:UILabel!
    
    var viewInstallment:UIView!
    var viewInstallmentHeight: CGFloat = 0.0
    
    var viewInfoDetail: UIView!
    
    var promotions: [String:NSMutableArray] = [:]
    var group: [String] = []
    
    var viewToshibaPoint:UIView!
    var viewBelowToshibaPoint:UIView!
    var lbFPoint,lbFCoin,lbRanking:UILabel!
    var viewInstallmentCard:UIView!
    var viewInstallmentCom:UIView!
    var companyButton: SearchTextField!
    
    var tfPrepayCom,tfContractNumber,tfCMND,tfInterestRateCom,tfLimit:UITextField!
    var listCompany:[VendorInstallment] = []
    
    var maCty:String!
    
    var debitCustomer:DebitCustomer!
    
    var listDebitCustomer: [DebitCustomer] = []
    
    var itemCart:Cart!
    var lbImei: UILabel!
    
    var viewVoucher,viewVoucherLine :UIView!
    var lbAddVoucherMore:UILabel!
    var viewFull:UIView!
    var lblChonThueBao:UILabel!
    var isShowlblChonThueBao:Bool = false
    var telecomChooseSo:String!
    var maGoiCuocBookSim:String!
    var tenGoiCuocBookSim:String!
    var giaGoiCuocBookSim:Float!
    
    var isScanImei: Bool = true
    
    var radioTGYes:DLRadioButton!
    var radioTGNo :DLRadioButton!
    var isTG: Int = 0
    //---
    var listLbDiscount:[UILabel] = []
    var discountPay:Float = 0.0
    var lbPayValue,lbDiscountValue:UILabel!
    var totalPay:Float = 0.0
    var groupSKU: [String] = []
    var listKho:[UILabel] = []
    var listTonKhoSPKhongIMEI: [String:NSMutableArray] = [:]
    //--
    
    var radioTGSSYes:DLRadioButton!
    var radioTGSSNo :DLRadioButton!
    var is_samsung: Int = 0
    
    var radioDHDUYes:DLRadioButton!
    var radioDHDUNo :DLRadioButton!
    var is_DH_DuAn: String = "N"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "Đơn hàng"
        isScanImei = true
        listImei = []
        listKho = []
        groupSKU = []
        discountPay = 0
        totalPay = 0
        
        let btDeleteIcon = UIButton.init(type: .custom)
        btDeleteIcon.setImage(#imageLiteral(resourceName: "Delete"), for: UIControl.State.normal)
        btDeleteIcon.imageView?.contentMode = .scaleAspectFit
        btDeleteIcon.addTarget(self, action: #selector(PaymentVNPTViewController.actionDelete), for: UIControl.Event.touchUpInside)
        btDeleteIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
      
        let btRightIcon = UIButton.init(type: .custom)
        btRightIcon.setImage(#imageLiteral(resourceName: "home"), for: UIControl.State.normal)
        btRightIcon.imageView?.contentMode = .scaleAspectFit
        btRightIcon.addTarget(self, action: #selector(PaymentVNPTViewController.actionHome), for: UIControl.Event.touchUpInside)
        btRightIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        let barRight = UIBarButtonItem(customView: btRightIcon)
        
        self.navigationItem.rightBarButtonItems = [barRight]
        
        var listSKU = ""
        for item in Cache.carts{
            // 00001891 la ma sp doi diem thuong
            if (item.product.qlSerial != "Y" && item.product.sku != Common.skuKHTT){
                if(listSKU == ""){
//                    listSKU = "\(item.product.sku)"
                    listSKU = "\(item.sku)"
                }else{
//                    listSKU = "\(listSKU),\(item.product.sku)"
                    listSKU = "\(listSKU),\(item.sku)"
                }
            }
        }
        print("listSKU \(listSKU)")
        
        if(listSKU == ""){
            loadUI()
        }else{
            let newViewController = LoadingViewController()
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            newViewController.content = "Đang kiểm tra thông tin sản phẩm..."
            self.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            MPOSAPIManager.inov_listTonKhoSanPham(listmasp: listSKU, handler: { (results, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        var listSKUHetHang = ""
                        for item in results{
                            if(item.tonkho <= 0){
                                if(listSKUHetHang == ""){
                                    listSKUHetHang = "\(item.itemcode)"
                                }else{
                                    listSKUHetHang = "\(listSKUHetHang),\(item.itemcode)"
                                }
                                for item2 in Cache.carts{
                                    if(item.itemcode == item2.sku){
                                        item2.inStock = 0
                                        break
                                    }
                                }
                            }
                        }
                        if(listSKUHetHang != ""){
                            let alertController = UIAlertController(title: "HẾT HÀNG", message: "Mã sản phẩm \(listSKUHetHang) đã hết hàng tại shop!", preferredStyle: .alert)
                            
                            let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                                _ = self.navigationController?.popViewController(animated: true)
                                self.dismiss(animated: true, completion: nil)
                            }
                            alertController.addAction(confirmAction)
                            
                            self.present(alertController, animated: true, completion: nil)
                        }else{
                            for item in results {
                                if let val:NSMutableArray = self.listTonKhoSPKhongIMEI["\(item.itemcode)"] {
                                    val.add(item)
                                    self.listTonKhoSPKhongIMEI.updateValue(val, forKey: "\(item.itemcode)")
                                } else {
                                    let arr: NSMutableArray = NSMutableArray()
                                    arr.add(item)
                                    self.listTonKhoSPKhongIMEI.updateValue(arr, forKey: "\(item.itemcode)")
                                }
                            }
                            self.loadUI()
                        }
                    }else{
                        let alertController = UIAlertController(title: "Thông báo", message: "Không thể kiểm tra thông tin sản phẩm, vui lòng thử lại sau!", preferredStyle: .alert)
                        
                        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                            
                            _ = self.navigationController?.popViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                        }
                        alertController.addAction(confirmAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            })
        }
    }
    func loadUI(){
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let lbUserInfo = UILabel(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:18)))
        lbUserInfo.textAlignment = .left
        lbUserInfo.textColor = UIColor(netHex:0x04AB6E)
        lbUserInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbUserInfo.text = "THÔNG TIN KHÁCH HÀNG"
        scrollView.addSubview(lbUserInfo)
        
        
        //input name info
         tfUserName = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:20), y: lbUserInfo.frame.origin.y + lbUserInfo.frame.size.height + Common.Size(s:10), width:  UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40) ), iconType: .image);
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
         tfUserName.addTarget(self, action: #selector(textFieldDidChangeName(_:)), for: .editingChanged)
         tfUserName.text = Cache.name
         scrollView.addSubview(tfUserName)
         tfUserName.text = Cache.infoCMNDVNPT!.TenKH
        tfUserName.isUserInteractionEnabled = false
        
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
        tfPhoneNumber.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tfPhoneNumber.text = Cache.phone
        tfPhoneNumber.keyboardType = .numberPad
        scrollView.addSubview(tfPhoneNumber)
        tfPhoneNumber.text = "\(Cache.infoCMNDVNPT!.SDT)"
        
        tfPhoneNumber.isUserInteractionEnabled = false
        
  
        
        //input email
        tfUserEmail = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: tfPhoneNumber.frame.origin.x, y: tfPhoneNumber.frame.origin.y + tfPhoneNumber.frame.size.height + Common.Size(s:10), width: tfPhoneNumber.frame.size.width , height: tfPhoneNumber.frame.size.height ), iconType: .image);
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
        tfUserEmail.addTarget(self, action: #selector(textFieldDidChangeEmail(_:)), for: .editingChanged)
        tfUserEmail.text = Cache.infoCMNDVNPT!.CMND
        tfUserEmail.isUserInteractionEnabled = false
   
        
        
      
   
        
        viewInfoDetail = UIView(frame: CGRect(x: 0, y: tfUserEmail.frame.origin.y  + tfUserEmail.frame.size.height, width: self.view.frame.size.width, height: 0))
              scrollView.addSubview(viewInfoDetail)
   
 
        viewVoucher = UIView(frame: CGRect(x:0,y: Common.Size(s:10),width:viewInfoDetail.frame.size.width,height:100))
        //        viewVoucher.backgroundColor = .yellow
        viewInfoDetail.addSubview(viewVoucher)
        
        let  lbVoucher = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: Common.Size(s:10), width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
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
        
        viewVoucherLine = UIView(frame: CGRect(x:Common.Size(s:20),y:lbVoucher.frame.origin.y + lbVoucher.frame.size.height + Common.Size(s:10),width:viewInfoDetail.frame.size.width - Common.Size(s:40),height:100))
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
        for item in Cache.listVoucherVNPT{
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
        if(Cache.listVoucherVNPT.count == 0){
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
        let tapShowAddVoucher = UITapGestureRecognizer(target: self, action: #selector(PaymentViewController.tapShowAddVoucher))
        lbAddVoucherMore.isUserInteractionEnabled = true
        lbAddVoucherMore.addGestureRecognizer(tapShowAddVoucher)
        
        viewVoucher.frame.size.height =  lbAddVoucherMore.frame.size.height + lbAddVoucherMore.frame.origin.y
        //input phone number
        //        tfVoucher = UITextField(frame: CGRect(x: Common.Size(s:20), y: radioPayNotNow.frame.origin.y + radioPayNotNow.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        //        tfVoucher.placeholder = "Nhập voucher không giá (nếu có)"
        //        tfVoucher.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        //        tfVoucher.borderStyle = UITextField.BorderStyle.roundedRect
        //        tfVoucher.autocorrectionType = UITextAutocorrectionType.no
        //        tfVoucher.keyboardType = UIKeyboardType.default
        //        tfVoucher.returnKeyType = UIReturnKeyType.done
        //        tfVoucher.clearButtonMode = UITextField.ViewMode.whileEditing;
        //        tfVoucher.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        //        tfVoucher.delegate = self
        //        viewInfoDetail.addSubview(tfVoucher)
        //        viewInfoDetail.backgroundColor = .red
        //
        //        tfVoucher.leftViewMode = UITextField.ViewMode.always
        //        let imageVoucher = UIImageView(frame: CGRect(x: tfVoucher.frame.size.height/4, y: tfVoucher.frame.size.height/4, width: tfVoucher.frame.size.height/2, height: tfVoucher.frame.size.height/2))
        //        imageVoucher.image = #imageLiteral(resourceName: "Vourcher")
        //        imageVoucher.contentMode = UIView.ContentMode.scaleAspectFit
        //
        //        let leftVoucherViewPhone = UIView()
        //        leftVoucherViewPhone.addSubview(imageVoucher)
        //        leftVoucherViewPhone.frame = CGRect(x: 0, y: 0, width: tfVoucher.frame.size.height, height: tfVoucher.frame.size.height)
        //        tfVoucher.leftView = leftVoucherViewPhone
        
        viewFull = UIView(frame: CGRect(x:viewInfoDetail.frame.origin.x,y:viewVoucher.frame.origin.y  + viewVoucher.frame.size.height + Common.Size(s:20),width:viewInfoDetail.frame.width ,height:0))
        
        viewInfoDetail.addSubview(viewFull)
        
  
        
        
        let soViewPhone = UIView()
        viewFull.addSubview(soViewPhone)
        soViewPhone.frame = CGRect(x: tfUserName.frame.origin.x, y:  Common.Size(s:10), width: tfUserName.frame.size.width, height: 100)
        
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
        var numKho = 0
        //        var totalPay:Float = 0.0
        var isShowSupportEmployee: Bool = false
        for item in Cache.cartsVNPT{
            if (item.product.qlSerial != "Y") {
                isShowSupportEmployee = true
            }
            //check hien lblChonThueBao
            print("labelName:  \(item.product.labelName)")
            if(item.product.labelName == "Y"){
                self.telecomChooseSo = item.product.brandName
                self.maGoiCuocBookSim = item.product.sku
                self.tenGoiCuocBookSim = item.product.name
                self.giaGoiCuocBookSim = item.product.price
                isShowlblChonThueBao = true
                
            }
            
            //
            num = num + 1
            totalPay = totalPay + (item.product.price * Float(item.quantity))
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
            listImei.append(lbQuantityProduct)
            
            lbQuantityProduct.numberOfLines = 1
            soViewLine.addSubview(lbQuantityProduct)
            
            let lbPriceProduct = UILabel(frame: CGRect(x: lbQuantityProduct.frame.origin.x , y: lbQuantityProduct.frame.origin.y + lbQuantityProduct.frame.size.height + Common.Size(s:5), width: lbQuantityProduct.frame.size.width/2, height: Common.Size(s:14)))
            lbPriceProduct.textAlignment = .left
            lbPriceProduct.textColor = UIColor(netHex:0xEF4A40)
            lbPriceProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbPriceProduct.text = "Giá: \(Common.convertCurrencyFloat(value: (item.product.price)))"
            lbPriceProduct.numberOfLines = 1
            soViewLine.addSubview(lbPriceProduct)
            
 
            
            if (item.product.qlSerial != "Y" && item.product.sku != Common.skuKHTT){
                
                groupSKU.append(item.product.sku)
                let lbStock = UILabel(frame: CGRect(x: lbNameProduct.frame.origin.x , y: lbPriceProduct.frame.origin.y + lbPriceProduct.frame.size.height + Common.Size(s:15), width: lbNameProduct.frame.size.width/4, height: Common.Size(s:14)))
                lbStock.textAlignment = .left
                lbStock.textColor = UIColor.black
                lbStock.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbStock.text = "Kho con:"
                soViewLine.addSubview(lbStock)
                
                let soSelectStock = UIView(frame:CGRect(x: lbStock.frame.origin.x + lbStock.frame.size.width, y: lbStock.frame.origin.y - Common.Size(s:5), width: lbNameProduct.frame.size.width * 3/4, height: lbStock.frame.size.height + Common.Size(s:10)))
                soViewLine.addSubview(soSelectStock)
                soSelectStock.layer.borderWidth = 0.5
                soSelectStock.layer.borderColor = UIColor(netHex:0x47B054).cgColor
                soSelectStock.layer.cornerRadius = 3.0
                soSelectStock.tag = numKho
                numKho = numKho + 1
                
                let tapShowSelectStock = UITapGestureRecognizer(target: self, action:  #selector (PaymentViewController.tapShowSelectStock (_:)))
                soSelectStock.addGestureRecognizer(tapShowSelectStock)
                
                let imageDown = UIImageView(frame: CGRect(x: soSelectStock.frame.size.width - soSelectStock.frame.size.height, y:0, width: soSelectStock.frame.size.height, height: soSelectStock.frame.size.height))
                imageDown.image = #imageLiteral(resourceName: "Down-1")
                imageDown.contentMode = UIView.ContentMode.scaleAspectFit
                soSelectStock.addSubview(imageDown)
                
                let stock = UILabel(frame: CGRect(x: Common.Size(s:5) , y: 0, width: soSelectStock.frame.size.width - Common.Size(s:10), height: soSelectStock.frame.size.height))
                stock.textAlignment = .left
                stock.textColor = UIColor.black
                stock.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                stock.text = ""
                soSelectStock.addSubview(stock)
                listKho.append(stock)
                
                for item1 in listTonKhoSPKhongIMEI{
                    if("\(item1.key)" == item.product.sku){
                        let tonKho:TonKhoSanPham = item1.value[0] as! TonKhoSanPham
                        stock.text = tonKho.whsname
                        item.whsCode = tonKho.whscode
                        break
                    }
                }
                
                let lbSttValue = UILabel(frame: CGRect(x: 0, y: 0, width: lbStt.frame.size.width, height: lbStt.frame.size.height))
                lbSttValue.textAlignment = .center
                lbSttValue.textColor = UIColor.black
                lbSttValue.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbSttValue.text = "\(num)"
                soViewLine.addSubview(lbSttValue)
                
                soViewLine.frame = CGRect(x: soViewLine.frame.origin.x, y: soViewLine.frame.origin.y, width: soViewLine.frame.size.width, height: lbStock.frame.origin.y + lbStock.frame.size.height + Common.Size(s:15))
                
                line3.frame.size.height = soViewLine.frame.size.height
                
                indexHeight = indexHeight + soViewLine.frame.size.height
                indexY = indexY + soViewLine.frame.size.height + soViewLine.frame.origin.x
                
                soViewLine.tag = num - 1
                let gestureSwift2AndHigher = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
                soViewLine.addGestureRecognizer(gestureSwift2AndHigher)
            }else{
                
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
        }
        
        soViewPhone.frame.size.height = indexHeight
        
        
        let soViewPromos = UIView()
        soViewPromos.frame = CGRect(x: soViewPhone.frame.origin.x, y: soViewPhone.frame.origin.y + soViewPhone.frame.size.height + Common.Size(s:10), width: soViewPhone.frame.size.width, height: 0)
        viewFull.addSubview(soViewPromos)
        
        var promos:[ProductPromotions] = []
        //        var discountPay:Float = 0.0
        Cache.itemsPromotionTempVNPT.removeAll()
        
        for item in Cache.itemsPromotionVNPT{
            
            let it = item
            if (it.TienGiam <= 0){
                if (promos.count == 0){
                    promos.append(it)
                    Cache.itemsPromotionTempVNPT.append(item)
                }else{
                    for pro in promos {
                        if (pro.SanPham_Tang == it.SanPham_Tang){
                            pro.SL_Tang =  pro.SL_Tang + item.SL_Tang
                        }else{
                            promos.append(it)
                            Cache.itemsPromotionTempVNPT.append(item)
                        }
                    }
                }
            }else{
                Cache.itemsPromotionTempVNPT.append(item)
                discountPay = discountPay + it.TienGiam
            }
        }
        for item in  Cache.itemsPromotionTempVNPT{
            print("aâ \(item.SL_Tang) \(item.TenSanPham_Tang)")
        }
        
        if (promos.count>0){
            let lbSOPromos = UILabel(frame: CGRect(x: 0, y: 0, width: soViewPhone.frame.size.width, height: Common.Size(s:18)))
            lbSOPromos.textAlignment = .left
            lbSOPromos.textColor = UIColor(netHex:0x04AB6E)
            lbSOPromos.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbSOPromos.text = "THÔNG TIN KHUYẾN MÃI"
            soViewPromos.addSubview(lbSOPromos)
            
            let line1Promos = UIView(frame: CGRect(x: soViewPromos.frame.size.width * 1.3/10, y:lbSOPromos.frame.origin.y + lbSOPromos.frame.size.height + Common.Size(s:10), width: 1, height: Common.Size(s:25)))
            line1Promos.backgroundColor = UIColor(netHex:0xEF4A40)
            soViewPromos.addSubview(line1Promos)
            let line2Promos = UIView(frame: CGRect(x: 0, y:line1Promos.frame.origin.y + line1Promos.frame.size.height, width: soViewPromos.frame.size.width, height: 1))
            line2Promos.backgroundColor = UIColor(netHex:0xEF4A40)
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
                line3.backgroundColor = UIColor(netHex:0xEF4A40)
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
                line4.backgroundColor = UIColor(netHex:0xEF4A40)
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
        
        
        lblChonThueBao = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: soViewPromos.frame.origin.y + soViewPromos.frame.size.height + Common.Size(s:20), width: tfUserEmail.frame.size.width, height: 0))
        lblChonThueBao.textAlignment = .left
        lblChonThueBao.textColor = UIColor.red
        lblChonThueBao.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        lblChonThueBao.text = "Chọn số thuê bao"
        
        let tapChonThueBao = UITapGestureRecognizer(target: self, action: #selector(PaymentViewController.tapChonThueBao))
        lblChonThueBao.isUserInteractionEnabled = true
        lblChonThueBao.addGestureRecognizer(tapChonThueBao)
        
        viewFull.addSubview(lblChonThueBao)
        
        if(isShowlblChonThueBao == true){
            
            lblChonThueBao.frame.size.height = Common.Size(s: 20)
        }
        
        let lblChooseSupportEmployee = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: lblChonThueBao.frame.origin.y + lblChonThueBao.frame.size.height + Common.Size(s:15), width: tfUserEmail.frame.size.width, height: 0))
        lblChooseSupportEmployee.textAlignment = .left
        lblChooseSupportEmployee.textColor = UIColor.red
        lblChooseSupportEmployee.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        lblChooseSupportEmployee.text = "NV hỗ trợ"
        
        let chooseSupportEmployee = UITapGestureRecognizer(target: self, action: #selector(PaymentViewController.tapChooseSupportEmployee))
        lblChooseSupportEmployee.isUserInteractionEnabled = true
        lblChooseSupportEmployee.addGestureRecognizer(chooseSupportEmployee)
        viewFull.addSubview(lblChooseSupportEmployee)
        
        if(isShowSupportEmployee){
            lblChooseSupportEmployee.frame.size.height = Common.Size(s: 20)
        }

        //        let lbTotal = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: soViewPromos.frame.origin.y + soViewPromos.frame.size.height + Common.Size(s:20), width: tfUserEmail.frame.size.width, height: Common.Size(s:20)))
        //        lbTotal.textAlignment = .left
        //        lbTotal.textColor = UIColor(netHex:0xEF4A40)
        //        lbTotal.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        //        lbTotal.text = "THÔNG TIN THANH TOÁN"
        //        viewFull.addSubview(lbTotal)
        
        
        let lbTotal = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: lblChooseSupportEmployee.frame.origin.y + lblChooseSupportEmployee.frame.size.height + Common.Size(s:20), width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbTotal.textAlignment = .left
        lbTotal.textColor = UIColor(netHex:0x04AB6E)
        lbTotal.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbTotal.text = "THÔNG TIN THANH TOÁN"
        viewFull.addSubview(lbTotal)
        
        
        //        let totalPay = total()
        //        let discountPay = discount()
        
        let lbTotalText = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: lbTotal.frame.origin.y + lbTotal.frame.size.height + Common.Size(s:10), width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbTotalText.textAlignment = .left
        lbTotalText.textColor = UIColor.black
        lbTotalText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbTotalText.text = "Tổng đơn hàng:"
        viewFull.addSubview(lbTotalText)
        
        
        let lbTotalValue = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: lbTotal.frame.origin.y + lbTotal.frame.size.height + Common.Size(s:10), width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbTotalValue.textAlignment = .right
        lbTotalValue.textColor = UIColor(netHex:0xEF4A40)
        lbTotalValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbTotalValue.text = Common.convertCurrencyFloat(value: totalPay)
        viewFull.addSubview(lbTotalValue)
        
        let lbDiscountText = UILabel(frame: CGRect(x: lbTotalText.frame.origin.x, y: lbTotalText.frame.origin.y + lbTotalText.frame.size.height, width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbDiscountText.textAlignment = .left
        lbDiscountText.textColor = UIColor.black
        lbDiscountText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbDiscountText.text = "Giảm giá:"
        viewFull.addSubview(lbDiscountText)
        
        lbDiscountValue = UILabel(frame: CGRect(x: lbTotalValue.frame.origin.x, y: lbDiscountText.frame.origin.y , width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbDiscountValue.textAlignment = .right
        lbDiscountValue.textColor = UIColor(netHex:0xEF4A40)
        lbDiscountValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbDiscountValue.text = Common.convertCurrencyFloat(value: discountPay)
        viewFull.addSubview(lbDiscountValue)
        
        let lbPayText = UILabel(frame: CGRect(x: lbDiscountText.frame.origin.x, y: lbDiscountText.frame.origin.y + lbDiscountText.frame.size.height, width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbPayText.textAlignment = .left
        lbPayText.textColor = UIColor.black
        lbPayText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbPayText.text = "Tổng thanh toán:"
        viewFull.addSubview(lbPayText)
        
        lbPayValue = UILabel(frame: CGRect(x: lbPayText.frame.origin.x, y: lbPayText.frame.origin.y , width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbPayValue.textAlignment = .right
        lbPayValue.textColor = UIColor(netHex:0xEF4A40)
        lbPayValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))
        lbPayValue.text = Common.convertCurrencyFloat(value: (totalPay - discountPay))
        viewFull.addSubview(lbPayValue)
        
        let btPay = UIButton()
        btPay.frame = CGRect(x: tfUserEmail.frame.origin.x, y: lbPayValue.frame.origin.y + lbPayValue.frame.size.height + Common.Size(s:20), width: tfUserEmail.frame.size.width, height: tfUserEmail.frame.size.height * 1.2)
        btPay.backgroundColor = UIColor(netHex:0xD0021B)
        btPay.setTitle("KIỂM TRA KHUYẾN MÃI", for: .normal)
        btPay.addTarget(self, action: #selector(actionCheckKMVC), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        
        viewFull.addSubview(btPay)
        viewFull.frame.size.height = btPay.frame.origin.y + btPay.frame.size.height + Common.Size(s:20)
        viewInfoDetail.frame.size.height = viewFull.frame.origin.y + viewFull.frame.size.height
        scrollView.addSubview(viewInfoDetail)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetail.frame.origin.y + viewInfoDetail.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        //hide keyboard
        self.hideKeyboardWhenTappedAround()
        

    }
    @objc func tapShowSelectStock(_ sender:UITapGestureRecognizer) {
        let view:UIView = sender.view!
        let lbKho = listKho[view.tag]
        let sku = groupSKU[view.tag]
        for item in listTonKhoSPKhongIMEI{
            if("\(item.key)" == sku){
                if(item.value.count <= 1){
                    let tonKho:TonKhoSanPham = item.value[0] as! TonKhoSanPham
                    lbKho.text = tonKho.whsname
                    for i in Cache.carts{
                        if(i.sku == sku){
                            i.whsCode = tonKho.whscode
                            break
                        }
                    }
                }else{
                    var arrDate:[String] = []
                    for ite in item.value{
                        let it:TonKhoSanPham = ite as! TonKhoSanPham
                        arrDate.append(it.whsname)
                    }
                    ActionSheetStringPicker.show(withTitle: "Chọn kho", rows: arrDate, initialSelection: 0, doneBlock: {
                        picker, value, index1 in
                        lbKho.text = (item.value[value] as! TonKhoSanPham).whsname
                        for i in Cache.carts{
                            if(i.sku == sku){
                                i.whsCode = (item.value[value] as! TonKhoSanPham).whscode
                                break
                            }
                        }
                        return
                    }, cancel: { ActionStringCancelBlock in
                        return
                    }, origin: self.view)
                }
                
                break
            }
        }
    }
 
    func discountSuccess(indx: Int, discount: Int, id: String, note: String,userapprove:String) {
        let item = Cache.carts[indx]
        item.discount = discount
        item.reason = "\(id)"
        item.note = note
        item.userapprove = userapprove
        if( item.discount > 0){
            let lbDiscount = listLbDiscount[indx]
            lbDiscount.textColor = UIColor.blue
            let underlineAttribute1 = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString1 = NSAttributedString(string: "Giảm: \(Common.convertCurrency(value: item.discount))", attributes: underlineAttribute1)
            lbDiscount.attributedText = underlineAttributedString1
        }else{
            let lbDiscount = listLbDiscount[indx]
            lbDiscount.textColor = UIColor(netHex:0xEF4A40)
            let underlineAttribute1 = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString1 = NSAttributedString(string: "Giảm giá", attributes: underlineAttribute1)
            lbDiscount.attributedText = underlineAttributedString1
        }
        
        discountPay = 0
        for item in Cache.itemsPromotion{
            discountPay = discountPay + item.TienGiam
        }
        for item in Cache.carts{
            discountPay = discountPay + Float(item.discount)
        }
        
        //        discountPay = Float(discount) + discountPay
        lbDiscountValue.text = Common.convertCurrencyFloat(value: discountPay)
        lbPayValue.text = Common.convertCurrency(value: (Int(totalPay) - Int(discountPay)))
    }
    @objc func tapChonThueBao(){
        let goiCuoc:GoiCuocBookSimV2! = GoiCuocBookSimV2(MaSP: self.maGoiCuocBookSim, TenSP: self.tenGoiCuocBookSim, GiaCuoc: Int(self.giaGoiCuocBookSim), DanhDauSS: false, isRule: true, tenKH: Cache.name)
        
        
        let newViewController = ChooseSoGioHangViewController()
        newViewController.nhaMang = self.telecomChooseSo
        newViewController.goiCuoc = goiCuoc
        self.navigationController?.pushViewController(newViewController, animated: true)
        
        
        
    }
    @objc func tapChooseSupportEmployee(){
        let newViewController = ChooseSupportEmployeeViewController()
  
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func supportEmployee(is_sale_MDMH: String, is_sale_software: String) {
        Cache.is_sale_MDMH = is_sale_MDMH
        Cache.is_sale_software = is_sale_software
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
                Cache.listVoucherVNPT.append("\(fNameField.text!)")
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
                for item in Cache.listVoucherVNPT{
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
                if(Cache.listVoucherVNPT.count == 0){
                    self.viewVoucherLine.frame.size.height = 0
                    self.viewVoucherLine.clipsToBounds = true
                }
                self.lbAddVoucherMore.frame.origin.y = self.viewVoucherLine.frame.size.height + self.viewVoucherLine.frame.origin.y
                self.viewVoucher.frame.size.height =  self.lbAddVoucherMore.frame.size.height + self.lbAddVoucherMore.frame.origin.y
                self.viewFull.frame.origin.y = self.viewVoucher.frame.origin.y  + self.viewVoucher.frame.size.height + Common.Size(s:20)
                self.viewInfoDetail.frame.size.height = self.viewFull.frame.origin.y + self.viewFull.frame.size.height
        
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.viewInfoDetail.frame.origin.y + self.viewInfoDetail.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
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
        let aa = Cache.listVoucherVNPT[view.tag]
        
        
        let alert = UIAlertController(title: "THÔNG BÁO", message: "Bạn muốn xoá voucher \(aa)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Xoá", style: .destructive) { _ in
            Cache.listVoucherVNPT.remove(at: view.tag)
            
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
            for item in Cache.listVoucherVNPT{
                numVoucher = numVoucher + 1
                let soViewLine = UIView()
                self.viewVoucherLine.addSubview(soViewLine)
                soViewLine.frame = CGRect(x: 0, y: indexYVoucher, width: self.viewVoucherLine.frame.size.width, height: Common.Size(s:40))
                
                let imageDelete = UIImageView(frame: CGRect(x: soViewLine.frame.size.width - soViewLine.frame.size.height, y: 0, width: soViewLine.frame.size.height - Common.Size(s:20), height: soViewLine.frame.size.height))
                imageDelete.image = #imageLiteral(resourceName: "DeleteVoucher")
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
            if(Cache.listVoucherVNPT.count == 0){
                self.viewVoucherLine.frame.size.height = 0
                self.viewVoucherLine.clipsToBounds = true
            }
            self.lbAddVoucherMore.frame.origin.y = self.viewVoucherLine.frame.size.height + self.viewVoucherLine.frame.origin.y
            self.viewVoucher.frame.size.height =  self.lbAddVoucherMore.frame.size.height + self.lbAddVoucherMore.frame.origin.y
            self.viewFull.frame.origin.y = self.viewVoucher.frame.origin.y  + self.viewVoucher.frame.size.height + Common.Size(s:20)
            self.viewInfoDetail.frame.size.height = self.viewFull.frame.origin.y + self.viewFull.frame.size.height
     
            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.viewInfoDetail.frame.origin.y + self.viewInfoDetail.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        })
        
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
    

    func showDialog(text:String){
        let alert = UIAlertController(title: "Thông báo", message: text, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
            
        })
        self.present(alert, animated: true)
    }
   
    

    @objc func someAction(_ sender:UITapGestureRecognizer){
        isScanImei = true
        // do other task
        let view:UIView = sender.view!
        itemCart = Cache.cartsVNPT[view.tag]
        self.lbImei = listImei[view.tag]
        if(itemCart.product.qlSerial == "Y"){
               self.loadImei()
                
//            }
        }else{
            if (itemCart.product.id == 2 || itemCart.product.id == 3){
                let alert = UIAlertController(title: "IMEI Máy", message: "", preferredStyle: .alert)
                alert.addTextField { (textField) in
                    textField.placeholder = "IMEI của máy"
                    let heightConstraint = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Common.Size(s: 25))
                    textField.addConstraint(heightConstraint)
                    textField.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
                    textField.keyboardType = .default
                }
                alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: { (_) in
                    
                }))
                alert.addAction(UIAlertAction(title: "Scan Imei", style: .default, handler: { (_) in
                    let viewController = ScanCodeViewController()
                    viewController.onClickBack = {
                        if(self.isScanImei){
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                self.loadImei()
                            }
                        }
                    }
                    viewController.scanSuccess = { code in
                            print("Barcode Data: \(code)")
                        self.scanSuccess(text: code)
                    }
                    self.present(viewController, animated: false, completion: nil)
                }))
                alert.addAction(UIAlertAction(title: "Xác nhận", style: .default, handler: { [weak alert] (_) in
                    if var username = alert?.textFields![0].text  {
                        username = username.trim()
                        if(username.count > 0){
                            self.itemCart.imei = username
                            self.lbImei.text = "IMEI: \(self.itemCart.imei)"
                        }else{
                            Toast.init(text: "Bạn phải nhập IMEI của máy.").show()
                        }
                    }else{
                        Toast.init(text: "Bạn phải nhập IMEI của máy.").show()
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func scanSuccessVoucher(_ viewController: ScanVoucherKhongGiaController, scan: String){
        print("VOUCHER_KG \(scan)")
        if(scan != "SELECT_VOUCHER_KHONG_GIA"){
            Cache.listVoucher.append("\(scan)")
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
            for item in Cache.listVoucher{
                numVoucher = numVoucher + 1
                let soViewLine = UIView()
                self.viewVoucherLine.addSubview(soViewLine)
                soViewLine.frame = CGRect(x: 0, y: indexYVoucher, width: self.viewVoucherLine.frame.size.width, height: Common.Size(s:40))
                
                let imageDelete = UIImageView(frame: CGRect(x: soViewLine.frame.size.width - soViewLine.frame.size.height, y: 0, width: soViewLine.frame.size.height - Common.Size(s:20), height: soViewLine.frame.size.height))
                imageDelete.image = #imageLiteral(resourceName: "DeleteVoucher")
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
            if(Cache.listVoucher.count == 0){
                self.viewVoucherLine.frame.size.height = 0
                self.viewVoucherLine.clipsToBounds = true
            }
            self.lbAddVoucherMore.frame.origin.y = self.viewVoucherLine.frame.size.height + self.viewVoucherLine.frame.origin.y
            self.viewVoucher.frame.size.height =  self.lbAddVoucherMore.frame.size.height + self.lbAddVoucherMore.frame.origin.y
            self.viewFull.frame.origin.y = self.viewVoucher.frame.origin.y  + self.viewVoucher.frame.size.height + Common.Size(s:20)
            self.viewInfoDetail.frame.size.height = self.viewFull.frame.origin.y + self.viewFull.frame.size.height
            self.viewBelowToshibaPoint.frame.size.height = self.viewInfoDetail.frame.size.height + self.viewInfoDetail.frame.origin.y + Common.Size(s: 5)
            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewBelowToshibaPoint.frame.origin.y + viewBelowToshibaPoint.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        }
        
    }
    func scanSuccess(_ viewController: ScanIMEIController, scan: String) {
        print("IMEI \(scan)")
        if(scan != "SELECT_IMEI"){
            
            let newViewController = LoadingViewController()
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(newViewController, animated: true, completion: nil)
            
            MPOSAPIManager.getImei(productCode: "\(itemCart.product.sku)", shopCode: "\(Cache.user!.ShopCode)") { (result, err) in
                let nc = NotificationCenter.default
                if (result.count > 0){
                    var checkImei: Bool = false
                    for item in result {
                        if(scan == item.DistNumber){
                            checkImei = true
                            let when = DispatchTime.now() + 1
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                
                                var check: Bool = true
                                for item in Cache.carts {
                                    if (item.product.qlSerial == "Y"){
                                        if item.imei == "\(String(describing: scan))" {
                                            check = false
                                            break
                                        }
                                    }
                                }
                                if (check == true) {
                                    
                                    if(result.count > 1){
                                         var dateStringCurrent = ""
                                        if let theDate = Date(jsonDate: "\(item.CreateDate)") {
                                            let dayTimePeriodFormatter = DateFormatter()
                                            dayTimePeriodFormatter.dateFormat = "dd/MM/YY"
                                             dateStringCurrent = dayTimePeriodFormatter.string(from: theDate)
                                        }
                                        var dateStringFirst = ""
                                        if let theDate = Date(jsonDate: "\(result[0].CreateDate)") {
                                            let dayTimePeriodFormatter = DateFormatter()
                                            dayTimePeriodFormatter.dateFormat = "dd/MM/YY"
                                            dateStringFirst = dayTimePeriodFormatter.string(from: theDate)
                                        }
                                        
                                        if (dateStringCurrent != dateStringFirst){
                                            let alert = UIAlertController(title: "CHÚ Ý", message:"Bạn chọn IMEI sai FIFO", preferredStyle: .alert)
                                            
                                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                                
                                            })
                                            self.present(alert, animated: true)
                                        }
                                    }
                                    
                                    self.itemCart.imei = item.DistNumber
                                    self.itemCart.whsCode = "\(item.WhsCode)"
                                    self.lbImei.text = "IMEI: \(self.itemCart.imei)"
                                }else{
                                    let alert = UIAlertController(title: "CHÚ Ý", message: "Bạn chọn IMEI máy bị trùng!", preferredStyle: .alert)
                                    
                                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                        
                                    })
                                    self.present(alert, animated: true)
                                }
                                
                            }
                            break
                        }
                    }
                    if(!checkImei){
                        self.showDialogOutOfStock(imei: scan)
                    }
                }else{
                    self.showDialogOutOfStock(imei: "")
                }
            }
            
            
        }else{
            let when = DispatchTime.now() + 0.3
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.loadImei()
            }
            
        }
    }
    func loadImei(){
        let newViewController = LoadingViewController()
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(newViewController, animated: true, completion: nil)
        
        MPOSAPIManager.getImei(productCode: "\(itemCart.product.sku)", shopCode: "\(Cache.user!.ShopCode)") { (result, err) in
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
                            self.itemCart.imei = arr[0]
                            self.itemCart.whsCode = whsCodes[0]
                            self.lbImei.text = "IMEI: \(self.itemCart.imei)"
                        }else{
                            let alert = UIAlertController(title: "CHÚ Ý", message: "Bạn chọn IMEI máy bị trùng!", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                
                            })
                            self.present(alert, animated: true)
                        }
                        
                    }
                    
                }else{
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        /*
                        let alert = UIAlertController(title: "IMEI Máy", message: "", preferredStyle: .alert)
                        alert.addTextField { (textField) in
                            textField.placeholder = "IMEI của máy"
                            let heightConstraint = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Common.Size(s: 25))
                            textField.addConstraint(heightConstraint)
                            textField.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
                            textField.keyboardType = .default
                        }
                        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: { (_) in
                            
                        }))
                        alert.addAction(UIAlertAction(title: "Xác nhận", style: .default, handler: { [weak alert] (_) in
                            if var username = alert?.textFields![0].text  {
                                username = username.trim()
                                if(username.count > 0){
                                    var check: Bool = true
                                    for item in Cache.carts {
                                        if (item.product.qlSerial == "Y"){
                                            if item.imei == "\(String(describing: username))" {
                                                check = false
                                                break
                                            }
                                        }
                                    }
                                    if (check == true) {
                                        var imeiS = ""
                                        var whsS = ""
                                        for item1 in result {
                                            if(item1.DistNumber == "\(username)"){
                                                imeiS = username
                                                whsS = "\(item1.WhsCode)"
                                                break
                                            }
                                        }
                                        if(imeiS != ""){
                                            self.itemCart.imei = "\(imeiS)"
                                            self.itemCart.whsCode = whsS
                                            self.lbImei.text = "IMEI: \(self.itemCart.imei)"
                                        }else{
                                            let alert = UIAlertController(title: "CHÚ Ý", message: "Không tìm thấy IMEI bạn nhập.", preferredStyle: .alert)
                                            
                                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                                
                                            })
                                            self.present(alert, animated: true)
                                        }
                                    }else{
                                        let alert = UIAlertController(title: "CHÚ Ý", message: "Bạn chọn IMEI máy bị trùng!", preferredStyle: .alert)
                                        
                                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                            
                                        })
                                        self.present(alert, animated: true)
                                    }
                                }else{
                                     Toast.init(text: "Bạn phải nhập IMEI của máy.").show()
                                }
                            }else{
                                Toast.init(text: "Bạn phải nhập IMEI của máy.").show()
                            }
                        }))
                        self.present(alert, animated: true, completion: nil)
                        */
                        
                        // CHON IMEI
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
                                        let alert = UIAlertController(title: "CHÚ Ý", message:"Bạn chọn IMEI sai FIFO", preferredStyle: .alert)
                                        
                                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                            
                                        })
                                        self.present(alert, animated: true)
                                    }
                                }
                                
                                self.itemCart.imei = "\(arr[value])"
                                self.itemCart.whsCode = whsCodes[value]
                                self.lbImei.text = "IMEI: \(self.itemCart.imei)"
                            }else{
                                let alert = UIAlertController(title: "CHÚ Ý", message: "Bạn chọn IMEI máy bị trùng!", preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                    
                                })
                                self.present(alert, animated: true)
                            }
                            return
                        }, cancel: { ActionStringCancelBlock in
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            return
                        }, origin: self.view)
                    }
                    
                }
            }else{
                self.showDialogOutOfStock(imei: "")
            }
        }
    }
    func showDialogOutOfStock(imei:String){
        let nc = NotificationCenter.default
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                
                var mgs = "Sản phẩm bạn chọn đã hết hàng tại shop!"
                if(!imei.isEmpty){
                    mgs = "Không tìm thấy IMEI \(imei) trong kho!"
                }
                
                let alert = UIAlertController(title: "HẾT HÀNG", message: mgs, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    if(imei.isEmpty){
                        self.itemCart.inStock = 0
                        _ = self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                    }
                })
                self.present(alert, animated: true)
            }
        }
    }
    @objc func actionHome(){
        _ = self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    func discount() ->Float{
        var sum:Float = 0.0
        for item in Cache.itemsPromotion{
            sum = sum + item.TienGiam
        }
        return sum
    }
    func total() ->Float{
        var sum: Float = 0
        for item in Cache.carts {
            sum = sum + Float(item.quantity) * item.product.price
        }
        return sum
    }
    @objc func textFieldDidChangeName(_ textField: UITextField) {
        Cache.name = textField.text!
    }
    @objc func textFieldDidChangeAddress(_ textField: UITextField) {
        Cache.address = textField.text!
    }
    @objc func textFieldDidChangeEmail(_ textField: UITextField) {
        Cache.email = textField.text!
    }
    @objc func textFieldDidChangeInterestRate(_ textField: UITextField) {
        Cache.vlInterestRate = textField.text!
    }
    @objc func textFieldDidChangePrepay(_ textField: UITextField) {
        Cache.vlPrepay = textField.text!
    }
    @objc func textFieldDidChangeBirthday(_ textField: UITextField) {
        Cache.vlBirthday = textField.text!
    }
    @objc func actionIntentBarcodeVoucherKhongGia(){
        isScanImei = false
        
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { code in
            self.scanSuccess(text: code)
        }
        self.present(viewController, animated: false, completion: nil)
    }
    
    func scanSuccess(text: String) {
        if(self.isScanImei){
                if(text != "SELECT_IMEI"){
                    if(self.itemCart.product.qlSerial == "Y"){
                        let newViewController = LoadingViewController()
                        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                        self.present(newViewController, animated: true, completion: nil)
                        
                        MPOSAPIManager.getImei(productCode: "\(self.itemCart.product.sku)", shopCode: "\(Cache.user!.ShopCode)") { (result, err) in
                            let nc = NotificationCenter.default
                            if (result.count > 0){
                                var checkImei: Bool = false
                                for item in result {
                                    if(text == item.DistNumber){
                                        checkImei = true
                                        let when = DispatchTime.now() + 1
                                        DispatchQueue.main.asyncAfter(deadline: when) {
                                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                            
                                            var check: Bool = true
                                            for item in Cache.carts {
                                                if (item.product.qlSerial == "Y"){
                                                    if item.imei == "\(String(describing: text))" {
                                                        check = false
                                                        break
                                                    }
                                                }
                                            }
                                            if (check == true) {
                                                if(result.count > 1){
                                                    var dateStringCurrent = ""
                                                    if let theDate = Date(jsonDate: "\(item.CreateDate)") {
                                                        let dayTimePeriodFormatter = DateFormatter()
                                                        dayTimePeriodFormatter.dateFormat = "dd/MM/YY"
                                                        dateStringCurrent = dayTimePeriodFormatter.string(from: theDate)
                                                    }
                                                    var dateStringFirst = ""
                                                    if let theDate = Date(jsonDate: "\(result[0].CreateDate)") {
                                                        let dayTimePeriodFormatter = DateFormatter()
                                                        dayTimePeriodFormatter.dateFormat = "dd/MM/YY"
                                                        dateStringFirst = dayTimePeriodFormatter.string(from: theDate)
                                                    }
                                                    
                                                    if (dateStringCurrent != dateStringFirst){
                                                        let alert = UIAlertController(title: "CHÚ Ý", message:"Bạn chọn IMEI sai FIFO", preferredStyle: .alert)
                                                        
                                                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                                            
                                                        })
                                                        self.present(alert, animated: true)
                                                    }
                                                }
                                                self.itemCart.imei = item.DistNumber
                                                self.itemCart.whsCode = "\(item.WhsCode)"
                                                self.lbImei.text = "IMEI: \(self.itemCart.imei)"
                                            }else{
                                                let alert = UIAlertController(title: "CHÚ Ý", message: "Bạn chọn IMEI máy bị trùng!", preferredStyle: .alert)
                                                
                                                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                                    
                                                })
                                                self.present(alert, animated: true)
                                            }
                                            
                                        }
                                        break
                                    }
                                }
                                if(!checkImei){
                                    self.showDialogOutOfStock(imei: text)
                                }
                            }else{
                                self.showDialogOutOfStock(imei: "")
                            }
                        }
                    }else{
                        if (self.itemCart.product.id == 2 || self.itemCart.product.id == 3){
                            self.itemCart.imei = text
                            self.lbImei.text = "IMEI: \(self.itemCart.imei)"
                        }
                    }
                    
                    
                    
                }else{
                    let when = DispatchTime.now() + 0.3
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        self.loadImei()
                    }
                    
                }
                
            }else{
                if(text != "SELECT_VOUCHER_KHONG_GIA"){
                    Cache.listVoucherVNPT.append("\(text)")
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
                    for item in Cache.listVoucherVNPT{
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
                    if(Cache.listVoucherVNPT.count == 0){
                        self.viewVoucherLine.frame.size.height = 0
                        self.viewVoucherLine.clipsToBounds = true
                    }
                    self.lbAddVoucherMore.frame.origin.y = self.viewVoucherLine.frame.size.height + self.viewVoucherLine.frame.origin.y
                    self.viewVoucher.frame.size.height =  self.lbAddVoucherMore.frame.size.height + self.lbAddVoucherMore.frame.origin.y
                    self.viewFull.frame.origin.y = self.viewVoucher.frame.origin.y  + self.viewVoucher.frame.size.height + Common.Size(s:20)
                    self.viewInfoDetail.frame.size.height = self.viewFull.frame.origin.y + self.viewFull.frame.size.height
                    self.viewBelowToshibaPoint.frame.size.height = self.viewInfoDetail.frame.size.height + self.viewInfoDetail.frame.origin.y + Common.Size(s: 5)
                    self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.viewBelowToshibaPoint.frame.origin.y + self.viewBelowToshibaPoint.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                }
            }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let phone = textField.text!
        if phone.count > 9 {
            if phone.hasPrefix("01") {
                if phone.count>10{
                    Cache.phone = phone
                    
                    MPOSAPIManager.searchCustomersToshiba(phoneNumber: "\(phone)", handler: { (results, err) in
                        if(results.count > 0){
                            let customer = results[0]
                            Cache.name = customer.name
                            Cache.code = customer.code
                            Cache.address = customer.address
                            Cache.email = customer.email
                            self.tfUserName.text = customer.name
                            self.tfUserAddress.text = customer.address
                            self.tfUserEmail.text = customer.email
                            
                            //                            if let theDate = Date(jsonDate: "\(customer.NgaySinh)") {
                            //                                let dayTimePeriodFormatter = DateFormatter()
                            //                                dayTimePeriodFormatter.dateFormat = "dd/MM/yyyy"
                            //                                let dateString = dayTimePeriodFormatter.string(from: theDate)
                            //self.tfUserBirthday.text = "\(customer.NgaySinh)"
                            //                            }
                            self.tfUserBirthday.text = "\(customer.NgaySinh)"
                            if (customer.gioitinh == 1){
                                self.radioMan.isSelected = true
                                self.genderType = 1
                            }else if (customer.gioitinh == 0){
                                self.radioWoman.isSelected = true
                                self.genderType = 0
                            }
                            Cache.genderType = customer.gioitinh
                            if(customer.ocrd_FF == "Y"){
                                self.tfUserName.isUserInteractionEnabled = false
                                self.tfUserAddress.isUserInteractionEnabled = false
                                self.tfUserEmail.isUserInteractionEnabled = false
                                self.tfUserBirthday.isUserInteractionEnabled = false
                                if (customer.gioitinh == 1){
                                    self.radioWoman.isEnabled = false
                                }else if (customer.gioitinh == 0){
                                    self.radioMan.isEnabled = false
                                }
                            }else{
                                self.tfUserName.isUserInteractionEnabled = true
                                self.tfUserAddress.isUserInteractionEnabled = true
                                self.tfUserEmail.isUserInteractionEnabled = true
                                self.tfUserBirthday.isUserInteractionEnabled = true
                                self.radioWoman.isEnabled = true
                                self.radioMan.isEnabled = true
                            }
                            
                            if(customer.p_flag == 1){
                                let alert = UIAlertController(title: "Thông báo", message: customer.p_messagess, preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                    
                                })
                                self.present(alert, animated: true)
                            }
                        }
                        if(self.orderType == 2 && self.orderPayInstallment == 0){
                            let newViewController = LoadingViewController()
                            newViewController.content = "Đang lấy thông tin nhà trả góp..."
                            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                            self.navigationController?.present(newViewController, animated: true, completion: nil)
                            let nc = NotificationCenter.default
                            
                            MPOSAPIManager.getVendorInstallment(handler: { (results, err) in
                                let when = DispatchTime.now() + 0.5
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    if(err.count<=0){
                                        
                                        MPOSAPIManager.loadDebitCustomer(phone: phone, handler: { (result, error) in
                                            if(error.count <= 0){
                                                self.listDebitCustomer = result
                                                var listCom: [String] = []
                                                self.listCompany = results
                                                for item in results {
                                                    listCom.append("\(item.CardName)")
                                                    //                                                    if("\(item.CardCode)" == result!.MaCty){
                                                    //                                                        self.maCty = "\(item.CardCode)"
                                                    //                                                        self.companyButton.text = "\(item.CardName)"
                                                    //                                                        self.companyButton.isEnabled = false
                                                    //                                                        self.tfCMND.text = "\(result!.CustomerIdCard)"
                                                    //                                                        self.tfCMND.isEnabled = false
                                                    //                                                        self.tfLimit.text = "\(result!.TenureOfLoan)"
                                                    //                                                        self.tfLimit.isEnabled = false
                                                    //                                                        self.tfInterestRateCom.text = "\(result!.Interestrate)"
                                                    //                                                        self.tfInterestRateCom.isEnabled = false
                                                    //                                                        self.tfContractNumber.text = "\(result!.ContractNo_AgreementNo)"
                                                    //                                                        self.tfContractNumber.isEnabled = false
                                                    //                                                        self.tfPrepayCom.text = "\(Common.convertCurrencyFloatV2(value: result!.DownPaymentAmount))"
                                                    //                                                        self.tfPrepayCom.isEnabled = false
                                                    //                                                    }
                                                }
                                                self.companyButton.filterStrings(listCom)
                                            }else{
                                                self.debitCustomer = nil
                                                var listCom: [String] = []
                                                self.listCompany = results
                                                for item in results {
                                                    listCom.append("\(item.CardName)")
                                                }
                                                self.maCty = ""
                                                self.companyButton.filterStrings(listCom)
                                                
                                                self.companyButton.text = ""
                                                self.companyButton.isUserInteractionEnabled = true
                                                self.tfCMND.text = ""
                                                self.tfCMND.isUserInteractionEnabled = true
                                                self.tfLimit.text = ""
                                                self.tfLimit.isUserInteractionEnabled = true
                                                self.tfInterestRateCom.text = ""
                                                self.tfInterestRateCom.isUserInteractionEnabled = true
                                                self.tfContractNumber.text = ""
                                                self.tfContractNumber.isUserInteractionEnabled = true
                                                self.tfPrepayCom.text = ""
                                                self.tfPrepayCom.isUserInteractionEnabled = true
                                            }
                                        })
                                        
                                    }else{
                                        
                                    }
                                }
                            })
                        }
                    })
                }else{
                    Cache.phone = ""
                    Cache.name = ""
                    Cache.code = 0
                    Cache.address = ""
                    Cache.email = ""
                    Cache.vlBirthday = ""
                    self.tfUserName.text = ""
                    self.tfUserAddress.text = ""
                    self.tfUserEmail.text = ""
                    self.tfUserBirthday.text = ""
                    
                    Cache.listVoucher = []
                    self.maCty = ""
                    
                    self.companyButton.text = ""
                    self.companyButton.isUserInteractionEnabled = true
                    self.tfCMND.text = ""
                    self.tfCMND.isUserInteractionEnabled = true
                    self.tfLimit.text = ""
                    self.tfLimit.isUserInteractionEnabled = true
                    self.tfInterestRateCom.text = ""
                    self.tfInterestRateCom.isUserInteractionEnabled = true
                    self.tfContractNumber.text = ""
                    self.tfContractNumber.isUserInteractionEnabled = true
                    self.tfPrepayCom.text = ""
                    self.tfPrepayCom.isUserInteractionEnabled = true
                    
                    self.tfUserName.isUserInteractionEnabled = true
                    self.tfUserAddress.isUserInteractionEnabled = true
                    self.tfUserEmail.isUserInteractionEnabled = true
                    self.tfUserBirthday.isUserInteractionEnabled = true
                    self.radioWoman.isEnabled = true
                    self.radioMan.isEnabled = true
                }
            }else{
                Cache.phone = phone
                MPOSAPIManager.searchCustomersToshiba(phoneNumber: "\(phone)", handler: { (results, err) in
                    if(results.count > 0){
                        let customer = results[0]
                        Cache.name = customer.name
                        Cache.code = customer.code
                        Cache.address = customer.address
                        Cache.email = customer.email
                        self.tfUserName.text = customer.name
                        self.tfUserAddress.text = customer.address
                        self.tfUserEmail.text = customer.email
                        
                        self.tfUserBirthday.text = "\(customer.NgaySinh)"
                        if (customer.gioitinh == 1){
                            self.radioMan.isSelected = true
                            self.genderType = 1
                        }else if (customer.gioitinh == 0){
                            self.radioWoman.isSelected = true
                            self.genderType = 0
                        }
                        
                        if(customer.ocrd_FF == "Y"){
                            self.tfUserName.isUserInteractionEnabled = false
                            self.tfUserAddress.isUserInteractionEnabled = false
                            self.tfUserEmail.isUserInteractionEnabled = false
                            self.tfUserBirthday.isUserInteractionEnabled = false
                            if (customer.gioitinh == 1){
                                self.radioWoman.isEnabled = false
                            }else if (customer.gioitinh == 0){
                                self.radioMan.isEnabled = false
                            }
                        }else{
                            self.tfUserName.isUserInteractionEnabled = true
                            self.tfUserAddress.isUserInteractionEnabled = true
                            self.tfUserEmail.isUserInteractionEnabled = true
                            self.tfUserBirthday.isUserInteractionEnabled = true
                            self.radioWoman.isEnabled = true
                            self.radioMan.isEnabled = true
                        }
                        if(customer.p_flag == 1){
                            let alert = UIAlertController(title: "Thông báo", message: customer.p_messagess, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                
                            })
                            self.present(alert, animated: true)
                        }
                    }
                    
                    if(self.orderType == 2 && self.orderPayInstallment == 0){
                        let newViewController = LoadingViewController()
                        newViewController.content = "Đang lấy thông tin nhà trả góp..."
                        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                        self.navigationController?.present(newViewController, animated: true, completion: nil)
                        let nc = NotificationCenter.default
                        
                        MPOSAPIManager.getVendorInstallment(handler: { (results, err) in
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                if(err.count<=0){
                                    
                                    MPOSAPIManager.loadDebitCustomer(phone: phone, handler: { (result, error) in
                                        if(error.count <= 0){
                                            
                                            self.listDebitCustomer = result
                                            
                                            //                                            self.debitCustomer = result
                                            var listCom: [String] = []
                                            self.listCompany = results
                                            for item in results {
                                                listCom.append("\(item.CardName)")
                                                //                                                if("\(item.CardCode)" == result!.MaCty){
                                                //                                                    self.maCty = "\(item.CardCode)"
                                                //                                                    self.companyButton.text = "\(item.CardName)"
                                                //                                                    self.companyButton.isEnabled = false
                                                //                                                     self.tfCMND.text = "\(result!.CustomerIdCard)"
                                                //                                                    self.tfCMND.isEnabled = false
                                                //                                                    self.tfLimit.text = "\(result!.TenureOfLoan)"
                                                //                                                    self.tfLimit.isEnabled = false
                                                //                                                    self.tfInterestRateCom.text = "\(result!.Interestrate)"
                                                //                                                    self.tfInterestRateCom.isEnabled = false
                                                //                                                    self.tfContractNumber.text = "\(result!.ContractNo_AgreementNo)"
                                                //                                                    self.tfContractNumber.isEnabled = false
                                                //                                                    self.tfPrepayCom.text = "\(Common.convertCurrencyFloatV2(value: result!.DownPaymentAmount))"
                                                //                                                    self.tfPrepayCom.isEnabled = false
                                                //                                                }
                                            }
                                            self.companyButton.filterStrings(listCom)
                                        }else{
                                            self.debitCustomer = nil
                                            var listCom: [String] = []
                                            self.listCompany = results
                                            for item in results {
                                                listCom.append("\(item.CardName)")
                                            }
                                            self.maCty = ""
                                            self.companyButton.filterStrings(listCom)
                                            
                                            self.companyButton.text = ""
                                            self.companyButton.isUserInteractionEnabled = true
                                            self.tfCMND.text = ""
                                            self.tfCMND.isUserInteractionEnabled = true
                                            self.tfLimit.text = ""
                                            self.tfLimit.isUserInteractionEnabled = true
                                            self.tfInterestRateCom.text = ""
                                            self.tfInterestRateCom.isUserInteractionEnabled = true
                                            self.tfContractNumber.text = ""
                                            self.tfContractNumber.isUserInteractionEnabled = true
                                            self.tfPrepayCom.text = ""
                                            self.tfPrepayCom.isUserInteractionEnabled = true
                                        }
                                    })
                                    
                                }else{
                                    
                                }
                            }
                        })
                    }
                })
            }
        }else{
            Cache.listVoucher = []
            Cache.phone = ""
            Cache.name = ""
            Cache.code = 0
            Cache.address = ""
            Cache.email = ""
            Cache.vlBirthday = ""
            self.tfUserName.text = ""
            self.tfUserAddress.text = ""
            self.tfUserEmail.text = ""
            self.tfUserBirthday.text = ""
            
            self.maCty = ""
            
            self.companyButton.text = ""
            self.companyButton.isUserInteractionEnabled = true
            self.tfCMND.text = ""
            self.tfCMND.isUserInteractionEnabled = true
            self.tfLimit.text = ""
            self.tfLimit.isUserInteractionEnabled = true
            self.tfInterestRateCom.text = ""
            self.tfInterestRateCom.isUserInteractionEnabled = true
            self.tfContractNumber.text = ""
            self.tfContractNumber.isUserInteractionEnabled = true
            self.tfPrepayCom.text = ""
            self.tfPrepayCom.isUserInteractionEnabled = true
            
            self.tfUserName.isUserInteractionEnabled = true
            self.tfUserAddress.isUserInteractionEnabled = true
            self.tfUserEmail.isUserInteractionEnabled = true
            self.tfUserBirthday.isUserInteractionEnabled = true
            self.radioWoman.isEnabled = true
            self.radioMan.isEnabled = true
            
        }
        
    }
    @objc func actionDelete() {
        print("actionDelete")
        Cache.listVoucher = []
        Cache.phone = ""
        Cache.name = ""
        Cache.code = 0
        Cache.address = ""
        Cache.email = ""
        self.tfPhoneNumber.text = ""
        self.tfUserName.text = ""
        self.tfUserAddress.text = ""
        self.tfUserEmail.text = ""
    }
    
    
    @objc func actionCheckKMVC(sender: UIButton!){
        //check
        var isCheckChonTB:Bool = false
        for item in Cache.carts{
            if(item.product.labelName == "Y"){
                if(Cache.phoneNumberBookSim == ""){
                    isCheckChonTB = true
                    break
                    
                }
            }
        }
        
        if(isCheckChonTB == true){
            
            if(Cache.listVoucher.count > 0){
                self.checkVoucherKMBookSim()
            }else{
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng chọn số thuê bao!!!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    
                })
                self.present(alert, animated: true)
                
                return
            }
            
            
        }
        self.actionPay()
    }
    
    
    func actionPay() {
        
        
        Cache.voucherVNPT = ""
        Cache.promotions.removeAll()
        Cache.group = []
        Cache.itemsPromotion.removeAll()
        self.promotions.removeAll()
        self.group.removeAll()
        
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
    
     
        
    
        var voucher = ""
        if(Cache.listVoucherVNPT.count > 0){
            voucher = "<line>"
            for item in Cache.listVoucher{
                voucher  = voucher + "<item voucher=\"\(item)\" />"
            }
            voucher = voucher + "</line>"
        }
        Cache.voucher = voucher
        
        let email = tfUserEmail.text!
      
   
        
        var prepay = ""
        var interestRate = ""
        
        var docType:String = "01"
        switch orderType {
        case 1:
            docType = "01"
        case 2:
            docType = "02"
        case 3:
            docType = "05"
        default:
            docType = "01"
        }
        var payType:String = "Y"
        switch orderPayType {
        case 1:
            payType = "Y"
        case 2:
            payType = "N"
        default:
            payType = "Y"
        }
        if (orderType != 3){
            for item in Cache.carts {
                if (item.product.qlSerial == "Y" || (item.product.id == 3)){
                    if (item.imei == "N/A" || item.imei == "") {
                        
                        self.showDialog(text: "\(item.product.name) chưa chọn IMEI.")
                        return
                    }
                }
            }
        }
        if (prepay == ""){
            prepay = "0"
        }
        if (interestRate == ""){
            interestRate = "0"
        }
        Cache.valuePrepay = 0
        Cache.valueInterestRate = 0
        Cache.birthdayTemp = ""
        Cache.genderTemp = 0
        let nc = NotificationCenter.default
        let newViewController = LoadingViewController()
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(newViewController, animated: true, completion: nil)
        if (orderType == 2){
            if(orderPayInstallment != 0){
                let number1 = NumberFormatter().number(from: interestRate)
                let number2 = NumberFormatter().number(from: prepay)
                if let number1 = number1 {
                    if let number2 = number2 {
                        let floatValue1 = Float(truncating: number1)
                        let floatValue2 = Float(truncating: number2)
                        
                        print("floatValue1 \(floatValue1)")
                        print("floatValue2 \(floatValue2)")
                        
                        MPOSAPIManager.checkPromotionVNPT(u_CrdCod: "\(Cache.infoCMNDVNPT!.CMND)", sdt: "\(phone)", LoaiDonHang: "03", LoaiTraGop: "\(0)", LaiSuat: floatValue1, SoTienTraTruoc: floatValue2,voucher:voucher, kyhan: "0", U_cardcode: "0", HDNum: "",is_KHRotTG: self.isTG,is_DH_DuAn: self.is_DH_DuAn,Docentry: Cache.infoCMNDVNPT!.Docentry) { (promotion, err) in
                            
                            if(promotion != nil){
                                
                                if let reasons = promotion?.unconfirmationReasons{
                                    var notify:String = ""
                                    for item1 in reasons{
                                        if(item1.issuccess == 0){
                                            if(notify == ""){
                                                notify = "\(item1.ItemCode)"
                                            }else{
                                                notify = "\(notify),\(item1.ItemCode)"
                                            }
                                        }
                                    }
                                    if(notify != ""){
                                        let when = DispatchTime.now() + 1
                                        DispatchQueue.main.asyncAfter(deadline: when) {
                                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                            let alertController = UIAlertController(title: "Thông báo", message: "Mã sản phẩm \(notify) vi phạm nguyên tắc giảm giá. Vui lòng kiểm tra lại!", preferredStyle: .alert)
                                            
                                            let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                                            }
                                            alertController.addAction(confirmAction)
                                            
                                            self.present(alertController, animated: true, completion: nil)}
                                        return
                                    }
                                    
                                    Cache.unconfirmationReasons = reasons
                                }
 
                                
                                let carts = Cache.cartsVNPT
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
                                            
                                            _ = self.navigationController?.popViewController(animated: true)
                                            self.dismiss(animated: true, completion: nil)
                                        }
                                    }else{
                                        if ((promotion?.productPromotions?.count)! > 0){
                                            
                                            for item in (promotion?.productPromotions)! {
                                                if let val:NSMutableArray = self.promotions["Nhóm \(item.Nhom)"] {
                                                    val.add(item)
                                                    self.promotions.updateValue(val, forKey: "Nhóm \(item.Nhom)")
                                                } else {
                                                    let arr: NSMutableArray = NSMutableArray()
                                                    arr.add(item)
                                                    self.promotions.updateValue(arr, forKey: "Nhóm \(item.Nhom)")
                                                    self.group.append("Nhóm \(item.Nhom)")
                                                }
                                            }
                                            // chuyen qua khuyen main
                                            Cache.promotions = self.promotions
                                            Cache.group = self.group
                                            let when = DispatchTime.now() + 0.5
                                            DispatchQueue.main.asyncAfter(deadline: when) {
                                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                                let newViewController = PromotionViewController()
                                                Cache.cartsTemp = Cache.carts
                                                Cache.phoneTemp = phone
                                                Cache.nameTemp = name
                                          
                                                Cache.emailTemp = email
                                              
                                                Cache.genderTemp = self.genderType
                                                
                                                Cache.docTypeTemp = docType
                                                Cache.payTypeTemp = payType
                                                Cache.orderPayType = self.orderPayType
                                                Cache.orderPayInstallment = self.orderPayInstallment
                                                Cache.valueInterestRate = floatValue1
                                                Cache.valuePrepay = floatValue2
                                                Cache.debitCustomer = self.debitCustomer
                                                Cache.phoneNumberBookSimTemp = Cache.phoneNumberBookSim
                                                Cache.is_DH_DuAn = self.is_DH_DuAn
                                                newViewController.productPromotions = (promotion?.productPromotions)!
                                                self.navigationController?.pushViewController(newViewController, animated: true)
                                            }
                                        }else{
                                            let when = DispatchTime.now() + 0.5
                                            DispatchQueue.main.asyncAfter(deadline: when) {
                                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                                let newViewController = ReadSODetailViewController()
                                                newViewController.carts = Cache.carts
                                                newViewController.itemsPromotion = Cache.itemsPromotion
                                                newViewController.phone = phone
                                                newViewController.name = name
                                           
                                                newViewController.email = email
                                             
                                                newViewController.gender = self.genderType
                                                newViewController.type = docType
                                              
                                                newViewController.payment = payType
                                                newViewController.docEntry = ""
                                                newViewController.orderPayType = self.orderPayType
                                                newViewController.orderPayInstallment = self.orderPayInstallment
                                                newViewController.valueInterestRate = floatValue1
                                                newViewController.valuePrepay = floatValue2
                                                newViewController.debitCustomer = self.debitCustomer
                                                Cache.valueInterestRate = floatValue1
                                                Cache.valuePrepay = floatValue2
                                                Cache.debitCustomer = self.debitCustomer
                                                Cache.is_DH_DuAn = self.is_DH_DuAn
                                                self.navigationController?.pushViewController(newViewController, animated: true)
                                            }
                                            
                                        }
                                    }
                                }else{
                                    if ((promotion?.productPromotions?.count)! > 0){
                                        for item in (promotion?.productPromotions)! {
                                            
                                            if let val:NSMutableArray = self.promotions["Nhóm \(item.Nhom)"] {
                                                val.add(item)
                                                self.promotions.updateValue(val, forKey: "Nhóm \(item.Nhom)")
                                            } else {
                                                let arr: NSMutableArray = NSMutableArray()
                                                arr.add(item)
                                                self.promotions.updateValue(arr, forKey: "Nhóm \(item.Nhom)")
                                                self.group.append("Nhóm \(item.Nhom)")
                                            }
                                        }
                                        Cache.promotions = self.promotions
                                        Cache.group = self.group
                                        
                                        let when = DispatchTime.now() + 0.5
                                        DispatchQueue.main.asyncAfter(deadline: when) {
                                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                            let newViewController = PromotionViewController()
                                            Cache.cartsTemp = Cache.carts
                                            Cache.phoneTemp = phone
                                            Cache.nameTemp = name
                                      
                                            Cache.emailTemp = email
                                          
                                            Cache.genderTemp = self.genderType
                                         
                                            Cache.docTypeTemp = docType
                                            Cache.payTypeTemp = payType
                                            Cache.orderPayType = self.orderPayType
                                            Cache.orderPayInstallment = self.orderPayInstallment
                                            Cache.valueInterestRate = floatValue1
                                            Cache.valuePrepay = floatValue2
                                            Cache.debitCustomer = self.debitCustomer
                                            Cache.phoneNumberBookSimTemp = Cache.phoneNumberBookSim
                                            Cache.is_DH_DuAn = self.is_DH_DuAn
                                            newViewController.productPromotions = (promotion?.productPromotions)!
                                            self.navigationController?.pushViewController(newViewController, animated: true)
                                        }
                                        // chuyen qua khuyen main
                                        
                                    }else{
                                        let when = DispatchTime.now() + 0.5
                                        DispatchQueue.main.asyncAfter(deadline: when) {
                                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                            let newViewController = ReadSODetailViewController()
                                            newViewController.carts = Cache.carts
                                            newViewController.itemsPromotion = Cache.itemsPromotion
                                            newViewController.phone = phone
                                            newViewController.name = name
                                          
                                            newViewController.email = email
                                       
                                            newViewController.gender = self.genderType
                                            newViewController.type = docType
                                          
                                            newViewController.payment = payType
                                            newViewController.docEntry = ""
                                            newViewController.orderPayType = self.orderPayType
                                            newViewController.orderPayInstallment = self.orderPayInstallment
                                            newViewController.valueInterestRate = floatValue1
                                            newViewController.valuePrepay = floatValue2
                                            newViewController.debitCustomer = self.debitCustomer
                                             newViewController.is_DH_DuAn = self.is_DH_DuAn
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
                    }else{
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        
                        self.showDialog(text: "Bạn nhập sai định dạng Trả trước!")
                        return
                    }
                }else{
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    
                    self.showDialog(text: "Bạn nhập sai định dạng Lãi suất!")
                    return
                }
            }else{
                if(self.debitCustomer == nil){
                    let prepayCom = tfPrepayCom.text!
                    let contractNumber = tfContractNumber.text!
                    let cmnd = tfCMND.text!
                    let interestRateCom = tfInterestRateCom.text!
                    let vLimit = tfLimit.text!
                    
                    if(self.maCty == ""){
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            
                            self.showDialog(text: "Bạn phải chọn nhà trả góp!")
                        }
                        return
                    }
                    let nameS:String = self.companyButton.text!
                    if(nameS.count <= 0){
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            
                            self.showDialog(text: "Bạn phải chọn nhà trả góp!")
                        }
                        return
                    }
                    if(vLimit.count <= 0){
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            
                            self.showDialog(text: "Bạn phải nhập kỳ hạn!")
                        }
                        return
                    }
                    let numLimit = Int(vLimit)
                    if numLimit == nil {
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            
                            self.showDialog(text: "Kỳ hạn phải là số!")
                        }
                        return
                    }
                    if(interestRateCom.count <= 0){
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            
                            self.showDialog(text: "Bạn phải nhập lãi suất!")
                        }
                        return
                    }
                    let interestRateComString = interestRateCom.replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
                    var numInterestRateCom:Float = 0
                    let formatter = NumberFormatter()
                    formatter.locale = NSLocale(localeIdentifier: "vi_VI") as Locale?
                    let numInterestRateComVl = formatter.number(from: interestRateComString)
                    if let numInterestRateComVl = numInterestRateComVl {
                        numInterestRateCom = Float(truncating: numInterestRateComVl)
                    }else{
//                        let when = DispatchTime.now() + 0.5
//                        DispatchQueue.main.asyncAfter(deadline: when) {
//                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
//
//                            self.showDialog(text: "Lãi suất phải là số!")
//                        }
//                        return
                        numInterestRateCom = Float(interestRateCom) ?? 0
                    }
                    
                    if (cmnd.count == 9 || cmnd.count == 12){
                    }else{
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            
                            self.showDialog(text: "CMND không đúng định dạng!")
                        }
                        return
                    }
                    if(contractNumber.count <= 0){
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            
                            self.showDialog(text: "Bạn phải nhập số hợp đồng!")
                        }
                        return
                    }
                    let prepayComString1 = prepayCom.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
                    let prepayComString = prepayComString1.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                    
                    var numPrepayCom:Float = 0
                    let numPrepayComVl = formatter.number(from: prepayComString)
                    
                    if let numPrepayComVl = numPrepayComVl {
                        numPrepayCom = Float(truncating: numPrepayComVl)
                    }else{
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            self.showDialog(text: "Số tiền trả trước phải là số!")
                        }
                        return
                    }
                    self.debitCustomer = DebitCustomer(TenCty: self.companyButton.text!, CustomerIdCard: cmnd, TenureOfLoan: numLimit!, Interestrate: numInterestRateCom, ContractNo_AgreementNo: contractNumber, MaCty: self.maCty, DownPaymentAmount: numPrepayCom)
                }
                
                MPOSAPIManager.checkPromotionVNPT(u_CrdCod: "\(Cache.infoCMNDVNPT!.CMND)", sdt: "\(phone)", LoaiDonHang: "03", LoaiTraGop: "\(0)", LaiSuat: self.debitCustomer.Interestrate, SoTienTraTruoc: self.debitCustomer.DownPaymentAmount,voucher:voucher, kyhan: "\(self.debitCustomer.TenureOfLoan)", U_cardcode: self.debitCustomer.MaCty, HDNum: self.debitCustomer.ContractNo_AgreementNo,is_KHRotTG: self.isTG,is_DH_DuAn: self.is_DH_DuAn,Docentry: "\(Cache.infoCMNDVNPT!.Docentry)") { (promotion, err) in
                    
                    if(promotion != nil){
                        
                        if let reasons = promotion?.unconfirmationReasons{
                            var notify:String = ""
                            for item1 in reasons{
                                if(item1.issuccess == 0){
                                    if(notify == ""){
                                        notify = "\(item1.ItemCode)"
                                    }else{
                                        notify = "\(notify),\(item1.ItemCode)"
                                    }
                                }
                            }
                            if(notify != ""){
                                let when = DispatchTime.now() + 1
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    let alertController = UIAlertController(title: "Thông báo", message: "Mã sản phẩm \(notify)  vi phạm nguyên tắc giảm giá. Vui lòng kiểm tra lại!", preferredStyle: .alert)
                                    
                                    let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                                        //                                            _ = self.navigationController?.popViewController(animated: true)
                                        //                                            self.dismiss(animated: true, completion: nil)
                                    }
                                    alertController.addAction(confirmAction)
                                    
                                    self.present(alertController, animated: true, completion: nil)
                                }
                                return
                            }
                            Cache.unconfirmationReasons = reasons
                        }
 
                        let carts = Cache.cartsVNPT
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
                                    
                                    _ = self.navigationController?.popViewController(animated: true)
                                    self.dismiss(animated: true, completion: nil)
                                }
                            }else{
                                if ((promotion?.productPromotions?.count)! > 0){
                                    
                                    for item in (promotion?.productPromotions)! {
                                        if let val:NSMutableArray = self.promotions["Nhóm \(item.Nhom)"] {
                                            val.add(item)
                                            self.promotions.updateValue(val, forKey: "Nhóm \(item.Nhom)")
                                        } else {
                                            let arr: NSMutableArray = NSMutableArray()
                                            arr.add(item)
                                            self.promotions.updateValue(arr, forKey: "Nhóm \(item.Nhom)")
                                            self.group.append("Nhóm \(item.Nhom)")
                                        }
                                    }
                                    // chuyen qua khuyen main
                                    Cache.promotions = self.promotions
                                    Cache.group = self.group
                                    let when = DispatchTime.now() + 0.5
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                        let newViewController = PromotionViewController()
                                        Cache.cartsTempVNPT = Cache.cartsVNPT
                                        Cache.phoneTemp = phone
                                        Cache.nameTemp = name
                                   
                                        Cache.emailTemp = email
                                   
                                        Cache.genderTemp = self.genderType
                                       
                                        Cache.docTypeTemp = docType
                                        Cache.payTypeTemp = payType
                                        Cache.orderPayType = self.orderPayType
                                        Cache.orderPayInstallment = self.orderPayInstallment
                                        Cache.valueInterestRate = self.debitCustomer.Interestrate
                                        Cache.valuePrepay = self.debitCustomer.DownPaymentAmount
                                        Cache.debitCustomer = self.debitCustomer
                                        Cache.phoneNumberBookSimTemp = Cache.phoneNumberBookSim
                                        Cache.is_DH_DuAn = self.is_DH_DuAn
                                        newViewController.productPromotions = (promotion?.productPromotions)!
                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                    }
                                }else{
                                    let when = DispatchTime.now() + 0.5
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                        let newViewController = ReadSODetailViewController()
                                        newViewController.carts = Cache.carts
                                        newViewController.itemsPromotion = Cache.itemsPromotion
                                        newViewController.phone = phone
                                        newViewController.name = name
                                      
                                        newViewController.email = email
                                     
                                        newViewController.gender = self.genderType
                                        newViewController.type = docType
                                    
                                        newViewController.payment = payType
                                        newViewController.docEntry = ""
                                        newViewController.orderPayType = self.orderPayType
                                        newViewController.orderPayInstallment = self.orderPayInstallment
                                        newViewController.valueInterestRate = self.debitCustomer.Interestrate
                                        newViewController.valuePrepay = self.debitCustomer.DownPaymentAmount
                                        newViewController.debitCustomer = self.debitCustomer
                                        Cache.valueInterestRate = self.debitCustomer.Interestrate
                                        Cache.valuePrepay = self.debitCustomer.DownPaymentAmount
                                        Cache.debitCustomer = self.debitCustomer
                                        Cache.is_DH_DuAn = self.is_DH_DuAn
                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                    }
                                }
                            }
                        }else{
                            if ((promotion?.productPromotions?.count)! > 0){
                                for item in (promotion?.productPromotions)! {
                                    
                                    if let val:NSMutableArray = self.promotions["Nhóm \(item.Nhom)"] {
                                        val.add(item)
                                        self.promotions.updateValue(val, forKey: "Nhóm \(item.Nhom)")
                                    } else {
                                        let arr: NSMutableArray = NSMutableArray()
                                        arr.add(item)
                                        self.promotions.updateValue(arr, forKey: "Nhóm \(item.Nhom)")
                                        self.group.append("Nhóm \(item.Nhom)")
                                    }
                                }
                                Cache.promotions = self.promotions
                                Cache.group = self.group
                                
                                let when = DispatchTime.now() + 0.5
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    let newViewController = PromotionViewController()
                                    Cache.cartsTemp = Cache.carts
                                    Cache.phoneTemp = phone
                                    Cache.nameTemp = name
                               
                                    Cache.emailTemp = email
                                 
                                    Cache.genderTemp = self.genderType
                               
                                    Cache.docTypeTemp = docType
                                    Cache.payTypeTemp = payType
                                    Cache.orderPayType = self.orderPayType
                                    Cache.orderPayInstallment = self.orderPayInstallment
                                    Cache.valueInterestRate = self.debitCustomer.Interestrate
                                    Cache.valuePrepay = self.debitCustomer.DownPaymentAmount
                                    Cache.debitCustomer = self.debitCustomer
                                    Cache.phoneNumberBookSimTemp = Cache.phoneNumberBookSim
                                    Cache.is_DH_DuAn = self.is_DH_DuAn
                                    newViewController.productPromotions = (promotion?.productPromotions)!
                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                }
                                // chuyen qua khuyen main
                                
                            }else{
                                let when = DispatchTime.now() + 0.5
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    let newViewController = ReadSODetailViewController()
                                    newViewController.carts = Cache.carts
                                    newViewController.itemsPromotion = Cache.itemsPromotion
                                    newViewController.phone = phone
                                    newViewController.name = name
                                   
                                    newViewController.email = email
                                   
                                    newViewController.gender = self.genderType
                                    newViewController.type = docType
                                 
                                    newViewController.payment = payType
                                    newViewController.docEntry = ""
                                    newViewController.orderPayType = self.orderPayType
                                    newViewController.orderPayInstallment = self.orderPayInstallment
                                    newViewController.valueInterestRate = self.debitCustomer.Interestrate
                                    newViewController.valuePrepay = self.debitCustomer.DownPaymentAmount
                                    newViewController.debitCustomer = self.debitCustomer
                                     newViewController.is_DH_DuAn = self.is_DH_DuAn
                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                }
                                
                            }
                        }
                    }else{
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                
                            })
                            self.present(alert, animated: true)
                        }
                    }
                    
                }
                
            }
        }else{
            if(orderType == 1){
                prepay = "0"
                interestRate = "0"
                MPOSAPIManager.checkPromotionVNPT(u_CrdCod: "\(Cache.infoCMNDVNPT!.CMND)", sdt: "\(phone)", LoaiDonHang: "03", LoaiTraGop: "\(0)", LaiSuat: Float(interestRate)!, SoTienTraTruoc: Float(prepay)!, voucher: voucher, kyhan: "0", U_cardcode: "0", HDNum: "",is_KHRotTG: self.isTG,is_DH_DuAn: self.is_DH_DuAn,Docentry: "\(Cache.infoCMNDVNPT!.Docentry)") { (promotion, err) in
                    if(promotion != nil){
                        
                        if let reasons = promotion?.unconfirmationReasons{
                            var notify:String = ""
                            for item1 in reasons{
                                if(item1.issuccess == 0){
                                    if(notify == ""){
                                        notify = "\(item1.ItemCode)"
                                    }else{
                                        notify = "\(notify),\(item1.ItemCode)"
                                    }
                                }
                            }
                            if(notify != ""){
                                let when = DispatchTime.now() + 1
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    let alertController = UIAlertController(title: "Thông báo", message: "Mã sản phẩm \(notify) vi phạm nguyên tắc giảm giá. Vui lòng kiểm tra lại!", preferredStyle: .alert)
                                    
                                    let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                                        //                                            _ = self.navigationController?.popViewController(animated: true)
                                        //                                            self.dismiss(animated: true, completion: nil)
                                    }
                                    alertController.addAction(confirmAction)
                                    
                                    self.present(alertController, animated: true, completion: nil)}
                                return
                            }
                            Cache.unconfirmationReasons = reasons
                        }
 
                        
                        let carts = Cache.cartsVNPT
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
                                    
                                    _ = self.navigationController?.popViewController(animated: true)
                                    self.dismiss(animated: true, completion: nil)
                                }
                                
                            }else{
                                if ((promotion?.productPromotions?.count)! > 0){
                                    
                                    for item in (promotion?.productPromotions)! {
                                        if let val:NSMutableArray = self.promotions["Nhóm \(item.Nhom)"] {
                                            val.add(item)
                                            self.promotions.updateValue(val, forKey: "Nhóm \(item.Nhom)")
                                        } else {
                                            let arr: NSMutableArray = NSMutableArray()
                                            arr.add(item)
                                            self.promotions.updateValue(arr, forKey: "Nhóm \(item.Nhom)")
                                            self.group.append("Nhóm \(item.Nhom)")
                                        }
                                    }
                                    // chuyen qua khuyen main
                                    Cache.promotions = self.promotions
                                    Cache.group = self.group
                                    let when = DispatchTime.now() + 0.5
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                        let newViewController = PromotionVNPTViewController()
                                        Cache.cartsTempVNPT = Cache.cartsVNPT
                                        Cache.phoneTemp = phone
                                        Cache.nameTemp = name
                                        
                                        Cache.emailTemp = email
                                        Cache.emailTemp = email
                                       
                                        Cache.genderTemp = self.genderType
                                     
                                        Cache.docTypeTemp = docType
                                        Cache.payTypeTemp = payType
                                        Cache.orderPayType = self.orderPayType
                                        Cache.orderPayInstallment = self.orderPayInstallment
                                        Cache.valueInterestRate = 0
                                        Cache.valuePrepay = 0
                                        Cache.debitCustomer = self.debitCustomer
                                        Cache.phoneNumberBookSimTemp = Cache.phoneNumberBookSim
                                        Cache.is_DH_DuAn = self.is_DH_DuAn
                                        newViewController.productPromotions = (promotion?.productPromotions)!
                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                    }
                                }else{
                                    let when = DispatchTime.now() + 0.5
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                        let newViewController = ReadSOVNPTDetailViewController()
                                        newViewController.carts = Cache.cartsVNPT
                                        newViewController.itemsPromotion = Cache.itemsPromotion
                                        newViewController.phone = phone
                                        newViewController.name = name
                                   
                                        newViewController.email = email
                                    
                                        newViewController.gender = self.genderType
                                        newViewController.type = docType
                                     
                                        newViewController.payment = payType
                                        newViewController.docEntry = ""
                                        newViewController.orderPayType = self.orderPayType
                                        newViewController.orderPayInstallment = self.orderPayInstallment
                                        newViewController.valueInterestRate = 0
                                        newViewController.valuePrepay = 0
                                        newViewController.debitCustomer = self.debitCustomer
                                         newViewController.is_DH_DuAn = self.is_DH_DuAn
                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                    }
                                    
                                }
                            }
                        }else{
                            if ((promotion?.productPromotions?.count)! > 0){
                                for item in (promotion?.productPromotions)! {
                                    
                                    if let val:NSMutableArray = self.promotions["Nhóm \(item.Nhom)"] {
                                        val.add(item)
                                        self.promotions.updateValue(val, forKey: "Nhóm \(item.Nhom)")
                                    } else {
                                        let arr: NSMutableArray = NSMutableArray()
                                        arr.add(item)
                                        self.promotions.updateValue(arr, forKey: "Nhóm \(item.Nhom)")
                                        self.group.append("Nhóm \(item.Nhom)")
                                    }
                                }
                                Cache.promotions = self.promotions
                                Cache.group = self.group
                                
                                let when = DispatchTime.now() + 0.5
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    let newViewController = PromotionViewController()
                                    Cache.cartsTempVNPT = Cache.cartsVNPT
                                    Cache.phoneTemp = phone
                                    Cache.nameTemp = name
                          
                                    Cache.emailTemp = email
                                
                                    Cache.genderTemp = self.genderType
                                 
                                    Cache.docTypeTemp = docType
                                    Cache.payTypeTemp = payType
                                    Cache.orderPayType = self.orderPayType
                                    Cache.orderPayInstallment = self.orderPayInstallment
                                    Cache.valueInterestRate = 0
                                    Cache.valuePrepay = 0
                                    Cache.debitCustomer = self.debitCustomer
                                    Cache.phoneNumberBookSimTemp = Cache.phoneNumberBookSim
                                    Cache.is_DH_DuAn = self.is_DH_DuAn
                                    newViewController.productPromotions = (promotion?.productPromotions)!
                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                }
                                // chuyen qua khuyen main
                                
                            }else{
                                let when = DispatchTime.now() + 0.5
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    let newViewController = ReadSOVNPTDetailViewController()
                                    newViewController.carts = Cache.cartsVNPT
                                    newViewController.itemsPromotion = Cache.itemsPromotion
                                    newViewController.phone = phone
                                    newViewController.name = name
                              
                                    newViewController.email = email
                             
                                    newViewController.gender = self.genderType
                                    newViewController.type = docType
                                   
                                    newViewController.payment = payType
                                    newViewController.docEntry = ""
                                    newViewController.orderPayType = self.orderPayType
                                    newViewController.orderPayInstallment = self.orderPayInstallment
                                    newViewController.valueInterestRate = 0
                                    newViewController.valuePrepay = 0
                                    newViewController.debitCustomer = self.debitCustomer
                                     newViewController.is_DH_DuAn = self.is_DH_DuAn
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
            }else{
                prepay = "0"
                interestRate = "0"
                MPOSAPIManager.checkPromotionVNPT(u_CrdCod: "\(Cache.infoCMNDVNPT!.CMND)", sdt: "\(phone)", LoaiDonHang: "03", LoaiTraGop: "\(0)", LaiSuat: Float(interestRate)!, SoTienTraTruoc: Float(prepay)!, voucher: voucher, kyhan: "0", U_cardcode: "0", HDNum: "",is_KHRotTG: self.isTG,is_DH_DuAn: self.is_DH_DuAn,Docentry: "\(Cache.infoCMNDVNPT!.Docentry)") { (promotion, err) in
                    if(promotion != nil){
                        
                        if let reasons = promotion?.unconfirmationReasons{
                            var notify:String = ""
                            for item1 in reasons{
                                if(item1.issuccess == 0){
                                    if(notify == ""){
                                        notify = "\(item1.ItemCode)"
                                    }else{
                                        notify = "\(notify),\(item1.ItemCode)"
                                    }
                                }
                            }
                            if(notify != ""){
                                let when = DispatchTime.now() + 1
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    let alertController = UIAlertController(title: "Thông báo", message: "Mã sản phẩm \(notify) vi phạm nguyên tắc giảm giá. Vui lòng kiểm tra lại!", preferredStyle: .alert)
                                    
                                    let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                                        //                                            _ = self.navigationController?.popViewController(animated: true)
                                        //                                            self.dismiss(animated: true, completion: nil)
                                    }
                                    alertController.addAction(confirmAction)
                                    
                                    self.present(alertController, animated: true, completion: nil)}
                                return
                            }
                            Cache.unconfirmationReasons = reasons
                        }
 
                        if ((promotion?.productPromotions?.count)! > 0){
                            for item in (promotion?.productPromotions)! {
                                
                                if let val:NSMutableArray = self.promotions["Nhóm \(item.Nhom)"] {
                                    val.add(item)
                                    self.promotions.updateValue(val, forKey: "Nhóm \(item.Nhom)")
                                } else {
                                    let arr: NSMutableArray = NSMutableArray()
                                    arr.add(item)
                                    self.promotions.updateValue(arr, forKey: "Nhóm \(item.Nhom)")
                                    self.group.append("Nhóm \(item.Nhom)")
                                }
                            }
                            Cache.promotions = self.promotions
                            Cache.group = self.group
                            
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                let newViewController = PromotionVNPTViewController()
                                Cache.cartsTemp = Cache.carts
                                Cache.phoneTemp = phone
                                Cache.nameTemp = name
                                
                                Cache.emailTemp = email
                           
                                Cache.genderTemp = self.genderType
                             
                                Cache.docTypeTemp = docType
                                Cache.payTypeTemp = payType
                                Cache.orderPayType = self.orderPayType
                                Cache.orderPayInstallment = self.orderPayInstallment
                                Cache.valueInterestRate = 0
                                Cache.valuePrepay = 0
                                Cache.debitCustomer = self.debitCustomer
                                Cache.phoneNumberBookSimTemp = Cache.phoneNumberBookSim
                                Cache.is_DH_DuAn = self.is_DH_DuAn
                                newViewController.productPromotions = (promotion?.productPromotions)!
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }
                            // chuyen qua khuyen main
                            
                        }else{
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                let newViewController = ReadSOVNPTDetailViewController()
                                newViewController.carts = Cache.cartsVNPT
                                newViewController.itemsPromotion = Cache.itemsPromotion
                                newViewController.phone = phone
                                newViewController.name = name
                           
                                newViewController.email = email
                             
                                newViewController.gender = self.genderType
                                newViewController.type = docType
                          
                                newViewController.payment = payType
                                newViewController.docEntry = ""
                                newViewController.orderPayType = self.orderPayType
                                newViewController.orderPayInstallment = self.orderPayInstallment
                                newViewController.valueInterestRate = 0
                                newViewController.valuePrepay = 0
                                newViewController.debitCustomer = self.debitCustomer
                                newViewController.is_DH_DuAn = self.is_DH_DuAn
                                self.navigationController?.pushViewController(newViewController, animated: true)
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
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if(self.debitCustomer  != nil && companyButton != nil){
            self.debitCustomer = nil
        }
        if(orderType == 2 && orderPayInstallment == 0 && tfPhoneNumber != nil){
            let phone = tfPhoneNumber.text!
            if (phone.hasPrefix("01") && phone.count == 11){
                
            }else if (phone.hasPrefix("0") && !phone.hasPrefix("01") && phone.count == 10){
                
            }else{
                self.showDialog(text: "Số điện thoại không hợp lệ!")
                return
            }
            let newViewController = LoadingViewController()
            newViewController.content = "Đang lấy thông tin nhà trả góp..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            MPOSAPIManager.getVendorInstallment(handler: { (results, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count<=0){
                        
                        MPOSAPIManager.loadDebitCustomer(phone: phone, handler: { (result, error) in
                            if(error.count <= 0){
                                
                                self.listDebitCustomer = result
                                //                                self.debitCustomer = result
                                var listCom: [String] = []
                                self.listCompany = results
                                for item in results {
                                    listCom.append("\(item.CardName)")
                                    //                                    if("\(item.CardCode)" == result!.MaCty){
                                    //                                        self.maCty = "\(item.CardCode)"
                                    //                                        self.companyButton.text = "\(item.CardName)"
                                    //                                        self.companyButton.isEnabled = false
                                    //                                        self.tfCMND.text = "\(result!.CustomerIdCard)"
                                    //                                        self.tfCMND.isEnabled = false
                                    //                                        self.tfLimit.text = "\(result!.TenureOfLoan)"
                                    //                                        self.tfLimit.isEnabled = false
                                    //                                        self.tfInterestRateCom.text = "\(result!.Interestrate)"
                                    //                                        self.tfInterestRateCom.isEnabled = false
                                    //                                        self.tfContractNumber.text = "\(result!.ContractNo_AgreementNo)"
                                    //                                        self.tfContractNumber.isEnabled = false
                                    //                                        self.tfPrepayCom.text = "\(Common.convertCurrencyFloatV2(value: result!.DownPaymentAmount))"
                                    //                                        self.tfPrepayCom.isEnabled = false
                                    //                                    }
                                }
                                self.companyButton.filterStrings(listCom)
                            }else{
                                self.debitCustomer = nil
                                var listCom: [String] = []
                                self.listCompany = results
                                for item in results {
                                    listCom.append("\(item.CardName)")
                                }
                                self.maCty = ""
                                self.companyButton.filterStrings(listCom)
                                
                                self.companyButton.text = ""
                                self.companyButton.isUserInteractionEnabled = true
                                self.tfCMND.text = ""
                                self.tfCMND.isUserInteractionEnabled = true
                                self.tfLimit.text = ""
                                self.tfLimit.isUserInteractionEnabled = true
                                self.tfInterestRateCom.text = ""
                                self.tfInterestRateCom.isUserInteractionEnabled = true
                                self.tfContractNumber.text = ""
                                self.tfContractNumber.isUserInteractionEnabled = true
                                self.tfPrepayCom.text = ""
                                self.tfPrepayCom.isUserInteractionEnabled = true
                            }
                        })
                        
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    }else{
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    }
                }
            })
        }
    }
    
    func checkVoucherKMBookSim(){
        
        var xmlvoucher = ""
        if(Cache.listVoucher.count > 0){
            xmlvoucher = "<line>"
            for item in Cache.listVoucher{
                xmlvoucher  = xmlvoucher + "<item voucher=\"\(item)\" />"
            }
            xmlvoucher = xmlvoucher + "</line>"
        }
        
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra voucher..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.checkVoucherKMBookSim(sdt: self.tfPhoneNumber.text!, xmlvoucher: xmlvoucher.toBase64()) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(results!.p_status == "Y"){
                        self.actionPay()
                    }else{
                        
                        let alert = UIAlertController(title: "Thông báo", message: "Vui lòng chọn số thuê bao!!!", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                        
                        return
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
        for item in Cache.itemsPromotion {
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
        for item in Cache.carts {
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
        for item in Cache.carts {
            sum = sum + Float(item.quantity) * item.product.price
        }
        return Common.convertCurrencyFloat(value: sum)
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    fileprivate func createRadioButton(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(PaymentVNPTViewController.logSelectedButton), for: UIControl.Event.touchUpInside);
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
        radioButton.addTarget(self, action: #selector(PaymentVNPTViewController.logSelectedButtonPayType), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
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
        radioButton.addTarget(self, action: #selector(PaymentVNPTViewController.logSelectedButtonGender), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonGender(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioMan.isSelected = false
            radioWoman.isSelected = false
            switch temp {
            case "Nam":
                genderType = 1
                Cache.genderType = 1
                radioMan.isSelected = true
                break
            case "Nữ":
                genderType = 0
                Cache.genderType = 0
                radioWoman.isSelected = true
                break
            default:
                genderType = -1
                Cache.genderType = -1
                break
            }
        }
    }
    @objc @IBAction fileprivate func logSelectedButtonPayType(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioPayNow.isSelected = false
            radioPayNotNow.isSelected = false
            switch temp {
            case "Trực tiếp":
                orderPayType = 1
                Cache.orderPayType = 1
                radioPayNow.isSelected = true
                break
            case "Khác":
                orderPayType = 2
                Cache.orderPayType = 2
                radioPayNotNow.isSelected = true
                break
            default:
                orderPayType = -1
                Cache.orderPayType = -1
                break
            }
        }
    }
    
    @objc @IBAction fileprivate func logSelectedButton(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioAtTheCounter.isSelected = false
            radioInstallment.isSelected = false
            radioDeposit.isSelected = false
            switch temp {
            case "Tại quầy":
                orderType = 1
                Cache.orderType = 1
                radioAtTheCounter.isSelected = true
                viewInstallment.frame.size.height = 0
                viewInfoDetail.frame.origin.y = viewInstallment.frame.size.height + viewInstallment.frame.origin.y
                viewBelowToshibaPoint.frame.size.height = viewInfoDetail.frame.size.height + viewInfoDetail.frame.origin.y + Common.Size(s: 5)
                //                scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetail.frame.origin.y + viewInfoDetail.frame.size.height)
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewBelowToshibaPoint.frame.origin.y + viewBelowToshibaPoint.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                break
            case "Trả góp":
                let phone = tfPhoneNumber.text!
                if (phone.hasPrefix("01") && phone.count == 11){
                    
                }else if (phone.hasPrefix("0") && !phone.hasPrefix("01") && phone.count == 10){
                    
                }else{
                    
                    self.showDialog(text: "Số điện thoại không hợp lệ!")
                    return
                }
                orderType = 2
                Cache.orderType = 2
                radioInstallment.isSelected = true
                viewInstallment.frame.size.height = viewInstallmentHeight
                viewInfoDetail.frame.origin.y = viewInstallment.frame.size.height + viewInstallment.frame.origin.y
                
                viewBelowToshibaPoint.frame.size.height = viewInfoDetail.frame.size.height + viewInfoDetail.frame.origin.y + Common.Size(s: 5)
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewBelowToshibaPoint.frame.origin.y + viewBelowToshibaPoint.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                
                let newViewController = LoadingViewController()
                newViewController.content = "Đang lấy thông tin nhà trả góp..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                MPOSAPIManager.getVendorInstallment(handler: { (results, err) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count<=0){
                            
                            MPOSAPIManager.loadDebitCustomer(phone: phone, handler: { (result, error) in
                                if(error.count <= 0){
                                    self.listDebitCustomer = result
                                    //                                    self.debitCustomer = result
                                    var listCom: [String] = []
                                    self.listCompany = results
                                    for item in results {
                                        listCom.append("\(item.CardName)")
                                    }
                                    self.companyButton.filterStrings(listCom)
                                }else{
                                    self.debitCustomer = nil
                                    var listCom: [String] = []
                                    self.listCompany = results
                                    for item in results {
                                        listCom.append("\(item.CardName)")
                                    }
                                    self.maCty = ""
                                    self.companyButton.filterStrings(listCom)
                                    
                                    self.companyButton.text = ""
                                    self.companyButton.isUserInteractionEnabled = true
                                    self.tfCMND.text = ""
                                    self.tfCMND.isUserInteractionEnabled = true
                                    self.tfLimit.text = ""
                                    self.tfLimit.isUserInteractionEnabled = true
                                    self.tfInterestRateCom.text = ""
                                    self.tfInterestRateCom.isUserInteractionEnabled = true
                                    self.tfContractNumber.text = ""
                                    self.tfContractNumber.isUserInteractionEnabled = true
                                    self.tfPrepayCom.text = ""
                                    self.tfPrepayCom.isUserInteractionEnabled = true
                                }
                            })
                            
                        }else{
                            
                        }
                    }
                })
                break
            case "Đặt cọc":
                orderType = 3
                Cache.orderType = 3
                radioDeposit.isSelected = true
                viewInstallment.frame.size.height = 0
                viewInfoDetail.frame.origin.y = viewInstallment.frame.size.height + viewInstallment.frame.origin.y
                viewBelowToshibaPoint.frame.size.height = viewInfoDetail.frame.size.height + viewInfoDetail.frame.origin.y + Common.Size(s: 5)
                //                scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetail.frame.origin.y + viewInfoDetail.frame.size.height)
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewBelowToshibaPoint.frame.origin.y + viewBelowToshibaPoint.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                break
            default:
                orderType = -1
                break
            }
        }
    }
    fileprivate func createRadioButtonPayInstallment(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(PaymentVNPTViewController.logSelectedButtonPayInstallment), for: UIControl.Event.touchUpInside);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonPayInstallment(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioPayInstallmentCom.isSelected = false
            radioPayInstallmentCard.isSelected = false
            switch temp {
            case "Thẻ":
                orderPayInstallment = 1
                Cache.orderPayInstallment = 1
                radioPayInstallmentCard.isSelected = true
                viewInstallmentCom.frame.size.height = 0
                viewInstallmentCard.frame.size.height = tfPrepay.frame.size.height + tfPrepay.frame.origin.y + Common.Size(s:20)
                viewInstallment.frame.size.height = viewInstallmentCard.frame.size.height + viewInstallmentCard.frame.origin.y
                viewInstallmentHeight = viewInstallment.frame.size.height
                viewInfoDetail.frame.origin.y = viewInstallment.frame.origin.y  + viewInstallment.frame.size.height
                viewBelowToshibaPoint.frame.size.height = viewInfoDetail.frame.size.height + viewInfoDetail.frame.origin.y + Common.Size(s: 5)
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewBelowToshibaPoint.frame.origin.y + viewBelowToshibaPoint.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                break
            case "Nhà trả góp":
                let phone = tfPhoneNumber.text!
                if (phone.hasPrefix("01") && phone.count == 11){
                    
                }else if (phone.hasPrefix("0") && !phone.hasPrefix("01") && phone.count == 10){
                    
                }else{
                    
                    self.showDialog(text: "Số điện thoại không hợp lệ!")
                    return
                }
                
                orderPayInstallment = 0
                Cache.orderPayInstallment = 0
                radioPayInstallmentCom.isSelected = true
                viewInstallmentCard.frame.size.height = 0
                viewInstallmentCom.frame.size.height = tfPrepayCom.frame.size.height + tfPrepayCom.frame.origin.y + Common.Size(s:20)
                viewInstallment.frame.size.height = viewInstallmentCom.frame.size.height + viewInstallmentCom.frame.origin.y
                viewInstallmentHeight = viewInstallment.frame.size.height
                
                viewInfoDetail.frame.origin.y = viewInstallment.frame.origin.y  + viewInstallment.frame.size.height
                
                viewBelowToshibaPoint.frame.size.height = viewInfoDetail.frame.size.height + viewInfoDetail.frame.origin.y + Common.Size(s: 5)
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewBelowToshibaPoint.frame.origin.y + viewBelowToshibaPoint.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                
                let newViewController = LoadingViewController()
                newViewController.content = "Đang lấy thông tin nhà trả góp..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                MPOSAPIManager.getVendorInstallment(handler: { (results, err) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count<=0){
                            
                            MPOSAPIManager.loadDebitCustomer(phone: phone, handler: { (result, error) in
                                if(error.count <= 0){
                                    self.listDebitCustomer = result
                                    //                                    self.debitCustomer = result
                                    var listCom: [String] = []
                                    self.listCompany = results
                                    for item in results {
                                        listCom.append("\(item.CardName)")
                                        
                                    }
                                    self.companyButton.filterStrings(listCom)
                                }else{
                                    self.debitCustomer = nil
                                    var listCom: [String] = []
                                    self.listCompany = results
                                    for item in results {
                                        listCom.append("\(item.CardName)")
                                    }
                                    self.maCty = ""
                                    self.companyButton.filterStrings(listCom)
                                    
                                    self.companyButton.text = ""
                                    self.companyButton.isUserInteractionEnabled = true
                                    self.tfCMND.text = ""
                                    self.tfCMND.isUserInteractionEnabled = true
                                    self.tfLimit.text = ""
                                    self.tfLimit.isUserInteractionEnabled = true
                                    self.tfInterestRateCom.text = ""
                                    self.tfInterestRateCom.isUserInteractionEnabled = true
                                    self.tfContractNumber.text = ""
                                    self.tfContractNumber.isUserInteractionEnabled = true
                                    self.tfPrepayCom.text = ""
                                    self.tfPrepayCom.isUserInteractionEnabled = true
                                }
                            })
                            
                        }else{
                            
                        }
                    }
                })
                break
            default:
                Cache.orderPayInstallment = -1
                orderPayInstallment = -1
                break
            }
        }
    }
    
    fileprivate func createRadioButtonPayTGSS(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(PaymentVNPTViewController.logSelectedButtonPayTGSS), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonPayTGSS(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioTGSSYes.isSelected = false
            radioTGSSNo.isSelected = false
            switch temp {
            case "Có":
                is_samsung = 1
                radioTGSSYes.isSelected = true
                Cache.is_samsung = 1
                break
            case "Không":
                is_samsung = 0
                radioTGSSNo.isSelected = true
                Cache.is_samsung = 0
                break
            default:
                is_samsung = 0
                Cache.is_samsung = 0
                break
            }
        }
    }
    fileprivate func createRadioButtonPayTG(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(PaymentVNPTViewController.logSelectedButtonPayTG), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonPayTG(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioTGYes.isSelected = false
            radioTGNo.isSelected = false
            switch temp {
            case "Có":
                isTG = 1
                radioTGYes.isSelected = true
                Cache.is_KHRotTG = 1
                break
            case "Không":
                isTG = 0
                radioTGNo.isSelected = true
                Cache.is_KHRotTG = 0
                break
            default:
                isTG = 0
                Cache.is_KHRotTG = 0
                break
            }
        }
    }
    fileprivate func createRadioButtonDHDuAn(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(PaymentVNPTViewController.logSelectedButtonDHDuAn), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonDHDuAn(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioDHDUYes.isSelected = false
            radioDHDUNo.isSelected = false
            switch temp {
            case "Có":
                is_DH_DuAn = "Y"
                radioDHDUYes.isSelected = true
                Cache.is_DH_DuAn = "Y"
                break
            case "Không":
                is_DH_DuAn = "N"
                radioDHDUNo.isSelected = true
                Cache.is_DH_DuAn = "N"
                break
            default:
                is_DH_DuAn = "N"
                Cache.is_DH_DuAn = "N"
                break
            }
        }
    }
}
