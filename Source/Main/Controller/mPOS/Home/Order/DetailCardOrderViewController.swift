//
//  DetailCardOrderViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/25/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Toaster
import PopupDialog
class DetailCardOrderViewController: UIViewController,UITextFieldDelegate{
    var so:GetCRMPaymentHistoryTheNapResult?
    var scrollView:UIScrollView!
    var scrollViewHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
//        self.initNavigationBar()
        
        if so?.Type_LoaiDichVu == 1 {
            self.title = "Lịch sử chi tiết thẻ cào"
        } else {
            self.title = "Lịch sử chi tiết topup"
        }
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(DetailCardOrderViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        self.view.backgroundColor = UIColor.white
        scrollView = UIScrollView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - ((self.navigationController?.navigationBar.frame.size.height ?? 0) + UIApplication.shared.statusBarFrame.height)))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: scrollView.frame.size.height)
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        let viewTTKH = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewTTKH.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView.addSubview(viewTTKH)
        
        let lbTTKH = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewTTKH.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbTTKH.text = "CHI TIẾT GIAO DỊCH"
        lbTTKH.textColor = UIColor(netHex: 0x109e59)
        lbTTKH.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 15))
        viewTTKH.addSubview(lbTTKH)
        
        let lbSoPOS = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewTTKH.frame.origin.y + viewTTKH.frame.height + Common.Size(s: 5), width: scrollView.frame.width/2 - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbSoPOS.text = "Số Mpos:"
        lbSoPOS.textColor = UIColor(netHex: 0x109e59)
        lbSoPOS.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbSoPOS)
        
        let lbSoPOSText = UILabel(frame: CGRect(x: lbSoPOS.frame.size.width + lbSoPOS.frame.origin.x, y: lbSoPOS.frame.origin.y, width: scrollView.frame.width/2 - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbSoPOSText.text = "\(so?.MPOS ?? 0)"
        lbSoPOSText.textColor = UIColor(netHex: 0x109e59)
        lbSoPOSText.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbSoPOSText)
        
        let lbTelecom = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSoPOSText.frame.origin.y + lbSoPOSText.frame.height + Common.Size(s: 5), width: scrollView.frame.width/2 - Common.Size(s: 15), height: Common.Size(s: 18)))
        lbTelecom.text = "Nhà mạng:"
        lbTelecom.textColor = UIColor.lightGray
        lbTelecom.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbTelecom)
        
        let lbValueTelecom = UILabel(frame: CGRect(x: lbTelecom.frame.size.width + lbTelecom.frame.origin.x, y: lbTelecom.frame.origin.y, width: scrollView.frame.width/2 - Common.Size(s: 15), height: lbTelecom.frame.size.height))
        lbValueTelecom.text = "\(so?.NhaMang ?? "")"
        lbValueTelecom.textColor = UIColor.black
        lbValueTelecom.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbValueTelecom)
        
        let lbPriceCard = UILabel(frame: CGRect(x: lbSoPOS.frame.origin.x, y: lbValueTelecom.frame.origin.y + lbValueTelecom.frame.size.height + Common.Size(s: 5), width: lbSoPOS.frame.size.width, height: lbSoPOS.frame.size.height))
        lbPriceCard.text = "Mệnh giá:"
        lbPriceCard.textColor = UIColor.lightGray
        lbPriceCard.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbPriceCard)
        
        let lbValuePriceCard = UILabel(frame: CGRect(x: lbPriceCard.frame.size.width + lbPriceCard.frame.origin.x, y: lbPriceCard.frame.origin.y, width: lbValueTelecom.frame.size.width, height: lbValueTelecom.frame.size.height))
        lbValuePriceCard.text = "\(Common.convertCurrency(value: so?.MenhGia ?? 0))"
        lbValuePriceCard.textColor = UIColor(netHex: 0xcc0c2f)
        lbValuePriceCard.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbValuePriceCard)
        
        let lbGiaBan = UILabel(frame: CGRect(x: lbSoPOS.frame.origin.x, y: lbValuePriceCard.frame.origin.y + lbValuePriceCard.frame.size.height + Common.Size(s: 5), width: lbSoPOS.frame.size.width, height: lbSoPOS.frame.size.height))
        lbGiaBan.text = "Giá bán:"
        lbGiaBan.textColor = UIColor.lightGray
        lbGiaBan.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbGiaBan)
        
        let lbGiaBanText = UILabel(frame: CGRect(x: lbGiaBan.frame.size.width + lbGiaBan.frame.origin.x, y: lbGiaBan.frame.origin.y, width: lbGiaBan.frame.size.width, height: lbValuePriceCard.frame.size.height))
        lbGiaBanText.text = "\(Common.convertCurrency(value: so?.TongTienDaThu ?? 0))"
        lbGiaBanText.textColor = UIColor(netHex: 0xcc0c2f)
        lbGiaBanText.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbGiaBanText)
        
        let lbQuantity = UILabel(frame: CGRect(x: lbSoPOS.frame.origin.x, y: lbGiaBanText.frame.origin.y + lbGiaBanText.frame.size.height + Common.Size(s: 5), width: lbSoPOS.frame.size.width, height: lbSoPOS.frame.size.height))
        lbQuantity.text = "Số lượng:"
        lbQuantity.textColor = UIColor.lightGray
        lbQuantity.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbQuantity)
        
        let lbValueQuantity = UILabel(frame: CGRect(x: lbQuantity.frame.size.width + lbQuantity.frame.origin.x, y: lbQuantity.frame.origin.y, width: lbGiaBan.frame.size.width, height: lbValuePriceCard.frame.size.height))
        lbValueQuantity.text = "\(Common.convertCurrencyInteger(value: so?.SLThe ?? 0))"
        lbValueQuantity.textColor = UIColor(netHex: 0x109e59)
        lbValueQuantity.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbValueQuantity)
        
        if so?.Type_LoaiDichVu == 1 {//the cao
            lbQuantity.isHidden = false
            lbQuantity.isHidden = false
            lbQuantity.frame = CGRect(x: lbQuantity.frame.origin.x, y: lbQuantity.frame.origin.y, width: lbQuantity.frame.width, height: Common.Size(s: 20))
            lbValueQuantity.frame = CGRect(x: lbValueQuantity.frame.origin.x, y: lbValueQuantity.frame.origin.y, width: lbValueQuantity.frame.width, height: Common.Size(s: 20))
        } else {//topup
            lbQuantity.isHidden = true
            lbQuantity.isHidden = true
            lbQuantity.frame = CGRect(x: lbQuantity.frame.origin.x, y: lbQuantity.frame.origin.y, width: lbQuantity.frame.width, height: 0)
            lbValueQuantity.frame = CGRect(x: lbValueQuantity.frame.origin.x, y: lbValueQuantity.frame.origin.y, width: lbValueQuantity.frame.width, height: 0)
        }
        
        let lbNCC = UILabel(frame: CGRect(x: lbSoPOS.frame.origin.x, y: lbValueQuantity.frame.origin.y + lbValueQuantity.frame.size.height + Common.Size(s: 5), width: lbSoPOS.frame.size.width, height: lbSoPOS.frame.size.height))
        lbNCC.text = "Nhà cung cấp"
        lbNCC.textColor = UIColor.lightGray
        lbNCC.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbNCC)
        
        let lbValueNCC = UILabel(frame: CGRect(x: lbNCC.frame.size.width + lbNCC.frame.origin.x, y: lbNCC.frame.origin.y, width: lbGiaBan.frame.size.width, height: lbValuePriceCard.frame.size.height))
        lbValueNCC.text = "\(so?.NCC ?? "")"
        lbValueNCC.textColor = UIColor.black
        lbValueNCC.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbValueNCC)
        
        let lbValueNCCHeight:CGFloat = lbValueNCC.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbValueNCC.optimalHeight + Common.Size(s: 5))
        lbValueNCC.numberOfLines = 0
        lbValueNCC.frame = CGRect(x: lbValueNCC.frame.origin.x, y: lbValueNCC.frame.origin.y, width: lbValueNCC.frame.width, height: lbValueNCCHeight)
        
        let lbNgayGD = UILabel(frame: CGRect(x: lbSoPOS.frame.origin.x, y: lbValueNCC.frame.origin.y + lbValueNCCHeight, width: lbSoPOS.frame.size.width, height: lbSoPOS.frame.size.height))
        lbNgayGD.text = "Ngày giao dịch:"
        lbNgayGD.textColor = UIColor.lightGray
        lbNgayGD.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbNgayGD)
        
        let lbNgayGDText = UILabel(frame: CGRect(x: lbNgayGD.frame.size.width + lbNgayGD.frame.origin.x, y: lbNgayGD.frame.origin.y, width: lbGiaBan.frame.size.width, height: lbValuePriceCard.frame.size.height))
        lbNgayGDText.textColor = UIColor.black
        lbNgayGDText.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbNgayGDText)
        let createDate = so?.CreatedDateTime ?? ""
        
        if !(createDate.isEmpty) {
            let dateStrOld = createDate
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            let date2 = formatter.date(from: dateStrOld)

            let newFormatter = DateFormatter()
            newFormatter.locale = Locale(identifier: "vi_VN");
            newFormatter.timeZone = TimeZone(identifier: "UTC");
            newFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            let str = newFormatter.string(from: date2 ?? Date())
            lbNgayGDText.text = str
        } else {
            lbNgayGDText.text = createDate
        }
        
        let lbNVGD = UILabel(frame: CGRect(x: lbSoPOS.frame.origin.x, y: lbNgayGDText.frame.origin.y + lbNgayGDText.frame.height + Common.Size(s: 5), width: lbSoPOS.frame.size.width, height: lbSoPOS.frame.size.height))
        lbNVGD.text = "Nhân viên giao dịch:"
        lbNVGD.textColor = UIColor.lightGray
        lbNVGD.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbNVGD)
        
        let lbNVGDText = UILabel(frame: CGRect(x: lbNVGD.frame.size.width + lbNVGD.frame.origin.x, y: lbNVGD.frame.origin.y, width: lbGiaBan.frame.size.width, height: lbValuePriceCard.frame.size.height))
        lbNVGDText.text = "\(so?.NVGD ?? "")"
        lbNVGDText.textColor = UIColor.black
        lbNVGDText.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbNVGDText)
        
        let lbNVGDTextHeight:CGFloat = lbNVGDText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNVGDText.optimalHeight + Common.Size(s: 5))
        lbNVGDText.numberOfLines = 0
        lbNVGDText.frame = CGRect(x: lbNVGDText.frame.origin.x, y: lbNVGDText.frame.origin.y, width: lbNVGDText.frame.width, height: lbNVGDTextHeight)
        
        let lbSdtKH = UILabel(frame: CGRect(x: lbSoPOS.frame.origin.x, y: lbNVGDText.frame.origin.y + lbNVGDTextHeight, width: lbSoPOS.frame.size.width, height: lbSoPOS.frame.size.height))
        lbSdtKH.text = "SĐT khách hàng:"
        lbSdtKH.textColor = UIColor.lightGray
        lbSdtKH.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbSdtKH)
        
        let lbSdtKHText = UILabel(frame: CGRect(x: lbSdtKH.frame.size.width + lbSdtKH.frame.origin.x, y: lbSdtKH.frame.origin.y, width: lbGiaBan.frame.size.width, height: lbValuePriceCard.frame.size.height))
        lbSdtKHText.text = "\(so?.SDT_KH ?? "")"
        lbSdtKHText.textColor = UIColor.black
        lbSdtKHText.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbSdtKHText)
        
        if so?.Type_LoaiDichVu == 1 {//the cao
            lbSdtKH.isHidden = true
            lbSdtKHText.isHidden = true
            lbSdtKH.frame = CGRect(x: lbSdtKH.frame.origin.x, y: lbSdtKH.frame.origin.y, width: lbSdtKH.frame.width, height: 0)
            lbSdtKHText.frame = CGRect(x: lbSdtKHText.frame.origin.x, y: lbSdtKHText.frame.origin.y, width: lbSdtKHText.frame.width, height: 0)
        } else {//topup
            lbSdtKH.isHidden = false
            lbSdtKHText.isHidden = false
            lbSdtKH.frame = CGRect(x: lbSdtKH.frame.origin.x, y: lbSdtKH.frame.origin.y, width: lbSdtKH.frame.width, height: Common.Size(s: 20))
            lbSdtKHText.frame = CGRect(x: lbSdtKHText.frame.origin.x, y: lbSdtKHText.frame.origin.y, width: lbSdtKHText.frame.width, height: Common.Size(s: 20))
        }
        
        let viewHTTT = UIView(frame: CGRect(x: 0, y: lbSdtKHText.frame.origin.y + lbSdtKHText.frame.height + Common.Size(s: 10), width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewHTTT.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView.addSubview(viewHTTT)

        let lbHTTT = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewHTTT.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbHTTT.text = "HÌNH THỨC THANH TOÁN"
        lbHTTT.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 15))
        lbHTTT.textColor = UIColor(netHex: 0x109e59)
        viewHTTT.addSubview(lbHTTT)
        
        let viewVCContent = UIView(frame: CGRect(x: 0, y: viewHTTT.frame.origin.y + viewHTTT.frame.height + Common.Size(s: 5), width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewVCContent.backgroundColor = UIColor.white
        scrollView.addSubview(viewVCContent)
        
        var viewVCContentHeight:CGFloat = 0
        if (so?.mVoucher.count ?? 0) > 0 {
            for i in 0..<(so?.mVoucher.count)! {
                let item = so?.mVoucher[i]
                
                let viewVC = UIView(frame: CGRect(x: 0, y: viewVCContentHeight, width: viewVCContent.frame.width, height: Common.Size(s: 70)))
                viewVC.backgroundColor = .white
                viewVCContent.addSubview(viewVC)
                
                let lbSTT = UILabel(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: Common.Size(s: 30), height: Common.Size(s: 15)))
                lbSTT.text = "\(i + 1)"
                lbSTT.textAlignment = .center
                lbSTT.font = UIFont.systemFont(ofSize: 14)
                viewVC.addSubview(lbSTT)
                
                let lbVCNumber = UILabel(frame: CGRect(x: lbSTT.frame.origin.x + lbSTT.frame.width + Common.Size(s: 11), y: Common.Size(s: 5), width: viewVC.frame.width - Common.Size(s: 61), height: Common.Size(s: 15)))
                lbVCNumber.text = "\(item?.VC_Code ?? "")"
                lbVCNumber.font = UIFont.boldSystemFont(ofSize: 14)
                viewVC.addSubview(lbVCNumber)
                
                let lbVCName = UILabel(frame: CGRect(x: lbVCNumber.frame.origin.x, y: lbVCNumber.frame.origin.y + lbVCNumber.frame.height + Common.Size(s: 5), width: lbVCNumber.frame.width, height: Common.Size(s: 15)))
                lbVCName.text = "\(item?.VC_Name ?? "")"
                lbVCName.font = UIFont.systemFont(ofSize: 14)
                viewVC.addSubview(lbVCName)
                
                let lbVCNameHeight:CGFloat = lbVCName.optimalHeight < Common.Size(s: 15) ? Common.Size(s: 15) : lbVCName.optimalHeight
                lbVCName.numberOfLines = 0
                lbVCName.frame = CGRect(x: lbVCName.frame.origin.x, y: lbVCName.frame.origin.y, width: lbVCName.frame.width, height: lbVCNameHeight)
                
                let lbVCPrice = UILabel(frame: CGRect(x: lbVCNumber.frame.origin.x, y: lbVCName.frame.origin.y + lbVCNameHeight + Common.Size(s: 5), width: lbVCNumber.frame.width, height: Common.Size(s: 15)))
                lbVCPrice.text = "\(Common.convertCurrency(value: item?.GiaTri_VC ?? 0))đ"
                lbVCPrice.font = UIFont.systemFont(ofSize: 14)
                lbVCPrice.textColor = UIColor(netHex: 0xcc0c2f)
                viewVC.addSubview(lbVCPrice)
                
                viewVC.frame = CGRect(x: viewVC.frame.origin.x, y: viewVC.frame.origin.y, width: viewVC.frame.width, height: lbVCPrice.frame.origin.y + lbVCPrice.frame.height + Common.Size(s: 5))
                
                let line = UIView(frame: CGRect(x: lbSTT.frame.origin.x + lbSTT.frame.width, y: Common.Size(s: 10), width: Common.Size(s: 1), height: viewVC.frame.height - Common.Size(s: 10)))
                line.backgroundColor = UIColor(red: 67/255, green: 135/255, blue: 107/255, alpha: 1)
                viewVC.addSubview(line)

                let line2 = UIView(frame: CGRect(x: 0, y: viewVC.frame.height - Common.Size(s: 1), width: viewVC.frame.width, height: Common.Size(s: 1)))
                line2.backgroundColor = UIColor(red: 67/255, green: 135/255, blue: 107/255, alpha: 1)
                viewVC.addSubview(line2)

                viewVCContentHeight = viewVCContentHeight + viewVC.frame.height
            }
            viewVCContent.frame = CGRect(x: viewVCContent.frame.origin.x, y: viewVCContent.frame.origin.y, width: viewVCContent.frame.width, height: viewVCContentHeight)
            
        } else {
            viewVCContent.frame = CGRect(x: viewVCContent.frame.origin.x, y: viewVCContent.frame.origin.y, width: viewVCContent.frame.width, height: 0)
        }
        
        let imgTienMat = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: viewVCContent.frame.origin.y + viewVCContent.frame.height + Common.Size(s: 5), width: Common.Size(s: 20), height: Common.Size(s: 20)))
        imgTienMat.image = #imageLiteral(resourceName: "check-2")
        imgTienMat.contentMode = .scaleAspectFit
        scrollView.addSubview(imgTienMat)
        
        let lbTienMatCheck = UILabel(frame: CGRect(x: imgTienMat.frame.origin.x + imgTienMat.frame.width + Common.Size(s: 5), y: imgTienMat.frame.origin.y, width: (scrollView.frame.size.width/2) - Common.Size(s: 35), height: Common.Size(s: 20)))
        lbTienMatCheck.text = "Tiền mặt"
        lbTienMatCheck.textColor = UIColor.black
        lbTienMatCheck.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbTienMatCheck)
        
        let imgThe = UIImageView(frame: CGRect(x: lbTienMatCheck.frame.origin.x + lbTienMatCheck.frame.width, y: lbTienMatCheck.frame.origin.y, width: Common.Size(s: 20), height: Common.Size(s: 20)))
        imgThe.image = #imageLiteral(resourceName: "check-2")
        imgThe.contentMode = .scaleAspectFit
        scrollView.addSubview(imgThe)
        
        let lbTheCheck = UILabel(frame: CGRect(x: imgThe.frame.origin.x + imgThe.frame.width + Common.Size(s: 5), y: imgThe.frame.origin.y, width: (scrollView.frame.size.width/2) - Common.Size(s: 35), height: Common.Size(s: 20)))
        lbTheCheck.text = "Thẻ"
        lbTheCheck.textColor = UIColor.black
        lbTheCheck.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbTheCheck)
        
        let imgXuatHD = UIImageView(frame: CGRect(x: imgTienMat.frame.origin.x, y: lbTienMatCheck.frame.origin.y + lbTienMatCheck.frame.height + Common.Size(s: 10), width: Common.Size(s: 20), height: Common.Size(s: 20)))
        imgXuatHD.image = #imageLiteral(resourceName: "check-2")
        imgXuatHD.contentMode = .scaleAspectFit
        scrollView.addSubview(imgXuatHD)
        
        if so?.Is_HDCty == 1 {
        imgXuatHD.image = #imageLiteral(resourceName: "check-1")
        } else {
            imgXuatHD.image = #imageLiteral(resourceName: "check-2")
        }
        
        let lbXuatHD = UILabel(frame: CGRect(x: imgXuatHD.frame.origin.x + imgXuatHD.frame.width + Common.Size(s: 5), y: imgXuatHD.frame.origin.y, width: (scrollView.frame.size.width) - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbXuatHD.text = "Xuất hoá đơn công ty"
        lbXuatHD.textColor = UIColor.black
        lbXuatHD.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbXuatHD)
        
        let lbTienMat = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbXuatHD.frame.origin.y + lbXuatHD.frame.height + Common.Size(s: 15), width: (scrollView.frame.size.width/2) - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbTienMat.text = "Tiền mặt"
        lbTienMat.textColor = UIColor.lightGray
        lbTienMat.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbTienMat)
        
        let lbTienMatText = UILabel(frame: CGRect(x: lbTienMat.frame.origin.x + lbTienMat.frame.width, y: lbTienMat.frame.origin.y, width: (scrollView.frame.size.width/2) - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbTienMatText.text = "\(Common.convertCurrency(value: so?.Tong_TienMat ?? 0))"
        lbTienMatText.textColor = UIColor(netHex: 0xcc0c2f)
        lbTienMatText.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        lbTienMatText.textAlignment = .right
        scrollView.addSubview(lbTienMatText)
        
        if (so?.Tong_TienMat ?? 0) > 0 {
            imgTienMat.image = #imageLiteral(resourceName: "check-1")
            lbTienMat.isHidden = false
            lbTienMatText.isHidden = false
            lbTienMat.frame = CGRect(x: lbTienMat.frame.origin.x, y: lbXuatHD.frame.origin.y + lbXuatHD.frame.height + Common.Size(s: 15), width: lbTienMat.frame.width, height: Common.Size(s: 20))
            lbTienMatText.frame = CGRect(x: lbTienMatText.frame.origin.x, y: lbXuatHD.frame.origin.y + lbXuatHD.frame.height + Common.Size(s: 15), width: lbTienMatText.frame.width, height: Common.Size(s: 20))
        } else {
            imgTienMat.image = #imageLiteral(resourceName: "check-2")
            lbTienMat.isHidden = true
            lbTienMatText.isHidden = true
            lbTienMat.frame = CGRect(x: lbTienMat.frame.origin.x, y: lbXuatHD.frame.origin.y + lbXuatHD.frame.height + Common.Size(s: 15), width: lbTienMat.frame.width, height: 0)
            lbTienMatText.frame = CGRect(x: lbTienMatText.frame.origin.x, y: lbXuatHD.frame.origin.y + lbXuatHD.frame.height + Common.Size(s: 15), width: lbTienMatText.frame.width, height: 0)
        }
        
        let lbThe = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTienMatText.frame.origin.y + lbTienMatText.frame.height, width: (scrollView.frame.size.width/2) - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbThe.text = "Thẻ"
        lbThe.textColor = UIColor.lightGray
        lbThe.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbThe)
        
        let lbTheText = UILabel(frame: CGRect(x: lbThe.frame.origin.x + lbThe.frame.width, y: lbThe.frame.origin.y, width: (scrollView.frame.size.width/2) - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbTheText.text = "\(Common.convertCurrency(value: so?.Tong_The ?? 0))"
        lbTheText.textColor = UIColor(netHex: 0xcc0c2f)
        lbTheText.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        lbTheText.textAlignment = .right
        scrollView.addSubview(lbTheText)
        
        if (so?.Tong_The ?? 0) > 0 {
            imgThe.image = #imageLiteral(resourceName: "check-1")
            lbThe.isHidden = false
            lbTheText.isHidden = false
            lbThe.frame = CGRect(x: lbThe.frame.origin.x, y: lbThe.frame.origin.y, width: lbThe.frame.width, height: Common.Size(s: 20))
            lbTheText.frame = CGRect(x: lbTheText.frame.origin.x, y: lbTheText.frame.origin.y, width: lbTheText.frame.width, height: Common.Size(s: 20))
        } else {
            imgThe.image = #imageLiteral(resourceName: "check-2")
            lbThe.isHidden = false
            lbTheText.isHidden = false
            lbThe.frame = CGRect(x: lbThe.frame.origin.x, y: lbThe.frame.origin.y, width: lbThe.frame.width, height: 0)
            lbTheText.frame = CGRect(x: lbTheText.frame.origin.x, y: lbTheText.frame.origin.y, width: lbTheText.frame.width, height: 0)
        }
        
        let viewTTThanhToan = UIView(frame: CGRect(x: 0, y: lbTheText.frame.origin.y + lbTheText.frame.height + Common.Size(s: 5), width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewTTThanhToan.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView.addSubview(viewTTThanhToan)

        let lbTTThanhToan = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewTTThanhToan.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbTTThanhToan.text = "THÔNG TIN THANH TOÁN"
        lbTTThanhToan.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 15))
        lbTTThanhToan.textColor = UIColor(netHex: 0x109e59)
        viewTTThanhToan.addSubview(lbTTThanhToan)

        let lbTongTien = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewTTThanhToan.frame.origin.y + viewTTThanhToan.frame.height + Common.Size(s: 5), width: (scrollView.frame.size.width/2) - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbTongTien.text = "Tổng tiền"
        lbTongTien.textColor = UIColor.lightGray
        lbTongTien.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbTongTien)

        let lbTongTienText = UILabel(frame: CGRect(x: lbTongTien.frame.origin.x + lbTongTien.frame.width, y: lbTongTien.frame.origin.y, width: lbTongTien.frame.size.width, height: Common.Size(s: 20)))
        lbTongTienText.text = "\(Common.convertCurrency(value: so?.TongTienKhongPhi ?? 0))"
        lbTongTienText.textColor = UIColor(netHex: 0xcc0c2f)
        lbTongTienText.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        lbTongTienText.textAlignment = .right
        scrollView.addSubview(lbTongTienText)

        let lbGiamGia = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTongTienText.frame.origin.y + lbTongTienText.frame.height , width: lbTongTien.frame.size.width, height: Common.Size(s: 20)))
        lbGiamGia.text = "Giảm giá"
        lbGiamGia.textColor = UIColor.lightGray
        lbGiamGia.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbGiamGia)

        let lbGiamGiaText = UILabel(frame: CGRect(x: lbGiamGia.frame.origin.x + lbGiamGia.frame.width, y: lbGiamGia.frame.origin.y, width: lbTongTienText.frame.size.width, height: Common.Size(s: 20)))
        lbGiamGiaText.text = "\(Common.convertCurrency(value: so?.TongTienPhi ?? 0))"
        lbGiamGiaText.textColor = UIColor(netHex: 0xcc0c2f)
        lbGiamGiaText.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        lbGiamGiaText.textAlignment = .right
        scrollView.addSubview(lbGiamGiaText)

        let lbTongTienTT = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbGiamGiaText.frame.origin.y + lbGiamGiaText.frame.height , width: lbTongTien.frame.size.width, height: Common.Size(s: 20)))
        lbTongTienTT.text = "Tổng tiền thanh toán"
        lbTongTienTT.textColor = UIColor.lightGray
        lbTongTienTT.numberOfLines = 2
        lbTongTienTT.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        scrollView.addSubview(lbTongTienTT)

        let lbTongTienTTText = UILabel(frame: CGRect(x: lbTongTienTT.frame.origin.x + lbTongTienTT.frame.width, y: lbTongTienTT.frame.origin.y, width: lbTongTienText.frame.size.width, height: Common.Size(s: 20)))
        lbTongTienTTText.textColor = UIColor(netHex: 0xcc0c2f)
        lbTongTienTTText.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        lbTongTienTTText.textAlignment = .right
        scrollView.addSubview(lbTongTienTTText)
        
        let totalPayValue = (so?.TongTienDaThu ?? 0)
        lbTongTienTTText.text = "\(Common.convertCurrency(value: totalPayValue))"

        let btnPrint = UIButton(frame: CGRect(x: Common.Size(s: 15), y: lbTongTienTTText.frame.origin.y + lbTongTienTTText.frame.height + Common.Size(s: 15), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 35)))
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

        let moneyString:String = "\(so!.ExpiredCard)"
        let printBillCard = PrintBillCard(Address:"\(Cache.user!.Address)", CardType: "\(so!.NhaMang)", FaceValue:"\(so!.MenhGia)", NumberCode:"\(so!.NumberCode)", Serial: "\(so!.SerialCard)", ExpirationDate:"\(moneyString)", ExportTime:"\(so!.CreatedDateTime)", SaleOrderCode:"\(so!.MPOS)", UserCode:"\(Cache.user!.UserName)", MaVoucher: "\(so!.U_Voucher)", HanSuDung: "")
        MPOSAPIManager.pushBillCard(printBill: printBillCard)
        Toast(text: "Đã gửi lệnh in!").show()

        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
