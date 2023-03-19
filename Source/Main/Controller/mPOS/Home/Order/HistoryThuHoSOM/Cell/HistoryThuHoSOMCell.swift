//
//  HistoryThuHoSOMCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 24/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HistoryThuHoSOMCell: UITableViewCell {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbBillNo: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbBillNoCRM: UILabel!
    @IBOutlet weak var lbCustomerCode: UILabel!
    @IBOutlet weak var lbProvider: UILabel!
    @IBOutlet weak var lbProviderGroup: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var lbPaymentType: UILabel!
    @IBOutlet weak var lbShop: UILabel!
    @IBOutlet weak var lbTransactionCode: UILabel!
    @IBOutlet weak var lbReturnTransactionCode: UILabel!
    @IBOutlet weak var lbEmployee: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vBackground.roundCorners(.allCorners, radius: 10)
        vBackground.dropShadowV2()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(history: ThuHoSOMHistory) {
        lbBillNo.text = "Số PT: \(history.billNo)"
        
        let date = history.creationTime.toDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        lbDate.text = date.stringWithFormat("dd-MM-yyyy HH:mm")
        
        lbBillNoCRM.text = history.crmBillNo
        lbCustomerCode.text = history.productCustomerCode
        lbProvider.text = history.productName
        lbProviderGroup.text = history.categoryName
        lbStatus.text = ThuHoSOMOrderStatusEnum.init(rawValue: history.orderStatus)?.description ?? ""
        lbStatus.textColor = ThuHoSOMOrderStatusEnum.init(rawValue: history.orderStatus)?.color
        lbAmount.text = "\(Common.convertCurrencyV2(value: history.totalAmountIncludingFee)) VNĐ"
        
        let paymentType: [Int] = history.paymentMethods.split(separator: ",").map { (Int($0) ?? 1) }
        var paymentTypeString = ""
        for type in paymentType {
            paymentTypeString += (ThuHoSOMPaymentTypeEnum.init(rawValue: type)?.description ?? "") + ", "
        }
        paymentTypeString = paymentTypeString.dropLast
        paymentTypeString = paymentTypeString.dropLast
        lbPaymentType.text = paymentTypeString
        
        lbShop.text = history.warehouseName
        lbTransactionCode.text = history.transactionCode
        lbReturnTransactionCode.text = history.partnerReturnTransactionID
        lbEmployee.text = history.employeeName
    }
}
