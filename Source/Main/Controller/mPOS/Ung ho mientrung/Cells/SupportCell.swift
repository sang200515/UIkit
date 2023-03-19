//
//  SupportCell.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 05/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class SupportCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var checkBoxLabel: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var moneyText: UITextField!
    @IBOutlet weak var moneyStackView: UIStackView!
    
    var onUPdateMoney: ((String) -> Void)?
    var onselectedTxt: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        moneyText.keyboardType = UIKeyboardType.numberPad
        moneyText.delegate = self
        moneyText.returnKeyType = UIReturnKeyType.done
        moneyText.clearButtonMode = UITextField.ViewMode.whileEditing
        moneyText.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        moneyText.addTarget(self, action: #selector(textFieldDidChangeMoney(_:)), for: .editingChanged)
    }
    
    func bindCell(item: ItemKhaoSatMienTrung) {
        numberLabel.text = "\(item.stt)."
        checkBoxLabel.image = item.isSelected ? UIImage(named: "support_checked") : UIImage(named: "support_uncheck")
        contentLabel.text = item.descriptionStr
        moneyStackView.isHidden = item.value == "15" && item.isSelected ? false : true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let select = onselectedTxt {
            select()
        }
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
            self.moneyText.text = str
        }else{
            textField.text = ""
            self.moneyText.text = ""
        }
        
        let money = self.moneyText.text?.replacingOccurrences(of: ".", with: "")
        if let update = onUPdateMoney {
            update(money ?? "")
        }
    }
}
