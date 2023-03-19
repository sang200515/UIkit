//
//  ThuHoSOMOrderParam.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class ThuHoSOMOrderParam: Mappable {
    var orderStatus: Int = 0
    var orderStatusDisplay: String = ""
    var billNo: String = ""
    var customerId: String = ""
    var customerName: String = ""
    var customerPhoneNumber: String?
    var warehouseCode: String = ""
    var regionCode: String = ""
    var creationBy: String = ""
    var creationTime: String = ""
    var referenceSystem: String = ""
    var referenceValue: String = ""
    var orderTransactionDtos: [ThuHoSOMOrderTransactionDtoParam] = []
    var payments: [ThuHoSOMPaymentDetailParam] = []
    var id: String = ""
    var ip: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.orderStatus <- map["orderStatus"]
        self.orderStatusDisplay <- map["orderStatusDisplay"]
        self.billNo <- map["billNo"]
        self.customerId <- map["customerId"]
        self.customerName <- map["customerName"]
        self.customerPhoneNumber <- map["customerPhoneNumber"]
        self.warehouseCode <- map["warehouseCode"]
        self.regionCode <- map["regionCode"]
        self.creationBy <- map["creationBy"]
        self.creationTime <- map["creationTime"]
        self.referenceSystem <- map["referenceSystem"]
        self.referenceValue <- map["referenceValue"]
        self.orderTransactionDtos <- map["orderTransactionDtos"]
        self.payments <- map["payments"]
        self.id <- map["id"]
        self.ip <- map["ip"]
    }
}

class ThuHoSOMOrderTransactionDtoParam: Mappable {
    var productId: String = ""
    var providerId: String = ""
    var providerName: String = ""
    var productName: String = ""
    var price: Int?
    var sellingPrice: Int?
    var quantity: Int = 0
    var totalAmount: Int?
    var totalAmountIncludingFee: Int = 0
    var totalFee: Int?
    var creationTime: String = ""
    var creationBy: String = ""
    var integratedGroupCode: String = ""
    var integratedGroupName: String = ""
    var integratedProductCode: String = ""
    var integratedProductName: String = ""
    var isOfflineTransaction: Bool = false
    var referenceCode: String?
    var minFee: Int = 0
    var maxFee: Int = 0
    var percentFee: Int = 0
    var constantFee: Int = 0
    var paymentFeeType: Int = 0
    var paymentRule: Int = 0
    var productCustomerCode: String = ""
    var productCustomerName: String = ""
    var productCustomerPhoneNumber: String?
    var productCustomerAddress: String = ""
    var productCustomerEmailAddress: String = ""
    var orderTransactionDtoDescription: String = ""
    var invoices: [ThuHoSOMOrderInvoiceDetail] = []
    var categoryId: String = ""
    var isExportInvoice: Bool = false
    var id: String = ""
    var extraProperties: ThuHoSOMExtraPropertiesParam = ThuHoSOMExtraPropertiesParam(JSON: [:])!
    var sender: ThuHoSOMReceiverParam = ThuHoSOMReceiverParam(JSON: [:])!
    var receiver: ThuHoSOMReceiverParam = ThuHoSOMReceiverParam(JSON: [:])!
    var productConfigDto: ThuHoSOMProductConfigDtoParam = ThuHoSOMProductConfigDtoParam(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.productId <- map["productId"]
        self.providerId <- map["providerId"]
        self.providerName <- map["providerName"]
        self.productName <- map["productName"]
        self.price <- map["price"]
        self.sellingPrice <- map["sellingPrice"]
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
        self.referenceCode <- map["referenceCode"]
        self.minFee <- map["minFee"]
        self.maxFee <- map["maxFee"]
        self.percentFee <- map["percentFee"]
        self.constantFee <- map["constantFee"]
        self.paymentFeeType <- map["paymentFeeType"]
        self.paymentRule <- map["paymentRule"]
        self.productCustomerCode <- map["productCustomerCode"]
        self.productCustomerName <- map["productCustomerName"]
        self.productCustomerPhoneNumber <- map["productCustomerPhoneNumber"]
        self.productCustomerAddress <- map["productCustomerAddress"]
        self.productCustomerEmailAddress <- map["productCustomerEmailAddress"]
        self.orderTransactionDtoDescription <- map["description"]
        self.invoices <- map["invoices"]
        self.categoryId <- map["categoryId"]
        self.isExportInvoice <- map["isExportInvoice"]
        self.id <- map["id"]
        self.extraProperties <- map["extraProperties"]
        self.sender <- map["sender"]
        self.receiver <- map["receiver"]
        self.productConfigDto <- map["productConfigDto"]
    }
}

class ThuHoSOMExtraPropertiesParam: Mappable {
    var referenceIntegrationInfo: ThuHoSOMReferenceIntegrationInfoParam = ThuHoSOMReferenceIntegrationInfoParam(JSON: [:])!
    var warehouseName: String = ""
    var customerIdentityType: String = ""
    var customerIdentityNumber: String = ""
    var orderProductID: String = ""
    var detailProductItemID: String = ""
    var detailTotalAmount: Int = 0
    var vehicleInsuranceObjID: Int = 0
    var vehicleFrameNo: String = ""
    var vehicleEngineNo: String = ""
    var vehicleDriverFee: Int = 0
    var vehiclePrice: Int = 0
    var vehicleSeatFee: Int = 0
    var vehicleSuminsure: Int = 0
    var effectiveDate: String = ""
    var expiredDate: String = ""
    var introducer: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.referenceIntegrationInfo <- map["referenceIntegrationInfo"]
        self.warehouseName <- map["warehouseName"]
        self.customerIdentityType <- map["customerIdentityType"]
        self.customerIdentityNumber <- map["customerIdentityNumber"]
        self.orderProductID <- map["orderProductId"]
        self.detailProductItemID <- map["detailProductItemId"]
        self.detailTotalAmount <- map["detailTotalAmount"]
        self.vehicleInsuranceObjID <- map["vehicleInsuranceObjId"]
        self.vehicleFrameNo <- map["vehicleFrameNo"]
        self.vehicleEngineNo <- map["vehicleEngineNo"]
        self.vehicleDriverFee <- map["vehicleDriverFee"]
        self.vehiclePrice <- map["vehiclePrice"]
        self.vehicleSeatFee <- map["vehicleSeatFee"]
        self.vehicleSuminsure <- map["vehicleSuminsure"]
        self.effectiveDate <- map["effectiveDate"]
        self.expiredDate <- map["expiredDate"]
        self.introducer <- map["introducer"]
    }
}

class ThuHoSOMReferenceIntegrationInfoParam: Mappable {
    var requestId: String = ""
    var responseId: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.requestId <- map["requestId"]
        self.responseId <- map["responseId"]
    }
}

class ThuHoSOMProductConfigDtoParam: Mappable {
    var checkInventory: Bool = false

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.checkInventory <- map["checkInventory"]
    }
}

class ThuHoSOMReceiverParam: Mappable {

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
    }
}

class ThuHoSOMPaymentDetailParam: Mappable {
    var paymentType: String = ""
    var paymentCode: String?
    var paymentValue: Int?
    var bankType: String?
    var cardType: String?
    var paymentExtraFee: Int = 0
    var paymentPercentFee: Int = 0
    var cardTypeDescription: String?
    var bankTypeDescription: String?
    var isCardOnline: Bool?
    var isChargeOnCash: Bool?
    var paymentCodeDescription: String?
    var paymentAccountNumber: String?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.paymentType <- map["paymentType"]
        self.paymentCode <- map["paymentCode"]
        self.paymentValue <- map["paymentValue"]
        self.bankType <- map["bankType"]
        self.bankTypeDescription <- map["bankTypeDescription"]
        self.cardType <- map["cardType"]
        self.cardTypeDescription <- map["cardTypeDescription"]
        self.isCardOnline <- map["isCardOnline"]
        self.paymentExtraFee <- map["paymentExtraFee"]
        self.paymentPercentFee <- map["paymentPercentFee"]
        self.isChargeOnCash <- map["isChargeOnCash"]
        self.paymentCodeDescription <- map["paymentCodeDescription"]
        self.paymentAccountNumber <- map["paymentAccountNumber"]
    }
}
