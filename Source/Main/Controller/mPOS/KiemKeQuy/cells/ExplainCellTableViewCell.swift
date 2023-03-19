//
//  ExplainCellTableViewCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 07/09/2021.
//  Copyright © 2021 Duong Hoang Minh. All rights reserved.
//

import UIKit
import DropDown

class ExplainCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var reasonView: UIView!
    @IBOutlet weak var reasonLbl: UILabel!
    @IBOutlet weak var explainTxt: UITextField!
    @IBOutlet weak var moneyTxt: UITextField!
    @IBOutlet weak var imageBtn: UIButton!
    
    var onImage: (()->Void)?
    var onReason: ((String)->Void)?
    var onTxtChnage: ((Bool,String)->Void)?
    let dropDownMenu = DropDown()
    var currentString = ""
    var listReason = [
        "Add sai hình thức thanh toán", "Hủy cọc do máy không đủ điều kiện bán, lỗi NSX, không có hàng => QA CF", "Hủy phiếu thu hộ", "Lỗi hệ thống", "Nộp hộ Shop khác","Lý do khác"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindCell(item: ExplainItem, isViewOnly: Bool) {
        if isViewOnly {
            moneyTxt.isUserInteractionEnabled = false
            reasonView.isUserInteractionEnabled = false
            reasonLbl.isUserInteractionEnabled = false
            explainTxt.isUserInteractionEnabled = false
        }
        moneyTxt.delegate = self
        switch item.reasonCode {
        case "1":
            reasonLbl.text = listReason[0]
        case "2":
            reasonLbl.text = listReason[1]
        case "3":
            reasonLbl.text = listReason[2]
        case "4":
            reasonLbl.text = listReason[3]
        case "5":
            reasonLbl.text = listReason[4]
        case "6":
            reasonLbl.text = listReason[5]
        default:
            break
        }
        addNumericAccessory(addPlusMinus: true)
        explainTxt.text = item.explain
        formatCurrency(text: item.money,isBack: false)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(setupDrop))
        self.reasonView.addGestureRecognizer(gesture)
        explainTxt.addTarget(self, action: #selector(txtDidChange(txt:)), for: .editingChanged)
        moneyTxt.addTarget(self, action: #selector(txtDidChange(txt:)), for: .editingChanged)
//        addToolbar()
    }
    
    func addNumericAccessory(addPlusMinus: Bool) {
        let numberToolbar = UIToolbar()
        numberToolbar.barStyle = UIBarStyle.default
        
        var accessories : [UIBarButtonItem] = []
        
        if addPlusMinus {
            accessories.append(UIBarButtonItem(title: "+/-", style: UIBarButtonItem.Style.plain, target: self, action: #selector(plusMinusPressed)))
            accessories.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))   //add padding after
        }
        
        accessories.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))   //add padding space
        accessories.append(UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(numberPadDone)))
        
        numberToolbar.items = accessories
        numberToolbar.sizeToFit()
        
        moneyTxt.inputAccessoryView = numberToolbar
    }
    
    @objc func numberPadDone() {
        moneyTxt.resignFirstResponder()
    }
    
    @objc func plusMinusPressed() {
        guard let currentText = moneyTxt.text else {
            return
        }
        if currentText.hasPrefix("-") {
            let offsetIndex = currentText.index(currentText.startIndex, offsetBy: 1)
            let substring = currentText[offsetIndex...]  //remove first character
            moneyTxt.text = String(substring)
        } else {
            moneyTxt.text = "-" + currentText
        }
        formatCurrency(text: moneyTxt.text ?? "")
    }
    
   
    func formatCurrency(text: String,isBack: Bool = true) {
        currentString = text.trimMoney()
        moneyTxt.text = Common.convertCurrencyDouble(value: Double(text.trimMoney()) ?? 0)
        if isBack {
            if let change = onTxtChnage {
                change(true,moneyTxt.text?.trimMoney() ?? "0")
            }
        }
    }
    
    @objc func txtDidChange(txt: UITextField) {
        if let change = onTxtChnage {
            if txt == explainTxt {
                change(false,txt.text ?? "")
            } else {
                change(true,txt.text?.trimMoney() ?? "0")
            }
        }
    }
    
    @objc func setupDrop() {
        dropDownMenu.anchorView = reasonView
        dropDownMenu.bottomOffset = CGPoint(x: 0, y:(dropDownMenu.anchorView?.plainView.bounds.height)! + 10)
        dropDownMenu.dataSource = listReason
        dropDownMenu.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dropDownMenu.selectionAction = { [weak self] (index, item) in
            if let reason = self?.onReason {
                reason("\(index + 1)")
            }
        }
        dropDownMenu.show()
    }
    
    @IBAction func onSelectImg() {
        if let img = onImage {
            img()
        }
    }
    
}

struct ExplainItem {
    var reasonCode  = ""
    var explain  = ""
    var money = "0"
    var url = ""
    
    var isNull: Bool {
        if reasonCode == "" || explain == "" {
            return true
        } else {
            return false
        }
    }
}

extension ExplainCellTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { // return NO to not change text
        switch string {
        case "-","0","1","2","3","4","5","6","7","8","9":
            currentString += string
            print(currentString)
            formatCurrency(text: currentString)
        default:
            let array = Array(string)
            var currentStringArray = Array(currentString)
            if array.count == 0 && currentStringArray.count != 0 {
                currentStringArray.removeLast()
                currentString = ""
                for character in currentStringArray {
                    currentString += String(character)
                }
                formatCurrency(text: currentString)
            }
        }
        return false
    }
}
