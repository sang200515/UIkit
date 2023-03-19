//
//  AddCardViewController.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 08/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown

class AddCardViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var cardTypeLabel: UILabel!
    @IBOutlet weak var selectCardView: UIView!
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var selectCardType: UIView!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    @IBOutlet weak var cardCodeTxt: UITextField!
    
    
    var onAdd: ((ViettelPayOrder_Payment)-> Void)?
    let dropDownMenuType = DropDown()
    let dropDownMenu = DropDown()
    var paymentTypeData: VASPaymentType?
    var cardData: VASCard?
    var currentString = ""
    
    var selectedPayment: ItemCard?
    var selectedCard: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Thanh toán bằng thẻ"
        
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(backAction), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        getpayMentType()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onclickPayemntType))
        selectCardView.isUserInteractionEnabled = true
        selectCardView.addGestureRecognizer(gesture)
        
        let cardGesture = UITapGestureRecognizer(target: self, action: #selector(onclickCards))
        selectCardType.isUserInteractionEnabled = true
        selectCardType.addGestureRecognizer(cardGesture)
        
        
        moneyTextField.keyboardType = UIKeyboardType.numberPad
        moneyTextField.returnKeyType = UIReturnKeyType.done
        moneyTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        moneyTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        moneyTextField.delegate = self
        moneyTextField.addTarget(self, action: #selector(textFieldDidChangeMoney(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChangeMoney(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s).\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
            self.moneyTextField.text = str
        }else{
            textField.text = ""
            self.moneyTextField.text = ""
        }
        
    }
    
    @objc func onclickPayemntType() {
        self.view.endEditing(true)
        dropDownMenuType.anchorView = selectCardView
        dropDownMenuType.bottomOffset = CGPoint(x: 0, y:(dropDownMenuType.anchorView?.plainView.bounds.height)! + 5)
        dropDownMenuType.dataSource = self.paymentTypeData?.items.map({ object in
            return (object.name)
        }) ?? []
        
        dropDownMenuType.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dropDownMenuType.selectionAction = { [weak self] (index, item) in
            self?.cardTypeLabel.text = item
            let card: ItemCard? = self?.paymentTypeData?.items[index]
            self?.selectedPayment = card
        }
        dropDownMenuType.show()
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onclickCards() {
        self.view.endEditing(true)
        dropDownMenu.anchorView = selectCardType
        dropDownMenu.cellHeight = 70
        dropDownMenu.direction = .bottom
        dropDownMenu.cellNib = UINib(nibName: "CustomDropDownCell", bundle: nil)
        dropDownMenu.bottomOffset = CGPoint(x: 0, y:(dropDownMenu.anchorView?.plainView.bounds.height)! + 5)
        
        dropDownMenu.customCellConfiguration = { (index:Index,item: String, cell: DropDownCell) in
            guard let acell = cell as? CustomDropDownCell else {return}
            acell.titleLabel.text = self.cardData?.items[index].name
            acell.subLabel.text = "\(self.cardData?.items[index].percentFee.removeZerosFromEnd() ?? "")%"
        }
        dropDownMenu.dataSource = self.cardData?.items.map({ object in
            return (object.name)
        }) ?? []
        
        dropDownMenu.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dropDownMenu.selectionAction = { [weak self] (index, item) in
            self?.cardNameLabel.text = item
            let paymentType: Card? = self?.cardData?.items[index]
            self?.percentLabel.text = "\(paymentType?.percentFee.removeZerosFromEnd() ?? "")%"
            self?.selectedCard = paymentType
        }
        dropDownMenu.show()
    }
    
    
    func getpayMentType() {
        let group = DispatchGroup()
        let queue1 = DispatchQueue(label: "queue1")
        let queue2 = DispatchQueue(label: "queue2")
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            group.enter()
            queue1.async {
                VASViettelApiManager.shared.getPaymentTypes { (data, err) in
                    group.leave()
                    if let paymenTypes = data {
                        self.paymentTypeData = paymenTypes
                        self.selectedPayment = paymenTypes.items.first
                        self.cardTypeLabel.text = paymenTypes.items.first?.name
                    } else {
                        self.showPopupWith(content: err)
                    }
                }
            }
            
            
            group.enter()
            queue2.async {
                VASViettelApiManager.shared.getCards { (data, err) in
                    group.leave()
                    if let card = data {
                        self.cardData = card
                        self.selectedCard = card.items.first
                        self.cardNameLabel.text = card.items.first?.name
                        self.percentLabel.text = "\(card.items.first?.percentFee.removeZerosFromEnd() ?? "0")%"
                    } else {
                        self.showPopupWith(content: err)
                    }
                }
            }
            group.notify(queue: .main, execute: {
                WaitingNetworkResponseAlert.DismissWaitingAlert {}
            })
        }
    }
    
    
    
    func showPopupWith(content: String) {
        let popup = PopupVC()
        popup.onOKAction = {}
        popup.dataPopup.content = content
        popup.modalPresentationStyle = .overCurrentContext
        popup.modalTransitionStyle = .crossDissolve
        self.present(popup, animated: true, completion: nil)
    }
    
    
    func isValidateOK() -> (isOK:Bool,message: String) {
        let isMoneyOK = moneyTextField.text != ""
        let isCardCodeOK = cardCodeTxt.text != ""
        let cardOK = selectedCard != nil
        let typeOK = selectedPayment != nil
        if isMoneyOK && isCardCodeOK && cardOK && typeOK {
            return (true, "")
        } else {
            if !typeOK {
                return (false,"Vui lòng chọn thẻ")
            } else if !isMoneyOK {
                return (false,"Vui lòng nhập số tiền")
            } else if !cardOK {
                return (false,"Vui lòng chọn loại thẻ")
            } else if !isCardCodeOK {
                return (false,"Vui lòng nhập mã thẻ")
            }
        }
        return (false,"")
    }
    
    @IBAction func addCardAction(_ sender: Any) {
        if isValidateOK().isOK {
            self.navigationController?.popViewController(animated: true)
            let money = (moneyTextField.text?.replace(".", withString: "").replace(",", withString: ""))!
            let newmoney = Double(money)
            let myPayment: ViettelPayOrder_Payment = ViettelPayOrder_Payment(paymentType: 2,
                                                                             paymentCode: cardCodeTxt.text!,
                                                                             paymentCodeDescription: "", paymentAccountNumber: "",
                                                                             paymentValue: newmoney ?? 0,
                                                                             bankType: selectedPayment!.code, bankTypeDescription: selectedPayment!.name,
                                                                             cardType: selectedCard!.code, cardTypeDescription: selectedCard!.name,
                                                                             isCardOnline: false,
                                                                             paymentExtraFee: 0,
                                                                             paymentPercentFee: selectedCard!.percentFee,
                                                                             isChargeOnCash: false)
            if let add = onAdd {
                add(myPayment)
            }
        } else {
            showPopupWith(content: isValidateOK().message)
        }
    }
}

