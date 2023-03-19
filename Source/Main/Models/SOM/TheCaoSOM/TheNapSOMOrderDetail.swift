//
//  TheNapSOMOrderDetail.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 23/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class TheNapSOMOrderDetail: Mappable {
    var orderStatus: Int = 0
    var orderStatusDisplay: String = ""
    var billNo: String = ""
    var customerID: String = ""
    var referenceSystem: String = ""
    var referenceValue: String = ""
    var tenant: String = ""
    var warehouseCode: String = ""
    var regionCode: String = ""
    var ip: String = ""
    var orderTransactionDtos: [TheNapSOMOrderTransactionDto] = []
    var orderHistories: [TheNapSOMOrderHistory] = []
    var customerName: String = ""
    var customerPhoneNumber: String = ""
    var employeeName: String = ""
    var warehouseAddress: String = ""
    var payments: [TheNapSOMPayment] = []
    var creationTime: String = ""
    var creationBy: String = ""
    var id: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.orderStatus <- map["orderStatus"]
        self.orderStatusDisplay <- map["orderStatusDisplay"]
        self.billNo <- map["billNo"]
        self.customerID <- map["customerId"]
        self.referenceSystem <- map["referenceSystem"]
        self.referenceValue <- map["referenceValue"]
        self.tenant <- map["tenant"]
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

class TheNapSOMOrderHistory: Mappable {
    var creationTime: String = ""
    var action: String = ""
    var actionDisplay: Int = 0
    var description: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.creationTime <- map["creationTime"]
        self.action <- map["action"]
        self.actionDisplay <- map["actionDisplay"]
        self.description <- map["description"]
    }
}

class TheNapSOMOrderTransactionDto: Mappable {
    var description: String = ""
    var productID: String = ""
    var productName: String = ""
    var providerID: String = ""
    var providerName: String = ""
    var categoryID: String = ""
    var categoryName: String = ""
    var sellingPrice: Int = 0
    var price: Int = 0
    var quantity: Int = 0
    var totalAmount: Int = 0
    var totalAmountIncludingFee: Int = 0
    var totalFee: Int = 0
    var creationTime: String = ""
    var creationBy: String = ""
    var integratedGroupCode: String = ""
    var integratedGroupName: String = ""
    var integratedProductCode: String = ""
    var integratedProductName: String = ""
    var isOfflineTransaction: Bool = false
    var isExportInvoice: Bool = false
    var referenceCode: String = ""
    var minFee: Int = 0
    var maxFee: Int = 0
    var percentFee: Int = 0
    var constantFee: Int = 0
    var paymentFeeType: Int = 0
    var paymentRule: Int = 0
    var productCustomerCode: String = ""
    var vehicleNumber: String = ""
    var productCustomerName: String = ""
    var productCustomerPhoneNumber: String = ""
    var transactionCode: String = ""
    var receiptMethod: String = ""
    var transferMethod: String = ""
    var productCustomerAddress: String = ""
    var productCustomerEmailAddress: String = ""
    var sender: TheNapSOMReceiver = TheNapSOMReceiver(JSON: [:])!
    var receiver: TheNapSOMReceiver = TheNapSOMReceiver(JSON: [:])!
    var licenseKey: String = ""
    var productConfigDto: TheNapSOMProductConfigDto = TheNapSOMProductConfigDto(JSON: [:])!
    var invoices: [String] = []
    var payments: TheNapSOMPayment?
    var id: String = ""
    var extraProperties: TheNapSOMExtraProperties = TheNapSOMExtraProperties(JSON: [:])!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.description <- map["description"]
        self.productID <- map["productId"]
        self.productName <- map["productName"]
        self.providerID <- map["providerId"]
        self.providerName <- map["providerName"]
        self.categoryID <- map["categoryId"]
        self.categoryName <- map["categoryName"]
        self.sellingPrice <- map["sellingPrice"]
        self.price <- map["price"]
        self.quantity <- map["quantity"]
        self.totalAmount <- map["totalAmount"]
        self.totalAmountIncludingFee <- map["totalAmountIncludingFee"]
        self.totalFee <- map["totalFee"]
        self.creationTime <- map["creationTime"]
        self.creationBy <- map["creationBy"]
        self.integratedGroupCode <- map["integratedGroupCode"]
        self.integratedGroupName <- map["integratedGroupName"]
        self.integratedProductCode <- map["integratedProductCode"]
        self.integratedProductName <- map["integratedProductName"]
        self.isOfflineTransaction <- map["isOfflineTransaction"]
        self.isExportInvoice <- map["isExportInvoice"]
        self.referenceCode <- map["referenceCode"]
        self.minFee <- map["minFee"]
        self.maxFee <- map["maxFee"]
        self.percentFee <- map["percentFee"]
        self.constantFee <- map["constantFee"]
        self.paymentFeeType <- map["paymentFeeType"]
        self.paymentRule <- map["paymentRule"]
        self.productCustomerCode <- map["productCustomerCode"]
        self.vehicleNumber <- map["vehicleNumber"]
        self.productCustomerName <- map["productCustomerName"]
        self.productCustomerPhoneNumber <- map["productCustomerPhoneNumber"]
        self.transactionCode <- map["transactionCode"]
        self.receiptMethod <- map["receiptMethod"]
        self.transferMethod <- map["transferMethod"]
        self.productCustomerAddress <- map["productCustomerAddress"]
        self.productCustomerEmailAddress <- map["productCustomerEmailAddress"]
        self.sender <- map["sender"]
        self.receiver <- map["receiver"]
        self.licenseKey <- map["licenseKey"]
        self.productConfigDto <- map["productConfigDto"]
        self.invoices <- map["invoices"]
        self.payments <- map["payments"]
        self.id <- map["id"]
        self.extraProperties <- map["extraProperties"]
    }
}

class TheNapSOMReferenceIntegrationInfo: Mappable {
    var requestID: String = ""
    var responseID: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.requestID <- map["requestId"]
        self.responseID <- map["responseId"]
    }
}

class TheNapSOMProductConfigDto: Mappable {
    var checkInventory: Bool = false
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.checkInventory <- map["checkInventory"]
    }
}

class TheNapSOMReceiver: Mappable {
    var id: String = ""
    var fullname: String = ""
    var idCard: String = ""
    var idIssuedOnDate: String = ""
    var idIssuedOnPlace: String = ""
    var phonenumber: String = ""
    var idCardFrontPhoto: String = ""
    var idCardBackPhoto: String = ""
    var provinceCode: String = ""
    var precinctCode: String = ""
    var districtCode: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.fullname <- map["fullname"]
        self.idCard <- map["idCard"]
        self.idIssuedOnDate <- map["idIssuedOnDate"]
        self.idIssuedOnPlace <- map["idIssuedOnPlace"]
        self.phonenumber <- map["phonenumber"]
        self.idCardFrontPhoto <- map["idCardFrontPhoto"]
        self.idCardBackPhoto <- map["idCardBackPhoto"]
        self.provinceCode <- map["provinceCode"]
        self.precinctCode <- map["precinctCode"]
        self.districtCode <- map["districtCode"]
    }
}

class TheNapSOMPayment: Mappable {
    var paymentType: String = ""
    var paymentCode: String = ""
    var paymentCodeDescription: String = ""
    var paymentAccountNumber: String = ""
    var paymentValue: Int = 0
    var bankType: String = ""
    var bankTypeDescription: String = ""
    var cardType: String = ""
    var cardTypeDescription: String = ""
    var isCardOnline: Bool = false
    var paymentExtraFee: Int = 0
    var paymentPercentFee: Int = 0
    var isChargeOnCash: Bool?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.paymentType <- map["paymentType"]
        if self.paymentType.isEmpty {
            var int: Int = 0
            int <- map["paymentType"]
            self.paymentType = String(int)
        }
        self.paymentCode <- map["paymentCode"]
        self.paymentCodeDescription <- map["paymentCodeDescription"]
        self.paymentAccountNumber <- map["paymentAccountNumber"]
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

