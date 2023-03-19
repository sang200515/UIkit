//
//  ThuHoSOMCatagories.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class ThuHoSOMCatagories: Mappable {
    var totalCount: Int = 0
    var items: [ThuHoSOMItem] = []
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.totalCount <- map["totalCount"]
        self.items <- map["items"]
    }
}

class ThuHoSOMItem: Mappable {
    var name: String = ""
    var itemDescription: String = ""
    var enabled: Bool = false
    var code: String = ""
    var parentId: String = ""
    var products: [ThuHoSOMProduct] = []
    var subCategories: [String] = []
    var extraProperties: ThuHoSOMItemExtraProperties = ThuHoSOMItemExtraProperties(JSON: [:])!
    var id: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.name <- map["name"]
        self.itemDescription <- map["itemDescription"]
        self.enabled <- map["enabled"]
        self.code <- map["code"]
        self.parentId <- map["parentId"]
        self.products <- map["products"]
        self.subCategories <- map["subCategories"]
        self.extraProperties <- map["extraProperties"]
        self.id <- map["id"]
    }
}

class ThuHoSOMItemExtraProperties: Mappable {
    var isHideProduct: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.isHideProduct <- map["isHideProduct"]
    }
}

class ThuHoSOMProduct: Mappable {
    var id: String = ""
    var price: Int = 0
    var fixedFee: Int = 0
    var percentFee: Int = 0
    var type: Int = 0
    var details: ThuHoSOMDetails = ThuHoSOMDetails(JSON: [:])!
    var configs: [ThuHoSOMConfig] = []
    var providerIds: [String] = []
    var routingIds: [String] = []
    var promotionInventories: [String] = []
    var name: String = ""
    var productDescription: String = ""
    var code: String = ""
    var legacyId: String = ""
    var enabled: Bool = false
    var defaultProviderId: String = ""
    var categoryIds: [String] = []

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
        self.providerIds <- map["providerIds"]
        self.routingIds <- map["routingIds"]
        self.promotionInventories <- map["promotionInventories"]
        self.name <- map["name"]
        self.productDescription <- map["productDescription"]
        self.code <- map["code"]
        self.legacyId <- map["legacyId"]
        self.enabled <- map["enabled"]
        self.defaultProviderId <- map["defaultProviderId"]
        self.categoryIds <- map["categoryIds"]
    }
}

class ThuHoSOMConfig: Mappable {
    var providerId: String = ""
    var integratedProductCode: String = ""
    var integratedGroupCode: String = ""
    var allowCardPayment: Bool = false
    var allowCashPayment: Bool = false
    var allowVoucherPayment: Bool = false
    var createURL: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.providerId <- map["providerId"]
        self.integratedProductCode <- map["integratedProductCode"]
        self.integratedGroupCode <- map["integratedGroupCode"]
        self.allowCardPayment <- map["allowCardPayment"]
        self.allowCashPayment <- map["allowCashPayment"]
        self.allowVoucherPayment <- map["allowVoucherPayment"]
        self.createURL <- map["createUrl"]
    }
}

class ThuHoSOMDetails: Mappable {
    var providerId: String = ""
    var price: Int = 0
    var sellingPrice: Int = 0
    var fixedFee: Int = 0
    var percentFee: Int = 0
    var type: Int = 0
    var allowCancel: Bool = false
    var allowUpdate: Bool = false
    var checkInventory: Bool = false
    var extraProperties: ThuHoSOMDetailsExtraProperties = ThuHoSOMDetailsExtraProperties(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.providerId <- map["providerId"]
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

class ThuHoSOMDetailsExtraProperties: Mappable {
    var payInProvider: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.payInProvider <- map["payInProvider"]
    }
}
