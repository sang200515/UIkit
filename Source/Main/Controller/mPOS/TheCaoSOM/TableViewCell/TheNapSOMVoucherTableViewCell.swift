//
//  TheNapSOMVoucherTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 26/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class TheNapSOMVoucherTableViewCell: UITableViewCell {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbCode: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    
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
    
    func setupCell(payment: TheNapSOMPayment) {
        lbCode.text = payment.paymentCode
        lbName.text = payment.paymentCodeDescription
        lbTotal.text = "\(Common.convertCurrencyV2(value: payment.paymentValue)) VNĐ"
    }
    
    func setupCell(payment: ThuHoSOMPaymentDetail) {
        lbCode.text = payment.paymentCode
        lbName.text = payment.paymentCodeDescription
        lbTotal.text = "\(Common.convertCurrencyV2(value: payment.paymentValue)) VNĐ"
    }
}
