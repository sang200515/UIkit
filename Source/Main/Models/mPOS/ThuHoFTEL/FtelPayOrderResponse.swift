//
//  FtelPayOrderResponse.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 14/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class FtelPayOrderResponse: Mappable {
    var code: String = ""
    var message: String = ""
    var extraProperties: FtelResponseExtraProperties = FtelResponseExtraProperties(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.code <- map["code"]
        self.message <- map["message"]
        self.extraProperties <- map["extraProperties"]
    }
}

class FtelResponseExtraProperties: Mappable {
    var message: FtelResponseMessage = FtelResponseMessage(JSON: [:])!
    var data: FtelResponseDataClass = FtelResponseDataClass(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.message <- map["message"]
        self.data <- map["data"]
    }
}

class FtelResponseDataClass: Mappable {
    var isSuccess: Bool = false
    var status: Int = 0
    var statusDescription: String = ""
    var transactionId: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.isSuccess <- map["isSuccess"]
        self.status <- map["status"]
        self.statusDescription <- map["statusDescription"]
        self.transactionId <- map["transactionId"]
    }
}

class FtelResponseMessage: Mappable {
    var message: String = ""
    var exMessage: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.message <- map["message"]
        self.exMessage <- map["exMessage"]
    }
}
