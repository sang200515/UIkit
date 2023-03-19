//
//  ThuHoSOMBikeInsuranceProductByCode.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 24/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class ThuHoSOMBikeInsuranceProductByCode: Mappable {
    var totalCount: Int = 0
    var items: [ThuHoSOMBikeInsuranceProductByCodeItem] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.totalCount <- map["totalCount"]
        self.items <- map["items"]
    }
}

class ThuHoSOMBikeInsuranceProductByCodeItem: Mappable {
    var id: String = ""
    var price: Int = 0
    var fixedFee: Int = 0
    var percentFee: Int = 0
    var type: Int = 0
    var details: ThuHoSOMBikeInsuranceProductByCodeDetails = ThuHoSOMBikeInsuranceProductByCodeDetails(JSON: [:])!
    var configs: [ThuHoSOMBikeInsuranceProductByCodeConfig] = []
    var providerIDS: [String] = []
    var routingIDS: [String] = []
    var promotionInventories: [String] = []
    var name: String = ""
    var description: String = ""
    var code: String = ""
    var legacyID: String = ""
    var enabled: Bool = false
    var defaultProviderID: String = ""
    var categoryIDS: [String] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.price <- map["price"]
        self.fixedFee <- map["fixedFee"]
        self.percentFee <- map["percentFee"]
        self.type <- map["type"]
        self.details <- map["details"]
        self.configs <- map["configs"]
        self.providerIDS <- map["providerIds"]
        self.routingIDS <- map["routingIds"]
        self.promotionInventories <- map["promotionInventories"]
        self.name <- map["name"]
        self.description <- map["description"]
        self.code <- map["code"]
        self.legacyID <- map["legacyId"]
        self.enabled <- map["enabled"]
        self.defaultProviderID <- map["defaultProviderId"]
        self.categoryIDS <- map["categoryIds"]
    }
}

class ThuHoSOMBikeInsuranceProductByCodeConfig: Mappable {
    var providerID: String = ""
    var integratedProductCode: String = ""
    var integratedGroupCode: String = ""
    var allowCardPayment: Bool = false
    var allowCashPayment: Bool = false
    var allowVoucherPayment: Bool = false
    var createURL: String = ""
    var createMobileScreen: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.providerID <- map["providerId"]
        self.integratedProductCode <- map["integratedProductCode"]
        self.integratedGroupCode <- map["integratedGroupCode"]
        self.allowCardPayment <- map["allowCardPayment"]
        self.allowCashPayment <- map["allowCashPayment"]
        self.allowVoucherPayment <- map["allowVoucherPayment"]
        self.createURL <- map["createUrl"]
        self.createMobileScreen <- map["createMobileScreen"]
    }
}

class ThuHoSOMBikeInsuranceProductByCodeDetails: Mappable {
    var providerID: String = ""
    var price: Int = 0
    var sellingPrice: Int = 0
    var fixedFee: Int = 0
    var percentFee: Int = 0
    var type: Int = 0
    var allowCancel: Bool = false
    var allowUpdate: Bool = false
    var checkInventory: Bool = false
    var extraProperties: ThuHoSOMBikeInsuranceProductByCodeExtraProperties = ThuHoSOMBikeInsuranceProductByCodeExtraProperties(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.providerID <- map["providerId"]
        self.price <- map["price"]
        self.sellingPrice <- map["sellingPrice"]
        self.fixedFee <- map["fixedFee"]
        self.percentFee <- map["percentFee"]
        self.type <- map["type"]
        self.allowCancel <- map["allowCancel"]
        self.allowUpdate <- map["allowUpdate"]
        self.checkInventory <- map["checkInventory"]
        self.extraProperties <- map["extraProperties"]
    }
}

class ThuHoSOMBikeInsuranceProductByCodeExtraProperties: Mappable {
    var payInProvider: String = ""
    var payOutProvider: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.payInProvider <- map["payInProvider"]
        self.payOutProvider <- map["payOutProvider"]
    }
}
