//
//  BaoHanhTaoPhieuMainController.swift
//  mPOS
//
//  Created by sumi on 12/14/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit

import PopupDialog

//import EPSignature
import AVFoundation
class BaoHanhTaoPhieuMainController: UIViewController , UIGestureRecognizerDelegate ,UITableViewDataSource, UITableViewDelegate,ItemListTabPKTableViewCellDelegate , ItemListTabMoTaLoiTableViewCellDelegate,BaoHanhViewDialogDelegate,UITextFieldDelegate,EPSignatureDelegate,InputIcloudDayBHViewControllerDelegate{
    
    func returnDate(input: String, index:Int) {
        self.dayIcloud = input
        if(input == ""){
            arrTinhTrangMay[index].KHGiaoShop = "false"
          self.baoHanhMoTaLoiView.tableView.reloadData()
        }
    }
    
    
    var p_IsCapMobile:Int = 0
    
    func editDoneTTKH(sender: ItemListTabPKTableViewCellDelegate, iIndex: Int, iValue: String) {
        if(arrPhuKien[iIndex].KHGiaoShop == "true")
        {
            arrPhuKien[iIndex].TinhTrangShop = "\(iValue)"
        }
        self.baoHanhPKKemTheoView.tableView.reloadData()
    }
    
    func didClose(sender: BaoHanhViewDialogDelegate) {
        self.baohanhViewDialog.isHidden = true
    }
    
    func editDoneSL(sender: ItemListTabPKTableViewCellDelegate, iIndex: Int, iValue: String) {
        if(arrPhuKien[iIndex].KHGiaoShop == "true")
        {
            if(iValue == "0")
            {
                showDialog(mMess: "Vui lòng chọn lại số lượng phụ kiện.")
                arrPhuKien[iIndex].SoLuong = "\(iValue)"
            }
            else
            {
                arrPhuKien[iIndex].SoLuong = "\(iValue)"
            }
            self.baoHanhPKKemTheoView.tableView.reloadData()
        }
    }
    
    func editDone(sender: ItemListTabPKTableViewCellDelegate, iIndex: Int, iValue: String) {
        
        arrPhuKien[iIndex].Serial = "\(iValue)"
        print("click into \(iIndex) value \(iValue)")
        self.baoHanhPKKemTheoView.tableView.reloadData()
    }
    
    func checkClickFromTableView(sender: ItemListTabMoTaLoiTableViewCellDelegate, iIndex: Int) {
        print("click into \(iIndex)")
        if(arrTinhTrangMay[iIndex].KHGiaoShop == "true")
        {
            arrTinhTrangMay[iIndex].KHGiaoShop = "false"
         
        }
        else
        {
            arrTinhTrangMay[iIndex].KHGiaoShop = "true"
            if(arrTinhTrangMay[iIndex].MaTinhTrang == "11"){
                if let index = arrTinhTrangMay.firstIndex(where: { $0.MaTinhTrang == "18" }) {
                    if(arrTinhTrangMay[index].KHGiaoShop == "true"){
                        arrTinhTrangMay[index].KHGiaoShop = "false"
                    }
                }
            }
            if(arrTinhTrangMay[iIndex].MaTinhTrang == "18"){
                
                if let index = arrTinhTrangMay.firstIndex(where: { $0.MaTinhTrang == "11" }) {
                    if(arrTinhTrangMay[index].KHGiaoShop == "true"){
                        arrTinhTrangMay[index].KHGiaoShop = "false"
                    }
                }
                
                let myVC = InputIcloudDayBHViewController()
                myVC.delegate = self
                myVC.indexID = iIndex
                self.navigationController?.pushViewController(myVC, animated: true)
                
            }
        }
        
        self.baoHanhMoTaLoiView.tableView.reloadData()
    }
    
    func checkClickFromTableView(sender: ItemListTabPKTableViewCellDelegate, iIndex: Int) {
        print("click into \(iIndex)")
        if(arrPhuKien[iIndex].KHGiaoShop == "false")
        {
            arrPhuKien[iIndex].KHGiaoShop = "true"
            arrPhuKien[iIndex].SoLuong = "1"
        }
        else
        {
            arrPhuKien[iIndex].KHGiaoShop = "false"
            arrPhuKien[iIndex].SoLuong = "0"
        }
        
        self.baoHanhPKKemTheoView.tableView.reloadData()
        
    }
    
    var mSigned:Int = 0
    var mArrayBaoHanhUploadImageNewObject  = [BaoHanhUploadImageNewObject]()
    var mString64Custom:String = ""
    var mString64Employ:String = ""
    var mString64Manager:String = ""
    var mImeiPush:String?
    var mScreen:Int = 0
    var processView:ProcessView!
    var arrCheckimei_V2Result:Checkimei_V2Result?
    var arrCheckimei_V2Result2:Checkimei_V2_ImeiInfoServices_Result?
    var arrCheckimei_V2Result3:[Checkimei_V2_LoadHTBH_Result]?
    /////tab bao hanh
    var arrPhuKien = [LayThongTinPhuKienResult]()
    var arrPhuKienAll = [LayThongTinPhuKienResult]()
    /////tab mo ta loi
    var arrTinhTrangMay = [LayTinhTrangMayResult]()
    
    
    var cellRow2: ItemListTabMoTaLoiTableViewCell?
    var cellRow: ItemListTabPKTableViewCell?
    var countRow:Int = 0
    var baohanhMainView:BaoHanhTaoPhieuMainView!
    var baohanhThongTinChungView:BaoHanhThongTinChungView!
    
    /////tab viewDialog
    var baohanhViewDialog:BaoHanhViewDialog!
    
    /////tab phụ kiện
    var baoHanhPKKemTheoView:BaoHanhPKKemTheoView!
    /////tab mô tả
    var baoHanhMoTaLoiView:BaoHanhMoTaLoiView!
    var posImageUpload = -1
    var numUPLoadImage = 0
    var isImageOne = false
    var isImageTwo = false
    var isImageThree = false
    var isImageFour = false
    var isImageFive = false
    var isImageSix = false
    
    var isImageChuKyNV = true
    var isImageChuKyQL = true
    var isImageChuKyKH = true
    
    var strChuoiDinhKem1:String = ""
    var strChuoiDinhKem2:String = ""
    var strChuoiDinhKem3:String = ""
    var strChuoiDinhKem4:String = ""
    var strChuoiDinhKem5:String = ""
    var strChuoiDinhKem6:String = ""
    
    var strChuoiDinhKemChuKyNV:String = ""
    var strChuoiDinhKemChuKyQL:String = ""
    var strChuoiDinhKemChuKyKH:String = ""
    
    //////tab thông tin đến hãng
    var baoHanhThongTinHang:ThongTinDenHangView!
    //////////list for create bill
    var strLoaiBH = ""
    var strHinhThucBH = ""
    var strMoTaLoi = ""
    var strDienGiai = ""
    var strNgayDuKienTra = ""
    var strMaShopTao = ""
    var strTenShopTao = ""
    var strNhanVienTao = ""
    var strMaTTBH1 = ""
    var strMaTTBH2 = ""
    var strMaHTBanGiao = ""
    var strTenHTBanGiao = ""
    var strSoNgayCamKet = ""
    var strSanPhamBH = ""
    var strSolanBH = ""
    var strSoDonHang = ""
    var strMaCuaHangBan = ""
    var strTenCuaHangBan = ""
    var strLoaiDonHang = ""
    var strMaSanPham = ""
    var strTenSanPham = ""
    var strNgayHetHanBH = ""
    var strNgayMua = ""
    var strSoHoaDonDo = ""
    var strImei = ""
    var strImei2 = ""
    var strMaSPBHV = ""
    var strSoLanBHV = ""
    var strMaHopDongBHV = ""
    var strTrangThaiBHV = ""
    var strMauSac = ""
    var strTenKH = ""
    var strSoDienThoaiKH = ""
    var strSoDienThoaiKhac = ""
    var strDiaChi = ""
    var strGhiChu = ""
    var strEmail = ""
    var strMaKho = ""
    var strListPhuKienXML = ""
    var strListTinhTrangMayXML = ""
    var strChuoiDinhKem = ""
    var strMaSPBHNhanh = ""
    var strMaHDBHNhanh = ""
    var strHieuLucBHNhanh = ""
    var strMaSPBHTanNoi = ""
    var strMaHDBHTanNoi = ""
    var strHieuLucBHTanNoi = ""
    var strMaSPBHVIP = ""
    var strMaHDBHVIP = ""
    var strHieuLucVIP = ""
    var strMaBook = ""
    var strMaSPSamSungVIP = ""
    var strMaHDSamSungVIP = ""
    var strHieuLucSamSungVIP = ""
    /////
    var strNgayBaoHanh = ""
    var strNganhHang = ""
    var strHang = ""
    
    var strNhanHang = ""
    var strLockKnox = ""
    var strSO_NOIBO = ""
    var strMaNhomHangCRM = ""
    var isSamsung = false
    var strThongBaoPhieu = ""
    var strLoaiHang = ""
    var strMaPhieu_BH = ""
    var imei:String = ""
    
    var canClickToTab = true
    var barSearchRight : UIBarButtonItem!
    var dayIcloud:String = ""
    // rule Tao Phieu BH from Máy demo
    var listErrorIDMayDemoString = ""
    var xmlImgMayDemo = ""
    var isMayDemo = false
    var errorNameMayDemoBH = ""
    var itemMayDemo:ProductDemoBH?
    var isDemo = 0
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Trở về", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.CloseClick(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        //
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x47B054)
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        
        let btSearchIcon = UIButton.init(type: .custom)
        btSearchIcon.setImage(#imageLiteral(resourceName: "ReloadPO"), for: UIControl.State.normal)
        btSearchIcon.imageView?.contentMode = .scaleAspectFit
        btSearchIcon.addTarget(self, action: #selector(actionRefresh), for: UIControl.Event.touchUpInside)
        btSearchIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barSearchRight = UIBarButtonItem(customView: btSearchIcon)
        self.navigationItem.rightBarButtonItems = [barSearchRight]
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("1iPhone 5 or 5S or 5C")
                baohanhMainView = BaoHanhTaoPhieuMainView.init(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height -  (navigationController?.navigationBar.frame.size.height)! - Common.Size(s: 65), width: UIScreen.main.bounds.size.width, height: Common.Size(s: 50)))
            case 1334:
                print("1iPhone 6/6S/7/8")
                baohanhMainView = BaoHanhTaoPhieuMainView.init(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height -  (navigationController?.navigationBar.frame.size.height)! - Common.Size(s: 65), width: UIScreen.main.bounds.size.width, height: Common.Size(s: 50)))
            case 2208:
                print("1iPhone 6+/6S+/7+/8+")
                baohanhMainView = BaoHanhTaoPhieuMainView.init(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height -  (navigationController?.navigationBar.frame.size.height)! - Common.Size(s: 65), width: UIScreen.main.bounds.size.width, height: Common.Size(s: 50)))
            case 2436:
                print("1iPhone X")
                baohanhMainView = BaoHanhTaoPhieuMainView.init(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height -  (navigationController?.navigationBar.frame.size.height)! - Common.Size(s: 80), width: UIScreen.main.bounds.size.width, height: Common.Size(s: 50)))
            default:
                print("1iPhone unknown")
                baohanhMainView = BaoHanhTaoPhieuMainView.init(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height -  (navigationController?.navigationBar.frame.size.height)! - Common.Size(s: 65), width: UIScreen.main.bounds.size.width, height: Common.Size(s: 50)))
            }
        }
        baohanhThongTinChungView = BaoHanhThongTinChungView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - baohanhMainView.frame.size.height ))
        
        baohanhThongTinChungView.scrollView.frame.size.height = UIScreen.main.bounds.size.height - baohanhMainView.frame.size.height
        
        baoHanhPKKemTheoView = BaoHanhPKKemTheoView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - baohanhMainView.frame.size.height ))
        
        baoHanhMoTaLoiView = BaoHanhMoTaLoiView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - baohanhMainView.frame.size.height - Common.Size(s: 20)))
        
        baoHanhThongTinHang = ThongTinDenHangView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - baohanhMainView.frame.size.height  ))
        
        
        baohanhViewDialog = BaoHanhViewDialog.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - baohanhMainView.frame.size.height ))
        
        
        processView = ProcessView.init(frame: CGRect(x: 0, y: -Common.Size(s: 50), width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - baohanhMainView.frame.size.height + Common.Size(s: 50) ))
        
        self.view.addSubview(baoHanhPKKemTheoView)
        self.view.addSubview(baohanhThongTinChungView)
        self.view.addSubview(baoHanhMoTaLoiView)
        self.view.addSubview(baoHanhThongTinHang)
        self.view.addSubview(baohanhMainView)

        self.view.addSubview(processView)

        self.view.addSubview(baohanhViewDialog)
        baohanhViewDialog.baoHanhViewDialogDelegate = self
        baohanhViewDialog.isHidden = true
        
        
        processView.isHidden = true
        initFunction()
        // Do any additional setup after loading the view.
        
        self.baoHanhPKKemTheoView.isHidden = true
        self.baoHanhMoTaLoiView.isHidden = true
        self.baoHanhThongTinHang.isHidden = true
        
        //////func init
        let tapMore = UITapGestureRecognizer(target: self, action: #selector(self.TapMore))
        baohanhThongTinChungView.txtXemThongTinSP.isUserInteractionEnabled = true
        baohanhThongTinChungView.txtXemThongTinSP.addGestureRecognizer(tapMore)
        
        
        let tapSearch = UITapGestureRecognizer(target: self, action: #selector(self.TapSearch))
        baohanhThongTinChungView.txtTitleDetails.isUserInteractionEnabled = true
        baohanhThongTinChungView.txtTitleDetails.addGestureRecognizer(tapSearch)
        
        let tapChon = UITapGestureRecognizer(target: self, action: #selector(self.TapChon))
        baohanhThongTinChungView.txtChonMaSP.isUserInteractionEnabled = true
        baohanhThongTinChungView.txtChonMaSP.addGestureRecognizer(tapChon)
        
        
        
        let tapScan = UITapGestureRecognizer(target: self, action: #selector(self.TapScan))
        baohanhThongTinChungView.txtTitleScan.isUserInteractionEnabled = true
        baohanhThongTinChungView.txtTitleScan.addGestureRecognizer(tapScan)
        
        /////func click tab
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaoHanhTaoPhieuMainController.ClickTabPK(gestureRecognizer:)))
        gestureRecognizer.delegate = self
        baohanhMainView.viewPhuKien.addGestureRecognizer(gestureRecognizer)
        
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(BaoHanhTaoPhieuMainController.ClickTabThongTin(gestureRecognizer:)))
        gestureRecognizer2.delegate = self
        baohanhMainView.viewThongTin.addGestureRecognizer(gestureRecognizer2)
        
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(BaoHanhTaoPhieuMainController.ClickTabMoTa(gestureRecognizer:)))
        gestureRecognizer3.delegate = self
        baohanhMainView.viewMoTaLoi.addGestureRecognizer(gestureRecognizer3)
        
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(BaoHanhTaoPhieuMainController.ClickTabThongTinHang(gestureRecognizer:)))
        gestureRecognizer4.delegate = self
        //baohanhMainView.viewTTHang.addGestureRecognizer(gestureRecognizer4)
        
        
        ////func search imei imageview click
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageSearchImeiTapped(tapGestureRecognizer:)))
        baohanhThongTinChungView.imageImei.isUserInteractionEnabled = true
        baohanhThongTinChungView.imageImei.addGestureRecognizer(tapGestureRecognizer)
        
        ////
        let tapGestureRecognizerBH = UITapGestureRecognizer(target: self, action: #selector(imageSearchBHTapped(tapGestureRecognizer:)))
        baohanhThongTinChungView.imageBHButton.isUserInteractionEnabled = true
        baohanhThongTinChungView.imageBHButton.addGestureRecognizer(tapGestureRecognizerBH)
        
        
        /////
        let tapGestureRecognizerImageLogo1 = UITapGestureRecognizer(target: self, action: #selector(imageLogoTapped(tapGestureRecognizer:)))
        baohanhThongTinChungView.viewLogo.isUserInteractionEnabled = true
        baohanhThongTinChungView.viewLogo.addGestureRecognizer(tapGestureRecognizerImageLogo1)
        
        
        baohanhThongTinChungView.btnHoanTat.addTarget(self, action: #selector(self.ClickTiepTheoStepOne), for: .touchUpInside)
        
        initTabPK()
        initTabMoTaLoi()
        initTabTTDenHang()
//        BackFromSearch()
        //TestObjectToArrayJson()
        
        baohanhThongTinChungView.hinhthucBHButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.baohanhThongTinChungView.hinhthucBHButton.text = "\(item.title)"
            print("choose \(item.title)")
            if(item.title == "Bảo hành")
            {
                self.strHinhThucBH = "10"
            }
            if(item.title == "Dịch vụ")
            {
                self.strHinhThucBH = "20"
            }
            if(item.title == "Bảo hành vàng")
            {
                self.strHinhThucBH = "30"
            }
            if(item.title == "Thẩm định lỗi")
            {
                self.strHinhThucBH = "40"
            }
            self.view.endEditing(true)
            ////"26" = dell
            if(self.strNhanHang == "26" && item.title == "Bảo hành")
            {
                self.showDialog(mMess: "Bạn đang chọn HTBH là bảo hành: 100% máy sẽ được bảo hành theo chính sách bảo hành tại chỗ của Dell")
            }
            if(self.strNhanHang == "26" && item.title == "Dịch vụ")
            {
                self.showDialog(mMess: "Bạn đang chọn HTBH là dịch vụ: 100% máy phải bàn giao về TTBH FRT")
            }
            if(self.strNhanHang == "26" && item.title == "Thẩm định lỗi")
            {
                self.showDialog(mMess: "Bạn đang chọn HTBH là thẩm định lỗi: 100% máy phải bàn giao về TTBH FRT")
            }
            
            
            self.GetDataLoadHinhThucBanGiao(p_MaCuaHang: "\(Cache.user!.ShopCode)",p_NganhHang:"\(self.strNganhHang)",p_LoaiHang: "\(self.strLoaiHang)",p_NhomHangCRM:"\(self.strMaNhomHangCRM)",p_Hang: "\(self.strNhanHang)",p_HinhThucBH:"\(self.strHinhThucBH)",p_LoaiBH:"\(self.strHinhThucBH)")
        }
        baohanhThongTinChungView.hinhthucBHButton.isEnabled = false
        
        //rule may demo BH
        if isMayDemo {
            self.imei = self.itemMayDemo?.imei ?? ""
            self.baohanhThongTinChungView.edtImei.text = self.itemMayDemo?.imei ?? ""
            baoHanhMoTaLoiView.edtMoTaLoi.text = "\(errorNameMayDemoBH)"
            baoHanhMoTaLoiView.edtMoTaLoi.font = UIFont.systemFont(ofSize: 13)
            
            GetDataCheckimei_V2(p_Imei: "\(self.baohanhThongTinChungView.edtImei.text!)",p_BILL: "",p_SO_DocNum: "0",p_PhoneNumber: "",p_Type: "0",mTypeCall: "0")
            self.baohanhThongTinChungView.edtImei.isEnabled = false
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(BackFromSearch), name: NSNotification.Name.init("searchTaoPhieuBH"), object: nil)
    }
    
    @objc func actionRefresh(){
        
        self.baohanhThongTinChungView.edtImei.text = ""
        self.baohanhThongTinChungView.hinhthucBHButton.text = ""
        self.baohanhThongTinChungView.loaiBHButton.text = ""
        self.baohanhThongTinChungView.edtMaSp.text = ""
        self.baohanhThongTinChungView.radioMarket.isSelected = false
        self.baohanhThongTinChungView.edtTenSp.text = ""
        self.baohanhThongTinChungView.edtHanBH.text = ""
        self.baohanhThongTinChungView.edtImei2.text = ""
        self.baohanhThongTinChungView.edtHinhThucBH2.text = ""
        self.baohanhThongTinChungView.edtTTBHHang.text = ""
        self.baohanhThongTinChungView.edtTTBHFRT.text = ""
        self.baohanhThongTinChungView.edtTenLienHe.text = ""
        self.baohanhThongTinChungView.edtSDTLienHe.text = ""
        self.baohanhThongTinChungView.edtSDTLienHeKhac.text = ""
        self.baohanhThongTinChungView.edtMailLienHe.text = ""
        self.baohanhThongTinChungView.edtDiaChiLienHe.text = ""
        self.baohanhThongTinChungView.edtGhiChuLienHe.text = ""
        // update mota loi from may demo
        if isMayDemo {
            self.imei = self.itemMayDemo?.imei ?? ""
            self.baohanhThongTinChungView.edtImei.text = self.itemMayDemo?.imei ?? ""
            baoHanhMoTaLoiView.edtMoTaLoi.text = "\(errorNameMayDemoBH)"
            baoHanhMoTaLoiView.edtMoTaLoi.font = UIFont.systemFont(ofSize: 13)
            
            GetDataCheckimei_V2(p_Imei: "\(self.baohanhThongTinChungView.edtImei.text!)",p_BILL: "",p_SO_DocNum: "0",p_PhoneNumber: "",p_Type: "0",mTypeCall: "0")
            self.baohanhThongTinChungView.edtImei.isEnabled = false
            
        }
        //
        print("asdsadsa")
        self.baoHanhPKKemTheoView.isHidden = true
        self.baohanhThongTinChungView.isHidden = false
        self.baoHanhMoTaLoiView.isHidden = true
        self.baoHanhThongTinHang.isHidden = true
        
        self.ChangeColorPushToThongTin()
    }
    
    func CheckHinhThucBH()
    {
        if(self.baohanhThongTinChungView.hinhthucBHButton.text == "Bảo hành")
        {
            self.strHinhThucBH = "10"
        }
        if(self.baohanhThongTinChungView.hinhthucBHButton.text == "Dịch vụ")
        {
            self.strHinhThucBH = "20"
        }
        if(self.baohanhThongTinChungView.hinhthucBHButton.text == "Bảo hành vàng")
        {
            self.strHinhThucBH = "30"
        }
        if(self.baohanhThongTinChungView.hinhthucBHButton.text == "Thẩm định lỗi")
        {
            self.strHinhThucBH = "40"
        }
        ////"26" = dell
        if(self.strNhanHang == "26" && self.baohanhThongTinChungView.hinhthucBHButton.text == "Bảo hành")
        {
            self.showDialog(mMess: "Bạn đang chọn HTBH là bảo hành: 100% máy sẽ được bảo hành theo chính sách bảo hành tại chỗ của Dell")
        }
        if(self.strNhanHang == "26" && self.baohanhThongTinChungView.hinhthucBHButton.text == "Dịch vụ")
        {
            self.showDialog(mMess: "Bạn đang chọn HTBH là dịch vụ: 100% máy phải bàn giao về TTBH FRT")
        }
        if(self.strNhanHang == "26" && self.baohanhThongTinChungView.hinhthucBHButton.text == "Thẩm định lỗi")
        {
            self.showDialog(mMess: "Bạn đang chọn HTBH là thẩm định lỗi: 100% máy phải bàn giao về TTBH FRT")
        }
        
        
    }
    
    
    @objc func CloseClick(sender: UIBarButtonItem)
    {
        if self.isMayDemo {
            for vc in self.navigationController?.viewControllers ?? [] {
                if vc is MayDemoBHMainViewController {
                    self.navigationController!.popToViewController(vc, animated: true)
                    NotificationCenter.default.post(name: NSNotification.Name.init("didEnter_mayDemoBH"), object: nil)
                }
            }
        } else {
            self.navigationController!.popToRootViewController(animated: true)
        }
    }
    
    /////check tab 4
    func GetDataGoiPopupHang_Mobile(p_MaPhieuBH:String,ThongBaoLoi:String)
    {
        MPOSAPIManager.GoiPopupHang_Mobile(p_MaPhieuBH: p_MaPhieuBH){ (error: Error? , success: Bool,result: GoiPopupHang_MobileResult?) in
            if success
            {
                self.showProcessView(mShow: false)
                if(result?.Result == "1")
                {
                    self.showDialog(mMess: "Vui lòng nhập thông tin và hoàn tất")
                    self.baoHanhPKKemTheoView.isHidden = true
                    self.baohanhThongTinChungView.isHidden = true
                    self.baoHanhMoTaLoiView.isHidden = true
                    self.baoHanhThongTinHang.isHidden = false
                    self.ChangeColorPushTTHang()
                    self.canClickToTab = false
                }
                else
                {
                    //Toast(text: "Auto mail cho hãng thất bại").show()
//                    self.showDialogAndPushToView(mMess: "Số phiếu: \(p_MaPhieuBH)\r\n\(ThongBaoLoi)")
                    //demo demo
                    if self.isMayDemo {
                        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                            MPOSAPIManager.Products_Demo_Warranty_Update(id: "\(self.itemMayDemo?.id ?? 0)", xmlimage: self.xmlImgMayDemo, list_type_error: self.listErrorIDMayDemoString, warranty_code: "\(p_MaPhieuBH)") { (rsCode, msg, err) in
                                WaitingNetworkResponseAlert.DismissWaitingAlert {
                                    if err.count <= 0 {
                                        if rsCode == 1{
                                            let popup = PopupDialog(title: "THÔNG BÁO", message: "\(ThongBaoLoi)\n Số phiếu BH: \(p_MaPhieuBH) \n Cập nhật máy demo thành công!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                print("Completed")
                                            }
                                            let buttonOne = DefaultButton(title: "OK") {
                                                for vc in self.navigationController?.viewControllers ?? [] {
                                                    if vc is MayDemoBHMainViewController {
                                                        self.navigationController!.popToViewController(vc, animated: true)
                                                        NotificationCenter.default.post(name: NSNotification.Name.init("didEnter_mayDemoBH"), object: nil)
                                                    }
                                                }
                                            }
                                            popup.addButtons([buttonOne])
                                            self.present(popup, animated: true, completion: nil)
                                        } else {
                                            let alert = UIAlertController(title: "Thông báo", message: "\(msg)", preferredStyle: .alert)
                                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                            alert.addAction(action)
                                            self.present(alert, animated: true, completion: nil)
                                        }
                                    } else {
                                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                        alert.addAction(action)
                                        self.present(alert, animated: true, completion: nil)
                                    }
                                }
                            }
                        }
                    } else {
                        self.showDialogAndPushToView(mMess: "Số phiếu: \(p_MaPhieuBH)\r\n\(ThongBaoLoi)")
                    }
                    self.showProcessView(mShow: false)
                }
            }
            else
            {
                
            }
        }
    }
    
    
    func GetDataAutoMailChoHang(p_MaPhieuBH: String,p_BuocKiemTra:String,p_KetLuan:String,p_MalinhKien:String,p_GhiChu:String,p_Type:String)
    {
        MPOSAPIManager.TaoPhieuBH_AutoMailChoHang(p_MaPhieuBH: p_MaPhieuBH,p_BuocKiemTra:p_BuocKiemTra,p_KetLuan:p_KetLuan,p_MalinhKien:p_MalinhKien,p_GhiChu:p_GhiChu,p_Type:p_Type){ (error: Error? , success: Bool,result: AutoMailChoHangResult!) in
            if success
            {
                if(result.Test == "1")
                {
                    self.showDialogAndPushToView(mMess: "Tạo phiếu bảo hành thành công - Số phiếu \(p_MaPhieuBH)")
                    let newViewController = BaoHanhTaoPhieuMainController()
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
                else
                {
                    self.showDialogAndPushToView(mMess: "Tạo phiếu bảo hành - Số phiếu \(p_MaPhieuBH) thất bại")
                }
            }
            else
            {
                
            }
        }
    }
    
    /////checked Hong3PK
    func CheckHongPK()
    {
        if(baohanhThongTinChungView.radioMarket.isSelected)
        {
            self.strSanPhamBH = "1"
            arrPhuKien.removeAll()
            for i in 0 ..< arrPhuKienAll.count
            {
                if(arrPhuKienAll[i].BaoHanh == "true")
                {
                    arrPhuKien.append(arrPhuKienAll[i])
                }
            }
        }
        else
        {
            self.strSanPhamBH = "0"
            arrPhuKien.removeAll()
            arrPhuKien = arrPhuKienAll
        }
        baoHanhPKKemTheoView.tableView.reloadData()
    }
    
    
    
    /////func get photo
    @objc func tapShowImagePick1(sender:UITapGestureRecognizer) {
        self.posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowImagePick2(sender:UITapGestureRecognizer) {
        if(self.isImageOne == true)
        {
            self.posImageUpload = 2
            self.thisIsTheFunctionWeAreCalling()
        }
        else
        {
            
            self.showDialog(mMess: "Vui lòng đính kèm ảnh thứ nhất!")
        }
        
    }
    @objc func tapShowImagePick3(sender:UITapGestureRecognizer) {
        if(self.isImageTwo == true)
        {
            self.posImageUpload = 3
            self.thisIsTheFunctionWeAreCalling()
        }
        else
        {
            self.showDialog(mMess: "Vui lòng đính kèm ảnh thứ hai!")
            
        }
        
    }
    
    @objc func tapShowImagePick4(sender:UITapGestureRecognizer) {
        if(self.isImageThree == true)
        {
            self.posImageUpload = 4
            self.thisIsTheFunctionWeAreCalling()
        }
        else
        {
            
            self.showDialog(mMess: "Vui lòng đính kèm ảnh thứ ba!")
        }
        
    }
    
    @objc func tapShowImagePick5(sender:UITapGestureRecognizer) {
        if(self.isImageFour == true)
        {
            self.posImageUpload = 5
            self.thisIsTheFunctionWeAreCalling()
        }
        else
        {
            
            self.showDialog(mMess: "Vui lòng đính kèm ảnh thứ tư!")
        }
        
    }
    
    @objc func tapShowImagePick6(sender:UITapGestureRecognizer) {
        if(self.isImageFive == true)
        {
            self.posImageUpload = 6
            self.thisIsTheFunctionWeAreCalling()
        }
        else
        {
            
            self.showDialog(mMess: "Vui lòng đính kèm ảnh thứ năm!")
        }
        
    }
    
    
    func showProcessView(mShow:Bool)
    {
        self.processView.isHidden = !mShow
    }
    
    func showDialog(mMess:String)
    {
        let title = "THÔNG BÁO"
        let message = "\(mMess)"
        
        
        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            print("Completed")
        }
        
        let buttonOne = DefaultButton(title: "OK") {
            
        }
        popup.addButtons([buttonOne])
        self.present(popup, animated: true, completion: nil)
    }
    
    func showDialogAndPushToView(mMess:String)
    {
        let title = "THÔNG BÁO"
        let message = "\(mMess)"
        
        
        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            print("Completed")
        }
        
        
        let buttonOne = DefaultButton(title: "OK") {
            let newViewController = BaoHanhTaoPhieuMainController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        popup.addButtons([buttonOne])
        self.present(popup, animated: true, completion: nil)
    }
    
    func GetThongBaoAfterCheckImei(mData:Checkimei_V2Result)
    {
        if(mData.LockKnox == "2")
        {
            showDialog(mMess: "Máy đang thuộc trường hợp nợ quá hạn chưa thanh toán.\nVui lòng thông báo KH thanh toán phí trước khi đi Bảo Hành")
        }
        if (self.isDemo != 1) {
            if(mData.SO_NOIBO == "1")
            {
                showDialog(mMess: "Imei đang tồn kho nội bộ, không thể bảo hành cho khách.")
            }
        }
    }
    
    func GetThongBaoAfferClickHoanTat()->Bool
    {
        if(self.baoHanhMoTaLoiView.edtMoTaLoi.text == "")
        {
            showDialog(mMess: "Vui lòng nhập mô tả lỗi.")
            return false
        }
        if(strMaNhomHangCRM == "1")
        {
            for i in 0 ..< arrTinhTrangMay.count
            {
                
                if(self.arrTinhTrangMay[i].TenTinhTrang == "Gỡ mật khẩu máy" && self.arrTinhTrangMay[i].KHGiaoShop == "false")
                {
                    showDialog(mMess: "Vui lòng gỡ mật khẩu máy.")
                    return false
                }
                
            }
            
        }
        
        if(self.strNhanHang == "9" )
        {
            if(self.strMaNhomHangCRM == "1" || self.strMaNhomHangCRM == "4")
            {
                for i in 0 ..< arrTinhTrangMay.count
                {
                    
                    if(self.arrTinhTrangMay[i].TenTinhTrang == "Thoát Icloud" && self.arrTinhTrangMay[i].KHGiaoShop == "false")
                    {
                        if(dayIcloud == ""){
                            showDialog(mMess: "Vui lòng kiểm tra Icloud")
                            return false
                        }
                        
                    }
                    
                    
                }
            }
            
        }
        if(self.strNganhHang == "01" && self.strLoaiHang == "107")
        {
            for i in 0 ..< arrTinhTrangMay.count
            {
                
                if(self.arrTinhTrangMay[i].TenTinhTrang == "Thoát Icloud" && self.arrTinhTrangMay[i].KHGiaoShop == "false")
                {
                    showDialog(mMess: "Vui lòng kiểm tra Icloud")
                    return false
                }
                
                
            }
        }
        if(self.baoHanhMoTaLoiView.edtDDTinhTrang.text == "")
        {
            for i in 0 ..< arrTinhTrangMay.count
            {
                
                if(self.arrTinhTrangMay[i].TenTinhTrang == "Khác" && self.arrTinhTrangMay[i].KHGiaoShop == "true")
                {
                    showDialog(mMess: "Vui lòng diễn giải tình trạng")
                    return false
                }
                
                
            }
        }
        if(isSamsung == true)
        {
            for i in 0 ..< arrTinhTrangMay.count
            {
                
                if(self.arrTinhTrangMay[i].TenTinhTrang == "Khách đã gọi lên tổng đài của đơn vị Bảo hiểm trong vòng 48h" && self.arrTinhTrangMay[i].KHGiaoShop == "false")
                {
                    showDialog(mMess: "Vui lòng nhắc khách gọi lên tổng đài")
                    return false
                }
                if(self.arrTinhTrangMay[i].TenTinhTrang == "Đã có CMND photo của KH" && self.arrTinhTrangMay[i].KHGiaoShop == "false")
                {
                    showDialog(mMess: "Vui lòng photo CMND khách hàng")
                    return false
                }
                if(self.arrTinhTrangMay[i].TenTinhTrang == "Đã làm form khai báo BH Vip Samsung" && self.arrTinhTrangMay[i].KHGiaoShop == "false")
                {
                    showDialog(mMess: "Vui lòng làm form khai báo BH Vip Samsung")
                    return false
                }
                
            }
            
        }
        return true
        
    }
    /////
    //search imei imageview
    @objc func imageLogoTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if(self.isSamsung == true)
        {
            self.baohanhViewDialog.isHidden = false
        }
        
    }
    
    @objc func imageSearchBHTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.baohanhThongTinChungView.hinhthucBHButton.text = ""
        self.baohanhThongTinChungView.hinhthucBHButton.startVisibleWithoutInteraction = true
    }
    
    //search imei imageview
    @objc func imageSearchImeiTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if(self.baohanhThongTinChungView.edtImei.text != "")
        {
            //GetDataCheckimei_V2(p_Imei: "862840035139662",p_BILL: "",p_SO_DocNum: "0",p_PhoneNumber: "",p_Type: "0")
            GetDataCheckimei_V2(p_Imei: "\(self.baohanhThongTinChungView.edtImei.text!)",p_BILL: "",p_SO_DocNum: "0",p_PhoneNumber: "",p_Type: "0",mTypeCall: "0")
            self.baohanhThongTinChungView.edtImei.isEnabled = false
        } else {
            self.baohanhThongTinChungView.edtImei.isEnabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func GetDataCheckimei_V2(p_Imei: String,p_BILL: String,p_SO_DocNum: String,p_PhoneNumber: String,p_Type: String,mTypeCall:String)
    {
        self.showProcessView(mShow: true)
        MPOSAPIManager.Checkimei_V2(p_Imei: p_Imei,p_BILL: p_BILL,p_SO_DocNum: p_SO_DocNum,p_PhoneNumber: p_PhoneNumber,p_Type: p_Type){ (error: Error? , success: Bool,result: [Checkimei_V2Result]!,result2:Checkimei_V2_ImeiInfoServices_Result!,result3: [Checkimei_V2_LoadHTBH_Result]!) in
            if success
            {
                if(result != nil && result.count > 0 )
                {
                    //////Step 1 Get data for HoanTat
                    self.imei = p_Imei
                    self.strLoaiBH = result[0].LoaiBH
                    self.strHinhThucBH = result[0].LoaiBH
                    //self.strMoTaLoi = result[0].imei
                    //self.strDienGiai = result[0].imei
                    //self.strNgayDuKienTra = result[0].imei
                    self.strMaShopTao = Cache.user!.ShopCode
                    self.strTenShopTao = Cache.user!.ShopName
                    self.strNhanVienTao = Cache.user!.UserName
                    //strMaTTBH1 = result[0].imei
                    //strMaTTBH2 = result[0].imei
                    //strMaHTBanGiao = result[0].imei
                    
                    //strTenHTBanGiao = result[0].imei
                    //strSoNgayCamKet = result[0].imei
                    self.strSanPhamBH = result[0].TenSanPham
                    self.strSolanBH = result[0].SoLanBH
                    self.strSoDonHang = result[0].SoDonHang
                    
                    self.strMaCuaHangBan = result[0].ShopTao
                    self.strTenCuaHangBan = result[0].TenShop
                    self.strLoaiDonHang = result[0].LoaiDonHang
                    
                    self.strNgayHetHanBH = result[0].NgayBaoHanh
                    self.strNgayMua = result[0].NgayTao
                    
                    self.strImei = result[0].imei
                    self.strImei2 = result[0].Imei2
                    self.strMaSPBHV = result[0].MaSPBHV
                    self.strSoLanBHV = result[0].SoLanBHV
                    self.strMaHopDongBHV = result[0].SoHDBHV
                    //self.strTrangThaiBHV = ""
                    //self.strMauSac = ""
                    self.strTenKH = result[0].TenKH
                    self.strSoDienThoaiKH = result[0].SoDienThoai
                    //self.strSoDienThoaiKhac = ""
                    //self.strDiaChi = ""
                    //self.strGhiChu = ""
                    //self.strEmail = ""
                    self.strMaKho = result[0].MaKho
                    //self.strListPhuKienXML = ""
                    //self.strListTinhTrangMayXML = ""
                    //self.strChuoiDinhKem = ""
                    
                    
                    
                    
                    //                        self.strMaSPBHNhanh = ""
                    //                        self.strMaHDBHNhanh = ""
                    //                        self.strHieuLucBHNhanh = ""
                    //                        self.strMaSPBHTanNoi = ""
                    //                        self.strMaHDBHTanNoi = ""
                    //                        self.strHieuLucBHTanNoi = ""
                    //                        self.strMaSPBHVIP = ""
                    //                        self.strMaHDBHVIP = ""
                    //                        self.strHieuLucVIP = ""
                    //                        self.strMaBook = ""
                    //                        self.strMaSPSamSungVIP = ""
                    //                        self.strMaHDSamSungVIP = ""
                    //                        self.strHieuLucSamSungVIP = ""
                    
                    ////////////
                    self.strNgayBaoHanh = result[0].NgayBaoHanh
                    
                    self.strHang = result[0].Hang
                    self.strLockKnox = result[0].LockKnox
                    self.strSO_NOIBO = result[0].SO_NOIBO
                    self.isDemo = result[0].IsDemo
                    
                    self.strThongBaoPhieu = result[0].ThongBaoPhieu
                    self.strSoHoaDonDo = result[0].HD_Do
                    //                        self.strMaSanPham = result[0].MaSanPham
                    //                        self.strTenSanPham = result[0].TenSanPham
                    //////
                    //self.baohanhThongTinChungView.edtImei.text = result[0].imei
                   if(result[0].TenSanPham != "")
                    {
                        self.baohanhThongTinChungView.edtTenSp.text = result[0].TenSanPham
                        self.strNhanHang = result[0].NhanHang
                        self.strTenSanPham = result[0].TenSanPham
                        self.strMaNhomHangCRM = result[0].MaNhomHangCRM
                        self.strLoaiHang = result[0].LoaiHang
                        self.strNganhHang = result[0].NganhHang
                    }
                    if(result[0].MaSanPham != "")
                    {
                        self.baohanhThongTinChungView.edtMaSp.text = result[0].MaSanPham
                        self.strMaSanPham = result[0].MaSanPham
                        
                    } else {
                        debugPrint("ma sp null")
                    }
                    self.baohanhThongTinChungView.edtTenLienHe.text = result[0].TenKH
                    self.baohanhThongTinChungView.loaiBHButton.text = result[0].TenLoaiBH
                    self.baohanhThongTinChungView.edtHanBH.text = result[0].NgayBaoHanh
                    
                    
                    self.baohanhThongTinChungView.lbSoDHvalue.text = result[0].SoDonHang
                    self.baohanhThongTinChungView.lbLoaiDHValue.text = result[0].LoaiDonHang
                    self.baohanhThongTinChungView.lbNgayMuaValue.text = result[0].NgayTao
                    self.baohanhThongTinChungView.lbShopValue.text = result[0].TenShop
                    
                    self.baoHanhMoTaLoiView.edtImei.text = self.baohanhThongTinChungView.edtImei.text
                    ///
                    self.baohanhThongTinChungView.edtSDTLienHe.text = result[0].SoDienThoai
                    
                    if(result[0].NgayBaoHanh == "01/01/1900" && result[0].LoaiBH == "10")
                    {
                        self.showDialog(mMess: "Sản phẩm không có hạn bảo hành, không tạo được phiếu")
                        
                    }
                    
                    if !(self.isMayDemo){
                        if(result[0].ThongBao != "")
                        {
                            self.showDialog(mMess: "\(result[0].ThongBao)")
                        }
                    }
                    
                    if(result[0].NhanHang == "93" && result[0].NoiDungHienThi != "")
                    {
                        self.baohanhViewDialog.isHidden = false
                    }
                    
                    
                    
                    ///inportant
                    //self.GetDataLayThongTinHinhThucBH(p_MaLoaiBaoHanh: "\(result[0].LoaiBH)")
                    
                    
                    /////if = 30
                    //self.GetDataLayHinhThucBanGiaoChoBHV(p_HinhThucBH_Ma: "30", p_MaShop: "18031");
                    ////else
                    //                        self.GetDataLoadHinhThucBanGiao(p_MaCuaHang: "40803",p_NganhHang:"01",p_LoaiHang: "104",p_NhomHangCRM:"1",p_Hang: "9",p_HinhThucBH:"30",p_LoaiBH:"1")
                    //                        self.GetDataTaoPhieuBH_NgayHenTra(p_LoaiCK: "KH",p_CuaHangTaoPhieu:"30808",p_Hang: "80",p_HinhThucBH:"40",p_NhomhangCRM: "1")
                    
                    
                    if(mTypeCall == "0")
                    {
                        self.GetDataTaoPhieuBH_NgayHenTra(p_LoaiCK: "KH",p_CuaHangTaoPhieu:"\(Cache.user!.ShopCode)",p_Hang: "\(result[0].NhanHang)",p_HinhThucBH:"\(result[0].LoaiBH)",p_NhomhangCRM: "\(result[0].MaNhomHangCRM)")
                    }
                    
                    self.showProcessView(mShow: false)
                    if (self.isDemo != 1) {
                        self.GetThongBaoAfterCheckImei(mData: result[0])
                    }
                    
                    if(result[0].LockKnox == "1")
                    {
                        self.baohanhThongTinChungView.imageViewLogoKnox.isHidden = false
                    }
                    
                    
                    if(result2 != nil)
                    {
                        self.strTrangThaiBHV = result2.HieuLuc
                        self.strHieuLucSamSungVIP = result2.HieuLucSamSungVip
                        self.strMaSPBHVIP = result2.MaSPVip
                        self.strHieuLucVIP = result2.HieuLucVip
                        self.strMaHDBHVIP = result2.MaHDVip
                        self.strMaHDSamSungVIP = result2.MaHDSamSungVip
                        self.strMaHopDongBHV = result2.SoHDBHV
                        self.strMaSPSamSungVIP = result2.MaSamSungVip
                        if(result2.MaSPBHV != "")
                        {
                            self.baohanhThongTinChungView.imageViewLogoFPT.isHidden = false
                        }
                        if(result2.MaSamSungVip != "")
                        {
                            self.baohanhThongTinChungView.imageViewLogoSamsung.isHidden = false
                            self.isSamsung = true
                        }
                        if(result2.MaSPVip != "")
                        {
                            self.baohanhThongTinChungView.imageViewApple.isHidden = false
                        }
                        
                        
                    }
                    if(result3 != nil)
                    {
                        var listCom: [String] = []
                        for i in 0 ..< result3.count
                        {
                            if(result3[i].DoUuTien == "1")
                            {
                                self.baohanhThongTinChungView.hinhthucBHButton.text = result3[i].TenHinhThuc
                                self.strHinhThucBH = result3[i].MaHinhThuc
                                self.CheckHinhThucBH()
                                self.GetDataLoadHinhThucBanGiao(p_MaCuaHang: "\(Cache.user!.ShopCode)",p_NganhHang:"\(result[0].NganhHang)",p_LoaiHang: "\(result[0].LoaiHang)",p_NhomHangCRM:"\(result[0].MaNhomHangCRM)",p_Hang: "\(result[0].NhanHang)",p_HinhThucBH:"\(result3[i].MaHinhThuc)",p_LoaiBH:"\(result[0].Loai)")
                                //                                    if(result3[i].MaHinhThuc == "30")
                                //                                    {
                                //                                        self.GetDataLayHinhThucBanGiaoChoBHV(p_HinhThucBH_Ma: "30", p_MaShop: "\(Cache.User!.ShopCode)");
                                //                                    }
                                //                                    else
                                //                                    {
                                //
                                //                                    }
                            }
                            listCom.append("\(result3[i].TenHinhThuc)")
                            
                        }
                        self.baohanhThongTinChungView.hinhthucBHButton.filterStrings(listCom)
                        
                    }
                }
                else
                {
                    self.showProcessView(mShow: false)
                    self.showDialog(mMess: "Không tìm thấy sản phẩm")
                }
                
            }
            else
            {
                self.showProcessView(mShow: false)
                self.showDialog(mMess: "Không tìm thấy sản phẩm")
            }
        }
    }
    
    
    @objc func BackFromSearch()
    {
        let userDefaults : UserDefaults = UserDefaults.standard
        if (userDefaults.object(forKey: "mTenSanPham") != nil)
        {
            GetDataCheckimei_V2(p_Imei: "\(self.mImeiPush ?? "")",p_BILL: "",p_SO_DocNum: "",p_PhoneNumber: "",p_Type: "0", mTypeCall: "1")
            self.baohanhThongTinChungView.edtImei.text = self.mImeiPush ?? ""
            let mMaSanPham = (UserDefaults.standard.object(forKey: "mMaSanPham") as? String)!
            let mTenSanPham  = (UserDefaults.standard.object(forKey: "mTenSanPham") as? String)!
            
            let mMaNhomHangCRM = (UserDefaults.standard.object(forKey: "mMaNhomHangCRM") as? String)!
            let mMaNhan  = (UserDefaults.standard.object(forKey: "mMaNhan") as? String)!
            let mMaLoai = (UserDefaults.standard.object(forKey: "mMaLoai") as? String)!
            let mMaNganh = (UserDefaults.standard.object(forKey: "mMaNganh") as? String)!
            
            print("eeee \(mTenSanPham),\(mMaSanPham),\(mMaNhomHangCRM),\(mMaNhan)")
            baohanhThongTinChungView.edtTenSp.text = mTenSanPham
            baohanhThongTinChungView.edtMaSp.text = mMaSanPham
            
            self.strMaSanPham = mMaSanPham
            self.strTenSanPham = mTenSanPham
            self.strNhanHang = mMaNhan
            self.strMaNhomHangCRM = mMaNhomHangCRM
            self.strNganhHang = mMaNganh
            self.strLoaiHang = mMaLoai
            
//            let defaults = UserDefaults.standard
//            defaults.removeObject(forKey: "mMaSanPham")
//            defaults.removeObject(forKey: "mTenSanPham")
            
            self.GetDataLoadHinhThucBanGiao(p_MaCuaHang: "\(Cache.user!.ShopCode)",p_NganhHang:"\(mMaNganh)",p_LoaiHang: "\(mMaLoai)",p_NhomHangCRM:"\(mMaNhomHangCRM)",p_Hang: "\(mMaNhan)",p_HinhThucBH:"20",p_LoaiBH:"20")
            
            self.GetDataTaoPhieuBH_NgayHenTra(p_LoaiCK: "KH",p_CuaHangTaoPhieu:"\(Cache.user!.ShopCode)",p_Hang: "\(mMaNhan)",p_HinhThucBH:"20",p_NhomhangCRM: "\(mMaNhomHangCRM)")
            ////
            print("asdasdasdas vao day")
        }
        if (userDefaults.object(forKey: "mSearchByV2") != nil)
        {
            GetThongBaoAfterCheckImei(mData: arrCheckimei_V2Result!)
            
            self.strNgayBaoHanh = arrCheckimei_V2Result!.NgayBaoHanh
            self.strNganhHang = arrCheckimei_V2Result!.NganhHang
            self.strLoaiHang = arrCheckimei_V2Result!.LoaiHang
            self.strHang = arrCheckimei_V2Result!.Hang
            self.strSoHoaDonDo = arrCheckimei_V2Result!.HD_Do
            self.strLockKnox = arrCheckimei_V2Result!.LockKnox
            self.isDemo = arrCheckimei_V2Result!.IsDemo
            self.strMaNhomHangCRM = arrCheckimei_V2Result!.MaNhomHangCRM
            self.strThongBaoPhieu = arrCheckimei_V2Result!.ThongBaoPhieu
            self.strLoaiBH = arrCheckimei_V2Result!.LoaiBH
            self.strHinhThucBH = arrCheckimei_V2Result!.LoaiBH
            
            self.strMaShopTao = Cache.user!.ShopCode
            self.strTenShopTao = Cache.user!.ShopName
            self.strNhanVienTao = Cache.user!.UserName
            
            self.strSanPhamBH = arrCheckimei_V2Result!.TenSanPham
            self.strSolanBH = arrCheckimei_V2Result!.SoLanBH
            self.strSoDonHang = arrCheckimei_V2Result!.SoDonHang
            
            print("so don hang\(strSoDonHang)")
            self.strNgayHetHanBH = arrCheckimei_V2Result!.NgayBaoHanh
            self.strMaCuaHangBan = arrCheckimei_V2Result!.ShopTao
            self.strTenCuaHangBan = arrCheckimei_V2Result!.TenShop
            self.strLoaiDonHang = arrCheckimei_V2Result!.LoaiDonHang
            self.strMaSanPham = arrCheckimei_V2Result!.MaSanPham
            self.strTenSanPham = arrCheckimei_V2Result!.TenSanPham
            
            self.strNgayMua = arrCheckimei_V2Result!.NgayTao
            
            self.strImei = arrCheckimei_V2Result!.imei
            self.strImei2 = arrCheckimei_V2Result!.Imei2
            self.strMaSPBHV = arrCheckimei_V2Result!.MaSPBHV
            self.strSoLanBHV = arrCheckimei_V2Result!.SoLanBHV
            self.strMaHopDongBHV = arrCheckimei_V2Result!.SoHDBHV
            
            self.strTenKH = arrCheckimei_V2Result!.TenKH
            self.strSoDienThoaiKH = arrCheckimei_V2Result!.SoDienThoai
            
            self.strMaKho = arrCheckimei_V2Result!.MaKho
            self.strNhanHang = arrCheckimei_V2Result!.NhanHang
            
            
            
            self.baohanhThongTinChungView.edtImei.text = arrCheckimei_V2Result!.imei
            self.baohanhThongTinChungView.edtTenSp.text = arrCheckimei_V2Result!.TenSanPham
            self.baohanhThongTinChungView.edtTenLienHe.text = arrCheckimei_V2Result!.TenKH
            self.baohanhThongTinChungView.loaiBHButton.text = arrCheckimei_V2Result!.TenLoaiBH
            self.baohanhThongTinChungView.edtHanBH.text = arrCheckimei_V2Result!.NgayBaoHanh
            self.baohanhThongTinChungView.edtMaSp.text = arrCheckimei_V2Result!.MaSanPham
            
            self.baohanhThongTinChungView.lbSoDHvalue.text = arrCheckimei_V2Result!.SoDonHang
            self.baohanhThongTinChungView.lbLoaiDHValue.text = arrCheckimei_V2Result!.LoaiDonHang
            self.baohanhThongTinChungView.lbNgayMuaValue.text = arrCheckimei_V2Result!.NgayTao
            self.baohanhThongTinChungView.lbShopValue.text = arrCheckimei_V2Result!.TenShop
            self.baohanhThongTinChungView.edtSDTLienHe.text = arrCheckimei_V2Result!.SoDienThoai
            //inportant
            ///self.GetDataLayThongTinHinhThucBH(p_MaLoaiBaoHanh: "\(arrCheckimei_V2Result!.LoaiBH)")
            
            if(arrCheckimei_V2Result2 != nil )
            {
                if(arrCheckimei_V2Result2!.MaSPBHV != "")
                {
                    self.baohanhThongTinChungView.imageViewLogoFPT.isHidden = false
                }
                if(arrCheckimei_V2Result2!.MaSamSungVip != "")
                {
                    self.baohanhThongTinChungView.imageViewLogoSamsung.isHidden = false
                    self.isSamsung = true
                }
                if(arrCheckimei_V2Result2!.MaSPVip != "")
                {
                    self.baohanhThongTinChungView.imageViewApple.isHidden = false
                }
            }
            if(arrCheckimei_V2Result3 != nil)
            {
                var listCom: [String] = []
                for i in 0 ..< arrCheckimei_V2Result3!.count
                {
                    
                    self.GetDataTaoPhieuBH_NgayHenTra(p_LoaiCK: "KH",p_CuaHangTaoPhieu:"\(Cache.user!.ShopCode)",p_Hang: "\(arrCheckimei_V2Result!.NhanHang)",p_HinhThucBH:"\(arrCheckimei_V2Result3![0].MaHinhThuc)",p_NhomhangCRM: "\(arrCheckimei_V2Result!.MaNhomHangCRM)")
                    
                    if(arrCheckimei_V2Result3![i].DoUuTien == "1")
                    {
                        self.baohanhThongTinChungView.hinhthucBHButton.text = arrCheckimei_V2Result3![i].TenHinhThuc
                        self.strHinhThucBH = arrCheckimei_V2Result3![i].MaHinhThuc
                        CheckHinhThucBH()
                        self.GetDataLoadHinhThucBanGiao(p_MaCuaHang: "\(Cache.user!.ShopCode)",p_NganhHang:"\(arrCheckimei_V2Result!.NganhHang)",p_LoaiHang: "\(arrCheckimei_V2Result!.LoaiHang)",p_NhomHangCRM:"\(arrCheckimei_V2Result!.MaNhomHangCRM)",p_Hang: "\(arrCheckimei_V2Result!.NhanHang)",p_HinhThucBH:"\(arrCheckimei_V2Result3![i].MaHinhThuc)",p_LoaiBH:"\(arrCheckimei_V2Result!.Loai)")
                        //                        if(arrCheckimei_V2Result3![i].MaHinhThuc == "30")
                        //                        {
                        //                            self.GetDataLayHinhThucBanGiaoChoBHV(p_HinhThucBH_Ma: "30", p_MaShop: "\(Cache.User!.ShopCode)");
                        //                        }
                        //                        else
                        //                        {
                        //
                        //                        }
                        
                    }
                    listCom.append("\(arrCheckimei_V2Result3![i].TenHinhThuc)")
                    
                }
                self.baohanhThongTinChungView.hinhthucBHButton.filterStrings(listCom)
            }
            
            self.showProcessView(mShow: false)
            let defaults = UserDefaults.standard
            
            defaults.removeObject(forKey: "mSearchByV2")
            
            print("asdasdasdas vao day")
        }
        
        debugPrint("isMayDemo: \(isMayDemo)")
        debugPrint("mayDemo_listErrorID: \(self.listErrorIDMayDemoString)")
        debugPrint("mayDemo_listErrorName: \(self.errorNameMayDemoBH)")
        debugPrint("mayDemo_xmlString: \(self.xmlImgMayDemo)")
        
        if isMayDemo {
            baoHanhMoTaLoiView.edtMoTaLoi.text = "\(errorNameMayDemoBH)"
            baoHanhMoTaLoiView.edtMoTaLoi.font = UIFont.systemFont(ofSize: 13)
        }
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func checkStepOne()->Bool
    {
        if(self.baohanhThongTinChungView.radioMarket.isSelected && self.baohanhThongTinChungView.hinhthucBHButton.text == "Bảo hành vàng")
        {
            self.showDialog(mMess: "Không thể chọn bảo hành phụ kiện cho hình thức bảo hành vàng")
            return false
        }
        
        if(self.strNgayBaoHanh == "01/01/1900" && self.strLoaiBH == "10")
        {
            self.showDialog(mMess: "Sản phẩm không có hạn bảo hành, không tạo được phiếu")
            return false
        }
        
        if(!self.baohanhThongTinChungView.radioMarket.isSelected && self.strThongBaoPhieu != "")
        {
            self.showDialog(mMess: "Imei \(self.strImei) đang được bảo hành sản phẩm chính.Không thể chọn sản phẩm chính là sản phẩm bảo hành.")
            return false
        }
        
        if(self.baohanhThongTinChungView.edtImei.text?.count == 0)
        {
            showDialog(mMess: "Vui lòng nhập Imei.")
            return false
        }
        if(self.baohanhThongTinChungView.hinhthucBHButton.text?.count == 0)
        {
            showDialog(mMess: "Vui lòng chọn hình thức bảo hành.")
            return false
        }
        if(self.baohanhThongTinChungView.edtMaSp.text?.count == 0)
        {
            showDialog(mMess: "Mã sản phẩm không được để trống.")
            return false
        }
        if(self.baohanhThongTinChungView.edtTenSp.text?.count == 0)
        {
            showDialog(mMess: "Tên sản phẩm không được để trống.")
            return false
        }
        if(strNgayBaoHanh == "")
        {
            showDialog(mMess: "Hạn bảo hành bị trống.")
            return false
            
        }
        if(self.baohanhThongTinChungView.edtTenLienHe.text?.count == 0)
        {
            showDialog(mMess: "Vui lòng nhập tên khách hàng.")
            return false
        }
        if(self.baohanhThongTinChungView.edtSDTLienHe.text?.count == 0)
        {
            showDialog(mMess: "Vui lòng kiểm tra lại số điện thoại.")
            return false
        }
        if(self.baohanhThongTinChungView.edtSDTLienHeKhac.text?.count == 0 && strLockKnox == "1" && !self.baohanhThongTinChungView.radioMarket.isSelected)
        {
            showDialog(mMess: "Bắt buộc nhập SDT khác khi có Knox.")
            return false
        }
        if(self.baohanhThongTinChungView.edtSDTLienHeKhac.text!.count > 0 && self.baohanhThongTinChungView.edtSDTLienHeKhac.text!.count != 10)
        {
            showDialog(mMess: "SDT khác sai định dạng.")
            return false
        }
        if(self.baohanhThongTinChungView.edtMailLienHe.text?.count == 0 && strNhanHang == "9" )
        {
            showDialog(mMess: "Vui lòng nhập Email khách hàng.")
            return false
        }
        if(strLoaiBH != "30" && strNganhHang == "7" || strNganhHang == "07" )
        {
            
            let mDate = Date()
            let mFormatter = DateFormatter()
            mFormatter.dateFormat = "dd.MM.yyyy"
            let mResult = mFormatter.string(from: mDate)
            
            print("sSplitString1 \(mResult)")
            let sSplitString1 = mResult.components(separatedBy: ".")
            var mDay1:String = ""
            var mMonth1:String = ""
            var mYear1:String = ""
            mDay1    = sSplitString1[0]
            mMonth1 = sSplitString1[1]
            mYear1 = sSplitString1[2]
            
            
            let dateSave:String = strNgayBaoHanh
            print("sSplitString2 \(dateSave)")
            let sSplitString2 = dateSave.components(separatedBy: "/")
            var mDay2:String = ""
            var mMonth2:String = ""
            var mYear2:String = ""
            mDay2    = sSplitString2[0]
            mMonth2 = sSplitString2[1]
            mYear2 = sSplitString2[2]
            
            if(Int(mYear2)! > Int(mYear1)!)
            {
                
            }
            else if(Int(mYear2)! < Int(mYear1)!)
            {
                showDialog(mMess: "PKNK này hết hạn bảo hành, không thể bảo hành.")
                return false
            }
            else
            {
                if(Int(mMonth1)! > Int(mMonth2)!)
                {
                    showDialog(mMess: "PKNK này hết hạn bảo hành, không thể bảo hành.")
                    return false
                }
                if(Int(mDay1)! < Int(mDay2)! || Int(mDay1)! == Int(mDay2)! )
                {
                    
                }
                else
                {
                    showDialog(mMess: "PKNK này hết hạn bảo hành, không thể bảo hành.")
                    return false
                }
            }
            
            
        }
        if(strNgayDuKienTra == "")
        {
            showDialog(mMess: "Hệ thống chưa định nghĩa ngày hẹn trả khách hàng cho sản phẩm vừa Nhập.")
            return false
        }
        if(strLockKnox == "2")
        {
            showDialog(mMess: "Máy đang thuộc trường hợp nợ quá hạn chưa thanh toán.\nVui lòng thông báo KH thanh toán phí trước khi đi Bảo Hành")
            return false
        }
        if self.isDemo != 1 {
            if(strSO_NOIBO == "1")
            {
                showDialog(mMess: "Imei đang tồn kho nội bộ, không thể bảo hành cho khách.")
                return false
            }
        }
        if(self.baohanhThongTinChungView.edtMailLienHe.text != "" && !isValidEmail(testStr :self.baohanhThongTinChungView.edtMailLienHe.text!))
        {
            showDialog(mMess: "Email không đúng.")
            return false
        }
            
        else
        {
            return true
        }
    }
    
    
    @objc func ClickTiepTheoStepOne()
    {
        print("asdasdas")
        
        if (!checkStepOne())
        {
            return
        }
        self.mScreen = 1
        CheckHongPK()
        self.baoHanhPKKemTheoView.isHidden = false
        self.baohanhThongTinChungView.isHidden = true
        self.baoHanhMoTaLoiView.isHidden = true
        ChangeColorPushToPK()
        self.baoHanhMoTaLoiView.edtImei.text! = self.baohanhThongTinChungView.edtImei.text!
        ///case20
        if(self.baohanhThongTinChungView.hinhthucBHButton.text == "Thẩm định lỗi")
        {
            
            self.showDialog(mMess: "Vui lòng nhận vỏ hộp, phụ kiện của khách. Nếu khách có mang theo tại shop để gửi đi bảo hành")
        }
    }
    
    
    func checkStepTwo()->Bool
    {
        var mCountCheck:Int = 0
        
        for i in 0 ..< arrPhuKien.count
        {
            
            if(self.arrPhuKien[i].KHGiaoShop == "true")
            {
                mCountCheck += 1
                if(self.arrPhuKien[i].SoLuong == "0")
                {
                    showDialog(mMess: "Vui lòng nhập số lượng cho phụ kiện đã check")
                    return false
                }
            }
            
        }
        
        if(self.baohanhThongTinChungView.radioMarket.isSelected)
        {
            
            if(mCountCheck == 0)
            {
                showDialog(mMess: "Vui lòng chọn phụ kiện kèm theo")
                return false
            }
            else
            {
                return true
            }
            
        }
        else
        {
            return true
        }
        
        
    }
    
    @objc func ClickTiepTheoStepTwo()
    {
        if(!checkStepTwo())
        {
            return
        }
        print("asdasdas")
        self.baoHanhPKKemTheoView.isHidden = true
        self.baohanhThongTinChungView.isHidden = true
        self.baoHanhMoTaLoiView.isHidden = false
        self.mScreen = self.mScreen + 1
        ChangeColorPushMoTa()
    }
    
    
    
    func GetDataLayThongTinHinhThucBH(p_MaLoaiBaoHanh: String)
    {
        MPOSAPIManager.LayThongTinHinhThucBH(p_MaLoaiBaoHanh: p_MaLoaiBaoHanh){ (error: Error? , success: Bool,result: [LayThongTinHinhThucBHResult]!) in
            if success
            {
                var listCom: [String] = []
                if(result != nil && result.count > 0 )
                {
                    print("wwwww\(result[0].TenHinhThuc)")
                    //self.baohanhThongTinChungView.hinhthucBHButton.text = result[0].TenHinhThuc
                    
                    for i in 0 ..< result.count
                    {
                        
                        listCom.append("\(result[i].TenHinhThuc)")
                        
                    }
                    self.baohanhThongTinChungView.hinhthucBHButton.filterStrings(listCom)
                    
                }
                else
                {
                    
                }
            }
            else
            {
                
            }
        }
    }
    
    ////////
    func GetDataLayHinhThucBanGiaoChoBHV(p_HinhThucBH_Ma: String,p_MaShop: String)
    {
        MPOSAPIManager.LayHinhThucBanGiaoChoBHV(p_HinhThucBH_Ma: p_HinhThucBH_Ma ,p_MaShop: p_MaShop ){ (error: Error? , success: Bool,result: [LayHinhThucBanGiaoChoBHVResult]!) in
            if success
            {
                print("GetDataLayHinhThucBanGiaoChoBHV GetDataLayHinhThucBanGiaoChoBHV")
                self.baohanhThongTinChungView.edtHinhThucBH2.text = result[0].TenHinhThuc
                self.baohanhThongTinChungView.edtTTBHFRT.text = result[0].TenTTBHFRT
                self.baohanhThongTinChungView.edtTTBHHang.text = result[0].HinhThucBG
                self.baohanhThongTinChungView.lbDiaChiFRT.text = result[0].DiaChiTTBHFRT
                
                self.strMaTTBH2 = result[0].MaTTBHFRT
                self.strMaTTBH1 = result[0].MaTTBHHang
                self.strMaHTBanGiao = result[0].HinhThucBG
                
                self.strTenHTBanGiao = result[0].TenHinhThuc
                
            }
            else
            {
                
            }
        }
    }
    
    
    ///////
    func GetDataLoadHinhThucBanGiao(p_MaCuaHang: String,p_NganhHang:String,p_LoaiHang: String,p_NhomHangCRM:String,p_Hang: String,p_HinhThucBH:String,p_LoaiBH:String)
    {
        MPOSAPIManager.LoadHinhThucBanGiao(p_MaCuaHang: p_MaCuaHang,p_NganhHang:p_NganhHang,p_LoaiHang: p_LoaiHang,p_NhomHangCRM:p_NhomHangCRM,p_Hang: p_Hang,p_HinhThucBH:p_HinhThucBH,p_LoaiBH:p_LoaiBH){ (error: Error? , success: Bool,result: [LayHinhThucBanGiaoChoBHVResult]!) in
            if success
            {
                print("GetDataLoadHinhThucBanGiao GetDataLoadHinhThucBanGiao")
                
                if(result.count > 0)
                {
                    self.baohanhThongTinChungView.edtHinhThucBH2.text = result[0].TenHinhThuc
                    self.baohanhThongTinChungView.edtTTBHFRT.text = result[0].TenTTBHFRT
                    self.baohanhThongTinChungView.edtTTBHHang.text = result[0].TenTTBH
                    self.baohanhThongTinChungView.lbDiaChiFRT.text = result[0].DiaChiTTBHFRT
                    self.strMaHTBanGiao = result[0].HinhThucBG
                    
                    self.strTenHTBanGiao = result[0].TenHinhThuc
                    
                    self.strMaTTBH2 = result[0].MaTTBHFRT
                    self.strMaTTBH1 = result[0].MaTTBHHang
                }
            }
            else
            {
                
            }
        }
    }
    
    //////
    func GetDataTaoPhieuBH_NgayHenTra(p_LoaiCK: String,p_CuaHangTaoPhieu:String,p_Hang: String,p_HinhThucBH:String,p_NhomhangCRM: String)
    {
        MPOSAPIManager.TaoPhieuBH_NgayHenTra(p_LoaiCK: p_LoaiCK,p_CuaHangTaoPhieu:p_CuaHangTaoPhieu,p_Hang: p_Hang,p_HinhThucBH:p_HinhThucBH,p_NhomhangCRM: p_NhomhangCRM){ (error: Error? , success: Bool,result: TaoPhieuBH_NgayHenTraResult!) in
            if success
            {
                print("GetDataTaoPhieuBH_NgayHenTra GetDataTaoPhieuBH_NgayHenTra \(result.NgayCamKet) ")
                self.baoHanhPKKemTheoView.lbKNgayDuKienTra.text = "Ngày dự kiến trả: \(result.NgayCamKet)"
                self.baoHanhMoTaLoiView.lbKNgayDuKienTra.text = "Ngày dự kiến trả: \(result.NgayCamKet)"
                self.showProcessView(mShow: false)
                
                ////step 2 getdata for hoantat
                self.strNgayDuKienTra = result.NgayCamKet
                self.strSoNgayCamKet = result.ThoiGianCamKet
            }
            else
            {
                
            }
        }
    }
    //////
    
    @objc func TapScan()
    {
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { code in
            self.baohanhThongTinChungView.edtImei.text = code
        }
        self.present(viewController, animated: false, completion: nil)
    }
    
    
    @objc func TapSearch()
    {
        let newViewController = BaoHanhSearchController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func TapChon()
    {
        if(strLoaiBH == "20") {
            let newViewController = BaoHanhTaoPhieuTimSPController()
            newViewController.mImeiUser = self.baohanhThongTinChungView.edtImei.text!
            self.navigationController?.pushViewController(newViewController, animated: true)
        } else {
            self.showDialog(mMess: "Chức năng này chỉ dành cho Imei ngoài hệ thống")
        }
    }
    
    
    @objc func TapMore()
    {
        print("clicccccc")
        if(self.baohanhThongTinChungView.viewContent.frame.size.height > 0)
        {
            self.baohanhThongTinChungView.viewContent.frame.size.height = 0
            self.baohanhThongTinChungView.viewContent.isHidden = true
            
            let strTitleDetails3 = "Xem thêm thông tin SP:"
            let _: CGSize = strTitleDetails3.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:12))])
            let textRange3 = NSMakeRange(0, strTitleDetails3.count)
            let attributedText3 = NSMutableAttributedString(string: strTitleDetails3)
            attributedText3.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange3)
            // Add other attributes if needed
            self.baohanhThongTinChungView.txtXemThongTinSP.attributedText = attributedText3
            
            
            
            self.baohanhThongTinChungView.scrollView.contentSize.height =  self.baohanhThongTinChungView.scrollView.contentSize.height - 400
            
        }
        else
        {
            self.baohanhThongTinChungView.viewContent.frame.size.height = (self.baohanhThongTinChungView.txtChonMaSP.frame.size.height + self.baohanhThongTinChungView.edtImei2.frame.size.height) * 6.5 + Common.Size(s:15)
            self.baohanhThongTinChungView.viewContent.isHidden = false
            
            let strTitleDetails3 = "Ẩn thông tin sản phẩm:"
            let _: CGSize = strTitleDetails3.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:12))])
            let textRange3 = NSMakeRange(0, strTitleDetails3.count)
            let attributedText3 = NSMutableAttributedString(string: strTitleDetails3)
            attributedText3.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange3)
            // Add other attributes if needed
            self.baohanhThongTinChungView.txtXemThongTinSP.attributedText = attributedText3
            
            self.baohanhThongTinChungView.viewContent.frame.size.height = self.baohanhThongTinChungView.lbShopValue.frame.size.height + self.baohanhThongTinChungView.lbShopValue.frame.origin.y
            
            self.baohanhThongTinChungView.txtXemThongTinSP.frame.origin.y = self.baohanhThongTinChungView.viewContent.frame.origin.y + self.baohanhThongTinChungView.viewContent.frame.size.height + Common.Size(s:10)
            
            self.baohanhThongTinChungView.viewLogo.frame.origin.y = self.baohanhThongTinChungView.txtXemThongTinSP.frame.origin.y + self.baohanhThongTinChungView.txtXemThongTinSP.frame.size.height + Common.Size(s:5)
            
            self.baohanhThongTinChungView.viewBottom.frame.origin.y = self.baohanhThongTinChungView.viewLogo.frame.origin.y + self.baohanhThongTinChungView.viewLogo.frame.size.height + Common.Size(s:5)
            
            
            self.baohanhThongTinChungView.viewBottom.frame.size.height = self.baohanhThongTinChungView.btnHoanTat.frame.origin.y + self.baohanhThongTinChungView.btnHoanTat.frame.size.height
            
            
            self.baohanhThongTinChungView.scrollView.contentSize.height =  self.baohanhThongTinChungView.viewBottom.frame.origin.y + self.baohanhThongTinChungView.viewBottom.frame.size.height + Common.Size(s: 20) + 50
            
        }
        
        self.baohanhThongTinChungView.txtXemThongTinSP.frame.origin.y = self.baohanhThongTinChungView.viewContent.frame.origin.y + self.baohanhThongTinChungView.viewContent.frame.size.height + Common.Size(s:10)
        
        self.baohanhThongTinChungView.viewLogo.frame.origin.y = self.baohanhThongTinChungView.txtXemThongTinSP.frame.origin.y + self.baohanhThongTinChungView.txtXemThongTinSP.frame.size.height + Common.Size(s:5)
        
        self.baohanhThongTinChungView.viewBottom.frame.origin.y = self.baohanhThongTinChungView.viewLogo.frame.origin.y + self.baohanhThongTinChungView.viewLogo.frame.size.height + Common.Size(s:5)
    }
    
    
    func initFunction()
    {
        ////hiden center view
        self.baohanhThongTinChungView.viewContent.frame.size.height = 0
        self.baohanhThongTinChungView.viewContent.isHidden = true
        self.baohanhThongTinChungView.txtXemThongTinSP.frame.origin.y = self.baohanhThongTinChungView.viewContent.frame.origin.y + self.baohanhThongTinChungView.viewContent.frame.size.height + Common.Size(s:10)
        
        self.baohanhThongTinChungView.viewLogo.frame.origin.y = self.baohanhThongTinChungView.txtXemThongTinSP.frame.origin.y + self.baohanhThongTinChungView.txtXemThongTinSP.frame.size.height + Common.Size(s:5)
        
        self.baohanhThongTinChungView.viewBottom.frame.origin.y = self.baohanhThongTinChungView.viewLogo.frame.origin.y + self.baohanhThongTinChungView.viewLogo.frame.size.height + Common.Size(s:5)
        
        
        self.baohanhThongTinChungView.viewBottom.frame.size.height = self.baohanhThongTinChungView.btnHoanTat.frame.origin.y + self.baohanhThongTinChungView.btnHoanTat.frame.size.height
        
        
        self.baohanhThongTinChungView.scrollView.contentSize.height =  self.baohanhThongTinChungView.viewBottom.frame.origin.y + self.baohanhThongTinChungView.viewBottom.frame.size.height + Common.Size(s: 20) + 50
        
    }
    
    
    
    ////////////////here is click on Tab
    @objc func ClickTabPK(gestureRecognizer: UIGestureRecognizer)
    {
        if(canClickToTab == false)
        {
            return
        }
        if(self.mScreen < 1)
        {
            return
        }
        mScreen = 1
        print("asdsadsa")
        self.baoHanhPKKemTheoView.isHidden = false
        self.baohanhThongTinChungView.isHidden = true
        self.baoHanhMoTaLoiView.isHidden = true
        self.baoHanhThongTinHang.isHidden = true
        CheckHongPK()
        
        ChangeColorPushToPK()
        
        
    }
    
    func ChangeColorPushToPK()
    {
        self.baohanhMainView.viewThongTin.backgroundColor = UIColor(netHex:0x47B054)
        self.baohanhMainView.lbThongTin.textColor = UIColor.white
        self.baohanhMainView.viewThongTin.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        self.baohanhMainView.viewPhuKien.backgroundColor = UIColor(netHex:0xffffff)
        self.baohanhMainView.lbPhuKien.textColor = UIColor.black
        self.baohanhMainView.viewPhuKien.layer.borderColor = UIColor(netHex:0x000000).cgColor
        
        self.baohanhMainView.viewMoTaLoi.backgroundColor = UIColor(netHex:0x47B054)
        self.baohanhMainView.lbMoTaLoi.textColor = UIColor.white
        self.baohanhMainView.viewMoTaLoi.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        self.baohanhMainView.viewTTHang.backgroundColor = UIColor(netHex:0x47B054)
        self.baohanhMainView.lbTTHang.textColor = UIColor.white
        self.baohanhMainView.viewTTHang.layer.borderColor = UIColor(netHex:0xffffff).cgColor
    }
    
    
    @objc func ClickTabThongTin(gestureRecognizer: UIGestureRecognizer)
    {
        if(canClickToTab == false)
        {
            return
        }
        print("asdsadsa")
        self.baoHanhPKKemTheoView.isHidden = true
        self.baohanhThongTinChungView.isHidden = false
        self.baoHanhMoTaLoiView.isHidden = true
        self.baoHanhThongTinHang.isHidden = true
        
        ChangeColorPushToThongTin()
        
    }
    
    func ChangeColorPushToThongTin()
    {
        self.baohanhMainView.viewThongTin.backgroundColor = UIColor(netHex:0xffffff)
        self.baohanhMainView.lbThongTin.textColor = UIColor.black
        self.baohanhMainView.viewThongTin.layer.borderColor = UIColor(netHex:0x000000).cgColor
        
        self.baohanhMainView.viewPhuKien.backgroundColor = UIColor(netHex:0x47B054)
        self.baohanhMainView.lbPhuKien.textColor = UIColor.white
        self.baohanhMainView.viewPhuKien.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        self.baohanhMainView.viewMoTaLoi.backgroundColor = UIColor(netHex:0x47B054)
        self.baohanhMainView.lbMoTaLoi.textColor = UIColor.white
        self.baohanhMainView.viewMoTaLoi.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        self.baohanhMainView.viewTTHang.backgroundColor = UIColor(netHex:0x47B054)
        self.baohanhMainView.lbTTHang.textColor = UIColor.white
        self.baohanhMainView.viewTTHang.layer.borderColor = UIColor(netHex:0xffffff).cgColor
    }
    
    @objc func ClickTabMoTa(gestureRecognizer: UIGestureRecognizer)
    {
        if(canClickToTab == false)
        {
            return
        }
        if(self.mScreen < 2)
        {
            return
        }
        self.mScreen = 2
        print("asdsadsa")
        self.baoHanhPKKemTheoView.isHidden = true
        self.baohanhThongTinChungView.isHidden = true
        self.baoHanhMoTaLoiView.isHidden = false
        self.baoHanhThongTinHang.isHidden = true
        ChangeColorPushMoTa()
    }
    
    func ChangeColorPushMoTa()
    {
        self.baohanhMainView.viewThongTin.backgroundColor = UIColor(netHex:0x47B054)
        self.baohanhMainView.lbThongTin.textColor = UIColor.white
        self.baohanhMainView.viewThongTin.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        self.baohanhMainView.viewPhuKien.backgroundColor = UIColor(netHex:0x47B054)
        self.baohanhMainView.lbPhuKien.textColor = UIColor.white
        self.baohanhMainView.viewPhuKien.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        self.baohanhMainView.viewMoTaLoi.backgroundColor = UIColor(netHex:0xffffff)
        self.baohanhMainView.lbMoTaLoi.textColor = UIColor.black
        self.baohanhMainView.viewMoTaLoi.layer.borderColor = UIColor(netHex:0x000000).cgColor
        
        self.baohanhMainView.viewTTHang.backgroundColor = UIColor(netHex:0x47B054)
        self.baohanhMainView.lbTTHang.textColor = UIColor.white
        self.baohanhMainView.viewTTHang.layer.borderColor = UIColor(netHex:0xffffff).cgColor
    }
    
    @objc func ClickTabThongTinHang(gestureRecognizer: UIGestureRecognizer)
    {
        if(canClickToTab == false)
        {
            return
        }
        print("asdsadsa")
        self.baoHanhPKKemTheoView.isHidden = true
        self.baohanhThongTinChungView.isHidden = true
        self.baoHanhMoTaLoiView.isHidden = true
        self.baoHanhThongTinHang.isHidden = false
        ChangeColorPushTTHang()
        
        
    }
    
    func ChangeColorPushTTHang()
    {
        self.baohanhMainView.viewThongTin.backgroundColor = UIColor(netHex:0x47B054)
        self.baohanhMainView.lbThongTin.textColor = UIColor.white
        self.baohanhMainView.viewThongTin.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        self.baohanhMainView.viewPhuKien.backgroundColor = UIColor(netHex:0x47B054)
        self.baohanhMainView.lbPhuKien.textColor = UIColor.white
        self.baohanhMainView.viewPhuKien.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        self.baohanhMainView.viewMoTaLoi.backgroundColor = UIColor(netHex:0x47B054)
        self.baohanhMainView.lbMoTaLoi.textColor = UIColor.white
        self.baohanhMainView.viewMoTaLoi.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        self.baohanhMainView.viewTTHang.backgroundColor = UIColor(netHex:0xffffff)
        self.baohanhMainView.lbTTHang.textColor = UIColor.black
        self.baohanhMainView.viewTTHang.layer.borderColor = UIColor(netHex:0x000000).cgColor
    }
    
    /**********************  Here is tab PK  **********************/
    
    
    func initTabPK()
    {
        baoHanhPKKemTheoView.tableView.dataSource = self
        baoHanhPKKemTheoView.tableView.delegate = self
        baoHanhPKKemTheoView.tableView.register(ItemListTabPKTableViewCell.self, forCellReuseIdentifier: "ItemListTabPKTableViewCell")
        baoHanhPKKemTheoView.btnTiepTuc.addTarget(self, action: #selector(self.ClickTiepTheoStepTwo), for: .touchUpInside)
        GetListPK()
        
        
    }
    
    
    func GetListPK()
    {
        MPOSAPIManager.GetBaoHanhPhuKien(){ (error: Error? , success: Bool,result: [LayThongTinPhuKienResult]!) in
            if success
            {
                if result != nil {
                    if(result.count > 0)
                    {
                        self.arrPhuKien = result
                        self.arrPhuKienAll = result
                        self.baoHanhPKKemTheoView.tableView.reloadData()
                    }
                    else
                    {
                        
                    }

                }
            

                
            }
            else
            {
                
            }
        }
    }
    /**********************  Here is table  **********************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.baoHanhPKKemTheoView.tableView)
        {
            countRow = arrPhuKien.count
        }
        else
        {
            countRow = arrTinhTrangMay.count
        }
        
        print("rowwww \(countRow)")
        return countRow
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:30);
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == self.baoHanhPKKemTheoView.tableView)
        {
            cellRow = ItemListTabPKTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemListTabPKTableViewCell")
            
            if(arrPhuKien.count > 0 )
            {
                cellRow?.selectionStyle = .none
                
                cellRow?.delegate = self
                cellRow?.imageCheck.tag = indexPath.row
                cellRow?.cellSoLuong.tag = indexPath.row
                cellRow?.cellSeriNo.tag = indexPath.row
                cellRow?.cellTenPhuKien.tag = indexPath.row
                cellRow?.cellTTKHGiao.tag = indexPath.row
                cellRow?.cellKHGiao.text = "\(arrPhuKien[indexPath.row].KHGiaoShop)";
                if(arrPhuKien[indexPath.row].KHGiaoShop == "false")
                {
                    cellRow?.imageCheck.image = #imageLiteral(resourceName: "iconuncheck")
                    cellRow?.cellSoLuong.isEnabled = false
                }
                else
                {
                    cellRow?.imageCheck.image = #imageLiteral(resourceName: "iconcheck")
                    cellRow?.cellSoLuong.isEnabled = true
                }
                cellRow?.cellTenPhuKien.text = "\(arrPhuKien[indexPath.row].TenPK)";
                cellRow?.cellSoLuong.text = "\(arrPhuKien[indexPath.row].SoLuong)";
                cellRow?.cellTTKHGiao.text = "\(arrPhuKien[indexPath.row].TinhTrangShop)";
                cellRow?.cellSeriNo.text = "\(arrPhuKien[indexPath.row].Serial)";
            }
            return cellRow!
        }
        else
        {
            cellRow2 = ItemListTabMoTaLoiTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemListTabMoTaLoiTableViewCell")
            
            if(arrTinhTrangMay.count > 0 )
            {
                cellRow2?.selectionStyle = .none
                cellRow2?.delegate = self
                //cellRow2.delegate = self
                cellRow2?.imageCheck.tag = indexPath.row
                cellRow2?.cellSeriNo.tag = indexPath.row
                cellRow2?.cellTenPhuKien.tag = indexPath.row
                cellRow2?.imageCheck.tag = indexPath.row
                cellRow2?.cellKHGiao.text = "\(indexPath.row + 1)";
                print("cxzczxczxcxz \(arrTinhTrangMay[indexPath.row].KHGiaoShop)")
                if(arrTinhTrangMay[indexPath.row].KHGiaoShop == "false")
                {
                    cellRow2?.imageCheck.image = #imageLiteral(resourceName: "iconuncheck")
                    
                }
                else
                {
                    cellRow2?.imageCheck.image = #imageLiteral(resourceName: "iconcheck")
                    
                }
                cellRow2?.cellSeriNo.text = "\(arrTinhTrangMay[indexPath.row].TenTinhTrang)";
                cellRow2?.backgroundColor = UIColor.white
                cellRow2?.layer.borderWidth = 0.5
                cellRow2?.layer.borderColor = UIColor(netHex:0x000000).cgColor
                if(arrTinhTrangMay[indexPath.row].TenTinhTrang.count >= 40)
                {
                    cellRow2?.cellSeriNo.lineBreakMode = .byWordWrapping
                    cellRow2?.cellSeriNo.numberOfLines = 2
                }
                //print("\(arrTinhTrangMay[indexPath.row].TenTinhTrang) - \(arrTinhTrangMay[indexPath.row].TenTinhTrang.count)")
                
            }
            return cellRow2!
        }
    }
    
    
    /**********************  Here is tab Mo Ta Loi  **********************/
    
    func initTabMoTaLoi()
    {
        baoHanhMoTaLoiView.tableView.dataSource = self
        baoHanhMoTaLoiView.tableView.delegate = self
        baoHanhMoTaLoiView.tableView.register(ItemListTabMoTaLoiTableViewCell.self, forCellReuseIdentifier: "ItemListTabMoTaLoiTableViewCell")
        
        GetDataLayTinhTrangMay()
        self.baoHanhMoTaLoiView.viewImageNVMore.isHidden = true
        let tapMoreImage = UITapGestureRecognizer(target: self, action: #selector(self.tapMoreImageFunc))
        baoHanhMoTaLoiView.txtTitleDetails.isUserInteractionEnabled = true
        baoHanhMoTaLoiView.txtTitleDetails.addGestureRecognizer(tapMoreImage)
        
        let tapShowViewImagePick1 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImagePick1))
        baoHanhMoTaLoiView.viewCMNDTruocButton.isUserInteractionEnabled = true
        baoHanhMoTaLoiView.viewCMNDTruocButton.addGestureRecognizer(tapShowViewImagePick1)
        
        let tapShowViewImagePick2 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImagePick2))
        baoHanhMoTaLoiView.viewCMNDTruocButton2.isUserInteractionEnabled = true
        baoHanhMoTaLoiView.viewCMNDTruocButton2.addGestureRecognizer(tapShowViewImagePick2)
        
        let tapShowViewImagePick3 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImagePick3))
        baoHanhMoTaLoiView.viewCMNDTruocButton3.isUserInteractionEnabled = true
        baoHanhMoTaLoiView.viewCMNDTruocButton3.addGestureRecognizer(tapShowViewImagePick3)
        
        
        let tapShowViewImagePick4 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImagePick4))
        baoHanhMoTaLoiView.viewCMNDTruocButton4.isUserInteractionEnabled = true
        baoHanhMoTaLoiView.viewCMNDTruocButton4.addGestureRecognizer(tapShowViewImagePick4)
        
        let tapShowViewImagePick5 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImagePick5))
        baoHanhMoTaLoiView.viewCMNDTruocButton5.isUserInteractionEnabled = true
        baoHanhMoTaLoiView.viewCMNDTruocButton5.addGestureRecognizer(tapShowViewImagePick5)
        
        let tapShowViewImagePick6 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImagePick6))
        baoHanhMoTaLoiView.viewCMNDTruocButton6.isUserInteractionEnabled = true
        baoHanhMoTaLoiView.viewCMNDTruocButton6.addGestureRecognizer(tapShowViewImagePick6)
        
        
        baoHanhMoTaLoiView.btnHoanTat.addTarget(self, action: #selector(self.ClickHoanTat), for: .touchUpInside)
        
        
        let tapSigningKH = UITapGestureRecognizer(target: self, action: #selector(self.tapSigningKH))
        baoHanhMoTaLoiView.viewChuKyKH.isUserInteractionEnabled = true
        baoHanhMoTaLoiView.viewChuKyKH.addGestureRecognizer(tapSigningKH)
        
        
        let tapSigningNV = UITapGestureRecognizer(target: self, action: #selector(self.tapSigningNV))
        baoHanhMoTaLoiView.viewChuKyNV.isUserInteractionEnabled = true
        baoHanhMoTaLoiView.viewChuKyNV.addGestureRecognizer(tapSigningNV)
        
        let tapSigningManager = UITapGestureRecognizer(target: self, action: #selector(self.tapSigningManager))
        baoHanhMoTaLoiView.viewChuKyManager.isUserInteractionEnabled = true
        baoHanhMoTaLoiView.viewChuKyManager.addGestureRecognizer(tapSigningManager)
    }
    
    func CheckAndUploadImage()
    {
        if(self.numUPLoadImage > 0)
        {
            self.showProcessView(mShow: true)
            if(self.isImageOne == true)
            {
                self.isImageOne = false
                let imageDataPic1:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                let strBase64Pic1 = imageDataPic1.base64EncodedString(options: .endLineWithLineFeed)
                self.uploadHinhAnh(p_FileName: "tuandeptrai_image1.png", p_Base64: strBase64Pic1)
                self.baoHanhMoTaLoiView.viewCMNDTruocButton.image = nil
                
            }
            if(self.isImageTwo == true)
            {
                self.isImageTwo = false
                let imageDataPic2:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton2.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                let strBase64Pic2 = imageDataPic2.base64EncodedString(options: .endLineWithLineFeed)
                self.uploadHinhAnh(p_FileName: "tuandeptrai_image2.png", p_Base64: strBase64Pic2)
                self.baoHanhMoTaLoiView.viewCMNDTruocButton2.image = nil
                
            }
            if(self.isImageThree == true)
            {
                self.isImageThree = false
                let imageDataPic3:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton3.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                let strBase64Pic3 = imageDataPic3.base64EncodedString(options: .endLineWithLineFeed)
                self.uploadHinhAnh(p_FileName : "tuandeptrai_image3.png", p_Base64: strBase64Pic3)
                self.baoHanhMoTaLoiView.viewCMNDTruocButton3.image = nil
                
            }
            if(self.isImageFour == true)
            {
                self.isImageFour = false
                let imageDataPic4:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton4.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                let strBase64Pic4 = imageDataPic4.base64EncodedString(options: .endLineWithLineFeed)
                self.uploadHinhAnh(p_FileName : "tuandeptrai_image4.png", p_Base64: strBase64Pic4)
                self.baoHanhMoTaLoiView.viewCMNDTruocButton4.image = nil
                
            }
            if(self.isImageFive == true)
            {
                self.isImageFive = false
                let imageDataPic5:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton5.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                let strBase64Pic5 = imageDataPic5.base64EncodedString(options: .endLineWithLineFeed)
                self.uploadHinhAnh(p_FileName : "tuandeptrai_image5.png", p_Base64: strBase64Pic5)
                self.baoHanhMoTaLoiView.viewCMNDTruocButton5.image = nil
                
            }
            if(self.isImageSix == true)
            {
                self.isImageSix = false
                let imageDataPic6:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton6.image!.jpegData(compressionQuality:  Common.resizeImageValueFF) as NSData?)!
                let strBase64Pic6 = imageDataPic6.base64EncodedString(options: .endLineWithLineFeed)
                self.uploadHinhAnh(p_FileName : "tuandeptrai_image6.png", p_Base64: strBase64Pic6)
                self.baoHanhMoTaLoiView.viewCMNDTruocButton6.image = nil
                
            }
        }
        else
        {
            //self.StepTwoHoanThanhClick()
            //self.showDialog(mMess: "Vui lòng đính kèm ít nhất 1 ảnh")
            
            self.showDialog(mMess: "Vui lòng đính kèm ít nhất 1 ảnh!")
        }
    }
    
    
    
    /////new 17/08
    func CheckAndUploadImageNew()
    {
        
        
        if(self.numUPLoadImage > 0)
        {
            self.showProcessView(mShow: true)
            if(self.isImageOne == true)
            {
                self.isImageOne = false
                let imageDataPic1:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                let strBase64Pic1 = imageDataPic1.base64EncodedString(options: .endLineWithLineFeed)
                self.baoHanhMoTaLoiView.viewCMNDTruocButton.image = nil
                let mObject = BaoHanhUploadImageNewObject(p_FileName:"ios_1.png", p_Base64: strBase64Pic1, p_IsSign:"0")
                mArrayBaoHanhUploadImageNewObject.append(mObject)
            }
            if(self.isImageTwo == true)
            {
                self.isImageTwo = false
                let imageDataPic2:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton2.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                let strBase64Pic2 = imageDataPic2.base64EncodedString(options: .endLineWithLineFeed)
                self.baoHanhMoTaLoiView.viewCMNDTruocButton2.image = nil
                let mObject = BaoHanhUploadImageNewObject(p_FileName:"ios_2.png", p_Base64: strBase64Pic2, p_IsSign:"0")
                mArrayBaoHanhUploadImageNewObject.append(mObject)
                
            }
            if(self.isImageThree == true)
            {
                self.isImageThree = false
                let imageDataPic3:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton3.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                let strBase64Pic3 = imageDataPic3.base64EncodedString(options: .endLineWithLineFeed)
                self.baoHanhMoTaLoiView.viewCMNDTruocButton3.image = nil
                let mObject = BaoHanhUploadImageNewObject(p_FileName:"ios_3.png", p_Base64: strBase64Pic3, p_IsSign:"0")
                mArrayBaoHanhUploadImageNewObject.append(mObject)
                
            }
            if(self.isImageFour == true)
            {
                self.isImageFour = false
                let imageDataPic4:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton4.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                let strBase64Pic4 = imageDataPic4.base64EncodedString(options: .endLineWithLineFeed)
                self.baoHanhMoTaLoiView.viewCMNDTruocButton4.image = nil
                let mObject = BaoHanhUploadImageNewObject(p_FileName:"ios_4.png", p_Base64: strBase64Pic4, p_IsSign:"0")
                mArrayBaoHanhUploadImageNewObject.append(mObject)
                
            }
            if(self.isImageFive == true)
            {
                self.isImageFive = false
                let imageDataPic5:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton5.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                let strBase64Pic5 = imageDataPic5.base64EncodedString(options: .endLineWithLineFeed)
                self.baoHanhMoTaLoiView.viewCMNDTruocButton5.image = nil
                let mObject = BaoHanhUploadImageNewObject(p_FileName:"ios_5.png", p_Base64: strBase64Pic5, p_IsSign:"0")
                mArrayBaoHanhUploadImageNewObject.append(mObject)
                
            }
            if(self.isImageSix == true)
            {
                self.isImageSix = false
                let imageDataPic6:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton6.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                let strBase64Pic6 = imageDataPic6.base64EncodedString(options: .endLineWithLineFeed)
                self.baoHanhMoTaLoiView.viewCMNDTruocButton6.image = nil
                let mObject = BaoHanhUploadImageNewObject(p_FileName:"ios_6.png", p_Base64: strBase64Pic6, p_IsSign:"0")
                mArrayBaoHanhUploadImageNewObject.append(mObject)
                
            }
            let mObjectNV = BaoHanhUploadImageNewObject(p_FileName:"ios_chukinv.png", p_Base64: mString64Employ, p_IsSign:"1")
            mArrayBaoHanhUploadImageNewObject.append(mObjectNV)
            
            let mObjectQL = BaoHanhUploadImageNewObject(p_FileName:"ios_chukiQL.png", p_Base64: mString64Manager, p_IsSign:"2")
            mArrayBaoHanhUploadImageNewObject.append(mObjectQL)
            
            let mObjectKH = BaoHanhUploadImageNewObject(p_FileName:"ios_chukiKH.png", p_Base64: mString64Custom, p_IsSign:"3")
            mArrayBaoHanhUploadImageNewObject.append(mObjectKH)
            
            
            
            let mObjectParam = BaoHanhUploadImageNewParamObject(p_UserCode:"\(Cache.user!.UserName)", p_UserName: "\(Cache.user!.EmployeeName)",p_MaPhieuBH:"-1",mObject: mArrayBaoHanhUploadImageNewObject)
            
            
            MPOSAPIManager.BaoHanhUploadImageNew(mListObject:mObjectParam){ (error: Error? , success: Bool,result: String!,resultMessage:String!) in
                
                if success
                {
                    self.strChuoiDinhKem = result
                    self.StepTwoHoanThanhClick()
                }
                else
                {
                    self.showDialog(mMess: "Lưu hình ảnh thất bại")
                }
            }
        }
            
        else
        {
            self.showDialog(mMess: "Vui lòng đính kèm ít nhất 1 ảnh!")
        }
    }
    
    func CheckAndUploadImageNew2(){
        if(self.numUPLoadImage > 0)
        {
            self.showProcessView(mShow: true)
            if(self.isImageOne == true)
            {
                self.isImageOne = false
                let imageDataPic1:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                let strBase64Pic1 = imageDataPic1.base64EncodedString(options: .endLineWithLineFeed)
                self.baoHanhMoTaLoiView.viewCMNDTruocButton.image = nil
                
                self.uploadImage2(p_FileName: "ios_1.png", p_Base64: strBase64Pic1, p_IsSign: "0",isType: "1")
                return
            }
            if(self.isImageTwo == true)
            {
                print("isImageTwo")
                self.isImageTwo = false
                let imageDataPic2:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton2.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                let strBase64Pic2 = imageDataPic2.base64EncodedString(options: .endLineWithLineFeed)
                self.baoHanhMoTaLoiView.viewCMNDTruocButton2.image = nil
                
                self.uploadImage2(p_FileName: "ios_2.png", p_Base64: strBase64Pic2, p_IsSign: "0",isType: "2")
                return
            }
            if(self.isImageThree == true)
            {
                self.isImageThree = false
                let imageDataPic3:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton3.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                let strBase64Pic3 = imageDataPic3.base64EncodedString(options: .endLineWithLineFeed)
                self.baoHanhMoTaLoiView.viewCMNDTruocButton3.image = nil
                
                self.uploadImage2(p_FileName: "ios_3.png", p_Base64: strBase64Pic3, p_IsSign: "0",isType: "3")
                return
            }
            if(self.isImageFour == true)
            {
                self.isImageFour = false
                let imageDataPic4:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton4.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                let strBase64Pic4 = imageDataPic4.base64EncodedString(options: .endLineWithLineFeed)
                self.baoHanhMoTaLoiView.viewCMNDTruocButton4.image = nil
                
                self.uploadImage2(p_FileName: "ios_4.png", p_Base64: strBase64Pic4, p_IsSign: "0", isType: "4")
                return
            }
            if(self.isImageFive == true)
            {
                self.isImageFive = false
                let imageDataPic5:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton5.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                let strBase64Pic5 = imageDataPic5.base64EncodedString(options: .endLineWithLineFeed)
                self.baoHanhMoTaLoiView.viewCMNDTruocButton5.image = nil
                
                self.uploadImage2(p_FileName: "ios_5.png", p_Base64: strBase64Pic5, p_IsSign: "0", isType: "5")
                return
            }
            if(self.isImageSix == true)
            {
                self.isImageSix = false
                let imageDataPic6:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton6.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                let strBase64Pic6 = imageDataPic6.base64EncodedString(options: .endLineWithLineFeed)
                self.baoHanhMoTaLoiView.viewCMNDTruocButton6.image = nil
                
                self.uploadImage2(p_FileName: "ios_6.png", p_Base64: strBase64Pic6, p_IsSign: "0", isType: "6")
                return
            }
            if(self.isImageChuKyNV == true){
                self.isImageChuKyNV = false
                
                self.uploadImage2(p_FileName: "ios_chukinv.png", p_Base64: mString64Employ, p_IsSign: "1", isType: "NV")
                return
            }
            if(self.isImageChuKyQL == true){
                self.isImageChuKyQL = false
                
                self.uploadImage2(p_FileName: "ios_chukiQL.png", p_Base64: mString64Manager, p_IsSign: "2" , isType: "QL")
                return
            }
            if(self.isImageChuKyKH == true){
                self.isImageChuKyKH = false
                
                self.uploadImage2(p_FileName: "ios_chukiKH.png", p_Base64: mString64Custom, p_IsSign: "3" , isType: "KH")
                return
            }
            
            
            
            
            
        }
            
        else
        {
            
            
            self.showDialog(mMess: "Vui lòng đính kèm ít nhất 1 ảnh!")
        }
    }
    
    func uploadImage2(p_FileName:String,p_Base64:String,p_IsSign:String,isType:String){
        MPOSAPIManager.UpLoadImageSingle_TaoPhieuBH(p_MaPhieuBH: "-1", p_FileName: p_FileName, p_Base64: p_Base64, p_IsSign: p_IsSign){ (err, success,result,resultMessage) in
            
            if success
            {
                if(isType == "1"){
                    print("isType 1")
                    self.strChuoiDinhKem1 = result!
                    self.CheckAndUploadImageNew2()
                }
                if(isType == "2"){
                    print("isType 2")
                    self.strChuoiDinhKem2 = result!
                    self.CheckAndUploadImageNew2()
                }
                if(isType == "3"){
                    print("isType 3")
                    self.strChuoiDinhKem3 = result!
                    self.CheckAndUploadImageNew2()
                }
                if(isType == "4"){
                    print("isType 4")
                    self.strChuoiDinhKem4 = result!
                    self.CheckAndUploadImageNew2()
                }
                if(isType == "5"){
                    print("isType 5")
                    self.strChuoiDinhKem5 = result!
                    self.CheckAndUploadImageNew2()
                }
                if(isType == "6"){
                    print("isType 6")
                    self.strChuoiDinhKem6 = result!
                    self.CheckAndUploadImageNew2()
                }
                if(isType == "NV"){
                    print("isType NV")
                    self.strChuoiDinhKemChuKyNV = result!
                    self.CheckAndUploadImageNew2()
                }
                if(isType == "QL"){
                    print("isType QL")
                    self.strChuoiDinhKemChuKyQL = result!
                    self.CheckAndUploadImageNew2()
                }
                if(isType == "KH"){
                    print("isType KH")
                    self.strChuoiDinhKemChuKyKH = result!
                    self.strChuoiDinhKem = self.strChuoiDinhKemChuKyKH + ",\(self.strChuoiDinhKemChuKyNV)" +
                        ",\(self.strChuoiDinhKemChuKyQL)" + ",\(self.strChuoiDinhKem1)"
                    
                    if(self.strChuoiDinhKem2 != ""){
                        self.strChuoiDinhKem = self.strChuoiDinhKem + ",\(self.strChuoiDinhKem2)"
                    }
                    if(self.strChuoiDinhKem3 != ""){
                        self.strChuoiDinhKem = self.strChuoiDinhKem + ",\(self.strChuoiDinhKem3)"
                    }
                    if(self.strChuoiDinhKem4 != ""){
                        self.strChuoiDinhKem = self.strChuoiDinhKem + ",\(self.strChuoiDinhKem4)"
                    }
                    if(self.strChuoiDinhKem5 != ""){
                        self.strChuoiDinhKem = self.strChuoiDinhKem + ",\(self.strChuoiDinhKem5)"
                    }
                    if(self.strChuoiDinhKem6 != ""){
                        self.strChuoiDinhKem = self.strChuoiDinhKem + ",\(self.strChuoiDinhKem6)"
                    }
                    print(self.strChuoiDinhKem)
                    self.StepTwoHoanThanhClick()
                }
                
                
                
            }
            else
            {
                if(err != ""){
                    self.showDialog(mMess: err)
                }else{
                    self.showDialog(mMess: "Kết nối api thất bại!")
                }
                
            }
        }
    }
    
    
    
    
    
    
    @objc func ClickHoanTat()
    {
        print("A")
        _ = checkStepOne()
        _ = checkStepTwo()
        
        if(mString64Custom == "")
        {
            let alert = UIAlertController(title: "Thông Báo", message: "Vui lòng xác nhận chữ kí khách hàng", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ action in
                
            }))
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        if(mString64Employ == "")
        {
            let alert = UIAlertController(title: "Thông Báo", message: "Vui lòng xác nhận chữ kí nhân viên", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ action in
                
            }))
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        if(mString64Manager == "")
        {
            let alert = UIAlertController(title: "Thông Báo", message: "Vui lòng xác nhận chữ kí quản lý", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ action in
                
            }))
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        
        
        let mCanGo:Bool = GetThongBaoAfferClickHoanTat()
        if(mCanGo == true)
        {
            ////case new
            if(self.baohanhThongTinChungView.hinhthucBHButton.text !=  "Dịch vụ")
            {
                for i in 0 ..< arrTinhTrangMay.count
                {
                    if( arrTinhTrangMay[i].MaTinhTrang == "3" && arrTinhTrangMay[i].KHGiaoShop == "true"
                        || arrTinhTrangMay[i].MaTinhTrang == "4" && arrTinhTrangMay[i].KHGiaoShop == "true"
                        || arrTinhTrangMay[i].MaTinhTrang == "5" && arrTinhTrangMay[i].KHGiaoShop == "true"
                        || arrTinhTrangMay[i].MaTinhTrang == "7" && arrTinhTrangMay[i].KHGiaoShop == "true") {
                        
                        let alert = UIAlertController(title: "Thông Báo", message: "Máy có thể bị từ chối bảo hành, \nShop lưu ý trao đổi với khách hàng và xem xét có chọn loại hình thức bảo hành “Dịch vụ” hay không?", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ action in
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                        return
                        //showDialog(mMess: " ")
                    }
                }
            }
            ////case 25
            if(self.strNhanHang == "26" && self.baohanhThongTinChungView.hinhthucBHButton.text !=  "Dịch vụ")
            {
                for i in 0 ..< arrTinhTrangMay.count
                {
                    if(arrTinhTrangMay[i].MaTinhTrang == "2" && arrTinhTrangMay[i].KHGiaoShop == "true" ||  arrTinhTrangMay[i].MaTinhTrang == "3" && arrTinhTrangMay[i].KHGiaoShop == "true"
                        || arrTinhTrangMay[i].MaTinhTrang == "4" && arrTinhTrangMay[i].KHGiaoShop == "true" || arrTinhTrangMay[i].MaTinhTrang == "5" && arrTinhTrangMay[i].KHGiaoShop == "true"
                        || arrTinhTrangMay[i].MaTinhTrang == "6" && arrTinhTrangMay[i].KHGiaoShop == "true" || arrTinhTrangMay[i].MaTinhTrang == "7" && arrTinhTrangMay[i].KHGiaoShop == "true"
                        || arrTinhTrangMay[i].MaTinhTrang == "8" && arrTinhTrangMay[i].KHGiaoShop == "true")
                    {
                        
                        
                        let alert = UIAlertController(title: "Thông Báo", message: "Máy có thể bị từ chối bảo hành, \nShop lưu ý trao đổi với khách hàng và xem xét có chọn loại hình thức bảo hành “Dịch vụ” hay không?", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ action in
                            
                            // do something like...
                            //self.CheckAndUploadImage()
                            //self.CheckAndUploadImageNew()
                            self.CheckAndUploadImageNew2()
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                        //showDialog(mMess: " ")
                    }
                }
            }
            if(self.strLockKnox != "0" )
            {
                let alert = UIAlertController(title: "Thông Báo", message: "Khi nhận bảo hành máy có F.Knox trên CRM, yêu cầu Shop thực hiện kết nối mạng cho máy ngay tại thời điểm tạo phiếu để F.Knox cập nhật trạng thái và tự mở khóa (auto unlock F.Knox). Trong vòng 30 phút sau khi tạo phiếu , kỹ thuật shop có thể tiến hành chạy smart tool và xử lý chạy phần mềm." + "\n Các trường hợp đặc biệt không thể kết nối mạng cho máy như: mất nguồn, hỏng màn hình, quên mật khẩu màn hình.. Yêu cầu kỹ thuật shop note trên phiếu bảo hành đầy đủ thông tin."
                    + "\nNếu máy phải chuyển qua hãng để xử lý bảo hành/thẩm định lỗi, nhân viên shop phải chuyển trạng thái bàn giao qua TTBH và thực hiện kết nối mạng cho máy để F.Knox cập nhật trạng thái và tự mở khóa (auto unlock F.Knox)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ action in
                    
                    // do something like...
                    //self.CheckAndUploadImage()
                    //self.CheckAndUploadImageNew()
                    self.CheckAndUploadImageNew2()
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                /////step 1 upload image
                //self.CheckAndUploadImage()
                //self.CheckAndUploadImageNew()
                self.CheckAndUploadImageNew2()
                self.baohanhThongTinChungView.btnHoanTat.isEnabled = false
                
            }
            
        }
        
    }
    
    func StepTwoHoanThanhClick()
    {
        
        
        GetDataForHoanTat()
        GetDataTaoPhieuBH_LuuPhieuBH(p_LoaiBH: "\(strLoaiBH)",
            p_HinhThucBH: "\(strHinhThucBH)",
            p_MoTaLoi: "\(strMoTaLoi)",
            p_DienGiai:"\(strDienGiai)",
            p_NgayDuKienTra: "\(strNgayDuKienTra)",
            p_MaShopTao: "\(strMaShopTao)",
            p_TenShopTao:"\(strTenShopTao)",
            p_NhanVienTao: "\(strNhanVienTao)",
            p_MaTTBH1:"\(strMaTTBH1)",
            p_MaTTBH2: "\(strMaTTBH2)",
            p_MaHTBanGiao: "\(strMaHTBanGiao)",
            p_TenHTBanGiao:"\(strTenHTBanGiao)",
            p_SoNgayCamKet: "\(strSoNgayCamKet)",
            p_SanPhamBH:"\(strSanPhamBH)",
            p_SolanBH: "\(strSolanBH)",
            p_SoDonHang: "\(strSoDonHang)",
            p_MaCuaHangBan:"\(strMaCuaHangBan)",
            p_TenCuaHangBan: "\(strTenCuaHangBan)",
            p_LoaiDonHang:"\(strLoaiDonHang)",
            p_MaSanPham: "\(strMaSanPham)",
            p_TenSanPham: "\(strTenSanPham)",
            p_NgayHetHanBH:"\(strNgayHetHanBH)",
            p_NgayMua: "\(strNgayMua)",
            p_SoHoaDonDo:"\(strSoHoaDonDo)",
            p_Imei: "\(strImei)",
            p_Imei2: "\(strImei2)",
            p_MaSPBHV:"\(strMaSPBHV)",
            p_SoLanBHV: "\(strSoLanBHV)",
            p_MaHopDongBHV:"\(strMaHopDongBHV)",
            p_TrangThaiBHV: "\(strTrangThaiBHV)",
            p_MauSac: "\(strMauSac)",
            p_TenKH:"\(self.baohanhThongTinChungView.edtTenLienHe.text!)",
            p_SoDienThoaiKH: "\(self.baohanhThongTinChungView.edtSDTLienHe.text!)",
            p_SoDienThoaiKhac:"\(self.baohanhThongTinChungView.edtSDTLienHeKhac.text!)",
            p_DiaChi: "\(self.baohanhThongTinChungView.edtDiaChiLienHe.text!)",
            p_GhiChu: "\(self.baohanhThongTinChungView.edtGhiChuLienHe.text!)",
            p_Email:"\(self.baohanhThongTinChungView.edtMailLienHe.text!)",
            p_MaKho: "\(strMaKho)",
            p_TB_PhuKien_PhieuBH:"\(strListPhuKienXML)",
            p_TB_TinhTrangMay_PhieuBH: "\(strListTinhTrangMayXML)",
            p_MaSPBHNhanh: "\(strMaSPBHNhanh)",
            p_MaHDBHNhanh:"\(strMaHDBHNhanh)",
            p_HieuLucBHNhanh: "",
            p_MaSPBHTanNoi:"\(strMaSPBHTanNoi)",
            p_MaHDBHTanNoi: "\(strMaHDBHTanNoi)",
            p_HieuLucBHTanNoi: "\(strHieuLucBHTanNoi)",
            p_MaSPBHVIP:"\(strMaSPBHVIP)",
            p_MaHDBHVIP: "\(strMaHDBHVIP)",
            p_HieuLucVIP:"\(strHieuLucVIP)",
            p_MaBook: "\(strMaBook)",
            p_MaSPSamSungVIP: "\(strMaSPSamSungVIP)",
            p_MaHDSamSungVIP:"\(strMaHDSamSungVIP)",
            p_HieuLucSamSungVIP: "\(strHieuLucSamSungVIP)",
            p_ChuoiDinhKem: "\(strChuoiDinhKem)", p_IsCapMobile: "\(p_IsCapMobile)",p_NgayCapLaiICloud : "\(self.dayIcloud)")
    }
    
    
    
    func GetDataTaoPhieuBH_LuuPhieuBH(p_LoaiBH: String,p_HinhThucBH:String,p_MoTaLoi: String,p_DienGiai:String,p_NgayDuKienTra: String,p_MaShopTao: String,p_TenShopTao:String,p_NhanVienTao: String,p_MaTTBH1:String,p_MaTTBH2: String,p_MaHTBanGiao: String,p_TenHTBanGiao:String,p_SoNgayCamKet: String,p_SanPhamBH:String,p_SolanBH: String,p_SoDonHang: String,p_MaCuaHangBan:String,p_TenCuaHangBan: String,p_LoaiDonHang:String,p_MaSanPham: String,p_TenSanPham: String,p_NgayHetHanBH:String,p_NgayMua: String,p_SoHoaDonDo:String,p_Imei: String,p_Imei2: String,p_MaSPBHV:String,p_SoLanBHV: String,p_MaHopDongBHV:String,p_TrangThaiBHV: String,p_MauSac: String,p_TenKH:String,p_SoDienThoaiKH: String,p_SoDienThoaiKhac:String,p_DiaChi: String,p_GhiChu: String,p_Email:String,p_MaKho: String,p_TB_PhuKien_PhieuBH:String,p_TB_TinhTrangMay_PhieuBH: String,p_MaSPBHNhanh: String,p_MaHDBHNhanh:String,p_HieuLucBHNhanh: String,p_MaSPBHTanNoi:String,p_MaHDBHTanNoi: String,p_HieuLucBHTanNoi: String,p_MaSPBHVIP:String,p_MaHDBHVIP: String,p_HieuLucVIP:String,p_MaBook: String,p_MaSPSamSungVIP: String,p_MaHDSamSungVIP:String,p_HieuLucSamSungVIP: String,p_ChuoiDinhKem:String,p_IsCapMobile:String,p_NgayCapLaiICloud:String)
    {
        
        MPOSAPIManager.TaoPhieuBH_LuuPhieuBH(p_LoaiBH: p_LoaiBH,p_HinhThucBH:p_HinhThucBH,p_MoTaLoi: p_MoTaLoi,p_DienGiai:p_DienGiai,p_NgayDuKienTra: p_NgayDuKienTra,p_MaShopTao: p_MaShopTao,p_TenShopTao:p_TenShopTao,p_NhanVienTao: p_NhanVienTao,p_MaTTBH1:p_MaTTBH1,p_MaTTBH2: p_MaTTBH2,p_MaHTBanGiao: p_MaHTBanGiao,p_TenHTBanGiao:p_TenHTBanGiao,p_SoNgayCamKet: p_SoNgayCamKet,p_SanPhamBH:p_SanPhamBH,p_SolanBH: p_SolanBH,p_SoDonHang: p_SoDonHang,p_MaCuaHangBan:p_MaCuaHangBan,p_TenCuaHangBan: p_TenCuaHangBan,p_LoaiDonHang:p_LoaiDonHang,p_MaSanPham: p_MaSanPham,p_TenSanPham: p_TenSanPham,p_NgayHetHanBH:p_NgayHetHanBH,p_NgayMua: p_NgayMua,p_SoHoaDonDo:p_SoHoaDonDo,p_Imei: p_Imei,p_Imei2: p_Imei2,p_MaSPBHV:p_MaSPBHV,p_SoLanBHV: p_SoLanBHV,p_MaHopDongBHV:p_MaHopDongBHV,p_TrangThaiBHV: p_TrangThaiBHV,p_MauSac: p_MauSac,p_TenKH:p_TenKH,p_SoDienThoaiKH: p_SoDienThoaiKH,p_SoDienThoaiKhac:p_SoDienThoaiKhac,p_DiaChi: p_DiaChi,p_GhiChu: p_GhiChu,p_Email:p_Email,p_MaKho: p_MaKho,p_TB_PhuKien_PhieuBH:p_TB_PhuKien_PhieuBH,p_TB_TinhTrangMay_PhieuBH: p_TB_TinhTrangMay_PhieuBH,p_MaSPBHNhanh: p_MaSPBHNhanh,p_MaHDBHNhanh:p_MaHDBHNhanh,p_HieuLucBHNhanh: p_HieuLucBHNhanh,p_MaSPBHTanNoi:p_MaSPBHTanNoi,p_MaHDBHTanNoi: p_MaHDBHTanNoi,p_HieuLucBHTanNoi: p_HieuLucBHTanNoi,p_MaSPBHVIP:p_MaSPBHVIP,p_MaHDBHVIP: p_MaHDBHVIP,p_HieuLucVIP:p_HieuLucVIP,p_MaBook: p_MaBook,p_MaSPSamSungVIP: p_MaSPSamSungVIP,p_MaHDSamSungVIP:p_MaHDSamSungVIP,p_HieuLucSamSungVIP: p_HieuLucSamSungVIP, p_TypeDevice: "2",p_ChuoiDinhKem:p_ChuoiDinhKem,p_IsCapMobile:p_IsCapMobile,p_NgayCapLaiICloud:p_NgayCapLaiICloud){ (error: Error? , success: Bool,result: TaoPhieuBH_LuuPhieuBHResult!) in
            if success
            {
                
                self.baohanhThongTinChungView.btnHoanTat.isEnabled = true
                if result != nil {
                    if(result.Result == "1")
                    {
                        //self.showDialogAndPushToView(mMess: "Tạo phiếu bảo hành thành công-Số phiếu \(result.SophieuBH)")
                        ///////15/08/2018 updatehere
                        
                        self.GetDataImageBienBanBH(p_MaPhieuBH: result.SophieuBH,  p_Base64_CusSign:"\(self.mString64Custom)",p_Base64_EplSign
                            : "\(self.mString64Employ)", p_Type:"0", p_UserCode:"\(Cache.user!.UserName)", p_UserName:"\(Cache.user!.EmployeeName)",p_Manager: "",
                                                         p_ManagerSignature: "\(self.mString64Manager)",ThongBaoLoi: result.ThongBaoLoi)
                        /////
                        self.strMaPhieu_BH = result.SophieuBH
                        print("TaoPhieuBH_LuuPhieuBH sucess")
                    }
                    else
                    {
                        self.showProcessView(mShow: false)
                        self.showDialogAndPushToView(mMess: "\(result.ThongBaoLoi)")
                    }
                }else{
                    self.showDialog(mMess: "Lưu hình ảnh thất bại")
                    self.baohanhThongTinChungView.btnHoanTat.isEnabled = true
                    self.showProcessView(mShow: false)
                    
                }
          
            }
            else
            {
                self.showDialog(mMess: "Lưu hình ảnh thất bại")
                self.baohanhThongTinChungView.btnHoanTat.isEnabled = true
                self.showProcessView(mShow: false)
            }
        }
    }
    /////get data
    func GetDataImageBienBanBH(p_MaPhieuBH:String,  p_Base64_CusSign:String,p_Base64_EplSign
        : String, p_Type:String, p_UserCode:String, p_UserName:String,p_Manager: String,
                  p_ManagerSignature: String,ThongBaoLoi:String)
    {
        self.showProcessView(mShow: true)
        MPOSAPIManager.GetImageBienBanBH(p_MaPhieuBH:p_MaPhieuBH,  p_Base64_CusSign:p_Base64_CusSign,p_Base64_EplSign
        : p_Base64_EplSign, p_Type:p_Type, p_UserCode:p_UserCode, p_UserName:p_UserName,p_Manager: p_Manager,p_ManagerSignature: p_ManagerSignature){ (error: Error? , success: Bool,result: String!,resultMessage:String!) in
            self.showProcessView(mShow: false)
            
            if success
            {
                
                if(result != nil  )
                {
                    //self.ShowDialog(mMess: "ok")
                    if(result == "1")
                    {
                        
                        //self.showDialog(mMess: "Thành công - \(resultMessage!)")
                        
                        self.GetDataGoiPopupHang_Mobile(p_MaPhieuBH:  "\(p_MaPhieuBH)",ThongBaoLoi:ThongBaoLoi)
                    }
                    else
                    {
                        self.showDialog(mMess: "\(resultMessage!)")
                    }
                    
                }
                else
                {
                    self.showDialog(mMess: "Không tìm thấy kết quả")
                }
                
            }
            else
            {
                
                self.showDialog(mMess: "Không tìm thấy kết quả")
            }
        }
    }
    
    
    
    
    func GetDataForHoanTat()
    {
        /// step 3 get data
        self.strMoTaLoi = baoHanhMoTaLoiView.edtMoTaLoi.text!
        self.strDienGiai = baoHanhMoTaLoiView.edtDDTinhTrang.text!
        self.strDiaChi = baohanhThongTinChungView.edtDiaChiLienHe.text!
        self.strGhiChu = baohanhThongTinChungView.edtGhiChuLienHe.text!
        self.strEmail = baohanhThongTinChungView.edtMailLienHe.text!
        // self.strImei = baohanhThongTinChungView.edtImei.text!
        self.strImei = self.imei
        GetXMLPhuKien()
        GetXMLMoTaLoi()
    }
    
    func GetXMLPhuKien()
    {
        if(arrPhuKien.count > 0)
        {
            var strXMLSample = ""
            for i in 0 ..< arrPhuKien.count
            {
                if(arrPhuKien[i].KHGiaoShop == "true")
                {
                    strXMLSample = strXMLSample + "<DATA>" + "<MaPK>" + "\(arrPhuKien[i].MaPK)" + "</MaPK>" + "<KHGiaoShop>" + "\(arrPhuKien[i].KHGiaoShop)" + "</KHGiaoShop>" + "<Serial>" + "\(arrPhuKien[i].Serial)" + "</Serial>"  + "<SoLuong>" + "\(arrPhuKien[i].SoLuong)" + "</SoLuong>"  + "<TinhTrangShop>" + "\(arrPhuKien[i].TinhTrangShop)" + "</TinhTrangShop>" + "<NgayTaoKhGiaoShop>" + "</NgayTaoKhGiaoShop>" + "<NguoiTaoKHGiaoShop>" + "</NguoiTaoKHGiaoShop>" + "</DATA>";
                    if(arrPhuKien[i].MaPK == "16"){
                        p_IsCapMobile = 1
                    }
                }
            }
            strXMLSample = "<Document>" + strXMLSample + "</Document>";
            strListPhuKienXML = strXMLSample
            print("strListPhuKienXML : \(strListPhuKienXML)")
            
        }
    }
    
    func GetXMLMoTaLoi()
    {
        let mDate = Date()
        let mFormatter = DateFormatter()
        mFormatter.dateFormat = "dd/MM/yyyy"
        let mResult = mFormatter.string(from: mDate)
        
        if(arrTinhTrangMay.count > 0)
        {
            var strXMLSample = ""
            for i in 0 ..< arrTinhTrangMay.count
            {
                if(arrTinhTrangMay[i].KHGiaoShop == "true")
                {
                    if(arrTinhTrangMay[i].MaTinhTrang != "10")
                    {
                        strXMLSample = strXMLSample + "<DATA>" + "<MaTinhTrangMay>" + "\(arrTinhTrangMay[i].MaTinhTrang)" + "</MaTinhTrangMay>" + "<DienGiai>" + "" + "</DienGiai>" + "<NguoiTao>" +  "\(Cache.user!.UserName)" + "</NguoiTao>"  + "<NgayTao>" + "\(mResult)" + "</NgayTao>" + "</DATA>";
                    }
                    else
                    {
                        strXMLSample = strXMLSample + "<DATA>" + "<MaTinhTrangMay>" + "\(arrTinhTrangMay[i].MaTinhTrang)" + "</MaTinhTrangMay>" + "<DienGiai>" + "\(self.baoHanhMoTaLoiView.edtDDTinhTrang.text!)" + "</DienGiai>" + "<NguoiTao>" +  "\(Cache.user!.UserName)" + "</NguoiTao>"  + "<NgayTao>" + "</NgayTao>" + "\(mResult)" + "</DATA>";
                    }
                    
                }
                else
                {
                    if(arrTinhTrangMay[i].MaTinhTrang == "10" && self.baoHanhMoTaLoiView.edtDDTinhTrang.text != "" )
                    {
                        strXMLSample = strXMLSample + "<DATA>" + "<MaTinhTrangMay>" + "\(arrTinhTrangMay[i].MaTinhTrang)" + "</MaTinhTrangMay>" + "<DienGiai>" + "\(self.baoHanhMoTaLoiView.edtDDTinhTrang.text!)"  + "</DienGiai>" + "<NguoiTao>" +  "\(Cache.user!.UserName)" + "</NguoiTao>"  + "<NgayTao>" + "\(mResult)" + "</NgayTao>" + "</DATA>";
                    }
                }
            }
            strXMLSample = "<Document>" + strXMLSample + "</Document>";
            strListTinhTrangMayXML = strXMLSample
            print("strListTinhTrangMayXML : \(strListTinhTrangMayXML)")
            
            
            
        }
    }
    
    //////TaoPhieuBH_UpLoadImage(target: String,base64:String,
    func uploadHinhAnh(p_FileName: String,p_Base64:String)
    {
        
        self.showProcessView(mShow: true)
        MPOSAPIManager.TaoPhieuBH_UpLoadImage(p_FileName: p_FileName,p_UserCode : "\(Cache.user!.UserName)", p_UserName: "\(Cache.user!.EmployeeName)", p_Base64:p_Base64){ (error: Error? , success: Bool,result: BaoHanhUpLoadImageResult!) in
            if success
            {
                if(result.Result == "1")
                {
                    self.numUPLoadImage = self.numUPLoadImage - 1
                    if(self.strChuoiDinhKem != "")
                    {
                        self.strChuoiDinhKem = self.strChuoiDinhKem + ",\(result.ImageName)"
                    }
                    else
                    {
                        self.strChuoiDinhKem = "\(result.ImageName)"
                    }
                    
                    if(self.numUPLoadImage > 0)
                    {
                        if(self.isImageOne == true)
                        {
                            let imageDataPic1:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                            let strBase64Pic1 = imageDataPic1.base64EncodedString(options: .endLineWithLineFeed)
                            self.uploadHinhAnh(p_FileName: "tuandeptrai_image1.png", p_Base64: strBase64Pic1)
                            self.baoHanhMoTaLoiView.viewCMNDTruocButton.image = nil
                            self.isImageOne = false
                        }
                        if(self.isImageTwo == true)
                        {
                            let imageDataPic2:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton2.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                            let strBase64Pic2 = imageDataPic2.base64EncodedString(options: .endLineWithLineFeed)
                            self.uploadHinhAnh(p_FileName: "tuandeptrai_image2.png", p_Base64: strBase64Pic2)
                            self.baoHanhMoTaLoiView.viewCMNDTruocButton2.image = nil
                            self.isImageTwo = false
                        }
                        if(self.isImageThree == true)
                        {
                            let imageDataPic3:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton3.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                            let strBase64Pic3 = imageDataPic3.base64EncodedString(options: .endLineWithLineFeed)
                            self.uploadHinhAnh(p_FileName: "tuandeptrai_image3.png", p_Base64: strBase64Pic3)
                            self.baoHanhMoTaLoiView.viewCMNDTruocButton3.image = nil
                            self.isImageThree = false
                        }
                        if(self.isImageFour == true)
                        {
                            let imageDataPic3:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton4.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                            let strBase64Pic3 = imageDataPic3.base64EncodedString(options: .endLineWithLineFeed)
                            self.uploadHinhAnh(p_FileName: "tuandeptrai_image4.png", p_Base64: strBase64Pic3)
                            self.baoHanhMoTaLoiView.viewCMNDTruocButton4.image = nil
                            self.isImageFour = false
                        }
                        
                        if(self.isImageFive == true)
                        {
                            let imageDataPic3:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton5.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                            let strBase64Pic3 = imageDataPic3.base64EncodedString(options: .endLineWithLineFeed)
                            self.uploadHinhAnh(p_FileName: "tuandeptrai_image5.png", p_Base64: strBase64Pic3)
                            self.baoHanhMoTaLoiView.viewCMNDTruocButton5.image = nil
                            self.isImageFive = false
                        }
                        
                        if(self.isImageSix == true)
                        {
                            let imageDataPic3:NSData = (self.baoHanhMoTaLoiView.viewCMNDTruocButton6.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                            let strBase64Pic3 = imageDataPic3.base64EncodedString(options: .endLineWithLineFeed)
                            self.uploadHinhAnh(p_FileName: "tuandeptrai_image6.png", p_Base64: strBase64Pic3)
                            self.baoHanhMoTaLoiView.viewCMNDTruocButton6.image = nil
                            self.isImageSix = false
                        }
                        
                        
                        
                        
                    }
                    else
                    {
                        self.StepTwoHoanThanhClick()
                    }
                }
                
            }
            else
            {
                self.showProcessView(mShow: false)
                self.showDialog(mMess: "Upload hình ảnh thất bại")
                self.baohanhThongTinChungView.btnHoanTat.isEnabled = true
            }
        }
    }
    
    
    
    /////////
    @objc func tapMoreImageFunc()
    {
        if(self.baoHanhMoTaLoiView.viewImageNVMore.frame.size.height > 0)
        {
            self.baoHanhMoTaLoiView.viewImageNVMore.frame.size.height = 0
            self.baoHanhMoTaLoiView.viewImageNVMore.isHidden = true
            
            let strTitleDetails3 = "Chọn Thêm:"
            let _: CGSize = strTitleDetails3.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:12))])
            let textRange3 = NSMakeRange(0, strTitleDetails3.count)
            let attributedText3 = NSMutableAttributedString(string: strTitleDetails3)
            attributedText3.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange3)
            // Add other attributes if needed
            self.baoHanhMoTaLoiView.txtTitleDetails.attributedText = attributedText3
            
            baoHanhMoTaLoiView.viewImageNVMore.frame.origin.y = baoHanhMoTaLoiView.viewImageNV.frame.origin.y +  baoHanhMoTaLoiView.viewImageNV.frame.size.height + Common.Size(s: 5)
            baoHanhMoTaLoiView.txtTitleDetails.frame.origin.y = baoHanhMoTaLoiView.viewImageNVMore.frame.origin.y +  baoHanhMoTaLoiView.viewImageNVMore.frame.size.height + Common.Size(s: 5)
            baoHanhMoTaLoiView.btnHoanTat.frame.origin.y = baoHanhMoTaLoiView.txtTitleDetails.frame.origin.y +  baoHanhMoTaLoiView.txtTitleDetails.frame.size.height + Common.Size(s: 5)
            baoHanhMoTaLoiView.scrollView.contentSize  = CGSize(width:UIScreen.main.bounds.size.width, height:baoHanhMoTaLoiView.btnHoanTat.frame.origin.y +  baoHanhMoTaLoiView.btnHoanTat.frame.size.height + Common.Size(s: 20))
            
        }
        else
        {
            self.baoHanhMoTaLoiView.viewImageNVMore.frame.size.height =  self.baoHanhMoTaLoiView.viewImageNV6.frame.size.height + baoHanhMoTaLoiView.viewImageNV6.frame.origin.y +  Common.Size(s:5)
            self.baoHanhMoTaLoiView.viewImageNVMore.isHidden = false
            
            let strTitleDetails3 = "Thu gọn :  "
            let _: CGSize = strTitleDetails3.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:12))])
            let textRange3 = NSMakeRange(0, strTitleDetails3.count)
            let attributedText3 = NSMutableAttributedString(string: strTitleDetails3)
            attributedText3.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange3)
            // Add other attributes if needed
            self.baoHanhMoTaLoiView.txtTitleDetails.attributedText = attributedText3
            
            baoHanhMoTaLoiView.viewImageNVMore.frame.origin.y = baoHanhMoTaLoiView.viewImageNV.frame.origin.y +  baoHanhMoTaLoiView.viewImageNV.frame.size.height + Common.Size(s: 5)
            baoHanhMoTaLoiView.txtTitleDetails.frame.origin.y = baoHanhMoTaLoiView.viewImageNVMore.frame.origin.y +  baoHanhMoTaLoiView.viewImageNVMore.frame.size.height + Common.Size(s: 5)
            baoHanhMoTaLoiView.btnHoanTat.frame.origin.y = baoHanhMoTaLoiView.txtTitleDetails.frame.origin.y +  baoHanhMoTaLoiView.txtTitleDetails.frame.size.height + Common.Size(s: 5)
            baoHanhMoTaLoiView.scrollView.contentSize  = CGSize(width:UIScreen.main.bounds.size.width, height:baoHanhMoTaLoiView.btnHoanTat.frame.origin.y +  baoHanhMoTaLoiView.btnHoanTat.frame.size.height + Common.Size(s: 20))
            
        }
        //        self.baoHanhMoTaLoiView.txtTitleDetails.frame.origin.y = self.baoHanhMoTaLoiView.viewImageNVMore.frame.origin.y + self.baoHanhMoTaLoiView.viewImageNVMore.frame.size.height +  Common.Size(s:5)
        //        self.baoHanhMoTaLoiView.btnHoanTat.frame.origin.y = self.baoHanhMoTaLoiView.txtTitleDetails.frame.origin.y + self.baoHanhMoTaLoiView.txtTitleDetails.frame.size.height +  Common.Size(s:10)
    }
    
    
    func GetDataLayTinhTrangMay()
    {
        MPOSAPIManager.LayTinhTrangMay(){ (error: Error? , success: Bool,result: [LayTinhTrangMayResult]!) in
            if success
            {
                if result != nil {
                    if(result.count > 0)
                    {
                        print("LayTinhTrangMay sucess")
                        self.arrTinhTrangMay = result
                        self.baoHanhMoTaLoiView.tableView.reloadData()
                        
                    }
                    else
                    {
                        
                    }
                }else{
                    
                }
           
                
            }
            else
            {
                
            }
        }
        
        
        
    }
    
    
    ////initTabTTDenHang
    func initTabTTDenHang()
    {
        baoHanhThongTinHang.btnHoanTat.addTarget(self, action: #selector(self.ClickHoanTatDenHang), for: .touchUpInside)
    }
    
    @objc func ClickHoanTatDenHang()
    {
        print("sadasdsadsa")
        if(strMaPhieu_BH != "")
        {
            GetDataAutoMailChoHang(p_MaPhieuBH: "\(strMaPhieu_BH)",p_BuocKiemTra:"\(baoHanhThongTinHang.edtCacBuocKiemTra.text!)",p_KetLuan:"\(baoHanhThongTinHang.edtKetLuan.text!)",p_MalinhKien:"\(baoHanhThongTinHang.edtMaLinhKien.text!)",p_GhiChu:"\(baoHanhThongTinHang.edtGhiChuLienHe.text!)",p_Type:"0")
        }
        else
        {
            self.showDialogAndPushToView(mMess: "Chưa lấy được số phiếu vui lòng thử lại")
        }
        
    }
    
    
    
    
    /////update here 15/08/2018
    @objc func tapSigningKH(sender:UITapGestureRecognizer) {
        self.mSigned = 1
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        
        //signatureVC.mBaoHanh = true
        
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
//        let nav = UINavigationController(rootViewController: signatureVC)
//        self.present(nav, animated: true, completion: nil)
        self.navigationController?.pushViewController(signatureVC, animated: true)
    }
    
    @objc func tapSigningNV(sender:UITapGestureRecognizer) {
        self.mSigned = 2
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        //signatureVC.mBaoHanh = true
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
//        let nav = UINavigationController(rootViewController: signatureVC)
//        self.present(nav, animated: true, completion: nil)
        self.navigationController?.pushViewController(signatureVC, animated: true)
    }
    
    @objc func tapSigningManager(sender:UITapGestureRecognizer) {
        self.mSigned = 3
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        //signatureVC.mBaoHanh = true
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
        
//        let nav = UINavigationController(rootViewController: signatureVC)
//        self.present(nav, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(signatureVC, animated: true)
    }
    
    
    func epSignature(_: EPSignatureViewController, didCancel error : NSError) {
        print("User canceled")
        _ = self.navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
    }
    
    func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect) {
        
        let width = baoHanhMoTaLoiView.ImageChuKyKH.frame.size.width - Common.Size(s: 10)
        //        let mHeight = baoHanhMoTaLoiView.ImageChuKyKHImage.frame.size.height
        let sca:CGFloat = boundingRect.size.width / boundingRect.size.height
        let heightImage:CGFloat = width / sca
        if(self.mSigned == 1)
        {
            baoHanhMoTaLoiView.ImageChuKyKH.subviews.forEach { $0.removeFromSuperview() }
            baoHanhMoTaLoiView.ImageChuKyKHImage  = UIImageView(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: width, height: heightImage))
            baoHanhMoTaLoiView.ImageChuKyKHImage.image = cropImage(image: signatureImage, toRect: boundingRect)
            baoHanhMoTaLoiView.ImageChuKyKHImage.contentMode = .scaleAspectFit
            baoHanhMoTaLoiView.ImageChuKyKH.addSubview(baoHanhMoTaLoiView.ImageChuKyKHImage)
            baoHanhMoTaLoiView.ImageChuKyKH.frame.size.height =  baoHanhMoTaLoiView.ImageChuKyKHImage.frame.size.height + baoHanhMoTaLoiView.ImageChuKyKHImage.frame.origin.y
            baoHanhMoTaLoiView.viewChuKyKH.frame.size.height =  baoHanhMoTaLoiView.ImageChuKyKH.frame.size.height + baoHanhMoTaLoiView.ImageChuKyKH.frame.origin.y
            
            let imageDataPic1:NSData = (baoHanhMoTaLoiView.ImageChuKyKHImage.image!.jpegData(compressionQuality: 1) as NSData?)!
            mString64Custom = imageDataPic1.base64EncodedString(options: .endLineWithLineFeed)
            
            baoHanhMoTaLoiView.viewChuKyNV.frame.origin.y = baoHanhMoTaLoiView.viewChuKyKH.frame.origin.y +  baoHanhMoTaLoiView.viewChuKyKH.frame.size.height + Common.Size(s: 10)
            baoHanhMoTaLoiView.viewChuKyManager.frame.origin.y = baoHanhMoTaLoiView.viewChuKyNV.frame.origin.y +  baoHanhMoTaLoiView.viewChuKyNV.frame.size.height + Common.Size(s: 10)
            baoHanhMoTaLoiView.lbHinhAnhDinhKem.frame.origin.y = baoHanhMoTaLoiView.viewChuKyManager.frame.origin.y +  baoHanhMoTaLoiView.viewChuKyManager.frame.size.height + Common.Size(s: 10)
            baoHanhMoTaLoiView.viewImageNV.frame.origin.y = baoHanhMoTaLoiView.lbHinhAnhDinhKem.frame.origin.y +  baoHanhMoTaLoiView.lbHinhAnhDinhKem.frame.size.height + Common.Size(s: 5)
            baoHanhMoTaLoiView.viewImageNVMore.frame.origin.y = baoHanhMoTaLoiView.viewImageNV.frame.origin.y +  baoHanhMoTaLoiView.viewImageNV.frame.size.height + Common.Size(s: 5)
            baoHanhMoTaLoiView.txtTitleDetails.frame.origin.y = baoHanhMoTaLoiView.viewImageNVMore.frame.origin.y +  baoHanhMoTaLoiView.viewImageNVMore.frame.size.height + Common.Size(s: 5)
            
            baoHanhMoTaLoiView.btnHoanTat.frame.origin.y = baoHanhMoTaLoiView.txtTitleDetails.frame.origin.y +  baoHanhMoTaLoiView.txtTitleDetails.frame.size.height + Common.Size(s: 5)
            baoHanhMoTaLoiView.scrollView.contentSize  = CGSize(width:UIScreen.main.bounds.size.width, height:baoHanhMoTaLoiView.btnHoanTat.frame.origin.y +  baoHanhMoTaLoiView.btnHoanTat.frame.size.height + Common.Size(s: 20))
        }
            
        else if(self.mSigned == 2)
        {
            baoHanhMoTaLoiView.ImageChuKyNV.subviews.forEach { $0.removeFromSuperview() }
            baoHanhMoTaLoiView.ImageChuKyNVImage  = UIImageView(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: width, height: heightImage))
            baoHanhMoTaLoiView.ImageChuKyNVImage.image = cropImage(image: signatureImage, toRect: boundingRect)
            baoHanhMoTaLoiView.ImageChuKyNVImage.contentMode = .scaleAspectFit
            baoHanhMoTaLoiView.ImageChuKyNV.addSubview(baoHanhMoTaLoiView.ImageChuKyNVImage)
            baoHanhMoTaLoiView.ImageChuKyNV.frame.size.height =  baoHanhMoTaLoiView.ImageChuKyNVImage.frame.size.height + baoHanhMoTaLoiView.ImageChuKyNVImage.frame.origin.y
            baoHanhMoTaLoiView.viewChuKyNV.frame.size.height =  baoHanhMoTaLoiView.ImageChuKyNV.frame.size.height + baoHanhMoTaLoiView.ImageChuKyNV.frame.origin.y
            
            
            let imageDataPic1:NSData = (baoHanhMoTaLoiView.ImageChuKyNVImage.image!.jpegData(compressionQuality: 1) as NSData?)!
            mString64Employ = imageDataPic1.base64EncodedString(options: .endLineWithLineFeed)
            
            baoHanhMoTaLoiView.viewChuKyManager.frame.origin.y = baoHanhMoTaLoiView.viewChuKyNV.frame.origin.y +  baoHanhMoTaLoiView.viewChuKyNV.frame.size.height + Common.Size(s: 10)
            baoHanhMoTaLoiView.lbHinhAnhDinhKem.frame.origin.y = baoHanhMoTaLoiView.viewChuKyManager.frame.origin.y +  baoHanhMoTaLoiView.viewChuKyManager.frame.size.height + Common.Size(s: 10)
            baoHanhMoTaLoiView.viewImageNV.frame.origin.y = baoHanhMoTaLoiView.lbHinhAnhDinhKem.frame.origin.y +  baoHanhMoTaLoiView.lbHinhAnhDinhKem.frame.size.height + Common.Size(s: 5)
            baoHanhMoTaLoiView.viewImageNVMore.frame.origin.y = baoHanhMoTaLoiView.viewImageNV.frame.origin.y +  baoHanhMoTaLoiView.viewImageNV.frame.size.height + Common.Size(s: 5)
            baoHanhMoTaLoiView.txtTitleDetails.frame.origin.y = baoHanhMoTaLoiView.viewImageNVMore.frame.origin.y +  baoHanhMoTaLoiView.viewImageNVMore.frame.size.height + Common.Size(s: 5)
            
            baoHanhMoTaLoiView.btnHoanTat.frame.origin.y = baoHanhMoTaLoiView.txtTitleDetails.frame.origin.y +  baoHanhMoTaLoiView.txtTitleDetails.frame.size.height + Common.Size(s: 5)
            baoHanhMoTaLoiView.scrollView.contentSize  = CGSize(width:UIScreen.main.bounds.size.width, height:baoHanhMoTaLoiView.btnHoanTat.frame.origin.y +  baoHanhMoTaLoiView.btnHoanTat.frame.size.height + Common.Size(s: 20))
        }
        else if(self.mSigned == 3)
        {
            
            baoHanhMoTaLoiView.ImageChuKyManager.subviews.forEach { $0.removeFromSuperview() }
            baoHanhMoTaLoiView.ImageChuKyManagerImage  = UIImageView(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: width, height: heightImage))
            baoHanhMoTaLoiView.ImageChuKyManagerImage.image = cropImage(image: signatureImage, toRect: boundingRect)
            baoHanhMoTaLoiView.ImageChuKyManagerImage.contentMode = .scaleAspectFit
            baoHanhMoTaLoiView.ImageChuKyManager.addSubview(baoHanhMoTaLoiView.ImageChuKyManagerImage)
            baoHanhMoTaLoiView.ImageChuKyManager.frame.size.height =  baoHanhMoTaLoiView.ImageChuKyManagerImage.frame.size.height + baoHanhMoTaLoiView.ImageChuKyManagerImage.frame.origin.y
            baoHanhMoTaLoiView.viewChuKyManager.frame.size.height =  baoHanhMoTaLoiView.ImageChuKyManager.frame.size.height + baoHanhMoTaLoiView.ImageChuKyManager.frame.origin.y
            
            let imageDataPic1:NSData = (baoHanhMoTaLoiView.ImageChuKyManagerImage.image!.jpegData(compressionQuality: 1) as NSData?)!
            mString64Manager = imageDataPic1.base64EncodedString(options: .endLineWithLineFeed)
            
            baoHanhMoTaLoiView.lbHinhAnhDinhKem.frame.origin.y = baoHanhMoTaLoiView.viewChuKyManager.frame.origin.y +  baoHanhMoTaLoiView.viewChuKyManager.frame.size.height + Common.Size(s: 10)
            baoHanhMoTaLoiView.viewImageNV.frame.origin.y = baoHanhMoTaLoiView.lbHinhAnhDinhKem.frame.origin.y +  baoHanhMoTaLoiView.lbHinhAnhDinhKem.frame.size.height + Common.Size(s: 5)
            baoHanhMoTaLoiView.viewImageNVMore.frame.origin.y = baoHanhMoTaLoiView.viewImageNV.frame.origin.y +  baoHanhMoTaLoiView.viewImageNV.frame.size.height + Common.Size(s: 5)
            baoHanhMoTaLoiView.txtTitleDetails.frame.origin.y = baoHanhMoTaLoiView.viewImageNVMore.frame.origin.y +  baoHanhMoTaLoiView.viewImageNVMore.frame.size.height + Common.Size(s: 5)
            
            baoHanhMoTaLoiView.btnHoanTat.frame.origin.y = baoHanhMoTaLoiView.txtTitleDetails.frame.origin.y +  baoHanhMoTaLoiView.txtTitleDetails.frame.size.height + Common.Size(s: 5)
            baoHanhMoTaLoiView.scrollView.contentSize  = CGSize(width:UIScreen.main.bounds.size.width, height:baoHanhMoTaLoiView.btnHoanTat.frame.origin.y +  baoHanhMoTaLoiView.btnHoanTat.frame.size.height + Common.Size(s: 20))
        }
        
       
        _ = self.navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
    }
    
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
    
    
    
    
    
    
    //    func TestObjectToArrayJson()
    //    {
    //        var mArrayTest2  = [BaoHanhUploadImageNewObject]()
    //        let mObject1 = BaoHanhUploadImageNewObject(p_FileName:"name_1", p_Base64: "base1", p_IsSign:"0")
    //        let mObject2 = BaoHanhUploadImageNewObject(p_FileName:"name_2", p_Base64: "base2", p_IsSign:"0")
    //        mArrayTest2.append(mObject1)
    //        mArrayTest2.append(mObject2)
    //        let mObjectParam = BaoHanhUploadImageNewParamObject(p_UserCode:"\(Cache.User!.UserName)", p_UserName: "\(Cache.User!.EmployeeName)",mObject: mArrayTest2)
    //        //APIService.BaoHanhUploadImageNew(mListObject:mObjectParam)
    //    }
    
}

//class table tab pk

//////////UI tableviewCell da nhap

class ItemListTabPKTableViewCell: UITableViewCell , UITextFieldDelegate{
    var delegate: ItemListTabPKTableViewCellDelegate?
    var imageCheck: UIImageView!
    var cellKHGiao: UILabel!
    var cellTenPhuKien: UILabel!
    var cellSoLuong: UITextField!
    var cellTTKHGiao: UITextField!
    
    var cellSeriNo:UITextField!
    
    var viewContent:UIView!
    
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.backgroundColor = UIColor(netHex:0xd5eef1)
        
        
        cellKHGiao = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width / 7 , height: Common.Size(s:30)))
        cellKHGiao.textAlignment = .center
        cellKHGiao.textColor = UIColor.black
        cellKHGiao.backgroundColor = UIColor(netHex:0xffffff)
        cellKHGiao.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellKHGiao.text = "KH Giao"
        cellKHGiao.numberOfLines = 1;
        cellKHGiao.layer.borderWidth = 0.5
        cellKHGiao.layer.borderColor = UIColor(netHex:0x000000).cgColor
        
        ///////lbtextNCC
        
        
        imageCheck = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageCheck.image = #imageLiteral(resourceName: "checkmark50")
        imageCheck.contentMode = UIView.ContentMode.scaleAspectFit
        
        
        let viewCheck = UIView()
        viewCheck.addSubview(imageCheck)
        viewCheck.backgroundColor = UIColor(netHex:0xffffff)
        viewCheck.layer.borderWidth = 0.5
        viewCheck.layer.borderColor = UIColor(netHex:0x000000).cgColor
        viewCheck.frame = CGRect(x: 0, y: 0, width: cellKHGiao.frame.size.width, height: cellKHGiao.frame.size.height)
        
        
        cellTenPhuKien = UILabel(frame: CGRect(x: cellKHGiao.frame.width, y: 0, width: (UIScreen.main.bounds.size.width / 6) + (UIScreen.main.bounds.size.width / 6) , height: Common.Size(s:30)))
        cellTenPhuKien.textAlignment = .center
        cellTenPhuKien.textColor = UIColor.black
        cellTenPhuKien.backgroundColor = UIColor(netHex:0xffffff)
        cellTenPhuKien.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellTenPhuKien.text = "Tên Pk"
        cellTenPhuKien.numberOfLines = 1;
        cellTenPhuKien.layer.borderWidth = 0.5
        cellTenPhuKien.layer.borderColor = UIColor(netHex:0x000000).cgColor
        //////////next row///////
        
        
        
        cellSoLuong = UITextField(frame: CGRect(x: cellTenPhuKien.frame.size.width + cellTenPhuKien.frame.origin.x, y: 0, width: UIScreen.main.bounds.size.width / 7 , height: Common.Size(s:30)))
        cellSoLuong.textAlignment = .center
        cellSoLuong.textColor = UIColor.black
        cellSoLuong.backgroundColor = UIColor(netHex:0xffffff)
        cellSoLuong.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellSoLuong.text = "SL"
        
        cellSoLuong.keyboardType = .numberPad
        cellSoLuong.layer.borderWidth = 0.5
        cellSoLuong.layer.borderColor = UIColor(netHex:0x000000).cgColor
        cellSoLuong.delegate = self
        
        
        cellTTKHGiao = UITextField(frame: CGRect(x: cellSoLuong.frame.size.width + cellSoLuong.frame.origin.x, y: 0, width:  UIScreen.main.bounds.size.width / 6 , height: Common.Size(s:30)))
        cellTTKHGiao.textAlignment = .center
        cellTTKHGiao.textColor = UIColor.black
        cellTTKHGiao.backgroundColor = UIColor(netHex:0xffffff)
        cellTTKHGiao.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellTTKHGiao.text = "TT KH Giao"
        //cellTTKHGiao.numberOfLines = 1;
        cellTTKHGiao.layer.borderWidth = 0.5
        cellTTKHGiao.layer.borderColor = UIColor(netHex:0x000000).cgColor
        cellTTKHGiao.delegate = self
        
        
        
        
        cellSeriNo = UITextField(frame: CGRect(x: cellTTKHGiao.frame.size.width + cellTTKHGiao.frame.origin.x  , y: 0, width: UIScreen.main.bounds.size.width - (cellTTKHGiao.frame.size.width + cellSoLuong.frame.size.width + cellTenPhuKien.frame.size.width + cellKHGiao.frame.size.width) , height: Common.Size(s:30)))
        cellSeriNo.textAlignment = .center
        cellSeriNo.textColor = UIColor.black
        cellSeriNo.backgroundColor = UIColor(netHex:0xffffff)
        cellSeriNo.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellSeriNo.text = "Serial No"
        //cellSeriNo.numberOfLines = 1;
        cellSeriNo.layer.borderWidth = 0.5
        
        cellSeriNo.layer.borderColor = UIColor(netHex:0x000000).cgColor
        
        
        cellSeriNo.delegate = self
        
        
        
        
        contentView.addSubview(viewCheck)
        contentView.addSubview(cellTenPhuKien)
        contentView.addSubview(cellSoLuong)
        contentView.addSubview(cellTTKHGiao)
        contentView.addSubview(cellSeriNo)
        
        
        
        ////
        let tapGestureRecognizerCheck = UITapGestureRecognizer(target: self, action: #selector(imagePKCheckTapped(tapGestureRecognizer:)))
        imageCheck.isUserInteractionEnabled = true
        imageCheck.addGestureRecognizer(tapGestureRecognizerCheck)
        
        
        
        
    }
    
    
    @objc func imagePKCheckTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        delegate?.checkClickFromTableView(sender: self, iIndex: imageCheck.tag)
    }
    /////change sl xog goi delegate cua table view
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.text != "")
        {
            if(textField == cellSeriNo)
            {
                delegate?.editDone(sender: self, iIndex: textField.tag, iValue: textField.text!)
            }
            if(textField == cellSoLuong)
            {
                delegate?.editDoneSL(sender: self, iIndex: textField.tag, iValue: textField.text!)
            }
            if(textField == cellTTKHGiao)
            {
                delegate?.editDoneTTKH(sender: self, iIndex: textField.tag, iValue: textField.text!)
            }
        }
        
        
    }
    
    
    
}



protocol ItemListTabPKTableViewCellDelegate {
    
    func checkClickFromTableView(sender: ItemListTabPKTableViewCellDelegate , iIndex:Int)
    
    func editDone(sender: ItemListTabPKTableViewCellDelegate , iIndex:Int , iValue:String)
    func editDoneSL(sender: ItemListTabPKTableViewCellDelegate , iIndex:Int , iValue:String)
    func editDoneTTKH(sender: ItemListTabPKTableViewCellDelegate , iIndex:Int , iValue:String)
}

extension ItemListTabPKTableViewCell: ItemListTabPKTableViewCellDelegate
{
    func editDone(sender: ItemListTabPKTableViewCellDelegate , iIndex:Int , iValue:String)
    {
        
    }
    func editDoneSL(sender: ItemListTabPKTableViewCellDelegate , iIndex:Int , iValue:String)
    {
        
    }
    func editDoneTTKH(sender: ItemListTabPKTableViewCellDelegate , iIndex:Int , iValue:String)
    {
        
    }
    
    func checkClickFromTableView(sender: ItemListTabPKTableViewCellDelegate, iIndex idex:Int)
    {
        
    }
    
    
    
    
    
}




//class table mo ta loi

//////////UI tableviewCell da nhap

class ItemListTabMoTaLoiTableViewCell: UITableViewCell {
    var delegate: ItemListTabMoTaLoiTableViewCellDelegate?
    var imageCheck: UIImageView!
    var cellKHGiao: UILabel!
    var cellTenPhuKien: UILabel!
    
    var cellSeriNo:UILabel!
    
    var viewContent:UIView!
    
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.backgroundColor = UIColor(netHex:0xd5eef1)
        
        
        cellKHGiao = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width / 7 , height: Common.Size(s:30)))
        cellKHGiao.textAlignment = .center
        cellKHGiao.textColor = UIColor.black
        cellKHGiao.backgroundColor = UIColor(netHex:0xffffff)
        cellKHGiao.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellKHGiao.text = "STT"
        cellKHGiao.numberOfLines = 1;
        
        
        ///////lbtextNCC
        
        
        
        
        cellTenPhuKien = UILabel(frame: CGRect(x: cellKHGiao.frame.width, y: 0, width: UIScreen.main.bounds.size.width / 7, height: Common.Size(s:30)))
        cellTenPhuKien.textAlignment = .center
        cellTenPhuKien.textColor = UIColor.black
        cellTenPhuKien.backgroundColor = UIColor(netHex:0xffffff)
        cellTenPhuKien.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellTenPhuKien.text = ""
        cellTenPhuKien.numberOfLines = 1;
        
        //////////next row///////
        imageCheck = UIImageView(frame: CGRect(x: cellKHGiao.frame.origin.x + 10 , y: cellKHGiao.frame.origin.y + 10, width: 20 , height: 20))
        imageCheck.image = #imageLiteral(resourceName: "checkmark50")
        imageCheck.contentMode = UIView.ContentMode.scaleAspectFit
        
        
        let viewCheck = UIView()
        viewCheck.addSubview(imageCheck)
        viewCheck.backgroundColor = UIColor(netHex:0xffffff)
        
        viewCheck.frame = CGRect(x: cellKHGiao.frame.width, y: 0, width: cellTenPhuKien.frame.size.width, height: cellKHGiao.frame.size.height)
        
        
        
        
        
        
        cellSeriNo = UILabel(frame: CGRect(x: cellTenPhuKien.frame.size.width + cellTenPhuKien.frame.origin.x + Common.Size(s:7) , y: 0, width: UIScreen.main.bounds.size.width - (cellKHGiao.frame.size.width + cellTenPhuKien.frame.size.width ) , height: Common.Size(s:30)))
        cellSeriNo.textAlignment = .left
        cellSeriNo.textColor = UIColor.black
        cellSeriNo.backgroundColor = UIColor(netHex:0xffffff)
        cellSeriNo.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellSeriNo.text = "Serial No"
        cellSeriNo.numberOfLines = 1;
        
        
        
        
        
        
        
        
        contentView.addSubview(viewCheck)
        contentView.addSubview(cellTenPhuKien)
        contentView.addSubview(cellKHGiao)
        
        contentView.addSubview(cellSeriNo)
        contentView.addSubview(viewCheck)
        
        
        
        //
        let tapGestureRecognizerCheck = UITapGestureRecognizer(target: self, action: #selector(imageMoTaCheckTapped(tapGestureRecognizer:)))
        imageCheck.isUserInteractionEnabled = true
        imageCheck.addGestureRecognizer(tapGestureRecognizerCheck)
        
        
        
        
    }
    
    @objc func imageMoTaCheckTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("click tag \(imageCheck.tag)")
        delegate?.checkClickFromTableView(sender: self, iIndex: imageCheck.tag)
    }
    
    /////change sl xog goi delegate cua table view
    
    
    
    
    
    
    
    
}

protocol ItemListTabMoTaLoiTableViewCellDelegate {
    
    func checkClickFromTableView(sender: ItemListTabMoTaLoiTableViewCellDelegate , iIndex:Int)
}

extension ItemListTabMoTaLoiTableViewCell: ItemListTabMoTaLoiTableViewCellDelegate
{
    
    
    func checkClickFromTableView(sender: ItemListTabMoTaLoiTableViewCellDelegate, iIndex idex:Int)
    {
        
    }
}



extension BaoHanhTaoPhieuMainController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
        let camera = DSCameraHandler(delegate_: self)
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let takePhoto = UIAlertAction(title: "Chụp ảnh", style: .default) { (alert : UIAlertAction!) in
            camera.getCameraOn(self, canEdit: false)
        }
        let sharePhoto = UIAlertAction(title: "Chọn ảnh có sẵn", style: .default) { (alert : UIAlertAction!) in
            camera.getPhotoLibraryOn(self, canEdit: false)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(sharePhoto)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        // image is our desired image
        if (self.posImageUpload == 1){
            self.baoHanhMoTaLoiView.viewCMNDTruocButton.frame.origin.x = self.baoHanhMoTaLoiView.viewImageNV.frame.width / 4
            self.baoHanhMoTaLoiView.viewCMNDTruocButton.frame.size.width =  self.baoHanhMoTaLoiView.viewImageNV.frame.width / 2
            self.baoHanhMoTaLoiView.viewCMNDTruocButton.frame.size.height = self.baoHanhMoTaLoiView.viewImageNV.frame.height
            self.baoHanhMoTaLoiView.viewCMNDTruocButton.contentMode = UIView.ContentMode.scaleToFill
            let squared = image.squared
            self.baoHanhMoTaLoiView.viewCMNDTruocButton.image = squared
            self.baoHanhMoTaLoiView.lbCMNDTruocButton.text = ""
            self.isImageOne = true
            
            baoHanhMoTaLoiView.viewImageNVMore.frame.origin.y = baoHanhMoTaLoiView.viewImageNV.frame.origin.y +  baoHanhMoTaLoiView.viewImageNV.frame.size.height + Common.Size(s: 5)
            baoHanhMoTaLoiView.txtTitleDetails.frame.origin.y = baoHanhMoTaLoiView.viewImageNVMore.frame.origin.y +  baoHanhMoTaLoiView.viewImageNVMore.frame.size.height + Common.Size(s: 5)
            baoHanhMoTaLoiView.btnHoanTat.frame.origin.y = baoHanhMoTaLoiView.txtTitleDetails.frame.origin.y +  baoHanhMoTaLoiView.txtTitleDetails.frame.size.height + Common.Size(s: 5)
            baoHanhMoTaLoiView.scrollView.contentSize  = CGSize(width:UIScreen.main.bounds.size.width, height:baoHanhMoTaLoiView.btnHoanTat.frame.origin.y +  baoHanhMoTaLoiView.btnHoanTat.frame.size.height + Common.Size(s: 20))
        }else if (self.posImageUpload == 2){
            
            self.baoHanhMoTaLoiView.viewCMNDTruocButton2.frame.origin.x = self.baoHanhMoTaLoiView.viewImageNV.frame.width / 4
            self.baoHanhMoTaLoiView.viewCMNDTruocButton2.frame.size.width =  self.baoHanhMoTaLoiView.viewImageNV.frame.width / 2
            self.baoHanhMoTaLoiView.viewCMNDTruocButton2.frame.size.height = self.baoHanhMoTaLoiView.viewImageNV.frame.height
            self.baoHanhMoTaLoiView.viewCMNDTruocButton2.contentMode = UIView.ContentMode.scaleToFill
            let squared = image.squared
            self.baoHanhMoTaLoiView.viewCMNDTruocButton2.image = squared
            self.baoHanhMoTaLoiView.lbCMNDTruocButton2.text = ""
            self.isImageTwo = true
        }else if (self.posImageUpload == 3){
            
            self.baoHanhMoTaLoiView.viewCMNDTruocButton3.frame.origin.x = self.baoHanhMoTaLoiView.viewImageNV.frame.width / 4
            self.baoHanhMoTaLoiView.viewCMNDTruocButton3.frame.size.width =  self.baoHanhMoTaLoiView.viewImageNV.frame.width / 2
            self.baoHanhMoTaLoiView.viewCMNDTruocButton3.frame.size.height = self.baoHanhMoTaLoiView.viewImageNV.frame.height
            self.baoHanhMoTaLoiView.viewCMNDTruocButton3.contentMode = UIView.ContentMode.scaleToFill
            let squared = image.squared
            self.baoHanhMoTaLoiView.viewCMNDTruocButton3.image = squared
            self.baoHanhMoTaLoiView.lbCMNDTruocButton3.text = ""
            self.isImageThree = true
        }else if (self.posImageUpload == 4){
            
            self.baoHanhMoTaLoiView.viewCMNDTruocButton4.frame.origin.x = self.baoHanhMoTaLoiView.viewImageNV.frame.width / 4
            self.baoHanhMoTaLoiView.viewCMNDTruocButton4.frame.size.width =  self.baoHanhMoTaLoiView.viewImageNV.frame.width / 2
            self.baoHanhMoTaLoiView.viewCMNDTruocButton4.frame.size.height = self.baoHanhMoTaLoiView.viewImageNV.frame.height
            self.baoHanhMoTaLoiView.viewCMNDTruocButton4.contentMode = UIView.ContentMode.scaleToFill
            let squared = image.squared
            self.baoHanhMoTaLoiView.viewCMNDTruocButton4.image = squared
            self.baoHanhMoTaLoiView.lbCMNDTruocButton4.text = ""
            self.isImageFour = true
            
        }
        else if (self.posImageUpload == 5){
            
            self.baoHanhMoTaLoiView.viewCMNDTruocButton5.frame.origin.x = self.baoHanhMoTaLoiView.viewImageNV.frame.width / 4
            self.baoHanhMoTaLoiView.viewCMNDTruocButton5.frame.size.width =  self.baoHanhMoTaLoiView.viewImageNV.frame.width / 2
            self.baoHanhMoTaLoiView.viewCMNDTruocButton5.frame.size.height = self.baoHanhMoTaLoiView.viewImageNV.frame.height
            self.baoHanhMoTaLoiView.viewCMNDTruocButton5.contentMode = UIView.ContentMode.scaleToFill
            let squared = image.squared
            self.baoHanhMoTaLoiView.viewCMNDTruocButton5.image = squared
            self.baoHanhMoTaLoiView.lbCMNDTruocButton5.text = ""
            self.isImageFive = true
        }
        else if (self.posImageUpload == 6){
            print("6666")
            self.baoHanhMoTaLoiView.viewCMNDTruocButton6.frame.origin.x = self.baoHanhMoTaLoiView.viewImageNV.frame.width / 4
            self.baoHanhMoTaLoiView.viewCMNDTruocButton6.frame.size.width =  self.baoHanhMoTaLoiView.viewImageNV.frame.width / 2
            self.baoHanhMoTaLoiView.viewCMNDTruocButton6.frame.size.height = self.baoHanhMoTaLoiView.viewImageNV.frame.height
            self.baoHanhMoTaLoiView.viewCMNDTruocButton6.contentMode = UIView.ContentMode.scaleToFill
            let squared = image.squared
            self.baoHanhMoTaLoiView.viewCMNDTruocButton6.image = squared
            self.baoHanhMoTaLoiView.lbCMNDTruocButton6.text = ""
            self.isImageSix = true
        }
        numUPLoadImage = numUPLoadImage + 1
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

extension UIImage {
    var isPortrait:  Bool    { return size.height > size.width }
    var isLandscape: Bool    { return size.width > size.height }
    var breadth:     CGFloat { return min(size.width, size.height) }
    var breadthSize: CGSize  { return CGSize(width: breadth, height: breadth) }
    var breadthRect: CGRect  { return CGRect(origin: .zero, size: breadthSize) }
    var squared: UIImage? {
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait  ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
        UIImage(cgImage: cgImage).draw(in: breadthRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
