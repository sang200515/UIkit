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
import UIKit
import SnapKit
var needReload = false
class PaymentViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,ScanIMEIControllerDelegate,DiscountViewControllerDelegate,ChooseSupportEmployeeViewControllerDelegate,CheckVoucherOTPViewControllerDelegate {
    
    
    
    var isTraCocEcom:Bool = false
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
    var isFromSearch = true
    var tracocItem: CustomerTraCoc?
    
    var listImei:[UILabel] = []
    var listPrice:[UILabel] = []
    var listTotal:[UILabel] = []
    
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
    var lblTongDonHang:UILabel!
    var lblTongThanhtoan:UILabel!
    var lblPrice: UILabel!
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
    var listTongDonHang:[UILabel] = []
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
    var tableViewVoucherNoPrice: UITableView = UITableView()
    var cellHeight:CGFloat = 0
    var indexCart:Int = 0
    var isPickGoiBH:Float = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "Đơn hàng"
        isScanImei = true
        listImei = []
        listPrice = []
        listTongDonHang = []
        listTotal = []
        listKho = []
        groupSKU = []
        discountPay = 0
        totalPay = 0
        
        let btDeleteIcon = UIButton.init(type: .custom)
        btDeleteIcon.setImage(#imageLiteral(resourceName: "Delete"), for: UIControl.State.normal)
        btDeleteIcon.imageView?.contentMode = .scaleAspectFit
        btDeleteIcon.addTarget(self, action: #selector(PaymentViewController.actionDelete), for: UIControl.Event.touchUpInside)
        btDeleteIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        
        let btRightIcon = UIButton.init(type: .custom)
        btRightIcon.setImage(#imageLiteral(resourceName: "home"), for: UIControl.State.normal)
        btRightIcon.imageView?.contentMode = .scaleAspectFit
        btRightIcon.addTarget(self, action: #selector(PaymentViewController.actionHome), for: UIControl.Event.touchUpInside)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if needReload {
            needReload = !needReload
            loadListVCNoPrice(phonenumber: tfPhoneNumber.text ?? "")
            let stInfo = UserDefaults.standard.string(forKey: "BtsStudentInfo")
            if let info = stInfo {
                let name = info.split(separator: ",").first
                tfUserName.text = name?.description
                let birth = info.split(separator: ",").last
                tfUserBirthday.text = birth?.description
                UserDefaults.standard.setValue(nil, forKey: "BtsStudentInfo")
            }
            
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
        
        //input phone number
        tfPhoneNumber = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:20), y: lbUserInfo.frame.origin.y + lbUserInfo.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)), iconType: .image)
        
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
        
        //input name info
        tfUserName = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: tfPhoneNumber.frame.origin.x, y: tfPhoneNumber.frame.origin.y + tfPhoneNumber.frame.size.height + Common.Size(s:10), width: tfPhoneNumber.frame.size.width , height: tfPhoneNumber.frame.size.height ), iconType: .image);
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
        
        //input address
        tfUserAddress = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: tfUserName.frame.origin.x, y: tfUserName.frame.origin.y + tfUserName.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width , height: tfUserName.frame.size.height ), iconType: .image);
        tfUserAddress.placeholder = "Nhập địa chỉ"
        tfUserAddress.title = "Địa chỉ"
        tfUserAddress.iconImage = UIImage(named: "address")
        tfUserAddress.tintColor = UIColor(netHex:0x04AB6E)
        tfUserAddress.lineColor = UIColor.gray
        tfUserAddress.selectedTitleColor = UIColor(netHex:0x04AB6E)
        tfUserAddress.selectedLineColor = UIColor(netHex:0x04AB6E)
        tfUserAddress.lineHeight = 0.5
        tfUserAddress.selectedLineHeight = 0.5
        tfUserAddress.clearButtonMode = .whileEditing
        tfUserAddress.delegate = self
        scrollView.addSubview(tfUserAddress)
        tfUserAddress.addTarget(self, action: #selector(textFieldDidChangeAddress(_:)), for: .editingChanged)
        tfUserAddress.text = Cache.address
        
        //input email
        tfUserEmail = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: tfUserAddress.frame.origin.x, y: tfUserAddress.frame.origin.y + tfUserAddress.frame.size.height + Common.Size(s:10), width: tfUserAddress.frame.size.width , height: tfUserAddress.frame.size.height ), iconType: .image);
        tfUserEmail.placeholder = "Nhập email"
        tfUserEmail.title = "Email"
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
        tfUserEmail.text = Cache.email
        
        //input email
        tfUserBirthday = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: tfUserEmail.frame.origin.x, y: tfUserEmail.frame.origin.y + tfUserEmail.frame.size.height + Common.Size(s:10), width: tfUserAddress.frame.size.width , height: tfUserAddress.frame.size.height), iconType: .image);
        tfUserBirthday.placeholder = "Nhập ngày sinh"
        tfUserBirthday.title = "Ngày sinh"
        tfUserBirthday.iconImage = UIImage(named: "birthday")
        tfUserBirthday.tintColor = UIColor(netHex:0x04AB6E)
        tfUserBirthday.lineColor = UIColor.gray
        tfUserBirthday.selectedTitleColor = UIColor(netHex:0x04AB6E)
        tfUserBirthday.selectedLineColor = UIColor(netHex:0x04AB6E)
        tfUserBirthday.lineHeight = 0.5
        tfUserBirthday.selectedLineHeight = 0.5
        tfUserBirthday.clearButtonMode = .whileEditing
        tfUserBirthday.delegate = self
        scrollView.addSubview(tfUserBirthday)
        tfUserBirthday.addTarget(self, action: #selector(textFieldDidChangeBirthday(_:)), for: .editingChanged)
        tfUserBirthday.text = Cache.vlBirthday
        
        
        let lbGenderText = UILabel(frame: CGRect(x: tfUserBirthday.frame.origin.x, y: tfUserBirthday.frame.origin.y + tfUserBirthday.frame.size.height + Common.Size(s:10), width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbGenderText.textAlignment = .left
        lbGenderText.textColor = UIColor.black
        lbGenderText.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbGenderText.text = "Giới tính"
        scrollView.addSubview(lbGenderText)
        
        radioMan = createRadioButtonGender(CGRect(x: lbGenderText.frame.origin.x,y:lbGenderText.frame.origin.y + lbGenderText.frame.size.height + Common.Size(s:5) , width: lbGenderText.frame.size.width/3, height: Common.Size(s:20)), title: "Nam", color: UIColor.black);
        scrollView.addSubview(radioMan)
        
        radioWoman = createRadioButtonGender(CGRect(x: radioMan.frame.origin.x + radioMan.frame.size.width ,y:radioMan.frame.origin.y, width: radioMan.frame.size.width, height: radioMan.frame.size.height), title: "Nữ", color: UIColor.black);
        scrollView.addSubview(radioWoman)
        
        print("\(Cache.genderType)")
        if (Cache.genderType == 1){
            radioMan.isSelected = true
            genderType = 1
        }else if (Cache.genderType == 0){
            radioWoman.isSelected = true
            genderType = 0
        }else{
            radioMan.isSelected = false
            radioWoman.isSelected = false
            genderType = -1
        }
        
        // DIEM THUONG
        let lbToshibaPoint = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: radioWoman.frame.origin.y + radioWoman.frame.size.height+Common.Size(s:20), width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbToshibaPoint.textAlignment = .left
        lbToshibaPoint.textColor = UIColor(netHex:0x04AB6E)
        lbToshibaPoint.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbToshibaPoint.text = "ĐIỂM THƯỞNG"
        scrollView.addSubview(lbToshibaPoint)
        
        let tapToshibaPoint = UITapGestureRecognizer(target: self, action: #selector(PaymentViewController.tapFunctionToshiba))
        lbToshibaPoint.isUserInteractionEnabled = true
        lbToshibaPoint.addGestureRecognizer(tapToshibaPoint)
        
        viewToshibaPoint = UIView(frame: CGRect(x: tfUserEmail.frame.origin.x, y: lbToshibaPoint.frame.origin.y + lbToshibaPoint.frame.size.height+Common.Size(s:5), width: tfUserEmail.frame.size.width, height: 0))
        scrollView.addSubview(viewToshibaPoint)
        viewToshibaPoint.clipsToBounds = true
        
        /*
         22/09/2017 11:30 A.Hao
         Change lable text Fpoint -> FMoney
         Change lable text FMoney -> Fpoint
         */
        
        lbFPoint = UILabel(frame: CGRect(x: 0, y: 0, width: (viewToshibaPoint.frame.size.width - Common.Size(s: 10))/3, height: Common.Size(s:40)))
        lbFPoint.textAlignment = .center
        lbFPoint.textColor = UIColor(netHex:0xEF4A40)
        lbFPoint.layer.cornerRadius = 10.0
        lbFPoint.layer.borderColor = UIColor(netHex:0xEF4A40).cgColor
        lbFPoint.layer.borderWidth = 0.5
        lbFPoint.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        lbFPoint.text = "FMoney"
        lbFPoint.numberOfLines = 1
        viewToshibaPoint.addSubview(lbFPoint)
        
        let lbFPointLable = UILabel(frame: CGRect(x: lbFPoint.frame.origin.x, y: lbFPoint.frame.size.height + lbFPoint.frame.origin.y+Common.Size(s:5), width: lbFPoint.frame.size.width, height: Common.Size(s:12)))
        lbFPointLable.textAlignment = .center
        lbFPointLable.textColor = .gray
        lbFPointLable.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        lbFPointLable.text = "FMoney"
        lbFPointLable.numberOfLines = 1
        viewToshibaPoint.addSubview(lbFPointLable)
        
        
        lbFCoin = UILabel(frame: CGRect(x: lbFPoint.frame.size.width + lbFPoint.frame.origin.x + Common.Size(s: 5), y: 0, width: (viewToshibaPoint.frame.size.width - Common.Size(s: 10))/3, height: Common.Size(s:40)))
        lbFCoin.textAlignment = .center
        lbFCoin.textColor = UIColor(netHex:0xEF4A40)
        lbFCoin.layer.cornerRadius = 10.0
        lbFCoin.layer.borderColor = UIColor(netHex:0xEF4A40).cgColor
        lbFCoin.layer.borderWidth = 0.5
        lbFCoin.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        lbFCoin.text = "FPoint"
        lbFCoin.numberOfLines = 1
        viewToshibaPoint.addSubview(lbFCoin)
        
        let lbFCoinLable = UILabel(frame: CGRect(x: lbFCoin.frame.origin.x, y: lbFCoin.frame.size.height + lbFCoin.frame.origin.y+Common.Size(s:5), width: lbFCoin.frame.size.width, height: Common.Size(s:12)))
        lbFCoinLable.textAlignment = .center
        lbFCoinLable.textColor = .gray
        lbFCoinLable.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        lbFCoinLable.text = "FPoint"
        lbFCoinLable.numberOfLines = 1
        viewToshibaPoint.addSubview(lbFCoinLable)
        
        lbRanking = UILabel(frame: CGRect(x: lbFCoin.frame.size.width + lbFCoin.frame.origin.x + Common.Size(s: 5), y: 0, width: (viewToshibaPoint.frame.size.width - Common.Size(s: 10))/3, height: Common.Size(s:40)))
        lbRanking.textAlignment = .center
        lbRanking.textColor = UIColor(netHex:0xEF4A40)
        lbRanking.layer.cornerRadius = 10.0
        lbRanking.layer.borderColor = UIColor(netHex:0xEF4A40).cgColor
        lbRanking.layer.borderWidth = 0.5
        lbRanking.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        lbRanking.text = "Hạng thẻ"
        lbRanking.numberOfLines = 1
        viewToshibaPoint.addSubview(lbRanking)
        
        let lbRankingLable = UILabel(frame: CGRect(x: lbRanking.frame.origin.x, y: lbRanking.frame.size.height + lbRanking.frame.origin.y+Common.Size(s:5), width: lbRanking.frame.size.width, height: Common.Size(s:12)))
        lbRankingLable.textAlignment = .center
        lbRankingLable.textColor = .gray
        lbRankingLable.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        lbRankingLable.text = "Hạng thẻ"
        lbRankingLable.numberOfLines = 1
        viewToshibaPoint.addSubview(lbRankingLable)
        
        
        let tapFpoint = UITapGestureRecognizer(target: self, action: #selector(PaymentViewController.functionFpoint))
        lbFPoint.isUserInteractionEnabled = true
        lbFPoint.addGestureRecognizer(tapFpoint)
        
        let tapFcoin = UITapGestureRecognizer(target: self, action: #selector(PaymentViewController.functionFcoin))
        lbFCoin.isUserInteractionEnabled = true
        lbFCoin.addGestureRecognizer(tapFcoin)
        
        let tapRanking = UITapGestureRecognizer(target: self, action: #selector(PaymentViewController.functionRanking))
        lbRanking.isUserInteractionEnabled = true
        lbRanking.addGestureRecognizer(tapRanking)
        
        
        viewBelowToshibaPoint = UIView(frame: CGRect(x: 0, y: viewToshibaPoint.frame.origin.y + viewToshibaPoint.frame.size.height+Common.Size(s:20), width: scrollView.frame.size.width, height: Common.Size(s:58)))
        
        //tilte choose type
        let lbCartType = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: 0, width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbCartType.textAlignment = .left
        lbCartType.textColor = UIColor(netHex:0x04AB6E)
        lbCartType.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbCartType.text = "LOẠI ĐƠN HÀNG"
        //        scrollView.addSubview(lbCartType)
        
        viewBelowToshibaPoint.addSubview(lbCartType)
        
        radioAtTheCounter = createRadioButton(CGRect(x: lbCartType.frame.origin.x, y: lbCartType.frame.origin.y + lbCartType.frame.size.height+Common.Size(s:10), width: lbCartType.frame.size.width/3, height: Common.Size(s:20)), title: "Tại quầy", color: UIColor.black);
        //        scrollView.addSubview(radioAtTheCounter)
        viewBelowToshibaPoint.addSubview(radioAtTheCounter)
        
        radioInstallment = createRadioButton(CGRect(x: radioAtTheCounter.frame.origin.x + radioAtTheCounter.frame.size.width, y: radioAtTheCounter.frame.origin.y , width: radioAtTheCounter.frame.size.width, height: radioAtTheCounter.frame.size.height), title: "Trả góp", color: UIColor.black);
        //        scrollView.addSubview(radioInstallment)
        
        viewBelowToshibaPoint.addSubview(radioInstallment)
        
        radioDeposit = createRadioButton(CGRect(x: radioInstallment.frame.origin.x + radioInstallment.frame.size.width, y: radioAtTheCounter.frame.origin.y , width: radioInstallment.frame.size.width, height: radioInstallment.frame.size.height), title: "Đặt cọc", color: UIColor.black);
        //        scrollView.addSubview(radioDeposit)
        
        viewBelowToshibaPoint.addSubview(radioDeposit)
        
        if isTraCocEcom {
            radioAtTheCounter.isUserInteractionEnabled  = false
            radioInstallment.isUserInteractionEnabled  = false
            radioDeposit.isUserInteractionEnabled  = false
        }
        var btsHeight:CGFloat = Common.Size(s:18)
        if !isFromSearch {
            let showBts = UserDefaults.standard.bool(forKey: "NeedShowBTSButton")
            btsHeight = showBts ? Common.Size(s:18) : 0
        }
        let lblConfirmBTS = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: radioAtTheCounter.frame.origin.y + radioAtTheCounter.frame.size.height + 10, width: tfUserEmail.frame.size.width, height: btsHeight))
        lblConfirmBTS.textAlignment = .left
        lblConfirmBTS.attributedText = "XÁC NHẬN BACK TO SCHOOL".underLined
        lblConfirmBTS.textColor = UIColor(netHex:0x04AB6E)
        lblConfirmBTS.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lblConfirmBTS.text = "XÁC NHẬN BACK TO SCHOOL"
        lblConfirmBTS.isUserInteractionEnabled = true
        let btsGesture = UITapGestureRecognizer(target: self, action: #selector(btsAction))
        lblConfirmBTS.addGestureRecognizer(btsGesture)
        viewBelowToshibaPoint.addSubview(lblConfirmBTS)
        
        let lblCMSN = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: lblConfirmBTS.frame.origin.y + lblConfirmBTS.frame.size.height + 10, width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lblCMSN.textAlignment = .left
        lblCMSN.attributedText = "Mừng sinh nhật khách hàng tháng 3".underLined
        lblCMSN.textColor = UIColor(netHex:0x04AB6E)
        lblCMSN.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        lblCMSN.text = "Mừng sinh nhật khách hàng tháng 3"
        lblCMSN.isUserInteractionEnabled = true
        let cmsnGesture = UITapGestureRecognizer(target: self, action: #selector(cmsnAction))
        lblCMSN.addGestureRecognizer(cmsnGesture)
        viewBelowToshibaPoint.addSubview(lblCMSN)
        
        if (Cache.orderType == 1){
            radioAtTheCounter.isSelected = true
            orderType = 1
        }else if (Cache.orderType == 2){
            radioInstallment.isSelected = true
            orderType = 2
        }else if (Cache.orderType == 3){
            radioDeposit.isSelected = true
            orderType = 3
        }
        
        viewInstallment = UIView(frame: CGRect(x: tfUserEmail.frame.origin.x, y: lblCMSN.frame.origin.y  + lblCMSN.frame.size.height + 10, width: tfUserEmail.frame.size.width, height: 0))
        
        //tilte choose type pay
        let lbPayInstallment = UILabel(frame: CGRect(x: 0, y: 0, width: viewInstallment.frame.size.width, height: Common.Size(s:18)))
        lbPayInstallment.textAlignment = .left
        lbPayInstallment.textColor = UIColor(netHex:0x04AB6E)
        lbPayInstallment.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbPayInstallment.text = "LOẠI CHƯƠNG TRÌNH"
        viewInstallment.addSubview(lbPayInstallment)
        
        radioPayInstallmentCom = createRadioButtonPayInstallment(CGRect(x: 0 ,y:radioInstallment.frame.origin.y, width: viewInstallment.frame.size.width/2, height: radioInstallment.frame.size.height), title: "Nhà trả góp", color: UIColor.black);
        viewInstallment.addSubview(radioPayInstallmentCom)
        
        radioPayInstallmentCard = createRadioButtonPayInstallment(CGRect(x: viewInstallment.frame.size.width/2,y:lbPayInstallment.frame.origin.y + lbPayInstallment.frame.size.height + Common.Size(s:10) , width: lbPayInstallment.frame.size.width/2, height: radioAtTheCounter.frame.size.height), title: "Thẻ", color: UIColor.black);
        viewInstallment.addSubview(radioPayInstallmentCard)
        
        
        viewInstallmentCom = UIView(frame: CGRect(x:0,y:radioPayInstallmentCom.frame.size.height + radioPayInstallmentCom.frame.origin.y + Common.Size(s: 10),width:viewInstallment.frame.size.width,height:0))
        viewInstallmentCom.backgroundColor = .white
        viewInstallmentCom.clipsToBounds = true
        viewInstallment.addSubview(viewInstallmentCom)
        
        let lbTextCompany = UILabel(frame: CGRect(x: 0, y: 0, width: viewInstallmentCom.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCompany.textAlignment = .left
        lbTextCompany.textColor = UIColor.black
        lbTextCompany.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbTextCompany.text = "Nhà trả góp"
        viewInstallmentCom.addSubview(lbTextCompany)
        
        companyButton = SearchTextField(frame: CGRect(x: lbTextCompany.frame.origin.x, y: lbTextCompany.frame.origin.y + lbTextCompany.frame.size.height + Common.Size(s:10), width: viewInstallmentCom.frame.size.width, height: Common.Size(s:40)));
        
        companyButton.placeholder = "Chọn nhà trả góp"
        companyButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.borderStyle = UITextField.BorderStyle.roundedRect
        companyButton.autocorrectionType = UITextAutocorrectionType.no
        companyButton.keyboardType = UIKeyboardType.default
        companyButton.returnKeyType = UIReturnKeyType.done
        companyButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        companyButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        companyButton.delegate = self
        viewInstallmentCom.addSubview(companyButton)
        
        companyButton.startVisible = true
        companyButton.theme.bgColor = UIColor.white
        companyButton.theme.fontColor = UIColor.black
        companyButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.theme.cellHeight = Common.Size(s:40)
        companyButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        let lbTextLimit = UILabel(frame: CGRect(x: 0, y: companyButton.frame.size.height + companyButton.frame.origin.y + Common.Size(s:10), width: (viewInstallmentCom.frame.size.width - Common.Size(s:20))/2, height: Common.Size(s:14)))
        lbTextLimit.textAlignment = .left
        lbTextLimit.textColor = UIColor.black
        lbTextLimit.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbTextLimit.text = "Kỳ hạn"
        viewInstallmentCom.addSubview(lbTextLimit)
        
        tfLimit = UITextField(frame: CGRect(x:0, y: lbTextLimit.frame.size.height + lbTextLimit.frame.origin.y + Common.Size(s:5), width: lbTextLimit.frame.size.width, height: Common.Size(s:40)))
        tfLimit.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfLimit.borderStyle = UITextField.BorderStyle.roundedRect
        tfLimit.autocorrectionType = UITextAutocorrectionType.no
        tfLimit.keyboardType = UIKeyboardType.numberPad
        tfLimit.returnKeyType = UIReturnKeyType.done
        tfLimit.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfLimit.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfLimit.delegate = self
        tfLimit.placeholder = "Nhập kỳ hạn"
        viewInstallmentCom.addSubview(tfLimit)
        
        let lbTextInterestRate = UILabel(frame: CGRect(x: viewInstallmentCom.frame.size.width/2 + Common.Size(s:10) , y: lbTextLimit.frame.origin.y, width: (viewInstallmentCom.frame.size.width - Common.Size(s:20))/2, height: Common.Size(s:14)))
        lbTextInterestRate.textAlignment = .left
        lbTextInterestRate.textColor = UIColor.black
        lbTextInterestRate.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbTextInterestRate.text = "Lãi suất"
        viewInstallmentCom.addSubview(lbTextInterestRate)
        
        tfInterestRateCom = UITextField(frame: CGRect(x:lbTextInterestRate.frame.origin.x, y: lbTextLimit.frame.size.height + lbTextLimit.frame.origin.y + Common.Size(s:5), width: lbTextLimit.frame.size.width, height: Common.Size(s:40)))
        tfInterestRateCom.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfInterestRateCom.borderStyle = UITextField.BorderStyle.roundedRect
        tfInterestRateCom.autocorrectionType = UITextAutocorrectionType.no
        tfInterestRateCom.keyboardType = UIKeyboardType.decimalPad
        tfInterestRateCom.returnKeyType = UIReturnKeyType.done
        tfInterestRateCom.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfInterestRateCom.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfInterestRateCom.delegate = self
        tfInterestRateCom.placeholder = "Nhập lãi suất"
        viewInstallmentCom.addSubview(tfInterestRateCom)
        
        let lbTextCMND = UILabel(frame: CGRect(x: 0, y: tfLimit.frame.size.height + tfLimit.frame.origin.y + Common.Size(s:10), width: tfLimit.frame.size.width, height: Common.Size(s:14)))
        lbTextCMND.textAlignment = .left
        lbTextCMND.textColor = UIColor.black
        lbTextCMND.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbTextCMND.text = "CMND"
        viewInstallmentCom.addSubview(lbTextCMND)
        
        
        tfCMND = UITextField(frame: CGRect(x:0, y: lbTextCMND.frame.size.height + lbTextCMND.frame.origin.y + Common.Size(s:5), width: lbTextCMND.frame.size.width, height: Common.Size(s:40)))
        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMND.autocorrectionType = UITextAutocorrectionType.no
        tfCMND.keyboardType = UIKeyboardType.numberPad
        tfCMND.returnKeyType = UIReturnKeyType.done
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMND.delegate = self
        tfCMND.placeholder = "Nhập CMND"
        viewInstallmentCom.addSubview(tfCMND)
        
        
        let lbTextContractNumber = UILabel(frame: CGRect(x: lbTextInterestRate.frame.origin.x, y: lbTextCMND.frame.origin.y, width: lbTextCMND.frame.size.width, height: Common.Size(s:14)))
        lbTextContractNumber.textAlignment = .left
        lbTextContractNumber.textColor = UIColor.black
        lbTextContractNumber.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbTextContractNumber.text = "Số hợp đồng"
        viewInstallmentCom.addSubview(lbTextContractNumber)
        
        tfContractNumber = UITextField(frame: CGRect(x:lbTextContractNumber.frame.origin.x, y:tfCMND.frame.origin.y , width: tfCMND.frame.size.width, height: Common.Size(s:40)))
        tfContractNumber.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        tfContractNumber.borderStyle = UITextField.BorderStyle.roundedRect
        tfContractNumber.autocorrectionType = UITextAutocorrectionType.no
        tfContractNumber.keyboardType = UIKeyboardType.default
        tfContractNumber.returnKeyType = UIReturnKeyType.done
        tfContractNumber.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfContractNumber.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfContractNumber.delegate = self
        tfContractNumber.placeholder = "Nhập số HĐ"
        viewInstallmentCom.addSubview(tfContractNumber)
        
        let lbTextPrepay = UILabel(frame: CGRect(x: 0, y: tfContractNumber.frame.origin.y + tfContractNumber.frame.size.height + Common.Size(s:10), width: viewInstallmentCom.frame.size.width, height: Common.Size(s:14)))
        lbTextPrepay.textAlignment = .left
        lbTextPrepay.textColor = UIColor.black
        lbTextPrepay.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbTextPrepay.text = "Số tiền trả trước"
        viewInstallmentCom.addSubview(lbTextPrepay)
        
        tfPrepayCom = UITextField(frame: CGRect(x:0, y:lbTextPrepay.frame.origin.y + lbTextPrepay.frame.size.height + Common.Size(s:5), width: viewInstallmentCom.frame.size.width, height: Common.Size(s:40)))
        tfPrepayCom.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPrepayCom.borderStyle = UITextField.BorderStyle.roundedRect
        tfPrepayCom.autocorrectionType = UITextAutocorrectionType.no
        tfPrepayCom.keyboardType = UIKeyboardType.numberPad
        tfPrepayCom.returnKeyType = UIReturnKeyType.done
        tfPrepayCom.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPrepayCom.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPrepayCom.delegate = self
        tfPrepayCom.placeholder = "Nhập số tiền trả trước"
        viewInstallmentCom.addSubview(tfPrepayCom)
        
        viewInstallmentCard = UIView(frame: CGRect(x:0,y:radioPayInstallmentCom.frame.size.height + radioPayInstallmentCom.frame.origin.y + Common.Size(s: 10),width:viewInstallment.frame.size.width,height:0))
        viewInstallment.addSubview(viewInstallmentCard)
        viewInstallmentCard.clipsToBounds = true
        
        tfInterestRate = UITextField(frame: CGRect(x: 0, y: Common.Size(s:10), width: tfUserAddress.frame.size.width , height: tfUserAddress.frame.size.height ));
        tfInterestRate.placeholder = "Lãi suất"
        tfInterestRate.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfInterestRate.borderStyle = UITextField.BorderStyle.roundedRect
        tfInterestRate.autocorrectionType = UITextAutocorrectionType.no
        tfInterestRate.keyboardType = UIKeyboardType.decimalPad
        tfInterestRate.returnKeyType = UIReturnKeyType.done
        tfInterestRate.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfInterestRate.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfInterestRate.delegate = self
        viewInstallmentCard.addSubview(tfInterestRate)
        tfInterestRate.addTarget(self, action: #selector(textFieldDidChangeInterestRate(_:)), for: .editingChanged)
        tfInterestRate.text = Cache.vlInterestRate
        
        tfPrepay = UITextField(frame: CGRect(x: 0, y: tfInterestRate.frame.origin.y + tfInterestRate.frame.size.height + Common.Size(s:10), width: tfUserAddress.frame.size.width , height: tfUserAddress.frame.size.height ));
        tfPrepay.placeholder = "Trả trước"
        tfPrepay.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPrepay.borderStyle = UITextField.BorderStyle.roundedRect
        tfPrepay.autocorrectionType = UITextAutocorrectionType.no
        tfPrepay.keyboardType = UIKeyboardType.decimalPad
        tfPrepay.returnKeyType = UIReturnKeyType.done
        tfPrepay.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPrepay.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPrepay.delegate = self
        viewInstallmentCard.addSubview(tfPrepay)
        tfPrepay.addTarget(self, action: #selector(textFieldDidChangePrepay(_:)), for: .editingChanged)
        tfPrepay.text = Cache.vlPrepay
        
        if(Cache.orderPayInstallment == 0 || Cache.orderPayInstallment == -1){
            radioPayInstallmentCom.isSelected = true
            orderPayInstallment = 0
            
            viewInstallmentCom.frame.size.height = tfPrepayCom.frame.size.height + tfPrepayCom.frame.origin.y + Common.Size(s:20)
            viewInstallment.frame.size.height = viewInstallmentCom.frame.size.height + viewInstallmentCom.frame.origin.y
        }else if (Cache.orderPayInstallment == 1){
            radioPayInstallmentCard.isSelected = true
            orderPayInstallment = 1
            
            viewInstallmentCard.frame.size.height = tfPrepay.frame.size.height + tfPrepay.frame.origin.y + Common.Size(s:20)
            viewInstallment.frame.size.height = viewInstallmentCard.frame.size.height + viewInstallmentCard.frame.origin.y
        }
        
        viewInstallmentHeight = viewInstallment.frame.size.height
        //        scrollView.addSubview(viewInstallment)
        
        viewBelowToshibaPoint.addSubview(viewInstallment)
        viewInstallment.clipsToBounds = true
        if (Cache.orderType != 2){
            viewInstallment.frame.size.height = 0
        }
        viewInfoDetail = UIView(frame: CGRect(x: 0, y: viewInstallment.frame.origin.y  + viewInstallment.frame.size.height, width: self.view.frame.size.width, height: 0))
        
        let lbTG = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: 0, width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbTG.textAlignment = .left
        lbTG.textColor = UIColor(netHex:0x04AB6E)
        lbTG.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbTG.text = "CT KH RỚT TRẢ GÓP"
        viewInfoDetail.addSubview(lbTG)
        
        radioTGYes = createRadioButtonPayTG(CGRect(x: radioAtTheCounter.frame.origin.x,y:lbTG.frame.origin.y + lbTG.frame.size.height + Common.Size(s:10) , width: lbTG.frame.size.width/2, height: radioAtTheCounter.frame.size.height), title: "Có", color: UIColor.black);
        viewInfoDetail.addSubview(radioTGYes)
        
        radioTGNo = createRadioButtonPayTG(CGRect(x: radioInstallment.frame.origin.x ,y:radioTGYes.frame.origin.y, width: radioTGYes.frame.size.width, height: radioTGYes.frame.size.height), title: "Không", color: UIColor.black);
        viewInfoDetail.addSubview(radioTGNo)
        radioTGNo.isSelected = true
        isTG = 0
        Cache.is_KHRotTG = 0
        
        let lbTGSamsung = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: radioTGYes.frame.size.height + radioTGYes.frame.origin.y + Common.Size(s:10), width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbTGSamsung.textAlignment = .left
        lbTGSamsung.textColor = UIColor(netHex:0x04AB6E)
        lbTGSamsung.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbTGSamsung.text = "TRẢ GÓP SAMSUNG"
        viewInfoDetail.addSubview(lbTGSamsung)
        
        radioTGSSYes = createRadioButtonPayTGSS(CGRect(x: radioAtTheCounter.frame.origin.x,y:lbTGSamsung.frame.origin.y + lbTGSamsung.frame.size.height + Common.Size(s:10) , width: lbTG.frame.size.width/2, height: radioAtTheCounter.frame.size.height), title: "Có", color: UIColor.black);
        viewInfoDetail.addSubview(radioTGSSYes)
        
        radioTGSSNo = createRadioButtonPayTGSS(CGRect(x: radioInstallment.frame.origin.x ,y:radioTGSSYes.frame.origin.y, width: radioTGYes.frame.size.width, height: radioTGYes.frame.size.height), title: "Không", color: UIColor.black);
        viewInfoDetail.addSubview(radioTGSSNo)
        radioTGSSNo.isSelected = true
        is_samsung = 0
        Cache.is_samsung = 0
        
        let lbDuAn = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: radioTGSSYes.frame.size.height + radioTGSSYes.frame.origin.y + Common.Size(s:10), width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbDuAn.textAlignment = .left
        lbDuAn.textColor = UIColor(netHex:0x04AB6E)
        lbDuAn.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbDuAn.text = "ĐƠN HÀNG DỰ ÁN"
        viewInfoDetail.addSubview(lbDuAn)
        
        radioDHDUYes = createRadioButtonDHDuAn(CGRect(x: radioAtTheCounter.frame.origin.x,y:lbDuAn.frame.origin.y + lbDuAn.frame.size.height + Common.Size(s:10) , width: lbTG.frame.size.width/2, height: radioAtTheCounter.frame.size.height), title: "Có", color: UIColor.black);
        viewInfoDetail.addSubview(radioDHDUYes)
        
        radioDHDUNo = createRadioButtonDHDuAn(CGRect(x: radioInstallment.frame.origin.x ,y:radioDHDUYes.frame.origin.y, width: radioDHDUYes.frame.size.width, height: radioDHDUYes.frame.size.height), title: "Không", color: UIColor.black);
        viewInfoDetail.addSubview(radioDHDUNo)
        radioDHDUNo.isSelected = true
        is_DH_DuAn = "N"
        Cache.is_DH_DuAn = "N"
        
        //tilte choose type pay
        lbPayType = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: radioDHDUYes.frame.origin.y + radioDHDUYes.frame.size.height + Common.Size(s:10), width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbPayType.textAlignment = .left
        lbPayType.textColor = UIColor(netHex:0x04AB6E)
        lbPayType.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbPayType.text = "LOẠI THANH TOÁN"
        viewInfoDetail.addSubview(lbPayType)
        
        radioPayNow = createRadioButtonPayType(CGRect(x: radioAtTheCounter.frame.origin.x,y:lbPayType.frame.origin.y + lbPayType.frame.size.height + Common.Size(s:10) , width: lbPayType.frame.size.width/2, height: radioAtTheCounter.frame.size.height), title: "Trực tiếp", color: UIColor.black);
        viewInfoDetail.addSubview(radioPayNow)
        
        radioPayNotNow = createRadioButtonPayType(CGRect(x: radioInstallment.frame.origin.x ,y:radioPayNow.frame.origin.y, width: radioPayNow.frame.size.width, height: radioPayNow.frame.size.height), title: "Khác", color: UIColor.black);
        viewInfoDetail.addSubview(radioPayNotNow)
        
        if (Cache.orderPayType == 1){
            radioPayNow.isSelected = true
            orderPayType = 1
        }else if (Cache.orderPayType == 2){
            radioPayNotNow.isSelected = true
            orderPayType = 2
        }
        viewVoucher = UIView(frame: CGRect(x:0,y:radioPayNotNow.frame.origin.y + radioPayNotNow.frame.size.height + Common.Size(s:10),width:viewInfoDetail.frame.size.width,height:100))
        //        viewVoucher.backgroundColor = .yellow
        viewInfoDetail.addSubview(viewVoucher)
        
        let  lbVoucher = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: Common.Size(s:0), width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
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
        
        tableViewVoucherNoPrice.frame = CGRect(x: tfUserEmail.frame.origin.x, y:lbVoucher.frame.size.height + lbVoucher.frame.origin.y + Common.Size(s:10), width: self.view.frame.size.width, height: 0)
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        tableViewVoucherNoPrice.dataSource = self
        tableViewVoucherNoPrice.delegate = self
        tableViewVoucherNoPrice.register(ItemVoucherNoPriceTableViewCell.self, forCellReuseIdentifier: "ItemVoucherNoPriceTableViewCell")
        tableViewVoucherNoPrice.tableFooterView = UIView()
        tableViewVoucherNoPrice.backgroundColor = UIColor.white
        viewVoucher.addSubview(tableViewVoucherNoPrice)
        
        if(Cache.listVoucherNoPrice.count > 0){
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
        
        let lbNotes = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: 0, width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbNotes.textAlignment = .left
        lbNotes.textColor = UIColor(netHex:0x04AB6E)
        lbNotes.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbNotes.text = "GHI CHÚ"
        viewFull.addSubview(lbNotes)
        
        taskNotes = UITextView(frame: CGRect(x: radioAtTheCounter.frame.origin.x , y: lbNotes.frame.origin.y  + lbNotes.frame.size.height + Common.Size(s:10), width: lbCartType.frame.size.width, height: tfUserEmail.frame.size.height * 2 ))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        taskNotes.layer.borderWidth = 0.5
        taskNotes.layer.borderColor = borderColor.cgColor
        taskNotes.layer.cornerRadius = 5.0
        taskNotes.delegate = self
        taskNotes.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        viewFull.addSubview(taskNotes)
        
        placeholderLabel = UILabel()
        placeholderLabel.text = "Ghi chú đơn hàng"
        placeholderLabel.font = UIFont.systemFont(ofSize: (taskNotes.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        taskNotes.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (taskNotes.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !taskNotes.text.isEmpty
        
        
        let soViewPhone = UIView()
        viewFull.addSubview(soViewPhone)
        soViewPhone.frame = CGRect(x: taskNotes.frame.origin.x, y: taskNotes.frame.origin.y + taskNotes.frame.size.height + Common.Size(s:20), width: taskNotes.frame.size.width, height: 100)
        
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
        // layout gio hang
        var isShowSupportEmployee: Bool = false
        for item in Cache.carts{
           
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
            var lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: 3, width: soViewPhone.frame.size.width - line3.frame.origin.x, height: sizeNameProduct))
            lbNameProduct.textAlignment = .left
            lbNameProduct.textColor = UIColor.black
            lbNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbNameProduct.text = nameProduct
            lbNameProduct.numberOfLines = 3
			soViewLine.addSubview(lbNameProduct)
			if item.product.hotSticker {
				let imageAttachment = NSTextAttachment()
				imageAttachment.image = UIImage(named: "ic_hot3")
				let imageString = NSAttributedString(attachment: imageAttachment)
				imageAttachment.bounds = CGRect(x: -10, y: 0, width: 65, height: 23)
				let textString = NSAttributedString(string: " \(nameProduct)")
				let combinedString = NSMutableAttributedString()
				combinedString.append(imageString)
				combinedString.append(textString)
				lbNameProduct.text = ""
				lbNameProduct.attributedText = combinedString
				lbNameProduct.snp.updateConstraints { make in
					make.top.right.equalToSuperview()
					make.left.equalTo(line1).offset(10)
				}

			}
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
            if (item.product.isPickGoiBH != ""){
                lbQuantityProduct.text = "IMEI: "
                
            }
            lbQuantityProduct.numberOfLines = 1
            soViewLine.addSubview(lbQuantityProduct)
            
            let lbPriceProduct = UILabel(frame: CGRect(x: lbQuantityProduct.frame.origin.x , y: lbQuantityProduct.frame.origin.y + lbQuantityProduct.frame.size.height + Common.Size(s:5), width: lbQuantityProduct.frame.size.width/2, height: Common.Size(s:14)))
            lbPriceProduct.textAlignment = .left
            lbPriceProduct.textColor = UIColor(netHex:0xEF4A40)
            lbPriceProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbPriceProduct.text = "Giá: \(Common.convertCurrencyFloat(value: (item.product.price)))"
            lbPriceProduct.numberOfLines = 1
            soViewLine.addSubview(lbPriceProduct)
            listPrice.append(lbPriceProduct)
            if (item.product.isPickGoiBH != ""){
                lbPriceProduct.text = "Giá: 0đ"
            }
            let lbAddDiscount = UILabel(frame: CGRect(x:lbPriceProduct.frame.origin.x + lbPriceProduct.frame.size.width, y:lbPriceProduct.frame.origin.y , width: lbPriceProduct.frame.size.width, height: lbPriceProduct.frame.size.height))
            lbAddDiscount.textAlignment = .right
            lbAddDiscount.textColor = UIColor(netHex:0xEF4A40)
            lbAddDiscount.font = UIFont.italicSystemFont(ofSize: Common.Size(s:14))
            let underlineAttribute1 = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString1 = NSAttributedString(string: "Giảm giá", attributes: underlineAttribute1)
            lbAddDiscount.attributedText = underlineAttributedString1
            soViewLine.addSubview(lbAddDiscount)
            listLbDiscount.append(lbAddDiscount)
            
            if(item.discount > 0){
                lbAddDiscount.textColor = UIColor.blue
                let underlineAttribute1 = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
                let underlineAttributedString1 = NSAttributedString(string: "Giảm: \(Common.convertCurrency(value: item.discount))", attributes: underlineAttribute1)
                lbAddDiscount.attributedText = underlineAttributedString1
            }else{
                lbAddDiscount.textColor = UIColor(netHex:0xEF4A40)
                let underlineAttribute1 = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
                let underlineAttributedString1 = NSAttributedString(string: "Giảm giá", attributes: underlineAttribute1)
                lbAddDiscount.attributedText = underlineAttributedString1
            }
            
            let soSelectDiscount = UIView(frame:CGRect(x: lbAddDiscount.frame.origin.x + lbAddDiscount.frame.size.width/2, y: lbQuantityProduct.frame.origin.y, width: lbAddDiscount.frame.size.width/2, height: lbAddDiscount.frame.size.height + lbAddDiscount.frame.origin.y - lbQuantityProduct.frame.origin.y))
            soViewLine.addSubview(soSelectDiscount)
            soSelectDiscount.tag = num - 1

            let tapShowSelectDiscount = UITapGestureRecognizer(target: self, action: #selector(PaymentViewController.tapShowSelectDiscount))
            soSelectDiscount.isUserInteractionEnabled = true
            soSelectDiscount.addGestureRecognizer(tapShowSelectDiscount)
            
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
        //het show gio hang
        soViewPhone.frame.size.height = indexHeight
        
        
        let soViewPromos = UIView()
        soViewPromos.frame = CGRect(x: soViewPhone.frame.origin.x, y: soViewPhone.frame.origin.y + soViewPhone.frame.size.height + Common.Size(s:20), width: soViewPhone.frame.size.width, height: 0)
        viewFull.addSubview(soViewPromos)
        
        var promos:[ProductPromotions] = []
        //        var discountPay:Float = 0.0
        Cache.itemsPromotionTemp.removeAll()
        
        for item in Cache.itemsPromotion{
            
            let it = item
            if (it.TienGiam <= 0){
                if (promos.count == 0){
                    promos.append(it)
                    Cache.itemsPromotionTemp.append(item)
                }else{
                    for pro in promos {
                        if (pro.SanPham_Tang == it.SanPham_Tang){
                            pro.SL_Tang =  pro.SL_Tang + item.SL_Tang
                        }else{
                            promos.append(it)
                            Cache.itemsPromotionTemp.append(item)
                        }
                    }
                }
            }else{
                Cache.itemsPromotionTemp.append(item)
                discountPay = discountPay + it.TienGiam
            }
        }
        for item in  Cache.itemsPromotionTemp{
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
        listTongDonHang.append(lbTotalValue)
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
        listTotal.append(lbPayValue)
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
        //        scrollView.addSubview(viewInfoDetail)
        
        
        viewBelowToshibaPoint.addSubview(viewInfoDetail)
        viewBelowToshibaPoint.frame.size.height = viewInfoDetail.frame.size.height + viewInfoDetail.frame.origin.y + Common.Size(s: 5)
        scrollView.addSubview(viewBelowToshibaPoint)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewBelowToshibaPoint.frame.origin.y + viewBelowToshibaPoint.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        //hide keyboard
        self.hideKeyboardWhenTappedAround()
        
        companyButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.companyButton.text = item.title
            let obj =  self.listCompany.filter{ $0.CardName == "\(item.title)" }.first
            if let id = obj?.CardCode {
                self.maCty = "\(id)"
                var check: Bool = false
                for it in self.listDebitCustomer {
                    if("\(id)" == it.MaCty){
                        check = true
                        self.debitCustomer = nil
                        self.companyButton.text = "\(obj!.CardName)"
                        self.tfCMND.text = "\(it.CustomerIdCard)"
                        self.tfCMND.isEnabled = false
                        self.tfLimit.text = "\(it.TenureOfLoan)"
                        self.tfLimit.isEnabled = false
                        self.tfInterestRateCom.text = "\(it.Interestrate)"
                        self.tfInterestRateCom.isEnabled = false
                        self.tfContractNumber.text = "\(it.ContractNo_AgreementNo)"
                        self.tfContractNumber.isEnabled = false
                        
                        
                        self.tfPrepayCom.text = "\(it.DownPaymentAmount.cleanValue)"
                        self.tfPrepayCom.isEnabled = false
                        break
                    }
                }
                if(!check){
                    self.tfCMND.isEnabled = true
                    self.tfLimit.isEnabled = true
                    self.tfInterestRateCom.isEnabled = true
                    self.tfContractNumber.isEnabled = true
                    self.tfPrepayCom.isEnabled = true
                    self.debitCustomer = nil
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
            }
        }
        if Cache.type_so == 1 {
            tfPhoneNumber.isUserInteractionEnabled = false
            
        }
        if tfPhoneNumber.text == "" {
            tfPhoneNumber.isUserInteractionEnabled = true
        }
        if tfPhoneNumber.text != "" {
            loadListVCNoPrice(phonenumber: tfPhoneNumber.text ?? "")
        }
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
    
    @objc func btsAction() {
        if tfPhoneNumber.text == "" {
            self.showDialog(text: "Bạn chưa nhập số điện thoại khách hàng!")
            tfPhoneNumber.isUserInteractionEnabled = true
            return
        }
        let vc = HomeBackToSchoolScreen()
        vc.isFromSearch = isFromSearch
        vc.tracocItem = self.tracocItem
        vc.showFull = true
        vc.phone = tfPhoneNumber.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func cmsnAction() {
        if tfPhoneNumber.text == "" {
            self.showDialog(text: "Bạn chưa nhập số điện thoại khách hàng!")
            tfPhoneNumber.isUserInteractionEnabled = true
            return
        }
        let vc = CMSNViewController()
        vc.phone = tfPhoneNumber.text ?? ""
//        vc.didScanComplete = { name, birthday in
//            self.tfUserName.text = name
//            self.tfUserBirthday.text = birthday
//        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapShowSelectDiscount(sender:UITapGestureRecognizer) {
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
        let view:UIView = sender.view!
        let newViewController = DiscountViewController()
        newViewController.delegate = self
        newViewController.indx = view.tag
        newViewController.itemCart = Cache.carts[view.tag]
        newViewController.total = totalPay - discountPay
        newViewController.is_DH_DuAn = is_DH_DuAn
        self.navigationController?.pushViewController(newViewController, animated: true)
        
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
        newViewController.delegate = self
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func supportEmployee(is_sale_MDMH: String, is_sale_software: String) {
        Cache.is_sale_MDMH = is_sale_MDMH
        Cache.is_sale_software = is_sale_software
    }
    
    
    @objc func tapShowAddVoucher(sender:UITapGestureRecognizer) {
        if(tfPhoneNumber.text! == ""){
            self.showDialog(text: "Bạn chưa nhập số điện thoại khách hàng !!!")
            return
        }
        if orderType == -1 {
            self.showDialog(text: "Bạn phải chọn loại đơn hàng!")
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
                
                var docType:String = "01"
                switch self.orderType {
                case 1:
                    docType = "01"
                case 2:
                    docType = "02"
                case 3:
                    docType = "05"
                default:
                    docType = "01"
                }
                
                let newViewController = LoadingViewController()
                newViewController.content = "Đang kiểm tra thông tin..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                MPOSAPIManager.mpos_FRT_SP_check_VC_crm(voucher:"\(fNameField.text!)",sdt:"\(self.tfPhoneNumber.text!)",doctype:"\(docType)") { (p_status,p_message,err) in
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
                                let alertController = UIAlertController(title: "Thông báo", message: "Bạn có muốn sử dụng voucher này ?", preferredStyle: .alert)
                                
                                let confirmAction = UIAlertAction(title: "Có", style: .default) { (_) in
                                    let newViewController = CheckVoucherOTPViewController()
                                    newViewController.delegate = self
                                    newViewController.phone = self.tfPhoneNumber.text!
                                    newViewController.doctype = docType
                                    newViewController.voucher = fNameField.text!
                                    
                                    let navController = UINavigationController(rootViewController: newViewController)
                                    self.navigationController?.present(navController, animated:false, completion: nil)
                                }
                                let rejectConfirm =  UIAlertAction(title: "Không", style: .cancel) { (_) in
                                    
                                }
                                alertController.addAction(rejectConfirm)
                                alertController.addAction(confirmAction)
                                
                                
                                self.present(alertController, animated: true, completion: nil)
                            }
                            if(p_status == 0){//0
                                
                                let voucherObject = VoucherNoPrice(VC_Code: fNameField.text!, VC_Name: "", Endate: "", U_OTPcheck: "", STT: 0, isSelected: true)
                                Cache.listVoucherNoPrice.append(voucherObject)
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
    func returnVoucher(voucher:String) {
        let voucherObject = VoucherNoPrice(VC_Code: voucher, VC_Name: "", Endate: "", U_OTPcheck: "", STT: 0, isSelected: false)
        Cache.listVoucherNoPrice.append(voucherObject)
        self.tableViewVoucherNoPrice.reloadData()
        self.autoSizeView()
    }
    func returnCheckOTPVoucher(voucher:String){
        for item in Cache.listVoucherNoPrice{
            if(item.VC_Code == voucher){
                item.isSelected = true
                break
            }
        }
        self.tableViewVoucherNoPrice.reloadData()
        self.autoSizeView()
    }
    
    
    @objc func tapFunctionToshiba(sender:UITapGestureRecognizer) {
        //      Toast(text: "Tính năng đang phát triển!")
        //        return
        let phone = tfPhoneNumber.text!
        if (phone.hasPrefix("01") && phone.count == 11){
            
        }else if (phone.hasPrefix("0") && !phone.hasPrefix("01") && phone.count == 10){
            
        }else{
            self.showDialog(text: "Số điện thoại không hợp lệ!")
            
            return
        }
        
        if (self.viewToshibaPoint.frame.size.height == 0){
            
            let newViewController = LoadingViewController()
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            newViewController.content = "Đang kiểm tra thông tin điểm thưởng"
            self.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            MPOSAPIManager.searchCustomersToshiba(phoneNumber: "\(phone)") { (results, err) in
                if(results.count > 0){
                    let customer = results[0]
                    MPOSAPIManager.getToshibaPoint(idCardPoint: "\(customer.IDcardPoint)", handler: { (result, err) in
                        
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            
                            if (err.count > 0){
                                self.showDialog(text: "Không tìm thấy thông tin điểm thưởng!")
                            }else{
                                self.lbFPoint.text = Common.convertCurrencyV2(value: result!.FPoint)
                                self.lbFCoin.text = Common.convertCurrencyV2(value: result!.FCoin)
                                self.lbRanking.text = result!.CurrentRank
                                
                                self.viewToshibaPoint.frame.size.height = Common.Size(s:60)
                                
                                self.viewBelowToshibaPoint.frame.origin.y = self.viewToshibaPoint.frame.size.height + self.viewToshibaPoint.frame.origin.y + Common.Size(s: 10)
                                
                                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.viewBelowToshibaPoint.frame.origin.y + self.viewBelowToshibaPoint.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                            }
                        }
                    })
                    
                }else{
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        self.showDialog(text: "Không tìm thấy thông tin khách hàng!")
                    }
                }
            }
        }else{
            self.viewToshibaPoint.frame.size.height = 0
            self.viewBelowToshibaPoint.frame.origin.y = self.viewToshibaPoint.frame.size.height + self.viewToshibaPoint.frame.origin.y + Common.Size(s: 10)
            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewBelowToshibaPoint.frame.origin.y + viewBelowToshibaPoint.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        }
        
        
    }
    func showDialog(text:String){
        let alert = UIAlertController(title: "Thông báo", message: text, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
            
        })
        self.present(alert, animated: true)
    }
    @objc func functionFpoint(_ sender:UITapGestureRecognizer){
        let phone = tfPhoneNumber.text!
        if (phone.hasPrefix("01") && phone.count == 11){
            
        }else if (phone.hasPrefix("0") && !phone.hasPrefix("01") && phone.count == 10){
            
        }else{
            self.showDialog(text: "Số điện thoại không hợp lệ!")
            return
        }
        let newViewController = LoadingViewController()
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        newViewController.content = "Đang kiểm tra thông tin điểm thưởng"
        self.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.searchCustomersToshiba(phoneNumber: "\(phone)") { (results, err) in
            if(results.count > 0){
                let customer = results[0]
                MPOSAPIManager.getToshibaPoint(idCardPoint: "\(customer.IDcardPoint)", handler: { (result, err) in
                    
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        
                        if (err.count > 0){
                            self.showDialog(text: "Không tìm thấy thông tin điểm thưởng!")
                            
                        }else{
                            let alert = UIAlertController(title: "FPoint", message: "Tổng điểm của hạng thẻ là: \r\n \(result!.FPoint)", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                
                            })
                            self.present(alert, animated: true)
                        }
                    }
                })
                
            }else{
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    self.showDialog(text: "Không tìm thấy thông tin khách hàng!")
                }
            }
        }
    }
    
    @objc func functionFcoin(_ sender:UITapGestureRecognizer){
        let phone = tfPhoneNumber.text!
        if (phone.hasPrefix("01") && phone.count == 11){
            
        }else if (phone.hasPrefix("0") && !phone.hasPrefix("01") && phone.count == 10){
            
        }else{
            self.showDialog(text: "Số điện thoại không hợp lệ!")
            return
        }
        let newViewController = LoadingViewController()
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        newViewController.content = "Đang kiểm tra thông tin điểm thưởng"
        self.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.searchCustomersToshiba(phoneNumber: "\(phone)") { (results, err) in
            if(results.count > 0){
                let customer = results[0]
                MPOSAPIManager.getToshibaPoint(idCardPoint: "\(customer.IDcardPoint)", handler: { (result, err) in
                    
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        
                        if (err.count > 0){
                            self.showDialog(text: "Không tìm thấy thông tin điểm thưởng!")
                        }else{
                            let alert = UIAlertController(title: "FCoin", message: "Tổng điểm của voucher: \r\n \(result!.FCoin)", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                
                            })
                            self.present(alert, animated: true)
                        }
                    }
                })
                
            }else{
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    self.showDialog(text: "Không tìm thấy thông tin khách hàng!")
                }
            }
        }
    }
    @objc func functionRanking(_ sender:UITapGestureRecognizer){
        let phone = tfPhoneNumber.text!
        if (phone.hasPrefix("01") && phone.count == 11){
            
        }else if (phone.hasPrefix("0") && !phone.hasPrefix("01") && phone.count == 10){
            
        }else{
            self.showDialog(text: "Số điện thoại không hợp lệ!")
            return
        }
        let newViewController = LoadingViewController()
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        newViewController.content = "Đang kiểm tra thông tin điểm thưởng"
        self.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.searchCustomersToshiba(phoneNumber: "\(phone)") { (results, err) in
            if(results.count > 0){
                let customer = results[0]
                MPOSAPIManager.getToshibaPoint(idCardPoint: "\(customer.IDcardPoint)", handler: { (result, err) in
                    
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        
                        if (err.count > 0){
                            self.showDialog(text: "Không tìm thấy thông tin hạng thẻ!")
                        }else{
                            let alert = UIAlertController(title: "Hạng thẻ", message: "Tên của hạng thẻ: \r\n \(result!.CurrentRank)", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                
                            })
                            self.present(alert, animated: true)
                        }
                    }
                })
                
            }else{
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    self.showDialog(text: "Không tìm thấy thông tin khách hàng!")
                }
            }
        }
    }
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        isScanImei = true
        // do other task
        let view:UIView = sender.view!
        itemCart = Cache.carts[view.tag]
        guard let index22 = sender.view?.tag else {
            return
        }
        
        self.indexCart = index22
        //        self.indexCart = Cache.carts[view.tag]
        self.lbImei = listImei[view.tag]
        self.lblPrice = listPrice[view.tag]
        self.lblTongDonHang = listTongDonHang[0]
        self.lblTongThanhtoan = listTotal[0]
        if(itemCart.product.qlSerial == "Y"){
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
                self.didScanCode(code: code)
            }
            self.present(viewController, animated: false, completion: nil)
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
                    viewController.scanSuccess = { code in
                        self.didScanCode(code: code)
                    }
                    self.present(viewController, animated: false, completion: nil)
                }))
                alert.addAction(UIAlertAction(title: "Xác nhận", style: .default, handler: { [weak alert] (_) in
                    if var username = alert?.textFields![0].text  {
                        username = username.trim()
                        if(username.count > 0){
                            self.itemCart.Warr_imei = username
                            self.lbImei.text = "IMEI: \(self.itemCart.Warr_imei)"
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
    func loadImeiGoiBH(){
        
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
        if(tfPhoneNumber.text! == ""){
            self.showDialog(text: "Bạn chưa nhập số điện thoại khách hàng !!!")
            return
        }
        if orderType == -1 {
            self.showDialog(text: "Bạn phải chọn loại đơn hàng!")
            return
        }
        isScanImei = false
        
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { code in
            self.didScanCode(code: code)
        }
        self.present(viewController, animated: false, completion: nil)
    }
    
    func didScanCode(code:String) {
        if(isScanImei){
            if(code != "SELECT_IMEI"){
                if(itemCart.product.qlSerial == "Y"){
                    let newViewController = LoadingViewController()
                    newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                    newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                    self.present(newViewController, animated: true, completion: nil)
                    
                    MPOSAPIManager.getImei(productCode: "\(itemCart.product.sku)", shopCode: "\(Cache.user!.ShopCode)") { (result, err) in
                        let nc = NotificationCenter.default
                        if (result.count > 0){
                            var checkImei: Bool = false
                            for item in result {
                                if(code == item.DistNumber){
                                    checkImei = true
                                    let when = DispatchTime.now() + 1
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                        
                                        var check: Bool = true
                                        for item in Cache.carts {
                                            if (item.product.qlSerial == "Y"){
                                                if item.imei == "\(String(describing: code))" {
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
                                self.showDialogOutOfStock(imei: code)
                            }
                        }else{
                            self.showDialogOutOfStock(imei: "")
                        }
                    }
                }else{
                    if (itemCart.product.id == 2 || itemCart.product.id == 3){
                        //self.itemCart.imei = code
                        self.itemCart.Warr_imei = code
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
            if(code != "SELECT_VOUCHER_KHONG_GIA"){
                //
                var docType:String = "01"
                switch self.orderType {
                case 1:
                    docType = "01"
                case 2:
                    docType = "02"
                case 3:
                    docType = "05"
                default:
                    docType = "01"
                }
                
                let newViewController = LoadingViewController()
                newViewController.content = "Đang kiểm tra thông tin..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                MPOSAPIManager.mpos_FRT_SP_check_VC_crm(voucher:"\(code)",sdt:"\(self.tfPhoneNumber.text!)",doctype:"\(docType)") { (p_status,p_message,err) in
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
                                let alertController = UIAlertController(title: "Thông báo", message: "Bạn có muốn sử dụng voucher này ?", preferredStyle: .alert)
                                
                                let confirmAction = UIAlertAction(title: "Có", style: .default) { (_) in
                                    let newViewController = CheckVoucherOTPViewController()
                                    newViewController.delegate = self
                                    newViewController.phone = self.tfPhoneNumber.text!
                                    newViewController.doctype = docType
                                    newViewController.voucher = code
                                    
                                    let navController = UINavigationController(rootViewController: newViewController)
                                    self.navigationController?.present(navController, animated:false, completion: nil)
                                }
                                let rejectConfirm =  UIAlertAction(title: "Không", style: .cancel) { (_) in
                                    
                                }
                                alertController.addAction(rejectConfirm)
                                alertController.addAction(confirmAction)
                                
                                
                                self.present(alertController, animated: true, completion: nil)
                            }
                            if(p_status == 0){//0
                                
                                let voucherObject = VoucherNoPrice(VC_Code: code, VC_Name: "", Endate: "", U_OTPcheck: "", STT: 0, isSelected: true)
                                Cache.listVoucherNoPrice.append(voucherObject)
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
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let phone = textField.text!
        if phone.count > 9 {
            if phone.hasPrefix("01") {
                if phone.count>10{
                    Cache.phone = phone
                    Cache.codePayment = 0
                    
                    MPOSAPIManager.searchCustomersToshiba(phoneNumber: "\(phone)", handler: { (results, err) in
                        if(results.count > 0){
                            let customer = results[0]
                            Cache.name = customer.name
                            Cache.code = customer.code
                            Cache.address = customer.address
                            Cache.email = customer.email
                            Cache.codePayment = customer.code
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
                    
                    Cache.listVoucherNoPrice = []
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
                Cache.codePayment = 0
                Cache.listVoucherNoPrice = []
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
                        Cache.codePayment = customer.code
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
                        self.loadListVCNoPrice(phonenumber: phone)
                    }else{
                        self.loadListVCNoPrice(phonenumber: phone)
                        self.tableViewVoucherNoPrice.reloadData()
                        self.autoSizeView()
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
            Cache.listVoucherNoPrice = []
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
        Cache.listVoucherNoPrice = []
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
            
            if(Cache.listVoucherNoPrice.count > 0){
                self.checkVoucherKMBookSim()
            }else{
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng chọn số thuê bao!!!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    
                })
                self.present(alert, animated: true)
                
                return
            }
            
            
        } else {
            self.actionPay()
        }
    }
    
    
    func actionPay() {
        
        
        Cache.voucher = ""
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
        if name.count > 0 {
            
        }else{
            self.showDialog(text: "Tên không được để trống!")
            return
        }
        // check user name
        let address = tfUserAddress.text!
        if address.count > 0 {
            
        }else{
            //self.showDialog(text: "Địa chỉ không được để trống!")
            self.showDialog(text: "Địa chỉ không được để trống!")
            return
        }
        if orderType != -1 {
            if (orderType == 2){
                if (orderPayInstallment == -1){
                    
                    self.showDialog(text: "Bạn phải chọn loại chương trình trả góp!")
                    return
                }
            }
        }else{
            
            self.showDialog(text: "Bạn phải chọn loại đơn hàng!")
            return
        }
        
        if orderPayType != -1 {
            
        }else{
            
            self.showDialog(text: "Bạn phải chọn loại thanh toán!")
            return
        }
        var voucher = ""
        if(Cache.listVoucherNoPrice.count > 0){
            voucher = "<line>"
            for item in Cache.listVoucherNoPrice{
                if(item.isSelected == true){
                    voucher  = voucher + "<item voucher=\"\(item.VC_Code)\" />"
                }
                
            }
            voucher = voucher + "</line>"
        }
        Cache.voucher = voucher
        
        let email = tfUserEmail.text!
        let note = taskNotes.text!
        
        let birthday = self.tfUserBirthday.text!
        if (birthday.count > 0){
            if(birthday.count == 10){
                if (!checkDate(stringDate: birthday)){
                    
                    self.showDialog(text: "Ngày sinh sai định dạng!")
                    return
                }else{
                    let listDate = birthday.components(separatedBy: "/")
                    if (listDate.count == 3){
                        let yearText = listDate[2]
                        let date = Date()
                        let calendar = Calendar.current
                        let year = calendar.component(.year, from: date)
                        let yearInt = Int(yearText)
                        if (year < yearInt!){
                            
                            self.showDialog(text: "Năm sinh không được lớn hơn năm hiện tại")
                            return
                        }
                    }
                }
            }else{
                
                self.showDialog(text: "Ngày sinh sai định dạng!")
                return
            }
        }
        
        var prepay = tfPrepay.text!
        var interestRate = tfInterestRate.text!
        
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
                if (item.product.qlSerial == "Y"){
                    if (item.imei == "N/A" || item.imei == "") {
                        
                        self.showDialog(text: "\(item.product.name) chưa chọn IMEI.")
                        return
                    }
                }
                if((item.product.id == 3)){
                    if (item.Warr_imei == "N/A" || item.Warr_imei == "") {
                        
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
                        
                        MPOSAPIManager.checkPromotionNew(u_CrdCod: "0", sdt: "\(phone)", LoaiDonHang: docType, LoaiTraGop: "\(orderPayInstallment)", LaiSuat: floatValue1, SoTienTraTruoc: floatValue2,voucher:voucher, kyhan: "0", U_cardcode: "0", HDNum: "",is_KHRotTG: self.isTG,is_DH_DuAn: self.is_DH_DuAn) { [weak self](promotion, err) in
                            guard let self = self else {return}
                            
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
                                
                                
                                let carts = Cache.carts
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
                                                Cache.addressTemp = address
                                                Cache.emailTemp = email
                                                Cache.birthdayTemp = birthday
                                                Cache.genderTemp = self.genderType
                                                Cache.noteTemp = note
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
                                                newViewController.indexCart = self.indexCart
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
                                                newViewController.address = address
                                                newViewController.email = email
                                                newViewController.birthday = birthday
                                                newViewController.gender = self.genderType
                                                newViewController.type = docType
                                                newViewController.note = note
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
                                            Cache.addressTemp = address
                                            Cache.emailTemp = email
                                            Cache.birthdayTemp = birthday
                                            Cache.genderTemp = self.genderType
                                            Cache.noteTemp = note
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
                                            newViewController.indexCart = self.indexCart
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
                                            newViewController.address = address
                                            newViewController.email = email
                                            newViewController.birthday = birthday
                                            newViewController.gender = self.genderType
                                            newViewController.type = docType
                                            newViewController.note = note
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
                
                MPOSAPIManager.checkPromotionNew(u_CrdCod: "0", sdt: "\(phone)", LoaiDonHang: docType, LoaiTraGop: "\(orderPayInstallment)", LaiSuat: self.debitCustomer.Interestrate, SoTienTraTruoc: self.debitCustomer.DownPaymentAmount,voucher:voucher, kyhan: "\(self.debitCustomer.TenureOfLoan)", U_cardcode: self.debitCustomer.MaCty, HDNum: self.debitCustomer.ContractNo_AgreementNo,is_KHRotTG: self.isTG,is_DH_DuAn: self.is_DH_DuAn) { [weak self](promotion, err) in
                    guard let self = self else{return}
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
                        
                        let carts = Cache.carts
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
                                        Cache.addressTemp = address
                                        Cache.emailTemp = email
                                        Cache.birthdayTemp = birthday
                                        Cache.genderTemp = self.genderType
                                        Cache.noteTemp = note
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
                                        newViewController.indexCart = self.indexCart
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
                                        newViewController.address = address
                                        newViewController.email = email
                                        newViewController.birthday = birthday
                                        newViewController.gender = self.genderType
                                        newViewController.type = docType
                                        newViewController.note = note
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
                                    Cache.addressTemp = address
                                    Cache.emailTemp = email
                                    Cache.birthdayTemp = birthday
                                    Cache.genderTemp = self.genderType
                                    Cache.noteTemp = note
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
                                    newViewController.indexCart = self.indexCart
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
                                    newViewController.address = address
                                    newViewController.email = email
                                    newViewController.birthday = birthday
                                    newViewController.gender = self.genderType
                                    newViewController.type = docType
                                    newViewController.note = note
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
                MPOSAPIManager.checkPromotionNew(u_CrdCod: "0", sdt: "\(phone)", LoaiDonHang: docType, LoaiTraGop: "\(orderPayInstallment)", LaiSuat: Float(interestRate)!, SoTienTraTruoc: Float(prepay)!, voucher: voucher, kyhan: "0", U_cardcode: "0", HDNum: "",is_KHRotTG: self.isTG,is_DH_DuAn: self.is_DH_DuAn) { [weak self](promotion, err) in
                    guard let self = self else {return}
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
                        
                        
                        let carts = Cache.carts
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
                                        Cache.addressTemp = address
                                        Cache.emailTemp = email
                                        Cache.emailTemp = email
                                        Cache.birthdayTemp = birthday
                                        Cache.genderTemp = self.genderType
                                        Cache.noteTemp = note
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
                                        newViewController.indexCart = self.indexCart
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
                                        newViewController.address = address
                                        newViewController.email = email
                                        newViewController.birthday = birthday
                                        newViewController.gender = self.genderType
                                        newViewController.type = docType
                                        newViewController.note = note
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
                                    Cache.cartsTemp = Cache.carts
                                    Cache.phoneTemp = phone
                                    Cache.nameTemp = name
                                    Cache.addressTemp = address
                                    Cache.emailTemp = email
                                    Cache.birthdayTemp = birthday
                                    Cache.genderTemp = self.genderType
                                    Cache.noteTemp = note
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
                                    newViewController.indexCart = self.indexCart
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
                                    newViewController.address = address
                                    newViewController.email = email
                                    newViewController.birthday = birthday
                                    newViewController.gender = self.genderType
                                    newViewController.type = docType
                                    newViewController.note = note
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
                MPOSAPIManager.checkPromotionNew(u_CrdCod: "0", sdt: "\(phone)", LoaiDonHang: docType, LoaiTraGop: "\(orderPayInstallment)", LaiSuat: Float(interestRate)!, SoTienTraTruoc: Float(prepay)!, voucher: voucher, kyhan: "0", U_cardcode: "0", HDNum: "",is_KHRotTG: self.isTG,is_DH_DuAn: self.is_DH_DuAn) {[weak self] (promotion, err) in
                    guard let self = self else {return}
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
                                let newViewController = PromotionViewController()
                                Cache.cartsTemp = Cache.carts
                                Cache.phoneTemp = phone
                                Cache.nameTemp = name
                                Cache.addressTemp = address
                                Cache.emailTemp = email
                                Cache.birthdayTemp = birthday
                                Cache.genderTemp = self.genderType
                                Cache.noteTemp = note
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
                                newViewController.indexCart = self.indexCart
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
                                newViewController.address = address
                                newViewController.email = email
                                newViewController.birthday = birthday
                                newViewController.gender = self.genderType
                                newViewController.type = docType
                                newViewController.note = note
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
        if(Cache.listVoucherNoPrice.count > 0){
            xmlvoucher = "<line>"
            for item in Cache.listVoucherNoPrice{
                if(item.isSelected == true){
                    xmlvoucher  = xmlvoucher + "<item voucher=\"\(item.VC_Code)\" />"
                }
                
            }
            xmlvoucher = xmlvoucher + "</line>"
        }
        
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra voucher..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.checkVoucherKMBookSim(sdt: self.tfPhoneNumber.text!, xmlvoucher: xmlvoucher.toBase64()) {[weak self] (results, err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(results?.p_status == "Y"){
                        self.actionPay()
                    }else{
                        
                        self.showPopUp("Vui lòng chọn số thuê bao!!!", "Thông báo", buttonTitle: "Đồng ý")
                        
                        return
                    }
                    
                }else{
                    
                    self.showPopUp(err, "Thông báo", buttonTitle: "Đồng ý")
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
            
            rs = rs + "<item U_ItmCod=\"\(item.product.sku)\" U_Imei=\"\(item.imei)\" U_Quantity=\"\(item.quantity)\"  U_Price=\"\(String(format: "%.6f", item.product.price))\" U_WhsCod=\"\(Cache.user!.ShopCode)010\" U_ItmName=\"\(name)\" Warr_imei=\"\(item.Warr_imei)\"/>"
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
    func updateTotal() ->String{
        var sum: Float = 0
        for item in Cache.carts {
            if item.product.itemCodeGoiBH != "" {
                
            }else{
                sum = sum + Float(item.quantity) * item.product.price
            }
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
        radioButton.addTarget(self, action: #selector(PaymentViewController.logSelectedButton), for: UIControl.Event.touchUpInside);
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
        radioButton.addTarget(self, action: #selector(PaymentViewController.logSelectedButtonPayType), for: UIControl.Event.touchUpInside);
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
        radioButton.addTarget(self, action: #selector(PaymentViewController.logSelectedButtonGender), for: UIControl.Event.touchUpInside);
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
                Cache.typeOrder1 = "01"
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
                Cache.typeOrder1 = "02"
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
                Cache.typeOrder1 = "05"
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
        radioButton.addTarget(self, action: #selector(PaymentViewController.logSelectedButtonPayInstallment), for: UIControl.Event.touchUpInside);
        
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
        radioButton.addTarget(self, action: #selector(PaymentViewController.logSelectedButtonPayTGSS), for: UIControl.Event.touchUpInside);
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
        radioButton.addTarget(self, action: #selector(PaymentViewController.logSelectedButtonPayTG), for: UIControl.Event.touchUpInside);
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
        radioButton.addTarget(self, action: #selector(PaymentViewController.logSelectedButtonDHDuAn), for: UIControl.Event.touchUpInside);
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
    func loadListVCNoPrice(phonenumber:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_FRT_SP_VC_get_list_voucher_by_phone(phonenumber:"\(phonenumber)") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    
                    Cache.listVoucherNoPrice = results
                    self.tableViewVoucherNoPrice.reloadData()
                    self.autoSizeView()
                    
                }else{
                    //                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    //
                    //                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    //
                    //                    })
                    //                    self.present(alert, animated: true)
                }
            }
        }
    }
}

extension PaymentViewController:UITableViewDataSource,UITableViewDelegate,ItemVoucherNoPriceTableViewCellDelegate{
    func autoSizeView(){
        
        self.tableViewVoucherNoPrice.layoutIfNeeded()
        self.tableViewVoucherNoPrice.frame.size.height = self.tableViewVoucherNoPrice.contentSize.height + Common.Size(s: 10)
        self.lbAddVoucherMore.frame.origin.y = self.tableViewVoucherNoPrice.frame.size.height + self.tableViewVoucherNoPrice.frame.origin.y + Common.Size(s: 15)
        self.viewVoucher.frame.size.height =  self.lbAddVoucherMore.frame.size.height + self.lbAddVoucherMore.frame.origin.y
        self.viewFull.frame.origin.y = self.viewVoucher.frame.origin.y  + self.viewVoucher.frame.size.height + Common.Size(s:20)
        self.viewInfoDetail.frame.size.height = self.viewFull.frame.origin.y + self.viewFull.frame.size.height
        self.viewBelowToshibaPoint.frame.size.height = self.viewInfoDetail.frame.size.height + self.viewInfoDetail.frame.origin.y + Common.Size(s: 5)
        self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.viewBelowToshibaPoint.frame.origin.y + self.viewBelowToshibaPoint.frame.size.height + Common.Size(s: 100) + UIApplication.shared.statusBarFrame.height)
        
        
    }
    func tabReloadViewRemoveVoucher(indexNum: Int) {
        guard indexNum < Cache.listVoucherNoPrice.count else { return }
        Cache.listVoucherNoPrice.remove(at: indexNum)
        self.tableViewVoucherNoPrice.reloadData()
        self.autoSizeView()
    }
    
    func tabClickView(voucher: VoucherNoPrice) {
        var docType:String = "01"
        switch self.orderType {
        case 1:
            docType = "01"
        case 2:
            docType = "02"
        case 3:
            docType = "05"
        default:
            docType = "01"
        }
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_FRT_SP_check_VC_crm(voucher:"\(voucher.VC_Code)",sdt:"\(self.tfPhoneNumber.text!)",doctype:"\(docType)") { [weak self] (p_status,p_message,err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(p_status == 2){
                        self.showPopUp(p_message, "Thông báo", buttonTitle: "Đồng ý")
                        return
                    }
                    if(p_status == 1){//1
                        let alertController = UIAlertController(title: "Thông báo", message: "Bạn có muốn sử dụng voucher này ?", preferredStyle: .alert)
                        
                        let confirmAction = UIAlertAction(title: "Có", style: .default) { (_) in
                            let newViewController = CheckVoucherOTPViewController()
                            newViewController.delegate = self
                            newViewController.phone = self.tfPhoneNumber.text!
                            newViewController.doctype = docType
                            newViewController.voucher = voucher.VC_Code
                            
                            let navController = UINavigationController(rootViewController: newViewController)
                            self.navigationController?.present(navController, animated:false, completion: nil)
                        }
                        let rejectConfirm =  UIAlertAction(title: "Không", style: .cancel) { (_) in
                            
                        }
                        alertController.addAction(rejectConfirm)
                        alertController.addAction(confirmAction)
                        
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                    if(p_status == 0){//0
                        
                        for item in Cache.listVoucherNoPrice{
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
        return Cache.listVoucherNoPrice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ItemVoucherNoPriceTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemVoucherNoPriceTableViewCell")
        let item:VoucherNoPrice = Cache.listVoucherNoPrice[indexPath.row]
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
protocol ItemVoucherNoPriceTableViewCellDelegate {
    
    func tabClickView(voucher:VoucherNoPrice)
    func tabReloadViewRemoveVoucher(indexNum:Int)
}
class ItemVoucherNoPriceTableViewCell: UITableViewCell {
    var radioCheck:DLRadioButton!
    var imgDelete:UIImageView!
    var lblIndex:UILabel!
    var estimateCellHeight: CGFloat = 0
    var delegate: ItemVoucherNoPriceTableViewCellDelegate?
    var indexNum:Int = 0
    var lblNameVoucher:UILabel!
    var lblDateVoucher:UILabel!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        
        lblIndex = UILabel()
        lblIndex.textColor = UIColor.black
        lblIndex.numberOfLines = 0
        lblIndex.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(lblIndex)
        
        radioCheck = DLRadioButton()
        radioCheck.titleLabel!.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        
        radioCheck.setTitleColor(UIColor.black, for: UIControl.State());
        radioCheck.iconColor = UIColor.black;
        radioCheck.isIconSquare = true
        radioCheck.indicatorColor = UIColor.black;
        radioCheck.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        contentView.addSubview(radioCheck)
        radioCheck.addTarget(self, action: #selector(ItemVoucherNoPriceTableViewCell.logSelectedButtonGender), for: UIControl.Event.touchUpInside);
        
        imgDelete = UIImageView()
        imgDelete.image = #imageLiteral(resourceName: "delete_red")
        imgDelete.contentMode = UIView.ContentMode.scaleAspectFit
        contentView.addSubview(imgDelete)
        
        
        lblNameVoucher = UILabel()
        lblNameVoucher.textColor = UIColor.black
        lblNameVoucher.numberOfLines = 0
        lblNameVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(lblNameVoucher)
        
        lblDateVoucher = UILabel()
        lblDateVoucher.textColor = UIColor.gray
        lblDateVoucher.numberOfLines = 0
        lblDateVoucher.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(lblDateVoucher)
        
        
        
        
    }
    var so1:VoucherNoPrice?
    func setup(so:VoucherNoPrice,indexNum:Int,readOnly:Bool){
        so1 = so
        self.indexNum = indexNum
        lblIndex.frame = CGRect(x: 0,y: Common.Size(s:10) , width: Common.Size(s: 20), height: Common.Size(s:15))
        lblIndex.text = "\(indexNum + 1)."
        
        radioCheck.frame = CGRect(x:lblIndex.frame.size.width + lblIndex.frame.origin.x + Common.Size(s:10),y: Common.Size(s:10) , width: Common.Size(s: 200), height: Common.Size(s:15))
        radioCheck.setTitle(so.VC_Code, for: UIControl.State())
        
        if(so.isSelected == true){
            radioCheck.isSelected = true
        }else{
            radioCheck.isSelected = false
        }
        
        imgDelete.frame = CGRect(x: radioCheck.frame.size.width + radioCheck.frame.origin.x ,y: Common.Size(s:10) , width: Common.Size(s: 20), height: Common.Size(s:15))
        let tapClick = UITapGestureRecognizer(target: self, action: #selector(ItemVoucherNoPriceTableViewCell.tabRemoveVoucher))
        imgDelete.isUserInteractionEnabled = true
        imgDelete.addGestureRecognizer(tapClick)
        
        
        lblNameVoucher.frame = CGRect(x:radioCheck.frame.origin.x,y: radioCheck.frame.size.height + radioCheck.frame.origin.y + Common.Size(s:10) , width: Common.Size(s: 200), height: Common.Size(s:15))
        lblNameVoucher.text = "\(so.VC_Name)"
        
        let lblNameVoucherValueHeight:CGFloat = lblNameVoucher.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lblNameVoucher.optimalHeight
        
        lblNameVoucher.frame = CGRect(x: lblNameVoucher.frame.origin.x, y: lblNameVoucher.frame.origin.y, width: lblNameVoucher.frame.width, height: lblNameVoucherValueHeight)
        if(so.VC_Name == ""){
            lblNameVoucher.frame.size.height = 0
        }
        
        lblDateVoucher.frame = CGRect(x:radioCheck.frame.origin.x,y: lblNameVoucher.frame.size.height + lblNameVoucher.frame.origin.y + Common.Size(s:10) , width: Common.Size(s: 200), height: Common.Size(s:15))
        lblDateVoucher.text = "\(so.Endate)"
        if(so.Endate == ""){
            lblDateVoucher.frame.size.height = 0
        }
        
        if(readOnly == true){
            imgDelete.isUserInteractionEnabled = false
            radioCheck.isUserInteractionEnabled = false
        }
        self.estimateCellHeight = lblDateVoucher.frame.origin.y + lblDateVoucher.frame.height + Common.Size(s: 15)
        
    }
    @objc func tabRemoveVoucher(){
        delegate?.tabReloadViewRemoveVoucher(indexNum: self.indexNum)
    }
    
    @objc @IBAction fileprivate func logSelectedButtonGender(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            radioCheck.isSelected = false
            if(so1!.isSelected == true){
                
                so1!.isSelected = false
                
                
            }else{
                delegate?.tabClickView(voucher:so1!)
            }
            
            
            
        }
    }
    
}
