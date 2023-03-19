//
//  CardInfoCell.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 08/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class CardInfoCell: UITableViewCell {

    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardTypeName: UILabel!
    @IBOutlet weak var cardAreaLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var mainVIew: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainVIew.layer.cornerRadius = 5
        mainVIew.layer.borderWidth = 1
        mainVIew.layer.borderColor = UIColor.lightGray.cgColor
        mainVIew.layer.masksToBounds = true
    }
    
    func bindCells(with data: ViettelPayOrder_Payment) {
        cardNumberLabel.text = data.paymentCode
        cardTypeName.text = data.bankTypeDescription
        cardAreaLabel.text = data.cardTypeDescription
        moneyLabel.text = "\(Common.convertCurrencyDouble(value: data.paymentValue))đ"
        feeLabel.text = "\(Common.convertCurrencyDouble(value: data.paymentExtraFee))đ"
    }

}
