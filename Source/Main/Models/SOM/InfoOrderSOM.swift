//
//  InfoOrderSOM.swift
//  fptshop
//
//  Created by Ngo Dang tan on 27/01/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
// MARK: - InfoOrderSOM
struct InfoOrderSOM: Codable {
    let orderStatus: Int?
    let orderStatusDisplay, billNo, customerID, referenceSystem: String?
    let referenceValue: String?
    let tenant: String?
    let warehouseCode, regionCode, ip: String?
    let orderTransactionDtos: [OrderTransactionDto]?
    let orderHistories: [OrderHistory]?
    let customerName, customerPhoneNumber, employeeName, warehouseAddress: String?
    let payments: [Payment]?
    let creationTime, creationBy, id: String?

    enum CodingKeys: String, CodingKey {
        case orderStatus, orderStatusDisplay, billNo
        case customerID = "customerId"
        case referenceSystem, referenceValue, tenant, warehouseCode, regionCode, ip, orderTransactionDtos, orderHistories, customerName, customerPhoneNumber, employeeName, warehouseAddress, payments, creationTime, creationBy, id
    }
}

// MARK: - OrderHistory
struct OrderHistory: Codable {
    let creationTime, action: String?
    let actionDisplay: Int?
    let orderHistoryDescription: String?

    enum CodingKeys: String, CodingKey {
        case creationTime, action, actionDisplay
        case orderHistoryDescription = "description"
    }
}

// MARK: - OrderTransactionDto
struct OrderTransactionDto: Codable {
    let orderTransactionDtoDescription, productID, productName, providerID: String?
    let providerName: String?
    let categoryID, categoryName: String?
    let sellingPrice, price, quantity, totalAmount: Int?
    let totalAmountIncludingFee, totalFee: Int?
    let creationTime, creationBy: String?
    let integratedGroupCode: String?
    let integratedGroupName: String?
    let integratedProductCode: String?
    let integratedProductName, isOfflineTransaction: String?
    let isExportInvoice: Bool?
    let referenceCode: String?
    let minFee, maxFee, percentFee, constantFee: String?
    let paymentFeeType, paymentRule: String?
    let productCustomerCode, vehicleNumber, productCustomerName, productCustomerPhoneNumber: String?
    let transactionCode, receiptMethod, transferMethod, productCustomerAddress: String?
    let productCustomerEmailAddress: String?
    let sender, receiver: Receiver?
    let licenseKey: String?
    
    let payments: String?
    let id: String?
  

    enum CodingKeys: String, CodingKey {
        case orderTransactionDtoDescription = "description"
        case productID = "productId"
        case productName
        case providerID = "providerId"
        case providerName
        case categoryID = "categoryId"
        case categoryName, sellingPrice, price, quantity, totalAmount, totalAmountIncludingFee, totalFee, creationTime, creationBy, integratedGroupCode, integratedGroupName, integratedProductCode, integratedProductName, isOfflineTransaction, isExportInvoice, referenceCode, minFee, maxFee, percentFee, constantFee, paymentFeeType, paymentRule, productCustomerCode, vehicleNumber, productCustomerName, productCustomerPhoneNumber, transactionCode, receiptMethod, transferMethod, productCustomerAddress, productCustomerEmailAddress, sender, receiver, licenseKey, payments, id
    }
}



// MARK: - Receiver
struct Receiver: Codable {
    let id: String?
    let fullname, idCard, idIssuedOnDate, idIssuedOnPlace: String?
    let phonenumber, idCardFrontPhoto, idCardBackPhoto, provinceCode: String?
    let precinctCode, districtCode: String?
}

// MARK: - Payment
struct Payment: Codable {
    let paymentType: Int?
    let paymentCode, paymentCodeDescription, paymentAccountNumber: String?
    let paymentValue: Int?
    let bankType, bankTypeDescription, cardType, cardTypeDescription: String?
    let isCardOnline: Bool?
    let paymentExtraFee, paymentPercentFee: Int?
    let isChargeOnCash: Bool?
}


struct StatusOrderSOM: Codable {
    let orderStatus: Int?
    let message: String?
}

struct OrderVoucherSOM: Codable {
    let status: String?
    let message: String?
}

struct ProviderDetailSOM: Codable {
    let name: String?
    let description: String?
    let integrationType: String?
    let enable: Bool?
    let id: String?
}
