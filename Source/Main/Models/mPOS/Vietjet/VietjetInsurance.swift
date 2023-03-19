//
//  VietjetInsurance.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 04/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class VietjetInsurance: Mappable {
    var purchaseKey: String = ""
    var name: String = ""
    var baseAmount: Int = 0
    var taxAmount: Int = 0
    var totalAmount: Int = 0
    var baseAmountFRT: Int = 0
    var taxAmountFRT: Int = 0
    var totalAmountFRT: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.purchaseKey <- map["purchaseKey"]
        self.name <- map["name"]
        self.baseAmount <- map["baseAmount"]
        self.taxAmount <- map["taxAmount"]
        self.totalAmount <- map["totalAmount"]
        self.baseAmountFRT <- map["baseAmountFRT"]
        self.taxAmountFRT <- map["taxAmountFRT"]
        self.totalAmountFRT <- map["totalAmountFRT"]
    }
}
