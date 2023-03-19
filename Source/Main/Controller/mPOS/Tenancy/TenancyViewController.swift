//
//  TenancyViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 6/10/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
//import DLRadioButton
import CoreLocation
import ActionSheetPicker_3_0
import Toaster
class TenancyViewController:UIViewController,UITextFieldDelegate,CLLocationManagerDelegate,PriceOfMonthViewControllerDelegate{

    
    var imagePicker = UIImagePickerController()
    var scrollView:UIScrollView!
    var posImageUpload:Int = 0
    //--
    var homeInfoView:UIView!
    var tfNameHome: UITextField!
    var tfTaxHome: UITextField!
    var tfPhoneHome: UITextField!
    //--
    var paymentInfoView:UIView!
    var tfNamePayment: UITextField!
    var tfAccountPayment: UITextField!
    var tfBanks: SearchTextField!
    //--
    var shopInfoView:UIView!
    
//    var radioFPTShop:DLRadioButton!
//    var radioLongChau:DLRadioButton!
    var tfShops: SearchTextField!
    var tfShopAddress: UITextField!
    var tfProvince: SearchTextField!
    var tfDistrict: SearchTextField!
//    var tfShopGPS: UITextField!
    //--
    
    var contractInfoView: UIView!
    var tfContractType: SearchTextField!
     var tfContractNumber: UITextField!
    var tfDateReceivingPremises: UITextField!
    var tfDateBeginPay:UITextField!
    var tfDateEndPay:UITextField!
    var tfLimit:UITextField!
    var tfDeposit:UITextField!
    var tfDepositUnit: SearchTextField!
    var tfWithdrawal:UITextField!
    var tfPaymentPeriod: SearchTextField!
    var tfDatePay:UITextField!
    var tfAcreage:UITextField!
//    var tfTax: SearchTextField!
    var tfContractStartDate:UITextField!
    var tfBeginDatePay:UITextField!
    var tfChooseTax: SearchTextField!
//    var tfPhongBanShopText: SearchTextField!
    var tfChiNhanhBankText: UITextField!
    
//    var radioTaxMB:DLRadioButton!
//    var radioTaxTNCN:DLRadioButton!
//    var radioTaxGTGT5:DLRadioButton!
//    var radioTaxGTGT10:DLRadioButton!
    //--IMAGES
    var viewFacade:UIView!
    var imgViewFacade: UIImageView!
    var viewImages:UIView!
    
    var viewImage1:UIView!
    var imgViewImage1: UIImageView!
    
    var viewImage2:UIView!
    var imgViewImage2: UIImageView!
    
    var viewImage3:UIView!
    var imgViewImage3: UIImageView!
    
    var viewImage4:UIView!
    var imgViewImage4: UIImageView!
    
    var viewImage5:UIView!
    var imgViewImage5: UIImageView!
    
    var viewImage6:UIView!
    var imgViewImage6: UIImageView!
    
    var viewImage7:UIView!
    var imgViewImage7: UIImageView!
    
    var viewImage8:UIView!
    var imgViewImage8: UIImageView!
    
    var viewImage9:UIView!
    var imgViewImage9: UIImageView!
    
    var viewImage10:UIView!
    var imgViewImage10: UIImageView!
    
    var lbMoreImages:UILabel!
    var btPay:UIButton!
    var viewFooter:UIView!
    var isShowAllImages: Bool = false
    
    //----
    var listBanks: [RequestPaymentBank] = []
    var idBank:Int = 0
    //--
    var listShops: [RequestPaymentShop] = []
    var idShop:String = ""
    //--
    var listProvinces: [RequestPaymentProvince] = []
    var idProvince:Int = 0
    //--
    var listDistricts: [RequestPaymentDistrict] = []
    var idDistrict:Int = 0
    //--
    var listContractType: [RequestPaymentContractType] = []
    var idContractType:Int = 0
    //--
    var listContractUnit: [RequestPaymentUnit] = []
    var idUnit:String = ""
    //--
    var listPeriods: [RequestPaymentPeriod] = []
    var idPeriod:Int = 0
    //--
    var priceItems: [RequestPaymentTimePrice] = []
    
    //---
    var imgUploadMT: UIImage!
    var imgUpload1: UIImage!
    var imgUpload2: UIImage!
    var imgUpload3: UIImage!
    var imgUpload4: UIImage!
    var imgUpload5: UIImage!
    var imgUpload6: UIImage!
    var imgUpload7: UIImage!
    var imgUpload8: UIImage!
    var imgUpload9: UIImage!
    var imgUpload10: UIImage!
    var listImgUpload: [UIImage] = []
    var listTax = [TaxHDThueNha]()
    var listPhongBan = [RequestPaymentShop]()
    var selectedPhongban:RequestPaymentShop?
    var selectedTax: TaxHDThueNha?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "HĐ thuê nhà"
        isShowAllImages = false
        navigationController?.navigationBar.isTranslucent = false
        self.initView()
        initData()
    }
    func initData(){
        let nc = NotificationCenter.default
        let newViewController = LoadingViewController()
        newViewController.content = "Đang tải thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        MPOSAPIManager.sp_FRT_Web_BrowserPaymentRequest_GetBank { (results, err) in
            if(err.count <= 0){
                self.listBanks = results
                //----BANK
                self.tfBanks.itemSelectionHandler = { filteredResults, itemPosition in
                    let item = filteredResults[itemPosition]
                    self.tfBanks.text = item.title
                    let obj =  self.listBanks.filter{ $0.label == "\(item.title)" }.first
                    if let code = obj?.value {
                        self.idBank =  code
                    }
                }
                var listBanksString: [String] = []
                for item in self.listBanks {
                    listBanksString.append("\(item.label)")
                }
                self.tfBanks.filterStrings(listBanksString)
                //----BANK
                self.getDataShops(isChoose: false,type:3)
//                self.getPhongBan()
                self.getDataTax()
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
    func getDataShops(isChoose: Bool,type:Int){
        let nc = NotificationCenter.default
        MPOSAPIManager.sp_FRTCallLog_Web_BrowserPaymentRequest_GetWarehouseByType(Type: type) { (results, err) in
            if(err.count <= 0){
                self.listShops = results
                if(!isChoose){
                    //----SHOPS
                    self.tfShops.itemSelectionHandler = { filteredResults, itemPosition in
                        let item = filteredResults[itemPosition]
                        self.tfShops.text = item.title
                        let obj =  self.listShops.filter{ $0.label == "\(item.title)" }.first
                        if let code = obj?.value {
                            self.idShop =  code
                        }
                    }
                    var listShopsString: [String] = []
                    for item in self.listShops {
                        listShopsString.append("\(item.label)")
                    }
                    self.tfShops.filterStrings(listShopsString)
                    self.getDataProvince()
                }else{
                    self.tfShops.text = ""
                    self.idShop =  ""
                    self.tfShops.itemSelectionHandler = { filteredResults, itemPosition in
                        let item = filteredResults[itemPosition]
                        self.tfShops.text = item.title
                        let obj =  self.listShops.filter{ $0.label == "\(item.title)" }.first
                        if let code = obj?.value {
                            self.idShop =  code
                        }
                    }
                    var listShopsString: [String] = []
                    for item in self.listShops {
                        listShopsString.append("\(item.label)")
                    }
                    self.tfShops.filterStrings(listShopsString)
                }
            }else{
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let errorAlert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(errorAlert, animated: true, completion: nil)
                }
            }
        }
    }
    func getDataTax() {
        MPOSAPIManager.sp_FRT_Web_BrowserPaymentRequest_GetThue { (rs, err) in
            if(err.count <= 0){
                self.tfChooseTax.itemSelectionHandler = { filteredResults, itemPosition in
                    let item = filteredResults[itemPosition]
                    self.tfChooseTax.text = item.title
                    self.selectedTax = rs.filter{ $0.label == "\(item.title)" }.first
                }
                var listTaxString: [String] = []
                for item in rs {
                    listTaxString.append("\(item.label)")
                }
                self.tfChooseTax.filterStrings(listTaxString)
            } else {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    NotificationCenter.default.post(name: Notification.Name("dismissLoading"), object: nil)
                    let errorAlert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(errorAlert, animated: true, completion: nil)
                }
            }
        }
    }
    func getDataProvince(){
        MPOSAPIManager.sp_FRT_Web_BrowserPaymentRequest_GetTinhThanh { (results, err) in
            if(err.count <= 0){
                self.listProvinces = results
                self.tfProvince.text = ""
                self.idProvince =  0
                self.tfDistrict.text = ""
                self.idDistrict =  0
                self.tfProvince.itemSelectionHandler = { filteredResults, itemPosition in
                    let item = filteredResults[itemPosition]
                    self.tfProvince.text = item.title
                    let obj =  self.listProvinces.filter{ $0.label == "\(item.title)" }.first
                    if let code = obj?.value {
                        self.tfDistrict.text = ""
                        self.idDistrict =  0
                        self.idProvince =  code
                        self.getDataDistrict(idProvince:  self.idProvince)
                    }
                }
                var listProvinceString: [String] = []
                for item in self.listProvinces {
                    listProvinceString.append("\(item.label)")
                }
                self.tfProvince.filterStrings(listProvinceString)
                //---
                self.getDataContractType()
            }else{
                let nc = NotificationCenter.default
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
    func getDataDistrict(idProvince:Int){
        MPOSAPIManager.sp_FRT_Web_BrowserPaymentRequest_GetQuanHuyen(IDCity: idProvince) { (results, err) in
            if(err.count <= 0){
                self.listDistricts = results
                self.tfDistrict.text = ""
                self.idDistrict =  0
                self.tfDistrict.itemSelectionHandler = { filteredResults, itemPosition in
                    let item = filteredResults[itemPosition]
                    self.tfDistrict.text = item.title
                    let obj =  self.listDistricts.filter{ $0.label == "\(item.title)" }.first
                    if let code = obj?.value {
                        self.idDistrict =  code
                    }
                }
                var listDictrictString: [String] = []
                for item in self.listDistricts {
                    listDictrictString.append("\(item.label)")
                }
                self.tfDistrict.filterStrings(listDictrictString)
                
            }else{
                let nc = NotificationCenter.default
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
    func getDataContractType(){
        MPOSAPIManager.sp_FRT_Web_BrowserPaymentRequest_GetLoaiKyHD { (results, err) in
            if(err.count <= 0){
                self.listContractType = results
                self.tfContractType.text = ""
                self.idContractType =  0
                self.tfContractType.itemSelectionHandler = { filteredResults, itemPosition in
                    let item = filteredResults[itemPosition]
                    self.tfContractType.text = item.title
                    let obj =  self.listContractType.filter{ $0.label == "\(item.title)" }.first
                    if let code = obj?.value {
                        self.idContractType =  code
                    }
                }
                var listContractTypeString: [String] = []
                for item in self.listContractType {
                    listContractTypeString.append("\(item.label)")
                }
                self.tfContractType.filterStrings(listContractTypeString)
                self.getDataUnit()
            }else{
                let nc = NotificationCenter.default
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
    func getDataUnit(){
        MPOSAPIManager.sp_FRT_Web_BrowserPaymentRequest_GetDonVi { (results, err) in
            if(err.count <= 0){
                self.listContractUnit = results
                self.tfDepositUnit.text = ""
                self.idUnit =  ""
                self.tfDepositUnit.itemSelectionHandler = { filteredResults, itemPosition in
                    let item = filteredResults[itemPosition]
                    self.tfDepositUnit.text = item.title
                    let obj =  self.listContractUnit.filter{ $0.label == "\(item.title)" }.first
                    if let code = obj?.value {
                        self.idUnit =  code
                    }
                }
                var listContractUnitString: [String] = []
                var count:Int = 0
                for item in self.listContractUnit {
                    listContractUnitString.append("\(item.label)")
                    if(count == 0){
                        self.tfDepositUnit.text = "\(item.label)"
                        self.idUnit =  "\(item.value)"
                    }
                    count = count + 1
                }
                self.tfDepositUnit.filterStrings(listContractUnitString)
                self.getDataPeriod()
            }else{
                let nc = NotificationCenter.default
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
    func getDataPeriod(){
        MPOSAPIManager.sp_FRT_Web_BrowserPaymentRequest_GetKyHan { (results, err) in
            if(err.count <= 0){
                self.listPeriods = results
                self.tfPaymentPeriod.text = ""
                self.idPeriod =  0
                self.tfPaymentPeriod.itemSelectionHandler = { filteredResults, itemPosition in
                    let item = filteredResults[itemPosition]
                    self.tfPaymentPeriod.text = item.title
                    let obj =  self.listPeriods.filter{ $0.label == "\(item.title)" }.first
                    if let code = obj?.value {
                        self.idPeriod =  code
                    }
                }
                var listPeriodString: [String] = []
                for item in self.listPeriods {
                    listPeriodString.append("\(item.label)")
                }
                self.tfPaymentPeriod.filterStrings(listPeriodString)
                let nc = NotificationCenter.default
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                
                }
            }else{
                let nc = NotificationCenter.default
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
    @objc func viewHistory(){
        let newViewController = HistoryTenancyViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func initView(){
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(TenancyViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        let btViewHistory = UIButton.init(type: .custom)
        btViewHistory.setImage(#imageLiteral(resourceName: "LSCC"), for: UIControl.State.normal)
        btViewHistory.imageView?.contentMode = .scaleAspectFit
        btViewHistory.addTarget(self, action: #selector(TenancyViewController.viewHistory), for: UIControl.Event.touchUpInside)
        btViewHistory.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        let barViewHistory = UIBarButtonItem(customView: btViewHistory)
        self.navigationItem.rightBarButtonItem = barViewHistory
        
        self.view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView = UIScrollView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: scrollView.frame.size.height)
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "THÔNG TIN CHỦ NHÀ"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        homeInfoView = UIView()
        homeInfoView.frame = CGRect(x: 0, y:label1.frame.origin.y + label1.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        homeInfoView.backgroundColor = UIColor.white
        scrollView.addSubview(homeInfoView)
        
        let lbTextNameHome = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextNameHome.textAlignment = .left
        lbTextNameHome.textColor = UIColor.black
        lbTextNameHome.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextNameHome.text = "Tên chủ nhà (*)"
        homeInfoView.addSubview(lbTextNameHome)
        
        tfNameHome = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextNameHome.frame.origin.y + lbTextNameHome.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfNameHome.placeholder = "Nhập tên chủ nhà"
        tfNameHome.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfNameHome.borderStyle = UITextField.BorderStyle.roundedRect
        tfNameHome.autocorrectionType = UITextAutocorrectionType.no
        tfNameHome.keyboardType = UIKeyboardType.default
        tfNameHome.returnKeyType = UIReturnKeyType.done
        tfNameHome.clearButtonMode = UITextField.ViewMode.whileEditing
        tfNameHome.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfNameHome.delegate = self
        homeInfoView.addSubview(tfNameHome)
        
        let lbTextTaxHome = UILabel(frame: CGRect(x: lbTextNameHome.frame.origin.x, y: tfNameHome.frame.origin.y + tfNameHome.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextTaxHome.textAlignment = .left
        lbTextTaxHome.textColor = UIColor.black
        lbTextTaxHome.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTaxHome.text = "Mã số thuế chủ nhà"
        homeInfoView.addSubview(lbTextTaxHome)
        
        tfTaxHome = UITextField(frame: CGRect(x: lbTextTaxHome.frame.origin.x, y: lbTextTaxHome.frame.origin.y + lbTextTaxHome.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfTaxHome.placeholder = "Nhập số thuế"
        tfTaxHome.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTaxHome.borderStyle = UITextField.BorderStyle.roundedRect
        tfTaxHome.autocorrectionType = UITextAutocorrectionType.no
        tfTaxHome.keyboardType = UIKeyboardType.numberPad
        tfTaxHome.returnKeyType = UIReturnKeyType.done
        tfTaxHome.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTaxHome.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTaxHome.delegate = self
        homeInfoView.addSubview(tfTaxHome)
        
        let lbTextPhoneHome = UILabel(frame: CGRect(x: lbTextNameHome.frame.origin.x, y: tfTaxHome.frame.origin.y + tfTaxHome.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhoneHome.textAlignment = .left
        lbTextPhoneHome.textColor = UIColor.black
        lbTextPhoneHome.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhoneHome.text = "Số điện thoại (*)"
        homeInfoView.addSubview(lbTextPhoneHome)
        
        tfPhoneHome = UITextField(frame: CGRect(x: lbTextPhoneHome.frame.origin.x, y: lbTextPhoneHome.frame.origin.y + lbTextPhoneHome.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfPhoneHome.placeholder = "Nhập số điện thoại"
        tfPhoneHome.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhoneHome.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhoneHome.autocorrectionType = UITextAutocorrectionType.no
        tfPhoneHome.keyboardType = UIKeyboardType.numberPad
        tfPhoneHome.returnKeyType = UIReturnKeyType.done
        tfPhoneHome.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhoneHome.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhoneHome.delegate = self
        homeInfoView.addSubview(tfPhoneHome)
        homeInfoView.frame.size.height = tfPhoneHome.frame.size.height + tfPhoneHome.frame.origin.y + Common.Size(s: 10)
        
        let label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: homeInfoView.frame.origin.y + homeInfoView.frame.size.height, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label2.text = "THÔNG TIN THANH TOÁN TIỀN THUÊ NHÀ"
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label2)
        
        paymentInfoView = UIView()
        paymentInfoView.frame = CGRect(x: 0, y:label2.frame.origin.y + label2.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        paymentInfoView.backgroundColor = UIColor.white
        scrollView.addSubview(paymentInfoView)
        
        let lbTextNamePayment = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextNamePayment.textAlignment = .left
        lbTextNamePayment.textColor = UIColor.black
        lbTextNamePayment.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextNamePayment.text = "Chủ tài khoản (*)"
        paymentInfoView.addSubview(lbTextNamePayment)
        
        tfNamePayment = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextNamePayment.frame.origin.y + lbTextNamePayment.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfNamePayment.placeholder = "Nhập tên chủ tài khoản"
        tfNamePayment.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfNamePayment.borderStyle = UITextField.BorderStyle.roundedRect
        tfNamePayment.autocorrectionType = UITextAutocorrectionType.no
        tfNamePayment.keyboardType = UIKeyboardType.default
        tfNamePayment.returnKeyType = UIReturnKeyType.done
        tfNamePayment.clearButtonMode = UITextField.ViewMode.whileEditing
        tfNamePayment.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfNamePayment.delegate = self
        paymentInfoView.addSubview(tfNamePayment)
        
        let lbTextAccountPayment = UILabel(frame: CGRect(x: lbTextNameHome.frame.origin.x, y: tfNamePayment.frame.origin.y + tfNamePayment.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextAccountPayment.textAlignment = .left
        lbTextAccountPayment.textColor = UIColor.black
        lbTextAccountPayment.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextAccountPayment.text = "Số tài khoản (*)"
        paymentInfoView.addSubview(lbTextAccountPayment)
        
        tfAccountPayment = UITextField(frame: CGRect(x: lbTextAccountPayment.frame.origin.x, y: lbTextAccountPayment.frame.origin.y + lbTextAccountPayment.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfAccountPayment.placeholder = "Nhập số tài khoản"
        tfAccountPayment.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfAccountPayment.borderStyle = UITextField.BorderStyle.roundedRect
        tfAccountPayment.autocorrectionType = UITextAutocorrectionType.no
        tfAccountPayment.keyboardType = UIKeyboardType.default
        tfAccountPayment.returnKeyType = UIReturnKeyType.done
        tfAccountPayment.clearButtonMode = UITextField.ViewMode.whileEditing
        tfAccountPayment.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfAccountPayment.delegate = self
        paymentInfoView.addSubview(tfAccountPayment)
        
        
        let lbTextBank = UILabel(frame: CGRect(x: lbTextNameHome.frame.origin.x, y: tfAccountPayment.frame.origin.y + tfAccountPayment.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextBank.textAlignment = .left
        lbTextBank.textColor = UIColor.black
        lbTextBank.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextBank.text = "Ngân hàng (*)"
        paymentInfoView.addSubview(lbTextBank)
        
        tfBanks = SearchTextField(frame: CGRect(x: lbTextAccountPayment.frame.origin.x, y: lbTextBank.frame.origin.y + lbTextBank.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        
        tfBanks.placeholder = "Chọn ngân hàng"
        tfBanks.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfBanks.borderStyle = UITextField.BorderStyle.roundedRect
        tfBanks.autocorrectionType = UITextAutocorrectionType.no
        tfBanks.keyboardType = UIKeyboardType.default
        tfBanks.returnKeyType = UIReturnKeyType.done
        tfBanks.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfBanks.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfBanks.delegate = self
        
        tfBanks.startVisible = true
        tfBanks.theme.bgColor = UIColor.white
        tfBanks.theme.fontColor = UIColor.black
        tfBanks.theme.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfBanks.theme.cellHeight = Common.Size(s:40)
        tfBanks.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font: UIFont.systemFont(ofSize: Common.Size(s:14))]
        paymentInfoView.addSubview(tfBanks)
        
        let lbChiNhanhBank = UILabel(frame: CGRect(x: lbTextNameHome.frame.origin.x, y: tfBanks.frame.origin.y + tfBanks.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbChiNhanhBank.textAlignment = .left
        lbChiNhanhBank.textColor = UIColor.black
        lbChiNhanhBank.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbChiNhanhBank.text = "Chi nhánh"
        paymentInfoView.addSubview(lbChiNhanhBank)
        
        tfChiNhanhBankText = UITextField(frame: CGRect(x: lbTextAccountPayment.frame.origin.x, y: lbChiNhanhBank.frame.origin.y + lbChiNhanhBank.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfChiNhanhBankText.placeholder = "Nhập chi nhánh"
        tfChiNhanhBankText.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfChiNhanhBankText.borderStyle = UITextField.BorderStyle.roundedRect
        tfChiNhanhBankText.autocorrectionType = UITextAutocorrectionType.no
        tfChiNhanhBankText.keyboardType = UIKeyboardType.default
        tfChiNhanhBankText.returnKeyType = UIReturnKeyType.done
        tfChiNhanhBankText.clearButtonMode = UITextField.ViewMode.whileEditing
        tfChiNhanhBankText.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfChiNhanhBankText.delegate = self
        paymentInfoView.addSubview(tfChiNhanhBankText)
        
        paymentInfoView.frame.size.height = tfChiNhanhBankText.frame.size.height + tfChiNhanhBankText.frame.origin.y + Common.Size(s: 10)
        
        let label3 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: paymentInfoView.frame.origin.y + paymentInfoView.frame.size.height, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label3.text = "THÔNG TIN SHOP"
        label3.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label3)
        
        shopInfoView = UIView()
        shopInfoView.frame = CGRect(x: 0, y:label3.frame.origin.y + label3.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        shopInfoView.backgroundColor = UIColor.white
        scrollView.addSubview(shopInfoView)
        
        let lbTextShop = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextShop.textAlignment = .left
        lbTextShop.textColor = UIColor.black
        lbTextShop.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextShop.text = "Shop"
        shopInfoView.addSubview(lbTextShop)
        
        tfShops = SearchTextField(frame: CGRect(x: lbTextShop.frame.origin.x, y: lbTextShop.frame.origin.y + lbTextShop.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        
        tfShops.placeholder = "Chọn shop"
        tfShops.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfShops.borderStyle = UITextField.BorderStyle.roundedRect
        tfShops.autocorrectionType = UITextAutocorrectionType.no
        tfShops.keyboardType = UIKeyboardType.default
        tfShops.returnKeyType = UIReturnKeyType.done
        tfShops.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfShops.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfShops.delegate = self
        
        tfShops.startVisible = true
        tfShops.theme.bgColor = UIColor.white
        tfShops.theme.fontColor = UIColor.black
        tfShops.theme.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfShops.theme.cellHeight = Common.Size(s:40)
        tfShops.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.systemFont(ofSize: Common.Size(s:14))]
        shopInfoView.addSubview(tfShops)
        
        let lbTextShopAddress = UILabel(frame: CGRect(x: tfShops.frame.origin.x, y: tfShops.frame.origin.y + tfShops.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextShopAddress.textAlignment = .left
        lbTextShopAddress.textColor = UIColor.black
        lbTextShopAddress.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextShopAddress.text = "Địa chỉ shop/phòng ban (*)"
        shopInfoView.addSubview(lbTextShopAddress)
        
        tfShopAddress = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextShopAddress.frame.origin.y + lbTextShopAddress.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfShopAddress.placeholder = "Nhập địa chỉ"
        tfShopAddress.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfShopAddress.borderStyle = UITextField.BorderStyle.roundedRect
        tfShopAddress.autocorrectionType = UITextAutocorrectionType.no
        tfShopAddress.keyboardType = UIKeyboardType.default
        tfShopAddress.returnKeyType = UIReturnKeyType.done
        tfShopAddress.clearButtonMode = UITextField.ViewMode.whileEditing
        tfShopAddress.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfShopAddress.delegate = self
        shopInfoView.addSubview(tfShopAddress)
        
        let lbTextShopProvince = UILabel(frame: CGRect(x: tfShops.frame.origin.x, y: tfShopAddress.frame.origin.y + tfShopAddress.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextShopProvince.textAlignment = .left
        lbTextShopProvince.textColor = UIColor.black
        lbTextShopProvince.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextShopProvince.text = "Tỉnh/Thành phố (*)"
        shopInfoView.addSubview(lbTextShopProvince)
        
        tfProvince = SearchTextField(frame: CGRect(x: lbTextShop.frame.origin.x, y: lbTextShopProvince.frame.origin.y + lbTextShopProvince.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        
        tfProvince.placeholder = "Chọn Tỉnh/Thành phố"
        tfProvince.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfProvince.borderStyle = UITextField.BorderStyle.roundedRect
        tfProvince.autocorrectionType = UITextAutocorrectionType.no
        tfProvince.keyboardType = UIKeyboardType.default
        tfProvince.returnKeyType = UIReturnKeyType.done
        tfProvince.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfProvince.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfProvince.delegate = self
        
        tfProvince.startVisible = true
        tfProvince.theme.bgColor = UIColor.white
        tfProvince.theme.fontColor = UIColor.black
        tfProvince.theme.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfProvince.theme.cellHeight = Common.Size(s:40)
        tfProvince.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.systemFont(ofSize: Common.Size(s:14))]
        shopInfoView.addSubview(tfProvince)
        
        let lbTextShopDistrict = UILabel(frame: CGRect(x: tfShops.frame.origin.x, y: tfProvince.frame.origin.y + tfProvince.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextShopDistrict.textAlignment = .left
        lbTextShopDistrict.textColor = UIColor.black
        lbTextShopDistrict.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextShopDistrict.text = "Quận/Huyện (*)"
        shopInfoView.addSubview(lbTextShopDistrict)
        
        tfDistrict = SearchTextField(frame: CGRect(x: lbTextShop.frame.origin.x, y: lbTextShopDistrict.frame.origin.y + lbTextShopDistrict.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        
        tfDistrict.placeholder = "Chọn Quận/Huyện"
        tfDistrict.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDistrict.borderStyle = UITextField.BorderStyle.roundedRect
        tfDistrict.autocorrectionType = UITextAutocorrectionType.no
        tfDistrict.keyboardType = UIKeyboardType.default
        tfDistrict.returnKeyType = UIReturnKeyType.done
        tfDistrict.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfDistrict.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDistrict.delegate = self
        
        tfDistrict.startVisible = true
        tfDistrict.theme.bgColor = UIColor.white
        tfDistrict.theme.fontColor = UIColor.black
        tfDistrict.theme.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfDistrict.theme.cellHeight = Common.Size(s:40)
        tfDistrict.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.systemFont(ofSize: Common.Size(s:14))]
        shopInfoView.addSubview(tfDistrict)
        
        shopInfoView.frame.size.height = tfDistrict.frame.size.height + tfDistrict.frame.origin.y + Common.Size(s: 10)
        
        let label4 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: shopInfoView.frame.origin.y + shopInfoView.frame.size.height, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label4.text = "THÔNG TIN HỢP ĐỒNG"
        label4.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label4)
        
        contractInfoView = UIView()
        contractInfoView.frame = CGRect(x: 0, y:label4.frame.origin.y + label4.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        contractInfoView.backgroundColor = UIColor.white
        scrollView.addSubview(contractInfoView)
        
        let lbTextContractType = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextContractType.textAlignment = .left
        lbTextContractType.textColor = UIColor.black
        lbTextContractType.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextContractType.text = "Loại ký hợp đồng (*)"
        contractInfoView.addSubview(lbTextContractType)
        
        tfContractType = SearchTextField(frame: CGRect(x: lbTextContractType.frame.origin.x, y: lbTextContractType.frame.origin.y + lbTextContractType.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        
        tfContractType.placeholder = "Chọn loại HĐ"
        tfContractType.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfContractType.borderStyle = UITextField.BorderStyle.roundedRect
        tfContractType.autocorrectionType = UITextAutocorrectionType.no
        tfContractType.keyboardType = UIKeyboardType.default
        tfContractType.returnKeyType = UIReturnKeyType.done
        tfContractType.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfContractType.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfContractType.delegate = self
        
        tfContractType.startVisible = true
        tfContractType.theme.bgColor = UIColor.white
        tfContractType.theme.fontColor = UIColor.black
        tfContractType.theme.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfContractType.theme.cellHeight = Common.Size(s:40)
        tfContractType.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.systemFont(ofSize: Common.Size(s:14))]
        contractInfoView.addSubview(tfContractType)
        
        let lbTextContractNumber = UILabel(frame: CGRect(x: tfContractType.frame.origin.x , y: tfContractType.frame.origin.y + tfContractType.frame.size.height +  Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextContractNumber.textAlignment = .left
        lbTextContractNumber.textColor = UIColor.black
        lbTextContractNumber.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextContractNumber.text = "Số hợp đồng (*)"
        contractInfoView.addSubview(lbTextContractNumber)
        
        tfContractNumber = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextContractNumber.frame.origin.y + lbTextContractNumber.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfContractNumber.placeholder = "Nhập số HĐ"
        tfContractNumber.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfContractNumber.borderStyle = UITextField.BorderStyle.roundedRect
        tfContractNumber.autocorrectionType = UITextAutocorrectionType.no
        tfContractNumber.keyboardType = UIKeyboardType.default
        tfContractNumber.returnKeyType = UIReturnKeyType.done
        tfContractNumber.clearButtonMode = UITextField.ViewMode.whileEditing
        tfContractNumber.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfContractNumber.delegate = self
        contractInfoView.addSubview(tfContractNumber)
        
        let lbTextDateReceivingPremises = UILabel(frame: CGRect(x: tfContractNumber.frame.origin.x , y: tfContractNumber.frame.origin.y + tfContractNumber.frame.size.height +  Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextDateReceivingPremises.textAlignment = .left
        lbTextDateReceivingPremises.textColor = UIColor.black
        lbTextDateReceivingPremises.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextDateReceivingPremises.text = "Ngày nhận mặt bằng (*)"
        contractInfoView.addSubview(lbTextDateReceivingPremises)
        
        tfDateReceivingPremises = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextDateReceivingPremises.frame.origin.y + lbTextDateReceivingPremises.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfDateReceivingPremises.placeholder = "Chọn ngày nhận mặt bằng"
        tfDateReceivingPremises.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDateReceivingPremises.borderStyle = UITextField.BorderStyle.roundedRect
        tfDateReceivingPremises.autocorrectionType = UITextAutocorrectionType.no
        tfDateReceivingPremises.keyboardType = UIKeyboardType.default
        tfDateReceivingPremises.returnKeyType = UIReturnKeyType.done
        tfDateReceivingPremises.clearButtonMode = UITextField.ViewMode.whileEditing
        tfDateReceivingPremises.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDateReceivingPremises.delegate = self
        tfDateReceivingPremises.isUserInteractionEnabled = false
        contractInfoView.addSubview(tfDateReceivingPremises)
        
        let viewDateReceivingPremises: UIView = UIView(frame: tfDateReceivingPremises.frame)
        contractInfoView.addSubview(viewDateReceivingPremises)
        
        let viewDateReceivingPremisesImage: UIImageView = UIImageView(frame: CGRect(x: viewDateReceivingPremises.frame.size.width - viewDateReceivingPremises.frame.size.height, y: viewDateReceivingPremises.frame.size.height/4, width: viewDateReceivingPremises.frame.size.height, height: viewDateReceivingPremises.frame.size.height/2))
        viewDateReceivingPremisesImage.image = UIImage(named:"Calender2")
        viewDateReceivingPremisesImage.contentMode = .scaleAspectFit
        viewDateReceivingPremises.addSubview(viewDateReceivingPremisesImage)
        
        let tapDateReceivingPremises = UITapGestureRecognizer(target: self, action: #selector(self.handleTapDateReceivingPremises(_:)))
        viewDateReceivingPremises.addGestureRecognizer(tapDateReceivingPremises)
        
        
        
        let lbTextDateBeginPay = UILabel(frame: CGRect(x: tfContractNumber.frame.origin.x , y: tfDateReceivingPremises.frame.origin.y + tfDateReceivingPremises.frame.size.height +  Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextDateBeginPay.textAlignment = .left
        lbTextDateBeginPay.textColor = UIColor.black
        lbTextDateBeginPay.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextDateBeginPay.text = "Ngày tính tiền thuê nhà (*)"
        contractInfoView.addSubview(lbTextDateBeginPay)
        
        tfDateBeginPay = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextDateBeginPay.frame.origin.y + lbTextDateBeginPay.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfDateBeginPay.placeholder = "Chọn ngày tính tiền"
        tfDateBeginPay.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDateBeginPay.borderStyle = UITextField.BorderStyle.roundedRect
        tfDateBeginPay.autocorrectionType = UITextAutocorrectionType.no
        tfDateBeginPay.keyboardType = UIKeyboardType.default
        tfDateBeginPay.returnKeyType = UIReturnKeyType.done
        tfDateBeginPay.clearButtonMode = UITextField.ViewMode.whileEditing
        tfDateBeginPay.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDateBeginPay.delegate = self
        contractInfoView.addSubview(tfDateBeginPay)
        
        let viewDateBeginPay: UIView = UIView(frame: tfDateBeginPay.frame)
        contractInfoView.addSubview(viewDateBeginPay)
        
        let viewDateBeginPayImage: UIImageView = UIImageView(frame: CGRect(x: viewDateBeginPay.frame.size.width - viewDateBeginPay.frame.size.height, y: viewDateBeginPay.frame.size.height/4, width: viewDateBeginPay.frame.size.height, height: viewDateBeginPay.frame.size.height/2))
        viewDateBeginPayImage.image = UIImage(named:"Calender2")
        viewDateBeginPayImage.contentMode = .scaleAspectFit
        viewDateBeginPay.addSubview(viewDateBeginPayImage)
        
        let tapDateBeginPay = UITapGestureRecognizer(target: self, action: #selector(self.handleTapDateBeginPay(_:)))
        viewDateBeginPay.addGestureRecognizer(tapDateBeginPay)
        
        let lbTextContractStartDate = UILabel(frame: CGRect(x: tfContractNumber.frame.origin.x , y: tfDateBeginPay.frame.origin.y + tfDateBeginPay.frame.size.height +  Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextContractStartDate.textAlignment = .left
        lbTextContractStartDate.textColor = UIColor.black
        lbTextContractStartDate.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextContractStartDate.text = "Ngày bắt đầu hợp đồng (*)"
        contractInfoView.addSubview(lbTextContractStartDate)
        
        
        tfContractStartDate = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextContractStartDate.frame.origin.y + lbTextContractStartDate.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfContractStartDate.placeholder = "Chọn ngày bắt đầu HĐ"
        tfContractStartDate.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfContractStartDate.borderStyle = UITextField.BorderStyle.roundedRect
        tfContractStartDate.autocorrectionType = UITextAutocorrectionType.no
        tfContractStartDate.keyboardType = UIKeyboardType.default
        tfContractStartDate.returnKeyType = UIReturnKeyType.done
        tfContractStartDate.clearButtonMode = UITextField.ViewMode.whileEditing
        tfContractStartDate.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfContractStartDate.delegate = self
        contractInfoView.addSubview(tfContractStartDate)
        
        let viewContractStartDate: UIView = UIView(frame: tfContractStartDate.frame)
        contractInfoView.addSubview(viewContractStartDate)
        
        let viewContractStartDateImage: UIImageView = UIImageView(frame: CGRect(x: viewContractStartDate.frame.size.width - viewContractStartDate.frame.size.height, y: viewContractStartDate.frame.size.height/4, width: viewContractStartDate.frame.size.height, height: viewContractStartDate.frame.size.height/2))
        viewContractStartDateImage.image = UIImage(named:"Calender2")
        viewContractStartDateImage.contentMode = .scaleAspectFit
        viewContractStartDate.addSubview(viewContractStartDateImage)
        
        let tapContractStartDate = UITapGestureRecognizer(target: self, action: #selector(self.handleTapContractStartDate(_:)))
        viewContractStartDate.addGestureRecognizer(tapContractStartDate)
        
        let lbTextDateEndPay = UILabel(frame: CGRect(x: tfContractNumber.frame.origin.x , y: tfContractStartDate.frame.origin.y + tfContractStartDate.frame.size.height +  Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextDateEndPay.textAlignment = .left
        lbTextDateEndPay.textColor = UIColor.black
        lbTextDateEndPay.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextDateEndPay.text = "Ngày kết thúc hợp đồng (*)"
        contractInfoView.addSubview(lbTextDateEndPay)
        
        tfDateEndPay = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextDateEndPay.frame.origin.y + lbTextDateEndPay.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfDateEndPay.placeholder = "Chọn ngày kết thúc HĐ"
        tfDateEndPay.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDateEndPay.borderStyle = UITextField.BorderStyle.roundedRect
        tfDateEndPay.autocorrectionType = UITextAutocorrectionType.no
        tfDateEndPay.keyboardType = UIKeyboardType.default
        tfDateEndPay.returnKeyType = UIReturnKeyType.done
        tfDateEndPay.clearButtonMode = UITextField.ViewMode.whileEditing
        tfDateEndPay.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDateEndPay.delegate = self
        contractInfoView.addSubview(tfDateEndPay)
        
        let viewDateEndPay: UIView = UIView(frame: tfDateEndPay.frame)
        contractInfoView.addSubview(viewDateEndPay)
        
        let viewDateEndPayImage: UIImageView = UIImageView(frame: CGRect(x: viewDateEndPay.frame.size.width - viewDateEndPay.frame.size.height, y: viewDateEndPay.frame.size.height/4, width: viewDateEndPay.frame.size.height, height: viewDateEndPay.frame.size.height/2))
        viewDateEndPayImage.image = UIImage(named:"Calender2")
        viewDateEndPayImage.contentMode = .scaleAspectFit
        viewDateEndPay.addSubview(viewDateEndPayImage)
        
        let tapDateEndPay = UITapGestureRecognizer(target: self, action: #selector(self.handleTapDateEndPay(_:)))
        viewDateEndPay.addGestureRecognizer(tapDateEndPay)
        
        let  lbInfoPrice = UILabel(frame: CGRect(x: tfDateEndPay.frame.origin.x, y: tfDateEndPay.frame.size.height + tfDateEndPay.frame.origin.y + Common.Size(s: 15), width:tfDateEndPay.frame.size.width, height: Common.Size(s: 14)))
        lbInfoPrice.textAlignment = .left
        lbInfoPrice.textColor = UIColor(netHex:0x04AB6E)
        lbInfoPrice.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Giá thuê theo giai đoạn", attributes: underlineAttribute)
        lbInfoPrice.attributedText = underlineAttributedString
        contractInfoView.addSubview(lbInfoPrice)
        
        let tapShowDetailPrice = UITapGestureRecognizer(target: self, action: #selector(TenancyViewController.detailPrice))
        lbInfoPrice.isUserInteractionEnabled = true
        lbInfoPrice.addGestureRecognizer(tapShowDetailPrice)
        
        
        let lbTextLimit = UILabel(frame: CGRect(x: tfContractNumber.frame.origin.x , y: lbInfoPrice.frame.origin.y + lbInfoPrice.frame.size.height +  Common.Size(s:15), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextLimit.textAlignment = .left
        lbTextLimit.textColor = UIColor.black
        lbTextLimit.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextLimit.text = "Thời hạn cho thuê (năm) (*)"
        contractInfoView.addSubview(lbTextLimit)
        
        tfLimit = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextLimit.frame.origin.y + lbTextLimit.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfLimit.placeholder = "Nhập thời hạn cho thuê"
        tfLimit.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfLimit.borderStyle = UITextField.BorderStyle.roundedRect
        tfLimit.autocorrectionType = UITextAutocorrectionType.no
        tfLimit.keyboardType = UIKeyboardType.default
        tfLimit.returnKeyType = UIReturnKeyType.done
        tfLimit.clearButtonMode = UITextField.ViewMode.whileEditing
        tfLimit.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfLimit.delegate = self
        contractInfoView.addSubview(tfLimit)
        
        
        let lbTextDeposit = UILabel(frame: CGRect(x: tfContractNumber.frame.origin.x , y: tfLimit.frame.origin.y + tfLimit.frame.size.height +  Common.Size(s:10), width: (scrollView.frame.size.width - Common.Size(s:45)) * 2/3, height: Common.Size(s:14)))
        lbTextDeposit.textAlignment = .left
        lbTextDeposit.textColor = UIColor.black
        lbTextDeposit.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextDeposit.text = "Tiền đặt cọc (*)"
        contractInfoView.addSubview(lbTextDeposit)
        
        tfDeposit = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextDeposit.frame.origin.y + lbTextDeposit.frame.size.height + Common.Size(s:5), width: lbTextDeposit.frame.size.width, height: Common.Size(s:35)))
        tfDeposit.placeholder = "Nhập số tiền"
        tfDeposit.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDeposit.borderStyle = UITextField.BorderStyle.roundedRect
        tfDeposit.autocorrectionType = UITextAutocorrectionType.no
        tfDeposit.keyboardType = UIKeyboardType.numberPad
        tfDeposit.returnKeyType = UIReturnKeyType.done
        tfDeposit.clearButtonMode = UITextField.ViewMode.whileEditing
        tfDeposit.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDeposit.delegate = self
        contractInfoView.addSubview(tfDeposit)
        tfDeposit.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let lbTextDepositUnit = UILabel(frame: CGRect(x: lbTextDeposit.frame.origin.x + lbTextDeposit.frame.size.width + Common.Size(s: 15), y: lbTextDeposit.frame.origin.y, width: (scrollView.frame.size.width - Common.Size(s:45))/3, height: Common.Size(s:14)))
        lbTextDepositUnit.textAlignment = .left
        lbTextDepositUnit.textColor = UIColor.black
        lbTextDepositUnit.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextDepositUnit.text = "Đơn vị tiền (*)"
        contractInfoView.addSubview(lbTextDepositUnit)
        
        tfDepositUnit = SearchTextField(frame: CGRect(x: lbTextDepositUnit.frame.origin.x, y: lbTextDepositUnit.frame.origin.y + lbTextDepositUnit.frame.size.height + Common.Size(s:5), width: lbTextDepositUnit.frame.size.width, height: Common.Size(s:35)))
        
        tfDepositUnit.placeholder = "Chọn ĐV"
        tfDepositUnit.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDepositUnit.borderStyle = UITextField.BorderStyle.roundedRect
        tfDepositUnit.autocorrectionType = UITextAutocorrectionType.no
        tfDepositUnit.keyboardType = UIKeyboardType.default
        tfDepositUnit.returnKeyType = UIReturnKeyType.done
        tfDepositUnit.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfDepositUnit.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDepositUnit.delegate = self
        
        tfDepositUnit.startVisible = true
        tfDepositUnit.theme.bgColor = UIColor.white
        tfDepositUnit.theme.fontColor = UIColor.black
        tfDepositUnit.theme.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfDepositUnit.theme.cellHeight = Common.Size(s:40)
        tfDepositUnit.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.systemFont(ofSize: Common.Size(s:14))]
        contractInfoView.addSubview(tfDepositUnit)
        
        
        let lbTextWithdrawal = UILabel(frame: CGRect(x: tfContractNumber.frame.origin.x , y: tfDepositUnit.frame.origin.y + tfDepositUnit.frame.size.height +  Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextWithdrawal.textAlignment = .left
        lbTextWithdrawal.textColor = UIColor.black
        lbTextWithdrawal.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextWithdrawal.text = "Hình thức rút cọc (*)"
        contractInfoView.addSubview(lbTextWithdrawal)
        
        tfWithdrawal = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextWithdrawal.frame.origin.y + lbTextWithdrawal.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfWithdrawal.placeholder = "Nhập hình thức rút cọc"
        tfWithdrawal.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfWithdrawal.borderStyle = UITextField.BorderStyle.roundedRect
        tfWithdrawal.autocorrectionType = UITextAutocorrectionType.no
        tfWithdrawal.keyboardType = UIKeyboardType.default
        tfWithdrawal.returnKeyType = UIReturnKeyType.done
        tfWithdrawal.clearButtonMode = UITextField.ViewMode.whileEditing
        tfWithdrawal.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfWithdrawal.delegate = self
        contractInfoView.addSubview(tfWithdrawal)
        
        let lbTextPaymentPeriod = UILabel(frame: CGRect(x: tfContractNumber.frame.origin.x , y: tfWithdrawal.frame.origin.y + tfWithdrawal.frame.size.height +  Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPaymentPeriod.textAlignment = .left
        lbTextPaymentPeriod.textColor = UIColor.black
        lbTextPaymentPeriod.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPaymentPeriod.text = "Kỳ thanh toán (tháng) (*)"
        contractInfoView.addSubview(lbTextPaymentPeriod)
        
        tfPaymentPeriod = SearchTextField(frame: CGRect(x: lbTextPaymentPeriod.frame.origin.x, y: lbTextPaymentPeriod.frame.origin.y + lbTextPaymentPeriod.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        
        tfPaymentPeriod.placeholder = "Chọn kỳ thanh toán"
        tfPaymentPeriod.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPaymentPeriod.borderStyle = UITextField.BorderStyle.roundedRect
        tfPaymentPeriod.autocorrectionType = UITextAutocorrectionType.no
        tfPaymentPeriod.keyboardType = UIKeyboardType.default
        tfPaymentPeriod.returnKeyType = UIReturnKeyType.done
        tfPaymentPeriod.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPaymentPeriod.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPaymentPeriod.delegate = self
        
        tfPaymentPeriod.startVisible = true
        tfPaymentPeriod.theme.bgColor = UIColor.white
        tfPaymentPeriod.theme.fontColor = UIColor.black
        tfPaymentPeriod.theme.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfPaymentPeriod.theme.cellHeight = Common.Size(s:40)
        tfPaymentPeriod.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.systemFont(ofSize: Common.Size(s:14))]
        contractInfoView.addSubview(tfPaymentPeriod)
        
        let lbTextBeginDatePay = UILabel(frame: CGRect(x: tfPaymentPeriod.frame.origin.x , y: tfPaymentPeriod.frame.origin.y + tfPaymentPeriod.frame.size.height +  Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextBeginDatePay.textAlignment = .left
        lbTextBeginDatePay.textColor = UIColor.black
        lbTextBeginDatePay.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextBeginDatePay.text = "Ngày bắt đầu thanh toán (*)"
        contractInfoView.addSubview(lbTextBeginDatePay)
        
        
        tfBeginDatePay = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextBeginDatePay.frame.origin.y + lbTextBeginDatePay.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfBeginDatePay.placeholder = "Chọn ngày bắt đầu thanh toán"
        tfBeginDatePay.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfBeginDatePay.borderStyle = UITextField.BorderStyle.roundedRect
        tfBeginDatePay.autocorrectionType = UITextAutocorrectionType.no
        tfBeginDatePay.keyboardType = UIKeyboardType.default
        tfBeginDatePay.returnKeyType = UIReturnKeyType.done
        tfBeginDatePay.clearButtonMode = UITextField.ViewMode.whileEditing
        tfBeginDatePay.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfBeginDatePay.delegate = self
        contractInfoView.addSubview(tfBeginDatePay)
        
        let viewBeginDatePay: UIView = UIView(frame: tfBeginDatePay.frame)
        contractInfoView.addSubview(viewBeginDatePay)
        
        let viewBeginDatePayImage: UIImageView = UIImageView(frame: CGRect(x: viewBeginDatePay.frame.size.width - viewBeginDatePay.frame.size.height, y: viewBeginDatePay.frame.size.height/4, width: viewBeginDatePay.frame.size.height, height: viewBeginDatePay.frame.size.height/2))
        viewBeginDatePayImage.image = UIImage(named:"Calender2")
        viewBeginDatePayImage.contentMode = .scaleAspectFit
        viewBeginDatePay.addSubview(viewBeginDatePayImage)
        
        let tapBeginDatePay = UITapGestureRecognizer(target: self, action: #selector(self.handleTapBeginDatePay(_:)))
        viewBeginDatePay.addGestureRecognizer(tapBeginDatePay)
        
        let lbTextDatePay = UILabel(frame: CGRect(x: tfPaymentPeriod.frame.origin.x , y: tfBeginDatePay.frame.origin.y + tfBeginDatePay.frame.size.height +  Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextDatePay.textAlignment = .left
        lbTextDatePay.textColor = UIColor.black
        lbTextDatePay.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextDatePay.text = "Ngày thanh toán"
        contractInfoView.addSubview(lbTextDatePay)
        
        
        tfDatePay = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextDatePay.frame.origin.y + lbTextDatePay.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfDatePay.placeholder = "Nhập ngày thanh toán"
        tfDatePay.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDatePay.borderStyle = UITextField.BorderStyle.roundedRect
        tfDatePay.autocorrectionType = UITextAutocorrectionType.no
        tfDatePay.keyboardType = UIKeyboardType.default
        tfDatePay.returnKeyType = UIReturnKeyType.done
        tfDatePay.clearButtonMode = UITextField.ViewMode.whileEditing
        tfDatePay.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDatePay.delegate = self
        contractInfoView.addSubview(tfDatePay)
        
        let lbTextAcreage = UILabel(frame: CGRect(x: tfDatePay.frame.origin.x , y: tfDatePay.frame.origin.y + tfDatePay.frame.size.height +  Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextAcreage.textAlignment = .left
        lbTextAcreage.textColor = UIColor.black
        lbTextAcreage.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextAcreage.text = "Diện tích (m2) (*)"
        contractInfoView.addSubview(lbTextAcreage)
        
        tfAcreage = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextAcreage.frame.origin.y + lbTextAcreage.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfAcreage.placeholder = "Nhập diện tích"
        tfAcreage.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfAcreage.borderStyle = UITextField.BorderStyle.roundedRect
        tfAcreage.autocorrectionType = UITextAutocorrectionType.no
        tfAcreage.keyboardType = UIKeyboardType.default
        tfAcreage.returnKeyType = UIReturnKeyType.done
        tfAcreage.clearButtonMode = UITextField.ViewMode.whileEditing
        tfAcreage.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfAcreage.delegate = self
        contractInfoView.addSubview(tfAcreage)
        
        let lbTextTaxFRT = UILabel(frame: CGRect(x: tfDatePay.frame.origin.x , y: tfAcreage.frame.origin.y + tfAcreage.frame.size.height +  Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextTaxFRT.textAlignment = .left
        lbTextTaxFRT.textColor = UIColor.black
        lbTextTaxFRT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lbTextTaxFRT.text = "FRT chịu thuế"
        lbTextTaxFRT.text = "Thuế"
        contractInfoView.addSubview(lbTextTaxFRT)
        
        tfChooseTax = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lbTextTaxFRT.frame.origin.y + lbTextTaxFRT.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfChooseTax.placeholder = "Chọn hình thức thuế"
        tfChooseTax.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfChooseTax.borderStyle = UITextField.BorderStyle.roundedRect
        tfChooseTax.autocorrectionType = UITextAutocorrectionType.no
        tfChooseTax.returnKeyType = UIReturnKeyType.done
        tfChooseTax.clearButtonMode = UITextField.ViewMode.whileEditing
        tfChooseTax.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfChooseTax.delegate = self
        contractInfoView.addSubview(tfChooseTax)
        
        tfChooseTax.startVisible = true
        tfChooseTax.theme.bgColor = UIColor.white
        tfChooseTax.theme.fontColor = UIColor.black
        tfChooseTax.theme.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfChooseTax.theme.cellHeight = Common.Size(s:40)
        tfChooseTax.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.systemFont(ofSize: Common.Size(s:14))]
        
        viewFacade = UIView(frame: CGRect(x: 0, y: tfChooseTax.frame.origin.y + tfChooseTax.frame.size.height +  Common.Size(s:10), width: scrollView.frame.size.width, height: 0))
        viewFacade.clipsToBounds = true
        contractInfoView.addSubview(viewFacade)
        
        let lbTextFacade = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbTextFacade.textAlignment = .left
        lbTextFacade.textColor = UIColor.black
        lbTextFacade.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextFacade.text = "Hình ảnh mặt tiền (*)"
        lbTextFacade.sizeToFit()
        viewFacade.addSubview(lbTextFacade)
        
        imgViewFacade = UIImageView(frame: CGRect(x:Common.Size(s: 15), y: lbTextFacade.frame.origin.y + lbTextFacade.frame.size.height + Common.Size(s:5), width: viewFacade.frame.size.width - Common.Size(s:30), height: (viewFacade.frame.size.width - Common.Size(s:30)) / 2.6))
        imgViewFacade.image = UIImage(named:"UploadImage")
        imgViewFacade.contentMode = .scaleAspectFit
        viewFacade.addSubview(imgViewFacade)
        viewFacade.frame.size.height = imgViewFacade.frame.origin.y + imgViewFacade.frame.size.height
        
        let tapShowFacade = UITapGestureRecognizer(target: self, action: #selector(self.tapShowFacade))
        viewFacade.isUserInteractionEnabled = true
        viewFacade.addGestureRecognizer(tapShowFacade)
        
        viewImages = UIView(frame: CGRect(x: 0, y: viewFacade.frame.origin.y + viewFacade.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width, height: 0))
        viewImages.clipsToBounds = true
        contractInfoView.addSubview(viewImages)
        
        viewImage1 = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: 0))
        viewImage1.clipsToBounds = true
        viewImages.addSubview(viewImage1)
        
        let lbTextImage1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbTextImage1.textAlignment = .left
        lbTextImage1.textColor = UIColor.black
        lbTextImage1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextImage1.text = "Hình đính kèm hợp đồng (*)"
        lbTextImage1.sizeToFit()
        viewImage1.addSubview(lbTextImage1)
        
        imgViewImage1 = UIImageView(frame: CGRect(x:Common.Size(s: 15), y: lbTextFacade.frame.origin.y + lbTextFacade.frame.size.height + Common.Size(s:5), width: viewFacade.frame.size.width - Common.Size(s:30), height: (viewFacade.frame.size.width - Common.Size(s:30)) / 2.6))
        imgViewImage1.image = UIImage(named:"UploadImage")
        imgViewImage1.contentMode = .scaleAspectFit
        viewImage1.addSubview(imgViewImage1)
        viewImage1.frame.size.height = imgViewImage1.frame.origin.y + imgViewImage1.frame.size.height
        viewImage1.tag = 1
        let tapShowImage = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImage))
        viewImage1.isUserInteractionEnabled = true
        viewImage1.addGestureRecognizer(tapShowImage)
        
        //2
        viewImage2 = UIView(frame: CGRect(x: 0, y: viewImage1.frame.size.height + viewImage1.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width, height: 0))
        viewImage2.clipsToBounds = true
        viewImages.addSubview(viewImage2)
        
        imgViewImage2 = UIImageView(frame: CGRect(x:Common.Size(s: 15), y: 0, width: viewFacade.frame.size.width - Common.Size(s:30), height: (viewFacade.frame.size.width - Common.Size(s:30)) / 2.6))
        imgViewImage2.image = UIImage(named:"UploadImage")
        imgViewImage2.contentMode = .scaleAspectFit
        viewImage2.addSubview(imgViewImage2)
        viewImage2.frame.size.height = imgViewImage2.frame.origin.y + imgViewImage2.frame.size.height
        viewImage2.tag = 2
        
        let tapShowImage2 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImage))
        viewImage2.isUserInteractionEnabled = true
        viewImage2.addGestureRecognizer(tapShowImage2)
        
        //3
        viewImage3 = UIView(frame: CGRect(x: 0, y: viewImage2.frame.size.height + viewImage2.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width, height: 0))
        viewImage3.clipsToBounds = true
        viewImages.addSubview(viewImage3)
        
        imgViewImage3 = UIImageView(frame: CGRect(x:Common.Size(s: 15), y: 0, width: viewFacade.frame.size.width - Common.Size(s:30), height: (viewFacade.frame.size.width - Common.Size(s:30)) / 2.6))
        imgViewImage3.image = UIImage(named:"UploadImage")
        imgViewImage3.contentMode = .scaleAspectFit
        viewImage3.addSubview(imgViewImage3)
        viewImage3.frame.size.height = imgViewImage3.frame.origin.y + imgViewImage3.frame.size.height
        viewImage3.tag = 3
        
        let tapShowImage3 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImage))
        viewImage3.isUserInteractionEnabled = true
        viewImage3.addGestureRecognizer(tapShowImage3)
        
        //4
        viewImage4 = UIView(frame: CGRect(x: 0, y: viewImage3.frame.size.height + viewImage3.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width, height: 0))
        viewImage4.clipsToBounds = true
        viewImages.addSubview(viewImage4)
        
        imgViewImage4 = UIImageView(frame: CGRect(x:Common.Size(s: 15), y: 0, width: viewFacade.frame.size.width - Common.Size(s:30), height: (viewFacade.frame.size.width - Common.Size(s:30)) / 2.6))
        imgViewImage4.image = UIImage(named:"UploadImage")
        imgViewImage4.contentMode = .scaleAspectFit
        viewImage4.addSubview(imgViewImage4)
        viewImage4.frame.size.height = imgViewImage4.frame.origin.y + imgViewImage4.frame.size.height
        viewImage4.tag = 4
        
        let tapShowImage4 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImage))
        viewImage4.isUserInteractionEnabled = true
        viewImage4.addGestureRecognizer(tapShowImage4)
        
        //5
        viewImage5 = UIView(frame: CGRect(x: 0, y: viewImage4.frame.size.height + viewImage4.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width, height: 0))
        viewImage5.clipsToBounds = true
        viewImages.addSubview(viewImage5)
        
        imgViewImage5 = UIImageView(frame: CGRect(x:Common.Size(s: 15), y: 0, width: viewFacade.frame.size.width - Common.Size(s:30), height: (viewFacade.frame.size.width - Common.Size(s:30)) / 2.6))
        imgViewImage5.image = UIImage(named:"UploadImage")
        imgViewImage5.contentMode = .scaleAspectFit
        viewImage5.addSubview(imgViewImage5)
        viewImage5.frame.size.height = imgViewImage5.frame.origin.y + imgViewImage5.frame.size.height
        viewImage5.tag = 5
        
        let tapShowImage5 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImage))
        viewImage5.isUserInteractionEnabled = true
        viewImage5.addGestureRecognizer(tapShowImage5)
        
        //6
        viewImage6 = UIView(frame: CGRect(x: 0, y: viewImage5.frame.size.height + viewImage5.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width, height: 0))
        viewImage6.clipsToBounds = true
        viewImages.addSubview(viewImage6)
        
        imgViewImage6 = UIImageView(frame: CGRect(x:Common.Size(s: 15), y: 0, width: viewFacade.frame.size.width - Common.Size(s:30), height: (viewFacade.frame.size.width - Common.Size(s:30)) / 2.6))
        imgViewImage6.image = UIImage(named:"UploadImage")
        imgViewImage6.contentMode = .scaleAspectFit
        viewImage6.addSubview(imgViewImage6)
        viewImage6.frame.size.height = imgViewImage6.frame.origin.y + imgViewImage6.frame.size.height
        viewImage6.tag = 6
        
        let tapShowImage6 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImage))
        viewImage6.isUserInteractionEnabled = true
        viewImage6.addGestureRecognizer(tapShowImage6)
        
        //7
        viewImage7 = UIView(frame: CGRect(x: 0, y: viewImage6.frame.size.height + viewImage6.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width, height: 0))
        viewImage7.clipsToBounds = true
        viewImages.addSubview(viewImage7)
        
        imgViewImage7 = UIImageView(frame: CGRect(x:Common.Size(s: 15), y: 0, width: viewFacade.frame.size.width - Common.Size(s:30), height: (viewFacade.frame.size.width - Common.Size(s:30)) / 2.6))
        imgViewImage7.image = UIImage(named:"UploadImage")
        imgViewImage7.contentMode = .scaleAspectFit
        viewImage7.addSubview(imgViewImage7)
        viewImage7.frame.size.height = imgViewImage7.frame.origin.y + imgViewImage7.frame.size.height
        viewImage7.tag = 7
        
        let tapShowImage7 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImage))
        viewImage7.isUserInteractionEnabled = true
        viewImage7.addGestureRecognizer(tapShowImage7)
        
        //8
        viewImage8 = UIView(frame: CGRect(x: 0, y: viewImage7.frame.size.height + viewImage7.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width, height: 0))
        viewImage8.clipsToBounds = true
        viewImages.addSubview(viewImage8)
        
        imgViewImage8 = UIImageView(frame: CGRect(x:Common.Size(s: 15), y: 0, width: viewFacade.frame.size.width - Common.Size(s:30), height: (viewFacade.frame.size.width - Common.Size(s:30)) / 2.6))
        imgViewImage8.image = UIImage(named:"UploadImage")
        imgViewImage8.contentMode = .scaleAspectFit
        viewImage8.addSubview(imgViewImage8)
        viewImage8.frame.size.height = imgViewImage8.frame.origin.y + imgViewImage8.frame.size.height
        viewImage8.tag = 8
        
        let tapShowImage8 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImage))
        viewImage8.isUserInteractionEnabled = true
        viewImage8.addGestureRecognizer(tapShowImage8)
        
        //9
        viewImage9 = UIView(frame: CGRect(x: 0, y: viewImage8.frame.size.height + viewImage8.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width, height: 0))
        viewImage9.clipsToBounds = true
        viewImages.addSubview(viewImage9)
        
        imgViewImage9 = UIImageView(frame: CGRect(x:Common.Size(s: 15), y: 0, width: viewFacade.frame.size.width - Common.Size(s:30), height: (viewFacade.frame.size.width - Common.Size(s:30)) / 2.6))
        imgViewImage9.image = UIImage(named:"UploadImage")
        imgViewImage9.contentMode = .scaleAspectFit
        viewImage9.addSubview(imgViewImage9)
        viewImage9.frame.size.height = imgViewImage9.frame.origin.y + imgViewImage9.frame.size.height
        viewImage9.tag = 9
        
        let tapShowImage9 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImage))
        viewImage9.isUserInteractionEnabled = true
        viewImage9.addGestureRecognizer(tapShowImage9)
        
        //10
        viewImage10 = UIView(frame: CGRect(x: 0, y: viewImage9.frame.size.height + viewImage9.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width, height: 0))
        viewImage10.clipsToBounds = true
        viewImages.addSubview(viewImage10)
        
        imgViewImage10 = UIImageView(frame: CGRect(x:Common.Size(s: 15), y: 0, width: viewFacade.frame.size.width - Common.Size(s:30), height: (viewFacade.frame.size.width - Common.Size(s:30)) / 2.6))
        imgViewImage10.image = UIImage(named:"UploadImage")
        imgViewImage10.contentMode = .scaleAspectFit
        viewImage10.addSubview(imgViewImage10)
        viewImage10.frame.size.height = imgViewImage10.frame.origin.y + imgViewImage10.frame.size.height
        viewImage10.tag = 10
        
        let tapShowImage10 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImage))
        viewImage10.isUserInteractionEnabled = true
        viewImage10.addGestureRecognizer(tapShowImage10)
        
        viewFooter = UIView(frame: CGRect(x: 0, y: viewImage1.frame.size.height + viewImage1.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width, height: 0))
        viewFooter.clipsToBounds = true
        viewFooter.backgroundColor = .white
        viewImages.addSubview(viewFooter)
        
        
        lbMoreImages = UILabel(frame: CGRect(x: tfDateEndPay.frame.origin.x, y: 0, width:tfDateEndPay.frame.size.width, height: Common.Size(s: 14)))
        lbMoreImages.textAlignment = .right
        lbMoreImages.textColor = UIColor(netHex:0x04AB6E)
        lbMoreImages.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttributeMore = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedMoreString = NSAttributedString(string: "Upload thêm", attributes: underlineAttributeMore)
        lbMoreImages.attributedText = underlineAttributedMoreString
        viewFooter.addSubview(lbMoreImages)
        
        let tapShowMore = UITapGestureRecognizer(target: self, action: #selector(TenancyViewController.tapShowMore))
        lbMoreImages.isUserInteractionEnabled = true
        lbMoreImages.addGestureRecognizer(tapShowMore)
        
        btPay = UIButton()
        btPay.frame = CGRect(x: Common.Size(s:15), y: lbMoreImages.frame.origin.y + lbMoreImages.frame.size.height + Common.Size(s:20), width: viewImages.frame.size.width - Common.Size(s:30), height: Common.Size(s:40))
        btPay.backgroundColor = UIColor(netHex:0x04AB6E)
        btPay.setTitle("LƯU", for: .normal)
        btPay.addTarget(self, action: #selector(actionSave), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        
        viewFooter.addSubview(btPay)
        viewImages.backgroundColor = .white
        viewImages.clipsToBounds = true
        viewFooter.frame.size.height = btPay.frame.size.height + btPay.frame.origin.y + Common.Size(s: 20)
        viewImages.frame.size.height = viewFooter.frame.size.height + viewFooter.frame.origin.y
        contractInfoView.frame.size.height = viewImages.frame.size.height + viewImages.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: contractInfoView.frame.size.height + contractInfoView.frame.origin.y + (self.navigationController?.navigationBar.frame.size.height)!)
    
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s),\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
        }else{
            textField.text = ""
        }
    }
    var valueBeginDatePay:String = ""
    @objc func handleTapBeginDatePay(_ sender: UITapGestureRecognizer? = nil) {
        let datePicker = ActionSheetDatePicker(title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let strDate = dateFormatter.string(from: value as! Date)
            self.tfBeginDatePay.text = "\(strDate)"
            self.valueBeginDatePay = strDate
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
        datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
        datePicker?.show()
    }
    var valueContractStartDate:String = ""
    @objc func handleTapContractStartDate(_ sender: UITapGestureRecognizer? = nil) {
        let datePicker = ActionSheetDatePicker(title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let strDate = dateFormatter.string(from: value as! Date)
            self.tfContractStartDate.text = "\(strDate)"
            self.valueContractStartDate = strDate
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
        datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
        datePicker?.show()
    }
    ///HANDLE CALENDAR
    var valueDateEndPay:String = ""
    var valueDateBeginPay:String = ""
    var valueDateReceivingPremises:String = ""
    
    @objc func handleTapDateEndPay(_ sender: UITapGestureRecognizer? = nil) {
        let datePicker = ActionSheetDatePicker(title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let strDate = dateFormatter.string(from: value as! Date)
            self.tfDateEndPay.text = "\(strDate)"
            self.valueDateEndPay = strDate
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
        datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
        datePicker?.show()
    }
    
    @objc func handleTapDateBeginPay(_ sender: UITapGestureRecognizer? = nil) {
        let datePicker = ActionSheetDatePicker(title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let strDate = dateFormatter.string(from: value as! Date)
            self.tfDateBeginPay.text = "\(strDate)"
            self.valueDateBeginPay = strDate
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
        datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
        datePicker?.show()
    }
    
    @objc func handleTapDateReceivingPremises(_ sender: UITapGestureRecognizer? = nil) {
        let datePicker = ActionSheetDatePicker(title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let strDate = dateFormatter.string(from: value as! Date)
            self.tfDateReceivingPremises.text = "\(strDate)"
            self.valueDateReceivingPremises = strDate
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
        datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
        datePicker?.show()
    }
    
    let locationManager = CLLocationManager()
    @objc func handleTapGPS(_ sender: UITapGestureRecognizer? = nil) {
        
        // Ask for Authorisation from the User.
        locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        //guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        if(tfShopGPS != nil){
//            tfShopGPS.text = "\(locValue.latitude),\(locValue.longitude)"
//        }
    }
//    fileprivate func createRadioButtonTax(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
//        let radioButton = DLRadioButton(frame: frame);
//        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:14));
//        radioButton.setTitle(title, for: UIControl.State());
//        radioButton.setTitleColor(color, for: UIControl.State());
//        radioButton.iconColor = UIColor(netHex:0x04AB6E);
//        radioButton.indicatorColor = UIColor(netHex:0x04AB6E);
//        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
//        radioButton.isIconSquare = true
//        radioButton.isMultipleSelectionEnabled = true
////        radioButton.addTarget(self, action: #selector(TenancyViewController.logSelectedButton), for: UIControl.Event.touchUpInside);
//        self.view.addSubview(radioButton);
//
//        return radioButton;
//    }
//    fileprivate func createRadioButton(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
//        let radioButton = DLRadioButton(frame: frame);
//        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:14));
//        radioButton.setTitle(title, for: UIControl.State());
//        radioButton.setTitleColor(color, for: UIControl.State());
//        radioButton.iconColor = UIColor(netHex:0x04AB6E);
//        radioButton.indicatorColor = UIColor(netHex:0x04AB6E);
//        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
//        radioButton.addTarget(self, action: #selector(TenancyViewController.logSelectedButton), for: UIControl.Event.touchUpInside);
//        self.view.addSubview(radioButton);
//
//        return radioButton;
//    }
//    @objc @IBAction fileprivate func logSelectedButton(_ radioButton : DLRadioButton) {
//        if (!radioButton.isMultipleSelectionEnabled) {
//            let temp = radioButton.selected()!.titleLabel!.text!
//            radioFPTShop.isSelected = false
//            radioLongChau.isSelected = false
//            switch temp {
//            case "FPT SHOP":
//                radioFPTShop.isSelected = true
//                self.getDataShops(isChoose: true,type: 3)
//                break
//            case "LONG CHÂU":
//                radioLongChau.isSelected = true
//                   self.getDataShops(isChoose: true,type: 8)
//                break
//            default:
//                radioFPTShop.isSelected = true
//                 self.getDataShops(isChoose: true,type: 3)
//                break
//            }
//
//        }
//    }
    func formatListPrice() -> String{
        if(self.priceItems.count > 0){
            var rs = "<line>"
            for item in self.priceItems {
                rs = rs + "<item U_FromDate=\"\(item.fromDate)\" U_ToDate=\"\(item.toDate)\" U_Money=\"\(String(describing: item.price))\"></item>"
            }
            rs = rs + "</line>"
            return rs.toBase64()
        }else{
            return ""
        }
    }
    @objc func actionSave(sender: UIButton!){
        let listPrice = formatListPrice()
        if(listPrice.isEmpty){
            Toast.init(text: "Bạn chưa chọn giá thuê theo giai đoạn").show()
            return
        }
        
        let nameHome = tfNameHome.text!
        if(nameHome.isEmpty){
            Toast.init(text: "Tên chủ nhà không được để trống").show()
            return
        }
        let taxHome = tfTaxHome.text!
//        if(taxHome.isEmpty){
//            Toast.init(text: "MST chủ nhà không được để trống").show()
//            return
//        }
        let phoneHome = tfPhoneHome.text!
        if(phoneHome.isEmpty){
            Toast.init(text: "SĐT chủ nhà không được để trống").show()
            return
        }
        if (phoneHome.hasPrefix("01") && phoneHome.count == 11){
            
        }else if (phoneHome.hasPrefix("0") && !phoneHome.hasPrefix("01") && phoneHome.count == 10){
            
        }else{
            Toast.init(text: "SĐT không hợp lệ").show()
            return
        }
        
        let namePayment = tfNamePayment.text!
        if(namePayment.isEmpty){
            Toast.init(text: "Tên tài khoản không được để trống").show()
            return
        }
        let accountPayment = tfAccountPayment.text!
        if(accountPayment.isEmpty){
            Toast.init(text: "Số tài khoản không được để trống").show()
            return
        }
        let bank = tfBanks.text!
        var checkBank: Bool = false
        for item in self.listBanks {
            if(item.label == bank){
                checkBank = true
                break
            }
        }
        if(!checkBank || idBank == 0){
            Toast.init(text: "Bạn phải chọn ngân hàng").show()
            return
        }
        
        let shop = tfShops.text!
        if(shop.count > 0){
            var checkShop: Bool = false
            for item in self.listShops {
                if(item.label == shop){
                    checkShop = true
                    break
                }
            }
            if(!checkShop || idShop == ""){
                Toast.init(text: "Bạn phải chọn shop").show()
                return
            }
        }

        let shopAddress = tfShopAddress.text!
        if(shopAddress.isEmpty){
            Toast.init(text: "Địa chỉ shop không được để trống").show()
            return
        }
        let province = tfProvince.text!
        var checkProvince: Bool = false
        for item in self.listProvinces {
            if(item.label == province){
                checkProvince = true
                break
            }
        }
        if(!checkProvince || idProvince == 0){
            Toast.init(text: "Bạn phải chọn Tỉnh/TP").show()
            return
        }
        
        let district = tfDistrict.text!
        var checkDistrict: Bool = false
        for item in self.listDistricts {
            if(item.label == district){
                checkDistrict = true
                break
            }
        }
        if(!checkDistrict || idDistrict == 0){
            Toast.init(text: "Bạn phải chọn Quận/Huyện").show()
            return
        }
        
        let contractType = tfContractType.text!
        var checkContractType: Bool = false
        for item in self.listContractType {
            if(item.label == contractType){
                checkContractType = true
                break
            }
        }
        if(!checkContractType || idContractType == 0){
            Toast.init(text: "Bạn phải chọn loại hợp đồng").show()
            return
        }
        
         let contractNumber = tfContractNumber.text!
        if(contractNumber.isEmpty){
            Toast.init(text: "Số hợp đồng không được để trống").show()
            return
        }
        
        if(valueDateReceivingPremises.isEmpty){
            Toast.init(text: "Bạn phải chọn ngày nhận mặt bằng").show()
            return
        }
        if(valueDateBeginPay.isEmpty){
            Toast.init(text: "Bạn phải chọn ngày tính tiền thuê nhà").show()
            return
        }
        if(valueContractStartDate.isEmpty){
            Toast.init(text: "Bạn phải chọn ngày bắt đầu hợp đồng").show()
            return
        }
        if(valueDateEndPay.isEmpty){
            Toast.init(text: "Bạn phải chọn ngày kết thúc hợp đồng").show()
            return
        }
        let limitTime = tfLimit.text!
        if(limitTime.isEmpty){
            Toast.init(text: "Thời hạn thuê không được để trống").show()
            return
        }
        var depositString:String = tfDeposit.text!
        depositString = depositString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        if(depositString == ""){
            depositString = "0"
        }
        let depositInt = Int(depositString)!
        if(depositInt <= 0){
            Toast.init(text: "Bạn phải nhập số tiền đặt cọc").show()
            return
        }
        
        let depositUnit = tfDepositUnit.text!
        var checkDepositUnit: Bool = false
        for item in self.listContractUnit {
            if(item.label == depositUnit){
                checkDepositUnit = true
                break
            }
        }
        if(!checkDepositUnit || idUnit == ""){
            Toast.init(text: "Bạn phải chọn đơn vị").show()
            return
        }
        
        let withdrawal = tfWithdrawal.text!
        if(withdrawal.isEmpty){
            Toast.init(text: "Hình thức rút cọc không được để trống").show()
            return
        }
        let paymentPeriod = tfPaymentPeriod.text!
        var checkPaymentPeriod: Bool = false
        for item in self.listPeriods{
            if(item.label == paymentPeriod){
                checkPaymentPeriod = true
                break
            }
        }
        if(!checkPaymentPeriod || idPeriod == 0){
            Toast.init(text: "Bạn phải chọn kỳ thanh toán").show()
            return
        }
        if(valueBeginDatePay.isEmpty){
            Toast.init(text: "Bạn phải chọn ngày bắt đầu thanh toán").show()
            return
        }
        let datePay = tfDatePay.text!
        if(datePay.isEmpty){
            Toast.init(text: "Ngày thanh toán không được để trống").show()
            return
        }
        let acreage = tfAcreage.text!
        if(acreage.isEmpty){
            Toast.init(text: "Diện tích không được để trống").show()
            return
        }
        if(imgUploadMT == nil){
            Toast.init(text: "Bạn phải chọn ảnh mặt tiền").show()
            return
        }
        if(imgUpload1 != nil){
            listImgUpload.append(imgUpload1)
        }else{
            Toast.init(text: "Bạn phải chọn ảnh hợp đồng").show()
            return
        }
        if(imgUpload2 != nil){
            listImgUpload.append(imgUpload2)
        }
        if(imgUpload3 != nil){
            listImgUpload.append(imgUpload3)
        }
        if(imgUpload4 != nil){
            listImgUpload.append(imgUpload4)
        }
        if(imgUpload5 != nil){
            listImgUpload.append(imgUpload5)
        }
        if(imgUpload6 != nil){
            listImgUpload.append(imgUpload6)
        }
        if(imgUpload7 != nil){
            listImgUpload.append(imgUpload7)
        }
        if(imgUpload8 != nil){
            listImgUpload.append(imgUpload8)
        }
        if(imgUpload9 != nil){
            listImgUpload.append(imgUpload9)
        }
        if(imgUpload10 != nil){
            listImgUpload.append(imgUpload10)
        }
        
        let typeShop: Int = 3
        //        if(radioLongChau.isSelected){
        //            typeShop = 8
        //        }
//        uploadImageMT(TenChuNha: nameHome, MaSoThueCN: taxHome, SDT: phoneHome, ChuTaiKhoan: namePayment, STK: accountPayment, NganHang: "\(idBank)", LoaiShop: "\(typeShop)", MaShop: idShop, TenShop: shop, DiaChiShop: shopAddress, QuanHuyen: "\(idDistrict)", TinhTP: "\(idProvince)", ViTriThucTe: shopGPS, LoaiKyHD: "\(idContractType)", SoHD: contractNumber, NgayNhanMB: valueDateReceivingPremises, NgayTTTNha: valueDateBeginPay, NgayKTHD: valueDateEndPay, ThoiHanThue: limitTime, TienDatCoc: depositString, DonVi: idUnit, HTRutCoc: withdrawal, KyHanTT: "\(idPeriod)", NgayBDTT: valueBeginDatePay, NgayThanhToan: datePay, DienTich: acreage, Thue: stringTax, SoTienChiuThue: taxString, XMLGTThang: listPrice,NgayBDHD:valueContractStartDate)
        
        uploadImageMT(TenChuNha: nameHome, MaSoThueCN: taxHome, SDT: phoneHome, ChuTaiKhoan: namePayment, STK: accountPayment, NganHang: "\(idBank)", LoaiShop: "\(typeShop)", MaShop: idShop, TenShop: shop, DiaChiShop: shopAddress, QuanHuyen: "\(idDistrict)", TinhTP: "\(idProvince)", ViTriThucTe: "", LoaiKyHD: "\(idContractType)", SoHD: contractNumber, NgayNhanMB: valueDateReceivingPremises, NgayTTTNha: valueDateBeginPay, NgayKTHD: valueDateEndPay, ThoiHanThue: limitTime, TienDatCoc: depositString, DonVi: idUnit, HTRutCoc: withdrawal, KyHanTT: "\(idPeriod)", NgayBDTT: valueBeginDatePay, NgayThanhToan: datePay, DienTich: acreage, Thue: "\(self.selectedTax?.value ?? 0)", SoTienChiuThue: "", XMLGTThang: listPrice,NgayBDHD:valueContractStartDate)
    }
    
    var urlImageMT:String = ""
    func uploadImageMT(TenChuNha: String, MaSoThueCN: String, SDT: String, ChuTaiKhoan: String, STK: String, NganHang: String, LoaiShop: String, MaShop: String, TenShop: String, DiaChiShop: String, QuanHuyen: String, TinhTP: String, ViTriThucTe: String, LoaiKyHD: String, SoHD: String, NgayNhanMB: String, NgayTTTNha: String, NgayKTHD: String, ThoiHanThue: String, TienDatCoc: String, DonVi: String, HTRutCoc: String, KyHanTT: String, NgayBDTT: String, NgayThanhToan: String, DienTich: String, Thue: String, SoTienChiuThue: String, XMLGTThang: String,NgayBDHD:String){
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang upload hình ảnh..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
         self.navigationController?.present(newViewController, animated: true, completion: nil)
        if let imageDataImage1:NSData = imgUploadMT.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
            let strBase64Image1 = imageDataImage1.base64EncodedString(options: .endLineWithLineFeed)
            MPOSAPIManager.mpos_FRT_RequestPaymentHome_UploadImage(Base64String: strBase64Image1) { (FilePath, error) in
                if(error.count <= 0){
                    self.urlImageMT = FilePath
                    self.uploadImage(TenChuNha: TenChuNha, MaSoThueCN: MaSoThueCN, SDT: SDT, ChuTaiKhoan: ChuTaiKhoan, STK: STK, NganHang: NganHang, LoaiShop: LoaiShop, MaShop: MaShop, TenShop: TenShop, DiaChiShop: DiaChiShop, QuanHuyen: QuanHuyen, TinhTP: TinhTP, ViTriThucTe: ViTriThucTe, LoaiKyHD: LoaiKyHD, SoHD: SoHD, NgayNhanMB: NgayNhanMB, NgayTTTNha: NgayTTTNha, NgayKTHD: NgayKTHD, ThoiHanThue: ThoiHanThue, TienDatCoc: TienDatCoc, DonVi: DonVi, HTRutCoc: HTRutCoc, KyHanTT: KyHanTT, NgayBDTT: NgayBDTT, NgayThanhToan: NgayThanhToan, DienTich: DienTich, Thue: Thue, SoTienChiuThue: SoTienChiuThue, XMLGTThang: XMLGTThang,NgayBDHD:NgayBDHD)
                }else{
                    let nc = NotificationCenter.default
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        let errorAlert = UIAlertController(title: "Thông báo", message: error, preferredStyle: .alert)
                        errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                            alert -> Void in
                            
                        }))
                        self.present(errorAlert, animated: true, completion: nil)
                    }
                }
            }
        }else{
            let nc = NotificationCenter.default
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                let errorAlert = UIAlertController(title: "Thông báo", message: "Xử lý hình lỗi, vui lòng chọn lại hình ảnh khác.", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                    alert -> Void in
                    
                }))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
    }
    var indexBase:Int = 0
    var arrLink: [String] = []
    func uploadImage(TenChuNha: String, MaSoThueCN: String, SDT: String, ChuTaiKhoan: String, STK: String, NganHang: String, LoaiShop: String, MaShop: String, TenShop: String, DiaChiShop: String, QuanHuyen: String, TinhTP: String, ViTriThucTe: String, LoaiKyHD: String, SoHD: String, NgayNhanMB: String, NgayTTTNha: String, NgayKTHD: String, ThoiHanThue: String, TienDatCoc: String, DonVi: String, HTRutCoc: String, KyHanTT: String, NgayBDTT: String, NgayThanhToan: String, DienTich: String, Thue: String, SoTienChiuThue: String, XMLGTThang: String,NgayBDHD:String){
        
        if(indexBase < self.listImgUpload.count){
            let imageDataImage1 = self.listImgUpload[indexBase]
            print("indexBase \(indexBase)")
            indexBase = indexBase + 1
            if let imageDataImage1:NSData = imageDataImage1.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                let strBase64Image1 = imageDataImage1.base64EncodedString(options: .endLineWithLineFeed)
                MPOSAPIManager.mpos_FRT_RequestPaymentHome_UploadImage(Base64String: strBase64Image1) { (FilePath, error) in
                    if(error.count <= 0){
                        self.arrLink.append(FilePath)
                        self.uploadImage(TenChuNha: TenChuNha, MaSoThueCN: MaSoThueCN, SDT: SDT, ChuTaiKhoan: ChuTaiKhoan, STK: STK, NganHang: NganHang, LoaiShop: LoaiShop, MaShop: MaShop, TenShop: TenShop, DiaChiShop: DiaChiShop, QuanHuyen: QuanHuyen, TinhTP: TinhTP, ViTriThucTe: ViTriThucTe, LoaiKyHD: LoaiKyHD, SoHD: SoHD, NgayNhanMB: NgayNhanMB, NgayTTTNha: NgayTTTNha, NgayKTHD: NgayKTHD, ThoiHanThue: ThoiHanThue, TienDatCoc: TienDatCoc, DonVi: DonVi, HTRutCoc: HTRutCoc, KyHanTT: KyHanTT, NgayBDTT: NgayBDTT, NgayThanhToan: NgayThanhToan, DienTich: DienTich, Thue: Thue, SoTienChiuThue: SoTienChiuThue, XMLGTThang: XMLGTThang,NgayBDHD:NgayBDHD)
                    }else{
                        let nc = NotificationCenter.default
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            let errorAlert = UIAlertController(title: "Thông báo", message: error, preferredStyle: .alert)
                            errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                                alert -> Void in
                                
                            }))
                            self.present(errorAlert, animated: true, completion: nil)
                        }
                    }
                }
            }else{
                let nc = NotificationCenter.default
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let errorAlert = UIAlertController(title: "Thông báo", message: "Xử lý hình lỗi, vui lòng chọn lại hình ảnh khác.", preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                        alert -> Void in
                        
                    }))
                    self.present(errorAlert, animated: true, completion: nil)
                }
            }
        }else{
            var stringURLs = ""
            for item in self.arrLink {
                if(stringURLs == ""){
                    stringURLs = item
                }else{
                    stringURLs = ",\(stringURLs)"
                }
            }
            MPOSAPIManager.sp_FRTCallLog_Web_CreateRequestPaymentHomeFromMobile(TenChuNha: TenChuNha, MaSoThueCN: MaSoThueCN, SDT: SDT, ChuTaiKhoan: ChuTaiKhoan, STK: STK, NganHang: NganHang, LoaiShop: LoaiShop, MaShop: MaShop, TenShop: TenShop, DiaChiShop: DiaChiShop, QuanHuyen: QuanHuyen, TinhTP: TinhTP, ViTriThucTe: ViTriThucTe, LoaiKyHD: LoaiKyHD, SoHD: SoHD, NgayNhanMB: NgayNhanMB, NgayTTTNha: NgayTTTNha, NgayKTHD: NgayKTHD, ThoiHanThue: ThoiHanThue, TienDatCoc: TienDatCoc, DonVi: DonVi, HTRutCoc: HTRutCoc, KyHanTT: KyHanTT, NgayBDTT: NgayBDTT, NgayThanhToan: NgayThanhToan, DienTich: DienTich, Thue: Thue, SoTienChiuThue: SoTienChiuThue, UrlImageHD: stringURLs, UrlImageMatTien: self.urlImageMT, XMLGTThang: XMLGTThang,NgayBDHD:NgayBDHD, MaPhongBan: "\(self.selectedPhongban?.value ?? "")", TenPhongBan: "\(self.selectedPhongban?.label ?? "")", CNNganHang: "\(self.tfChiNhanhBankText.text ?? "")") { (success, err) in
                let nc = NotificationCenter.default
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        let errorAlert = UIAlertController(title: "Thông báo", message: success, preferredStyle: .alert)
                        errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                            alert -> Void in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(errorAlert, animated: true, completion: nil)
                    }else{
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
    @objc func tapShowMore() {

        if(isShowAllImages){
            let underlineAttributeMore = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedMoreString = NSAttributedString(string: "Upload thêm", attributes: underlineAttributeMore)
            lbMoreImages.attributedText = underlineAttributedMoreString
            
            viewFooter.frame.origin.y = viewImage1.frame.size.height + viewImage1.frame.origin.y + Common.Size(s: 10)
        }else{
            let underlineAttributeMore = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedMoreString = NSAttributedString(string: "Ẩn upload thêm", attributes: underlineAttributeMore)
            lbMoreImages.attributedText = underlineAttributedMoreString
            viewFooter.frame.origin.y = viewImage10.frame.size.height + viewImage10.frame.origin.y + Common.Size(s: 10)
        }
        viewImages.frame.size.height = viewFooter.frame.size.height + viewFooter.frame.origin.y
        contractInfoView.frame.size.height = viewImages.frame.size.height + viewImages.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: contractInfoView.frame.size.height + contractInfoView.frame.origin.y + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        
        isShowAllImages = !isShowAllImages
    }
    @objc func tapShowImage(_ sender: UITapGestureRecognizer) {
        posImageUpload = sender.view!.tag
         self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowFacade() {
        posImageUpload = 11
         self.thisIsTheFunctionWeAreCalling()
    }
    @objc func detailPrice() {
        let vc = PriceOfMonthViewController()
        vc.delegate = self
        vc.items = self.priceItems
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func addPriceSuccess(items: [RequestPaymentTimePrice]) {
        self.priceItems = items
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func image(image:UIImage){
        imgUploadMT = image
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = imgViewFacade.frame.size.width / sca
        imgViewFacade.image = image
        imgViewFacade.frame.size.height = heightImage
        viewFacade.frame.size.height = imgViewFacade.frame.origin.y + imgViewFacade.frame.size.height
        viewImages.frame.origin.y = viewFacade.frame.origin.y + viewFacade.frame.size.height + Common.Size(s:10)
        contractInfoView.frame.size.height = viewImages.frame.size.height + viewImages.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: contractInfoView.frame.size.height + contractInfoView.frame.origin.y + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    func image1(image:UIImage){
        imgUpload1 = image
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = imgViewFacade.frame.size.width / sca
        imgViewImage1.image = image
        imgViewImage1.frame.size.height = heightImage
        viewImage1.frame.size.height = imgViewImage1.frame.origin.y + imgViewImage1.frame.size.height
        
        viewImage2.frame.origin.y = viewImage1.frame.size.height + viewImage1.frame.origin.y + Common.Size(s: 10)
        viewImage3.frame.origin.y = viewImage2.frame.size.height + viewImage2.frame.origin.y + Common.Size(s: 10)
        viewImage4.frame.origin.y = viewImage3.frame.size.height + viewImage3.frame.origin.y + Common.Size(s: 10)
        viewImage5.frame.origin.y = viewImage4.frame.size.height + viewImage4.frame.origin.y + Common.Size(s: 10)
        viewImage6.frame.origin.y = viewImage5.frame.size.height + viewImage5.frame.origin.y + Common.Size(s: 10)
        viewImage7.frame.origin.y = viewImage6.frame.size.height + viewImage6.frame.origin.y + Common.Size(s: 10)
        viewImage8.frame.origin.y = viewImage7.frame.size.height + viewImage7.frame.origin.y + Common.Size(s: 10)
        viewImage9.frame.origin.y = viewImage8.frame.size.height + viewImage8.frame.origin.y + Common.Size(s: 10)
        viewImage10.frame.origin.y = viewImage9.frame.size.height + viewImage9.frame.origin.y + Common.Size(s: 10)
        
        if(isShowAllImages){
            viewFooter.frame.origin.y = viewImage10.frame.size.height + viewImage10.frame.origin.y + Common.Size(s: 10)
        }else{
            viewFooter.frame.origin.y = viewImage1.frame.size.height + viewImage1.frame.origin.y + Common.Size(s: 10)
        }
        viewImages.frame.size.height = viewFooter.frame.size.height + viewFooter.frame.origin.y
        contractInfoView.frame.size.height = viewImages.frame.size.height + viewImages.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: contractInfoView.frame.size.height + contractInfoView.frame.origin.y + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    func image2(image:UIImage){
        imgUpload2 = image
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = imgViewFacade.frame.size.width / sca
        imgViewImage2.image = image
        imgViewImage2.frame.size.height = heightImage
        viewImage2.frame.size.height = imgViewImage2.frame.origin.y + imgViewImage2.frame.size.height
        
        viewImage3.frame.origin.y = viewImage2.frame.size.height + viewImage2.frame.origin.y + Common.Size(s: 10)
        viewImage4.frame.origin.y = viewImage3.frame.size.height + viewImage3.frame.origin.y + Common.Size(s: 10)
        viewImage5.frame.origin.y = viewImage4.frame.size.height + viewImage4.frame.origin.y + Common.Size(s: 10)
        viewImage6.frame.origin.y = viewImage5.frame.size.height + viewImage5.frame.origin.y + Common.Size(s: 10)
        viewImage7.frame.origin.y = viewImage6.frame.size.height + viewImage6.frame.origin.y + Common.Size(s: 10)
        viewImage8.frame.origin.y = viewImage7.frame.size.height + viewImage7.frame.origin.y + Common.Size(s: 10)
        viewImage9.frame.origin.y = viewImage8.frame.size.height + viewImage8.frame.origin.y + Common.Size(s: 10)
        viewImage10.frame.origin.y = viewImage9.frame.size.height + viewImage9.frame.origin.y + Common.Size(s: 10)
        
        if(isShowAllImages){
            viewFooter.frame.origin.y = viewImage10.frame.size.height + viewImage10.frame.origin.y + Common.Size(s: 10)
        }else{
            viewFooter.frame.origin.y = viewImage1.frame.size.height + viewImage1.frame.origin.y + Common.Size(s: 10)
        }
        viewImages.frame.size.height = viewFooter.frame.size.height + viewFooter.frame.origin.y
        contractInfoView.frame.size.height = viewImages.frame.size.height + viewImages.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: contractInfoView.frame.size.height + contractInfoView.frame.origin.y + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    func image3(image:UIImage){
        imgUpload3 = image
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = imgViewFacade.frame.size.width / sca
        imgViewImage3.image = image
        imgViewImage3.frame.size.height = heightImage
        viewImage3.frame.size.height = imgViewImage3.frame.origin.y + imgViewImage3.frame.size.height
        
        viewImage4.frame.origin.y = viewImage3.frame.size.height + viewImage3.frame.origin.y + Common.Size(s: 10)
        viewImage5.frame.origin.y = viewImage4.frame.size.height + viewImage4.frame.origin.y + Common.Size(s: 10)
        viewImage6.frame.origin.y = viewImage5.frame.size.height + viewImage5.frame.origin.y + Common.Size(s: 10)
        viewImage7.frame.origin.y = viewImage6.frame.size.height + viewImage6.frame.origin.y + Common.Size(s: 10)
        viewImage8.frame.origin.y = viewImage7.frame.size.height + viewImage7.frame.origin.y + Common.Size(s: 10)
        viewImage9.frame.origin.y = viewImage8.frame.size.height + viewImage8.frame.origin.y + Common.Size(s: 10)
        viewImage10.frame.origin.y = viewImage9.frame.size.height + viewImage9.frame.origin.y + Common.Size(s: 10)
        if(isShowAllImages){
            viewFooter.frame.origin.y = viewImage10.frame.size.height + viewImage10.frame.origin.y + Common.Size(s: 10)
        }else{
            viewFooter.frame.origin.y = viewImage1.frame.size.height + viewImage1.frame.origin.y + Common.Size(s: 10)
        }
        viewImages.frame.size.height = viewFooter.frame.size.height + viewFooter.frame.origin.y
        contractInfoView.frame.size.height = viewImages.frame.size.height + viewImages.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: contractInfoView.frame.size.height + contractInfoView.frame.origin.y + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    func image4(image:UIImage){
        imgUpload4 = image
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = imgViewFacade.frame.size.width / sca
        imgViewImage4.image = image
        imgViewImage4.frame.size.height = heightImage
        viewImage4.frame.size.height = imgViewImage4.frame.origin.y + imgViewImage4.frame.size.height
        
        viewImage5.frame.origin.y = viewImage4.frame.size.height + viewImage4.frame.origin.y + Common.Size(s: 10)
        viewImage6.frame.origin.y = viewImage5.frame.size.height + viewImage5.frame.origin.y + Common.Size(s: 10)
        viewImage7.frame.origin.y = viewImage6.frame.size.height + viewImage6.frame.origin.y + Common.Size(s: 10)
        viewImage8.frame.origin.y = viewImage7.frame.size.height + viewImage7.frame.origin.y + Common.Size(s: 10)
        viewImage9.frame.origin.y = viewImage8.frame.size.height + viewImage8.frame.origin.y + Common.Size(s: 10)
        viewImage10.frame.origin.y = viewImage9.frame.size.height + viewImage9.frame.origin.y + Common.Size(s: 10)
        if(isShowAllImages){
            viewFooter.frame.origin.y = viewImage10.frame.size.height + viewImage10.frame.origin.y + Common.Size(s: 10)
        }else{
            viewFooter.frame.origin.y = viewImage1.frame.size.height + viewImage1.frame.origin.y + Common.Size(s: 10)
        }
        viewImages.frame.size.height = viewFooter.frame.size.height + viewFooter.frame.origin.y
        contractInfoView.frame.size.height = viewImages.frame.size.height + viewImages.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: contractInfoView.frame.size.height + contractInfoView.frame.origin.y + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    func image5(image:UIImage){
        imgUpload5 = image
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = imgViewFacade.frame.size.width / sca
        imgViewImage5.image = image
        imgViewImage5.frame.size.height = heightImage
        viewImage5.frame.size.height = imgViewImage5.frame.origin.y + imgViewImage5.frame.size.height
        
        viewImage6.frame.origin.y = viewImage5.frame.size.height + viewImage5.frame.origin.y + Common.Size(s: 10)
        viewImage7.frame.origin.y = viewImage6.frame.size.height + viewImage6.frame.origin.y + Common.Size(s: 10)
        viewImage8.frame.origin.y = viewImage7.frame.size.height + viewImage7.frame.origin.y + Common.Size(s: 10)
        viewImage9.frame.origin.y = viewImage8.frame.size.height + viewImage8.frame.origin.y + Common.Size(s: 10)
        viewImage10.frame.origin.y = viewImage9.frame.size.height + viewImage9.frame.origin.y + Common.Size(s: 10)
        if(isShowAllImages){
            viewFooter.frame.origin.y = viewImage10.frame.size.height + viewImage10.frame.origin.y + Common.Size(s: 10)
        }else{
            viewFooter.frame.origin.y = viewImage1.frame.size.height + viewImage1.frame.origin.y + Common.Size(s: 10)
        }
        viewImages.frame.size.height = viewFooter.frame.size.height + viewFooter.frame.origin.y
        contractInfoView.frame.size.height = viewImages.frame.size.height + viewImages.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: contractInfoView.frame.size.height + contractInfoView.frame.origin.y + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    func image6(image:UIImage){
        imgUpload6 = image
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = imgViewFacade.frame.size.width / sca
        imgViewImage6.image = image
        imgViewImage6.frame.size.height = heightImage
        viewImage6.frame.size.height = imgViewImage6.frame.origin.y + imgViewImage6.frame.size.height
        
        viewImage7.frame.origin.y = viewImage6.frame.size.height + viewImage6.frame.origin.y + Common.Size(s: 10)
        viewImage8.frame.origin.y = viewImage7.frame.size.height + viewImage7.frame.origin.y + Common.Size(s: 10)
        viewImage9.frame.origin.y = viewImage8.frame.size.height + viewImage8.frame.origin.y + Common.Size(s: 10)
        viewImage10.frame.origin.y = viewImage9.frame.size.height + viewImage9.frame.origin.y + Common.Size(s: 10)
        if(isShowAllImages){
            viewFooter.frame.origin.y = viewImage10.frame.size.height + viewImage10.frame.origin.y + Common.Size(s: 10)
        }else{
            viewFooter.frame.origin.y = viewImage1.frame.size.height + viewImage1.frame.origin.y + Common.Size(s: 10)
        }
        viewImages.frame.size.height = viewFooter.frame.size.height + viewFooter.frame.origin.y
        contractInfoView.frame.size.height = viewImages.frame.size.height + viewImages.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: contractInfoView.frame.size.height + contractInfoView.frame.origin.y + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    func image7(image:UIImage){
        imgUpload7 = image
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = imgViewFacade.frame.size.width / sca
        imgViewImage7.image = image
        imgViewImage7.frame.size.height = heightImage
        viewImage7.frame.size.height = imgViewImage7.frame.origin.y + imgViewImage7.frame.size.height
        
        viewImage8.frame.origin.y = viewImage7.frame.size.height + viewImage7.frame.origin.y + Common.Size(s: 10)
        viewImage9.frame.origin.y = viewImage8.frame.size.height + viewImage8.frame.origin.y + Common.Size(s: 10)
        viewImage10.frame.origin.y = viewImage9.frame.size.height + viewImage9.frame.origin.y + Common.Size(s: 10)
        if(isShowAllImages){
            viewFooter.frame.origin.y = viewImage10.frame.size.height + viewImage10.frame.origin.y + Common.Size(s: 10)
        }else{
            viewFooter.frame.origin.y = viewImage1.frame.size.height + viewImage1.frame.origin.y + Common.Size(s: 10)
        }
        viewImages.frame.size.height = viewFooter.frame.size.height + viewFooter.frame.origin.y
        contractInfoView.frame.size.height = viewImages.frame.size.height + viewImages.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: contractInfoView.frame.size.height + contractInfoView.frame.origin.y + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    func image8(image:UIImage){
        imgUpload8 = image
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = imgViewFacade.frame.size.width / sca
        imgViewImage8.image = image
        imgViewImage8.frame.size.height = heightImage
        viewImage8.frame.size.height = imgViewImage8.frame.origin.y + imgViewImage8.frame.size.height
        
        viewImage9.frame.origin.y = viewImage8.frame.size.height + viewImage8.frame.origin.y + Common.Size(s: 10)
        viewImage10.frame.origin.y = viewImage9.frame.size.height + viewImage9.frame.origin.y + Common.Size(s: 10)
        if(isShowAllImages){
            viewFooter.frame.origin.y = viewImage10.frame.size.height + viewImage10.frame.origin.y + Common.Size(s: 10)
        }else{
            viewFooter.frame.origin.y = viewImage1.frame.size.height + viewImage1.frame.origin.y + Common.Size(s: 10)
        }
        viewImages.frame.size.height = viewFooter.frame.size.height + viewFooter.frame.origin.y
        contractInfoView.frame.size.height = viewImages.frame.size.height + viewImages.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: contractInfoView.frame.size.height + contractInfoView.frame.origin.y + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    func image9(image:UIImage){
        imgUpload9 = image
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = imgViewFacade.frame.size.width / sca
        imgViewImage9.image = image
        imgViewImage9.frame.size.height = heightImage
        viewImage9.frame.size.height = imgViewImage9.frame.origin.y + imgViewImage9.frame.size.height
        
        viewImage10.frame.origin.y = viewImage9.frame.size.height + viewImage9.frame.origin.y + Common.Size(s: 10)
        if(isShowAllImages){
            viewFooter.frame.origin.y = viewImage10.frame.size.height + viewImage10.frame.origin.y + Common.Size(s: 10)
        }else{
            viewFooter.frame.origin.y = viewImage1.frame.size.height + viewImage1.frame.origin.y + Common.Size(s: 10)
        }
        viewImages.frame.size.height = viewFooter.frame.size.height + viewFooter.frame.origin.y
        contractInfoView.frame.size.height = viewImages.frame.size.height + viewImages.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: contractInfoView.frame.size.height + contractInfoView.frame.origin.y + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    func image10(image:UIImage){
        imgUpload10 = image
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = imgViewFacade.frame.size.width / sca
        imgViewImage10.image = image
        imgViewImage10.frame.size.height = heightImage
        viewImage10.frame.size.height = imgViewImage10.frame.origin.y + imgViewImage10.frame.size.height
        
        if(isShowAllImages){
            viewFooter.frame.origin.y = viewImage10.frame.size.height + viewImage10.frame.origin.y + Common.Size(s: 10)
        }else{
            viewFooter.frame.origin.y = viewImage1.frame.size.height + viewImage1.frame.origin.y + Common.Size(s: 10)
        }
        viewImages.frame.size.height = viewFooter.frame.size.height + viewFooter.frame.origin.y
        contractInfoView.frame.size.height = viewImages.frame.size.height + viewImages.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: contractInfoView.frame.size.height + contractInfoView.frame.origin.y + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    
}
extension TenancyViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
        let alert = UIAlertController(title: "Chọn hình ảnh", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Chụp ảnh", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Thư viện", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Huỷ", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            //            alert.popoverPresentationController?.sourceView = sender
            //            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        self.present(alert, animated: true, completion: nil)
    }
    //MARK: - Open the camera
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Choose image from camera roll
    
    func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        // image is our desired image
        if (self.posImageUpload == 1){
            self.image1(image: image)
        }else if (self.posImageUpload == 2){
            self.image2(image: image)
        } else if (self.posImageUpload == 3){
            self.image3(image: image)
        }else if (self.posImageUpload == 4){
            self.image4(image: image)
        }else if (self.posImageUpload == 5){
            self.image5(image: image)
        }else if (self.posImageUpload == 6){
            self.image6(image: image)
        }else if (self.posImageUpload == 7){
            self.image7(image: image)
        }else if (self.posImageUpload == 8){
            self.image8(image: image)
        }else if (self.posImageUpload == 9){
            self.image9(image: image)
        }else if (self.posImageUpload == 10){
            self.image10(image: image)
        }else if (self.posImageUpload == 11){
            self.image(image: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
