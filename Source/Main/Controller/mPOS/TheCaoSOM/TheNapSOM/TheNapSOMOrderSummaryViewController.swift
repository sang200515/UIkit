//
//  TheNapSOMOrderSummaryViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

enum TheCaoSOMType {
    case TheNap
    case BanTien
}

class TheNapSOMOrderSummaryViewController: UIViewController {

    @IBOutlet weak var lbOrderNo: UILabel!
    @IBOutlet weak var lbTransactionNo: UILabel!
    @IBOutlet weak var lbService: UILabel!
    @IBOutlet weak var lbProvider: UILabel!
    @IBOutlet weak var lbQuantity: UILabel!
    @IBOutlet weak var lbShop: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbEmpoyee: UILabel!
    @IBOutlet weak var lbCash: UILabel!
    @IBOutlet weak var lbCard: UILabel!
    @IBOutlet weak var lbCardFee: UILabel!
    @IBOutlet weak var lbVoucher: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var stvTotalPayment: UIStackView!
    @IBOutlet weak var btnPrint: UIButton!
    
    var type: TheCaoSOMType = .TheNap
    private var date: Date = Date()
    private var totalCardFee: Int = 0
    var isHistory: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    private func setupUI() {
        title = isHistory ? "Lịch Sử Thanh Toán" : "Chi Tiết Thanh Toán"
        addBackButton(#selector(backButtonAction))
        
        btnPrint.roundCorners(.allCorners, radius: 5)
        btnPrint.isHidden = isHistory
        stvTotalPayment.isHidden = isHistory
        if !isHistory { showAlert() }
        checkPrintPermission()
        
        lbOrderNo.text = TheCaoSOMDataManager.shared.orderDetail.billNo
        lbTransactionNo.text = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.transactionCode
        lbService.text = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.categoryName
        lbQuantity.text = "\(TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.quantity ?? 0)"
        lbShop.text = TheCaoSOMDataManager.shared.orderDetail.warehouseAddress
        lbStatus.text = ThuHoSOMOrderStatusEnum.init(rawValue: TheCaoSOMDataManager.shared.orderDetail.orderStatus)?.description
        lbStatus.textColor = ThuHoSOMOrderStatusEnum.init(rawValue: TheCaoSOMDataManager.shared.orderDetail.orderStatus)?.color
        
        date = TheCaoSOMDataManager.shared.orderDetail.creationTime.toDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        lbDate.text = date.stringWithFormat("HH:mm:ss dd-MM-yyyy")
        
        lbEmpoyee.text = TheCaoSOMDataManager.shared.orderDetail.employeeName
        
        let cash = TheCaoSOMDataManager.shared.orderDetail.payments.first(where: { $0.paymentType == "1" })
        lbCash.text = "\(Common.convertCurrencyV2(value: cash?.paymentValue ?? 0)) VNĐ"
        
        let cards = TheCaoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == "2" }
        var totalCard = 0
        for card in cards {
            totalCard += card.paymentValue
            totalCardFee += card.isChargeOnCash ?? false ? 0 : card.paymentExtraFee
        }
        lbCard.text = "\(Common.convertCurrencyV2(value: totalCard)) VNĐ"
        lbCardFee.text = "\(Common.convertCurrencyV2(value: totalCardFee)) VNĐ"
        
        let vouchers = TheCaoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == "4" }
        var totalVoucher = 0
        for voucher in vouchers {
            totalVoucher += voucher.paymentValue
        }
        lbVoucher.text = "\(Common.convertCurrencyV2(value: totalVoucher)) VNĐ"
        lbTotal.text = "\(Common.convertCurrencyV2(value: TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.totalAmountIncludingFee ?? 0)) VNĐ"
    }
    
    @objc func backButtonAction() {
        TheCaoSOMDataManager.shared.resetParam()
        TheCaoSOMDataManager.shared.providers = ThuHoSOMProviders(JSON: [:])!

        if isHistory {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func loadData() {
        SOMAPIManager.shared.getProviderDetail(providerID: TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.providerID ?? "", completion: { result in
            switch result {
            case .success(let provider):
                if !provider.name&.isEmpty {
                    TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.providerName = provider.name&
                }
                
                self.lbProvider.text = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.providerName
            case .failure(let error):
                self.showPopUp(error.description, "Thông báo", buttonTitle: "OK", handleOk: {
                    self.lbProvider.text = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.providerName
                })
            }
        })
    }
    
    private func showAlert() {
        switch TheCaoSOMDataManager.shared.orderDetail.orderStatus {
        case 1, 7:
            showAlertOneButton(title: "Thông báo", with: "\(ThuHoSOMOrderStatusEnum.init(rawValue: TheCaoSOMDataManager.shared.orderDetail.orderStatus)?.description ?? ""). Vui lòng thu tiền khách hàng", titleButton: "OK")
        case 2:
            showAlertOneButton(title: "Thông báo", with: ThuHoSOMOrderStatusEnum.init(rawValue: TheCaoSOMDataManager.shared.orderDetail.orderStatus)?.description ?? "", titleButton: "OK")
        default:
            showAlertOneButton(title: "Thông báo", with: ThuHoSOMOrderStatusEnum.init(rawValue: TheCaoSOMDataManager.shared.orderDetail.orderStatus)?.description ?? "", titleButton: "OK")
        }
    }
    
    private func checkPrintPermission() {
        switch TheCaoSOMDataManager.shared.orderDetail.orderStatus {
        case 1, 2, 7:
            btnPrint.setTitle("In Phiếu", for: .normal)
            btnPrint.isHidden = false
        default:
            btnPrint.setTitle("Hoàn Tất", for: .normal)
        }
    }
    
    private func getCardDetails() {
        let orderId = TheCaoSOMDataManager.shared.orderDetail.id
        let providerID = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.providerID ?? ""
        let transactionID = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.id ?? ""
        
        Provider.shared.thecaoSOMAPIService.getCardDetails(providerID: providerID, orderID: orderId, transactionID: transactionID, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            self.printBill(cards: data)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    private func printBill(cards: TheNapSOMCards?) {
        let address = TheCaoSOMDataManager.shared.orderDetail.warehouseAddress
        let phone = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.productCustomerPhoneNumber ?? ""
        let orderCode = TheCaoSOMDataManager.shared.orderDetail.billNo
        
        var voucherString = ""
        for voucher in TheCaoSOMDataManager.shared.orderDetail.payments.filter({ $0.paymentType == "4" }) {
            voucherString += voucher.paymentCode + ";"
        }
        voucherString = voucherString.dropLast
        
        switch type {
        case .BanTien:
            let price = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.price ?? 0
            
            let printBillTopup = CardCodePayooTopUp(DiaChi: address, SoDienThoai: phone, TenLoaiThe: "", MenhGiaThe: "\(price)", ThoiGianXuat: date.stringWith(format: "HH:mm:ss, dd/MM/yyyy"), SoPhieuThu: orderCode, MaVoucher: voucherString, HanSuDung: "")
            MPOSAPIManager.pushBillTopUpCard(printBill: printBillTopup)
        case .TheNap:
            let type = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.categoryName ?? ""
            let value = "\(TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.price ?? 0)"
            
            var pinString = ""
            var serialString = ""
            var expiredDateString = ""
            for card in cards!.cards {
                let expiredDate = card.rawExpiredDate.toNewStrDate(withFormat: "yyyy/MM/dd", newFormat: "dd/MM/yyyy")
                pinString += card.pin + ","
                serialString += card.serial + ","
                expiredDateString += expiredDate + ","
            }
            pinString = pinString.dropLast
            serialString = serialString.dropLast
            expiredDateString = expiredDateString.dropLast
            
            let printBillCard = PrintBillCard(Address: address, CardType: type, FaceValue: value, NumberCode: pinString, Serial: serialString, ExpirationDate: expiredDateString, ExportTime: date.stringWith(format: "HH:mm:ss, dd/MM/yyyy"), SaleOrderCode: orderCode, UserCode: Cache.user!.UserName, MaVoucher: voucherString, HanSuDung: "")
            MPOSAPIManager.pushBillCard(printBill: printBillCard)
        }
        
        showAlertOneButton(title: "Thông báo", with: "Đã gửi lệnh in!", titleButton: "OK", handleOk: {
            TheCaoSOMDataManager.shared.resetParam()
            TheCaoSOMDataManager.shared.providers = ThuHoSOMProviders(JSON: [:])!
            self.navigationController?.popToRootViewController(animated: true)
        })
    }
    
    @IBAction func printButtonPressed(_ sender: Any) {
        if btnPrint.title(for: .normal) == "In Phiếu" {
            switch type {
            case .BanTien:
                printBill(cards: nil)
            case .TheNap:
                getCardDetails()
            }
        } else {
            TheCaoSOMDataManager.shared.resetParam()
            TheCaoSOMDataManager.shared.providers = ThuHoSOMProviders(JSON: [:])!
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
