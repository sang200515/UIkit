//
//  VietjetPriceQuotationParam.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 26/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class VietjetPriceQuotationParam: Mappable {
    var order: VietjetOrder = VietjetOrder(JSON: [:])!
    var contact: VietjetContact = VietjetContact(JSON: [:])!
    var booking: VietjetBooking = VietjetBooking(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.order <- map["order"]
        self.contact <- map["contact"]
        self.booking <- map["booking"]
    }
}

class VietjetBooking: Mappable {
    var adultCount: Int = 0
    var childCount: Int = 0
    var infantCount: Int = 0
    var departure: VietjetBookingDeparture = VietjetBookingDeparture(JSON: [:])!
    var arrival: VietjetBookingDeparture?
    var passengers: [VietjetPassenger] = []
    var insurancePolicies: [VietjetInsurancePolicy] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.adultCount <- map["adultCount"]
        self.childCount <- map["childCount"]
        self.infantCount <- map["infantCount"]
        self.departure <- map["departure"]
        self.arrival <- map["return"]
        self.passengers <- map["passengers"]
        self.insurancePolicies <- map ["insurancePolicies"]
    }
}

class VietjetBookingDeparture: Mappable {
    var bookingKey: String = ""
    var airlineNumber: String = ""
    var aircraftModel: String = ""
    var cityPair: DepartureCityPair = DepartureCityPair(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.bookingKey <- map["bookingKey"]
        self.airlineNumber <- map["airlineNumber"]
        self.aircraftModel <- map["aircraftModel"]
        self.cityPair <- map["cityPair"]
    }
}

class VietjetPassenger: Mappable {
    var departure: VietjetPassengerDeparture?
    var arrival: VietjetPassengerDeparture?
    var fareApplicability: VietjetFareApplicability = VietjetFareApplicability(JSON: [:])!
    var reservationProfile: VietjetReservationProfile = VietjetReservationProfile(JSON: [:])!
    var infantProfile: VietjetInfantProfile?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.departure <- map["departure"]
        self.arrival <- map["return"]
        self.fareApplicability <- map["fareApplicability"]
        self.reservationProfile <- map["reservationProfile"]
        self.infantProfile <- map["infantProfile"]
    }
}

class VietjetPassengerDeparture: Mappable {
    var seatOption: VietjetSeatOrderOption?
    var ancillaries: [VietjetAncillary] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.seatOption <- map["seatOption"]
        self.ancillaries <- map["ancillaries"]
    }
}

class VietjetAncillary: Mappable {
    var ancillaryDescription: String = ""
    var purchaseKey: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.ancillaryDescription <- map["description"]
        self.purchaseKey <- map["purchaseKey"]
    }
}

class VietjetSeatOrderOption: Mappable {
    var seatName: String = ""
    var selectionKey: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.seatName <- map["seatName"]
        self.selectionKey <- map["selectionKey"]
    }
}

class VietjetFareApplicability: Mappable {
    var adult: Bool = false
    var child: Bool = false

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.adult <- map["adult"]
        self.child <- map["child"]
    }
}

class VietjetInfantProfile: Mappable {
    var lastName: String = ""
    var firstName: String = ""
    var gender: String = ""
    var birthDate: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.lastName <- map["lastName"]
        self.firstName <- map["firstName"]
        self.gender <- map["gender"]
        self.birthDate <- map["birthDate"]
    }
}

class VietjetReservationProfile: Mappable {
    var lastName: String = ""
    var firstName: String = ""
    var title: String = ""
    var gender: String = ""
    var address: String = ""
    var phoneNumber: String = ""
    var email: String = ""
    var birthDate: String = ""
    var idcard: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.lastName <- map["lastName"]
        self.firstName <- map["firstName"]
        self.title <- map["title"]
        self.gender <- map["gender"]
        self.address <- map["address"]
        self.phoneNumber <- map["phoneNumber"]
        self.email <- map["email"]
        self.birthDate <- map["birthDate"]
        self.idcard <- map["idcard"]
    }
}

class VietjetContact: Mappable {
    var phoneNumber: String = ""
    var fullName: String = ""
    var email: String = ""
    var address: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.phoneNumber <- map["phoneNumber"]
        self.fullName <- map["fullName"]
        self.email <- map["email"]
        self.address <- map["address"]
    }
}

class VietjetOrder: Mappable {
    var shopcode: String = ""
    var usercode: String = ""
    var deviceID: Int = 2
    var totalAmount: Int = 0
    var totalAmountFRT: Int = 0
    var xmlItemProducts: String = ""
    var xmlPromotions: String = ""
    var xmlPayments: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.shopcode <- map["shopcode"]
        self.usercode <- map["usercode"]
        self.deviceID <- map["deviceID"]
        self.totalAmount <- map["totalAmount"]
        self.totalAmountFRT <- map["totalAmountFRT"]
        self.xmlItemProducts <- map["xmlItemProducts"]
        self.xmlPromotions <- map["xmlPromotions"]
        self.xmlPayments <- map["xmlPayments"]
    }
}

class VietjetInsurancePolicy: Mappable {
    var name: String = ""
    var purchaseKey: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.name <- map["name"]
        self.purchaseKey <- map["purchaseKey"]
    }
}
