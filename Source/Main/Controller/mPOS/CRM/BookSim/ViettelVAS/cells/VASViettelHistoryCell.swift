//
//  VASViettelHistoryCell.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 07/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VASViettelHistoryCell: UITableViewCell {

    
    @IBOutlet weak var ticketNumberLabel: UILabel!
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var nccLabel: UILabel!
    @IBOutlet weak var customerPhoneLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var packNameLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.layer.cornerRadius = 10
        mainView.layer.shadowOffset = CGSize(width: 0, height: 3)
        mainView.layer.shadowOpacity = 0.6
        mainView.layer.shadowRadius = 3.0
        mainView.layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    func bindCell(item: ViettelVASHistory) {
        ticketNumberLabel.text = item.billNo
        employeeNameLabel.text = item.employeeName
        customerPhoneLabel.text = item.customerPhoneNumber
        if let statusCode = CreateOrderResultViettelPay_SOM(rawValue: item.orderStatus) {
            stateLabel.text = statusCode.message
            if statusCode == .SUCCESS {
                stateLabel.textColor = Constants.COLORS.bold_green
            } else if statusCode == .CREATE && statusCode == .PROCESSING {
                stateLabel.textColor = Constants.COLORS.main_red_my_info
            }
        } else {
            stateLabel.text = "\(item.orderStatus)"
        }
        packNameLabel.text = item.productName
        totalMoneyLabel.text = "\(Common.convertCurrencyDoubleV2(value: item.totalAmountIncludingFee))đ"
        timeLabel.text = "\(Common.convertDateISO8601(dateString: item.creationTime))"
        nccLabel.text = "Viettel"
    }
    
}


extension UIView {
    func highlightView() {
        self.layer.cornerRadius = 10
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 3.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
    }
}
