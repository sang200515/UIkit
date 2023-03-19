//
//  VietjetPaymentHistory.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 29/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class VietjetPaymentHistory: Mappable {
    var id: Int = 0
    var key: String = ""
    var number: String = ""
    var locator: String = ""
    var contactName: String = ""
    var contactPhone: String = ""
    var contactEmail: String = ""
    var totalAmountFRT: Int = 0
    var sompos: Int = 0
    var createdate: String = ""
    var createby: String = ""
    var status: String = ""
    var color: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.id <- map["Id"]
        self.key <- map["key"]
        self.number <- map["number"]
        self.locator <- map["locator"]
        self.contactName <- map["contactName"]
        self.contactPhone <- map["contactPhone"]
        self.contactEmail <- map["contactEmail"]
        self.totalAmountFRT <- map["TotalAmountFRT"]
        self.sompos <- map["SO_MPOS"]
        self.createdate <- map["createdate"]
        self.createby <- map["createby"]
        self.status <- map["status"]
        self.color <- map["color"]
    }
}
