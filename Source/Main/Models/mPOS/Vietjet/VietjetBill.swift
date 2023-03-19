//
//  VietjetBill.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class VietjetBill: Mappable {
    var charges: [VietjetCharge] = []
    var totalAmount: Int = 0
    var totalAmountFRT: Int = 0
    var xmlItemProducts: String = ""
    var number: String = ""
    var locator: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.charges <- map["charges"]
        self.totalAmount <- map["totalAmount"]
        self.totalAmountFRT <- map["totalAmountFRT"]
        self.xmlItemProducts <- map["xmlItemProducts"]
        self.number <- map["number"]
        self.locator <- map["locator"]
    }
}

class VietjetCharge: Mappable {
    var chargeDescription: String = ""
    var baseAmount: Int = 0
    var taxAmount: Int = 0
    var totalAmount: Int = 0
    var baseAmountFRT: Int = 0
    var taxAmountFRT: Int = 0
    var totalAmountFRT: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.chargeDescription <- map["chargeDescription"]
        self.baseAmount <- map["baseAmount"]
        self.taxAmount <- map["taxAmount"]
        self.totalAmount <- map["totalAmount"]
        self.baseAmountFRT <- map["baseAmountFRT"]
        self.taxAmountFRT <- map["taxAmountFRT"]
        self.totalAmountFRT <- map["totalAmountFRT"]
    }
}
