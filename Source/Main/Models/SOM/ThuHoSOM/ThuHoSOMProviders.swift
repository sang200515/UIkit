//
//  ThuHoSOMProviders.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 20/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class ThuHoSOMProviders: Mappable {
    var totalCount: Int = 0
    var items: [ThuHoSOMProviderItem] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.totalCount <- map["totalCount"]
        self.items <- map["items"]
    }
}

class ThuHoSOMProviderItem: Mappable {
    var name: String = ""
    var itemDescription: String = ""
    var integrationType: String = ""
    var enabled: Bool = false
    var attributes: [ThuHoSOMProviderAttribute] = []
    var id: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.name <- map["name"]
        self.itemDescription <- map["itemDescription"]
        self.integrationType <- map["integrationType"]
        self.enabled <- map["enabled"]
        self.attributes <- map["attributes"]
        self.id <- map["id"]
    }
}

class ThuHoSOMProviderAttribute: Mappable {
    var valueID: String = ""
    var value: String = ""
    var name: String = ""
    var type: String = ""
    var order: Int = 0
    var isShowUI: Bool = false
    var id: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.valueID <- map["valueId"]
        self.value <- map["value"]
        self.name <- map["name"]
        self.type <- map["type"]
        self.order <- map["order"]
        self.isShowUI <- map["isShowUi"]
        self.id <- map["id"]
    }
}
