//
//  VietjetSeat.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 26/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class VietjetSeat: Mappable {
    var column: String = ""
    var row: String = ""
    var seatOptions: [VietjetSeatOption] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.column <- map["column"]
        self.row <- map["row"]
        self.seatOptions <- map["seatOptions"]
    }
}

class VietjetSeatOption: Mappable {
    var selectionKey: String = ""
    var available: Bool = false
    var infant: Bool = false
    var color: String = ""
    var seatMapCell: VietjetSeatMapCell = VietjetSeatMapCell(JSON: [:])!
    var seatCharges: VietjetSeatCharges = VietjetSeatCharges(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.selectionKey <- map["selectionKey"]
        self.available <- map["available"]
        self.infant <- map["infant"]
        self.color <- map["color"]
        self.seatMapCell <- map["seatMapCell"]
        self.seatCharges <- map["seatCharges"]
    }
}

class VietjetSeatCharges: Mappable {
    var code: String = ""
    var seatChargesDescription: String = ""
    var baseAmount: Int = 0
    var taxAmount: Int = 0
    var totalAmount: Int = 0
    var baseAmountFRT: Int = 0
    var taxAmountFRT: Int = 0
    var totalAmountFRT: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.code <- map["code"]
        self.seatChargesDescription <- map["seatChargesDescription"]
        self.baseAmount <- map["baseAmount"]
        self.taxAmount <- map["taxAmount"]
        self.totalAmount <- map["totalAmount"]
        self.baseAmountFRT <- map["baseAmountFRT"]
        self.taxAmountFRT <- map["taxAmountFRT"]
        self.totalAmountFRT <- map["totalAmountFRT"]
    }
}

class VietjetSeatMapCell: Mappable {
    var rowIdentifier: String = ""
    var seatIdentifier: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.rowIdentifier <- map["rowIdentifier"]
        self.seatIdentifier <- map["seatIdentifier"]
    }
}

