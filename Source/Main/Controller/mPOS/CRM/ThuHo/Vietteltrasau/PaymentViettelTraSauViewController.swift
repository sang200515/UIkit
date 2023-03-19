//
//  PaymentViettelTraSauViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 8/12/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Toaster

class PaymentViettelTraSauViewController: UIViewController {
    
    var scrollView:UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var itemViettelTSPayTeleCharge: GetPayTeleChargeViettelTS?
    var tenKH = ""
    var totalCash = "0"
    var totalCredict = "0"
    var sdtLienHe = ""
    var phiCathe:Double = 0
    var phiThuHo:Double = 0
    var thuHoService: ThuHoService?
    var thuHoProvider: ThuHoProvider?
    var itemTheThanhToan:CardTypeFromPOSResult?
    var isDKUyQuyen = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Thanh toán thành công"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: scrollView.frame.size.height)
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        let viewTTThanhToan = UIScrollView(frame: CGRect(x: 0, y:0, width: scrollView.frame.size.width, height:  Common.Size(s: 40)))
        viewTTThanhToan.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView.addSubview(viewTTThanhToan)
        
        let lbTTTT = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbTTTT.text = "THÔNG TIN THANH TOÁN"
        lbTTTT.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 15))
        lbTTTT.textColor = UIColor(netHex: 0x109e59)
        viewTTThanhToan.addSubview(lbTTTT)
        
        let lbTenKH = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewTTThanhToan.frame.origin.y + viewTTThanhToan.frame.height + Common.Size(s: 5), width: (scrollView.frame.width - Common.Size(s: 30))/3 + Common.Size(s: 10), height: Common.Size(s: 20)))
        lbTenKH.text = "Tên khách hàng:"
        lbTenKH.textColor = UIColor.lightGray
        lbTenKH.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbTenKH)
        
        let lbTenKHText = UILabel(frame: CGRect(x: lbTenKH.frame.size.width + lbTenKH.frame.origin.x + Common.Size(s: 5), y: lbTenKH.frame.origin.y, width: (scrollView.frame.width - Common.Size(s: 30)) * 2/3 - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbTenKHText.text = "\(self.tenKH)"
        lbTenKHText.textColor = UIColor.black
        lbTenKHText.textAlignment = .right
        lbTenKHText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbTenKHText)
        
        let lbTenKHTextHeight:CGFloat = lbTenKHText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbTenKHText.optimalHeight + Common.Size(s: 5))
        lbTenKHText.numberOfLines = 0
        lbTenKHText.frame = CGRect(x: lbTenKHText.frame.origin.x, y: lbTenKHText.frame.origin.y, width: lbTenKHText.frame.width, height: lbTenKHTextHeight)
        
        let lbSdt = UILabel(frame: CGRect(x: lbTenKH.frame.origin.x, y: lbTenKHText.frame.origin.y + lbTenKHTextHeight, width: lbTenKH.frame.size.width, height: Common.Size(s: 20)))
        lbSdt.text = "Số điện thoại:"
        lbSdt.textColor = UIColor.lightGray
        lbSdt.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbSdt)

        let lbSdtText = UILabel(frame: CGRect(x: lbTenKHText.frame.origin.x, y: lbSdt.frame.origin.y, width: lbTenKHText.frame.width, height: Common.Size(s: 20)))
        lbSdtText.text = "\(self.sdtLienHe)"
        lbSdtText.textColor = UIColor.black
        lbSdtText.textAlignment = .right
        lbSdtText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbSdtText)
        
        let lbMaHD = UILabel(frame: CGRect(x: lbTenKH.frame.origin.x, y: lbSdtText.frame.origin.y + lbSdtText.frame.height, width: lbTenKH.frame.size.width, height: Common.Size(s: 20)))
        lbMaHD.text = "Mã hợp đồng:"
        lbMaHD.textColor = UIColor.lightGray
        lbMaHD.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbMaHD)
        
        if self.isDKUyQuyen {
            lbSdt.isHidden = false
            lbSdtText.isHidden = false
            lbMaHD.frame = CGRect(x: lbMaHD.frame.origin.x, y: lbSdtText.frame.origin.y + lbSdtText.frame.height, width: lbMaHD.frame.size.width, height: lbMaHD.frame.height)
        } else {
            lbSdt.isHidden = true
            lbSdtText.isHidden = true
            lbMaHD.frame = CGRect(x: lbMaHD.frame.origin.x, y: lbTenKHText.frame.origin.y + lbTenKHTextHeight, width: lbMaHD.frame.size.width, height: lbMaHD.frame.height)
        }
        
        let lbMaHDText = UILabel(frame: CGRect(x: lbTenKHText.frame.origin.x, y: lbMaHD.frame.origin.y, width: lbTenKHText.frame.width, height: Common.Size(s: 20)))
        lbMaHDText.text = self.formatPhoneViettel(phoneNumber: "\(self.itemViettelTSPayTeleCharge?.billing_code ?? "")")
        lbMaHDText.textColor = UIColor.black
        lbMaHDText.textAlignment = .right
        lbMaHDText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbMaHDText)
        
        let lbMaHDTextHeight:CGFloat = lbMaHDText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbMaHDText.optimalHeight + Common.Size(s: 5))
        lbMaHDText.numberOfLines = 0
        lbMaHDText.frame = CGRect(x: lbMaHDText.frame.origin.x, y: lbMaHDText.frame.origin.y, width: lbMaHDText.frame.width, height: lbMaHDTextHeight)
        
        let lbNCC = UILabel(frame: CGRect(x: lbTenKH.frame.origin.x, y: lbMaHDText.frame.origin.y + lbMaHDTextHeight, width: lbTenKH.frame.size.width, height: Common.Size(s: 20)))
        lbNCC.text = "Nhà cung cấp:"
        lbNCC.textColor = UIColor.lightGray
        lbNCC.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbNCC)
        
        let lbNCCText = UILabel(frame: CGRect(x: lbTenKHText.frame.origin.x, y: lbNCC.frame.origin.y, width: lbTenKHText.frame.width, height: Common.Size(s: 20)))
        lbNCCText.text = "\(self.thuHoProvider?.PaymentBillProviderName ?? "")"
        lbNCCText.textColor = UIColor.black
        lbNCCText.textAlignment = .right
        lbNCCText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbNCCText)
        
        let lbNCCTextHeight:CGFloat = lbNCCText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNCCText.optimalHeight + Common.Size(s: 5))
        lbNCCText.numberOfLines = 0
        lbNCCText.frame = CGRect(x: lbNCCText.frame.origin.x, y: lbNCCText.frame.origin.y, width: lbNCCText.frame.width, height: lbNCCTextHeight)
        
        let lbLoaiDV = UILabel(frame: CGRect(x: lbTenKH.frame.origin.x, y: lbNCCText.frame.origin.y + lbNCCTextHeight, width: lbTenKH.frame.size.width, height: Common.Size(s: 20)))
        lbLoaiDV.text = "Loại dịch vụ:"
        lbLoaiDV.textColor = UIColor.lightGray
        lbLoaiDV.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbLoaiDV)
        
        let lbLoaiDVText = UILabel(frame: CGRect(x: lbTenKHText.frame.origin.x, y: lbLoaiDV.frame.origin.y, width: lbTenKHText.frame.width, height: Common.Size(s: 20)))
        lbLoaiDVText.text = "\(self.thuHoService?.PaymentBillServiceName ?? "")"
        lbLoaiDVText.textColor = UIColor.black
        lbLoaiDVText.textAlignment = .right
        lbLoaiDVText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbLoaiDVText)
        
        let lbLoaiDVTextHeight:CGFloat = lbLoaiDVText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbLoaiDVText.optimalHeight + Common.Size(s: 5))
        lbLoaiDVText.numberOfLines = 0
        lbLoaiDVText.frame = CGRect(x: lbLoaiDVText.frame.origin.x, y: lbLoaiDVText.frame.origin.y, width: lbLoaiDVText.frame.width, height: lbLoaiDVTextHeight)
        
        let viewThanhToan = UIScrollView(frame: CGRect(x: 0, y: lbLoaiDVText.frame.origin.y + lbLoaiDVTextHeight + Common.Size(s: 8), width: scrollView.frame.size.width, height: Common.Size(s: 40)))
        viewThanhToan.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView.addSubview(viewThanhToan)
        
        let lbTT = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbTT.text = "THANH TOÁN"
        lbTT.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 15))
        lbTT.textColor = UIColor(netHex: 0x109e59)
        viewThanhToan.addSubview(lbTT)
        
        let lbTienMat = UILabel(frame: CGRect(x: lbTenKH.frame.origin.x, y: viewThanhToan.frame.origin.y + viewThanhToan.frame.height + Common.Size(s: 5), width: (scrollView.frame.width - Common.Size(s: 30))/2, height: Common.Size(s: 20)))
        lbTienMat.text = "Tiền mặt:"
        lbTienMat.textColor = UIColor.lightGray
        lbTienMat.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbTienMat)
        
        let lbTienMatText = UILabel(frame: CGRect(x: lbTienMat.frame.origin.x + lbTienMat.frame.width, y: lbTienMat.frame.origin.y, width: lbTienMat.frame.width, height: Common.Size(s: 20)))
        lbTienMatText.text = "\(self.totalCash)đ"
        lbTienMatText.textColor = UIColor(netHex: 0x109e59)
        lbTienMatText.textAlignment = .right
        lbTienMatText.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbTienMatText)
        
        let lbThe = UILabel(frame: CGRect(x: lbTenKH.frame.origin.x, y: lbTienMatText.frame.origin.y + lbTienMatText.frame.height, width: lbTienMat.frame.width, height: Common.Size(s: 20)))
        lbThe.text = "Thẻ:"
        lbThe.textColor = UIColor.lightGray
        lbThe.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbThe)
        
        let lbTheText = UILabel(frame: CGRect(x: lbThe.frame.origin.x + lbThe.frame.width, y: lbThe.frame.origin.y, width: lbTienMatText.frame.width, height: Common.Size(s: 20)))
        lbTheText.text = "\(self.totalCredict)đ"
        lbTheText.textColor = UIColor(netHex: 0x109e59)
        lbTheText.textAlignment = .right
        lbTheText.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbTheText)
        
        let viewHTTT = UIScrollView(frame: CGRect(x: 0, y: lbTheText.frame.origin.y + lbTheText.frame.height + Common.Size(s: 8), width: scrollView.frame.size.width, height: Common.Size(s: 40)))
        viewHTTT.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView.addSubview(viewHTTT)
        
        let lbHTTT = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbHTTT.text = "HÌNH THỨC THANH TOÁN"
        lbHTTT.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 15))
        lbHTTT.textColor = UIColor(netHex: 0x109e59)
        viewHTTT.addSubview(lbHTTT)
        
        let lbPhiThuHo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewHTTT.frame.origin.y + viewHTTT.frame.size.height + Common.Size(s: 5), width: (scrollView.frame.width - Common.Size(s: 30))/2, height: Common.Size(s: 20)))
        lbPhiThuHo.text = "Phí thu hộ"
        lbPhiThuHo.textColor = UIColor.lightGray
        lbPhiThuHo.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbPhiThuHo)
        
        let lbPhiThuHoText = UILabel(frame: CGRect(x: lbPhiThuHo.frame.size.width + lbPhiThuHo.frame.origin.x, y: lbPhiThuHo.frame.origin.y, width: lbPhiThuHo.frame.width, height: Common.Size(s: 20)))
        lbPhiThuHoText.text = "0đ"
        lbPhiThuHoText.textAlignment = .right
        lbPhiThuHoText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbPhiThuHoText)
        
        let lbPhiCaThe = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbPhiThuHoText.frame.origin.y + lbPhiThuHoText.frame.size.height + Common.Size(s: 5), width: lbPhiThuHo.frame.size.width, height: Common.Size(s: 20)))
        lbPhiCaThe.text = "Phí cà thẻ/ví"
        lbPhiCaThe.textColor = UIColor.lightGray
        lbPhiCaThe.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbPhiCaThe)
        
        let lbPhiCaTheText = UILabel(frame: CGRect(x: lbPhiCaThe.frame.size.width + lbPhiCaThe.frame.origin.x, y: lbPhiCaThe.frame.origin.y, width: lbPhiThuHoText.frame.size.width, height: Common.Size(s: 20)))
        lbPhiCaTheText.text = "\(Common.convertCurrencyDouble(value: self.phiCathe))đ"
        lbPhiCaTheText.textAlignment = .right
        lbPhiCaTheText.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbPhiCaTheText)
        
        let lbSoTienThanhToan = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbPhiCaTheText.frame.origin.y + lbPhiCaTheText.frame.size.height + Common.Size(s: 5), width: lbPhiThuHo.frame.size.width, height: Common.Size(s: 20)))
        lbSoTienThanhToan.text = "Số tiền thanh toán"
        lbSoTienThanhToan.textColor = UIColor.lightGray
        lbSoTienThanhToan.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbSoTienThanhToan)
        
        let lbSoTienThanhToanText = UILabel(frame: CGRect(x: lbSoTienThanhToan.frame.size.width + lbSoTienThanhToan.frame.origin.x, y: lbSoTienThanhToan.frame.origin.y, width: lbPhiThuHoText.frame.size.width, height: Common.Size(s: 20)))
        lbSoTienThanhToanText.text = "0"
        lbSoTienThanhToanText.textColor = UIColor(netHex: 0xcc0c2f)
        lbSoTienThanhToanText.textAlignment = .right
        lbSoTienThanhToanText.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbSoTienThanhToanText)
        
        let amount = NumberFormatter().number(from: (self.itemViettelTSPayTeleCharge?.amount ?? "0"))?.doubleValue ?? 0
        let totalPayment = amount + phiThuHo + phiCathe
        lbSoTienThanhToanText.text = "\(Common.convertCurrencyDouble(value: totalPayment))đ"
        
        let btnPrint = UIButton(frame: CGRect(x: Common.Size(s: 15), y: lbSoTienThanhToanText.frame.origin.y + lbSoTienThanhToanText.frame.height + Common.Size(s: 15), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        btnPrint.backgroundColor = UIColor(netHex: 0x109e59)
        btnPrint.setTitle("IN", for: .normal)
        btnPrint.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btnPrint.layer.cornerRadius = 5
        btnPrint.addTarget(self, action: #selector(actionPrint), for: .touchUpInside)
        scrollView.addSubview(btnPrint)
        
        scrollViewHeight = btnPrint.frame.origin.y + btnPrint.frame.height + Common.Size(s: 30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    @objc func actionBack() {
        for vc in self.navigationController?.viewControllers ?? [] {
            if vc is ChooseNCCThuHoServiceViewController {
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    
    @objc func actionPrint() {
        let sdt = self.formatPhoneViettel(phoneNumber: "\(self.itemViettelTSPayTeleCharge?.billing_code ?? "")")
        
        let printBillThuHo = PrintBillThuHo(BillCode:"\(sdt)", TransactionCode: "\(itemViettelTSPayTeleCharge?.payment_order_id ?? "")", ServiceName:"\(self.thuHoService?.PaymentBillServiceName ?? "")", ProVideName:"\(self.thuHoProvider?.PaymentBillProviderName ?? "")", NhaCungCap: "\(self.thuHoProvider?.PaymentBillProviderName ?? "")", Customernamne: self.tenKH, Customerpayoo:"", PayerMobiphone:"\(sdt)", Address:"", BillID:"", Month:"", TotalAmouth:"\(self.itemViettelTSPayTeleCharge?.amount ?? "")", Paymentfee:"", Employname:"\(Cache.user!.EmployeeName)", Createby:"\(Cache.user!.UserName)", ShopAddress:"\(Cache.user!.Address)",ThoiGianXuat:"", MaVoucher: "", HanSuDung: "", PhiCaThe: "\(self.phiCathe)")

        MPOSAPIManager.pushBillThuHo(printBill: printBillThuHo)
        Toast(text: "Đã gửi lệnh in!").show()
        
        
        let moneyCuocViettel = NumberFormatter().number(from: self.itemViettelTSPayTeleCharge?.amount ?? "0")?.doubleValue ?? 0
        let totalPay = moneyCuocViettel + self.phiCathe + self.phiThuHo
        let somposInt = NumberFormatter().number(from: self.itemViettelTSPayTeleCharge?.sompos ?? "0")?.intValue ?? 0
        debugPrint("so mpos: \(somposInt)")
        
        let totalCashNum = NumberFormatter().number(from: self.totalCash.replace(",", withString: ""))?.intValue ?? 0
        let totalCredictNum = NumberFormatter().number(from: self.totalCredict.replace(",", withString: ""))?.intValue ?? 0
        
        let itemThuHo = GetCRMPaymentHistoryTheNapResult(
            Bill_Code: "\(sdt)",
            MPOS: somposInt, TinhTrang_ThuTien: "",
            LoaiGiaoDich: "\(self.thuHoService?.PaymentBillServiceName ?? "")",
            SDT_KH: "\(sdt)",
            TongTienDaThu: Int(totalPay),
            Tong_TienMat: totalCashNum,
            Tong_The: totalCredictNum,
            Tong_VC: 0,
            GiaTri_VC: "",
            NhaMang: "",
            MenhGia: 0,
            LoaiDichVu: "\(self.thuHoService?.PaymentBillServiceName ?? "")",
            NCC: "\(self.thuHoProvider?.PaymentBillProviderName ?? "Viettel")",
            Is_Cash: 1,
            customerCode: "\(sdt)",
            customerName: self.tenKH,
            ExpiredCard: "",
            NumberCode: "",
            SerialCard: "",
            CreatedDateTime: "",
            TongTienKhongPhi: Int(moneyCuocViettel),
            TongTienPhi: Int(self.phiThuHo),
            U_Voucher: "",
            KyThanhToan: "",
            PhiCaThe: Int(self.phiCathe),
            mVoucher: [],
            MaGD: "\(itemViettelTSPayTeleCharge?.payment_order_id ?? "")",
            NgayHetHan: "",
            NVGD: "\(Cache.user!.EmployeeName)",
            Type_LoaiDichVu: 0,
            SLThe: 0,
            NameCard: "\(self.itemTheThanhToan?.Text ?? "")",
            Is_HDCty: 0)
        
        let vc = DetailSOThuHoViewController()
        vc.so = itemThuHo
        vc.isThuHoViettelTS = true
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func formatPhoneViettel(phoneNumber: String) -> String {
        var sdt = phoneNumber
        if sdt.count == 11 && (sdt.hasPrefix("84")) {
            let str1 = sdt.substring(fromIndex: 2)
            sdt = "0\(str1)"
        }
        debugPrint("sdt: \(sdt)")
        return sdt
    }
}
