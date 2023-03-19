//
//  ThuHoSOMPaymentTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 02/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ThuHoSOMPaymentTableViewCell: UITableViewCell {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbCardTitle: UILabel!
    @IBOutlet weak var lbCardCode: UILabel!
    @IBOutlet weak var lbBankTitle: UILabel!
    @IBOutlet weak var lbCard: UILabel!
    @IBOutlet weak var stvCardType: UIStackView!
    @IBOutlet weak var lbCardType: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var stvFee: UIStackView!
    @IBOutlet weak var lbFee: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vBackground.makeCorner(corner: 5)
        vBackground.layer.borderWidth = 1.5
        vBackground.layer.borderColor = UIColor(hexString: "F5F5F5").cgColor
        vBackground.dropShadowV2()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(payment: ThuHoSOMPaymentDetail) {
        if payment.paymentType == 2 {
            lbCardTitle.text = "Mã thẻ:"
            lbBankTitle.text = "Thẻ:"
            stvCardType.isHidden = false
//            stvFee.isHidden = false
            
            lbCardCode.text = payment.paymentCode
            lbCard.text = payment.bankTypeDescription
            lbCardType.text = payment.cardTypeDescription
            lbTotal.text = "\(Common.convertCurrencyV2(value: payment.paymentValue )) VNĐ"
//            lbFee.text = "\(Common.convertCurrencyV2(value: payment.paymentExtraFee)) VNĐ"
        } else {
            lbCardTitle.text = "Số tài khoản:"
            lbBankTitle.text = "Ngân hàng:"
            stvCardType.isHidden = true
//            stvFee.isHidden = true
            
            lbCardCode.text = payment.paymentCode
            lbCard.text = payment.bankTypeDescription
            lbTotal.text = "\(Common.convertCurrencyV2(value: payment.paymentValue )) VNĐ"
        }
    }
    
    func setupCell(payment: TheNapSOMPayment) {
        stvCardType.isHidden = false
        lbCardCode.text = payment.paymentCode
        lbCard.text = payment.bankTypeDescription
        lbCardType.text = payment.cardTypeDescription
        lbTotal.text = "\(Common.convertCurrencyV2(value: payment.paymentValue)) VNĐ"
    }
}
