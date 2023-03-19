//
//  ShinhanTragopCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 07/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ShinhanTragopCell: UITableViewCell {

    
    @IBOutlet weak var goitragop: CustomTxt!
    @IBOutlet weak var kyhan: CustomTxt!
    @IBOutlet weak var tientratruoc: CustomTxt!
    @IBOutlet weak var laisuatLbl: UILabel!
    
    var onlick:((Int)-> Void)?
    var onChangeTxt:((Float)-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        tientratruoc.keyboard = .numberPad
        goitragop.delegateTextfield = self
        kyhan.delegateTextfield = self
        tientratruoc.delegateTextfield = self
    }
    
    func bindCell(pack:ShinhanTragopData?,selectedKyHan: ShinhanLoanTenure?) {
        if pack != nil {
            goitragop.textfield.text = pack?.schemeName
            laisuatLbl.text = pack?.schemeDetails
        } else {
            laisuatLbl.text = ""
        }
        if kyhan != nil {
            kyhan.textfield.text = selectedKyHan?.text
        }
        if ShinhanData.tientraTruoc > 0 {
            tientratruoc.textfield.text = Common.convertCurrencyFloat(value: ShinhanData.tientraTruoc).replace("đ", withString: "").trim()
        }
    }
    
}

extension ShinhanTragopCell:CustomTxtDelegate {
    func onClickButton(txt: CustomTxt, tag: Int) {
        if let click = onlick {
            if txt == goitragop {
                click(0) // goi tragop
            } else {
                click(1) // ky han
            }
        }
    }
    
    func txtDidChange(txt: CustomTxt, value: String) {
        if txt == tientratruoc {
            if let change = onChangeTxt {
                change(Float(value.trimMoney()) ?? 0)
            }
        }
    }
}
