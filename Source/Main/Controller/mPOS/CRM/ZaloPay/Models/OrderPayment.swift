//
//  OrderPayment.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 29/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct OrderPayment:Decodable
{
    var paymentType: Int
    var paymentCode: String?
    var paymentCodeDescription: String?
    var paymentAccountNumber: String?
    var paymentValue: Double
    var bankType: String?
    var bankTypeDescription: String?
    var isCardOnline: Bool
    var paymentExtraFee: Double
    var paymentPercentFee: Double
    var isChargeOnCash: Bool
}
