//
//  FtelReciptDetail.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 13/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class FtelReciptDetail: Mappable {
    var orderStatus: Int = 0
    var billNo: String = ""
    var customerId: String = ""
    var referenceSystem: String = ""
    var referenceValue: String = ""
    var warehouseCode: String = ""
    var regionCode: String = ""
    var ip: String = ""
    var orderTransactionDtos: [FtelOrderTransactionDto] = []
    var orderHistories: [FtelOrderHistory] = []
    var customerName: String = ""
    var customerPhoneNumber: String = ""
    var employeeName: String = ""
    var warehouseAddress: String = ""
    var payments: [FtelPayment] = []
    var creationTime: String = ""
    var creationBy: String = ""
    var id: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.orderStatus <- map["orderStatus"]
        self.billNo <- map["billNo"]
        self.customerId <- map["customerId"]
        self.referenceSystem <- map["referenceSystem"]
        self.referenceValue <- map["referenceValue"]
        self.warehouseCode <- map["warehouseCode"]
        self.regionCode <- map["regionCode"]
        self.ip <- map["ip"]
        self.orderTransactionDtos <- map["orderTransactionDtos"]
        self.orderHistories <- map["orderHistories"]
        self.customerName <- map["customerName"]
        self.customerPhoneNumber <- map["customerPhoneNumber"]
        self.employeeName <- map["employeeName"]
        self.warehouseAddress <- map["warehouseAddress"]
        self.payments <- map["payments"]
        self.creationTime <- map["creationTime"]
        self.creationBy <- map["creationBy"]
        self.id <- map["id"]
    }
}

// MARK: - OrderHistory
class FtelOrderHistory: Mappable {
    var creationTime: String = ""
    var action: String = ""
    var actionDisplay: Int = 0
    var orderHistoryDescription: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.creationTime <- map["creationTime"]
        self.action <- map["action"]
        self.actionDisplay <- map["actionDisplay"]
        self.orderHistoryDescription <- map["orderHistoryDescription"]
    }
}

class FtelOrderTransactionDto: Mappable {
    var productId: String = ""
    var productName: String = ""
    var providerId: String = ""
    var categoryId: String = ""
    var categoryName: String = ""
    var sellingPrice: Int = 0
    var price: Int = 0
    var quantity: Int = 0
    var totalAmount: Int = 0
    var totalAmountIncludingFee: Int = 0
    var totalFee: Int = 0
    var integratedGroupCode: String = ""
    var integratedProductCode: String = ""
    var isExportInvoice: Bool = false
    var productCustomerCode: String = ""
    var productCustomerName: String = ""
    var productCustomerPhoneNumber: String = ""
    var transactionCode: String = ""
    var receiptMethod: String = ""
    var transferMethod: String = ""
    var invoices: [FtelInvoice] = []
    var id: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.productId <- map["productId"]
        self.productName <- map["productName"]
        self.providerId <- map["providerId"]
        self.categoryId <- map["categoryId"]
        self.categoryName <- map["categoryName"]
        self.sellingPrice <- map["sellingPrice"]
        self.price <- map["price"]
        self.quantity <- map["quantity"]
        self.totalAmount <- map["totalAmount"]
        self.totalAmountIncludingFee <- map["totalAmountIncludingFee"]
        self.totalFee <- map["totalFee"]
        self.integratedGroupCode <- map["integratedGroupCode"]
        self.integratedProductCode <- map["integratedProductCode"]
        self.isExportInvoice <- map["isExportInvoice"]
        self.productCustomerCode <- map["productCustomerCode"]
        self.productCustomerName <- map["productCustomerName"]
        self.productCustomerPhoneNumber <- map["productCustomerPhoneNumber"]
        self.transactionCode <- map["transactionCode"]
        self.receiptMethod <- map["receiptMethod"]
        self.transferMethod <- map["transferMethod"]
        self.invoices <- map["invoices"]
        self.id <- map["id"]
    }
}

class FtelInvoice: Mappable {
    var id: String = ""
    var rawPeriod: String = ""
    var paymentAmount: Int = 0
    var paymentFee: Int = 0
    var isCheck: Bool = false
    var isDisable: Bool = false

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.rawPeriod <- map["rawPeriod"]
        self.paymentAmount <- map["paymentAmount"]
        self.paymentFee <- map["paymentFee"]
        self.isCheck <- map["isCheck"]
        self.isDisable <- map["isDisable"]
    }
}

class FtelPayment: Mappable {
    var paymentType: Int = 0
    var paymentCode: String = ""
//    var paymentCodeDescription: NSNull
//    var paymentAccountNumber: NSNull
    var paymentValue: Int = 0
    var bankType: String = ""
    var bankTypeDescription: String = ""
    var cardType: String = ""
    var cardTypeDescription: String = ""
    var isCardOnline: Bool = false
    var paymentExtraFee: Int = 0
    var paymentPercentFee: Int = 0
    var isChargeOnCash: Bool = false

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.paymentType <- map["paymentType"]
        self.paymentCode <- map["paymentCode"]
//        self.paymentCodeDescription <- map["paymentCodeDescription"]
//        self.paymentAccountNumber <- map["paymentAccountNumber"]
        self.paymentValue <- map["paymentValue"]
        self.bankType <- map["bankType"]
        self.bankTypeDescription <- map["bankTypeDescription"]
        self.cardType <- map["cardType"]
        self.cardTypeDescription <- map["cardTypeDescription"]
        self.isCardOnline <- map["isCardOnline"]
        self.paymentExtraFee <- map["paymentExtraFee"]
        self.paymentPercentFee <- map["paymentPercentFee"]
        self.isChargeOnCash <- map["isChargeOnCash"]
    }
}

