//
//  VietjetJourneyPriceQuotationParam.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 11/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class VietjetJourneyPriceQuotationParam: Mappable {
    var order: VietjetOrder = VietjetOrder(JSON: [:])!
    var contact: VietjetContact = VietjetContact(JSON: [:])!
    var booking: VietjetFlightBooking = VietjetFlightBooking(JSON: [:])!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.order <- map["order"]
        self.contact <- map["contact"]
        self.booking <- map["booking"]
    }
}

class VietjetFlightBooking: Mappable {
    var resKey: String = ""
    var number: String = ""
    var locator: String = ""
    var reservationJourney: VietjetReservationJourney = VietjetReservationJourney(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.resKey <- map["resKey"]
        self.number <- map["number"]
        self.locator <- map["locator"]
        self.reservationJourney <- map["reservationJourney"]
    }
}

class VietjetReservationJourney: Mappable {
    var journeyKey: String = ""
    var bookingKey: String = ""
    var airlineNumber: String = ""
    var aircraftModel: String = ""
    var cityPair: DepartureCityPair = DepartureCityPair(JSON: [:])!
    var journeyDetails: [VietjetJourneyDetail] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.journeyKey <- map["journeyKey"]
        self.bookingKey <- map["bookingKey"]
        self.airlineNumber <- map["airlineNumber"]
        self.aircraftModel <- map["aircraftModel"]
        self.cityPair <- map["cityPair"]
        self.journeyDetails <- map["passengerJourneyDetails"]
    }
}
