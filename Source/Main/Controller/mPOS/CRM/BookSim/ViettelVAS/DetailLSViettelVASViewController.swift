//
//  DetailLSViettelVASViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 3/19/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DetailLSViettelVASViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Chi tiết gói cước Viettel hiện hữu"
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.view.backgroundColor = .white
        
        let btLeftIcon = Common.initBackButton()
        btLeftIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
        
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
        
        let lbSoMpos = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewCustomerInfo.frame.origin.y + viewCustomerInfo.frame.height + Common.Size(s: 8), width: (scrollView.frame.width - Common.Size(s: 30))/3, height: Common.Size(s: 20)))
        lbSoMpos.text = "Số Mpos:"
        lbSoMpos.font = UIFont.systemFont(ofSize: 14)
        lbSoMpos.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbSoMpos)
        
        let lbSoMposText = UILabel(frame: CGRect(x: lbSoMpos.frame.origin.x + lbSoMpos.frame.width + Common.Size(s: 5), y: lbSoMpos.frame.origin.y, width: (scrollView.frame.width - Common.Size(s: 30)) * 2/3, height: Common.Size(s: 20)))
        lbSoMposText.text = "chua co"
        lbSoMposText.font = UIFont.systemFont(ofSize: 14)
        lbSoMposText.textAlignment = .right
        scrollView.addSubview(lbSoMposText)
        
        let lbSdt = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSoMposText.frame.origin.y + lbSoMposText.frame.height, width: lbSoMpos.frame.width, height: Common.Size(s: 20)))
        lbSdt.text = "SĐT khách hàng:"
        lbSdt.font = UIFont.systemFont(ofSize: 14)
        lbSdt.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbSdt)
        
        let lbSdtText = UILabel(frame: CGRect(x: lbSdt.frame.origin.x + lbSdt.frame.width + Common.Size(s: 5), y: lbSdt.frame.origin.y, width: lbSoMposText.frame.width, height: Common.Size(s: 20)))
        lbSdtText.text = "chua co"
        lbSdtText.font = UIFont.systemFont(ofSize: 14)
        lbSdtText.textAlignment = .right
        scrollView.addSubview(lbSdtText)
        
        let lbGoiCuoc = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSdtText.frame.origin.y + lbSdtText.frame.height, width: lbSoMpos.frame.width, height: Common.Size(s: 20)))
        lbGoiCuoc.text = "Gói cước:"
        lbGoiCuoc.font = UIFont.systemFont(ofSize: 14)
        lbGoiCuoc.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbGoiCuoc)
        
        let lbGoiCuocText = UILabel(frame: CGRect(x: lbGoiCuoc.frame.origin.x + lbGoiCuoc.frame.width + Common.Size(s: 5), y: lbGoiCuoc.frame.origin.y, width: lbSoMposText.frame.width, height: Common.Size(s: 20)))
        lbGoiCuocText.text = "chua co"
        lbGoiCuocText.font = UIFont.systemFont(ofSize: 14)
        lbGoiCuocText.textAlignment = .right
        scrollView.addSubview(lbGoiCuocText)
        
        let lbGiaGoiCuoc = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbGoiCuocText.frame.origin.y + lbGoiCuocText.frame.height, width: lbSoMpos.frame.width, height: Common.Size(s: 20)))
        lbGiaGoiCuoc.text = "Giá gói cước:"
        lbGiaGoiCuoc.font = UIFont.systemFont(ofSize: 14)
        lbGiaGoiCuoc.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbGiaGoiCuoc)
        
        let lbGiaGoiCuocText = UILabel(frame: CGRect(x: lbGiaGoiCuoc.frame.origin.x + lbGiaGoiCuoc.frame.width + Common.Size(s: 5), y: lbGiaGoiCuoc.frame.origin.y, width: lbSoMposText.frame.width, height: Common.Size(s: 20)))
        lbGiaGoiCuocText.text = "chua co"
        lbGiaGoiCuocText.font = UIFont.systemFont(ofSize: 14)
        lbGiaGoiCuocText.textAlignment = .right
        lbGiaGoiCuocText.textColor = .red
        scrollView.addSubview(lbGiaGoiCuocText)
        
        let lbNCC = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbGiaGoiCuocText.frame.origin.y + lbGiaGoiCuocText.frame.height, width: lbSoMpos.frame.width, height: Common.Size(s: 20)))
        lbNCC.text = "Nhà cung cấp:"
        lbNCC.font = UIFont.systemFont(ofSize: 14)
        lbNCC.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbNCC)
        
        let lbNCCText = UILabel(frame: CGRect(x: lbNCC.frame.origin.x + lbNCC.frame.width + Common.Size(s: 5), y: lbNCC.frame.origin.y, width: lbSoMposText.frame.width, height: Common.Size(s: 20)))
        lbNCCText.text = "Viettel"
        lbNCCText.font = UIFont.systemFont(ofSize: 14)
        lbNCCText.textAlignment = .right
        scrollView.addSubview(lbNCCText)
        
        let lbNgayGD = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNCCText.frame.origin.y + lbNCCText.frame.height, width: lbSoMpos.frame.width, height: Common.Size(s: 20)))
        lbNgayGD.text = "Ngày giao dịch:"
        lbNgayGD.font = UIFont.systemFont(ofSize: 14)
        lbNgayGD.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbNgayGD)
        
        let lbNgayGDText = UILabel(frame: CGRect(x: lbNgayGD.frame.origin.x + lbNgayGD.frame.width + Common.Size(s: 5), y: lbNgayGD.frame.origin.y, width: lbSoMposText.frame.width, height: Common.Size(s: 20)))
        lbNgayGDText.text = "chưa có"
        lbNgayGDText.font = UIFont.systemFont(ofSize: 14)
        lbNgayGDText.textAlignment = .right
        scrollView.addSubview(lbNgayGDText)
        
        let lbNVGD = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNgayGDText.frame.origin.y + lbNgayGDText.frame.height, width: lbSoMpos.frame.width, height: Common.Size(s: 20)))
        lbNVGD.text = "NV giao dịch:"
        lbNVGD.font = UIFont.systemFont(ofSize: 14)
        lbNVGD.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbNVGD)
        
        let lbNVGDText = UILabel(frame: CGRect(x: lbNVGD.frame.origin.x + lbNVGD.frame.width + Common.Size(s: 5), y: lbNVGD.frame.origin.y, width: lbSoMposText.frame.width, height: Common.Size(s: 20)))
        lbNVGDText.text = "chưa có"
        lbNVGDText.font = UIFont.systemFont(ofSize: 14)
        lbNVGDText.textAlignment = .right
        scrollView.addSubview(lbNVGDText)
        
        let lbNVGDTextHeight:CGFloat = lbNVGDText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNVGDText.optimalHeight + Common.Size(s: 5))
        lbNVGDText.numberOfLines = 0
        lbNVGDText.frame = CGRect(x: lbNVGDText.frame.origin.x, y: lbNVGDText.frame.origin.y, width: lbNVGDText.frame.width, height: lbNVGDTextHeight)
        
        let lbShop = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNVGDText.frame.origin.y + lbNVGDText.frame.height, width: lbSoMpos.frame.width, height: Common.Size(s: 20)))
        lbShop.text = "Shop:"
        lbShop.font = UIFont.systemFont(ofSize: 14)
        lbShop.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbShop)
        
        let lbShopText = UILabel(frame: CGRect(x: lbShop.frame.origin.x + lbShop.frame.width + Common.Size(s: 5), y: lbShop.frame.origin.y, width: lbSoMposText.frame.width, height: Common.Size(s: 20)))
        lbShopText.text = "chưa có"
        lbShopText.font = UIFont.systemFont(ofSize: 14)
        lbShopText.textAlignment = .right
        scrollView.addSubview(lbShopText)
        
        let lbShopTextHeight:CGFloat = lbShopText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbShopText.optimalHeight + Common.Size(s: 5))
        lbShopText.numberOfLines = 0
        lbShopText.frame = CGRect(x: lbShopText.frame.origin.x, y: lbShopText.frame.origin.y, width: lbShopText.frame.width, height: lbShopTextHeight)
        
        let lbTrangThai = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbShopText.frame.origin.y + lbShopText.frame.height, width: lbSoMpos.frame.width, height: Common.Size(s: 20)))
        lbTrangThai.text = "Trạng thái:"
        lbTrangThai.font = UIFont.systemFont(ofSize: 14)
        lbTrangThai.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbTrangThai)
        
        let lbTrangThaiText = UILabel(frame: CGRect(x: lbTrangThai.frame.origin.x + lbTrangThai.frame.width + Common.Size(s: 5), y: lbTrangThai.frame.origin.y, width: lbSoMposText.frame.width, height: Common.Size(s: 20)))
        lbTrangThaiText.text = "chưa có"
        lbTrangThaiText.font = UIFont.systemFont(ofSize: 14)
        lbTrangThaiText.textAlignment = .right
        scrollView.addSubview(lbTrangThaiText)
        
        let lbTrangThaiTextHeight:CGFloat = lbTrangThaiText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbTrangThaiText.optimalHeight + Common.Size(s: 5))
        lbTrangThaiText.numberOfLines = 0
        lbTrangThaiText.frame = CGRect(x: lbTrangThaiText.frame.origin.x, y: lbTrangThaiText.frame.origin.y, width: lbTrangThaiText.frame.width, height: lbTrangThaiTextHeight)
        
        //HTTT
        let viewHTTT = UIView(frame: CGRect(x: 0, y: lbTrangThaiText.frame.origin.y + lbTrangThaiText.frame.height + Common.Size(s: 5), width: self.view.frame.width, height: Common.Size(s: 40)))
        viewHTTT.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        scrollView.addSubview(viewHTTT)
        
        let lbHTTT = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewHTTT.frame.width - Common.Size(s: 30), height: viewHTTT.frame.height))
        lbHTTT.text = "HÌNH THỨC THANH TOÁN"
        lbHTTT.font = UIFont.boldSystemFont(ofSize: 14)
        lbHTTT.textColor = UIColor(netHex: 0x109e59)
        viewHTTT.addSubview(lbHTTT)
        
        let imgTienMat = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: viewHTTT.frame.origin.y + viewHTTT.frame.height + Common.Size(s: 8), width: Common.Size(s: 15), height: Common.Size(s: 15)))
        imgTienMat.image = #imageLiteral(resourceName: "check-1-1")
        imgTienMat.contentMode = .scaleToFill
        imgTienMat.tag = 1
        scrollView.addSubview(imgTienMat)
        
        let lbTienMat = UILabel(frame: CGRect(x: imgTienMat.frame.origin.x + imgTienMat.frame.width + Common.Size(s: 5), y:  imgTienMat.frame.origin.y - Common.Size(s: 3), width: self.view.frame.width/2 - Common.Size(s: 35), height: Common.Size(s: 20)))
        lbTienMat.text = "Tiền mặt"
        lbTienMat.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbTienMat)
        
        let imgThe = UIImageView(frame: CGRect(x: lbTienMat.frame.origin.x + lbTienMat.frame.width, y: imgTienMat.frame.origin.y, width: Common.Size(s: 15), height: Common.Size(s: 15)))
        imgThe.image = #imageLiteral(resourceName: "check-2-1")
        imgThe.contentMode = .scaleToFill
        imgThe.tag = 2
        scrollView.addSubview(imgThe)
        
        let lbThe = UILabel(frame: CGRect(x: imgThe.frame.origin.x + imgThe.frame.width + Common.Size(s: 5), y:  imgThe.frame.origin.y - Common.Size(s: 3), width: lbTienMat.frame.width, height: Common.Size(s: 20)))
        lbThe.text = "Thẻ"
        lbThe.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbThe)
        
        let lbTMText = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbThe.frame.origin.y + lbThe.frame.height + Common.Size(s: 8), width: lbSoMpos.frame.width, height: Common.Size(s: 20)))
        lbTMText.text = "Tiền mặt:"
        lbTMText.font = UIFont.systemFont(ofSize: 14)
        lbTMText.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbTMText)
        
        let lbTMTextValue = UILabel(frame: CGRect(x: lbTMText.frame.origin.x + lbTMText.frame.width + Common.Size(s: 5), y: lbTMText.frame.origin.y, width: lbSoMposText.frame.width, height: Common.Size(s: 20)))
        lbTMTextValue.text = "chưa có"
        lbTMTextValue.font = UIFont.boldSystemFont(ofSize: 14)
        lbTMTextValue.textAlignment = .right
        scrollView.addSubview(lbTMTextValue)
        
        let lbTheText = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTMTextValue.frame.origin.y + lbTMTextValue.frame.height, width: lbSoMpos.frame.width, height: Common.Size(s: 20)))
        lbTheText.text = "Thẻ:"
        lbTheText.font = UIFont.systemFont(ofSize: 14)
        lbTheText.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbTheText)
        
        let lbTheTextValue = UILabel(frame: CGRect(x: lbTheText.frame.origin.x + lbTheText.frame.width + Common.Size(s: 5), y: lbTheText.frame.origin.y, width: lbSoMposText.frame.width, height: Common.Size(s: 20)))
        lbTheTextValue.text = "chưa có"
        lbTheTextValue.font = UIFont.boldSystemFont(ofSize: 14)
        lbTheTextValue.textAlignment = .right
        scrollView.addSubview(lbTheTextValue)
        
        //TTTT
        let viewTTTT = UIView(frame: CGRect(x: 0, y: lbTheTextValue.frame.origin.y + lbTheTextValue.frame.height + Common.Size(s: 5), width: self.view.frame.width, height: Common.Size(s: 40)))
        viewTTTT.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        scrollView.addSubview(viewTTTT)
        
        let lbTTTT = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewTTTT.frame.width - Common.Size(s: 30), height: viewHTTT.frame.height))
        lbTTTT.text = "THÔNG TIN THANH TOÁN"
        lbTTTT.font = UIFont.boldSystemFont(ofSize: 14)
        lbTTTT.textColor = UIColor(netHex: 0x109e59)
        viewTTTT.addSubview(lbTTTT)
        
        let lbTongTien = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewTTTT.frame.origin.y + viewTTTT.frame.height + Common.Size(s: 8), width: lbSoMpos.frame.width, height: Common.Size(s: 20)))
        lbTongTien.text = "Tổng tiền:"
        lbTongTien.font = UIFont.systemFont(ofSize: 14)
        lbTongTien.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbTongTien)
        
        let lbTongTienText = UILabel(frame: CGRect(x: lbTongTien.frame.origin.x + lbTongTien.frame.width + Common.Size(s: 5), y: lbTongTien.frame.origin.y, width: lbSoMposText.frame.width, height: Common.Size(s: 20)))
        lbTongTienText.text = "chưa có"
        lbTongTienText.font = UIFont.boldSystemFont(ofSize: 14)
        lbTongTienText.textAlignment = .right
        lbTongTienText.textColor = .red
        scrollView.addSubview(lbTongTienText)
        
        let btnPrint = UIButton(frame: CGRect(x: Common.Size(s: 15), y: lbTongTienText.frame.origin.y + lbTongTienText.frame.height + Common.Size(s: 15), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        btnPrint.backgroundColor = UIColor(netHex: 0x109e59)
        btnPrint.setTitle("IN PHIẾU", for: .normal)
        btnPrint.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btnPrint.layer.cornerRadius = 5
        btnPrint.addTarget(self, action: #selector(payAction(_:)), for: .touchUpInside)
        scrollView.addSubview(btnPrint)
        
        scrollViewHeight = btnPrint.frame.origin.y + btnPrint.frame.height + Common.Size(s: 30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    @objc func handleBack(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func payAction(_ sender:UITapGestureRecognizer){

//        let moneyString:String = "\(so!.ExpiredCard)"
//        let printBillCard = PrintBillCard(Address:"\(Cache.user!.Address)", CardType: "\(so!.NhaMang)", FaceValue:"\(so!.MenhGia)", NumberCode:"\(so!.NumberCode)", Serial: "\(so!.SerialCard)", ExpirationDate:"\(moneyString)", ExportTime:"\(so!.CreatedDateTime)", SaleOrderCode:"\(so!.MPOS)", UserCode:"\(Cache.user!.UserName)", MaVoucher: "\(so!.U_Voucher)", HanSuDung: "")
//        MPOSAPIManager.pushBillCard(printBill: printBillCard)
//        Toast(text: "Đã gửi lệnh in!").show()
//
//        self.navigationController?.popViewController(animated: true)
    }
}
