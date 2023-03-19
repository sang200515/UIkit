//
//  OrderTransactionZaloPay.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 29/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct OrderTransactionZaloPay:Decodable
{
    var description: String?
    var productId: String?
    var productName: String?
    var providerId: String?
    var providerName: String?
    var categoryId: String?
    var categoryName: String?
    var sellingPrice: Double?
    var price: Double?
    var quantity: Int?
    var totalAmount: Double?
    var totalAmountIncludingFee: Double?
    var totalFee: Double?
    var creationTime: String?
    var creationBy: String?
    var integratedGroupCode: String?
    var integratedGroupName: String?
    var integratedProductCode: String?
    var integratedProductName: String?
    var isOfflineTransaction: Bool?
    var isExportInvoice: Bool?
    var referenceCode: String?
    var minFee: Double?
    var maxFee: Double?
    var percentFee: Double?
    var constantFee: Double?
    var paymentFeeType: Double?
    var paymentRule: String?
    var productCustomerCode: String?
    var vehicleNumber: String?
    var productCustomerName: String?
    var productCustomerPhoneNumber: String?
    var transactionCode: String?
    var receiptMethod: String?
    var transferMethod: String?
    var productCustomerAddress: String?
    var productCustomerEmailAddress: String?
    var id: String?
}
