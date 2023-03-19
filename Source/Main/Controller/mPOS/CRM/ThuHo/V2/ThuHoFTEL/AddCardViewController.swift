//
//  AddCardViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 09/04/2021.
//  Copyright © 2021 Duong Hoang Minh. All rights reserved.
//

import UIKit
import DropDown

class AddCardViewController: UIViewController {

    @IBOutlet weak var tfCard: UITextField!
    @IBOutlet weak var tfTotal: UITextField!
    @IBOutlet weak var tfCardType: UITextField!
    @IBOutlet weak var tfCardNumber: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    
    private let cardDropDown = DropDown()
    private let cardTypeDropDown = DropDown()
    private var cards: FtelCard = FtelCard(JSON: [:])!
    private var cardTypes: FtelCardType = FtelCardType(JSON: [:])!
    private var selectedCardIndex = -1
    private var selectedCardTypeIndex = -1
    var addCardParam: FtelAddCardParam = FtelAddCardParam(JSON: [:])!
    var ftelPaymentVC: FtelPaymentViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupViews()
    }

    private func setupViews() {
        title = "Thanh toán bằng thẻ"
        addBackButton()

        btnAdd.makeCorner(corner: 5)
        btnAdd.layer.borderWidth = 0.5
        btnAdd.layer.borderColor = UIColor.white.cgColor
        
        DropDown.startListeningToKeyboard()
        cardDropDown.anchorView = tfCard
        cardTypeDropDown.anchorView = tfCardType
        cardTypeDropDown.cellNib = UINib(nibName: "CardTypeTableViewCell", bundle: nil)
        cardTypeDropDown.cellHeight = 80
        
        cardDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfCard.text = self.cards.items[index].name
            self.selectedCardIndex = index
        }
        
        cardTypeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfCardType.text = self.cardTypes.items[index].name
            self.selectedCardTypeIndex = index
        }
    }
    
    private func loadData() {
        Provider.shared.thuHoFtelAPIService.getListFtelCard(success: { [weak self] data in
            guard let self = self, let cards = data else { return }
            self.cards = cards
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
        })
        
        Provider.shared.thuHoFtelAPIService.getListFtelCardType(success: { [weak self] data in
            guard let self = self, let cardTypes = data else { return }
            self.cardTypes = cardTypes
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
        })
    }
    
    private func checkValidation() -> Bool {
        if let card = tfCard.text, card.isEmpty {
            self.showPopUp("Vui lòng chọn thẻ", "Thông báo", buttonTitle: "OK")
            return false
        }
        
        if let total = tfTotal.text, total.isEmpty {
            self.showPopUp("Vui lòng nhập số tiền", "Thông báo", buttonTitle: "OK")
            return false
        }
        
        if let type = tfCardType.text, type.isEmpty {
            self.showPopUp("Vui lòng chọn loại thẻ", "Thông báo", buttonTitle: "OK")
            return false
        }
        
        if let number = tfCardNumber.text, number.isEmpty {
            self.showPopUp("Vui lòng nhập số thẻ", "Thông báo", buttonTitle: "OK")
            return false
        }
        
        return true
    }
    
    private func prepareParam() {
        addCardParam.creationTime = Date().stringWith(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        addCardParam.referenceSystem = "MPOS"
        
        let payment = FtelPayment(JSON: [:])!
        payment.paymentType = 2
        payment.paymentCode = tfCardNumber.text ?? ""
        payment.paymentValue = Int(tfTotal.text ?? "0") ?? 0
        payment.bankType = cards.items[selectedCardIndex].code
        payment.cardType = cardTypes.items[selectedCardTypeIndex].code
        payment.paymentExtraFee = 0
        payment.paymentPercentFee = cardTypes.items[selectedCardTypeIndex].percentFee
        payment.cardTypeDescription = cardTypes.items[selectedCardTypeIndex].name
        payment.bankTypeDescription = cards.items[selectedCardIndex].name
        payment.isCardOnline = cards.items[selectedCardIndex].isCardOnline == "1"
        payment.isChargeOnCash = cardTypes.items[selectedCardTypeIndex].isCredit
        
        addCardParam.payments.append(payment)
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        guard checkValidation() else { return }
        prepareParam()
        
        Provider.shared.thuHoFtelAPIService.ftelCardAction(param: addCardParam, isAdd: true, success: { [weak self] data in
            guard let self = self, let detail = data else { return }
            self.ftelPaymentVC.orderDetail = detail
            self.ftelPaymentVC.refreshViews()
            self.navigationController?.popViewController(animated: true)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
        })
    }
}

extension AddCardViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfCard {
            cardDropDown.dataSource = self.cards.items.map { $0.name }
            cardDropDown.show()
            return false
        } else if textField == tfCardType {
            cardTypeDropDown.dataSource = self.cardTypes.items.map { $0.name }
            cardTypeDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
                guard let cell = cell as? CardTypeTableViewCell else { return }
                cell.lbFee.text = "Phí: \(self.cardTypes.items[index].percentFee)%"
            }
            cardTypeDropDown.show()
            return false
        }

        return true
    }
}
