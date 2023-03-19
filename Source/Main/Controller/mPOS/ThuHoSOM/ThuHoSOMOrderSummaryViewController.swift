//
//  ThuHoSOMOrderSummaryViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 04/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Toaster
class ThuHoSOMOrderSummaryViewController: UIViewController {
    static var isCheckCanPopViewSign:Bool = false
    @IBOutlet weak var lbOrderNo: UILabel!
    @IBOutlet weak var lbTransactionNo: UILabel!
    @IBOutlet weak var lbService: UILabel!
    @IBOutlet weak var lbProvider: UILabel!
    @IBOutlet weak var lbInvoice: UILabel!
    @IBOutlet weak var lbShop: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbEmpoyee: UILabel!
    @IBOutlet weak var lbCustomerName: UILabel!
    @IBOutlet weak var lbCustomerPhone: UILabel!
    @IBOutlet weak var lbCash: UILabel!
    @IBOutlet weak var lbCard: UILabel!
    @IBOutlet weak var lbCardFee: UILabel!
    @IBOutlet weak var vTransfer: UIStackView!
    @IBOutlet weak var lbTransfer: UILabel!
    @IBOutlet weak var vVoucher: UIStackView!
    @IBOutlet weak var lbVoucher: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var stvTotalPayment: UIStackView!
    @IBOutlet weak var btnPrint: UIButton!
    @IBOutlet weak var headerViewSign: UIView!
    @IBOutlet weak var stackViewViewSign: UIStackView!
    @IBOutlet weak var viewSign: UIView!
    @IBOutlet weak var imageSigned: UIImageView!
    @IBOutlet weak var viewSignButton: UIView!
    @IBOutlet weak var viewSignTitle: UILabel!
    @IBOutlet weak var viewSignIcon: UIImageView!
    private var date: Date = Date()
    private var totalCardFee: Int = 0
    var isHistory: Bool = false
    var isVinasure: Bool = false
	var isEpay:Bool = false
    private var stringBase64Sign: String = ""
    private var isSign: Bool = false
    private var urlChuKy:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
		setupViewSign()
        setupUI()
        loadData()
        ThuHoSOMOrderSummaryViewController.isCheckCanPopViewSign = false
    }
    private func setupViewSign() {
        if ThuHoSOMDataManager.shared.orderDetail.orderStatus == 2 && ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos[0].extraProperties.signaturePhoto == nil {
let a = ThuHoSOMDataManager.shared.orderDetail
            print(ThuHoSOMDataManager.shared.orderDetail)
            print(a)

            headerViewSign.isHidden = false
            stackViewViewSign.isHidden  = false
            self.imageSigned.isUserInteractionEnabled = true
            let tapShowSignature = UITapGestureRecognizer(target: self, action: #selector(tapShowSign))
            imageSigned.addGestureRecognizer(tapShowSignature)
        }else {
            headerViewSign.isHidden = true
            stackViewViewSign.isHidden  = true
        }

    }
    @objc func tapShowSign(sender: UITapGestureRecognizer) {
        let signatureVC = EPSignatureViewController(
            signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"

        self.navigationController?.pushViewController(signatureVC, animated: true)
    }

    private func setupUI() {
        title = isHistory ? "Lịch Sử Thanh Toán Thu Hộ" : "Chi Tiết Thanh Toán Thu Hộ"
        addBackButton(#selector(backButtonAction))

        btnPrint.roundCorners(.allCorners, radius: 5)
//        btnPrint.isHidden = isHistory
		stackViewViewSign.isHidden = true
		btnPrint.isHidden = false
		headerViewSign.isHidden = true
		if isEpay {
			stackViewViewSign.isHidden = true
			btnPrint.isHidden = true
			headerViewSign.isHidden = true
		}
        if !isHistory { showAlert() }
        checkPrintPermission()
        
        lbOrderNo.text = ThuHoSOMDataManager.shared.orderDetail.billNo
        lbTransactionNo.text = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.transactionCode
        lbService.text = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.productName
        
        let invoices = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.invoices.filter { $0.isCheck } ?? []
        lbInvoice.text = "\(invoices.count) Kỳ"
        lbShop.text = ThuHoSOMDataManager.shared.orderDetail.warehouseAddress
        lbStatus.text = ThuHoSOMOrderStatusEnum.init(rawValue: ThuHoSOMDataManager.shared.orderDetail.orderStatus)?.description
        lbStatus.textColor = ThuHoSOMOrderStatusEnum.init(rawValue: ThuHoSOMDataManager.shared.orderDetail.orderStatus)?.color
        
        date = ThuHoSOMDataManager.shared.orderDetail.creationTime.toDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        lbDate.text = date.stringWithFormat("HH:mm:ss dd-MM-yyyy")
        
        lbEmpoyee.text = ThuHoSOMDataManager.shared.orderDetail.employeeName
        lbCustomerName.text = ThuHoSOMDataManager.shared.orderDetail.customerName
        lbCustomerPhone.text = ThuHoSOMDataManager.shared.orderDetail.customerPhoneNumber
        
        let cash = ThuHoSOMDataManager.shared.orderDetail.payments.first(where: { $0.paymentType == 1 })
        lbCash.text = "\(Common.convertCurrencyV2(value: cash?.paymentValue ?? 0)) VNĐ"
        
        let cards = ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 2 }
        var totalCard = 0
        for card in cards {
            totalCard += card.paymentValue
            totalCardFee += card.isChargeOnCash ?? false ? 0 : card.paymentExtraFee
        }
        lbCard.text = "\(Common.convertCurrencyV2(value: totalCard)) VNĐ"
        lbCardFee.text = "\(Common.convertCurrencyV2(value: totalCardFee)) VNĐ"
        
        let transfers = ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 3 }
        var totalTransfer = 0
        for transfer in transfers {
            totalTransfer += transfer.paymentValue
        }
        lbTransfer.text = "\(Common.convertCurrencyV2(value: totalTransfer)) VNĐ"
        lbTotal.text = "\(Common.convertCurrencyV2(value: ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.totalAmountIncludingFee ?? 0)) VNĐ"
    }
    
    @objc func backButtonAction() {
        ThuHoSOMDataManager.shared.resetProduct()
        ThuHoSOMDataManager.shared.resetParam()
        if isHistory {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func loadData() {
        SOMAPIManager.shared.getProviderDetail(providerID: ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.providerId ?? "", completion: { result in
            switch result {
            case .success(let provider):
                ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.providerName = provider.description ?? "ThuHo"
                self.lbProvider.text = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.providerName
                self.isVinasure = provider.name == "Vinasure-v2"
                if self.isVinasure {
                    self.vTransfer.isHidden = true
                    self.vVoucher.isHidden = false
                    
                    let vouchers = ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 4 }
                    var totalVoucher = 0
                    for voucher in vouchers {
                        totalVoucher += voucher.paymentValue
                    }
                    self.lbVoucher.text = "\(Common.convertCurrencyV2(value: totalVoucher)) VNĐ"
                }
            case .failure(let error):
                self.showPopUp(error.description, "Thông báo", buttonTitle: "OK", handleOk: {
                    ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.providerName = "ThuHo"
                    self.lbProvider.text = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.providerName
                })
            }
        })
    }

    private func updateBienLai(orderId: String, url: String) {
        ProgressView.shared.show()
        Provider.shared.ebayService.updateBienLai(
            orderId: orderId, url: url,
            success: { [weak self] (result) in
                guard let self = self, let response = result else { return }
                ProgressView.shared.hide()
                if response.code == 200 {  //success
                    let vc = InPhieuEbayVC()
						vc.isFromSignFromHistory = true
						vc.finacialCode = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos[0].extraProperties.finance ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.showAlertOneButton(
                        title: "Thông báo", with: response.message ?? "", titleButton: "OK")
                }
            },
            failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
    }
    private func showAlert() {
        switch ThuHoSOMDataManager.shared.orderDetail.orderStatus {
        case 1, 7:
            showAlertOneButton(title: "Thông báo", with: "\(ThuHoSOMOrderStatusEnum.init(rawValue: ThuHoSOMDataManager.shared.orderDetail.orderStatus)?.description ?? ""). Vui lòng thu tiền khách hàng", titleButton: "OK")
        case 2:
            showAlertOneButton(title: "Thông báo", with: ThuHoSOMOrderStatusEnum.init(rawValue: ThuHoSOMDataManager.shared.orderDetail.orderStatus)?.description ?? "", titleButton: "OK")
        default:
            showAlertOneButton(title: "Thông báo", with: ThuHoSOMOrderStatusEnum.init(rawValue: ThuHoSOMDataManager.shared.orderDetail.orderStatus)?.description ?? "", titleButton: "OK")
        }
    }
    
    private func checkPrintPermission() {
        switch ThuHoSOMDataManager.shared.orderDetail.orderStatus {
        case 1, 2, 7:
            btnPrint.setTitle("In Phiếu", for: .normal)
        default:
            btnPrint.setTitle("Hoàn Tất", for: .normal)
        }
    }
    
    private func getOrderVoucher() {
        var voucherString = ""
        ProgressView.shared.show()
        SOMAPIManager.shared.getOrderVoucher(orderID: ThuHoSOMDataManager.shared.orderDetail.id, providerName: ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.providerName ?? "ThuHo", completion: { result in
            ProgressView.shared.hide()
            switch result {
            case .success(let voucher):
                voucherString = voucher.message?.replace("|-|", withString: ";") ?? ""
                DispatchQueue.main.async {
                    self.printBill(voucher: voucherString)
                }
            case .failure(let error):
                self.showPopUp(error.description, "Thông báo", buttonTitle: "OK", handleOk: {
                    DispatchQueue.main.async {
                        self.printBill(voucher: voucherString)
                    }
                })
            }
        })
    }
    
    private func printBill(voucher: String) {
        if isVinasure {
            let invoice = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.invoices.first ?? ThuHoSOMOrderInvoiceDetail(JSON: [:])!
            let ids = invoice.id.split(separator: "-")
            let rawPeriods = invoice.rawPeriod.split(separator: "-")
            
            let printBillBaoHiem = BaoHiem_PrintObject(DiaChiShop: ThuHoSOMDataManager.shared.orderDetail.warehouseAddress,
                                                       SoPhieuThu: ThuHoSOMDataManager.shared.orderDetail.billNo,
                                                       DichVu: ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.productName ?? "",
                                                       NhaBaoHiem: ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.providerName ?? "BaoHiem",
                                                       TenChuXe: ThuHoSOMDataManager.shared.orderDetail.customerName,
                                                       SoDienThoaiKH: ThuHoSOMDataManager.shared.orderDetail.customerPhoneNumber,
                                                       DiaChiKH: ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.productCustomerAddress ?? "",
                                                       LoaiXe: ids.count > 0 ? String(ids[0]).trim() : "",
                                                       DungTich: ids.count > 2 ? String(ids[2]).trim() : "",
                                                       BienSo: ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.productCustomerCode ?? "",
                                                       NgayBatDau: rawPeriods.count > 0 ? String(rawPeriods[0]).trim() : "",
                                                       NgayKetThuc: rawPeriods.count > 1 ? String(rawPeriods[1]).trim() : "",
                                                       GiaBHTDNS: "\(ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.price ?? 0)",
                                                       GiaBHTaiNan: "\(invoice.paymentFee)",
                                                       TongTien: "\(ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.totalAmountIncludingFee ?? 0)",
                                                       nhanVien: Cache.user!.EmployeeName,
                                                       MaVoucher: voucher,
                                                       HanSuDung: rawPeriods.count > 1 ? String(rawPeriods[1]).trim() : "")
            
            MPOSAPIManager.pushPrintBaoHiem(printBH: printBillBaoHiem)
        } else {
            var invoice = ""
            for item in ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.invoices ?? [] {
                invoice += item.rawPeriod + ", "
            }
            invoice = invoice.dropLast
            invoice = invoice.dropLast
            
            let printBillThuHo = ThuHoSOMPrintBill(JSON: [:])!
            
            printBillThuHo.header.billCode = ThuHoSOMDataManager.shared.orderDetail.billNo
            printBillThuHo.header.transactionCode = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.transactionCode ?? ""
            printBillThuHo.header.serviceName = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.productName ?? ""
            printBillThuHo.header.providerName = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.providerName ?? "ThuHo"
            printBillThuHo.header.total = "\(ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.totalAmountIncludingFee ?? 0)"
            printBillThuHo.header.employeeName = Cache.user!.EmployeeName
            printBillThuHo.header.createBy = Cache.user!.UserName
            printBillThuHo.header.shopAddress = ThuHoSOMDataManager.shared.orderDetail.warehouseAddress
            printBillThuHo.header.time = date.stringWithFormat("HH:mm:ss, dd/MM/yyyy")
            printBillThuHo.header.voucherCode = voucher
            
            var details: [ThuHoSOMPrintBillDetail] = []
            
            let customerCode = ThuHoSOMPrintBillDetail(JSON: [:])!
            var code = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.productCustomerCode ?? ""
            if code.count == 16 && (code.prefix(3) == "539" || code.prefix(3) == "356") {
                var chars = Array(code)
                chars.replaceSubrange(6...11, with: repeatElement("*", count: 6))
                code = String(chars)
            }
            customerCode.stt = "1"
            customerCode.name = "Mã khách hàng:"
            customerCode.value = code
            details.append(customerCode)
            
            let customerName = ThuHoSOMPrintBillDetail(JSON: [:])!
            customerName.stt = "2"
            customerName.name = "Tên KH:"
            customerName.value = ThuHoSOMDataManager.shared.orderDetail.customerName
            details.append(customerName)
            
            let customerPhone = ThuHoSOMPrintBillDetail(JSON: [:])!
            customerPhone.stt = "3"
            customerPhone.name = "Số ĐT KH:"
            customerPhone.value = ThuHoSOMDataManager.shared.orderDetail.customerPhoneNumber
            details.append(customerPhone)
            
            let customerAddress = ThuHoSOMPrintBillDetail(JSON: [:])!
            customerAddress.stt = "4"
            customerAddress.name = "Địa chỉ:"
            customerAddress.value = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.productCustomerAddress ?? ""
            details.append(customerAddress)
            
            let invoices = ThuHoSOMPrintBillDetail(JSON: [:])!
            invoices.stt = "5"
            invoices.name = "Tháng (kỳ):"
            invoices.value = invoice
            details.append(invoices)
            
            printBillThuHo.detail = details
            
            Provider.shared.thuhoSOMAPIService.pushBillThuHoSOM(printBill: printBillThuHo)
        }
        
        showAlertOneButton(title: "Thông báo", with: "Đã gửi lệnh in!", titleButton: "OK", handleOk: {
            ThuHoSOMDataManager.shared.resetProduct()
            ThuHoSOMDataManager.shared.resetParam()
            self.navigationController?.popToRootViewController(animated: true)
        })
    }
        //MARK: - API
    private func genBienLai(
        ten_shop: String, dia_chi_shop: String, ngay_tao: String, ma_giao_dich: String, khach_hang: String,
        ma_hop_dong: String, so_tien_nhan: Double, so_dien_thoai: String, ma_thu_ngan: String,
        ten_thu_ngan: String, chu_ky_dien_tu: String,don_vi_tai_chinh:String
    ) {
        ProgressView.shared.show()
        Provider.shared.ebayService.genBienLaiEbay(
            ten_shop: ten_shop, dia_chi_shop: dia_chi_shop, ngay_tao: ngay_tao, ma_giao_dich: ma_giao_dich,
            khach_hang: khach_hang, ma_hop_dong: ma_hop_dong, so_tien_nhan: so_tien_nhan,
            so_dien_thoai: so_dien_thoai, ma_thu_ngan: ma_thu_ngan, ten_thu_ngan: ten_thu_ngan,
            chu_ky_dien_tu: chu_ky_dien_tu,don_vi_tai_chinh: don_vi_tai_chinh,
            success: { [weak self] (result) in
                guard let self = self, let response = result else { return }
                ProgressView.shared.hide()
                if response.error != "" {  //fail
                    self.showAlertOneButton(
                        title: "Thông báo", with: response.error ?? "", titleButton: "OK")
                } else {  //success
                    Toast.init(text: "Gen biên lai thành công").show()
                    self.updateBienLai(orderId: ThuHoSOMDataManager.shared.orderDetail.id, url: response.url ?? "")
                }
            },
            failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
    }
    private func uploadImageEbay(ma_hop_dong: String, type: Int, base64: String) {
//        self.loading(isShow: true)
        Provider.shared.ebayService.uploadImageEbayNoLoading(
            ma_hop_dong: ma_hop_dong, type: type, base64: base64,
            success: { [weak self] (result) in
                guard let self = self, let response = result else { return }
//                self.loading(isShow: false)
                if response.error != "" {  //fail
                    self.showAlertOneButton(
                        title: "Thông báo", with: response.error ?? "", titleButton: "OK")
                }else {
                    self.urlChuKy = response.url ?? ""
                    self.showAlertOneButton(
                        title: "Thông báo", with: "Cập nhật chữ ký thành công.Bấm xác nhận để hoàn tất phiếu.", titleButton: "OK")
                }
            },
            failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
    }
    @IBAction func onSave(_ sender: Any) {
        if isSign == false {
            self.showPopUp("Chưa có chữ ký khách hàng", "Thông báo", buttonTitle: "OK")
        }else {
//            let currentDate = Common.gettimeWith(format: "yyyy-MM-dd")
//            let creationTime: String = currentDate
            let orderID:String = ThuHoSOMDataManager.shared.orderDetail.id
            let shopcode:String = ThuHoSOMDataManager.shared.orderDetail.warehouseName
            let wareHouseAddress:String = ThuHoSOMDataManager.shared.orderDetail.warehouseAddress
            let createTime:String = ThuHoSOMDataManager.shared.orderDetail.creationTime.convertDateEbay()
            let maGiaoDich:String = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos[0].transactionCode
            let khachHang:String = ThuHoSOMDataManager.shared.orderDetail.customerName
            let maHopDong:String = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos[0].productCustomerCode
            let totalAmount:Double = Double(ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos[0].totalAmount)
            let phone:String = ThuHoSOMDataManager.shared.orderDetail.customerPhoneNumber
            let done_vi_tai_chinh:String = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos[0].extraProperties.finance ?? ""
            let ma_thu_ngan:String = ""

            self.genBienLai(
                ten_shop: shopcode, dia_chi_shop: wareHouseAddress,
                ngay_tao: createTime, ma_giao_dich: maGiaoDich,
                khach_hang: khachHang,
                ma_hop_dong: maHopDong, so_tien_nhan: totalAmount,
                so_dien_thoai: phone,
                ma_thu_ngan: ma_thu_ngan,
                ten_thu_ngan: "\(ThuHoSOMDataManager.shared.orderDetail.employeeName)", chu_ky_dien_tu: urlChuKy,don_vi_tai_chinh: done_vi_tai_chinh)


//            self.uploadImageEbay(
//                ma_hop_dong: ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos[0].productCustomerCode, type: 5, base64: stringBase64Sign)
        }

    }
    private func loading(isShow: Bool) {
        let nc = NotificationCenter.default
        if isShow {
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra thông tin..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
        } else {
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
        }
    }
    @IBAction func printButtonPressed(_ sender: Any) {
        if btnPrint.title(for: .normal) == "In Phiếu" {
            getOrderVoucher()
        } else {
            ThuHoSOMDataManager.shared.resetProduct()
            ThuHoSOMDataManager.shared.resetParam()
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

    //MARK: - View sign
extension ThuHoSOMOrderSummaryViewController: EPSignatureDelegate {
    private func cropImage(image: UIImage, toRect rect: CGRect) -> UIImage {
        let imageRef: CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage: UIImage = UIImage(cgImage: imageRef)
        return croppedImage
    }
    func epSignature(_: EPSignatureViewController, didCancel error: NSError) {

        _ = self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }

    func epSignature(_: EPSignatureViewController, didSign signatureImage: UIImage, boundingRect: CGRect) {
        _ = self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
        ThuHoSOMOrderSummaryViewController.isCheckCanPopViewSign = true
        imageSigned.contentMode = .scaleAspectFit
        imageSigned.image = cropImage(image: signatureImage, toRect: boundingRect)
        viewSignIcon.isHidden = true
        viewSignTitle.isHidden = true
        isSign = true
        let imageSign: UIImage = self.resizeImage(image: imageSigned.image!, newHeight: 170)!
        let imageDataSign: NSData = (imageSign.jpegData(compressionQuality: 0.75) as NSData?)!
        self.stringBase64Sign = imageDataSign.base64EncodedString(options: .endLineWithLineFeed)
        self.uploadImageEbay(
            ma_hop_dong: ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos[0].productCustomerCode, type: 5, base64: stringBase64Sign)
    }

    func reSignatureSignn() {

        let tapShowSignature = UITapGestureRecognizer(target: self, action: #selector(tapShowSign))
        imageSigned.isUserInteractionEnabled = true
        imageSigned.addGestureRecognizer(tapShowSignature)
    }
    private func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage? {

        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

}
