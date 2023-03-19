//
//  TheNapSOMItems.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 22/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class TheNapSOMItems: Mappable {
    var totalCount: Int = 0
    var items: [TheNapSOMItem] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.totalCount <- map["totalCount"]
        self.items <- map["items"]
    }
}

class TheNapSOMItem: Mappable {
    var name: String = ""
    var description: String = ""
    var enabled: Bool = false
    var code: String = ""
    var parentID: String = ""
    var products: [TheNapSOMProduct] = []
    var subCategories: [String] = []
    var extraProperties: TheNapSOMExtraProperties = TheNapSOMExtraProperties(JSON: [:])!
    var id: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.name <- map["name"]
        self.description <- map["description"]
        self.enabled <- map["enabled"]
        self.code <- map["code"]
        self.parentID <- map["parentId"]
        self.products <- map["products"]
        self.subCategories <- map["subCategories"]
        self.extraProperties <- map["extraProperties"]
        self.id <- map["id"]
    }
}

class TheNapSOMExtraProperties: Mappable {
    var size: Int = 0
    var type: String = ""
    var imageBase64: String = ""
    var referenceIntegrationInfo: TheNapSOMReferenceIntegrationInfo = TheNapSOMReferenceIntegrationInfo(JSON: [:])!
    var telPrefix: [String] = []
    var otp: String  = ""
    var warehouseName: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.warehouseName <- map["warehouseName"]
        self.otp <- map["otp"]
        self.size <- map["size"]
        self.type <- map["type"]
        self.imageBase64 <- map["imageBase64"]
        self.referenceIntegrationInfo <- map["referenceIntegrationInfo"]
        self.telPrefix <- map["telPrefix"]
    }
}

class TheNapSOMProduct: Mappable {
    var id: String = ""
    var price: Int = 0
    var fixedFee: Int = 0
    var percentFee: Int = 0
    var type: String = ""
    var details: TheNapSOMProductDetails = TheNapSOMProductDetails(JSON: [:])!
    var configs: [TheNapSOMProductConfig] = []
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
        var intType: Int = 0
        intType <- map["type"]
        self.type = "\(intType)"
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

class TheNapSOMProductConfig: Mappable {
    var providerID: String = ""
    var integratedProductCode: String = ""
    var integratedGroupCode: String = ""
    var allowCardPayment: Bool = false
    var allowCashPayment: Bool = false
    var allowVoucherPayment: Bool = false
    var createURL: String = ""

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
    }
}

class TheNapSOMProductDetails: Mappable {
    var providerID: String = ""
    var price: Int = 0
    var sellingPrice: Int = 0
    var fixedFee: Int = 0
    var percentFee: Int = 0
    var type: Int = 0
    var allowCancel: Bool = false
    var allowUpdate: Bool = false
    var checkInventory: Bool = false
    var extraProperties: TheNapSOMExtraProperties = TheNapSOMExtraProperties(JSON: [:])!

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
