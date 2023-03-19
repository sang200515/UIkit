//
//  VASPaymentType.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 08/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//


import Foundation
import UIKit


struct VASPaymentType: Codable {
    var totalCount: Int
    var items: [ItemCard]
}

struct ItemCard: Codable {
    var code: String
    var name: String
    var isCardOnline: String
    var id: String
}


struct VASCard: Codable {
    var totalCount: Int
    var items: [Card]
}

struct Card: Codable {
    var code: String
    var name: String
    var percentFee: Double
    var id: String
    var isCredit: Bool
}


struct VASPayment {
    var paymentType: String = ""
    var paymentCode: String = ""
    var paymentValue: String = ""
    var bankType: String = ""
    var cardType: String = ""
    var paymentExtraFee: Double = 0
    var paymentPercentFee: Double = 0
    var cardTypeDescription: String = ""
    var bankTypeDescription: String = ""
    var isCardOnline: Bool = false
    var isChargeOnCash: Bool = false
    
//    init(paymentType: String, paymentCode: String,paymentValue: String, bankType: String, cardType: String, paymentExtraFee: Double,paymentPercentFee: Double , cardTypeDescription: String, bankTypeDescription: String,isCardOnline: Bool ,isChargeOnCash: Bool) {
//        self.paymentValue = paymentValue
//        self.paymentCode = paymentCode
//        self.paymentValue = paymentValue
//        self.bankType = bankType
//        self.cardType = cardType
//        self.paymentExtraFee = paymentExtraFee
//        self.paymentPercentFee = paymentPercentFee
//        self.cardTypeDescription = cardTypeDescription
//        self.bankTypeDescription = bankTypeDescription
//        self.isCardOnline = isCardOnline
//        self.isChargeOnCash = isChargeOnCash
//    }
    
    func convertTodict(from list: [VASPayment]) -> [[String:Any]] {
        var arrDict_payments = [[String:Any]]()
        for item in list {
            let dict_payments: [String:Any] = ["paymentType": Int(item.paymentType) ?? 0,
                                               "paymentCode": item.paymentCode,
                                               "paymentValue": Int(item.paymentValue) ?? 0,
                                               "bankType": item.bankType,
                                               "cardType": item.cardType,
                                               "paymentExtraFee": Int(item.paymentExtraFee),
                                               "paymentPercentFee": Int(item.paymentPercentFee),
                                               "cardTypeDescription": item.cardTypeDescription,
                                               "bankTypeDescription": item.bankTypeDescription,
                                               "isCardOnline": item.isCardOnline,
                                               "isChargeOnCash": item.isChargeOnCash,
            ]
            arrDict_payments.append(dict_payments)
        }
        return arrDict_payments
    }
}
