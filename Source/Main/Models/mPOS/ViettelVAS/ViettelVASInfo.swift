//
//  ViettelVASInfo.swift
//  fptshop
//
//  Created by DiemMy Le on 3/17/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViettelVASInfo: NSObject {

    let id, name, mDescription: String
    let enabled: Bool
    let mCode, parentID: String
    let products: [ViettelVAS_Product]
    let subCategories: [String]
    let extraProperties: ViettelVAS_ExtraProperty
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case mDescription = "description"
        case mCode = "code"
        case enabled, products, extraProperties, subCategories
        case parentID = "parentId"
    }
    
    init(id: String, name: String, mDescription: String, enabled: Bool, mCode: String, parentID: String, products: [ViettelVAS_Product], subCategories: [String], extraProperties: ViettelVAS_ExtraProperty) {
        self.id = id
        self.name = name
        self.mDescription = mDescription
        self.enabled = enabled
        self.mCode = mCode
        self.parentID = parentID
        self.products = products
        self.subCategories = subCategories
        self.extraProperties = extraProperties
    }
    
    class func getObjectFromJson(data: JSON) -> ViettelVASInfo {
        let products = ViettelVAS_Product.parseArrayFromJson(data: data["products"].arrayValue)
        let subCategories = ViettelVAS_Product.parseArrayString(data: data["subCategories"].arrayValue)
        let extraProperties = ViettelVAS_ExtraProperty.getObjectFromJson(data: data["extraProperties"])
        
        let obj = ViettelVASInfo(id: data["id"].stringValue, name: data["name"].stringValue, mDescription: data["description"].stringValue, enabled: data["enabled"].boolValue, mCode: data["code"].stringValue, parentID: data["parentId"].stringValue, products: products, subCategories: subCategories, extraProperties: extraProperties)
        return obj
    }
    
    class func parseArrayFromJson(data: [JSON]) -> [ViettelVASInfo] {
        var rs = [ViettelVASInfo]()
        for item in data {
            let i = ViettelVASInfo.getObjectFromJson(data: item)
            rs.append(i)
        }
        return rs
    }
}

class ViettelVAS_ExtraProperty: NSObject {
    let type, imageBase64: String
    
    init(type: String, imageBase64: String) {
        self.type = type
        self.imageBase64 = imageBase64
    }
    class func getObjectFromJson(data: JSON) -> ViettelVAS_ExtraProperty {
        let obj = ViettelVAS_ExtraProperty(type: data["type"].stringValue, imageBase64: data["imageBase64"].stringValue)
        return obj
    }
}

// MARK: - ViettelVASInfo_Detail
class ViettelVASInfo_Detail: NSObject {
    let providerID: String
    let price, sellingPrice, fixedFee, percentFee: Double
    let type: Int
    let allowCancel, allowUpdate, checkInventory: Bool

    init(providerID: String, price: Double, sellingPrice: Double, fixedFee: Double, percentFee: Double, type: Int, allowCancel: Bool, allowUpdate: Bool, checkInventory: Bool) {
        self.providerID = providerID
        self.price = price
        self.sellingPrice = sellingPrice
        self.fixedFee = fixedFee
        self.percentFee = percentFee
        self.type = type
        self.allowCancel = allowCancel
        self.allowUpdate = allowUpdate
        self.checkInventory = checkInventory
    }
    
    class func getObjectFromJson(data: JSON) -> ViettelVASInfo_Detail {
        let obj = ViettelVASInfo_Detail(providerID: data["providerId"].stringValue,
                                        price: data["price"].doubleValue,
                                        sellingPrice: data["sellingPrice"].doubleValue,
                                        fixedFee: data["fixedFee"].doubleValue,
                                        percentFee: data["percentFee"].doubleValue,
                                        type: data["type"].intValue,
                                        allowCancel: data["allowCancel"].boolValue,
                                        allowUpdate: data["allowUpdate"].boolValue,
                                        checkInventory: data["checkInventory"].boolValue)
        return obj
    }
}

// MARK: - ViettelVASInfo_Config
class ViettelVASInfo_Config: NSObject {
    let providerID, integratedProductCode, integratedGroupCode: String
    let allowCardPayment, allowCashPayment, allowVoucherPayment: Bool

    init(providerID: String, integratedProductCode: String, integratedGroupCode: String, allowCardPayment: Bool, allowCashPayment: Bool, allowVoucherPayment: Bool) {
        self.providerID = providerID
        self.integratedProductCode = integratedProductCode
        self.integratedGroupCode = integratedGroupCode
        self.allowCardPayment = allowCardPayment
        self.allowCashPayment = allowCashPayment
        self.allowVoucherPayment = allowVoucherPayment
    }
    class func getObjectFromJson(data: JSON) -> ViettelVASInfo_Config {
        let objc = ViettelVASInfo_Config(providerID: data["providerID"].stringValue,
                                         integratedProductCode: data["integratedProductCode"].stringValue,
                                         integratedGroupCode: data["integratedGroupCode"].stringValue,
                                         allowCardPayment: data["allowCardPayment"].boolValue,
                                         allowCashPayment: data["allowCashPayment"].boolValue,
                                         allowVoucherPayment: data["allowVoucherPayment"].boolValue)
        return objc
    }
    class func parseArrayFromJson(data: [JSON]) -> [ViettelVASInfo_Config] {
        var rs = [ViettelVASInfo_Config]()
        for item in data {
            let i = ViettelVASInfo_Config.getObjectFromJson(data: item)
            rs.append(i)
        }
        return rs
    }
}
// MARK: - ViettelVAS_Product
class ViettelVAS_Product: NSObject {
    let id, name, mDescription, mCode, legacyID, defaultProviderId: String
    let price, fixedFee, percentFee: Double
    let type: Int
    let enabled: Bool
    let details: ViettelVASInfo_Detail
    let configs: [ViettelVASInfo_Config]
    let providerIds: [String]
    let categoryIds: [String]
    let routingIds: [String]
    let promotionInventories: [String]
    
    init(id: String, name: String, mDescription: String, mCode: String, legacyID: String, defaultProviderId: String, price: Double, fixedFee: Double, percentFee: Double, type: Int, enabled: Bool, details: ViettelVASInfo_Detail, configs: [ViettelVASInfo_Config], providerIds: [String], categoryIds: [String], routingIds: [String], promotionInventories: [String]) {
        self.id = id
        self.name = name
        self.mDescription = mDescription
        self.mCode = mCode
        self.legacyID = legacyID
        self.defaultProviderId = defaultProviderId
        self.price = price
        self.fixedFee = fixedFee
        self.percentFee = percentFee
        self.type = type
        self.enabled = enabled
        self.details = details
        self.configs = configs
        self.providerIds = providerIds
        self.categoryIds = categoryIds
        self.routingIds = routingIds
        self.promotionInventories = promotionInventories
    }
    
    class func getObjectFromJson(data: JSON) -> ViettelVAS_Product {
        let details = ViettelVASInfo_Detail.getObjectFromJson(data: data["details"])
        let configs = ViettelVASInfo_Config.parseArrayFromJson(data: data["configs"].arrayValue)
        
        let providerIds = ViettelVAS_Product.parseArrayString(data: data["providerIds"].arrayValue)
        let categoryIds = ViettelVAS_Product.parseArrayString(data: data["categoryIds"].arrayValue)
        let routingIds = ViettelVAS_Product.parseArrayString(data: data["routingIds"].arrayValue)
        let promotionInventories = ViettelVAS_Product.parseArrayString(data: data["promotionInventories"].arrayValue)
        
        let obj = ViettelVAS_Product(id: data["id"].stringValue,
                                     name: data["name"].stringValue,
                                     mDescription: data["description"].stringValue,
                                     mCode: data["code"].stringValue,
                                     legacyID: data["legacyId"].stringValue,
                                     defaultProviderId: data["defaultProviderId"].stringValue,
                                     price: data["price"].doubleValue,
                                     fixedFee: data["fixedFee"].doubleValue,
                                     percentFee: data["percentFee"].doubleValue,
                                     type: data["type"].intValue, enabled: data["enabled"].boolValue,
                                     details: details,
                                     configs: configs,
                                     providerIds: providerIds,
                                     categoryIds: categoryIds,
                                     routingIds: routingIds,
                                     promotionInventories: promotionInventories)
        return obj
    }
    
    class func parseArrayFromJson(data: [JSON]) -> [ViettelVAS_Product] {
        var rs = [ViettelVAS_Product]()
        for item in data {
            let i = ViettelVAS_Product.getObjectFromJson(data: item)
            rs.append(i)
        }
        return rs
    }
    
    class func parseArrayString(data: [JSON]) -> [String] {
        var rs = [String]()
        for item in data {
            rs.append(item.stringValue)
        }
        return rs
    }
}
