//
//  FtelOrderDetailViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 09/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class FtelOrderDetailViewController: UIViewController {

    @IBOutlet weak var lbOrderCode: UILabel!
    @IBOutlet weak var lbTransactionCode: UILabel!
    @IBOutlet weak var lbService: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbEmployee: UILabel!
    @IBOutlet weak var lbCustomerName: UILabel!
    @IBOutlet weak var lbCustomerPhone: UILabel!
    @IBOutlet weak var lbCash: UILabel!
    @IBOutlet weak var lbCard: UILabel!
    @IBOutlet weak var lbCardFee: UILabel!
    @IBOutlet weak var lbTotalBill: UILabel!
    @IBOutlet weak var lbTotalPay: UILabel!
    @IBOutlet weak var btnPrint: UIButton!

    var isHistory: Bool = false
    var orderDetail: FtelReciptDetail = FtelReciptDetail(JSON: [:])!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        title = isHistory ? "Lịch sử thu hộ" : "Thanh toán"
        addBackButton()

        btnPrint.makeCorner(corner: 5)
        btnPrint.layer.borderWidth = 0.5
        btnPrint.layer.borderColor = UIColor.white.cgColor
        
        lbOrderCode.text = orderDetail.billNo
        lbTransactionCode.text = orderDetail.orderTransactionDtos[0].productCustomerCode
        lbService.text = orderDetail.orderTransactionDtos[0].productName
        let date = orderDetail.creationTime.toDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        lbDate.text = date.toString(dateFormat: "dd/MM/yyyy'T'HH:mm:ss")
        lbEmployee.text = orderDetail.employeeName
        lbCustomerName.text = orderDetail.customerName
        lbCustomerPhone.text = orderDetail.customerPhoneNumber
        
        let cash = orderDetail.payments.first(where: { $0.paymentType == 1 })?.paymentValue ?? 0
        lbCash.text = "\(Common.convertCurrencyFloat(value: Float(cash)))"
        
        let cards = orderDetail.payments.filter { $0.paymentType != 1 }
        var cardValue = 0
        for card in cards {
            cardValue += card.paymentValue
        }
        lbCard.text = "\(Common.convertCurrencyFloat(value: Float(cardValue)))"
        
        lbCardFee.text = "\(Common.convertCurrencyFloat(value: Float(orderDetail.orderTransactionDtos[0].totalFee)))"
        lbTotalBill.text = "\(Common.convertCurrencyFloat(value: Float(orderDetail.orderTransactionDtos[0].totalAmount)))"
        lbTotalPay.text = "\(Common.convertCurrencyFloat(value: Float(orderDetail.orderTransactionDtos[0].totalAmountIncludingFee)))"
    }

    @IBAction func printButtonPressed(_ sender: Any) {
    }
}
