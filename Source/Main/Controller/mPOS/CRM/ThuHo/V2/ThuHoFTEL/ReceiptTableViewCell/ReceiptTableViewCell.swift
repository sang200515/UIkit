//
//  ReceiptTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 06/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ReceiptTableViewCell: UITableViewCell {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbReceiptNumber: UILabel!
    @IBOutlet weak var lbTransactionCode: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbService: UILabel!
    @IBOutlet weak var lbCustomerCode: UILabel!
    @IBOutlet weak var lbCustomerName: UILabel!
    @IBOutlet weak var lbCustomerPhone: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var svStatus: UIStackView!
    @IBOutlet weak var lbTotalPay: UILabel!
    @IBOutlet weak var lbReceiverName: UILabel!

    var estimateCellHeight: CGFloat = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setUpCell(item: FtelReceipt, isUnconfirmed: Bool = true) {
        svStatus.isHidden = isUnconfirmed
        lbReceiptNumber.text = item.billNo
        lbTransactionCode.text = item.productCustomerCode
        let date = item.creationTime.toDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        lbTime.text = date.toString(dateFormat: "dd/MM/yyyy'T'HH:mm:ss")
        lbService.text = item.productName
        lbCustomerCode.text = item.productCustomerCode
        lbCustomerPhone.text = item.customerPhoneNumber
        lbStatus.text = "\(item.orderStatus)"
        lbTotalPay.text = "\(Common.convertCurrencyFloat(value: Float(item.totalAmountIncludingFee)))"
        lbReceiverName.text = item.employeeName
        vBackground.makeCorner(corner: 5)
    }
}
