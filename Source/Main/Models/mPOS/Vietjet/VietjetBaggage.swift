//
//  VietjetBaggage.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 26/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class VietjetBaggage: Mappable {
    var purchaseKey: String = ""
    var description: String = ""
    var name: String = ""
    var ancillaryCharge: VietjetAncillaryCharge = VietjetAncillaryCharge(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.purchaseKey <- map["purchaseKey"]
        self.description <- map["description"]
        self.name <- map["name"]
        self.ancillaryCharge <- map["ancillaryCharge"]
    }
}

class VietjetAncillaryCharge: Mappable {
    var baseAmount: Int = 0
    var taxAmount: Int = 0
    var totalAmount: Int = 0
    var baseAmountFRT: Int = 0
    var taxAmountFRT: Int = 0
    var totalAmountFRT: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.baseAmount <- map["baseAmount"]
        self.taxAmount <- map["taxAmount"]
        self.totalAmount <- map["totalAmount"]
        self.baseAmountFRT <- map["baseAmountFRT"]
        self.taxAmountFRT <- map["taxAmountFRT"]
        self.totalAmountFRT <- map["totalAmountFRT"]
    }
}
