//
//  ThuHoSOMBikeInsuranceAddVoucherViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 24/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ThuHoSOMBikeInsuranceAddVoucherViewController: UIViewController {

    @IBOutlet weak var tfVoucher: UITextField!
    @IBOutlet weak var btnConfirm: UIButton!
    
    private var tempOrderParam: ThuHoSOMOrderParam = ThuHoSOMOrderParam(JSON: [:])!
    var didChangePayment: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Voucher"
        addBackButton()
        
        btnConfirm.roundCorners(.allCorners, radius: 5)
    }
    
    private func validateVoucher() -> Bool {
        guard let voucher = tfVoucher.text, !voucher.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập mã voucher", titleButton: "OK")
            return false
        }
        
        let vouchers = ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 4 }
        if vouchers.contains(where: { $0.paymentCode == voucher }) {
            showAlertOneButton(title: "Thông báo", with: "Voucher của bạn đã tồn tại vui lòng xóa voucher hoặc thêm voucher khác", titleButton: "OK")
            return false
        }
        
        return true
    }
    
    private func prepareParam(voucher: TheNapSOMVoucher) {
        tempOrderParam.orderStatusDisplay = ThuHoSOMDataManager.shared.orderParam.orderStatusDisplay
        tempOrderParam.billNo = ThuHoSOMDataManager.shared.orderParam.billNo
        tempOrderParam.customerId = ThuHoSOMDataManager.shared.orderParam.customerId
        tempOrderParam.customerName = ThuHoSOMDataManager.shared.orderParam.customerName
        tempOrderParam.customerPhoneNumber = ThuHoSOMDataManager.shared.orderParam.customerPhoneNumber
        tempOrderParam.warehouseCode = ThuHoSOMDataManager.shared.orderParam.warehouseCode
        tempOrderParam.regionCode = ThuHoSOMDataManager.shared.orderParam.regionCode
        tempOrderParam.creationBy = ThuHoSOMDataManager.shared.orderParam.creationBy
        tempOrderParam.creationTime = ThuHoSOMDataManager.shared.orderParam.creationTime
        tempOrderParam.referenceSystem = ThuHoSOMDataManager.shared.orderParam.referenceSystem
        tempOrderParam.referenceValue = ThuHoSOMDataManager.shared.orderParam.referenceValue
        tempOrderParam.orderTransactionDtos = ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos
        tempOrderParam.payments = ThuHoSOMDataManager.shared.orderParam.payments
        tempOrderParam.id = ThuHoSOMDataManager.shared.orderParam.id
        tempOrderParam.ip = ThuHoSOMDataManager.shared.orderParam.ip
        
        let payment = ThuHoSOMPaymentDetailParam(JSON: [:])!
        payment.paymentType = "4"
        payment.paymentAccountNumber = voucher.voucherAccount
        payment.paymentCode = voucher.voucherCode
        payment.paymentCodeDescription = voucher.voucherName
        payment.paymentValue = voucher.voucherAmount
        
        tempOrderParam.payments.append(payment)
    }
    
    private func updatePaymentParam(payments: [ThuHoSOMPaymentDetail]) {
        var paymentParams: [ThuHoSOMPaymentDetailParam] = []
        for payment in payments {
            let param = ThuHoSOMPaymentDetailParam(JSON: [:])!
            param.paymentType = String(payment.paymentType)
            param.paymentCode = payment.paymentCode
            param.paymentValue = payment.paymentValue
            param.bankType = payment.bankType
            param.cardType = payment.cardType
            param.paymentExtraFee = payment.paymentExtraFee
            param.paymentPercentFee = payment.paymentPercentFee
            param.cardTypeDescription = payment.cardTypeDescription
            param.bankTypeDescription = payment.bankTypeDescription
            param.isCardOnline = payment.isCardOnline
            param.paymentAccountNumber = payment.paymentAccountNumber
            param.paymentCodeDescription = payment.paymentCodeDescription
//            param.isChargeOnCash = payment.isChargeOnCash
            
            paymentParams.append(param)
        }
        
        ThuHoSOMDataManager.shared.orderParam.payments = paymentParams
    }
    
    private func addPayment() {
        Provider.shared.thuhoSOMAPIService.addPayment(param: tempOrderParam, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            var dtos: [ThuHoSOMOrderTransactionDtoParam] = []
            let dto = ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos.first!
            dto.totalAmount = data.orderTransactionDtos.first?.totalAmount
            dto.totalFee = data.orderTransactionDtos.first?.totalFee
            dto.totalAmountIncludingFee = data.orderTransactionDtos.first?.totalAmountIncludingFee ?? 0
            dtos.append(dto)
            
            ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos = dtos
            ThuHoSOMDataManager.shared.orderDetail = data
            self.updatePaymentParam(payments: data.payments)
            
            self.didChangePayment?()
            self.navigationController?.popViewController(animated: true)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        guard validateVoucher() else { return }
        
        let total = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.totalAmountIncludingFee ?? 0
        let price = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.price ?? 0
        let legacyID = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.referenceCode ?? ""
        let categoryID = ThuHoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.categoryId ?? ""
        let cash = ThuHoSOMDataManager.shared.orderDetail.payments.first(where: { $0.paymentType == 1 })?.paymentValue ?? 0
        let cards = ThuHoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == 2 }
        var card: Int = 0
        for item in cards {
            card += item.paymentValue
        }
        
        Provider.shared.thecaoSOMAPIService.getVoucher(code: tfVoucher.text&, cash: cash, card: card, total: total, price: price, legacyID: legacyID, categoryID: categoryID, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            self.prepareParam(voucher: data)
            self.addPayment()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
}

extension ThuHoSOMBikeInsuranceAddVoucherViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfVoucher {
            textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
            return false
        }
        
        return true
    }
}
