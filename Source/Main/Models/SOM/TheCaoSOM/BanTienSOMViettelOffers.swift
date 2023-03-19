//
//  BanTienSOMViettelOffers.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 28/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class BanTienSOMViettelOffers: Mappable {
    var integrationInfo: BanTienSOMIntegrationInfo = BanTienSOMIntegrationInfo(JSON: [:])!
    var subject: String = ""
    var extraProperties: BanTienSOMExtraProperties = BanTienSOMExtraProperties(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.integrationInfo <- map["integrationInfo"]
        self.subject <- map["subject"]
        self.extraProperties <- map["extraProperties"]
    }
}

class BanTienSOMExtraProperties: Mappable {
    var data: [BanTienSOMViettelData] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.data <- map["data"]
    }
}

class BanTienSOMViettelData: Mappable {
    var type: String = ""
    var products: [BanTienSOMViettelProduct] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.type <- map["type"]
        self.products <- map["products"]
    }
}

class BanTienSOMViettelProduct: Mappable {
    var status: Int = 0
    var code: String = ""
    var prepaidCode: String = ""
    var postpaidCode: String = ""
    var type: String = ""
    var systemType: Int = 0
    var price: Int = 0
    var priority: Int = 0
    var name: String = ""
    var desc: String = ""
    var offered: Bool = false
    var productGroup: String = ""
    var remain: Int = 0
    var vtfreeType: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.status <- map["status"]
        self.code <- map["code"]
        self.prepaidCode <- map["prepaidCode"]
        self.postpaidCode <- map["postpaidCode"]
        self.type <- map["type"]
        self.systemType <- map["systemType"]
        self.price <- map["price"]
        self.priority <- map["priority"]
        self.name <- map["name"]
        self.desc <- map["desc"]
        self.offered <- map["offered"]
        self.productGroup <- map["productGroup"]
        self.remain <- map["remain"]
        self.vtfreeType <- map["vtfreeType"]
    }
}

class BanTienSOMIntegrationInfo: Mappable {
    var requestID: String = ""
    var responseID: String = ""
    var returnedCode: String = ""
    var returnedMessage: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.requestID <- map["requestId"]
        self.responseID <- map["responseId"]
        self.returnedCode <- map["returnedCode"]
        self.returnedMessage <- map["returnedMessage"]
    }
}

