//
//  DetailSOThuHoViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/27/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Toaster
import PopupDialog
class DetailSOThuHoViewController: UIViewController,UITextFieldDelegate{
    var so:GetCRMPaymentHistoryTheNapResult?
    //---
    
    var type:Int = 0 // 0: THE 1: TOPUP
    var itemPrice:ItemPrice?
    var quantityValue:Int = 1
    var phone:String = ""
    var ValuePromotion:Int = 0
    var cashValue:Int = 0
    var cardValue:Int = 0
    
    var payooPayCodeResult:PayooPayCodeResult?
    var payooPayCodeHeaderResult:PayooPayCodeHeaderResult?
    
    var theCaoVietNamMobile:TheCao_VietNamMobile?
    var theCaoVietNamMobileHeaders:TheCao_VietNamMobileHeaders?
    
    var payooTopupResult:PayooTopupResult?
    
    //----
    var lbTotalValue: UILabel!
    var scrollView:UIScrollView!
    var listVoucherView:UIView!
    var boxVoucherView:UIView!
    var tfVoucher:UITextField!
    var listVoucher:[CheckVoucherResult] = []
    var lbTotalVoucherValue: UILabel!
    var lbTotalSumValue:UILabel!
    var viewBottomVoucher:UIView!
    var typeCard:UIView!
    var typeCash:UIView!
    var lbTypeCash:UILabel!
    var lbTypeCard:UILabel!
    var typeCashPayment:Bool = false
    var typeCardPayment:Bool = false
    var promotionView:UIView!
    var typePaymentView:UIView!
    var tfCash:UITextField!
    var tfCard:UITextField!
    var total:Int = 0
    var scrollViewHeight: CGFloat = 0
    
    var isThuHoViettelTS = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.initNavigationBar()
        
        self.title = "Lịch sử thu hộ"
        self.view.backgroundColor = UIColor.white
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(DetailSOThuHoViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: scrollView.frame.size.height)
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        let viewGD = UIScrollView(frame: CGRect(x: 0, y:0, width: scrollView.frame.size.width, height:  Common.Size(s: 40)))
        viewGD.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView.addSubview(viewGD)
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        label1.text = "THÔNG TIN GIAO DỊCH"
        label1.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 15))
        label1.textColor = UIColor(netHex: 0x109e59)
        viewGD.addSubview(label1)
        
        let lbSoHD = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewGD.frame.origin.y + viewGD.frame.height + Common.Size(s: 5), width: scrollView.frame.width/2 - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbSoHD.text = "Số hợp đồng"
        lbSoHD.textColor = UIColor.lightGray
        lbSoHD.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbSoHD)
        
        let lbSoHDText = UILabel(frame: CGRect(x: lbSoHD.frame.size.width + lbSoHD.frame.origin.x, y: lbSoHD.frame.origin.y, width: scrollView.frame.width/2 - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbSoHDText.text = "\(so!.customerCode)"
        lbSoHDText.textColor = UIColor.black
        lbSoHDText.textAlignment = .right
        lbSoHDText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbSoHDText)
        
        let lbSoHDTextHeight:CGFloat = lbSoHDText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbSoHDText.optimalHeight + Common.Size(s: 5))
        lbSoHDText.numberOfLines = 0
        lbSoHDText.frame = CGRect(x: lbSoHDText.frame.origin.x, y: lbSoHDText.frame.origin.y, width: lbSoHDText.frame.width, height: lbSoHDTextHeight)
        
        let lbPrice = UILabel(frame: CGRect(x: lbSoHD.frame.origin.x, y: lbSoHDText.frame.origin.y + lbSoHDTextHeight, width: lbSoHD.frame.size.width, height: Common.Size(s: 20)))
        lbPrice.text = "Loại dịch vụ"
        lbPrice.textColor = UIColor.lightGray
        lbPrice.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbPrice)
        
        let lbValuePrice = UILabel(frame: CGRect(x: lbSoHDText.frame.origin.x, y: lbPrice.frame.origin.y, width: lbSoHDText.frame.size.width, height: Common.Size(s: 20)))
        lbValuePrice.text = "\(so!.LoaiDichVu)"
        lbValuePrice.textColor = UIColor.black
        lbValuePrice.textAlignment = .right
        lbValuePrice.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbValuePrice)
        
        let lbValuePriceHeight:CGFloat = lbValuePrice.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbValuePrice.optimalHeight + Common.Size(s: 5))
        lbValuePrice.numberOfLines = 0
        lbValuePrice.frame = CGRect(x: lbValuePrice.frame.origin.x, y: lbValuePrice.frame.origin.y, width: lbValuePrice.frame.width, height: lbValuePriceHeight)
        
        let lbNCC = UILabel(frame: CGRect(x: lbPrice.frame.origin.x, y: lbPrice.frame.origin.y + lbValuePriceHeight, width: lbPrice.frame.size.width, height: Common.Size(s: 20)))
        lbNCC.text = "Nhà cung cấp"
        lbNCC.textColor = UIColor.lightGray
        lbNCC.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbNCC)
        
        let lbNCCText = UILabel(frame: CGRect(x: lbValuePrice.frame.origin.x, y: lbNCC.frame.origin.y, width: lbPrice.frame.size.width, height: Common.Size(s: 20)))
        lbNCCText.text = "\(so!.NCC)"
        lbNCCText.textColor = UIColor.black
        lbNCCText.textAlignment = .right
        lbNCCText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbNCCText)
        
        let lbNCCTextHeight:CGFloat = lbNCCText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNCCText.optimalHeight + Common.Size(s: 5))
        lbNCCText.numberOfLines = 0
        lbNCCText.frame = CGRect(x: lbNCCText.frame.origin.x, y: lbNCCText.frame.origin.y, width: lbNCCText.frame.width, height: lbNCCTextHeight)
        
        let lbSoPos = UILabel(frame: CGRect(x: lbPrice.frame.origin.x, y: lbNCCText.frame.origin.y + lbNCCTextHeight, width: lbPrice.frame.size.width, height: lbPrice.frame.size.height))
        lbSoPos.text = "Số Mpos"
        lbSoPos.textColor = UIColor.lightGray
        lbSoPos.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbSoPos)
        
        let lbSoPosText = UILabel(frame: CGRect(x: lbSoPos.frame.size.width + lbSoPos.frame.origin.x, y: lbSoPos.frame.origin.y, width: lbPrice.frame.size.width, height: Common.Size(s: 20)))
        lbSoPosText.text = "\(so!.MPOS)"
        lbSoPosText.textColor = UIColor.black
        lbSoPosText.textAlignment = .right
        lbSoPosText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbSoPosText)
        
        let lbSoPosTextHeight:CGFloat = lbSoPosText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbSoPosText.optimalHeight + Common.Size(s: 5))
        lbSoPosText.numberOfLines = 0
        lbSoPosText.frame = CGRect(x: lbSoPosText.frame.origin.x, y: lbSoPosText.frame.origin.y, width: lbSoPosText.frame.width, height: lbSoPosTextHeight)
        
        let lbNgayGiaoDich = UILabel(frame: CGRect(x: lbPrice.frame.origin.x, y: lbSoPosText.frame.origin.y + lbSoPosTextHeight, width: lbPrice.frame.size.width, height: lbPrice.frame.size.height))
        lbNgayGiaoDich.text = "Ngày giao dịch"
        lbNgayGiaoDich.textColor = UIColor.lightGray
        lbNgayGiaoDich.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbNgayGiaoDich)
        
        let lbNgayGiaoDichText = UILabel(frame: CGRect(x: lbNgayGiaoDich.frame.size.width + lbNgayGiaoDich.frame.origin.x, y: lbNgayGiaoDich.frame.origin.y, width: lbPrice.frame.size.width, height: Common.Size(s: 20)))
        lbNgayGiaoDichText.textColor = UIColor.black
        lbNgayGiaoDichText.textAlignment = .right
        lbNgayGiaoDichText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbNgayGiaoDichText.text = so?.CreatedDateTime ?? ""
        scrollView.addSubview(lbNgayGiaoDichText)
        
        let lbNVGiaoDich = UILabel(frame: CGRect(x: lbPrice.frame.origin.x, y: lbNgayGiaoDichText.frame.origin.y + lbNgayGiaoDichText.frame.size.height, width: lbPrice.frame.size.width, height: lbPrice.frame.size.height))
        lbNVGiaoDich.text = "Nhân viên giao dịch"
        lbNVGiaoDich.textColor = UIColor.lightGray
        lbNVGiaoDich.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbNVGiaoDich)
        
        let lbNVGiaoDichText = UILabel(frame: CGRect(x: lbNVGiaoDich.frame.size.width + lbNVGiaoDich.frame.origin.x, y: lbNVGiaoDich.frame.origin.y, width: lbPrice.frame.size.width, height: Common.Size(s: 20)))
        lbNVGiaoDichText.text = "\(so?.NVGD ?? "")"
        lbNVGiaoDichText.textColor = UIColor.black
        lbNVGiaoDichText.textAlignment = .right
        lbNVGiaoDichText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbNVGiaoDichText)
        
        let lbNVGiaoDichTextHeight:CGFloat = lbNVGiaoDichText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNVGiaoDichText.optimalHeight)
        lbNVGiaoDichText.numberOfLines = 0
        lbNVGiaoDichText.frame = CGRect(x: lbNVGiaoDichText.frame.origin.x, y: lbNVGiaoDichText.frame.origin.y, width: lbNVGiaoDichText.frame.width, height: lbNVGiaoDichTextHeight)
        
        if self.isThuHoViettelTS {
            lbNgayGiaoDich.isHidden = true
            lbNgayGiaoDichText.isHidden = true
            
            lbNVGiaoDich.frame = CGRect(x: lbNVGiaoDich.frame.origin.x, y: lbSoPosText.frame.origin.y + lbSoPosTextHeight, width: lbNVGiaoDich.frame.width, height: lbNVGiaoDich.frame.height)
            lbNVGiaoDichText.frame = CGRect(x: lbNVGiaoDichText.frame.origin.x, y: lbNVGiaoDich.frame.origin.y, width: lbNVGiaoDichText.frame.width, height: lbNVGiaoDichTextHeight)
            
        } else {
            lbNgayGiaoDich.isHidden = false
            lbNgayGiaoDichText.isHidden = false
            
            lbNVGiaoDich.frame = CGRect(x: lbNVGiaoDich.frame.origin.x, y: lbNgayGiaoDichText.frame.origin.y + lbNgayGiaoDichText.frame.size.height, width: lbNVGiaoDich.frame.width, height: lbNVGiaoDich.frame.height)
            lbNVGiaoDichText.frame = CGRect(x: lbNVGiaoDichText.frame.origin.x, y: lbNVGiaoDich.frame.origin.y, width: lbNVGiaoDichText.frame.width, height: lbNVGiaoDichTextHeight)
        }
        
        let viewInfoKH = UIScrollView(frame: CGRect(x: 0, y: lbNVGiaoDichText.frame.origin.y + lbNVGiaoDichTextHeight + Common.Size(s: 5), width: scrollView.frame.size.width, height: Common.Size(s: 40)))
        viewInfoKH.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView.addSubview(viewInfoKH)
        
        let lbKHInfo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbKHInfo.text = "THÔNG TIN KHÁCH HÀNG"
        lbKHInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 15))
        lbKHInfo.textColor = UIColor(netHex: 0x109e59)
        viewInfoKH.addSubview(lbKHInfo)
        
        let lbTenKH = UILabel(frame: CGRect(x: lbPrice.frame.origin.x, y: viewInfoKH.frame.origin.y + viewInfoKH.frame.size.height + Common.Size(s: 5), width: lbPrice.frame.size.width, height: lbPrice.frame.size.height))
        lbTenKH.text = "Tên khách hàng"
        lbTenKH.textColor = UIColor.lightGray
        lbTenKH.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbTenKH)
        
        let lbTenKHText = UILabel(frame: CGRect(x: lbTenKH.frame.size.width + lbTenKH.frame.origin.x, y: lbTenKH.frame.origin.y, width: lbPrice.frame.size.width, height: Common.Size(s: 20)))
        lbTenKHText.text = "\(so?.customerName ?? "")"
        lbTenKHText.textColor = UIColor.black
        lbTenKHText.textAlignment = .right
        lbTenKHText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbTenKHText)
        
        let lbTenKHTextHeight:CGFloat = lbTenKHText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbTenKHText.optimalHeight
        lbTenKHText.numberOfLines = 0
        lbTenKHText.frame = CGRect(x: lbTenKHText.frame.origin.x, y: lbTenKHText.frame.origin.y, width: lbNVGiaoDichText.frame.width, height: lbTenKHTextHeight)
        
        let lbSdt = UILabel(frame: CGRect(x: lbPrice.frame.origin.x, y: lbTenKHText.frame.origin.y + lbTenKHTextHeight + Common.Size(s: 5), width: lbPrice.frame.size.width, height: lbPrice.frame.size.height))
        lbSdt.text = "Số điện thoại"
        lbSdt.textColor = UIColor.lightGray
        lbSdt.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbSdt)
        
        let lbSdtText = UILabel(frame: CGRect(x: lbSdt.frame.size.width + lbSdt.frame.origin.x, y: lbSdt.frame.origin.y, width: lbPrice.frame.size.width, height: Common.Size(s: 20)))
        lbSdtText.text = "\(so?.SDT_KH ?? "")"
        lbSdtText.textColor = UIColor.black
        lbSdtText.textAlignment = .right
        lbSdtText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbSdtText)
        
        let viewHTThanhToan = UIScrollView(frame: CGRect(x: 0, y: lbSdtText.frame.origin.y + lbSdtText.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width, height: Common.Size(s: 40)))
        viewHTThanhToan.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView.addSubview(viewHTThanhToan)
        
        let lbHTThanhToan = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbHTThanhToan.text = "HÌNH THỨC THANH TOÁN"
        lbHTThanhToan.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 15))
        lbHTThanhToan.textColor = UIColor(netHex: 0x109e59)
        viewHTThanhToan.addSubview(lbHTThanhToan)
        
        let lbTienMat = UILabel(frame: CGRect(x: lbPrice.frame.origin.x, y: viewHTThanhToan.frame.origin.y + viewHTThanhToan.frame.size.height + Common.Size(s: 5), width: lbPrice.frame.size.width, height: lbPrice.frame.size.height))
        lbTienMat.text = "Tiền mặt"
        lbTienMat.textColor = UIColor.lightGray
        lbTienMat.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbTienMat)
        
        let lbTienMatText = UILabel(frame: CGRect(x: lbTienMat.frame.size.width + lbTienMat.frame.origin.x, y: lbTienMat.frame.origin.y, width: lbPrice.frame.size.width, height: Common.Size(s: 20)))
        lbTienMatText.text = "\(Common.convertCurrency(value: so?.Tong_TienMat ?? 0))"
        lbTienMatText.textColor = UIColor(netHex: 0x109e59)
        lbTienMatText.textAlignment = .right
        lbTienMatText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbTienMatText)
        
        let lbThe = UILabel(frame: CGRect(x: lbPrice.frame.origin.x, y: lbTienMatText.frame.origin.y + lbTienMatText.frame.size.height + Common.Size(s: 5), width: lbPrice.frame.size.width, height: lbPrice.frame.size.height))
        lbThe.text = "Thẻ/Ví"
        lbThe.textColor = UIColor.lightGray
        lbThe.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbThe)
        
        let lbTheText = UILabel(frame: CGRect(x: lbThe.frame.size.width + lbThe.frame.origin.x, y: lbThe.frame.origin.y, width: lbPrice.frame.size.width, height: Common.Size(s: 20)))
        lbTheText.text = "\(Common.convertCurrency(value: so?.Tong_The ?? 0))"
        lbTheText.textColor = UIColor(netHex: 0x109e59)
        lbTheText.textAlignment = .right
        lbTheText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbTheText)
        
        let lbLoaiThe = UILabel(frame: CGRect(x: lbPrice.frame.origin.x, y: lbTheText.frame.origin.y + lbTheText.frame.size.height + Common.Size(s: 5), width: lbPrice.frame.size.width, height: lbPrice.frame.size.height))
        lbLoaiThe.text = "Loại Thẻ/Ví"
        lbLoaiThe.textColor = UIColor.lightGray
        lbLoaiThe.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbLoaiThe)
        
        let lbLoaiTheText = UILabel(frame: CGRect(x: lbLoaiThe.frame.size.width + lbLoaiThe.frame.origin.x, y: lbLoaiThe.frame.origin.y, width: lbPrice.frame.size.width, height: Common.Size(s: 20)))
        lbLoaiTheText.text = "\(so?.NameCard ?? "")"
        lbLoaiTheText.textColor = UIColor(netHex: 0x1c6cad)
        lbLoaiTheText.textAlignment = .right
        lbLoaiTheText.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbLoaiTheText)
        
        let viewInfoThanhToan = UIScrollView(frame: CGRect(x: 0, y: lbLoaiTheText.frame.origin.y + lbLoaiTheText.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width, height: Common.Size(s: 40)))
        viewInfoThanhToan.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView.addSubview(viewInfoThanhToan)
        
        let lbInfoThanhToan = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbInfoThanhToan.text = "THÔNG TIN THANH TOÁN"
        lbInfoThanhToan.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 15))
        lbInfoThanhToan.textColor = UIColor(netHex: 0x109e59)
        viewInfoThanhToan.addSubview(lbInfoThanhToan)
        
        let lbPhiThuHo = UILabel(frame: CGRect(x: lbPrice.frame.origin.x, y: viewInfoThanhToan.frame.origin.y + viewInfoThanhToan.frame.size.height + Common.Size(s: 5), width: lbPrice.frame.size.width, height: lbPrice.frame.size.height))
        lbPhiThuHo.text = "Phí thu hộ"
        lbPhiThuHo.textColor = UIColor.lightGray
        lbPhiThuHo.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbPhiThuHo)
        
        let lbPhiThuHoText = UILabel(frame: CGRect(x: lbPhiThuHo.frame.size.width + lbPhiThuHo.frame.origin.x, y: lbPhiThuHo.frame.origin.y, width: lbPrice.frame.size.width, height: Common.Size(s: 20)))
        lbPhiThuHoText.text = "\(Common.convertCurrency(value: so?.TongTienPhi ?? 0))"
        lbPhiThuHoText.textColor = UIColor(netHex: 0xcc0c2f)
        lbPhiThuHoText.textAlignment = .right
        lbPhiThuHoText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbPhiThuHoText)
        
        let lbPhiCaThe = UILabel(frame: CGRect(x: lbPrice.frame.origin.x, y: lbPhiThuHoText.frame.origin.y + lbPhiThuHoText.frame.size.height + Common.Size(s: 5), width: lbPrice.frame.size.width, height: lbPrice.frame.size.height))
        lbPhiCaThe.text = "Phí cà thẻ/Ví"
        lbPhiCaThe.textColor = UIColor.lightGray
        lbPhiCaThe.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbPhiCaThe)
        
        let lbPhiCaTheText = UILabel(frame: CGRect(x: lbPhiCaThe.frame.size.width + lbPhiCaThe.frame.origin.x, y: lbPhiCaThe.frame.origin.y, width: lbPrice.frame.size.width, height: Common.Size(s: 20)))
        lbPhiCaTheText.text = "\(Common.convertCurrency(value: so?.PhiCaThe ?? 0))"
        lbPhiCaTheText.textColor = UIColor(netHex: 0xcc0c2f)
        lbPhiCaTheText.textAlignment = .right
        lbPhiCaTheText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbPhiCaTheText)
        
        let lbSoTienThuHo = UILabel(frame: CGRect(x: lbPrice.frame.origin.x, y: lbPhiCaTheText.frame.origin.y + lbPhiCaTheText.frame.size.height + Common.Size(s: 5), width: lbPrice.frame.size.width, height: lbPrice.frame.size.height))
        lbSoTienThuHo.text = "Số tiền thu hộ"
        lbSoTienThuHo.textColor = UIColor.lightGray
        lbSoTienThuHo.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbSoTienThuHo)
        
        let lbSoTienThuHoText = UILabel(frame: CGRect(x: lbSoTienThuHo.frame.size.width + lbSoTienThuHo.frame.origin.x, y: lbSoTienThuHo.frame.origin.y, width: lbPrice.frame.size.width, height: Common.Size(s: 20)))
        lbSoTienThuHoText.text = "\(Common.convertCurrency(value: so?.TongTienKhongPhi ?? 0))"
        lbSoTienThuHoText.textColor = UIColor(netHex: 0xcc0c2f)
        lbSoTienThuHoText.textAlignment = .right
        lbSoTienThuHoText.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbSoTienThuHoText)
        
        let lbSoTienThanhToan = UILabel(frame: CGRect(x: lbPrice.frame.origin.x, y: lbSoTienThuHoText.frame.origin.y + lbSoTienThuHoText.frame.size.height + Common.Size(s: 5), width: lbPrice.frame.size.width, height: lbPrice.frame.size.height))
        lbSoTienThanhToan.text = "Số tiền thanh toán"
        lbSoTienThanhToan.textColor = UIColor.lightGray
        lbSoTienThanhToan.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbSoTienThanhToan)
        
        let lbSoTienThanhToanText = UILabel(frame: CGRect(x: lbSoTienThanhToan.frame.size.width + lbSoTienThanhToan.frame.origin.x, y: lbSoTienThanhToan.frame.origin.y, width: lbPrice.frame.size.width, height: Common.Size(s: 20)))
        lbSoTienThanhToanText.text = "0"
        lbSoTienThanhToanText.textColor = UIColor(netHex: 0xcc0c2f)
        lbSoTienThanhToanText.textAlignment = .right
        lbSoTienThanhToanText.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbSoTienThanhToanText)
        
        let totalPayValue = (so?.TongTienDaThu ?? 0)
        lbSoTienThanhToanText.text = "\(Common.convertCurrency(value: totalPayValue))"
        
        let btnPrint = UIButton(frame: CGRect(x: Common.Size(s: 15), y: lbSoTienThanhToanText.frame.origin.y + lbSoTienThanhToanText.frame.height + Common.Size(s: 15), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        btnPrint.backgroundColor = UIColor(netHex: 0x109e59)
        btnPrint.setTitle("IN", for: .normal)
        btnPrint.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btnPrint.layer.cornerRadius = 5
        btnPrint.addTarget(self, action: #selector(payAction(_:)), for: .touchUpInside)
        scrollView.addSubview(btnPrint)
        
        scrollViewHeight = btnPrint.frame.origin.y + btnPrint.frame.height + Common.Size(s: 30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    @objc func payAction(_ sender:UITapGestureRecognizer){
        
        let printBillThuHo = PrintBillThuHo(BillCode:"\(so!.Bill_Code)", TransactionCode: "\(so!.MaGD)", ServiceName:"\(so!.LoaiDichVu)", ProVideName:"\(so!.NCC)", NhaCungCap: "\(so!.NCC)", Customernamne:"\(so!.customerName)", Customerpayoo:"\(so!.customerCode)", PayerMobiphone:"\(so!.SDT_KH)", Address:"", BillID:"", Month:"\(so!.KyThanhToan)", TotalAmouth:"\(Common.FormatMoney(cost: so!.TongTienKhongPhi)!)", Paymentfee:"\(Common.FormatMoney(cost: so!.TongTienPhi)!)", Employname:"\(Cache.user!.EmployeeName)", Createby:"\(Cache.user!.UserName)", ShopAddress:"\(Cache.user!.Address)",ThoiGianXuat:"\(so!.CreatedDateTime)", MaVoucher: "\(so!.U_Voucher)", HanSuDung: "\(so?.NgayHetHan ?? "")", PhiCaThe: "\(so!.PhiCaThe)")
        
        
        MPOSAPIManager.pushBillThuHo(printBill: printBillThuHo)
        Toast(text: "Đã gửi lệnh in!").show()
        if self.isThuHoViettelTS {
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func actionBack() {
        if self.isThuHoViettelTS {
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}
