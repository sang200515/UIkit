//
//  DetailOrderZaloPay.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 29/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct DetailOrderZaloPay: Decodable
{
    var orderStatus: OrderStatus
    var orderStatusDisplay: String?
    var billNo: String
    var customerId: String
    var referenceSystem: String
    var referenceValue: String?
    var warehouseCode: String
    var regionCode: String?
    var ip: String?
    var customerName: String
    var customerPhoneNumber: String
    var employeeName: String
    var warehouseAddress: String
    var creationTime: String
    var creationBy: String
    var id: String
    var payments: [OrderPayment]
    var orderHistories: [OrderHistoryZaloPay]
    var orderTransactionDtos: [OrderTransactionZaloPay]
}

