//
//  TheNapSOMAddPaymentViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 26/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown

class TheNapSOMAddPaymentViewController: UIViewController {

    @IBOutlet weak var tfPaymentType: UITextField!
    @IBOutlet weak var tfCardType: UITextField!
    @IBOutlet weak var tfCardCode: UITextField!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var btnConfirm: UIButton!
    
    var didChangePayment: (() -> Void)?
    private let cards = DropDown()
    private let types = DropDown()
    private var tempOrderParam: TheNapSOMOrderDetail = TheNapSOMOrderDetail(JSON: [:])!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        configureDropDowns()
    }
    
    private func setupUI() {
        title = "Thanh Toán Thẻ"
        addBackButton()
        
        btnConfirm.roundCorners(.allCorners, radius: 5)
        tfPaymentType.withImage(direction: .right, image: UIImage(named: "ArrowDown-1")!)
        tfCardType.withImage(direction: .right, image: UIImage(named: "ArrowDown-1")!)
    }
    
    private func configureDropDowns() {
        DropDown.startListeningToKeyboard()
        
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
    
    private func loadData() {
        if TheCaoSOMDataManager.shared.cards.count < 1 {
            Provider.shared.thecaoSOMAPIService.getCards(success: { result in
                guard let data = result else { return }
                TheCaoSOMDataManager.shared.cards = data.items
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        }
        
        if TheCaoSOMDataManager.shared.paymentTypes.count < 1 {
            Provider.shared.thecaoSOMAPIService.getPaymentTypes(success: { result in
                guard let data = result else { return }
                TheCaoSOMDataManager.shared.paymentTypes = data.items
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        }
    }
    
    private func validateInputs() -> Bool {
        guard let type = tfPaymentType.text, !type.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn ngân hàng máy POS", titleButton: "OK")
            return false
        }
        
        guard TheCaoSOMDataManager.shared.paymentTypes.contains(where: { $0.name == type }) else {
            showAlertOneButton(title: "Thông báo", with: "Ngân hàng máy POS không hợp lệ. Vui lòng chọn lại", titleButton: "OK")
            return false
        }
        
        guard let card = tfCardType.text, !card.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn loại thẻ", titleButton: "OK")
            return false
        }
        
        guard TheCaoSOMDataManager.shared.cards.contains(where: { $0.name == card }) else {
            showAlertOneButton(title: "Thông báo", with: "Loại thẻ không hợp lệ. Vui lòng chọn lại", titleButton: "OK")
            return false
        }
        
        guard let code = tfCardCode.text, !code.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập mã thẻ", titleButton: "OK")
            return false
        }
        
        guard let amount = tfAmount.text, !amount.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập số tiền", titleButton: "OK")
            return false
        }
        
        let paymentValue = Int(amount.replace(".", withString: "").replace(",", withString: "")) ?? 0
        var totalPayment = 0
        for payment in (TheCaoSOMDataManager.shared.orderDetail.payments.filter { $0.paymentType != "1" }) {
            totalPayment += payment.paymentValue
        }
        let totalAmount = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos.first?.totalAmountIncludingFee ?? 0
        if paymentValue > totalAmount - totalPayment {
            showAlertOneButton(title: "Thông báo", with: "Số tiền bạn nhập đã vượt quá tổng số tiền cần thanh toán. Vui lòng nhập lại", titleButton: "OK")
            return false
        }
        
        return true
    }
    
    private func prepareParam() {
        tempOrderParam.orderStatus = TheCaoSOMDataManager.shared.orderDetail.orderStatus
        tempOrderParam.warehouseCode = TheCaoSOMDataManager.shared.orderDetail.warehouseCode
        tempOrderParam.warehouseAddress = TheCaoSOMDataManager.shared.orderDetail.warehouseAddress
        tempOrderParam.creationBy = TheCaoSOMDataManager.shared.orderDetail.creationBy
        tempOrderParam.creationTime = TheCaoSOMDataManager.shared.orderDetail.creationTime
        tempOrderParam.referenceSystem = TheCaoSOMDataManager.shared.orderDetail.referenceSystem
        tempOrderParam.orderTransactionDtos = TheCaoSOMDataManager.shared.orderDetail.orderTransactionDtos
        tempOrderParam.payments = TheCaoSOMDataManager.shared.orderDetail.payments
        
        let payment = TheNapSOMPayment(JSON: [:])!
        let type = TheCaoSOMDataManager.shared.paymentTypes.first { $0.name == tfPaymentType.text& }!
        let card = TheCaoSOMDataManager.shared.cards.first { $0.name == tfCardType.text& }!
        payment.paymentType = "2"
        payment.paymentCode = tfCardCode.text&
        payment.paymentValue = Int(tfAmount.text&.replace(".", withString: "").replace(",", withString: "")) ?? 0
        payment.bankType = type.code
        payment.cardType = card.code
        payment.paymentPercentFee = card.percentFee
        payment.cardTypeDescription = card.name
        payment.bankTypeDescription = type.name
        payment.isCardOnline = type.isCardOnline
        
        tempOrderParam.payments.append(payment)
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        guard validateInputs() else { return }
        
        prepareParam()
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
}

extension TheNapSOMAddPaymentViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfCardType {
            cards.dataSource = TheCaoSOMDataManager.shared.cards.map { $0.name }
            cards.show()
        } else if textField == tfPaymentType {
            types.dataSource = TheCaoSOMDataManager.shared.paymentTypes.map { $0.name }
            types.show()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfCardType {
            let text = textField.text&
            if (text.isEmpty) {
                return true
            }
            
            var listDataSuggest: [String] = []
            let locale = Locale(identifier: "vi_VN")
            for item in TheCaoSOMDataManager.shared.cards {
                let string = item.name.folding(options: .diacriticInsensitive, locale: locale)
                if string.contains(text.folding(options: .diacriticInsensitive, locale: locale), caseSensitive: false) {
                    listDataSuggest.append(item.name)
                }
            }
            
            cards.dataSource = listDataSuggest
            cards.show()
        } else if textField == tfPaymentType {
            let text = textField.text&
            if (text.isEmpty) {
                return true
            }
            
            var listDataSuggest: [String] = []
            let locale = Locale(identifier: "vi_VN")
            for item in TheCaoSOMDataManager.shared.paymentTypes {
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
