//
//  VietjetHistoryTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 28/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbOrder: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbCode: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vBackground.setBorder(color: .black, borderWidth: 1, corner: 10)
//        vBackground.setBorder(color: UIColor(hexString: "FAFAFA"), borderWidth: 1, corner: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ history: VietjetPaymentHistory) {
        lbOrder.text = "Số MPOS: \(history.sompos)"
        lbDate.text = history.createdate
        lbName.text = history.contactName
        lbPhone.text = history.contactPhone
        lbCode.text = history.locator
        lbPrice.text = "\(Common.convertCurrencyV2(value: history.totalAmountFRT)) VNĐ"
        lbStatus.text = history.status
        lbStatus.textColor = UIColor(hexString: history.color)
    }
    
    func setupCell(_ history: BaoKimHistory) {
        lbOrder.text = "Số MPOS: \(history.sompos)"
        lbDate.text = history.bookingDate
        lbName.text = history.customerName
        lbPhone.text = history.customerPhone
        lbCode.text = history.bookingID
        lbPrice.text = "\(Common.convertCurrencyV2(value: history.doctotal)) VNĐ"
        lbStatus.text = history.statusName
        
        switch history.status {
        case "O":
            lbStatus.textColor = .orange
        case "F":
            lbStatus.textColor = .green
        case "H":
            lbStatus.textColor = .red
        default:
            lbStatus.textColor = .green
        }
    }
}
