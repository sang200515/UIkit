//
//  BaoHiemMainViewController.swift
//  mPOS
//
//  Created by sumi on 7/23/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import DLRadioButton
import DropDown
import PopupDialog
import NVActivityIndicatorView

class BaoHiemMainViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource,ItemSearchNameKHTableViewCellDelegate,UITextFieldDelegate {
    func clickFromTableView(sender: ItemSearchNameKHTableViewCellDelegate, iIndex: Int) {
        mCardTypeArr.removeAll()
        mCardTypeArr.append(arrCardTypeFromPOS[iIndex])
        self.mViewPayCardPercent.isHidden = true
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = false
    }
    
    var mSoPhieuThu:String = ""
    var loading:NVActivityIndicatorView!
    var loadingView:UIView!
    var btnDone:UIButton!
    var mLoaiToken:String = "1"
    
    var mCardTypeArr = [CardTypeFromPOSResult]()
    var mViewPayCardPercent:ThuHoSearchView!
    var mBuyMoreChecked:Bool = false
    var mMoneyChecked:Bool = false
    var mCreditChecked:Bool = false
    var arrGetSP = [BaoHiem_getSPResult]()
    var arrHangXe = [BaoHiem_getHangXeResult]()
    var arrGetLoaiXe = [BaoHiem_getLoaiXeResult]()
    var arrGetPhuongXa = [BaoHiem_getPhuongXaResult]()
    var arrGetQuan = [BaoHiem_getQuanHuyenResult]()
    var arrGetTinhThanh = [BaoHiem_getTinhThanhResult]()
    var arrGetDungTich = [BaoHiem_getDungTichResult]()
    var imageCheck:UIImageView!
    var edtTenChuXe:UITextField!
    var txtTitle:UILabel!
    var scrollView:UIScrollView!
    
    var edtSDT:UITextField!
    var edtDiaChi:UITextField!
    
    var tinhThanhButton: UIButton!
    let hangxeDropDown = DropDown()
    let spDropDown = DropDown()
    let tinhThanhDropDown = DropDown()
    let loaixeDropDown = DropDown()
    let dungtichDropDown = DropDown()
    var quanButton:UIButton!
    var quanDropDown = DropDown()
    let phuongxaDropDown = DropDown()
    var phuongxaButton:UIButton!
    
    var LoaiXeButton:UIButton!
    var DungTichButton:UIButton!
    
    var edtBienSo:UITextField!
    var hangXeButton:UIButton!
    var spButton:UIButton!
    
    var edtNgayBatDau:UITextField!
    var edtNgayKetThuc:UITextField!
    
    var edtPhiBH:UITextField!
    var edtPhiBHTrenXe:UITextField!
    var edtTongTienThu:UITextField!
    var imageCheckTienMat:UIImageView!
    var imageCheckThe:UIImageView!
    var edtTienMat:UITextField!
    var edtTienThe:UITextField!
    var edtTienTong:UITextField!
    
    
    //////data
    var mMaTinh:String = ""
    var mMaHuyen:String = ""
    var mMaLoaiXe:String = ""
    var mMaQuan:String = ""
    var mMaPhuongXa:String = ""
    var mMaDungTich:String = ""
    var mMaHangXe:String = ""
    var mSanPham:String = ""
    var arrCardTypeFromPOS = [CardTypeFromPOSResult]()
    var mLoaiThanhToan:String = "0"
    var tfTenNguoiNhan:UITextField!
    var tfSDTNguoiNhan:UITextField!
    var isPromotionFRT:Bool = false
    var imageCheckPromotionFRT:UIImageView!
    var giaTong:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        intitView()
        AddTheView()
        GetDataTinhThanh(usercode: "\(Cache.user!.UserName)",shopcode:"\(Cache.user!.ShopCode)")
        GetDataLoaiXe(usercode: "\(Cache.user!.UserName)",shopcode:"\(Cache.user!.ShopCode)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.text != "")
        {
            let intMCosTotalt:Int = Int(edtTienTong.text!)!
            if(textField == edtTienMat )
            {
                if(mMoneyChecked == true)
                {
                    let iInputCost:Int = Int(textField.text!)!
                    if(iInputCost > intMCosTotalt)
                    {
                        edtTienMat.text = "\(edtTienTong.text!)"
                        edtTienThe.text = "0"
                    }
                    if(iInputCost < intMCosTotalt)
                    {
                        if(mCreditChecked == true)
                        {
                            let iLessCost:Int = intMCosTotalt - Int(edtTienMat.text!)!
                            edtTienThe.text = "\(iLessCost)"
                        }
                        else
                        {
                            edtTienMat.text = "\(edtTienTong.text!)"
                            edtTienThe.text = "0"
                        }
                        
                        
                    }
                    if(iInputCost == intMCosTotalt)
                    {
                        edtTienMat.text = "\(edtTienTong.text!)"
                        edtTienThe.text = "0"
                        
                    }
                    
                }
                
                
            }
            if(textField == edtTienThe )
            {
                if(mCreditChecked == true)
                {
                    let iInputCost:Int = Int(textField.text!)!
                    if(iInputCost > intMCosTotalt)
                    {
                        edtTienThe.text = "\(edtTienTong.text!)"
                        edtTienMat.text = "0"
                    }
                    if(iInputCost < intMCosTotalt)
                    {
                        if(mCreditChecked == true)
                        {
                            let iLessCost:Int = intMCosTotalt - Int(edtTienThe.text!)!
                            edtTienMat.text = "\(iLessCost)"
                        }
                        else
                        {
                            edtTienThe.text = "\(edtTienTong.text!)"
                            edtTienMat.text = "0"
                        }
                        
                    }
                    if(iInputCost == intMCosTotalt)
                    {
                        edtTienThe.text = "\(edtTienTong.text!)"
                        edtTienMat.text = "0"
                        
                    }
                    
                }
                
            }
            
        }
        
        
        
    }
    
    
    func AddTheView()
    {
        mViewPayCardPercent = ThuHoSearchView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.view.addSubview(mViewPayCardPercent)
        
        self.mViewPayCardPercent.tableViewSearchTenKH.register(ItemSearchNameKHTableViewCell.self, forCellReuseIdentifier: "ItemSearchNameKHTableViewCell")
        self.mViewPayCardPercent.tableViewSearchTenKH.dataSource = self
        self.mViewPayCardPercent.tableViewSearchTenKH.delegate = self
        mViewPayCardPercent.isHidden = true
        
        getDataCardTypeToGetPercent()
    }
    
    
    func GetDataHangXe(usercode:String,shopcode:String,mMaLoaiXe:String)
    {
        MPOSAPIManager.BaoHiem_GetHangXe(usercode: "\(usercode)", shopcode: "\(shopcode)", maloaixe: "\(mMaLoaiXe)") { (results, err) in
            if(results.count > 0)
            {
                self.arrHangXe = results
                self.SetUpDropDownHangXe()
                self.hangXeButton.setTitle("\(results[0].HangXeName)", for: .normal)
            }
        }
    }
    func getDataCardTypeToGetPercent()
    {
        MPOSAPIManager.Get_CardType_From_POS { (result, err) in
            if(result.count > 0)
            {
                self.arrCardTypeFromPOS = result
                self.mViewPayCardPercent.tableViewSearchTenKH.reloadData()
            }
        }
    }
    func GetDataLoaiXe(usercode:String,shopcode:String)
    {
        MPOSAPIManager.BaoHiem_GetLoaiXe(usercode: "\(usercode)", shopcode: "\(shopcode)") { (result, err) in
            if(result.count > 0)
            {
                self.arrGetLoaiXe = result
                self.SetUpDropDownLoaiXe()
                self.LoaiXeButton.setTitle("\(result[0].LoaiHinhName)", for: .normal)
                self.mMaLoaiXe = "\(result[0].LoaiHinhCode)"
                self.GetDataSP(usercode: "\(Cache.user!.UserName)",shopcode:"\(Cache.user!.ShopCode)",maloaixe:"\(result[0].LoaiHinhCode)")
                self.GetDataDungTich(usercode: "\(Cache.user!.UserName)",shopcode:"\(Cache.user!.ShopCode)",maloaixe:"\(result[0].LoaiHinhCode)")
                self.GetDataHangXe(usercode: "\(Cache.user!.UserName)",shopcode:"\(Cache.user!.ShopCode)", mMaLoaiXe: "\(result[0].LoaiHinhCode)")
                if(result[0].LoaiHinhCode == "CTPL_MOBI")
                {
                    self.mBuyMoreChecked = true
                    self.imageCheck.image = #imageLiteral(resourceName: "iconcheck")
                    self.imageCheck.isUserInteractionEnabled = false
                    self.mBuyMoreChecked = true
                    self.mLoaiToken = "2"
                    
                }
                if(result[0].LoaiHinhCode  == "CTPL_MONO")
                {
                    self.mBuyMoreChecked = true
                    self.imageCheck.image = #imageLiteral(resourceName: "iconcheck")
                    self.imageCheck.isUserInteractionEnabled = true
                    self.mLoaiToken = "2"
                    self.mBuyMoreChecked = true
                }
            }
        }
    }
    
    func GetDataSP(usercode:String,shopcode:String,maloaixe:String)
    {
        MPOSAPIManager.BaoHiem_GetSP(usercode: "\(usercode)"
        , shopcode: "\(shopcode)", maloaixe: "\(maloaixe)") { (result, err) in
            
            if(result.count > 0)
            {
                self.arrGetSP = result
                self.SetUpDropDownSP()
                self.spButton.setTitle("\(result[0].SanPhamName)", for: .normal)
                self.mSanPham = result[0].SanPhamCode
            }
        }
        
    }
    ///////
    
    func GetDataPhuongXa(usercode:String,shopcode:String,matinh:String,mahuyen:String)
    {
        MPOSAPIManager.BaoHiem_GetPhuongXa(usercode:"\(usercode)",shopcode:"\(shopcode)",matinh:"\(matinh)",mahuyen:"\(mahuyen)") { (result, err) in
            if(result.count > 0)
            {
                print("BaoHiem_getPhuongXaResult sucess")
                self.arrGetPhuongXa = result
                self.mMaHuyen = "\(result[0].PhuongXaCode)"
                self.mMaPhuongXa = "\(result[0].PhuongXaCode)"
                self.SetUpDropDownPhuongXa()
                self.phuongxaButton.setTitle("\(result[0].PhuongXaName)", for: .normal)
            }
        }
    }
    
    
    
    func GetDataQuan(usercode:String,shopcode:String,matinh:String)
    {
        MPOSAPIManager.BaoHiem_GetQuan(usercode:"\(usercode)",shopcode:"\(shopcode)",matinh:"\(matinh)") { (result, err) in
            if(result.count > 0)
            {
                print("BaoHiem_GetTinhThanh sucess")
                self.arrGetQuan = result
                self.SetUpDropDownQuan()
                self.quanButton.setTitle("\(result[0].QuanHuyenName)", for: .normal)
                self.mMaQuan = "\(result[0].QuanHuyenCode)"
                
                self.GetDataPhuongXa(usercode:"\(Cache.user!.UserName)",shopcode:"\(Cache.user!.ShopCode)",matinh:"\(self.mMaTinh)",mahuyen: "\(result[0].QuanHuyenCode)")
            }
        }
    }
    
    func GetDataDungTich(usercode:String,shopcode:String,maloaixe:String)
    {
        MPOSAPIManager.BaoHiem_GetDungTich(usercode:"\(usercode)",shopcode:"\(shopcode)",maloaixe:"\(maloaixe)") { (result, err) in
            if(result.count > 0)
            {
                print("BaoHiem_getDungTichResult sucess")
                self.arrGetDungTich = result
                self.SetUpDropDownDungTich()
                self.DungTichButton.setTitle("\(result[0].DoiTuongName)", for: .normal)
                
                self.GetGiaBan_BHX(usercode: "\(Cache.user!.UserName)",shopcode:"\(Cache.user!.ShopCode)",maloaihinh:"\(self.mMaLoaiXe)",madoituong:"\(result[0].DoiTuongCode)",loai:"\(self.mLoaiToken)")
            }
        }
    }
    
    
    func GetGiaBan_BHX(usercode:String,shopcode:String,maloaihinh:String,madoituong:String,loai:String)
    {
        
        MPOSAPIManager.BaoHiem_getGiaBan_BHX(usercode:"\(usercode)",shopcode:"\(shopcode)",maloaihinh:"\(maloaihinh)",madoituong:"\(madoituong)",loai:"\(loai)") { (result, err) in
            if(result.count > 0)
            {
                print("BaoHiem_getGiaBanResult sucess")
                if(self.isPromotionFRT == true){
                    self.edtPhiBH.text =  "\(result[0].GiaBHXeMay)"
                    self.edtPhiBHTrenXe.text = "\(result[0].GiaBHNgoiSau)"
                    self.edtTongTienThu.text = "\(result[0].GiaFRT)"
                    self.edtTienTong.text =  "\(result[0].GiaFRT)"
                    self.giaTong = result[0].GiaTong
                }else{
                    self.edtPhiBH.text =  "\(result[0].GiaBHXeMay)"
                    self.edtPhiBHTrenXe.text = "\(result[0].GiaBHNgoiSau)"
                    self.edtTongTienThu.text = "\(result[0].GiaTong)"
                    self.edtTienTong.text =  "\(result[0].GiaTong)"
                       self.giaTong = result[0].GiaTong
                }
                
                
            }
        }
    }
    
    
    func GenPrintObject(mMaVoucher:String,mHanSuDung:String)->BaoHiem_PrintObject
    {
        let mObject = BaoHiem_PrintObject(DiaChiShop:"\((Cache.user?.ShopName)!)", SoPhieuThu: "\(mSoPhieuThu)", DichVu:"Bảo hiểm xe cơ giới", NhaBaoHiem:"", TenChuXe: "\(edtTenChuXe.text!)", SoDienThoaiKH:"\(edtSDT.text!)", DiaChiKH:"\(edtDiaChi.text!)", LoaiXe:"\(LoaiXeButton.title(for: .normal)!)", DungTich:"\(DungTichButton.title(for: .normal)!)", BienSo:"\(edtBienSo.text!)", NgayBatDau:"\(edtNgayBatDau.text!)", NgayKetThuc:"\(edtNgayKetThuc.text!)", GiaBHTDNS:"\(self.edtPhiBH.text!)", GiaBHTaiNan:"\(self.edtPhiBHTrenXe.text!)", TongTien:"\(edtTongTienThu.text!)", nhanVien:"\(Cache.user!.UserName)",MaVoucher : "\(mMaVoucher)" ,HanSuDung :"\(mHanSuDung)")
        return mObject
    }
    
    func GetGiaBan_getGiaBanAll_BHX(usercode:String,shopcode:String)
    {
        MPOSAPIManager.BaoHiem_getGiaBanAll_BHX(usercode:"\(usercode)",shopcode:"\(shopcode)") { (result, err) in
            if(result.count > 0)
            {
                print("BaoHiem_getGiaBanAllResult sucess")
                
            }
        }
    }
    
    
    
    
    func GetDataGetToken(Loai:String)
    {
        MPOSAPIManager.BaoHiem_GetToken(Loai: "\(Loai)") { (result, err) in
            if(result != nil)
            {
                self.ProcessPayMent(mToken: "\(result!.Code)")
                
            }
        }
    }
    
    
    func ProcessPayMent(mToken:String)
    {
        
        if(edtTienThe.text != "" && edtTienThe.text != "0")
        {
            mLoaiThanhToan = "2"
        }
        else
        {
            mLoaiThanhToan = "1"
        }
        
        let mUserCodeAPI:String = "\((Cache.user?.UserName)!)"
        let mShopCodeAPI:String = "\((Cache.user?.ShopCode)!)"
        
        let _ : UserDefaults = UserDefaults.standard
        let mCodeCRMAPI = UserDefaults.standard.string(forKey: "CRMCode")!
        
        let mVersionAPI:String = "\(Common.versionApp())"
        let mDeviceTypeAPI:String = "2"
        //default
        let mLoaiAPI:String = "3"
        let mThanhToanXML:String = "<BankAccountName></BankAccountName><BankCode>TPBank</BankCode><BankAccountNumber></BankAccountNumber>"
        let mListPaymentAPI:String = "<CardType></CardType><CardPM></CardPM><CCardNum></CCardNum><CardAmount>\(edtTienThe.text!)</CardAmount><CashAmount>\(edtTienMat.text!)</CashAmount>"
        let mTotalPaymentCashAPI:String = "\((self.edtTienThe.text)!)"
        let mLoaiThanhToanAPI:String = "\(mLoaiThanhToan)"
        let mQuantityAPI:String = "1"
        let mTokenAPI:String = "\(mToken)"
        let mSaleCodeAPI:String = "\((Cache.user?.UserName)!)"
        let mOwnerNameAPI:String = "\((self.edtTenChuXe.text)!)"
        let mOwnerIDAPI:String = ""
        let mOwnerAddrAPI:String = "\((self.edtDiaChi.text)!)"
        let mOwnerSDTAPI:String = "\((self.edtSDT.text)!)"
        let mOwnerPlateAPI:String = "\((self.edtBienSo.text)!)"
        let mOwnerChassisAPI:String = ""
        let mOwnerEngineAPI:String = ""
        let mBrandAPI:String = "\(mMaHangXe)"
        let mModelAPI:String = ""
        let mAddonAPI:String = "\(mBuyMoreChecked)"
        let mEffectFromAPI:String = "\((self.edtNgayBatDau.text)!)"
        let mEffectToAPI:String = "\((self.edtNgayKetThuc.text)!)"
        let mBuyerNameAPI:String = "\((self.edtTenChuXe.text)!)"
        let mBuyerAddrAPI:String = "\((self.edtDiaChi.text)!)"
        let mBuyerSDTAPI:String = "\((self.edtSDT.text)!)"
        let mCityCodeAPI:String = "\((self.mMaTinh))"
        let mDistrictCodeAPI:String = "\((self.mMaQuan))"
        let mWardCodeAPI:String = "\((self.mMaHuyen))"
        let mMotorTypeAPI:String = "\(mMaLoaiXe)"
        let mMotorObjectAPI:String = "\(mMaDungTich)"
        let mInsuranceCodeAPI:String = "\(mSanPham)"
        let mPremiumAPI:String = "\((self.edtPhiBH.text)!)"
        //let mTotalAPI:String = "\((self.edtTienTong.text)!)"
        let mTotalAPI:String = "\(self.giaTong)"
        ///default
        let mPaymentStatusAPI:String = "1"
        let mIsAutoCard:String = ""
        var isDiscountByFRT:String = ""
        if(self.isPromotionFRT == true){
            isDiscountByFRT = "1"
        }else{
            isDiscountByFRT = "0"
        }
        GetDataBaoHiem_AddOrder(userCode:mUserCodeAPI,shopCode:mShopCodeAPI,codeCrm:mCodeCRMAPI,version:mVersionAPI,deviceType:mDeviceTypeAPI,Loai:mLoaiAPI,ThanhToanXML:mThanhToanXML,ListPaymentMethodCard:mListPaymentAPI,TotalPaymentCash:mTotalPaymentCashAPI,LoaiThanhToan:mLoaiThanhToanAPI,Quantity:mQuantityAPI,Token:mTokenAPI,sale_code:mSaleCodeAPI,motor_owner_name:mOwnerNameAPI,motor_owner_id:mOwnerIDAPI,motor_owner_add:mOwnerAddrAPI,motor_owner_mobile:mOwnerSDTAPI,motor_num_plate:mOwnerPlateAPI,motor_num_chassis:mOwnerChassisAPI,motor_num_engine:mOwnerEngineAPI,motor_color:mBrandAPI,motor_brand:mBrandAPI,motor_model:mModelAPI,insurance_motor_addon_pa:mAddonAPI,insurance_effect_from:mEffectFromAPI,insurance_effect_to:mEffectToAPI,buyer_name:mBuyerNameAPI,buyer_add:mBuyerAddrAPI,buyer_mobile:mBuyerSDTAPI,city_code:mCityCodeAPI,District_code:mDistrictCodeAPI,ward_code:mWardCodeAPI,insurance_motor_type:mMotorTypeAPI,insurance_motor_object:mMotorObjectAPI,insurance_code:mInsuranceCodeAPI,premium_main_motor_ctpl:mPremiumAPI,premium_total:mTotalAPI,Payment_Status:mPaymentStatusAPI,IsAutoCard:mIsAutoCard,ReceiverName:"\(self.tfTenNguoiNhan.text!)",ReceiverPhone:"\(self.tfSDTNguoiNhan.text!)",isDiscountByFRT:isDiscountByFRT)
    }
    
    
    func CheckDatePayment()->Bool
    {
        var mChecked:Bool = true
        if(self.edtTienThe.text == "" || self.edtTenChuXe.text == ""
            || self.edtDiaChi.text == "" || self.edtSDT.text == ""
            || self.edtBienSo.text == "" || mMaHangXe == ""
            || self.edtNgayBatDau.text == "" || self.edtNgayKetThuc.text == "" || self.edtTenChuXe.text == ""
            || self.edtDiaChi.text == "" || self.edtSDT.text == "" || self.mMaTinh == "" || self.mMaQuan == ""
            || self.mMaHuyen == "" || mMaLoaiXe == "" || mMaDungTich == "" || mSanPham == ""
            || self.edtPhiBH.text == "" || self.edtTienTong.text == "" || self.tfTenNguoiNhan.text! == "" || self.tfSDTNguoiNhan.text! == "")
        {
            mChecked = false
        }
        
        if (edtSDT.text!.hasPrefix("01") && edtSDT.text!.count == 11){
            
        }else if (edtSDT.text!.hasPrefix("0") && !edtSDT.text!.hasPrefix("01") && edtSDT.text!.count == 10){
            
        }else{
            self.showDialog(message: "Số điện thoại không hợp lệ!")
            mChecked = false
        }
        
        
        
        if((Int(edtTienThe.text!)!) + (Int(edtTienMat.text!)!) != Int(edtTienTong.text!))
        {
            self.showDialog(message: "Tổng tiền mặt và tiền thẻ phải bằng tổng tiền thanh toán !!!!")
            mChecked = false
        }
        return mChecked
        
    }
    
    
    @objc func ClickDone()
    {
        self.btnDone.isHidden = true
        if (!checkDate(stringDate: self.edtNgayBatDau.text!)){
            
            let alert = UIAlertController(title: "Thông báo", message: "Ngày tháng bắt đầu hiệu lực không đúng định dạng !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.edtNgayBatDau.becomeFirstResponder()
                 self.btnDone.isHidden = false
            })
            self.present(alert, animated: true)
            return
        }
        if(self.edtTienMat.text == "" && self.mMoneyChecked == true)
        {
            self.showDialog(message: "Bạn đang chọn tiền mặt, vui lòng nhập số tiền")
            self.btnDone.isHidden = false
            return
        }
        if(self.edtTienThe.text == "" && self.mCreditChecked == true)
        {
            self.showDialog(message: "Bạn đang chọn thẻ, vui lòng nhập số tiền")
            self.btnDone.isHidden = false
            return
        }
        
        let mCheck:Bool = CheckDatePayment()
        if(mCheck == false)
        {
            self.showDialog(message: "Vui lòng nhập đầy đủ thông tin")
            self.btnDone.isHidden = false
        }
        else
        {
            self.GetDataGetToken(Loai: "\(mLoaiToken)")
            self.btnDone.isHidden = true
        }
        
    }
    
    @objc func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
    
    func GetDataBaoHiem_AddOrder(userCode:String,shopCode:String,codeCrm:String,version:String,deviceType:String,Loai:String,ThanhToanXML:String,ListPaymentMethodCard:String,TotalPaymentCash:String,LoaiThanhToan:String,Quantity:String,Token:String,sale_code:String,motor_owner_name:String,motor_owner_id:String,motor_owner_add:String,motor_owner_mobile:String,motor_num_plate:String,motor_num_chassis:String,motor_num_engine:String,motor_color:String,motor_brand:String,motor_model:String,insurance_motor_addon_pa:String,insurance_effect_from:String,insurance_effect_to:String,buyer_name:String,buyer_add:String,buyer_mobile:String,city_code:String,District_code:String,ward_code:String,insurance_motor_type:String,insurance_motor_object:String,insurance_code:String,premium_main_motor_ctpl:String,premium_total:String,Payment_Status:String,IsAutoCard:String,ReceiverName:String,ReceiverPhone:String,isDiscountByFRT:String)
    {
        loadingView.isHidden = false
        
        MPOSAPIManager.BaoHiem_AddOrder(userCode:userCode,shopCode:shopCode,codeCrm:codeCrm,version:version,deviceType:deviceType,Loai:Loai,ThanhToanXML:ThanhToanXML,ListPaymentMethodCard:ListPaymentMethodCard,TotalPaymentCash:TotalPaymentCash,LoaiThanhToan:LoaiThanhToan,Quantity:Quantity,Token:Token,sale_code:sale_code,motor_owner_name:motor_owner_name,motor_owner_id:motor_owner_id,motor_owner_add:motor_owner_add,motor_owner_mobile:motor_owner_mobile,motor_num_plate:motor_num_plate,motor_num_chassis:motor_num_chassis,motor_num_engine:motor_num_engine,motor_color:motor_color,motor_brand:motor_brand,motor_model:motor_model,insurance_motor_addon_pa:insurance_motor_addon_pa,insurance_effect_from:insurance_effect_from,insurance_effect_to:insurance_effect_to,buyer_name:buyer_name,buyer_add:buyer_add,buyer_mobile:buyer_mobile,city_code:city_code,District_code:District_code,ward_code:ward_code,insurance_motor_type:insurance_motor_type,insurance_motor_object:insurance_motor_object,insurance_code:insurance_code,premium_main_motor_ctpl:premium_main_motor_ctpl,premium_total:premium_total,Payment_Status:Payment_Status, IsAutoCard: IsAutoCard,ReceiverName:ReceiverName,ReceiverPhone:ReceiverPhone,isDiscountByFRT:isDiscountByFRT) { (result: BaoHiem_addOrderResult!,resultBody: BaoHiem_addOrderBodyResult!, err) in
            if(result != nil)
            {
                if(result.IDDonHangFRT != "0")
                {
                    self.loadingView.isHidden = true
                    if(result.ResultFRT == "02")
                    {
                        self.mSoPhieuThu = "\(result.EcomCode)"
                        let mObject = self.GenPrintObject(mMaVoucher: "\((resultBody.Voucher))",mHanSuDung: "\((resultBody.NgayKetThucHLVC))")
                        let newViewController = BaoHiemThanhToanThanhCongViewController()
                        newViewController.mSoHopDong = "\((result.EcomCode))"
                        newViewController.mLoaiGD = "Bảo hiểm xe cơ giới"
                        newViewController.mNCC = "Nha CC"
                        newViewController.mSoPos = "\((result.EcomCode))"
                        newViewController.mTenKH = "\((self.edtTenChuXe.text)!)"
                        newViewController.mSoDT = "\((self.edtSDT.text)!)"
                        newViewController.mTienMat = "\((self.edtTienMat.text)!)"
                        newViewController.mTienThe = "\((self.edtTienThe.text)!)"
                        newViewController.mPhiCaThe = "0"
                        newViewController.mObjectPrint = mObject
                        
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }
                    else
                    {
                         self.loadingView.isHidden = true
                        self.btnDone.isHidden = false
                        let title = "Có lỗi xảy ra"
                        let message = "\(resultBody.Message)"
                        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
                        }
                        let buttonOne = DefaultButton(title: "OK") {
                            popup.dismiss();
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
                else
                {
                     self.loadingView.isHidden = true
                    self.btnDone.isHidden = false
                    let title = "Có lỗi xảy ra"
                    let message = "\(result.MSGFRT)"
                    let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
                    }
                    let buttonOne = DefaultButton(title: "OK") {
                        popup.dismiss();
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
                
                
                
            }
        }
        
    }
    
    func GetDataTinhThanh(usercode:String,shopcode:String)
    {
        MPOSAPIManager.BaoHiem_GetTinhThanh(usercode:"\(usercode)",shopcode:"\(shopcode)") { (result, err) in
            if(result.count > 0)
            {
                self.arrGetTinhThanh = result
                self.SetUpDropDownTinhThanh()
                self.tinhThanhButton.setTitle("\(result[0].TinhThanhName)", for: .normal)
                self.mMaTinh = result[0].TinhThanhCode
                
                self.GetDataQuan(usercode:"\(Cache.user!.UserName)",shopcode:"\(Cache.user!.ShopCode)",matinh:"\(result[0].TinhThanhCode)")
            }
        }
    }
    func SetUpDropDownLoaiXe()
    {
        var mLoaiXe:[String] = []
        for i in arrGetLoaiXe {
            mLoaiXe.append(i.LoaiHinhName)
        }
        
        loaixeDropDown.anchorView = LoaiXeButton
        loaixeDropDown.bottomOffset = CGPoint(x: 0, y: tinhThanhButton.bounds.height)
        loaixeDropDown.dataSource = mLoaiXe
        loaixeDropDown.selectionAction = { [unowned self] (index, item) in
            self.LoaiXeButton.setTitle(item, for: .normal)
            
            self.mMaLoaiXe = self.arrGetLoaiXe[index].LoaiHinhCode
            self.GetDataSP(usercode: "\(Cache.user!.UserName)",shopcode:"\(Cache.user!.ShopCode)",maloaixe:"\(self.arrGetLoaiXe[index].LoaiHinhCode)")
            self.GetDataDungTich(usercode: "\(Cache.user!.UserName)",shopcode:"\(Cache.user!.ShopCode)",maloaixe:"\(self.arrGetLoaiXe[index].LoaiHinhCode)")
            print("chon \(index)")
            self.GetDataHangXe(usercode: "\(Cache.user!.UserName)",shopcode:"\(Cache.user!.ShopCode)", mMaLoaiXe: "\(self.arrGetLoaiXe[index].LoaiHinhCode)")
            
            if(self.arrGetLoaiXe[index].LoaiHinhCode == "CTPL_MOBI")
            {
                self.mBuyMoreChecked = true
                self.imageCheck.image = #imageLiteral(resourceName: "iconcheck")
                self.imageCheck.isUserInteractionEnabled = false
                self.mBuyMoreChecked = true
                self.mLoaiToken = "2"
            }
            if(self.arrGetLoaiXe[index].LoaiHinhCode == "CTPL_MONO")
            {
                self.mBuyMoreChecked = true
                self.imageCheck.isUserInteractionEnabled = true
                self.imageCheck.image = #imageLiteral(resourceName: "iconcheck")
                self.mBuyMoreChecked = true
                self.mLoaiToken = "2"
            }
            
        }
    }
    
    
    func SetUpDropDownPhuongXa()
    {
        var mPhuong:[String] = []
        for i in arrGetPhuongXa {
            mPhuong.append(i.PhuongXaName)
        }
        
        phuongxaDropDown.anchorView = phuongxaButton
        phuongxaDropDown.bottomOffset = CGPoint(x: 0, y: tinhThanhButton.bounds.height)
        phuongxaDropDown.dataSource = mPhuong
        phuongxaDropDown.selectionAction = { [unowned self] (index, item) in
            self.phuongxaButton.setTitle(item, for: .normal)
            print("chon \(index)")
            self.mMaHuyen = self.arrGetPhuongXa[index].PhuongXaCode
            self.mMaPhuongXa = self.arrGetPhuongXa[index].PhuongXaCode
        }
    }
    
    
    func SetUpDropDownTinhThanh()
    {
        var mTinhThanh:[String] = []
        for i in arrGetTinhThanh {
            mTinhThanh.append(i.TinhThanhName)
        }
        
        tinhThanhDropDown.anchorView = tinhThanhButton
        tinhThanhDropDown.bottomOffset = CGPoint(x: 0, y: tinhThanhButton.bounds.height)
        tinhThanhDropDown.dataSource = mTinhThanh
        tinhThanhDropDown.selectionAction = { [unowned self] (index, item) in
            self.tinhThanhButton.setTitle(item, for: .normal)
            print("chon \(index)")
            self.GetDataQuan(usercode:"\(Cache.user!.UserName)",shopcode:"\(Cache.user!.ShopCode)",matinh:"\(self.arrGetTinhThanh[index].TinhThanhCode)")
            
            self.mMaTinh = self.arrGetTinhThanh[index].TinhThanhCode
            
            
        }
    }
    
    
    
    
    
    func SetUpDropDownQuan()
    {
        var mQuan:[String] = []
        for i in arrGetQuan {
            mQuan.append(i.QuanHuyenName)
        }
        
        quanDropDown.anchorView = quanButton
        quanDropDown.bottomOffset = CGPoint(x: 0, y: tinhThanhButton.bounds.height)
        quanDropDown.dataSource = mQuan
        quanDropDown.selectionAction = { [unowned self] (index, item) in
            self.quanButton.setTitle(item, for: .normal)
            print("chon \(index)")
            self.GetDataPhuongXa(usercode:"\(Cache.user!.UserName)",shopcode:"\(Cache.user!.ShopCode)",matinh:"\(self.mMaTinh)",mahuyen: "\(self.arrGetQuan[index].QuanHuyenCode)")
            self.mMaQuan = self.arrGetQuan[index].QuanHuyenCode
            
        }
    }
    
    
    func SetUpDropDownDungTich()
    {
        var mDungTich:[String] = []
        for i in arrGetDungTich {
            mDungTich.append(i.DoiTuongName)
        }
        
        dungtichDropDown.anchorView = DungTichButton
        dungtichDropDown.bottomOffset = CGPoint(x: 0, y: tinhThanhButton.bounds.height)
        dungtichDropDown.dataSource = mDungTich
        dungtichDropDown.selectionAction = { [unowned self] (index, item) in
            self.DungTichButton.setTitle(item, for: .normal)
            print("chon \(index)")
            self.mMaDungTich = self.arrGetDungTich[index].DoiTuongCode
            
            self.GetGiaBan_BHX(usercode: "\(Cache.user!.UserName)",shopcode:"\(Cache.user!.ShopCode)",maloaihinh:"\(self.mMaLoaiXe)",madoituong:"\(self.arrGetDungTich[index].DoiTuongCode)",loai:"\(self.mLoaiToken)")
            
        }
    }
    
    
    
    func SetUpDropDownHangXe()
    {
        var mHangXe:[String] = []
        for i in arrHangXe {
            mHangXe.append(i.HangXeName)
        }
        
        hangxeDropDown.anchorView = hangXeButton
        hangxeDropDown.bottomOffset = CGPoint(x: 0, y: tinhThanhButton.bounds.height)
        hangxeDropDown.dataSource = mHangXe
        hangxeDropDown.selectionAction = { [unowned self] (index, item) in
            self.hangXeButton.setTitle(item, for: .normal)
            print("chon \(index)")
            self.mMaHangXe = self.arrHangXe[index].HangXeCode
            
        }
    }
    
    
    func SetUpDropDownSP()
    {
        var mSP:[String] = []
        for i in arrGetSP {
            mSP.append(i.SanPhamName)
        }
        
        spDropDown.anchorView = spButton
        spDropDown.bottomOffset = CGPoint(x: 0, y: tinhThanhButton.bounds.height)
        spDropDown.dataSource = mSP
        spDropDown.selectionAction = { [unowned self] (index, item) in
            self.spButton.setTitle(item, for: .normal)
            print("chon \(index)")
            self.mSanPham = self.arrGetSP[index].SanPhamCode
            
        }
    }
    
    
    @objc func buttonClickedSP() {
        spDropDown.show()
    }
    
    
    @objc func buttonClickedHangXe() {
        hangxeDropDown.show()
    }
    
    @objc func buttonClickedDungTich() {
        dungtichDropDown.show()
    }
    
    @objc func buttonClickedQuan() {
        quanDropDown.show()
    }
    
    @objc func buttonClickedTinhThanh() {
        tinhThanhDropDown.show()
    }
    
    @objc func buttonClickedPhuongXa() {
        phuongxaDropDown.show()
    }
    
    @objc func buttonClickedLoaiXe() {
        loaixeDropDown.show()
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField == edtNgayBatDau){
            let text = textField.text!
            
            if(text.count > 0){
//                let mDate = Date()
//                let mFormatter = DateFormatter()
//                mFormatter.dateFormat = "dd-MM-yyyy"
//                edtNgayBatDau.text = mFormatter.string(from: mDate)
//
//
//
//                edtNgayKetThuc.text = mFormatter.string(from: mDate)
//
//                let date = Calendar.current.date(byAdding: .day, value: +364, to: Date())
//                edtNgayKetThuc.text = mFormatter.string(from: date!)
                //
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-mm-yyyy" //Your date format
              
                //according to date format your date string
                guard let date = dateFormatter.date(from: "\(edtNgayBatDau.text!)") else {
                  
                  return
                }
                let date2 = Calendar.current.date(byAdding: .day, value: +364, to: date)
                edtNgayKetThuc.text = dateFormatter.string(from: date2!)
            }else{
                
                
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          
         
          if(textField == edtNgayBatDau){
              guard var number = textField.text else {
                  return true
              }
              // If user try to delete, remove the char manually
              if string == "" {
                  number.remove(at: number.index(number.startIndex, offsetBy: range.location))
              }
              // Remove all mask characters
              number = number.replacingOccurrences(of: "-", with: "")
              number = number.replacingOccurrences(of: "D", with: "")
              number = number.replacingOccurrences(of: "M", with: "")
              number = number.replacingOccurrences(of: "Y", with: "")
              
              // Set the position of the cursor
              var cursorPosition = number.count+1
              if string == "" {
                  //if it's delete, just take the position given by the delegate
                  cursorPosition = range.location
              } else {
                  // If not, take into account the slash
                  if cursorPosition > 2 && cursorPosition < 5 {
                      cursorPosition += 1
                  } else if cursorPosition > 4 {
                      cursorPosition += 2
                  }
              }
              // Stop editing if we have rich the max numbers
              if number.count == 8 { return false }
              // Readd all mask char
              number += string
              while number.count < 8 {
                  if number.count < 2 {
                      number += "D"
                  } else if number.count < 4 {
                      number += "M"
                  } else {
                      number += "Y"
                  }
              }
              number.insert("-", at: number.index(number.startIndex, offsetBy: 4))
              number.insert("-", at: number.index(number.startIndex, offsetBy: 2))
              
              // Some styling
              let enteredTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
              let maskTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
              
              let partOne = NSMutableAttributedString(string: String(number.prefix(cursorPosition)), attributes: enteredTextAttribute)
              let partTwo = NSMutableAttributedString(string: String(number.suffix(number.count-cursorPosition)), attributes: maskTextAttribute)
              
              let combination = NSMutableAttributedString()
              
              combination.append(partOne)
              combination.append(partTwo)
              
              textField.attributedText = combination
              textField.setCursor(position: cursorPosition)
              return false
              
              
          }
          return true
          
      }
    
    
    @objc func imageBuyMoreCheckTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        self.mBuyMoreChecked = !self.mBuyMoreChecked
        if(self.mBuyMoreChecked)
        {
            imageCheck.image = #imageLiteral(resourceName: "iconcheck")
            mLoaiToken = "2"
        }
        else
        {
            imageCheck.image = #imageLiteral(resourceName: "iconuncheck")
            mLoaiToken = "1"
            
        }
        self.GetGiaBan_BHX(usercode: "\(Cache.user!.UserName)",shopcode:"\(Cache.user!.ShopCode)",maloaihinh:"\(self.mMaLoaiXe)",madoituong:"\(mMaDungTich)",loai:"\(self.mLoaiToken)")
    }
    @objc func imageCheckPromotionFRT(tapGestureRecognizer: UITapGestureRecognizer){
        self.isPromotionFRT = !self.isPromotionFRT
             if(self.isPromotionFRT)
             {
                 imageCheckPromotionFRT.image = #imageLiteral(resourceName: "iconcheck")
                self.checkpromotionFRTBaoHiem()
            
             }
             else
             {
                 imageCheckPromotionFRT.image = #imageLiteral(resourceName: "iconuncheck")
               
                 
             }
           
    }
    
    @objc func imageCreditCheckTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.mCreditChecked = !self.mCreditChecked
        if(self.mCreditChecked)
        {
            imageCheckThe.image = #imageLiteral(resourceName: "iconcheck")
           // self.mViewPayCardPercent.isHidden = false
            
            self.edtTienThe.isEnabled = true
               self.edtTienThe.text = self.edtTienTong.text
            
            
            self.navigationItem.hidesBackButton = true
            let newBackButton = UIBarButtonItem(title: "Trở về", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.CloseClick(sender:)))
            self.navigationItem.leftBarButtonItem = newBackButton
        }
        else
        {
            imageCheckThe.image = #imageLiteral(resourceName: "iconuncheck")
            self.edtTienThe.isEnabled = false
            self.edtTienThe.text = "0"
            
            
            if(mMoneyChecked == true)
            {
                self.edtTienMat.text = self.edtTongTienThu.text
            }
            else
            {
                self.edtTienMat.text = "0"
            }
        }
    }
    
    
    @objc func CloseClick(sender: UIBarButtonItem)
    {
        mViewPayCardPercent.isHidden = true
        
        imageCheckThe.image = #imageLiteral(resourceName: "iconuncheck")
        self.mCreditChecked = false
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = false
        
    }
    
    @objc func imageMoneyCheckTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.mMoneyChecked = !self.mMoneyChecked
        if(self.mMoneyChecked)
        {
            imageCheckTienMat.image = #imageLiteral(resourceName: "iconcheck")
            self.edtTienMat.text = self.edtTienTong.text
            self.edtTienMat.isEnabled = true
            
        }
        else
        {
            imageCheckTienMat.image = #imageLiteral(resourceName: "iconuncheck")
            self.edtTienMat.isEnabled = false
            self.edtTienMat.text = "0"
            if(mCreditChecked == true)
            {
                self.edtTienThe.text = self.edtTongTienThu.text
            }
            else
            {
                self.edtTienThe.text = "0"
            }
            
        }
    }
    
    
    
    
    func intitView()
    {
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        
        let txtThongTinKhachHang = UILabel(frame: CGRect(x: Common.Size(s:15)  , y: 0  , width: UIScreen.main.bounds.size.width , height: Common.Size(s:40)));
        txtThongTinKhachHang.textAlignment = .left
        txtThongTinKhachHang.textColor = UIColor(netHex:0x07922d)
        txtThongTinKhachHang.backgroundColor = UIColor(netHex:0xffffff)
        txtThongTinKhachHang.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        txtThongTinKhachHang.text = "THÔNG TIN KHÁCH HÀNG"
        
        
        
        let strTitle = "Số điện thoại: "
        let sizeStrTitle: CGSize = strTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Common.Size(s:20))])
        txtTitle = UILabel(frame: CGRect(x: 0, y: 5, width: UIScreen.main.bounds.size.width , height: sizeStrTitle.height))
        txtTitle.textAlignment = .center
        txtTitle.textColor = UIColor(netHex:0x06b012)
        txtTitle.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))
        txtTitle.text = strTitle
        txtTitle.text = "THANH TOÁN DỊCH VỤ"
        
        
        /////
        let lbTenChuXe = UILabel(frame: CGRect(x: Common.Size(s:15), y: txtThongTinKhachHang.frame.origin.y + txtThongTinKhachHang.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTenChuXe.textAlignment = .left
        lbTenChuXe.textColor = UIColor.black
        lbTenChuXe.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTenChuXe.text = "Tên chủ xe (*)"
        
        
        
        ///sdt
        
        edtTenChuXe = UITextField(frame: CGRect(x: 15 , y: lbTenChuXe.frame.origin.y + lbTenChuXe.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtTenChuXe.placeholder = "Nhập họ và tên chủ xe"
        edtTenChuXe.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtTenChuXe.borderStyle = UITextField.BorderStyle.roundedRect
        edtTenChuXe.autocorrectionType = UITextAutocorrectionType.no
        edtTenChuXe.keyboardType = UIKeyboardType.default
        edtTenChuXe.returnKeyType = UIReturnKeyType.done
        edtTenChuXe.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtTenChuXe.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        //////////
        
        ////rightview Spinner NCC
        //edtTenChuXe.rightViewMode = UITextFieldViewMode.always
        
        let imageMaHD = UIImageView(frame: CGRect(x: edtTenChuXe.frame.size.height/4, y: edtTenChuXe.frame.size.height/4, width: edtTenChuXe.frame.size.height/2, height: edtTenChuXe.frame.size.height/2))
        imageMaHD.image = UIImage(named: "Search-50-black")
        imageMaHD.contentMode = UIView.ContentMode.scaleAspectFit
        let rightViewMaHD = UIView()
        rightViewMaHD.addSubview(imageMaHD)
        rightViewMaHD.frame = CGRect(x: 0, y: 0, width: edtTenChuXe.frame.size.height, height: edtTenChuXe.frame.size.height)
        edtTenChuXe.rightView = rightViewMaHD
        
        
        
        
        
        let lbSDT = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtTenChuXe.frame.origin.y + edtTenChuXe.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbSDT.textAlignment = .left
        lbSDT.textColor = UIColor.black
        lbSDT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSDT.text = "Số điện thoại (*)"
        
        
        
        ///sdt
        
        edtSDT = UITextField(frame: CGRect(x: 15 , y: lbSDT.frame.origin.y + lbSDT.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtSDT.placeholder = "Nhập SĐT bắt buộc và chính xác"
        
        edtSDT.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtSDT.borderStyle = UITextField.BorderStyle.roundedRect
        edtSDT.autocorrectionType = UITextAutocorrectionType.no
        edtSDT.keyboardType = .numberPad
        edtSDT.returnKeyType = UIReturnKeyType.done
        edtSDT.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtSDT.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        imageCheckPromotionFRT = UIImageView(frame: CGRect(x: Common.Size(s:15)  , y: edtSDT.frame.origin.y + edtSDT.frame.size.height + Common.Size(s:5), width: 20 , height: 0))//20
        imageCheckPromotionFRT.image = #imageLiteral(resourceName: "iconuncheck")
        imageCheckPromotionFRT.contentMode = UIView.ContentMode.scaleAspectFit
        let tapGestureRecognizerCheckPromotion = UITapGestureRecognizer(target: self, action: #selector(imageCheckPromotionFRT(tapGestureRecognizer:)))
        imageCheckPromotionFRT.isUserInteractionEnabled = true
        imageCheckPromotionFRT.addGestureRecognizer(tapGestureRecognizerCheckPromotion)
        self.scrollView.addSubview(imageCheckPromotionFRT)
        
        
        
        let lbPromotionText = UILabel(frame: CGRect(x: imageCheckPromotionFRT.frame.origin.x + imageCheckPromotionFRT.frame.size.width + Common.Size(s: 3), y: imageCheckPromotionFRT.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:0)))//14
        lbPromotionText.textAlignment = .left
        lbPromotionText.textColor = .red
        //
        lbPromotionText.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPromotionText.text = "Người nhà FRT"
           self.scrollView.addSubview(lbPromotionText)
        

        let txtThongTinNguoiNhan = UILabel(frame: CGRect(x: Common.Size(s:15)  , y: lbPromotionText.frame.size.height + lbPromotionText.frame.origin.y + Common.Size(s:10)  , width: UIScreen.main.bounds.size.width , height: Common.Size(s:40)));
        txtThongTinNguoiNhan.textAlignment = .left
        txtThongTinNguoiNhan.textColor = UIColor(netHex:0x07922d)
        txtThongTinNguoiNhan.backgroundColor = UIColor(netHex:0xffffff)
        txtThongTinNguoiNhan.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        txtThongTinNguoiNhan.text = "THÔNG TIN NGƯỜI NHẬN GIẤY BẢO HIỂM"
          self.scrollView.addSubview(txtThongTinNguoiNhan)
        
//        phuongxaButton.setImage(image: UIImage(named: "Home-50-1"), inFrame: CGRect(x: phuongxaButton.frame.size.height/4, y: phuongxaButton.frame.size.height/4, width: phuongxaButton.frame.size.height/2, height: phuongxaButton.frame.size.height/2), forState: .normal)
//        phuongxaButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        let lbTenNguoiNhan = UILabel(frame: CGRect(x: Common.Size(s:15), y: txtThongTinNguoiNhan.frame.origin.y + txtThongTinNguoiNhan.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
         lbTenNguoiNhan.textAlignment = .left
         lbTenNguoiNhan.textColor = UIColor.black
         lbTenNguoiNhan.font = UIFont.systemFont(ofSize: Common.Size(s:12))
         lbTenNguoiNhan.text = "Tên người nhận (*)"
        self.scrollView.addSubview(lbTenNguoiNhan)
         
         
         ///sdt
         
         tfTenNguoiNhan = UITextField(frame: CGRect(x: 15 , y: lbTenNguoiNhan.frame.origin.y + lbTenNguoiNhan.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
         tfTenNguoiNhan.placeholder = "Nhập tên người nhận"
         
         tfTenNguoiNhan.font = UIFont.systemFont(ofSize: Common.Size(s:15))
         tfTenNguoiNhan.borderStyle = UITextField.BorderStyle.roundedRect
         tfTenNguoiNhan.autocorrectionType = UITextAutocorrectionType.no
         tfTenNguoiNhan.keyboardType = .default
         tfTenNguoiNhan.returnKeyType = UIReturnKeyType.done
         tfTenNguoiNhan.clearButtonMode = UITextField.ViewMode.whileEditing;
         tfTenNguoiNhan.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        self.scrollView.addSubview(tfTenNguoiNhan)
         
         let lbSDTNguoiNhan = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfTenNguoiNhan.frame.origin.y + tfTenNguoiNhan.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
         lbSDTNguoiNhan.textAlignment = .left
         lbSDTNguoiNhan.textColor = UIColor.black
         lbSDTNguoiNhan.font = UIFont.systemFont(ofSize: Common.Size(s:12))
         lbSDTNguoiNhan.text = "SĐT người nhận (*)"
       self.scrollView.addSubview(lbSDTNguoiNhan)
        
        
        ///sdt
        
        tfSDTNguoiNhan = UITextField(frame: CGRect(x: 15 , y: lbSDTNguoiNhan.frame.origin.y + lbSDTNguoiNhan.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        tfSDTNguoiNhan.placeholder = "Nhập SĐT người nhận"
        
        tfSDTNguoiNhan.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSDTNguoiNhan.borderStyle = UITextField.BorderStyle.roundedRect
        tfSDTNguoiNhan.autocorrectionType = UITextAutocorrectionType.no
        tfSDTNguoiNhan.keyboardType = .numberPad
        tfSDTNguoiNhan.returnKeyType = UIReturnKeyType.done
        tfSDTNguoiNhan.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfSDTNguoiNhan.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        self.scrollView.addSubview(tfSDTNguoiNhan)
        
        ///////
        let lbDiaChi = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfSDTNguoiNhan.frame.origin.y + tfSDTNguoiNhan.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbDiaChi.textAlignment = .left
        lbDiaChi.textColor = UIColor.black
        lbDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbDiaChi.text = "Địa chỉ nhận giấy bảo hiểm: (*)"
        
        
        
        ///sdt
        
        edtDiaChi = UITextField(frame: CGRect(x: 15 , y: lbDiaChi.frame.origin.y + lbDiaChi.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtDiaChi.placeholder = "Số nhà, tên đường/Ấp"
        edtDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtDiaChi.borderStyle = UITextField.BorderStyle.roundedRect
        edtDiaChi.autocorrectionType = UITextAutocorrectionType.no
        edtDiaChi.keyboardType = UIKeyboardType.default
        edtDiaChi.returnKeyType = UIReturnKeyType.done
        edtDiaChi.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtDiaChi.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        
        
        
        
        let lbTinhThanh = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtDiaChi.frame.origin.y + edtDiaChi.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTinhThanh.textAlignment = .left
        lbTinhThanh.textColor = UIColor.black
        lbTinhThanh.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTinhThanh.text = "Chọn tỉnh thành (*)"
        
        
        tinhThanhButton = NiceButton(frame: CGRect(x: edtSDT.frame.origin.x, y: lbTinhThanh.frame.origin.y + lbTinhThanh.frame.size.height + Common.Size(s:10), width: edtSDT.frame.size.width , height: edtSDT.frame.size.height ))
        
        tinhThanhButton.contentHorizontalAlignment = .left
        tinhThanhButton.tintColor = UIColor.red
        tinhThanhButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tinhThanhButton.setTitleColor(UIColor.black ,for: .normal)
        tinhThanhButton.setTitle("", for: .normal)
        tinhThanhButton.layer.borderWidth = 0.5
        tinhThanhButton.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        tinhThanhButton.layer.cornerRadius = 3.0
        tinhThanhButton.addTarget(self, action:#selector(self.buttonClickedTinhThanh), for: .touchUpInside)
        
        
        
        //        tinhThanhButton.setImage(image: UIImage(named: "Home-50-1"), inFrame: CGRect(x: tinhThanhButton.frame.size.height/4, y: tinhThanhButton.frame.size.height/4, width: tinhThanhButton.frame.size.height/2, height: tinhThanhButton.frame.size.height/2), forState: .normal)
        //        tinhThanhButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        
        
        
        let lbQuan = UILabel(frame: CGRect(x: Common.Size(s:15), y: tinhThanhButton.frame.origin.y + tinhThanhButton.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbQuan.textAlignment = .left
        lbQuan.textColor = UIColor.black
        lbQuan.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbQuan.text = "Chọn quận (*)"
        
        
        quanButton = NiceButton(frame: CGRect(x: edtSDT.frame.origin.x, y: lbQuan.frame.origin.y + lbQuan.frame.size.height + Common.Size(s:10), width: edtSDT.frame.size.width , height: edtSDT.frame.size.height ))
        
        quanButton.contentHorizontalAlignment = .left
        quanButton.tintColor = UIColor.red
        quanButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        quanButton.setTitleColor(UIColor.black ,for: .normal)
        quanButton.setTitle("", for: .normal)
        quanButton.layer.borderWidth = 0.5
        quanButton.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        quanButton.layer.cornerRadius = 3.0
        quanButton.addTarget(self, action:#selector(self.buttonClickedQuan), for: .touchUpInside)
        
        
        //        quanButton.setImage(image: UIImage(named: "Home-50-1"), inFrame: CGRect(x: quanButton.frame.size.height/4, y: quanButton.frame.size.height/4, width: quanButton.frame.size.height/2, height: quanButton.frame.size.height/2), forState: .normal)
        //        quanButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        
        let lbPhuongXa = UILabel(frame: CGRect(x: Common.Size(s:15), y: quanButton.frame.origin.y + quanButton.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbPhuongXa.textAlignment = .left
        lbPhuongXa.textColor = UIColor.black
        lbPhuongXa.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPhuongXa.text = "Chọn phường xã (*)"
        
        
        phuongxaButton = NiceButton(frame: CGRect(x: edtSDT.frame.origin.x, y: lbPhuongXa.frame.origin.y + lbPhuongXa.frame.size.height + Common.Size(s:10), width: edtSDT.frame.size.width , height: edtSDT.frame.size.height ))
        
        phuongxaButton.contentHorizontalAlignment = .left
        phuongxaButton.tintColor = UIColor.red
        phuongxaButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        phuongxaButton.setTitleColor(UIColor.black ,for: .normal)
        phuongxaButton.setTitle("", for: .normal)
        phuongxaButton.layer.borderWidth = 0.5
        phuongxaButton.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        phuongxaButton.layer.cornerRadius = 3.0
        phuongxaButton.addTarget(self, action:#selector(self.buttonClickedPhuongXa), for: .touchUpInside)
        
        
        let txtThongTinSP = UILabel(frame: CGRect(x: Common.Size(s:15)  , y: phuongxaButton.frame.origin.y + phuongxaButton.frame.size.height  , width: UIScreen.main.bounds.size.width , height: Common.Size(s:40)));
        txtThongTinSP.textAlignment = .left
        txtThongTinSP.textColor = UIColor(netHex:0x07922d)
        txtThongTinSP.backgroundColor = UIColor(netHex:0xffffff)
        txtThongTinSP.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        txtThongTinSP.text = "THÔNG TIN SẢN PHẨM BẢO HIỂM"
        
        
        
        
        
        let lbLoạiXe = UILabel(frame: CGRect(x: Common.Size(s:15), y: txtThongTinSP.frame.origin.y + txtThongTinSP.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbLoạiXe.textAlignment = .left
        lbLoạiXe.textColor = UIColor.black
        lbLoạiXe.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbLoạiXe.text = "Loại xe (*)"
        
        
        
        LoaiXeButton = NiceButton(frame: CGRect(x: edtSDT.frame.origin.x, y: lbLoạiXe.frame.origin.y + lbLoạiXe.frame.size.height + Common.Size(s:10), width: edtSDT.frame.size.width , height: edtSDT.frame.size.height ))
        
        LoaiXeButton.contentHorizontalAlignment = .left
        LoaiXeButton.tintColor = UIColor.red
        LoaiXeButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        LoaiXeButton.setTitleColor(UIColor.black ,for: .normal)
        LoaiXeButton.setTitle("", for: .normal)
        LoaiXeButton.layer.borderWidth = 0.5
        LoaiXeButton.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        LoaiXeButton.layer.cornerRadius = 3.0
        LoaiXeButton.addTarget(self, action:#selector(self.buttonClickedLoaiXe), for: .touchUpInside)
        
        
        LoaiXeButton.setImage(image: UIImage(named: "motorcycle"), inFrame: CGRect(x: phuongxaButton.frame.size.height/4, y: phuongxaButton.frame.size.height/4, width: phuongxaButton.frame.size.height/2, height: phuongxaButton.frame.size.height/2), forState: .normal)
        LoaiXeButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        
        
        
        let lbDungTich = UILabel(frame: CGRect(x: Common.Size(s:15), y: LoaiXeButton.frame.origin.y + LoaiXeButton.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbDungTich.textAlignment = .left
        lbDungTich.textColor = UIColor.black
        lbDungTich.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbDungTich.text = "Dung tích/Số chỗ (*)"
        
        
        
        DungTichButton = NiceButton(frame: CGRect(x: edtSDT.frame.origin.x, y: lbDungTich.frame.origin.y + lbDungTich.frame.size.height + Common.Size(s:10), width: edtSDT.frame.size.width , height: edtSDT.frame.size.height ))
        
        DungTichButton.contentHorizontalAlignment = .left
        DungTichButton.tintColor = UIColor.red
        DungTichButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        DungTichButton.setTitleColor(UIColor.black ,for: .normal)
        DungTichButton.setTitle("", for: .normal)
        DungTichButton.layer.borderWidth = 0.5
        DungTichButton.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        DungTichButton.layer.cornerRadius = 3.0
        DungTichButton.addTarget(self, action:#selector(self.buttonClickedDungTich), for: .touchUpInside)
        
        DungTichButton.setImage(image: UIImage(named: "motorcycle"), inFrame: CGRect(x: phuongxaButton.frame.size.height/4, y: phuongxaButton.frame.size.height/4, width: phuongxaButton.frame.size.height/2, height: phuongxaButton.frame.size.height/2), forState: .normal)
        DungTichButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        
        let lbBienSo = UILabel(frame: CGRect(x: Common.Size(s:15), y: DungTichButton.frame.origin.y + DungTichButton.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbBienSo.textAlignment = .left
        lbBienSo.textColor = UIColor.red
        lbBienSo.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbBienSo.text = "Biển số xe (Viết liền không dấu,VD: 52F512345)"
        
        
        
        ///sdt
        
        edtBienSo = UITextField(frame: CGRect(x: 15 , y: lbBienSo.frame.origin.y + lbBienSo.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtBienSo.placeholder = "NHẬP BIỂN SỐ"
        edtBienSo.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtBienSo.borderStyle = UITextField.BorderStyle.roundedRect
        edtBienSo.autocorrectionType = UITextAutocorrectionType.no
        edtBienSo.keyboardType = UIKeyboardType.default
        edtBienSo.returnKeyType = UIReturnKeyType.done
        edtBienSo.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtBienSo.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        
        let lbHangXe = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtBienSo.frame.origin.y + edtBienSo.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHangXe.textAlignment = .left
        lbHangXe.textColor = UIColor.black
        lbHangXe.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHangXe.text = "Hãng xe (*)"
        
        
        hangXeButton = NiceButton(frame: CGRect(x: edtSDT.frame.origin.x, y: lbHangXe.frame.origin.y + lbHangXe.frame.size.height + Common.Size(s:10), width: edtSDT.frame.size.width , height: edtSDT.frame.size.height ))
        
        hangXeButton.contentHorizontalAlignment = .left
        hangXeButton.tintColor = UIColor.red
        hangXeButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        hangXeButton.setTitleColor(UIColor.black ,for: .normal)
        hangXeButton.setTitle("", for: .normal)
        hangXeButton.layer.borderWidth = 0.5
        hangXeButton.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        hangXeButton.layer.cornerRadius = 3.0
        hangXeButton.addTarget(self, action:#selector(self.buttonClickedHangXe), for: .touchUpInside)
        
        hangXeButton.setImage(image: UIImage(named: "motorcycle"), inFrame: CGRect(x: phuongxaButton.frame.size.height/4, y: phuongxaButton.frame.size.height/4, width: phuongxaButton.frame.size.height/2, height: phuongxaButton.frame.size.height/2), forState: .normal)
        hangXeButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        
        
        let lbSanPham = UILabel(frame: CGRect(x: Common.Size(s:15), y: hangXeButton.frame.origin.y + hangXeButton.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbSanPham.textAlignment = .left
        lbSanPham.textColor = UIColor.black
        lbSanPham.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSanPham.text = "Sản phẩm (*)"
        
        
        
        spButton = NiceButton(frame: CGRect(x: edtSDT.frame.origin.x, y: lbSanPham.frame.origin.y + lbSanPham.frame.size.height + Common.Size(s:10), width: edtSDT.frame.size.width , height: edtSDT.frame.size.height ))
        
        spButton.contentHorizontalAlignment = .left
        spButton.tintColor = UIColor.red
        spButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        spButton.setTitleColor(UIColor.black ,for: .normal)
        spButton.setTitle("", for: .normal)
        spButton.layer.borderWidth = 0.5
        spButton.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        spButton.layer.cornerRadius = 3.0
        spButton.addTarget(self, action:#selector(self.buttonClickedSP), for: .touchUpInside)
        
         spButton.setImage(image: UIImage(named: "motorcycle"), inFrame: CGRect(x: phuongxaButton.frame.size.height/4, y: phuongxaButton.frame.size.height/4, width: phuongxaButton.frame.size.height/2, height: phuongxaButton.frame.size.height/2), forState: .normal)
        
//        spButton.setImage(image: UIImage(named: "motorcycle"), inFrame: CGRect(x: phuongxaButton.frame.size.height/4, y: phuongxaButton.frame.size.height/4, width: phuongxaButton.frame.size.height/2, height: phuongxaButton.frame.size.height/2), for: .normal)
        spButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        let lbNgayBatDau = UILabel(frame: CGRect(x: Common.Size(s:15), y: spButton.frame.origin.y + spButton.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbNgayBatDau.textAlignment = .left
        lbNgayBatDau.textColor = UIColor.black
        lbNgayBatDau.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbNgayBatDau.text = "Ngày bắt đầu hiệu lực (*)"
        
        
        
        ///sdt
        
        edtNgayBatDau = UITextField(frame: CGRect(x: 15 , y: lbNgayBatDau.frame.origin.y + lbNgayBatDau.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtNgayBatDau.placeholder = ""
        edtNgayBatDau.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtNgayBatDau.borderStyle = UITextField.BorderStyle.roundedRect
        edtNgayBatDau.autocorrectionType = UITextAutocorrectionType.no
        edtNgayBatDau.keyboardType = UIKeyboardType.numberPad
        edtNgayBatDau.returnKeyType = UIReturnKeyType.done
        edtNgayBatDau.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtNgayBatDau.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtNgayBatDau.delegate = self
        edtNgayBatDau.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        
        
        let lbNgayKetThuc = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtNgayBatDau.frame.origin.y + edtNgayBatDau.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbNgayKetThuc.textAlignment = .left
        lbNgayKetThuc.textColor = UIColor.black
        lbNgayKetThuc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbNgayKetThuc.text = "Ngày kết thúc hiệu lực (*)"
        
        
        
        ///sdt
        
        edtNgayKetThuc = UITextField(frame: CGRect(x: 15 , y: lbNgayKetThuc.frame.origin.y + lbNgayKetThuc.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtNgayKetThuc.placeholder = ""
        edtNgayKetThuc.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtNgayKetThuc.borderStyle = UITextField.BorderStyle.roundedRect
        edtNgayKetThuc.autocorrectionType = UITextAutocorrectionType.no
        edtNgayKetThuc.keyboardType = UIKeyboardType.default
        edtNgayKetThuc.returnKeyType = UIReturnKeyType.done
        edtNgayKetThuc.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtNgayKetThuc.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        imageCheck = UIImageView(frame: CGRect(x: edtNgayKetThuc.frame.origin.x  , y: edtNgayKetThuc.frame.origin.y + edtNgayKetThuc.frame.size.height + Common.Size(s:5), width: 20 , height: 20))
        imageCheck.image = #imageLiteral(resourceName: "iconuncheck")
        imageCheck.contentMode = UIView.ContentMode.scaleAspectFit
        let tapGestureRecognizerCheck = UITapGestureRecognizer(target: self, action: #selector(imageBuyMoreCheckTapped(tapGestureRecognizer:)))
        imageCheck.isUserInteractionEnabled = true
        imageCheck.addGestureRecognizer(tapGestureRecognizerCheck)
        
        
        
        
        let lbMuaThem = UILabel(frame: CGRect(x: imageCheck.frame.origin.x + imageCheck.frame.size.width + Common.Size(s: 3), y: imageCheck.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbMuaThem.textAlignment = .left
        lbMuaThem.textColor = UIColor(netHex:0x04ba36)
        //
        lbMuaThem.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbMuaThem.text = "Chấp nhận mua bảo hiểm người ngồi,phụ,lái xe"
        
        
        //////////
        let lbPhiBH = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbMuaThem.frame.origin.y + lbMuaThem.frame.size.height  + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbPhiBH.textAlignment = .left
        lbPhiBH.textColor = UIColor.black
        lbPhiBH.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPhiBH.text = "Phí bảo hiểm"
        
        
        
        ///sdt
        
        edtPhiBH = UITextField(frame: CGRect(x: 15 , y: lbPhiBH.frame.origin.y + lbNgayKetThuc.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtPhiBH.placeholder = ""
        edtPhiBH.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtPhiBH.borderStyle = UITextField.BorderStyle.roundedRect
        edtPhiBH.autocorrectionType = UITextAutocorrectionType.no
        edtPhiBH.keyboardType = UIKeyboardType.default
        edtPhiBH.returnKeyType = UIReturnKeyType.done
        edtPhiBH.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtPhiBH.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        
        
        
        let lbPhiBHTrenXe = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtPhiBH.frame.origin.y + edtPhiBH.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbPhiBHTrenXe.textAlignment = .left
        lbPhiBHTrenXe.textColor = UIColor.black
        lbPhiBHTrenXe.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPhiBHTrenXe.text = "Phí bảo hiểm cho người trên xe"
        
        
        
        ///sdt
        
        edtPhiBHTrenXe = UITextField(frame: CGRect(x: 15 , y: lbPhiBHTrenXe.frame.origin.y + lbPhiBHTrenXe.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtPhiBHTrenXe.placeholder = ""
        edtPhiBHTrenXe.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtPhiBHTrenXe.borderStyle = UITextField.BorderStyle.roundedRect
        edtPhiBHTrenXe.autocorrectionType = UITextAutocorrectionType.no
        edtPhiBHTrenXe.keyboardType = UIKeyboardType.default
        edtPhiBHTrenXe.returnKeyType = UIReturnKeyType.done
        edtPhiBHTrenXe.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtPhiBHTrenXe.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        let lbTongTienThu = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtPhiBHTrenXe.frame.origin.y + edtPhiBHTrenXe.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTongTienThu.textAlignment = .left
        lbTongTienThu.textColor = UIColor.red
        lbTongTienThu.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbTongTienThu.text = "Tổng tiền thu (*)"
        
        
        
        ///sdt
        
        edtTongTienThu = UITextField(frame: CGRect(x: 15 , y: lbTongTienThu.frame.origin.y + lbTongTienThu.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtTongTienThu.placeholder = ""
        edtTongTienThu.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtTongTienThu.borderStyle = UITextField.BorderStyle.roundedRect
        edtTongTienThu.autocorrectionType = UITextAutocorrectionType.no
        edtTongTienThu.keyboardType = UIKeyboardType.default
        edtTongTienThu.returnKeyType = UIReturnKeyType.done
        edtTongTienThu.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtTongTienThu.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        imageCheckTienMat = UIImageView(frame: CGRect(x: edtNgayKetThuc.frame.origin.x  , y: edtTongTienThu.frame.origin.y + edtTongTienThu.frame.size.height + Common.Size(s:5), width: 20 , height: 20))
        imageCheckTienMat.image = #imageLiteral(resourceName: "iconuncheck")
        imageCheckTienMat.contentMode = UIView.ContentMode.scaleAspectFit
        
        let tapGestureRecognizerCheck2 = UITapGestureRecognizer(target: self, action: #selector(imageMoneyCheckTapped(tapGestureRecognizer:)))
        imageCheckTienMat.isUserInteractionEnabled = true
        imageCheckTienMat.addGestureRecognizer(tapGestureRecognizerCheck2)
        
        
        
        
        let lbTienMat = UILabel(frame: CGRect(x: imageCheckTienMat.frame.origin.x + imageCheckTienMat.frame.size.width + Common.Size(s: 3), y: imageCheckTienMat.frame.origin.y, width: scrollView.frame.size.width / 3, height: Common.Size(s:14)))
        lbTienMat.textAlignment = .left
        lbTienMat.textColor = UIColor.black
        lbTienMat.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTienMat.text = "Tiền mặt"
        
        
        imageCheckThe = UIImageView(frame: CGRect(x: lbTienMat.frame.origin.x + lbTienMat.frame.size.width + Common.Size(s: 3) , y: lbTienMat.frame.origin.y , width: 20 , height: 20))
        imageCheckThe.image = #imageLiteral(resourceName: "iconuncheck")
        imageCheckThe.contentMode = UIView.ContentMode.scaleAspectFit
        
        
        let tapGestureRecognizerCheck3 = UITapGestureRecognizer(target: self, action: #selector(imageCreditCheckTapped(tapGestureRecognizer:)))
        imageCheckThe.isUserInteractionEnabled = true
        imageCheckThe.addGestureRecognizer(tapGestureRecognizerCheck3)
        
        
        let lbTienThe = UILabel(frame: CGRect(x: imageCheckThe.frame.origin.x + imageCheckThe.frame.size.width + Common.Size(s: 3), y: imageCheckThe.frame.origin.y, width: scrollView.frame.size.width / 3, height: Common.Size(s:14)))
        lbTienThe.textAlignment = .left
        lbTienThe.textColor = UIColor.black
        lbTienThe.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTienThe.text = "Thẻ"
        
        
        let lbTienMatThanhToan = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbTienThe.frame.origin.y + lbTienThe.frame.size.height  + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTienMatThanhToan.textAlignment = .left
        lbTienMatThanhToan.textColor = UIColor.black
        lbTienMatThanhToan.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTienMatThanhToan.text = "Tiền mặt phải thanh toán "
        
        
        
        ///sdt
        
        edtTienMat = UITextField(frame: CGRect(x: 15 , y: lbTienMatThanhToan.frame.origin.y + lbTienMatThanhToan.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtTienMat.placeholder = ""
        edtTienMat.delegate = self
        edtTienMat.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtTienMat.borderStyle = UITextField.BorderStyle.roundedRect
        edtTienMat.autocorrectionType = UITextAutocorrectionType.no
        edtTienMat.keyboardType = UIKeyboardType.default
        edtTienMat.returnKeyType = UIReturnKeyType.done
        edtTienMat.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtTienMat.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtTienMat.keyboardType = .numberPad
        edtTienMat.text = "0"
        
        let lbTienTheThanhToan = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtTienMat.frame.origin.y + edtTienMat.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTienTheThanhToan.textAlignment = .left
        lbTienTheThanhToan.textColor = UIColor.black
        lbTienTheThanhToan.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTienTheThanhToan.text = "Tiền thẻ phải thanh toán "
        
        
        
        ///sdt
        
        edtTienThe = UITextField(frame: CGRect(x: 15 , y: lbTienTheThanhToan.frame.origin.y + lbTienTheThanhToan.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtTienThe.placeholder = ""
        edtTienThe.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtTienThe.borderStyle = UITextField.BorderStyle.roundedRect
        edtTienThe.autocorrectionType = UITextAutocorrectionType.no
        edtTienThe.keyboardType = UIKeyboardType.default
        edtTienThe.delegate = self
        edtTienThe.keyboardType = .numberPad
        edtTienThe.returnKeyType = UIReturnKeyType.done
        edtTienThe.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtTienThe.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtTienThe.text = "0"
        
        let lbTienTong = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtTienThe.frame.origin.y + edtTienThe.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTienTong.textAlignment = .left
        lbTienTong.textColor = UIColor.red
        lbTienTong.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbTienTong.text = "Tổng thanh toán (*)"
        
        
        edtTienTong = UITextField(frame: CGRect(x: 15 , y: lbTienTong.frame.origin.y + lbTienTong.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtTienTong.placeholder = ""
        edtTienTong.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtTienTong.borderStyle = UITextField.BorderStyle.roundedRect
        edtTienTong.autocorrectionType = UITextAutocorrectionType.no
        edtTienTong.keyboardType = UIKeyboardType.default
        edtTienTong.returnKeyType = UIReturnKeyType.done
        edtTienTong.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtTienTong.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        
        
        btnDone = UIButton(frame: CGRect(x: (UIScreen.main.bounds.size.width - (UIScreen.main.bounds.size.width - 20)) / 2, y: edtTienTong.frame.origin.y + edtTienTong.frame.size.height + 10, width: UIScreen.main.bounds.size.width - 20 , height: Common.Size(s:40)));
        btnDone.backgroundColor = UIColor(netHex:0xff0000)
        
        btnDone.setTitle("Hoàn Tất",for: .normal)
        btnDone.setTitleColor(UIColor.white, for: .normal)
        btnDone.titleLabel!.font =  UIFont(name: "Helvetica", size: 20)
        btnDone.addTarget(self, action: #selector(ClickDone), for: UIControl.Event.touchDown)
        ////////
        let viewRightTinhThanh = UIView(frame: CGRect(x: tinhThanhButton.frame.origin.x + tinhThanhButton.frame.size.width - tinhThanhButton.frame.size.height,y: tinhThanhButton.frame.origin.y + tinhThanhButton.frame.size.height / 4 ,width: tinhThanhButton.frame.size.height / 2, height: tinhThanhButton.frame.size.height / 2))
        viewRightTinhThanh.backgroundColor = UIColor.white
        
        let viewRightQuan = UIView(frame: CGRect(x: quanButton.frame.origin.x + quanButton.frame.size.width - quanButton.frame.size.height,y: quanButton.frame.origin.y + quanButton.frame.size.height / 4 ,width: tinhThanhButton.frame.size.height / 2, height: tinhThanhButton.frame.size.height / 2))
        viewRightQuan.backgroundColor = UIColor.white
        
        let viewRightPhuongXa = UIView(frame: CGRect(x: phuongxaButton.frame.origin.x + phuongxaButton.frame.size.width - phuongxaButton.frame.size.height,y: phuongxaButton.frame.origin.y + phuongxaButton.frame.size.height / 4 ,width: phuongxaButton.frame.size.height / 2, height: phuongxaButton.frame.size.height / 2))
        viewRightPhuongXa.backgroundColor = UIColor.white
        
        let viewRightLoaiXe = UIView(frame: CGRect(x: LoaiXeButton.frame.origin.x + phuongxaButton.frame.size.width - phuongxaButton.frame.size.height,y: LoaiXeButton.frame.origin.y + phuongxaButton.frame.size.height / 4 ,width: phuongxaButton.frame.size.height / 2, height: phuongxaButton.frame.size.height / 2))
        viewRightLoaiXe.backgroundColor = UIColor.white
        
        let viewRightDungTich = UIView(frame: CGRect(x: DungTichButton.frame.origin.x + DungTichButton.frame.size.width - DungTichButton.frame.size.height,y: DungTichButton.frame.origin.y + phuongxaButton.frame.size.height / 4 ,width: phuongxaButton.frame.size.height / 2, height: phuongxaButton.frame.size.height / 2))
        viewRightDungTich.backgroundColor = UIColor.white
        
        let viewRightHangXe = UIView(frame: CGRect(x: hangXeButton.frame.origin.x + DungTichButton.frame.size.width - hangXeButton.frame.size.height,y: hangXeButton.frame.origin.y + hangXeButton.frame.size.height / 4 ,width: phuongxaButton.frame.size.height / 2, height: phuongxaButton.frame.size.height / 2))
        viewRightHangXe.backgroundColor = UIColor.white
        
        let viewRightSanPham = UIView(frame: CGRect(x: spButton.frame.origin.x + spButton.frame.size.width - spButton.frame.size.height,y: spButton.frame.origin.y + spButton.frame.size.height / 4 ,width: phuongxaButton.frame.size.height / 2, height: phuongxaButton.frame.size.height / 2))
        viewRightSanPham.backgroundColor = UIColor.white
        
        
        
        var iconRightTinhThanh : UIImageView
        iconRightTinhThanh  = UIImageView(frame:CGRect(x: 0 , y: 0, width: viewRightTinhThanh.frame.size.width, height: viewRightTinhThanh.frame.size.height));
        iconRightTinhThanh.image = #imageLiteral(resourceName: "ic_arrow")
        iconRightTinhThanh.contentMode = .scaleAspectFit
        
        
        var iconRightQuan : UIImageView
        iconRightQuan  = UIImageView(frame:CGRect(x: 0 , y: 0, width: viewRightTinhThanh.frame.size.width, height: viewRightTinhThanh.frame.size.height));
        iconRightQuan.image = #imageLiteral(resourceName: "ic_arrow")
        iconRightQuan.contentMode = .scaleAspectFit
        
        var iconRightPhuongXa : UIImageView
        iconRightPhuongXa  = UIImageView(frame:CGRect(x: 0 , y: 0, width: viewRightTinhThanh.frame.size.width, height: viewRightTinhThanh.frame.size.height));
        iconRightPhuongXa.image = #imageLiteral(resourceName: "ic_arrow")
        iconRightPhuongXa.contentMode = .scaleAspectFit
        
        var iconRightLoaiXe : UIImageView
        iconRightLoaiXe  = UIImageView(frame:CGRect(x: 0 , y: 0, width: viewRightTinhThanh.frame.size.width, height: viewRightTinhThanh.frame.size.height));
        iconRightLoaiXe.image = #imageLiteral(resourceName: "ic_arrow")
        iconRightLoaiXe.contentMode = .scaleAspectFit
        
        var iconRightDungTich : UIImageView
        iconRightDungTich  = UIImageView(frame:CGRect(x: 0 , y: 0, width: viewRightTinhThanh.frame.size.width, height: viewRightTinhThanh.frame.size.height));
        iconRightDungTich.image = #imageLiteral(resourceName: "ic_arrow")
        iconRightDungTich.contentMode = .scaleAspectFit
        
        var iconRightHangXe : UIImageView
        iconRightHangXe  = UIImageView(frame:CGRect(x: 0 , y: 0, width: viewRightTinhThanh.frame.size.width, height: viewRightTinhThanh.frame.size.height));
        iconRightHangXe.image = #imageLiteral(resourceName: "ic_arrow")
        iconRightHangXe.contentMode = .scaleAspectFit
        
        var iconRightSP : UIImageView
        iconRightSP  = UIImageView(frame:CGRect(x: 0 , y: 0, width: viewRightTinhThanh.frame.size.width, height: viewRightTinhThanh.frame.size.height));
        iconRightSP.image = #imageLiteral(resourceName: "ic_arrow")
        iconRightSP.contentMode = .scaleAspectFit
        
        
        viewRightTinhThanh.addSubview(iconRightTinhThanh)
        viewRightLoaiXe.addSubview(iconRightLoaiXe)
        viewRightDungTich.addSubview(iconRightDungTich)
        
        viewRightQuan.addSubview(iconRightQuan)
        viewRightPhuongXa.addSubview(iconRightPhuongXa)
        viewRightHangXe.addSubview(iconRightHangXe)
        viewRightSanPham.addSubview(iconRightSP)
        
        
        edtNgayKetThuc.isEnabled = false
        edtNgayBatDau.isEnabled = true
        edtPhiBH.isEnabled = false
        edtPhiBHTrenXe.isEnabled = false
        edtTongTienThu.isEnabled = false
        edtTienTong.isEnabled = false
        edtTienThe.isEnabled = false
        edtTienMat.isEnabled = false
        
        
        loadingView  = UIView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        
        
        let frameLoading = CGRect(x: loadingView.frame.size.width/2 - Common.Size(s:25), y:loadingView.frame.height/2 - Common.Size(s:25), width: Common.Size(s:50), height: Common.Size(s:50))
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor(netHex:0x47B054)
        loading = NVActivityIndicatorView(frame: frameLoading,
                                          type: .ballClipRotateMultiple)
        loading.startAnimating()
        loadingView.addSubview(loading)
        loadingView.isHidden = true
        
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btnDone.frame.size.height + btnDone.frame.origin.y + 100)
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(txtThongTinKhachHang)
        scrollView.addSubview(lbTenChuXe)
        scrollView.addSubview(viewRightTinhThanh)
        scrollView.addSubview(viewRightQuan)
        scrollView.addSubview(viewRightPhuongXa)
        
        scrollView.addSubview(viewRightLoaiXe)
        scrollView.addSubview(viewRightDungTich)
        scrollView.addSubview(viewRightHangXe)
        scrollView.addSubview(viewRightSanPham)
        
        
        scrollView.addSubview(edtTenChuXe)
        scrollView.addSubview(tinhThanhButton)
        
        scrollView.addSubview(lbDiaChi)
        scrollView.addSubview(edtDiaChi)
        
        scrollView.addSubview(lbSDT)
        scrollView.addSubview(edtSDT)
        scrollView.addSubview(lbTinhThanh)
        
        scrollView.addSubview(lbQuan)
        scrollView.addSubview(quanButton)
        scrollView.addSubview(lbPhuongXa)
        scrollView.addSubview(phuongxaButton)
        scrollView.addSubview(txtThongTinSP)
        
        
        self.scrollView.addSubview(txtThongTinSP)
        self.scrollView.addSubview(lbLoạiXe)
        self.scrollView.addSubview(LoaiXeButton)
        self.scrollView.addSubview(lbDungTich)
        self.scrollView.addSubview(DungTichButton)
        
        self.scrollView.addSubview(lbBienSo)
        self.scrollView.addSubview(edtBienSo)
        self.scrollView.addSubview(lbHangXe)
        self.scrollView.addSubview(hangXeButton)
        self.scrollView.addSubview(lbSanPham)
        self.scrollView.addSubview(spButton)
        
        self.scrollView.addSubview(lbNgayBatDau)
        self.scrollView.addSubview(edtNgayBatDau)
        self.scrollView.addSubview(lbNgayKetThuc)
        self.scrollView.addSubview(edtNgayKetThuc)
        self.scrollView.addSubview(imageCheck)
        self.scrollView.addSubview(lbMuaThem)
        self.scrollView.addSubview(lbPhiBH)
        self.scrollView.addSubview(edtPhiBH)
        self.scrollView.addSubview(lbPhiBHTrenXe)
        self.scrollView.addSubview(edtPhiBHTrenXe)
        self.scrollView.addSubview(edtTongTienThu)
        self.scrollView.addSubview(lbTongTienThu)
        self.scrollView.addSubview(imageCheckTienMat)
        self.scrollView.addSubview(lbTienMat)
        self.scrollView.addSubview(imageCheckThe)
        self.scrollView.addSubview(lbTienThe)
        
        self.scrollView.addSubview(lbTienMatThanhToan)
        self.scrollView.addSubview(lbTienTheThanhToan)
        self.scrollView.addSubview(edtTienMat)
        self.scrollView.addSubview(edtTienThe)
        self.scrollView.addSubview(lbTienTong)
        self.scrollView.addSubview(edtTienTong)
        self.scrollView.addSubview(btnDone)
        
        self.view.addSubview(loadingView)
        
        self.hideKeyboardWhenTappedAround()
        
        let mDate = Date()
        let mFormatter = DateFormatter()
        mFormatter.dateFormat = "dd-MM-yyyy"
        edtNgayBatDau.text = mFormatter.string(from: mDate)
        
        
        
        edtNgayKetThuc.text = mFormatter.string(from: mDate)
        
        let date = Calendar.current.date(byAdding: .day, value: +364, to: Date())
        edtNgayKetThuc.text = mFormatter.string(from: date!)
        //edtNgayKetThuc.text = "\(sSplitString1![0])-\(sSplitString1![1])-\(mTimeYear)"
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let countRow = arrCardTypeFromPOS.count
        print("rowwww \(countRow)")
        return countRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellSearch: ItemSearchNameKHTableViewCell?
        cellSearch = ItemSearchNameKHTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemSearchNameKHTableViewCell")
        
        if(arrCardTypeFromPOS.count > 0 )
        {
            /////addnew11/8
            cellSearch?.contentView.tag = indexPath.row
            cellSearch?.delegate = self
            cellSearch?.name.text =  " \(arrCardTypeFromPOS[indexPath.row].Text)";
            cellSearch?.nhaCC.text = "Thanh toán thẻ";
            cellSearch?.tenDV.text = "Phí :\(arrCardTypeFromPOS[indexPath.row].PercentFee)";
            
            cellSearch?.tenDV.frame.origin.y =  (cellSearch?.tenDV.frame.origin.y)! - Common.Size(s: 40)
            cellSearch?.nhaCC.frame.origin.y =  (cellSearch?.nhaCC.frame.origin.y)! - Common.Size(s: 40)
            cellSearch?.line1.frame.origin.y =  (cellSearch?.line1.frame.origin.y)! - Common.Size(s: 40)
            cellSearch?.line2.frame.origin.y =  (cellSearch?.line2.frame.origin.y)! - Common.Size(s: 40)
            cellSearch?.contentView.tag = indexPath.row
            
        }
        return cellSearch!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return (Common.Size(s:16)) * 3 ;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        mCardTypeArr.removeAll()
        mCardTypeArr.append(arrCardTypeFromPOS[indexPath.row])
        self.mViewPayCardPercent.isHidden = true
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = false
    }
    @objc func checkDate(stringDate:String) -> Bool{
           let dateFormatterGet = DateFormatter()
           dateFormatterGet.dateFormat = "dd-MM-yyyy"
           
           if let _ = dateFormatterGet.date(from: stringDate) {
               return true
           } else {
               return false
           }
       }
    func checkpromotionFRTBaoHiem(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.checkpromotionfrtBaoHiem() { (status,message, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(status == 1){
                        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            self.isPromotionFRT = false
                            self.imageCheckPromotionFRT.image = #imageLiteral(resourceName: "iconuncheck")
                        })
                        self.present(alert, animated: true)
                    }else{
                        
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
class ItemSearchNameKHTableViewCell: UITableViewCell {
    
    var delegate: ItemSearchNameKHTableViewCellDelegate?
    
    var sdt: UILabel!
    var name: UILabel!
    var maHD: UILabel!
    var tenDV: UILabel!
    var line1: UIView!
    var line2: UIView!
    
    var nhaCC: UILabel!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        //self.backgroundColor = UIColor.red
        
        name = UILabel()
        name.textColor = UIColor.black
        name.numberOfLines = 1
        name.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        contentView.addSubview(name)
        
        sdt = UILabel()
        sdt.textColor = UIColor.gray
        sdt.numberOfLines = 1
        sdt.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(sdt)
        
        maHD = UILabel()
        maHD.textColor = UIColor.gray
        maHD.numberOfLines = 1
        maHD.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(maHD)
        
        
        tenDV = UILabel()
        tenDV.textColor = UIColor.gray
        tenDV.numberOfLines = 1
        tenDV.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(tenDV)
        
        
        
        nhaCC = UILabel()
        nhaCC.numberOfLines = 1
        nhaCC.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        contentView.addSubview(nhaCC)
        
        name.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        
        
        sdt.frame = CGRect(x:name.frame.origin.x ,y: name.frame.origin.y + name.frame.size.height +  Common.Size(s:5),width: name.frame.size.width ,height: Common.Size(s:13))
        
        
        maHD.frame = CGRect(x:sdt.frame.origin.x ,y: sdt.frame.origin.y + sdt.frame.size.height +  Common.Size(s:5) ,width: sdt.frame.size.width ,height: Common.Size(s:13))
        
        line1 = UIView(frame: CGRect(x: maHD.frame.origin.x, y:maHD.frame.origin.y + maHD.frame.size.height + Common.Size(s:5), width: 1, height: Common.Size(s:16)))
        line1.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line1)
        
        line2 = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width/3 + Common.Size(s:10), y:line1.frame.origin.y, width: 1, height: Common.Size(s:16)))
        line2.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line2)
        
        
        
        tenDV.frame = CGRect(x:line1.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: name.frame.size.width/3,height:line1.frame.size.height)
        
        
        
        
        
        nhaCC.frame = CGRect(x:line2.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: name.frame.size.width/3 * 2,height:line1.frame.size.height)
        
        
        let tapGestureRecognizerCheck = UITapGestureRecognizer(target: self, action: #selector(TapContentView(tapGestureRecognizer:)))
        contentView.isUserInteractionEnabled = true
        contentView.addGestureRecognizer(tapGestureRecognizerCheck)
        
        
        
    }
    
    @objc func TapContentView(tapGestureRecognizer: UITapGestureRecognizer)
    {
        delegate?.clickFromTableView(sender: self, iIndex:contentView.tag )
    }
    
    
}

protocol ItemSearchNameKHTableViewCellDelegate {
    
    func clickFromTableView(sender: ItemSearchNameKHTableViewCellDelegate, iIndex:Int )
}

extension ItemSearchNameKHTableViewCell: ItemSearchNameKHTableViewCellDelegate
{
    func clickFromTableView(sender: ItemSearchNameKHTableViewCellDelegate, iIndex:Int )
    {
        
    }
    
    
}
