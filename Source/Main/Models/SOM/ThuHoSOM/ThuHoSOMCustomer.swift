//
//  ThuHoSOMCustomer.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class ThuHoSOMCustomer: Mappable {
    var customerPhoneNumber: String?
    var customerName: String = ""
    var address: String = ""
    var contractId: String = ""
    var contractNo: String = ""
    var serviceId: String = ""
    var serviceName: String = ""
    var providerId: String = ""
    var providerName: String = ""
    var customerDescription: String = ""
    var totalAmount: Int?
    var totalFee: Int?
    var referenceCode: String?
    var paymentFeeType: Int = 0
    var percentFee: Int = 0
    var constantFee: Int = 0
    var minFee: Int = 0
    var maxFee: Int = 0
    var paymentRule: Int = 0
    var isOfflineTransaction: Bool = false
    var invoices: [ThuHoSOMInvoice] = []
    var additionalData: ThuHoSOMAdditionalData = ThuHoSOMAdditionalData(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.customerPhoneNumber <- map["customerPhoneNumber"]
        self.customerName <- map["customerName"]
        self.address <- map["address"]
        self.contractId <- map["contractId"]
        self.contractNo <- map["contractNo"]
        self.serviceId <- map["serviceId"]
        self.serviceName <- map["serviceName"]
        self.providerId <- map["providerId"]
        self.providerName <- map["providerName"]
        self.customerDescription <- map["description"]
        self.totalAmount <- map["totalAmount"]
        self.totalFee <- map["totalFee"]
        self.referenceCode <- map["referenceCode"]
        self.paymentFeeType <- map["paymentFeeType"]
        self.percentFee <- map["percentFee"]
        self.constantFee <- map["constantFee"]
        self.minFee <- map["minFee"]
        self.maxFee <- map["maxFee"]
        self.paymentRule <- map["paymentRule"]
        self.isOfflineTransaction <- map["isOfflineTransaction"]
        self.invoices <- map["invoices"]
        self.additionalData <- map["additionalData"]
    }
}

class ThuHoSOMAdditionalData: Mappable {

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
    }
}

class ThuHoSOMInvoice: Mappable {
    var id: String = ""
    var amount: Int = 0
    var price: Int = 0
    var fee: Int = 0
    var period: String = ""
    var periodDescription: String = ""
    var minimumAmount: Int = 0
    var dueDate: String = ""
    var paymentRange: String = ""
    var isPrepaid: Bool = false
    var type: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.amount <- map["amount"]
        self.price <- map["price"]
        self.fee <- map["fee"]
        self.period <- map["period"]
        self.periodDescription <- map["periodDescription"]
        self.minimumAmount <- map["minimumAmount"]
        self.dueDate <- map["dueDate"]
        self.paymentRange <- map["paymentRange"]
        self.isPrepaid <- map["isPrepaid"]
        self.type <- map["type"]
    }
}
