//
//  VietjetTravelOption.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 23/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class VietjetTravelOption: Mappable {
    var departureOption: TravelOption = TravelOption(JSON: [:])!
    var returnOption: TravelOption = TravelOption(JSON: [:])!
    var htmlTAC: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.departureOption <- map["departure"]
        self.returnOption <- map["return"]
        self.htmlTAC <- map["htmlTAC"]
    }
}

class TravelOption: Mappable {
    var options: VietjetOption = VietjetOption(JSON: [:])!
    var cityPair: DepartureCityPair = DepartureCityPair(JSON: [:])!
    var travels: [VietjetTravel] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.options <- map["options"]
        self.cityPair <- map["cityPair"]
        self.travels <- map["travels"]
    }
}

class DepartureCityPair: Mappable {
    var identifier: String = ""
    var departure: VietjetArrival = VietjetArrival(JSON: [:])!
    var arrival: VietjetArrival = VietjetArrival(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.identifier <- map["identifier"]
        self.departure <- map["departure"]
        self.arrival <- map["arrival"]
    }
}

class VietjetCity: Mappable {
    var airport: VietjetAirport = VietjetAirport(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.airport <- map["airport"]
    }
}

class VietjetAirport: Mappable {
    var code: String = ""
    var name: String = ""
    var type: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.code <- map["code"]
        self.name <- map["name"]
        self.type <- map["type"]
    }
}

class VietjetOption: Mappable {
    var adultCount: Int = 0
    var childCount: Int = 0
    var infantCount: Int = 0
    var text: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.adultCount <- map["adultCount"]
        self.childCount <- map["childCount"]
        self.infantCount <- map["infantCount"]
        self.text <- map["text"]
    }
}

class VietjetTravel: Mappable {
    var cityPair: DepartureCityPair = DepartureCityPair(JSON: [:])!
    var departureDate: String = ""
    var departureTime: String = ""
    var totalTime: String = ""
    var numberOfStops: Int = 0
    var airlineNumber: String = ""
    var aircraftModel: String = ""
    var fareOptions: [FareOption] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.cityPair <- map["cityPair"]
        self.departureDate <- map["departureDate"]
        self.departureTime <- map["departureTime"]
        self.totalTime <- map["totalTime"]
        self.numberOfStops <- map["numberOfStops"]
        self.airlineNumber <- map["airlineNumber"]
        self.aircraftModel <- map["aircraftModel"]
        self.fareOptions <- map["fareOptions"]
    }
}

class TravelCityPair: Mappable {
    var identifier: String = ""
    var departure: VietjetArrival = VietjetArrival(JSON: [:])!
    var arrival: VietjetArrival = VietjetArrival(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.identifier <- map["identifier"]
        self.departure <- map["departure"]
        self.arrival <- map["arrival"]
    }
}

class VietjetArrival: Mappable {
    var code: String = ""
    var name: String = ""
    var schedueledTime: String = ""
    var hours: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.code <- map["code"]
        self.name <- map["name"]
        self.schedueledTime <- map["schedueledTime"]
        self.hours <- map["hours"]
    }
}

class FareOption: Mappable {
    var bookingKey: String = ""
    var fareClass: String = ""
    var logo: String = ""
    var html: String = ""
    var totalAmount: Int = 0
    var totalAmountFRT: Int = 0
    var fareCharges: [FareCharge] = []
    var fareChargeDetails: [FareChargeDetail] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.bookingKey <- map["bookingKey"]
        self.fareClass <- map["fareClass"]
        self.logo <- map["logo"]
        self.html <- map["html"]
        self.totalAmount <- map["totalAmount"]
        self.fareCharges <- map["fareCharges"]
        self.fareChargeDetails <- map["fareChargeDetails"]
        self.totalAmountFRT <- map["totalAmountFRT"]
    }
}

class FareCharge: Mappable {
    var fareChargeDescription: String = ""
    var baseAmount: Int = 0
    var taxAmount: Int = 0
    var totalAmount: Int = 0
    var baseAmountFRT: Int = 0
    var taxAmountFRT: Int = 0
    var totalAmountFRT: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.fareChargeDescription <- map["fareChargeDescription"]
        self.baseAmount <- map["baseAmount"]
        self.taxAmount <- map["taxAmount"]
        self.totalAmount <- map["totalAmount"]
        self.baseAmountFRT <- map["baseAmountFRT"]
        self.taxAmountFRT <- map["taxAmountFRT"]
        self.totalAmountFRT <- map["totalAmountFRT"]
    }
}

class FareChargeDetail: Mappable {
    var fareChargeDetailDescription: String = ""
    var count: Int = 0
    var totalAmount: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.fareChargeDetailDescription <- map["description"]
        self.count <- map["count"]
        self.totalAmount <- map["totalAmount"]
    }
}

