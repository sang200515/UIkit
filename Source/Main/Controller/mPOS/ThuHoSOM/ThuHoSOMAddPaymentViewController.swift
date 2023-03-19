//
//  ThuHoSOMAddPaymentViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 02/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown

class ThuHoSOMAddPaymentViewController: UIViewController {
    
    @IBOutlet weak var stvPaymentType: UIStackView!
    @IBOutlet weak var tfPaymentType: UITextField!
    @IBOutlet weak var stvCardType: UIStackView!
    @IBOutlet weak var tfCardType: UITextField!
    @IBOutlet weak var stvCardCode: UIStackView!
    @IBOutlet weak var tfCardCode: UITextField!
    @IBOutlet weak var stvBank: UIStackView!
    @IBOutlet weak var tfBank: UITextField!
    @IBOutlet weak var stvAccountNo: UIStackView!
    @IBOutlet weak var tfAccountNo: UITextField!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var vChargeOnCash: UIView!
    @IBOutlet weak var imgChargeOnCash: UIImageView!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var lbPaymentNote: UILabel!
    
    var didChangePayment: (() -> Void)?
    var isTransfer: Bool = false
    private let banks = DropDown()
    private let cards = DropDown()
    private let types = DropDown()
//    private var isChargeOnCash: Bool = false
    private var tempOrderParam: ThuHoSOMOrderParam = ThuHoSOMOrderParam(JSON: [:])!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        configureDropDowns()
    }
    
    private func setupUI() {
        title = isTransfer ? "Chuyển Khoản" : "Thanh Toán Thẻ"
        addBackButton()
        
        btnConfirm.roundCorners(.allCorners, radius: 5)
        tfPaymentType.withImage(direction: .right, image: UIImage(named: "ArrowDown-1")!)
        tfCardType.withImage(direction: .right, image: UIImage(named: "ArrowDown-1")!)
        tfBank.withImage(direction: .right, image: UIImage(named: "ArrowDown-1")!)
        
        if isTransfer {
            stvPaymentType.isHidden = true
            stvCardType.isHidden = true
            stvCardCode.isHidden = true
            stvBank.isHidden = false
            stvAccountNo.isHidden = false
//            vChargeOnCash.isHidden = true
            lbPaymentNote.isHidden = true
            
            btnConfirm.setTitle("Thêm Tài Khoản", for: .normal)
        } else {
            stvPaymentType.isHidden = false
            stvCardType.isHidden = false
            stvCardCode.isHidden = false
            stvBank.isHidden = true
            stvAccountNo.isHidden = true
//            vChargeOnCash.isHidden = false
            lbPaymentNote.isHidden = false
            
            btnConfirm.setTitle("Thêm Thẻ", for: .normal)
        }
    }
    
    private func configureDropDowns() {
        DropDown.startListeningToKeyboard()
        
        if isTransfer {
            banks.direction = .bottom
            banks.bottomOffset = CGPoint(x: 0, y: tfBank.bounds.height)
            banks.anchorView = tfBank
            
            banks.selectionAction = { [weak self] index, item in
                guard let self = self else { return }
                self.view.endEditing(true)
                self.tfBank.text = item
            }
        } else {
            cards.direction = .bottom
            cards.bottomOffset = CGPoint(x: 0, y: tfCardType.bounds.height)
            cards.anchorView = tfCardType
            
            cards.selectionAction = { [weak self] index, item in
                guard let self = self else { return }
                self.view.endEditing(true)
                self.tfCardType.text = item
            }
            
            types.direction = .bottom
            types.bottomOffset = CGPoint(x: 0, y: tfPaymentType.bounds.height)
            types.anchorView = tfPaymentType
            
            types.selectionAction = { [weak self] index, item in
                guard let self = self else { return }
                self.view.endEditing(true)
                self.tfPaymentType.text = item
            }
        }
    }
    
    private func loadData() {
        if isTransfer {
            guard ThuHoSOMDataManager.shared.banks.count < 1 else { return }
            Provider.shared.thuhoSOMAPIService.getBanks(success: { result in
                guard let data = result else { return }
                ThuHoSOMDataManager.shared.banks = data.items
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        } else {
            if ThuHoSOMDataManager.shared.cards.count < 1 {
                Provider.shared.thuhoSOMAPIService.getCards(success: { result in
                    guard let data = result else { return }
                    ThuHoSOMDataManager.shared.cards = data.items
                }, failure: { [weak self] error in
                    guard let self = self else { return }
                    self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
                })
            }
            
            if ThuHoSOMDataManager.shared.paymentTypes.count < 1 {
                Provider.shared.thuhoSOMAPIService.getPaymentTypes(success: { result in
                    guard let data = result else { return }
                    ThuHoSOMDataManager.shared.paymentTypes = data.items
                }, failure: { [weak self] error in
                    guard let self = self else { return }
                    self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
                })
            }
        }
    }
    
    private func validateInputs() -> Bool {
        if isTransfer {
            guard let bank = tfBank.text, !bank.isEmpty else {
                showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn ngân hàng", titleButton: "OK")
                return false
            }
            
            guard ThuHoSOMDataManager.shared.banks.contains(where: { $0.name == bank }) else {
                showAlertOneButton(title: "Thông báo", with: "Ngân hàng không hợp lệ. Vui lòng chọn lại", titleButton: "OK")
                return false
            }
            
            guard let number = tfAccountNo.text, !number.isEmpty else {
                showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập số tài khoản", titleButton: "OK")
                return false
            }
        } else {
            guard let type = tfPaymentType.text, !type.isEmpty else {
                showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn ngân hàng máy POS", titleButton: "OK")
                return false
            }
            
            guard ThuHoSOMDataManager.shared.paymentTypes.contains(where: { $0.name == type }) else {
                showAlertOneButton(title: "Thông báo", with: "Ngân hàng máy POS không hợp lệ. Vui lòng chọn lại", titleButton: "OK")
                return false
            }
            
            guard let card = tfCardType.text, !card.isEmpty else {
                showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn loại thẻ", titleButton: "OK")
                return false
            }
            
            guard ThuHoSOMDataManager.shared.cards.contains(where: { $0.name == card }) else {
                showAlertOneButton(title: "Thông báo", with: "Loại thẻ không hợp lệ. Vui lòng chọn lại", titleButton: "OK")
                return false
            }
            
            guard let code = tfCardCode.text, !code.isEmpty else {
                showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập mã thẻ", titleButton: "OK")
                return false
            }
        }
        
        guard let amount = tfAmount.text, !amount.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập số tiền", titleButton: "OK")
            return false
        }
        
        let paymentValue = Int(amount.replace(".", withString: "").replace(",", withString: "")) ?? 0
        var totalPayment = 0
        for payment in (ThuHoSOMDataManager.shared.orderParam.payments.filter { $0.paymentType != "1" }) {
            totalPayment += (payment.paymentValue ?? 0)
        }
        let totalAmount = ThuHoSOMDataManager.shared.orderParam.orderTransactionDtos.first?.totalAmountIncludingFee ?? 0
        if paymentValue > totalAmount - totalPayment {
            showAlertOneButton(title: "Thông báo", with: "Số tiền bạn nhập đã vượt quá tổng số tiền cần thanh toán. Vui lòng nhập lại", titleButton: "OK")
            return false
        }
        
        return true
    }
    
    private func prepareParam() {
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
        if isTransfer {
            let bank = ThuHoSOMDataManager.shared.banks.first { $0.name == tfBank.text& }!
            payment.paymentType = "3"
            payment.paymentCode = tfAccountNo.text&
            payment.paymentValue = Int(tfAmount.text&.replace(".", withString: "").replace(",", withString: "")) ?? 0
            payment.bankType = bank.code
            payment.bankTypeDescription = bank.name
        } else {
            let type = ThuHoSOMDataManager.shared.paymentTypes.first { $0.name == tfPaymentType.text& }!
            let card = ThuHoSOMDataManager.shared.cards.first { $0.name == tfCardType.text& }!
            payment.paymentType = "2"
            payment.paymentCode = tfCardCode.text&
            payment.paymentValue = Int(tfAmount.text&.replace(".", withString: "").replace(",", withString: "")) ?? 0
            payment.bankType = type.code
            payment.cardType = card.code
            payment.paymentPercentFee = card.percentFee
            payment.cardTypeDescription = card.name
            payment.bankTypeDescription = type.name
            payment.isCardOnline = type.isCardOnline
//            payment.isChargeOnCash = isChargeOnCash
        }
        
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
    
    @IBAction func chargeOnCashButtonPressed(_ sender: Any) {
//        let check = UIImage(named: "check-1")!
//        let uncheck = UIImage(named: "check-2")!
//        isChargeOnCash = !isChargeOnCash
        
//        imgChargeOnCash.image = isChargeOnCash ? check : uncheck
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        guard validateInputs() else { return }
        
        prepareParam()
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
}

extension ThuHoSOMAddPaymentViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfBank {
            banks.dataSource = ThuHoSOMDataManager.shared.banks.map { $0.name }
            banks.show()
        } else if textField == tfCardType {
            var listCard: [String] = []
            if ThuHoSOMDataManager.shared.selectedCatagory.products.first?.configs.first?.allowCardPayment ?? true {
                listCard = ThuHoSOMDataManager.shared.cards.map { $0.name }
            } else {
                listCard = ThuHoSOMDataManager.shared.cards.filter { $0.name == "Nội địa" }.map { $0.name }
            }
            cards.dataSource = listCard
            cards.show()
        } else if textField == tfPaymentType {
            types.dataSource = ThuHoSOMDataManager.shared.paymentTypes.map { $0.name }
            types.show()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfBank {
            let text = textField.text&
            if (text.isEmpty) {
                return true
            }
            
            var listDataSuggest: [String] = []
            let locale = Locale(identifier: "vi_VN")
            for item in ThuHoSOMDataManager.shared.banks {
                let string = item.name.folding(options: .diacriticInsensitive, locale: locale)
                if string.contains(text.folding(options: .diacriticInsensitive, locale: locale), caseSensitive: false) {
                    listDataSuggest.append(item.name)
                }
            }
            
            banks.dataSource = listDataSuggest
            banks.show()
        } else if textField == tfCardType {
            let text = textField.text&
            if (text.isEmpty) {
                return true
            }
            
            var listDataSuggest: [ThuHoSOMCardItem] = []
            let locale = Locale(identifier: "vi_VN")
            for item in ThuHoSOMDataManager.shared.cards {
                let string = item.name.folding(options: .diacriticInsensitive, locale: locale)
                if string.contains(text.folding(options: .diacriticInsensitive, locale: locale), caseSensitive: false) {
                    listDataSuggest.append(item)
                }
            }
            
            var listCard: [String] = []
            if ThuHoSOMDataManager.shared.selectedCatagory.products.first?.configs.first?.allowCardPayment ?? true {
                listCard = listDataSuggest.map { $0.name }
            } else {
                listCard = listDataSuggest.filter { $0.name == "Nội địa" }.map { $0.name }
            }
            cards.dataSource = listCard
            cards.show()
        } else if textField == tfPaymentType {
            let text = textField.text&
            if (text.isEmpty) {
                return true
            }
            
            var listDataSuggest: [String] = []
            let locale = Locale(identifier: "vi_VN")
            for item in ThuHoSOMDataManager.shared.paymentTypes {
                let string = item.name.folding(options: .diacriticInsensitive, locale: locale)
                if string.contains(text.folding(options: .diacriticInsensitive, locale: locale), caseSensitive: false) {
                    listDataSuggest.append(item.name)
                }
            }
            
            types.dataSource = listDataSuggest
            types.show()
        } else if textField == tfAmount {
            var text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            text = text.replace(".", withString: "").replace(",", withString: "")
            textField.text = "\(Common.convertCurrencyV2(value: Int(text) ?? 0))"
            
            return false
        }
        
        return true
    }
}
