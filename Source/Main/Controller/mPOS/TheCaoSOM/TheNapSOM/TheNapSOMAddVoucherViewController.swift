//
//  TheNapSOMAddVoucherViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class TheNapSOMAddVoucherViewController: UIViewController {

    @IBOutlet weak var tfVoucher: UITextField!
    @IBOutlet weak var btnConfirm: UIButton!
    
    private var tempOrderParam: TheNapSOMOrderDetail = TheNapSOMOrderDetail(JSON: [:])!
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
        
        let vouchers = TheCaoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == "4" }
        if vouchers.contains(where: { $0.paymentCode == voucher }) {
            showAlertOneButton(title: "Thông báo", with: "Voucher của bạn đã tồn tại vui lòng xóa voucher hoặc thêm voucher khác", titleButton: "OK")
            return false
        }
        
        return true
    }
    
    private func prepareParam(voucher: TheNapSOMVoucher) {
        tempOrderParam.orderStatus = TheCaoSOMDataManager.shared.orderDetail.orderStatus
        tempOrderParam.warehouseCode = TheCaoSOMDataManager.shared.orderDetail.warehouseCode
        tempOrderParam.warehouseAddress = TheCaoSOMDataManager.shared.orderDetail.warehouseAddress
        tempOrderParam.creationBy = TheCaoSOMDataManager.shared.orderDetail.creationBy
        tempOrderParam.creationTime = TheCaoSOMDataManager.shared.orderDetail.creationTime
        tempOrderParam.referenceSystem = TheCaoSOMDataManager.shared.orderDetail.referenceSystem
        tempOrderParam.orderTransactionDtos = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos
        tempOrderParam.payments = TheCaoSOMDataManager.shared.orderDetail.payments
        
        let payment = TheNapSOMPayment(JSON: [:])!
        payment.paymentType = "4"
        payment.paymentAccountNumber = voucher.voucherAccount
        payment.paymentCode = voucher.voucherCode
        payment.paymentCodeDescription = voucher.voucherName
        payment.paymentValue = voucher.voucherAmount
        
        tempOrderParam.payments.append(payment)
    }
    
    private func addPayment() {
        Provider.shared.thecaoSOMAPIService.addPayment(param: tempOrderParam, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            TheCaoSOMDataManager.shared.orderDetail = data
            
            self.didChangePayment?()
            self.navigationController?.popViewController(animated: true)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        guard validateVoucher() else { return }
        
        let total = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.totalAmountIncludingFee ?? 0
        let price = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.price ?? 0
        let legacyID = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.referenceCode ?? ""
        let categoryID = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.categoryID ?? ""
        let cash = TheCaoSOMDataManager.shared.orderDetail.payments.first(where: { $0.paymentType == "1" })?.paymentValue ?? 0
        let cards = TheCaoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType == "2" }
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

extension TheNapSOMAddVoucherViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfVoucher {
            textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
            return false
        }
        
        return true
    }
}
