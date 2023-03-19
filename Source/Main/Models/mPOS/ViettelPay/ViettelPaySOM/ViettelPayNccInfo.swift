//
//  ViettelPayNccInfo.swift
//  fptshop
//
//  Created by DiemMy Le on 3/1/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//{
//    "id": "79ef7a15-eefe-4d6d-a816-90df86cd0ad3",
//    "price": null,
//    "fixedFee": null,
//    "percentFee": null,
//    "type": 1,
//    "details": {
//        "providerId": "67defced-5f16-4ba9-9db8-5eac8fe9df68",
//        "price": null,
//        "sellingPrice": null,
//        "fixedFee": null,
//        "percentFee": null,
//        "type": 1,
//        "allowCancel": false,
//        "allowUpdate": false,
//        "checkInventory": false,
//        "extraProperties": {}
//    },
//    "configs": [
//        {
//            "providerId": "67defced-5f16-4ba9-9db8-5eac8fe9df68",
//            "integratedProductCode": "TRANSFER",
//            "integratedGroupCode": "TOPUP",
//            "allowCardPayment": true,
//            "allowCashPayment": true,
//            "allowVoucherPayment": true
//        }
//    ],
//    "providerIds": [
//        "67defced-5f16-4ba9-9db8-5eac8fe9df68"
//    ],
//    "routingIds": [],
//    "promotionInventories": [],
//    "name": "Nạp tiền tài khoản Viettel Pay",
//    "description": "Nạp tiền tài khoản Viettel Pay",
//    "code": null,
//    "legacyId": null,
//    "enabled": true,
//    "defaultProviderId": "67defced-5f16-4ba9-9db8-5eac8fe9df68",
//    "categoryIds": [
//        "e0b79ec6-f263-4473-ab07-97bf6299281a"
//    ]
//}

import UIKit
import SwiftyJSON

class ViettelPayNccInfo: NSObject {

    let id: String
    let price: String
    let fixedFee: String
    let percentFee: String
    let type: Int
    let name: String
    let mDescription: String
    let mCode: String
    let legacyId: String
    let enabled: Bool
    let defaultProviderId: String
    let details: ViettelPayNccInfo_Detail
    let configs: [ViettelPayNccInfo_Config]
    let providerIds: [String]
    let routingIds: [String]
    let promotionInventories: [String]
    let categoryIds: [String]
    
    init(id: String, price: String, fixedFee: String, percentFee: String, type: Int, name: String, mDescription: String, mCode: String, legacyId: String, enabled: Bool, defaultProviderId: String, details: ViettelPayNccInfo_Detail, configs: [ViettelPayNccInfo_Config], providerIds: [String], routingIds: [String], promotionInventories: [String], categoryIds: [String]) {
        
        self.id = id
        self.price = price
        self.fixedFee = fixedFee
        self.percentFee = percentFee
        self.type = type
        self.name = name
        self.mDescription = mDescription
        self.mCode = mCode
        self.legacyId = legacyId
        self.enabled = enabled
        self.defaultProviderId = defaultProviderId
        self.details = details
        self.configs = configs
        self.providerIds = providerIds
        self.routingIds = routingIds
        self.promotionInventories = promotionInventories
        self.categoryIds = categoryIds
    }
    
    class func getObjFromDictionary(data:JSON) -> ViettelPayNccInfo{
        
        let id = data["id"].stringValue
        let price = data["price"].stringValue
        let fixedFee = data["fixedFee"].stringValue
        let percentFee = data["percentFee"].stringValue
        let type = data["type"].intValue
        let name = data["name"].stringValue
        let mDescription = data["description"].stringValue
        let mCode = data["code"].stringValue
        let legacyId = data["legacyId"].stringValue
        let enabled = data["enabled"].boolValue
        let defaultProviderId = data["defaultProviderId"].stringValue
        
        let detailsJson = data["details"]
        let details = ViettelPayNccInfo_Detail.getObjFromDictionary(data: detailsJson)
        
        let configsJsonArray = data["configs"].arrayValue
        let configs = ViettelPayNccInfo_Config.parseObjfromArray(array: configsJsonArray)
        
        let providerIdsJsonArray = data["providerIds"].arrayValue
        var arrproviderIdsString = [String]()
        for pro in providerIdsJsonArray {
            arrproviderIdsString.append(pro.stringValue)
        }
        
        let routingIdsJsonArray = data["routingIds"].arrayValue
        var routingIdsString = [String]()
        for routing in routingIdsJsonArray {
            routingIdsString.append(routing.stringValue)
        }
        
        let promotionInventoriesJsonArray = data["promotionInventories"].arrayValue
        var promotionInventoriesString = [String]()
        for promotion in promotionInventoriesJsonArray {
            promotionInventoriesString.append(promotion.stringValue)
        }
        
        let categoryIdsJsonArray = data["categoryIds"].arrayValue
        var categoryIdsString = [String]()
        for cate in categoryIdsJsonArray {
            categoryIdsString.append(cate.stringValue)
        }
        
        return ViettelPayNccInfo(id: id, price: price, fixedFee: fixedFee, percentFee: percentFee, type: type, name: name, mDescription: mDescription, mCode: mCode, legacyId: legacyId, enabled: enabled, defaultProviderId: defaultProviderId, details: details, configs: configs, providerIds: arrproviderIdsString, routingIds: routingIdsString, promotionInventories: promotionInventoriesString, categoryIds: categoryIdsString)
    }
}


class ViettelPayNccInfo_Detail {
    let providerId: String
    let price: String
    let sellingPrice: String
    let fixedFee: String
    let percentFee: String
    let type: Int
    let allowCancel: Bool
    let allowUpdate: Bool
    let checkInventory: Bool
    
    init(providerId: String, price: String, sellingPrice: String, fixedFee: String, percentFee: String, type: Int, allowCancel: Bool, allowUpdate: Bool, checkInventory: Bool) {
        
        self.providerId = providerId
        self.price = price
        self.sellingPrice = sellingPrice
        self.fixedFee = fixedFee
        self.percentFee = percentFee
        self.type = type
        self.allowCancel = allowCancel
        self.allowUpdate = allowUpdate
        self.checkInventory = checkInventory
    }
    
    class func parseObjfromArray(array:[JSON])->[ViettelPayNccInfo_Detail]{
        var list:[ViettelPayNccInfo_Detail] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ViettelPayNccInfo_Detail{
        
        let providerId = data["providerId"].stringValue
        let price = data["price"].stringValue
        let sellingPrice = data["sellingPrice"].stringValue
        let fixedFee = data["fixedFee"].stringValue
        let percentFee = data["percentFee"].stringValue
        let type = data["type"].intValue
        let allowCancel = data["allowCancel"].boolValue
        let allowUpdate = data["allowUpdate"].boolValue
        let checkInventory = data["checkInventory"].boolValue
        
        return ViettelPayNccInfo_Detail(providerId: providerId, price: price, sellingPrice: sellingPrice, fixedFee: fixedFee, percentFee: percentFee, type: type, allowCancel: allowCancel, allowUpdate: allowUpdate, checkInventory: checkInventory)
    }
}

class ViettelPayNccInfo_Config {
    let providerId: String
    let integratedProductCode: String
    let integratedGroupCode: String
    let allowCardPayment: Bool
    let allowCashPayment: Bool
    let allowVoucherPayment: Bool
    
    init(providerId: String, integratedProductCode: String, integratedGroupCode: String, allowCardPayment: Bool, allowCashPayment: Bool, allowVoucherPayment: Bool) {
        
        self.providerId = providerId
        self.integratedProductCode = integratedProductCode
        self.integratedGroupCode = integratedGroupCode
        self.allowCardPayment = allowCardPayment
        self.allowCashPayment = allowCashPayment
        self.allowVoucherPayment = allowVoucherPayment
    }
    
    class func parseObjfromArray(array:[JSON])->[ViettelPayNccInfo_Config]{
        var list:[ViettelPayNccInfo_Config] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ViettelPayNccInfo_Config{
        
        let providerId = data["providerId"].stringValue
        let integratedProductCode = data["integratedProductCode"].stringValue
        let integratedGroupCode = data["integratedGroupCode"].stringValue
        let allowCardPayment = data["allowCardPayment"].boolValue
        let allowCashPayment = data["allowCashPayment"].boolValue
        let allowVoucherPayment = data["allowVoucherPayment"].boolValue
        
        return ViettelPayNccInfo_Config(providerId: providerId, integratedProductCode: integratedProductCode, integratedGroupCode: integratedGroupCode, allowCardPayment: allowCardPayment, allowCashPayment: allowCashPayment, allowVoucherPayment: allowVoucherPayment)
    }
}
