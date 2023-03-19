//
//  ThuHoSOMBikeInsuranceProduct.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 23/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class ThuHoSOMBikeInsurance: Mappable {
    var customerPhoneNumber: String = ""
    var customerName: String = ""
    var address: String = ""
    var contractID: String = ""
    var contractNo: String = ""
    var serviceID: String = ""
    var serviceName: String = ""
    var providerID: String = ""
    var providerName: String = ""
    var description: String = ""
    var totalAmount: Int = 0
    var totalFee: Int = 0
    var referenceCode: String = ""
    var paymentFeeType: String = ""
    var percentFee: Int = 0
    var constantFee: Int = 0
    var minFee: Int = 0
    var maxFee: Int = 0
    var paymentRule: String = ""
    var isOfflineTransaction: Bool = false
    var invoices: [ThuHoSOMInvoice] = []
    var additionalDataProvider: ThuHoSOMBikeInsuranceAdditionalDataProvider = ThuHoSOMBikeInsuranceAdditionalDataProvider(JSON: [:])!
    var additionalDataProduct: ThuHoSOMBikeInsuranceAdditionalDataProduct = ThuHoSOMBikeInsuranceAdditionalDataProduct(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.customerPhoneNumber <- map["customerPhoneNumber"]
        self.customerName <- map["customerName"]
        self.address <- map["address"]
        self.contractID <- map["contractId"]
        self.contractNo <- map["contractNo"]
        self.serviceID <- map["serviceId"]
        self.serviceName <- map["serviceName"]
        self.providerID <- map["providerId"]
        self.providerName <- map["providerName"]
        self.description <- map["description"]
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
        self.additionalDataProvider <- map["additionalData"]
        self.additionalDataProduct <- map["additionalData"]
    }
}

class ThuHoSOMBikeInsuranceEmployee: Mappable {
    var employeeCode: String = ""
    var employeeName: String = ""
    var warehouseCode: String = ""
    var warehouseName: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.employeeCode <- map["employeeCode"]
        self.employeeName <- map["employeeName"]
        self.warehouseCode <- map["warehouseCode"]
        self.warehouseName <- map["warehouseName"]
    }
}

class ThuHoSOMBikeInsuranceAdditionalDataProvider: Mappable {
    var data: [ThuHoSOMBikeInsuranceProvider] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.data <- map["data"]
    }
}

class ThuHoSOMBikeInsuranceAdditionalDataProduct: Mappable {
    var data: ThuHoSOMBikeInsuranceProduct = ThuHoSOMBikeInsuranceProduct(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.data <- map["data"]
    }
}

class ThuHoSOMBikeInsuranceProduct: Mappable {
    var product: ThuHoSOMBikeInsuranceProductDetail = ThuHoSOMBikeInsuranceProductDetail(JSON: [:])!
    var insuranceObj: [ThuHoSOMBikeInsuranceObj] = []
    var startDate: String?
    var endDate: String?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.product <- map["product"]
        self.insuranceObj <- map["insuranceObj"]
        self.startDate <- map["startDate"]
        self.endDate <- map["endDate"]
    }
}

class ThuHoSOMBikeInsuranceObj: Mappable {
    var insuranceObjID: Int = 0
    var insuranceObjName: String = ""
    var seat: Int = 0
    var price: Int = 0
    var seatFee: Int = 0
    var driverFee: Int = 0
    var suminsure: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.insuranceObjID <- map["insuranceObjId"]
        self.insuranceObjName <- map["insuranceObjName"]
        self.seat <- map["seat"]
        self.price <- map["price"]
        self.seatFee <- map["seatFee"]
        self.driverFee <- map["driverFee"]
        self.suminsure <- map["suminsure"]
    }
}

class ThuHoSOMBikeInsuranceProductDetail: Mappable {
    var productID: String = ""
    var productName: String = ""
    var providerName: String = ""
    var portraitLogoURL: String = ""
    var time: [ThuHoSOMBikeInsuranceTime] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.productID <- map["productId"]
        self.productName <- map["productName"]
        self.providerName <- map["providerName"]
        self.portraitLogoURL <- map["portraitLogoUrl"]
        self.time <- map["time"]
    }
}

class ThuHoSOMBikeInsuranceTime: Mappable {
    var productItemID: String = ""
    var activeTime: Int = 0
    var waitingTime: Int = 0
    var effectiveTime: Int = 0
    var isActive: Bool = false
    var title: String = ""
    var rate2Price: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.productItemID <- map["productItemId"]
        self.activeTime <- map["activeTime"]
        self.waitingTime <- map["waitingTime"]
        self.effectiveTime <- map["effectiveTime"]
        self.isActive <- map["isActive"]
        self.title <- map["title"]
        self.rate2Price <- map["rate2price"]
    }
}

class ThuHoSOMBikeInsuranceProvider: Mappable {
    var productID: String = ""
    var productName: String = ""
    var providerName: String = ""
    var referencePrice: String = ""
    var proType: String = ""
    var portraitLogoURL: String = ""
    var isShip: String = ""
    var isVATInvoice: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.productID <- map["productId"]
        self.productName <- map["productName"]
        self.providerName <- map["providerName"]
        self.referencePrice <- map["referencePrice"]
        self.proType <- map["proType"]
        self.portraitLogoURL <- map["portraitLogoUrl"]
        self.isShip <- map["isShip"]
        self.isVATInvoice <- map["isVATInvoice"]
    }
}
