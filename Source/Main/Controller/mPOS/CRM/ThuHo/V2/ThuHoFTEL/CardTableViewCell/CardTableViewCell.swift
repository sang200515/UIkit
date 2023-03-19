//
//  CardTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 09/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbCardCode: UILabel!
    @IBOutlet weak var lbCard: UILabel!
    @IBOutlet weak var lbCardType: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var lbFee: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        vBackground.makeCorner(corner: 5)
        vBackground.layer.borderWidth = 1.5
        vBackground.layer.borderColor = UIColor(hexString: "F5F5F5").cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(card: FtelPayment) {
        lbCardCode.text = card.paymentCode
        lbCard.text = card.bankTypeDescription
        lbCardType.text = card.cardTypeDescription
        
        let value = Float(card.paymentValue)
        lbTotal.text = "\(Common.convertCurrencyFloat(value: value))"
        lbFee.text = "\(card.paymentPercentFee)%"
    }
}
