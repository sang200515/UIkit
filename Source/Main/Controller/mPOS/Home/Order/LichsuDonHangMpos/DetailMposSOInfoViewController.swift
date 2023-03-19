//
//  DetailMposSOInfoViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 7/22/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DLRadioButton
import Presentr

class DetailMposSOInfoViewController: UIViewController {
    
    var parentNavigationController : UINavigationController?
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var so: SOHeader?
    var radioMan:DLRadioButton!
    var radioWoman:DLRadioButton!
    var rsLine_VC_NoPrice:[Line_VC_NoPrice] = []
    var rsLineProduct:[LineProduct] = []
    var rsLinePromos:[LinePromos] = []
    var rsLineORCT:[LineORCT] = []
    var rsLineVoucher:[LineVoucher] = []
    var viewPopUp: UIView!
    let presenter: Presentr = {
        let dynamicType = PresentationType.dynamic(center: ModalCenterPosition.center)
        let customPresenter = Presentr(presentationType: dynamicType)
        customPresenter.backgroundOpacity = 0.3
        customPresenter.roundCorners = true
        customPresenter.dismissOnSwipe = false
        customPresenter.dismissAnimated = false
        //        customPresenter.backgroundTap = .noAction
        return customPresenter
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isTranslucent = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    func loadData() {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()) {
            MPOSAPIManager.mpos_sp_Order_getSOdetails(Docentry: "\(self.so?.DocEntry ?? 0)") { (rsVCNoPrice, rsLineProduct, rsLinePromos, rsLineORCT, rsLineVoucher, err) in
                if err.count <= 0 {
                    self.rsLine_VC_NoPrice = rsVCNoPrice
                    self.rsLineProduct = rsLineProduct
                    self.rsLinePromos = rsLinePromos
                    self.rsLineORCT = rsLineORCT
                    self.rsLineVoucher = rsLineVoucher
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                        self.setUpView()
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
    
    func setUpView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let viewCustomerInfo = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewCustomerInfo.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        scrollView.addSubview(viewCustomerInfo)
        
        let lbCustomerInfo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewCustomerInfo.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbCustomerInfo.text = "THÔNG TIN KHÁCH HÀNG"
        lbCustomerInfo.font = UIFont.boldSystemFont(ofSize: 15)
        lbCustomerInfo.textColor = UIColor(netHex: 0x109e59)
        viewCustomerInfo.addSubview(lbCustomerInfo)
        
        let lbSdt = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewCustomerInfo.frame.origin.y + viewCustomerInfo.frame.height + Common.Size(s: 8), width: (scrollView.frame.width - Common.Size(s: 30))/3, height: Common.Size(s: 20)))
        lbSdt.text = "Số điện thoại:"
        lbSdt.font = UIFont.systemFont(ofSize: 14)
        lbSdt.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbSdt)
        
        let lbSdtText = UILabel(frame: CGRect(x: lbSdt.frame.origin.x + lbSdt.frame.width + Common.Size(s: 5), y: lbSdt.frame.origin.y, width: (scrollView.frame.width - Common.Size(s: 30)) * 2/3, height: Common.Size(s: 20)))
        lbSdtText.text = "\(self.so?.U_LicTrad ?? "")"
        lbSdtText.font = UIFont.systemFont(ofSize: 14)
        lbSdtText.textAlignment = .right
        scrollView.addSubview(lbSdtText)
        
        let lbCustomerName = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSdtText.frame.origin.y + lbSdtText.frame.height, width: lbSdt.frame.width, height: Common.Size(s: 20)))
        lbCustomerName.text = "Tên khách hàng:"
        lbCustomerName.font = UIFont.systemFont(ofSize: 14)
        lbCustomerName.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbCustomerName)
        
        let lbCustomerNameText = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x + lbCustomerName.frame.width + Common.Size(s: 5), y: lbCustomerName.frame.origin.y, width: lbSdtText.frame.width, height: Common.Size(s: 20)))
        lbCustomerNameText.text = "\(self.so?.CardName ?? "")"
        lbCustomerNameText.font = UIFont.systemFont(ofSize: 14)
        lbCustomerNameText.textAlignment = .right
        scrollView.addSubview(lbCustomerNameText)
        
        let lbCustomerNameTextHeight:CGFloat = lbCustomerNameText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbCustomerNameText.optimalHeight + Common.Size(s: 5))
        lbCustomerNameText.numberOfLines = 0
        lbCustomerNameText.frame = CGRect(x: lbCustomerNameText.frame.origin.x, y: lbCustomerNameText.frame.origin.y, width: lbCustomerNameText.frame.width, height: lbCustomerNameTextHeight)
        
        let lbAddress = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbCustomerNameText.frame.origin.y + lbCustomerNameTextHeight, width: lbSdt.frame.width, height: Common.Size(s: 20)))
        lbAddress.text = "Địa chỉ:"
        lbAddress.font = UIFont.systemFont(ofSize: 14)
        lbAddress.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbAddress)
        
        let lbAddressText = UILabel(frame: CGRect(x: lbAddress.frame.origin.x + lbAddress.frame.width + Common.Size(s: 5), y: lbAddress.frame.origin.y, width: lbSdtText.frame.width, height: Common.Size(s: 20)))
        lbAddressText.text = "\(self.so?.U_Address1 ?? "")"
        lbAddressText.font = UIFont.systemFont(ofSize: 14)
        lbAddressText.textAlignment = .right
        scrollView.addSubview(lbAddressText)
        
        let lbAddressTextHeight:CGFloat = lbAddressText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbAddressText.optimalHeight + Common.Size(s: 5))
        lbAddressText.numberOfLines = 0
        lbAddressText.frame = CGRect(x: lbAddressText.frame.origin.x, y: lbAddressText.frame.origin.y, width: lbAddressText.frame.width, height: lbAddressTextHeight)
        
        let lbEmail = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbAddressText.frame.origin.y + lbAddressTextHeight, width: lbSdt.frame.width, height: Common.Size(s: 20)))
        lbEmail.text = "Email:"
        lbEmail.font = UIFont.systemFont(ofSize: 14)
        lbEmail.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbEmail)
        
        let lbEmailText = UILabel(frame: CGRect(x: lbEmail.frame.origin.x + lbEmail.frame.width + Common.Size(s: 5), y: lbEmail.frame.origin.y, width: lbSdtText.frame.width, height: Common.Size(s: 20)))
        lbEmailText.text = "\(self.so?.U_Email ?? "")"
        lbEmailText.font = UIFont.systemFont(ofSize: 14)
        lbEmailText.textAlignment = .right
        scrollView.addSubview(lbEmailText)
        
        let lbEmailTextHeight:CGFloat = lbEmailText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbEmailText.optimalHeight + Common.Size(s: 5))
        lbEmailText.numberOfLines = 0
        lbEmailText.frame = CGRect(x: lbEmailText.frame.origin.x, y: lbEmailText.frame.origin.y, width: lbEmailText.frame.width, height: lbEmailTextHeight)
        
        let lbGender = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbEmailText.frame.origin.y + lbEmailTextHeight, width: lbSdt.frame.width, height: Common.Size(s: 20)))
        lbGender.text = "Giới tính:"
        lbGender.font = UIFont.boldSystemFont(ofSize: 14)
        lbGender.textColor = UIColor(netHex: 0x109e59)
        scrollView.addSubview(lbGender)
        
        radioMan = createRadioButton(CGRect(x: Common.Size(s: 15), y:lbGender.frame.origin.y + lbGender.frame.size.height + Common.Size(s:5) , width: (scrollView.frame.width - Common.Size(s:30))/3, height: Common.Size(s:15)), title: "Nam", color: UIColor(netHex: 0x109e59));
        scrollView.addSubview(radioMan)
        
        radioWoman = createRadioButton(CGRect(x: radioMan.frame.origin.x + radioMan.frame.size.width ,y:radioMan.frame.origin.y, width: radioMan.frame.size.width, height: radioMan.frame.size.height), title: "Nữ", color: UIColor(netHex: 0x109e59));
        scrollView.addSubview(radioWoman)
        
        switch (so?.gender)!{
        case 0:
            radioWoman.isSelected = true
            radioMan.isEnabled = false
        case 1:
            radioMan.isSelected = true
            radioWoman.isEnabled = false
        default:
            radioWoman.isSelected = true
            radioMan.isEnabled = false
        }
        
        let viewLoaiDHTitle = UIView(frame: CGRect(x: 0, y: radioWoman.frame.origin.y + radioWoman.frame.height + Common.Size(s: 10), width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewLoaiDHTitle.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        scrollView.addSubview(viewLoaiDHTitle)
        
        let lbLoaiDHTitle = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewLoaiDHTitle.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbLoaiDHTitle.text = "LOẠI ĐƠN HÀNG"
        lbLoaiDHTitle.font = UIFont.boldSystemFont(ofSize: 15)
        lbLoaiDHTitle.textColor = UIColor(netHex: 0x109e59)
        viewLoaiDHTitle.addSubview(lbLoaiDHTitle)
        
        let radioAtTheCounter = createRadioButton(CGRect(x: Common.Size(s: 15), y: viewLoaiDHTitle.frame.origin.y + viewLoaiDHTitle.frame.height + Common.Size(s: 8), width: (scrollView.frame.width - Common.Size(s: 30))/3, height: Common.Size(s:15)), title: "Tại quầy", color: UIColor(netHex: 0x109e59));
        scrollView.addSubview(radioAtTheCounter)
        
        let radioInstallment = createRadioButton(CGRect(x: radioAtTheCounter.frame.origin.x + radioAtTheCounter.frame.size.width, y: radioAtTheCounter.frame.origin.y , width: radioAtTheCounter.frame.size.width, height: radioAtTheCounter.frame.size.height), title: "Trả góp", color: UIColor(netHex: 0x109e59));
        scrollView.addSubview(radioInstallment)
        
        let radioDeposit = createRadioButton(CGRect(x: radioInstallment.frame.origin.x + radioInstallment.frame.size.width, y: radioAtTheCounter.frame.origin.y , width: radioInstallment.frame.size.width, height: radioInstallment.frame.size.height), title: "Đặt cọc", color: UIColor(netHex: 0x109e59));
        scrollView.addSubview(radioDeposit)
        
        switch (so?.DocType)!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) {
        case "01"://tai quầy
            radioAtTheCounter.isSelected = true
            radioInstallment.isEnabled = false
            radioDeposit.isEnabled = false
        case "02"://trả góp
            radioInstallment.isSelected = true
            radioAtTheCounter.isEnabled = false
            radioDeposit.isEnabled = false
        case "05"://đặt cọc
            radioDeposit.isSelected = true
            radioAtTheCounter.isEnabled = false
            radioInstallment.isEnabled = false
        default:
            radioAtTheCounter.isSelected = true
            radioInstallment.isEnabled = false
            radioDeposit.isEnabled = false
        }
        
        //LOAI CHUONG TRINH
        let viewLoaiChuongTrinh = UIView(frame: CGRect(x: 0, y: radioAtTheCounter.frame.origin.y + radioAtTheCounter.frame.height + Common.Size(s: 10), width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewLoaiChuongTrinh.backgroundColor = UIColor.white
        scrollView.addSubview(viewLoaiChuongTrinh)
        
        let viewLoaiChuongTrinhTitle = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewLoaiChuongTrinhTitle.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        viewLoaiChuongTrinh.addSubview(viewLoaiChuongTrinhTitle)
        
        let lbLoaiChuongTrinhTitle = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewLoaiChuongTrinhTitle.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbLoaiChuongTrinhTitle.text = "LOẠI CHƯƠNG TRÌNH"
        lbLoaiChuongTrinhTitle.font = UIFont.boldSystemFont(ofSize: 15)
        lbLoaiChuongTrinhTitle.textColor = UIColor(netHex: 0x109e59)
        viewLoaiChuongTrinhTitle.addSubview(lbLoaiChuongTrinhTitle)
        
        let radioNhaTraGop = createRadioButton(CGRect(x: Common.Size(s: 15), y: viewLoaiChuongTrinhTitle.frame.origin.y + viewLoaiChuongTrinhTitle.frame.height + Common.Size(s: 8), width: (viewLoaiChuongTrinh.frame.width - Common.Size(s: 30))/3, height: Common.Size(s:15)), title: "Nhà trả góp", color: UIColor(netHex: 0x109e59));
        viewLoaiChuongTrinh.addSubview(radioNhaTraGop)
        
        let radioThe = createRadioButton(CGRect(x: radioNhaTraGop.frame.origin.x + radioNhaTraGop.frame.size.width, y: radioNhaTraGop.frame.origin.y , width: radioNhaTraGop.frame.size.width, height: radioNhaTraGop.frame.size.height), title: "Thẻ", color: UIColor(netHex: 0x109e59));
        viewLoaiChuongTrinh.addSubview(radioThe)
        
        if self.so?.TenCtyTraGop.trim() == "" {
            radioThe.isSelected = true
            radioNhaTraGop.isSelected = false
        } else {
            radioNhaTraGop.isSelected = true
            radioThe.isSelected = false
        }
        
        let lbNhaTraGop = UILabel(frame: CGRect(x: Common.Size(s: 15), y: radioThe.frame.origin.y + radioThe.frame.height + Common.Size(s: 5), width: (viewLoaiChuongTrinh.frame.width - Common.Size(s: 30))/3 + Common.Size(s: 10), height: Common.Size(s: 20)))
        lbNhaTraGop.text = "Nhà trả góp:"
        lbNhaTraGop.font = UIFont.systemFont(ofSize: 14)
        lbNhaTraGop.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        viewLoaiChuongTrinh.addSubview(lbNhaTraGop)

        let lbNhaTraGopText = UILabel(frame: CGRect(x: lbNhaTraGop.frame.origin.x + lbNhaTraGop.frame.width + Common.Size(s: 5), y: lbNhaTraGop.frame.origin.y, width: (viewLoaiChuongTrinh.frame.width - Common.Size(s: 30)) * 2/3 - Common.Size(s: 10), height: Common.Size(s: 20)))
        lbNhaTraGopText.text = "\(self.so?.TenCtyTraGop ?? "")"
        lbNhaTraGopText.font = UIFont.systemFont(ofSize: 14)
        viewLoaiChuongTrinh.addSubview(lbNhaTraGopText)
        
        let lbNhaTraGopTextHeight:CGFloat = lbNhaTraGopText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNhaTraGopText.optimalHeight + Common.Size(s: 5))
        lbNhaTraGopText.numberOfLines = 0
        lbNhaTraGopText.frame = CGRect(x: lbNhaTraGopText.frame.origin.x, y: lbNhaTraGopText.frame.origin.y, width: lbNhaTraGopText.frame.width, height: lbNhaTraGopTextHeight)
        
        let lbKyHan = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNhaTraGopText.frame.origin.y + lbNhaTraGopTextHeight, width: lbNhaTraGop.frame.width, height: Common.Size(s: 20)))
        lbKyHan.text = "Kỳ hạn:"
        lbKyHan.font = UIFont.systemFont(ofSize: 14)
        lbKyHan.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        viewLoaiChuongTrinh.addSubview(lbKyHan)
        
        let lbKyHanText = UILabel(frame: CGRect(x: lbKyHan.frame.origin.x + lbKyHan.frame.width + Common.Size(s: 5), y: lbKyHan.frame.origin.y, width: lbNhaTraGopText.frame.width, height: Common.Size(s: 20)))
        lbKyHanText.text = "\(self.so?.period ?? 0) tháng"
        lbKyHanText.font = UIFont.systemFont(ofSize: 13)
        lbKyHanText.textColor = UIColor(netHex: 0xcc0c2f)
        viewLoaiChuongTrinh.addSubview(lbKyHanText)
        
        let lbLaiSuat = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbKyHanText.frame.origin.y + lbKyHanText.frame.height, width: lbNhaTraGop.frame.width, height: Common.Size(s: 20)))
        lbLaiSuat.text = "Lãi suất:"
        lbLaiSuat.font = UIFont.systemFont(ofSize: 14)
        lbLaiSuat.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        viewLoaiChuongTrinh.addSubview(lbLaiSuat)
        
        let lbLaiSuatText = UILabel(frame: CGRect(x: lbLaiSuat.frame.origin.x + lbLaiSuat.frame.width + Common.Size(s: 5), y: lbLaiSuat.frame.origin.y, width: lbNhaTraGopText.frame.width, height: Common.Size(s: 20)))
        lbLaiSuatText.text = "\(self.so?.LaiSuat ?? 0) %"
        lbLaiSuatText.font = UIFont.systemFont(ofSize: 14)
        lbLaiSuatText.textColor = UIColor(netHex: 0x109e59)
        viewLoaiChuongTrinh.addSubview(lbLaiSuatText)
        
        let lbCMND = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbLaiSuatText.frame.origin.y + lbLaiSuatText.frame.height, width: lbNhaTraGop.frame.width, height: Common.Size(s: 20)))
        lbCMND.text = "CMND/Căn cước:"
        lbCMND.font = UIFont.systemFont(ofSize: 14)
        lbCMND.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        viewLoaiChuongTrinh.addSubview(lbCMND)
        
        let lbCMNDText = UILabel(frame: CGRect(x: lbCMND.frame.origin.x + lbCMND.frame.width + Common.Size(s: 5), y: lbCMND.frame.origin.y, width: lbNhaTraGopText.frame.width, height: Common.Size(s: 20)))
        lbCMNDText.text = "\(self.so?.IdentityCard ?? "")"
        lbCMNDText.font = UIFont.systemFont(ofSize: 14)
        lbCMNDText.textColor = UIColor(netHex: 0x109e59)
        viewLoaiChuongTrinh.addSubview(lbCMNDText)
        
        let lbSoHopDong = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbCMNDText.frame.origin.y + lbCMNDText.frame.height, width: lbNhaTraGop.frame.width, height: Common.Size(s: 20)))
        lbSoHopDong.text = "Số hợp đồng:"
        lbSoHopDong.font = UIFont.systemFont(ofSize: 14)
        lbSoHopDong.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        viewLoaiChuongTrinh.addSubview(lbSoHopDong)
        
        let lbSoHopDongText = UILabel(frame: CGRect(x: lbSoHopDong.frame.origin.x + lbSoHopDong.frame.width + Common.Size(s: 5), y: lbSoHopDong.frame.origin.y, width: lbNhaTraGopText.frame.width, height: Common.Size(s: 20)))
        lbSoHopDongText.text = "\(self.so?.So_HD ?? "")"
        lbSoHopDongText.font = UIFont.systemFont(ofSize: 14)
        lbSoHopDongText.textColor = UIColor(netHex: 0x109e59)
        viewLoaiChuongTrinh.addSubview(lbSoHopDongText)
        
        let lbSoTienTraTruoc = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSoHopDongText.frame.origin.y + lbSoHopDongText.frame.height, width: lbNhaTraGop.frame.width, height: Common.Size(s: 20)))
        lbSoTienTraTruoc.text = "Số tiền trả trước:"
        lbSoTienTraTruoc.font = UIFont.systemFont(ofSize: 14)
        lbSoTienTraTruoc.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        viewLoaiChuongTrinh.addSubview(lbSoTienTraTruoc)
        
        let lbSoTienTraTruocText = UILabel(frame: CGRect(x: lbSoTienTraTruoc.frame.origin.x + lbSoTienTraTruoc.frame.width + Common.Size(s: 5), y: lbSoTienTraTruoc.frame.origin.y, width: lbNhaTraGopText.frame.width, height: Common.Size(s: 20)))
        lbSoTienTraTruocText.text = "\(Common.convertCurrencyFloat(value: self.so?.SoTienTraTruoc ?? 0))"
        lbSoTienTraTruocText.font = UIFont.systemFont(ofSize: 14)
        lbSoTienTraTruocText.textColor = UIColor(netHex: 0x109e59)
        viewLoaiChuongTrinh.addSubview(lbSoTienTraTruocText)
        
        viewLoaiChuongTrinh.frame = CGRect(x: viewLoaiChuongTrinh.frame.origin.x, y: viewLoaiChuongTrinh.frame.origin.y, width: viewLoaiChuongTrinh.frame.width, height: lbSoTienTraTruocText.frame.origin.y + lbSoTienTraTruocText.frame.height + Common.Size(s: 5))
        
        if self.so?.DocType.trim() == "02" {//tra gop
            viewLoaiChuongTrinh.isHidden = false
            viewLoaiChuongTrinh.frame = CGRect(x: viewLoaiChuongTrinh.frame.origin.x, y: viewLoaiChuongTrinh.frame.origin.y, width: viewLoaiChuongTrinh.frame.width, height: lbSoTienTraTruocText.frame.origin.y + lbSoTienTraTruocText.frame.height + Common.Size(s: 5))

        } else {
            viewLoaiChuongTrinh.isHidden = true
            viewLoaiChuongTrinh.frame = CGRect(x: viewLoaiChuongTrinh.frame.origin.x, y: viewLoaiChuongTrinh.frame.origin.y, width: viewLoaiChuongTrinh.frame.width, height: 0)
        }
        
        //VOUCHER KHONG GIA
        let viewVCKhongGia = UIView(frame: CGRect(x: 0, y: viewLoaiChuongTrinh.frame.origin.y + viewLoaiChuongTrinh.frame.height, width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewVCKhongGia.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        scrollView.addSubview(viewVCKhongGia)
        
        let lbVCKhongGia = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewVCKhongGia.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbVCKhongGia.text = "VOUCHER KHÔNG GIÁ"
        lbVCKhongGia.font = UIFont.boldSystemFont(ofSize: 15)
        lbVCKhongGia.textColor = UIColor(netHex: 0x109e59)
        viewVCKhongGia.addSubview(lbVCKhongGia)
        
        let viewVCKhongGiaContent = UIView(frame: CGRect(x: 0, y: viewVCKhongGia.frame.origin.y + viewVCKhongGia.frame.height , width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewVCKhongGiaContent.backgroundColor = UIColor.white
        scrollView.addSubview(viewVCKhongGiaContent)
        
        var viewVCKhongGiaContentHeight:CGFloat = 0
        for i in 0..<self.rsLine_VC_NoPrice.count {
            let item = self.rsLine_VC_NoPrice[i]
            
            let viewVC = UIView(frame: CGRect(x: 0, y: viewVCKhongGiaContentHeight, width: viewVCKhongGiaContent.frame.width, height: Common.Size(s: 70)))
            viewVC.backgroundColor = .white
            viewVCKhongGiaContent.addSubview(viewVC)
            
            let lbSTT = UILabel(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: Common.Size(s: 30), height: Common.Size(s: 15)))
            lbSTT.text = "\(i + 1)"
            lbSTT.textAlignment = .center
            lbSTT.font = UIFont.systemFont(ofSize: 14)
            viewVC.addSubview(lbSTT)
            
            let lbVCNumber = UILabel(frame: CGRect(x: lbSTT.frame.origin.x + lbSTT.frame.width + Common.Size(s: 11), y: Common.Size(s: 5), width: viewVC.frame.width - Common.Size(s: 61), height: Common.Size(s: 15)))
            lbVCNumber.text = "\(item.VC_num)"
            lbVCNumber.font = UIFont.boldSystemFont(ofSize: 14)
            viewVC.addSubview(lbVCNumber)
            
            let lbVCName = UILabel(frame: CGRect(x: lbVCNumber.frame.origin.x, y: lbVCNumber.frame.origin.y + lbVCNumber.frame.height + Common.Size(s: 5), width: lbVCNumber.frame.width, height: Common.Size(s: 15)))
            lbVCName.text = "\(item.VC_Name)"
            lbVCName.font = UIFont.systemFont(ofSize: 14)
            viewVC.addSubview(lbVCName)
            
            let lbVCNameHeight:CGFloat = lbVCName.optimalHeight < Common.Size(s: 15) ? Common.Size(s: 15) : lbVCName.optimalHeight
            lbVCName.numberOfLines = 0
            lbVCName.frame = CGRect(x: lbVCName.frame.origin.x, y: lbVCName.frame.origin.y, width: lbVCName.frame.width, height: lbVCNameHeight)
            
            let lbVCDate = UILabel(frame: CGRect(x: lbVCNumber.frame.origin.x, y: lbVCName.frame.origin.y + lbVCNameHeight + Common.Size(s: 5), width: lbVCNumber.frame.width, height: Common.Size(s: 15)))
            lbVCDate.text = "\(item.Expired)"
            lbVCDate.font = UIFont.systemFont(ofSize: 14)
            lbVCDate.textColor = UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
            viewVC.addSubview(lbVCDate)
            
            viewVC.frame = CGRect(x: viewVC.frame.origin.x, y: viewVC.frame.origin.y, width: viewVC.frame.width, height: lbVCDate.frame.origin.y + lbVCDate.frame.height + Common.Size(s: 5))
            
            let line = UIView(frame: CGRect(x: lbSTT.frame.origin.x + lbSTT.frame.width, y: Common.Size(s: 10), width: Common.Size(s: 1), height: viewVC.frame.height - Common.Size(s: 10)))
            line.backgroundColor = UIColor(red: 67/255, green: 135/255, blue: 107/255, alpha: 1)
            viewVC.addSubview(line)

            let line2 = UIView(frame: CGRect(x: 0, y: viewVC.frame.height - Common.Size(s: 1), width: viewVC.frame.width, height: Common.Size(s: 1)))
            line2.backgroundColor = UIColor(red: 67/255, green: 135/255, blue: 107/255, alpha: 1)
            viewVC.addSubview(line2)

            viewVCKhongGiaContentHeight = viewVCKhongGiaContentHeight + viewVC.frame.height
        }
        viewVCKhongGiaContent.frame = CGRect(x: viewVCKhongGiaContent.frame.origin.x, y: viewVCKhongGiaContent.frame.origin.y, width: viewVCKhongGiaContent.frame.width, height: viewVCKhongGiaContentHeight)
        
        if self.rsLine_VC_NoPrice.count > 0 {
            viewVCKhongGia.isHidden = false
            viewVCKhongGiaContent.isHidden = false
            
            viewVCKhongGia.frame = CGRect(x: viewVCKhongGia.frame.origin.x, y: viewVCKhongGia.frame.origin.y, width: viewVCKhongGia.frame.width, height: Common.Size(s: 40))
            viewVCKhongGiaContent.frame = CGRect(x: viewVCKhongGiaContent.frame.origin.x, y: viewVCKhongGia.frame.origin.y + viewVCKhongGia.frame.height, width: viewVCKhongGiaContent.frame.width, height: CGFloat(self.rsLine_VC_NoPrice.count) * Common.Size(s: 70))

        } else {
            viewVCKhongGia.isHidden = true
            viewVCKhongGiaContent.isHidden = true
            
            viewVCKhongGia.frame = CGRect(x: viewVCKhongGia.frame.origin.x, y: viewVCKhongGia.frame.origin.y, width: viewVCKhongGia.frame.width, height: 0)
            viewVCKhongGiaContent.frame = CGRect(x: viewVCKhongGiaContent.frame.origin.x, y: viewVCKhongGia.frame.origin.y + viewVCKhongGia.frame.height, width: viewVCKhongGiaContent.frame.width, height: 0)
        }
                
        //CHI TIET DON HANG
        let viewChiTietDH = UIView(frame: CGRect(x: 0, y: viewVCKhongGiaContent.frame.origin.y + viewVCKhongGiaContent.frame.height + Common.Size(s: 5), width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewChiTietDH.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        scrollView.addSubview(viewChiTietDH)
        
        let lbChiTietDH = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewChiTietDH.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbChiTietDH.text = "CHI TIẾT ĐƠN HÀNG"
        lbChiTietDH.font = UIFont.boldSystemFont(ofSize: 15)
        lbChiTietDH.textColor = UIColor(netHex: 0x109e59)
        viewChiTietDH.addSubview(lbChiTietDH)
        
        let viewChiTietDHContent = UIView(frame: CGRect(x: 0, y: viewChiTietDH.frame.origin.y + viewChiTietDH.frame.height , width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewChiTietDHContent.backgroundColor = UIColor.white
        scrollView.addSubview(viewChiTietDHContent)
        
        var viewChiTietDHContentHeight:CGFloat = 0
        for i in 0..<self.rsLineProduct.count {
            let item = self.rsLineProduct[i]
            
            let viewDH = UIView(frame: CGRect(x: 0, y: viewChiTietDHContentHeight, width: viewChiTietDHContent.frame.width, height: Common.Size(s: 70)))
            viewDH.backgroundColor = .white
            viewChiTietDHContent.addSubview(viewDH)
            
            let lbSTT = UILabel(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: Common.Size(s: 30), height: Common.Size(s: 20)))
            lbSTT.text = "\(i + 1)"
            lbSTT.textAlignment = .center
            lbSTT.font = UIFont.systemFont(ofSize: 14)
            viewDH.addSubview(lbSTT)
            
            let lbDHName = UILabel(frame: CGRect(x: lbSTT.frame.origin.x + lbSTT.frame.width + Common.Size(s: 11), y: Common.Size(s: 5), width: viewDH.frame.width - Common.Size(s: 61) - Common.Size(s: 50), height: Common.Size(s: 15)))
            lbDHName.text = "\(item.Dscription)"
            lbDHName.font = UIFont.systemFont(ofSize: 14)
            viewDH.addSubview(lbDHName)
            
            let lbDHNameHeight:CGFloat = lbDHName.optimalHeight < Common.Size(s: 15) ? Common.Size(s: 15) : lbDHName.optimalHeight
            lbDHName.numberOfLines = 0
            lbDHName.frame = CGRect(x: lbDHName.frame.origin.x, y: lbDHName.frame.origin.y, width: lbDHName.frame.width, height: lbDHNameHeight)
            
            let lbDHImei = UILabel(frame: CGRect(x: lbDHName.frame.origin.x, y: lbDHName.frame.origin.y + lbDHNameHeight + Common.Size(s: 5), width: lbDHName.frame.width, height: Common.Size(s: 15)))
            lbDHImei.text = "IMEI: \(item.U_Imei)"
            lbDHImei.font = UIFont.systemFont(ofSize: 14)
            lbDHImei.textColor = UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
            viewDH.addSubview(lbDHImei)
            
            let imgViewBaoHanh = UIImageView(frame: CGRect(x: lbDHName.frame.origin.x + lbDHName.frame.width, y: lbDHName.frame.origin.y, width: Common.Size(s: 50), height: lbDHNameHeight + lbDHImei.frame.height + Common.Size(s: 5)))
            imgViewBaoHanh.image = #imageLiteral(resourceName: "AddImage51")
            imgViewBaoHanh.contentMode = .scaleAspectFit
            imgViewBaoHanh.tag = i
            viewDH.addSubview(imgViewBaoHanh)
            
            let tapShowImgPhieuBaoHanh = UITapGestureRecognizer(target: self, action: #selector(showImgPhieuBaoHanh(sender:)))
            imgViewBaoHanh.isUserInteractionEnabled = true
            imgViewBaoHanh.addGestureRecognizer(tapShowImgPhieuBaoHanh)
            
            if !(item.LinkAnh.isEmpty) {
                imgViewBaoHanh.isHidden = false
                imgViewBaoHanh.frame = CGRect(x: imgViewBaoHanh.frame.origin.x, y: imgViewBaoHanh.frame.origin.y, width: imgViewBaoHanh.frame.width, height: lbDHNameHeight + lbDHImei.frame.height + Common.Size(s: 5))
            } else {
                imgViewBaoHanh.isHidden = true
                imgViewBaoHanh.frame = CGRect(x: imgViewBaoHanh.frame.origin.x, y: imgViewBaoHanh.frame.origin.y, width: imgViewBaoHanh.frame.width, height: 0)
            }
            
            let lbPrice = UILabel(frame: CGRect(x: lbDHName.frame.origin.x, y: lbDHImei.frame.origin.y + lbDHImei.frame.height + Common.Size(s: 5), width: (viewDH.frame.width - Common.Size(s: 61))/2, height: Common.Size(s: 20)))
            lbPrice.text = "Giá: \(Common.convertCurrencyFloat(value: item.Price))"
            lbPrice.font = UIFont.systemFont(ofSize: 14)
            lbPrice.textColor = UIColor(red: 194/255, green: 42/255, blue: 31/255, alpha: 1)
            viewDH.addSubview(lbPrice)
            
            let lbGiamGiatay = UILabel(frame: CGRect(x: lbPrice.frame.origin.x + lbPrice.frame.width, y: lbPrice.frame.origin.y, width: lbPrice.frame.width, height: Common.Size(s: 20)))
            lbGiamGiatay.text = "Giảm giá tay: \(Common.convertCurrencyFloat(value: item.U_discount))"
            lbGiamGiatay.font = UIFont.systemFont(ofSize: 14)
            lbGiamGiatay.textAlignment = .right
            lbGiamGiatay.textColor = UIColor(red: 29/255, green: 110/255, blue: 191/255, alpha: 1)
            viewDH.addSubview(lbGiamGiatay)
            
            if item.U_discount > 0 {
                lbGiamGiatay.isHidden = false
                lbGiamGiatay.frame = CGRect(x: lbGiamGiatay.frame.origin.x, y: lbGiamGiatay.frame.origin.y, width: lbGiamGiatay.frame.width, height: Common.Size(s: 20))
            } else {
                lbGiamGiatay.isHidden = true
                lbGiamGiatay.frame = CGRect(x: lbGiamGiatay.frame.origin.x, y: lbGiamGiatay.frame.origin.y, width: lbGiamGiatay.frame.width, height: 0)
            }
            
            viewDH.frame = CGRect(x: viewDH.frame.origin.x, y: viewDH.frame.origin.y, width: viewDH.frame.width, height: lbPrice.frame.origin.y + lbPrice.frame.height + Common.Size(s: 5))
            
            let line = UIView(frame: CGRect(x: lbSTT.frame.origin.x + lbSTT.frame.width, y: Common.Size(s: 10), width: Common.Size(s: 1), height: viewDH.frame.height - Common.Size(s: 10)))
            line.backgroundColor = UIColor(red: 67/255, green: 135/255, blue: 107/255, alpha: 1)
            viewDH.addSubview(line)
            
            let line2 = UIView(frame: CGRect(x: 0, y: viewDH.frame.height - Common.Size(s: 1), width: viewDH.frame.width, height: Common.Size(s: 1)))
            line2.backgroundColor = UIColor(red: 67/255, green: 135/255, blue: 107/255, alpha: 1)
            viewDH.addSubview(line2)
            
            viewChiTietDHContentHeight = viewChiTietDHContentHeight + viewDH.frame.height
        }
        
        viewChiTietDHContent.frame = CGRect(x: viewChiTietDHContent.frame.origin.x, y: viewChiTietDHContent.frame.origin.y, width: viewChiTietDHContent.frame.width, height: viewChiTietDHContentHeight)
        
        if self.rsLineProduct.count > 0 {
            viewChiTietDH.isHidden = false
            viewChiTietDHContent.isHidden = false
            
            viewChiTietDH.frame = CGRect(x: viewChiTietDH.frame.origin.x, y: viewChiTietDH.frame.origin.y, width: viewChiTietDH.frame.width, height: Common.Size(s: 40))
            viewChiTietDHContent.frame = CGRect(x: viewChiTietDHContent.frame.origin.x, y: viewChiTietDH.frame.origin.y + viewChiTietDH.frame.height, width: viewChiTietDHContent.frame.width, height: viewChiTietDHContentHeight)
        } else {
            viewChiTietDH.isHidden = true
            viewChiTietDHContent.isHidden = true
            
            viewChiTietDH.frame = CGRect(x: viewChiTietDH.frame.origin.x, y: viewChiTietDH.frame.origin.y, width: viewChiTietDH.frame.width, height: 0)
            viewChiTietDHContent.frame = CGRect(x: viewChiTietDHContent.frame.origin.x, y: viewChiTietDH.frame.origin.y + viewChiTietDH.frame.height, width: viewChiTietDHContent.frame.width, height: 0)
        }
        
        //THONG TIN KHUYEN MAI
        let viewKhuyenMai = UIView(frame: CGRect(x: 0, y: viewChiTietDHContent.frame.origin.y + viewChiTietDHContent.frame.height + Common.Size(s: 5), width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewKhuyenMai.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        scrollView.addSubview(viewKhuyenMai)
        
        let lbTTKhuyenMai = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewKhuyenMai.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbTTKhuyenMai.text = "THÔNG TIN KHUYẾN MÃI"
        lbTTKhuyenMai.font = UIFont.boldSystemFont(ofSize: 15)
        lbTTKhuyenMai.textColor = UIColor(netHex: 0x109e59)
        viewKhuyenMai.addSubview(lbTTKhuyenMai)
        
        let viewKhuyenMaiContent = UIView(frame: CGRect(x: 0, y: viewKhuyenMai.frame.origin.y + viewKhuyenMai.frame.height , width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewKhuyenMaiContent.backgroundColor = UIColor.white
        scrollView.addSubview(viewKhuyenMaiContent)
        
        var viewKhuyenMaiContentHeight:CGFloat = 0
        
        for i in 0..<self.rsLinePromos.count {
            let item = self.rsLinePromos[i]
            
            let viewKM = UIView(frame: CGRect(x: 0, y: viewKhuyenMaiContentHeight, width: viewKhuyenMaiContent.frame.width, height: Common.Size(s: 70)))
            viewKM.backgroundColor = .white
            viewKhuyenMaiContent.addSubview(viewKM)
            
            let lbSTT = UILabel(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: Common.Size(s: 30), height: Common.Size(s: 20)))
            lbSTT.text = "\(i + 1)"
            lbSTT.textAlignment = .center
            lbSTT.font = UIFont.systemFont(ofSize: 14)
            viewKM.addSubview(lbSTT)
            
            let lbKMName = UILabel(frame: CGRect(x: lbSTT.frame.origin.x + lbSTT.frame.width + Common.Size(s: 11), y: Common.Size(s: 5), width: viewKM.frame.width - Common.Size(s: 61), height: Common.Size(s: 15)))
            lbKMName.text = "\(item.TenCTKM)"
            lbKMName.font = UIFont.systemFont(ofSize: 14)
            viewKM.addSubview(lbKMName)
            
            let lbKMNameHeight:CGFloat = lbKMName.optimalHeight < Common.Size(s: 15) ? Common.Size(s: 15) : lbKMName.optimalHeight
            lbKMName.numberOfLines = 0
            lbKMName.frame = CGRect(x: lbKMName.frame.origin.x, y: lbKMName.frame.origin.y, width: lbKMName.frame.width, height: lbKMNameHeight)
            
            let lbKMDescription = UILabel(frame: CGRect(x: lbKMName.frame.origin.x, y: lbKMName.frame.origin.y + lbKMNameHeight + Common.Size(s: 5), width: lbKMName.frame.width, height: Common.Size(s: 15)))
            lbKMDescription.text = "\(item.TenSanPham_Tang)"
            lbKMDescription.font = UIFont.systemFont(ofSize: 14)
            lbKMDescription.textColor = UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
            viewKM.addSubview(lbKMDescription)
            
            let lbKMDescriptionHeight:CGFloat = lbKMDescription.optimalHeight < Common.Size(s: 15) ? Common.Size(s: 15) : lbKMDescription.optimalHeight
            lbKMDescription.numberOfLines = 0
            lbKMDescription.frame = CGRect(x: lbKMDescription.frame.origin.x, y: lbKMDescription.frame.origin.y, width: lbKMDescription.frame.width, height: lbKMDescriptionHeight)
            
            let lbSoLuong = UILabel(frame: CGRect(x: lbKMDescription.frame.origin.x, y: lbKMDescription.frame.origin.y + lbKMDescriptionHeight + Common.Size(s: 5), width: lbKMName.frame.width, height: Common.Size(s: 15)))
            lbSoLuong.text = "Số lượng: \(Common.convertCurrencyInteger(value: item.SL_Tang))"
            lbSoLuong.font = UIFont.systemFont(ofSize: 14)
            viewKM.addSubview(lbSoLuong)
            
            viewKM.frame = CGRect(x: viewKM.frame.origin.x, y: viewKM.frame.origin.y, width: viewKM.frame.width, height: lbSoLuong.frame.origin.y + lbSoLuong.frame.height + Common.Size(s: 5))
            
            let line = UIView(frame: CGRect(x: lbSTT.frame.origin.x + lbSTT.frame.width, y: Common.Size(s: 10), width: Common.Size(s: 1), height: viewKM.frame.height - Common.Size(s: 10)))
            line.backgroundColor = UIColor(red: 67/255, green: 135/255, blue: 107/255, alpha: 1)
            viewKM.addSubview(line)
            
            let line2 = UIView(frame: CGRect(x: 0, y: viewKM.frame.height - Common.Size(s: 1), width: viewKM.frame.width, height: Common.Size(s: 1)))
            line2.backgroundColor = UIColor(red: 67/255, green: 135/255, blue: 107/255, alpha: 1)
            viewKM.addSubview(line2)
            
            viewKhuyenMaiContentHeight = viewKhuyenMaiContentHeight + viewKM.frame.height
        }
        viewKhuyenMaiContent.frame = CGRect(x: viewKhuyenMaiContent.frame.origin.x, y: viewKhuyenMaiContent.frame.origin.y, width: viewKhuyenMaiContent.frame.width, height: viewKhuyenMaiContentHeight)
        
        if self.rsLinePromos.count > 0 {
            viewKhuyenMai.isHidden = false
            viewKhuyenMaiContent.isHidden = false
            viewKhuyenMai.frame = CGRect(x: viewKhuyenMai.frame.origin.x, y: viewKhuyenMai.frame.origin.y, width: viewKhuyenMai.frame.width, height: Common.Size(s: 40))
            viewKhuyenMaiContent.frame = CGRect(x: viewKhuyenMaiContent.frame.origin.x, y: viewKhuyenMai.frame.origin.y + viewKhuyenMai.frame.height, width: viewKhuyenMaiContent.frame.width, height: viewKhuyenMaiContentHeight)
        } else {
            viewKhuyenMai.isHidden = true
            viewKhuyenMai.frame = CGRect(x: viewKhuyenMai.frame.origin.x, y: viewKhuyenMai.frame.origin.y, width: viewKhuyenMai.frame.width, height: 0)
            viewKhuyenMaiContent.isHidden = true
            viewKhuyenMaiContent.frame = CGRect(x: viewKhuyenMaiContent.frame.origin.x, y: viewKhuyenMai.frame.origin.y + viewKhuyenMai.frame.height, width: viewKhuyenMaiContent.frame.width, height: 0)
        }
        
        scrollViewHeight = viewKhuyenMaiContent.frame.origin.y + viewKhuyenMaiContent.frame.height + Common.Size(s: 50)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
    }
    
    fileprivate func createRadioButton(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:12));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(UIColor.black, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.isUserInteractionEnabled = false
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        self.view.addSubview(radioButton);
        return radioButton;
    }
    
    @objc func showImgPhieuBaoHanh(sender:UITapGestureRecognizer) {
        let imgView:UIImageView = sender.view! as! UIImageView
        let tag = imgView.tag
        debugPrint("img tag: \(tag)")
        
        let vc = ShowImgPhieuBaoHanhViewController()
        vc.linkAnh = self.rsLineProduct[tag].LinkAnh
        self.customPresentViewController(presenter, viewController: vc, animated: true)
    }
}
