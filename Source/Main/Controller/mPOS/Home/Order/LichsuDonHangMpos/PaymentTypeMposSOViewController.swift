//
//  PaymentTypeMposSOViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 7/22/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class PaymentTypeMposSOViewController: UIViewController {
    
    var parentNavigationController : UINavigationController?
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var so: SOHeader?
    var rsLine_VC_NoPrice:[Line_VC_NoPrice] = []
    var rsLineProduct:[LineProduct] = []
    var rsLinePromos:[LinePromos] = []
    var rsLineORCT:[LineORCT] = []
    var rsLineVoucher:[LineVoucher] = []
    var itemORCT:LineORCT?
    var totalDh:Float = 0
    var totalPromos:Float = 0
    var totalPayemt:Float = 0
    
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
                    if rsLineProduct.count > 0 {
                        self.totalPromos = rsLineProduct.reduce(0, {$0 + $1.U_DisOther}) + rsLineProduct.reduce(0, {$0 + $1.U_discount})
//                        rsLineProduct.forEach { (itemLineProduct) in
//                            self.totalDh = self.totalDh + (itemLineProduct.Price * Float(itemLineProduct.Quantity))
//                        }
                    }
                    if rsLineORCT.count > 0 {
                        let sumU_MoCash = rsLineORCT.reduce(0, {$0 + $1.U_MoCash})
                        let sumU_MoCCad = rsLineORCT.reduce(0, {$0 + $1.U_MoCCad})
                        let sumU_MoQRCode = rsLineORCT.reduce(0, {$0 + $1.U_MoQRCode})
                        let sumU_MoVoCh = rsLineORCT.reduce(0, {$0 + $1.U_MoVoCh})
                        self.totalPayemt = sumU_MoCash + sumU_MoCCad + sumU_MoQRCode + sumU_MoVoCh
                    }
                    
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
        
        let viewVCThanhToan = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewVCThanhToan.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        scrollView.addSubview(viewVCThanhToan)
        
        let lbVCThanhToan = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewVCThanhToan.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbVCThanhToan.text = "VOUVHER THANH TOÁN"
        lbVCThanhToan.font = UIFont.boldSystemFont(ofSize: 15)
        lbVCThanhToan.textColor = UIColor(netHex: 0x109e59)
        viewVCThanhToan.addSubview(lbVCThanhToan)
        
        let viewVCThanhToanContent = UIView(frame: CGRect(x: 0, y: viewVCThanhToan.frame.origin.y + viewVCThanhToan.frame.height , width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewVCThanhToanContent.backgroundColor = UIColor.white
        scrollView.addSubview(viewVCThanhToanContent)
        
        var viewVCThanhToanContentHeight:CGFloat = 0
        for i in 0..<self.rsLineVoucher.count {
            let item = self.rsLineVoucher[i]
            
            let viewVC = UIView(frame: CGRect(x: 0, y: viewVCThanhToanContentHeight, width: viewVCThanhToanContent.frame.width, height: Common.Size(s: 70)))
            viewVC.backgroundColor = .white
            viewVCThanhToanContent.addSubview(viewVC)
            
            let lbSTT = UILabel(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: Common.Size(s: 30), height: Common.Size(s: 20)))
            lbSTT.text = "\(i + 1)"
            lbSTT.textAlignment = .center
            lbSTT.font = UIFont.systemFont(ofSize: 14)
            viewVC.addSubview(lbSTT)
            
            let lbVCNumber = UILabel(frame: CGRect(x: lbSTT.frame.origin.x + lbSTT.frame.width + Common.Size(s: 11), y: Common.Size(s: 5), width: viewVC.frame.width - Common.Size(s: 61), height: Common.Size(s: 15)))
            lbVCNumber.text = "\(item.U_NumVouhcer)"
            lbVCNumber.font = UIFont.boldSystemFont(ofSize: 14)
            viewVC.addSubview(lbVCNumber)
            
            let lbVCName = UILabel(frame: CGRect(x: lbVCNumber.frame.origin.x, y: lbVCNumber.frame.origin.y + lbVCNumber.frame.height + Common.Size(s: 5), width: lbVCNumber.frame.width, height: Common.Size(s: 15)))
            lbVCName.text = "\(item.U_NameVouhcer)"
            lbVCName.font = UIFont.systemFont(ofSize: 14)
            viewVC.addSubview(lbVCName)
            
            let lbVCNameHeight:CGFloat = lbVCName.optimalHeight < Common.Size(s: 15) ? Common.Size(s: 15) : lbVCName.optimalHeight
            lbVCName.numberOfLines = 0
            lbVCName.frame = CGRect(x: lbVCName.frame.origin.x, y: lbVCName.frame.origin.y, width: lbVCName.frame.width, height: lbVCNameHeight)
            
            let lbVCPrice = UILabel(frame: CGRect(x: lbVCNumber.frame.origin.x, y: lbVCName.frame.origin.y + lbVCNameHeight + Common.Size(s: 5), width: lbVCNumber.frame.width, height: Common.Size(s: 20)))
            lbVCPrice.text = "\(Common.convertCurrencyDoubleV2(value: item.U_MoVoCh))VNĐ"
            lbVCPrice.font = UIFont.systemFont(ofSize: 14)
            lbVCPrice.textColor = UIColor(netHex: 0xcc0c2f)
            viewVC.addSubview(lbVCPrice)
            
            viewVC.frame = CGRect(x: viewVC.frame.origin.x, y: viewVC.frame.origin.y, width: viewVC.frame.width, height: lbVCPrice.frame.origin.y + lbVCPrice.frame.height + Common.Size(s: 5))
            
            let line = UIView(frame: CGRect(x: lbSTT.frame.origin.x + lbSTT.frame.width, y: Common.Size(s: 10), width: Common.Size(s: 1), height: viewVC.frame.height - Common.Size(s: 10)))
            line.backgroundColor = UIColor(red: 67/255, green: 135/255, blue: 107/255, alpha: 1)
            viewVC.addSubview(line)
            
            let line2 = UIView(frame: CGRect(x: 0, y: viewVC.frame.origin.y + viewVC.frame.height - Common.Size(s: 1), width: viewVC.frame.width, height: Common.Size(s: 1)))
            line2.backgroundColor = UIColor(red: 67/255, green: 135/255, blue: 107/255, alpha: 1)
            viewVC.addSubview(line2)
            
            viewVCThanhToanContentHeight = viewVCThanhToanContentHeight + viewVC.frame.height
        }
        viewVCThanhToanContent.frame = CGRect(x: viewVCThanhToanContent.frame.origin.x, y: viewVCThanhToanContent.frame.origin.y, width: viewVCThanhToanContent.frame.width, height: viewVCThanhToanContentHeight)
        
        if self.rsLineVoucher.count > 0 {
            viewVCThanhToan.frame = CGRect(x: viewVCThanhToan.frame.origin.x, y: viewVCThanhToan.frame.origin.y, width: viewVCThanhToan.frame.width, height: Common.Size(s: 40))
            viewVCThanhToanContent.frame = CGRect(x: viewVCThanhToanContent.frame.origin.x, y: viewVCThanhToan.frame.origin.y + viewVCThanhToan.frame.height, width: viewVCThanhToanContent.frame.width, height: viewVCThanhToanContentHeight)
        } else {
            viewVCThanhToan.frame = CGRect(x: viewVCThanhToan.frame.origin.x, y: viewVCThanhToan.frame.origin.y, width: viewVCThanhToan.frame.width, height: 0)
            viewVCThanhToanContent.frame = CGRect(x: viewVCThanhToanContent.frame.origin.x, y: viewVCThanhToan.frame.origin.y + viewVCThanhToan.frame.height, width: viewVCThanhToanContent.frame.width, height: 0)
        }
        
        let viewHinhThucThanhToan = UIView(frame: CGRect(x: 0, y: viewVCThanhToanContent.frame.origin.y + viewVCThanhToanContent.frame.height + Common.Size(s: 5), width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewHinhThucThanhToan.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        scrollView.addSubview(viewHinhThucThanhToan)
        
        let lbHinhThucThanhToan = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewHinhThucThanhToan.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbHinhThucThanhToan.text = "HÌNH THỨC THANH TOÁN"
        lbHinhThucThanhToan.font = UIFont.boldSystemFont(ofSize: 15)
        lbHinhThucThanhToan.textColor = UIColor(netHex: 0x109e59)
        viewHinhThucThanhToan.addSubview(lbHinhThucThanhToan)
        
        let imgPayment = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: viewHinhThucThanhToan.frame.origin.y + viewHinhThucThanhToan.frame.height + Common.Size(s: 5), width: Common.Size(s: 70), height: Common.Size(s: 40)))
        imgPayment.contentMode = .scaleAspectFit
        scrollView.addSubview(imgPayment)
        
        if self.rsLineORCT.count > 0 {
            self.itemORCT = self.rsLineORCT[0]
            if self.rsLineORCT[0].electronic_wallet.isEmpty {
                imgPayment.frame = CGRect(x: imgPayment.frame.origin.x, y: imgPayment.frame.origin.y, width: imgPayment.frame.width, height: 0)
            } else {
                imgPayment.frame = CGRect(x: imgPayment.frame.origin.x, y: imgPayment.frame.origin.y, width: imgPayment.frame.width, height: Common.Size(s: 40))
                switch self.rsLineORCT[0].electronic_wallet {
                case "MOCA":
                    imgPayment.image = #imageLiteral(resourceName: "Moca_1")
                    break
                case "VNPAY":
                    imgPayment.image = #imageLiteral(resourceName: "vnpay")
                    break
                case "SMART PAY":
                    imgPayment.image = #imageLiteral(resourceName: "SmartPayIcon")
                    break
                default:
                    imgPayment.frame = CGRect(x: imgPayment.frame.origin.x, y: imgPayment.frame.origin.y, width: imgPayment.frame.width, height: 0)
                    break
                }
            }
        }
        let lbTienMat = UILabel(frame: CGRect(x: Common.Size(s: 15), y: imgPayment.frame.origin.y + imgPayment.frame.height + Common.Size(s: 5), width: (scrollView.frame.width - Common.Size(s: 30))/3 + Common.Size(s: 8), height: Common.Size(s: 20)))
        lbTienMat.text = "Tiền mặt"
        lbTienMat.font = UIFont.systemFont(ofSize: 14)
        lbTienMat.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbTienMat)
        
        let lbTienMatText = UILabel(frame: CGRect(x: lbTienMat.frame.origin.x + lbTienMat.frame.width, y: lbTienMat.frame.origin.y, width: ((scrollView.frame.width - Common.Size(s: 30)) * 2/3) - Common.Size(s: 8), height: Common.Size(s: 20)))
        lbTienMatText.text = "\(Common.convertCurrencyDouble(value: Double(self.itemORCT?.U_MoCash ?? 0)))đ"
        lbTienMatText.font = UIFont.systemFont(ofSize: 14)
        lbTienMatText.textAlignment = .right
        lbTienMatText.textColor = UIColor(netHex: 0x109e59)
        scrollView.addSubview(lbTienMatText)
        
        let lbThe = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTienMatText.frame.origin.y + lbTienMatText.frame.height, width: lbTienMat.frame.width, height: Common.Size(s: 20)))
        lbThe.text = "Thẻ"
        lbThe.font = UIFont.systemFont(ofSize: 14)
        lbThe.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbThe)
        
        let lbTheText = UILabel(frame: CGRect(x: lbThe.frame.origin.x + lbThe.frame.width, y: lbThe.frame.origin.y, width: lbTienMatText.frame.width, height: Common.Size(s: 20)))
        lbTheText.text = "\(Common.convertCurrencyDouble(value: Double(self.itemORCT?.U_MoCCad ?? 0)))đ"
        lbTheText.font = UIFont.systemFont(ofSize: 14)
        lbTheText.textAlignment = .right
        lbTheText.textColor = UIColor(netHex: 0x109e59)
        scrollView.addSubview(lbTheText)
        
        let lbViDienTu = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTheText.frame.origin.y + lbTheText.frame.height, width: lbTienMat.frame.width, height: Common.Size(s: 20)))
        lbViDienTu.text = "Ví điện tử"
        lbViDienTu.font = UIFont.systemFont(ofSize: 14)
        lbViDienTu.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbViDienTu)
        
        let lbViDienTuText = UILabel(frame: CGRect(x: lbViDienTu.frame.origin.x + lbViDienTu.frame.width, y: lbViDienTu.frame.origin.y, width: lbTienMatText.frame.width, height: Common.Size(s: 20)))
        lbViDienTuText.text = "\(Common.convertCurrencyDouble(value: Double(self.itemORCT?.U_MoQRCode ?? 0)))đ"
        lbViDienTuText.font = UIFont.systemFont(ofSize: 14)
        lbViDienTuText.textAlignment = .right
        lbViDienTuText.textColor = UIColor(netHex: 0x109e59)
        scrollView.addSubview(lbViDienTuText)
        
        let lbVoucher = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbViDienTuText.frame.origin.y + lbViDienTuText.frame.height, width: lbTienMat.frame.width, height: Common.Size(s: 20)))
        lbVoucher.text = "Voucher"
        lbVoucher.font = UIFont.systemFont(ofSize: 14)
        lbVoucher.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbVoucher)
        
        let lbVoucherText = UILabel(frame: CGRect(x: lbVoucher.frame.origin.x + lbVoucher.frame.width, y: lbVoucher.frame.origin.y, width: lbTienMatText.frame.width, height: Common.Size(s: 20)))
        lbVoucherText.text = "\(Common.convertCurrencyDouble(value: Double(self.itemORCT?.U_MoVoCh ?? 0)))đ"
        lbVoucherText.font = UIFont.systemFont(ofSize: 14)
        lbVoucherText.textAlignment = .right
        lbVoucherText.textColor = UIColor(netHex: 0x109e59)
        scrollView.addSubview(lbVoucherText)
        
        //THONG TIN THANH TOAN
        let viewThongTinThanhToan = UIView(frame: CGRect(x: 0, y: lbVoucherText.frame.origin.y + lbVoucherText.frame.height + Common.Size(s: 5), width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewThongTinThanhToan.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        scrollView.addSubview(viewThongTinThanhToan)
        
        let lbThongTinThanhToan = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewThongTinThanhToan.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbThongTinThanhToan.text = "THÔNG TIN THANH TOÁN"
        lbThongTinThanhToan.font = UIFont.boldSystemFont(ofSize: 15)
        lbThongTinThanhToan.textColor = UIColor(netHex: 0x109e59)
        viewThongTinThanhToan.addSubview(lbThongTinThanhToan)
        
        let lbTongDH = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewThongTinThanhToan.frame.origin.y + viewThongTinThanhToan.frame.height + Common.Size(s: 5), width: lbTienMat.frame.width, height: Common.Size(s: 20)))
        lbTongDH.text = "Tổng đơn hàng:"
        lbTongDH.font = UIFont.systemFont(ofSize: 14)
        lbTongDH.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbTongDH)
        
        let lbTongDHText = UILabel(frame: CGRect(x: lbTongDH.frame.origin.x + lbTongDH.frame.width, y: lbTongDH.frame.origin.y, width: lbTienMatText.frame.width, height: Common.Size(s: 20)))
        let totalPrice = self.totalPromos + (so?.U_TMonBi ?? 0)
        lbTongDHText.text = "\(Common.convertCurrencyFloat(value: totalPrice))"
        lbTongDHText.font = UIFont.systemFont(ofSize: 14)
        lbTongDHText.textAlignment = .right
        lbTongDHText.textColor = UIColor(netHex: 0xcc0c2f)
        scrollView.addSubview(lbTongDHText)
        
        let lbThanhToanOnline = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTongDHText.frame.origin.y + lbTongDHText.frame.height, width: lbTienMat.frame.width, height: Common.Size(s: 20)))
        lbThanhToanOnline.text = "Thanh toán online:"
        lbThanhToanOnline.font = UIFont.systemFont(ofSize: 14)
        lbThanhToanOnline.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbThanhToanOnline)
        
        let lbThanhToanOnlineText = UILabel(frame: CGRect(x: lbThanhToanOnline.frame.origin.x + lbThanhToanOnline.frame.width, y: lbThanhToanOnline.frame.origin.y, width: lbTienMatText.frame.width, height: Common.Size(s: 20)))
        lbThanhToanOnlineText.text = "\(Common.convertCurrencyFloat(value: so?.Downpayment_ecom ?? 0))"
        lbThanhToanOnlineText.font = UIFont.systemFont(ofSize: 14)
        lbThanhToanOnlineText.textAlignment = .right
        lbThanhToanOnlineText.textColor = UIColor(netHex: 0xcc0c2f)
        scrollView.addSubview(lbThanhToanOnlineText)
        
        let lbKhoanVay = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbThanhToanOnlineText.frame.origin.y + lbThanhToanOnlineText.frame.height, width: lbTienMat.frame.width, height: Common.Size(s: 20)))
        lbKhoanVay.text = "Khoản vay:"
        lbKhoanVay.font = UIFont.systemFont(ofSize: 14)
        lbKhoanVay.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbKhoanVay)
        
        let lbKhoanVayText = UILabel(frame: CGRect(x: lbKhoanVay.frame.origin.x + lbKhoanVay.frame.width, y: lbKhoanVay.frame.origin.y, width: lbTienMatText.frame.width, height: Common.Size(s: 20)))
        lbKhoanVayText.text = "\(Common.convertCurrency(value: so?.LoanAmount ?? 0))"
        lbKhoanVayText.font = UIFont.systemFont(ofSize: 14)
        lbKhoanVayText.textAlignment = .right
        lbKhoanVayText.textColor = UIColor(netHex: 0xcc0c2f)
        scrollView.addSubview(lbKhoanVayText)
        
        let lbGiamGia = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbKhoanVayText.frame.origin.y + lbKhoanVayText.frame.height, width: lbTienMat.frame.width, height: Common.Size(s: 20)))
        lbGiamGia.text = "Giảm giá:"
        lbGiamGia.font = UIFont.systemFont(ofSize: 14)
        lbGiamGia.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbGiamGia)
        
        let lbGiamGiaText = UILabel(frame: CGRect(x: lbGiamGia.frame.origin.x + lbGiamGia.frame.width, y: lbGiamGia.frame.origin.y, width: lbTienMatText.frame.width, height: Common.Size(s: 20)))
        lbGiamGiaText.text = "\(Common.convertCurrencyFloat(value: self.totalPromos))"
        lbGiamGiaText.font = UIFont.systemFont(ofSize: 14)
        lbGiamGiaText.textAlignment = .right
        lbGiamGiaText.textColor = UIColor(netHex: 0xcc0c2f)
        scrollView.addSubview(lbGiamGiaText)
        
        let lbThanhToan = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbGiamGiaText.frame.origin.y + lbGiamGiaText.frame.height + Common.Size(s: 5), width: lbTienMat.frame.width, height: Common.Size(s: 20)))
        lbThanhToan.text = "Thanh toán:"
        lbThanhToan.font = UIFont.systemFont(ofSize: 16)
        lbThanhToan.textColor =  UIColor(red: 72/255, green: 84/255, blue: 97/255, alpha: 1)
        scrollView.addSubview(lbThanhToan)
        
        let lbThanhToanText = UILabel(frame: CGRect(x: lbThanhToan.frame.origin.x + lbThanhToan.frame.width, y: lbThanhToan.frame.origin.y, width: lbTienMatText.frame.width, height: Common.Size(s: 20)))
        lbThanhToanText.text = "\(Common.convertCurrencyFloat(value: self.totalPayemt))"
        lbThanhToanText.font = UIFont.boldSystemFont(ofSize: 16)
        lbThanhToanText.textAlignment = .right
        lbThanhToanText.textColor = UIColor(netHex: 0xcc0c2f)
        scrollView.addSubview(lbThanhToanText)
        
        scrollViewHeight = lbThanhToanText.frame.origin.y + lbThanhToanText.frame.height + Common.Size(s: 50)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
}
