//
//  ViettelVASGoiCuoc.swift
//  fptshop
//
//  Created by DiemMy Le on 3/17/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViettelVASGoiCuoc: NSObject {
    let integrationInfo: ViettelVASGoiCuoc_IntegrationInfo
    let subject: String
    let extraProperties:[ViettelVASGoiCuoc_extraPropertiesData]
    init(integrationInfo: ViettelVASGoiCuoc_IntegrationInfo, subject: String, extraProperties:[ViettelVASGoiCuoc_extraPropertiesData]) {
        self.integrationInfo = integrationInfo
        self.subject = subject
        self.extraProperties = extraProperties
    }
    class func getObjectFromJson(data: JSON) -> ViettelVASGoiCuoc {
        let integrationInfo = ViettelVASGoiCuoc_IntegrationInfo.getObjectFromJson(data: data["integrationInfo"])
        let extraPropertiesJson = data["extraProperties"]
        let extraProperties_data = ViettelVASGoiCuoc_extraPropertiesData.parseArrayFromJson(data: extraPropertiesJson["data"].arrayValue)
        
        let obj = ViettelVASGoiCuoc(integrationInfo: integrationInfo, subject: data["subject"].stringValue, extraProperties: extraProperties_data)
        return obj
    }
    
}

class ViettelVASGoiCuoc_extraPropertiesData: NSObject {
    let type: String
    let products: [ViettelVASGoiCuoc_products]
    
    init(type: String, products: [ViettelVASGoiCuoc_products]) {
        self.type = type
        self.products = products
    }
    class func getObjectFromJson(data: JSON) -> ViettelVASGoiCuoc_extraPropertiesData {
        let products = ViettelVASGoiCuoc_products.parseArrayFromJson(data: data["products"].arrayValue)
        let obj = ViettelVASGoiCuoc_extraPropertiesData(type: data["type"].stringValue, products: products)
        return obj
    }
    class func parseArrayFromJson(data: [JSON]) -> [ViettelVASGoiCuoc_extraPropertiesData] {
        var rs = [ViettelVASGoiCuoc_extraPropertiesData]()
        for item in data {
            let i = ViettelVASGoiCuoc_extraPropertiesData.getObjectFromJson(data: item)
            rs.append(i)
        }
        return rs
    }
}

class ViettelVASGoiCuoc_products: NSObject {
    var subName: String = ""
    let status, system_type, priority, remain: Int
    let price: Double
    let offered: Bool
    let mCode, prepaid_code, postpaid_code, type, name, desc, product_group, vtfreeType: String
    var isChooseGoiCuoc: Bool
    
    init(status: Int, system_type: Int, priority: Int, remain: Int, price: Double, offered: Bool, mCode: String, prepaid_code: String, postpaid_code: String, type: String, name: String, desc: String, product_group: String, vtfreeType: String, isChooseGoiCuoc: Bool, subName: String = "") {
        self.status = status
        self.system_type = system_type
        self.priority = priority
        self.remain = remain
        self.price = price
        self.offered = offered
        self.mCode = mCode
        self.prepaid_code = prepaid_code
        self.postpaid_code = postpaid_code
        self.type = type
        self.name = name
        self.desc = desc
        self.product_group = product_group
        self.vtfreeType = vtfreeType
        self.isChooseGoiCuoc = isChooseGoiCuoc
        self.subName = subName
    }
    
    class func getObjectFromJson(data: JSON) -> ViettelVASGoiCuoc_products {
        let obj = ViettelVASGoiCuoc_products(status: data["status"].intValue,
                                             system_type: data["system_type"].intValue,
                                             priority: data["priority"].intValue,
                                             remain: data["remain"].intValue,
                                             price: data["price"].doubleValue,
                                             offered: data["offered"].boolValue,
                                             mCode: data["code"].stringValue,
                                             prepaid_code: data["prepaid_code"].stringValue,
                                             postpaid_code: data["postpaid_code"].stringValue,
                                             type: data["type"].stringValue,
                                             name: data["name"].stringValue,
                                             desc: data["desc"].stringValue,
                                             product_group: data["product_group"].stringValue,
                                             vtfreeType: data["vtfreeType"].stringValue,
                                             isChooseGoiCuoc: false)
        return obj
    }
    
    class func parseArrayFromJson(data: [JSON]) -> [ViettelVASGoiCuoc_products] {
        var rs = [ViettelVASGoiCuoc_products]()
        for item in data {
            let i = ViettelVASGoiCuoc_products.getObjectFromJson(data: item)
            rs.append(i)
        }
        return rs
    }
}
class ViettelVASGoiCuoc_IntegrationInfo: NSObject {
    let requestId, responseId, returnedCode, returnedMessage: String
    init(requestId: String, responseId: String, returnedCode: String, returnedMessage: String) {
        self.requestId = requestId
        self.responseId = responseId
        self.returnedCode = returnedCode
        self.returnedMessage = returnedMessage
    }
    class func getObjectFromJson(data: JSON) -> ViettelVASGoiCuoc_IntegrationInfo {
        let obj = ViettelVASGoiCuoc_IntegrationInfo(requestId: data["requestId"].stringValue,
                                                    responseId: data["responseId"].stringValue,
                                                    returnedCode: data["returnedCode"].stringValue,
                                                    returnedMessage: data["returnedMessage"].stringValue)
        return obj
    }
}
