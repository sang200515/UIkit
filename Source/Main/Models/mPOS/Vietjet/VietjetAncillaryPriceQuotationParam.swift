//
//  VietjetAncillaryPriceQuotationParam.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 05/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class VietjetAncillaryPriceQuotationParam: Mappable {
    var order: VietjetOrder = VietjetOrder(JSON: [:])!
    var contact: VietjetContact = VietjetContact(JSON: [:])!
    var booking: VietjetAncillaryBooking = VietjetAncillaryBooking(JSON: [:])!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.order <- map["order"]
        self.contact <- map["contact"]
        self.booking <- map["booking"]
    }
}

class VietjetAncillaryBooking: Mappable {
    var locator: String = ""
    var number: String = ""
    var resKey: String = ""
    var ancillaryPurchases: VietjetAncillaryPurchases?
    var seatPurchases: VietjetSeatPurchases?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.locator <- map["locator"]
        self.number <- map["number"]
        self.resKey <- map["resKey"]
        self.ancillaryPurchases <- map["ancillaryPurchases"]
        self.seatPurchases <- map["seatSelections"]
    }
}

class VietjetAncillaryPurchases: Mappable {
    var ancillaryPurchasesDescription: String = ""
    var purchaseKey: String = ""
    var passenger: VietjetJourney = VietjetJourney(JSON: [:])!
    var journey: VietjetJourney = VietjetJourney(JSON: [:])!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.ancillaryPurchasesDescription <- map["description"]
        self.purchaseKey <- map["purchaseKey"]
        self.passenger <- map["passenger"]
        self.journey <- map["journey"]
    }
}

class VietjetSeatPurchases: Mappable {
    var seatPurchasesDescription: String = ""
    var selectionKey: String = ""
    var passenger: VietjetJourney = VietjetJourney(JSON: [:])!
    var journey: VietjetJourney = VietjetJourney(JSON: [:])!
    var segment: VietjetSegment = VietjetSegment(JSON: [:])!
    var timestamp: String?
    var seatSelectionKey: String?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.seatPurchasesDescription <- map["description"]
        self.selectionKey <- map["selectionKey"]
        self.passenger <- map["passenger"]
        self.journey <- map["journey"]
        self.segment <- map["segment"]
        self.timestamp <- map["timestamp"]
        self.seatSelectionKey <- map["seatSelectionKey"]
    }
}

class VietjetJourney: Mappable {
    var key: String = ""
    var href: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.key <- map["key"]
        self.href <- map["href"]
    }
}
