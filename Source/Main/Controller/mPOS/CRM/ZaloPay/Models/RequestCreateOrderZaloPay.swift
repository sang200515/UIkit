//
//  RequestCreateOrderZaloPay.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 30/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct RequestCreateOrderZaloPay: Encodable
{
    var customerName: String
    var customerPhoneNumber: String
    var creationBy: String
    var warehouseCode: String
    var referenceSystem: String
    var payments: [RequestOrderPaymentZaloPay]
    var orderTransactionDtos: [RequestOrderTransactionZaloPay]
}
struct RequestOrderPaymentZaloPay: Encodable
{
    var paymentType: Int
    var paymentValue: Double
    var paymentExtraFee: Double
    var paymentPercentFee: Double
}
struct RequestOrderTransactionZaloPay: Encodable
{
    var productId: String
    var providerId: String
    var providerName: String
    var productName: String
    var price: Double
    var quantity: Double
    var totalAmount: Double
    var totalAmountIncludingFee: Double
    var productCustomerCode: String
    var productCustomerName: String
    var productCustomerPhoneNumber: String
    var description: String
}
