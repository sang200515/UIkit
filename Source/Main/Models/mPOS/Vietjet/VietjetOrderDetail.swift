//
//  VietjetOrderDetail.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 29/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class VietjetHistoryOrder: Mappable {
    var order: VietjetOrderDetail = VietjetOrderDetail(JSON: [:])!
    var booking: VietjetHistoryBooking = VietjetHistoryBooking(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.order <- map["order"]
        self.booking <- map["booking"]
    }
}

class VietjetOrderDetail: Mappable {
    var contact: VietjetOrderContact = VietjetOrderContact(JSON: [:])!
    var products: [VietjetOrderProduct] = []
    var promotions: [VietjetPromotion] = []
    var payment: VietjetOrderPayment = VietjetOrderPayment(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.contact <- map["contact"]
        self.products <- map["products"]
        self.promotions <- map["promotions"]
        self.payment <- map["payment"]
    }
}

class VietjetOrderContact: Mappable {
    var locator: String = ""
    var contactName: String = ""
    var contactPhone: String = ""
    var contactEmail: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.locator <- map["locator"]
        self.contactName <- map["contactName"]
        self.contactPhone <- map["contactPhone"]
        self.contactEmail <- map["contactEmail"]
    }
}

class VietjetOrderPayment: Mappable {
    var totalAmount: Int = 0
    var discount: Int = 0
    var totalPay: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.totalAmount <- map["TotalAmount"]
        self.discount <- map["Discount"]
        self.totalPay <- map["TotalPay"]
    }
}

class VietjetOrderProduct: Mappable {
    var itemCode: String = ""
    var dscription: String = ""
    var quantity: Int = 0
    var price: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.itemCode <- map["ItemCode"]
        self.dscription <- map["Dscription"]
        self.quantity <- map["Quantity"]
        self.price <- map["Price"]
    }
}

class VietjetHistoryBooking: Mappable {
    var locator: String = ""
    var departure: VietjetHistoryDeparture = VietjetHistoryDeparture(JSON: [:])!
    var contactInformation: VietjetHistoryContactInformation = VietjetHistoryContactInformation(JSON: [:])!
    var arrival: VietjetHistoryDeparture?
    var passengers: [VietjetHistoryPassenger] = []
    var key: String = ""
    var number: String = ""
    var insurances: [VietjetHistoryInsurance] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.locator <- map["locator"]
        self.departure <- map["departure"]
        self.contactInformation <- map["contactInformation"]
        self.arrival <- map["return"]
        self.passengers <- map["passengers"]
        self.key <- map["key"]
        self.number <- map["number"]
        self.insurances <- map["insurancePolicies"]
    }
}

class VietjetHistoryInsurance: Mappable {
    var name: String = ""
    var key: String = ""
    var purchaseKey: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.name <- map["name"]
        self.key <- map["key"]
        self.purchaseKey <- map["purchaseKey"]
    }
}

class VietjetHistoryContactInformation: Mappable {
    var phoneNumber: String = ""
    var name: String = ""
    var email: String = ""
    var address: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.phoneNumber <- map["phoneNumber"]
        self.name <- map["name"]
        self.email <- map["email"]
        self.address <- map["address"]
    }
}

class VietjetHistoryDeparture: Mappable {
    var departureTime: String = ""
    var cityPair: VietjetHistoryCityPair = VietjetHistoryCityPair(JSON: [:])!
    var aircraftModel: String = ""
    var airlineNumber: String = ""
    var fareClass: String = ""
    var departureDate: String = ""
    var key: String = ""
    var totalTime: String = ""
    var bookingKey: String = ""
    var href: String = ""
    var segment: VietjetSegment = VietjetSegment(JSON: [:])!
    var journeyDetail: [VietjetJourneyDetail] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.departureTime <- map["departureTime"]
        self.cityPair <- map["cityPair"]
        self.aircraftModel <- map["aircraftModel"]
        self.airlineNumber <- map["airlineNumber"]
        self.fareClass <- map["fareClass"]
        self.departureDate <- map["departureDate"]
        self.key <- map["key"]
        self.totalTime <- map["totalTime"]
        self.bookingKey <- map["bookingKey"]
        self.href <- map["href"]
        self.segment <- map["segment"]
        self.journeyDetail <- map["passengerJourneyDetails"]
    }
}

class VietjetJourneyDetail: Mappable {
    var href: String = ""
    var key: String = ""
    var passenger: VietjetPassengerJourney = VietjetPassengerJourney(JSON: [:])!
    var timestamp: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.href <- map["href"]
        self.key <- map["key"]
        self.passenger <- map["passenger"]
        self.timestamp <- map["timestamp"]
    }
}

class VietjetPassengerJourney: Mappable {
    var href: String = ""
    var key: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.href <- map["href"]
        self.key <- map["key"]
    }
}

class VietjetSegment: Mappable {
    var key: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.key <- map["key"]
    }
}

class VietjetHistoryCityPair: Mappable {
    var arrival: VietjetHistoryArrival = VietjetHistoryArrival(JSON: [:])!
    var identifier: String = ""
    var departure: VietjetHistoryArrival = VietjetHistoryArrival(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.arrival <- map["arrival"]
        self.identifier <- map["identifier"]
        self.departure <- map["departure"]
    }
}

class VietjetHistoryArrival: Mappable {
    var code: String = ""
    var schedueledTime: String = ""
    var name: String = ""
    var hours: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.code <- map["code"]
        self.schedueledTime <- map["schedueledTime"]
        self.name <- map["name"]
        self.hours <- map["hours"]
    }
}

class VietjetHistoryPassenger: Mappable {
    var departure: VietjetHistoryPassengerDeparture = VietjetHistoryPassengerDeparture(JSON: [:])!
    var gender: String = ""
    var birthDate: String = ""
    var title: String = ""
    var firstName: String = ""
    var key: String = ""
    var lastName: String = ""
    var arrival: VietjetHistoryPassengerDeparture = VietjetHistoryPassengerDeparture(JSON: [:])!
    var fareApplicability: String = ""
    var href: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.departure <- map["departure"]
        self.gender <- map["gender"]
        self.birthDate <- map["birthDate"]
        self.title <- map["title"]
        self.firstName <- map["firstName"]
        self.key <- map["key"]
        self.lastName <- map["lastName"]
        self.arrival <- map["return"]
        self.fareApplicability <- map["fareApplicability"]
        self.href <- map["href"]
    }
}

class VietjetHistoryPassengerDeparture: Mappable {
    var seatSelection: VietjetHistorySeatSelection?
    var ancillaryPurchases: [VietjetHistoryAncillaryPurchase]?
    var timestamp: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.seatSelection <- map["seatSelection"]
        self.ancillaryPurchases <- map["ancillaryPurchases"]
        self.timestamp <- map["journeyTimestamp"]
    }
}

class VietjetHistoryAncillaryPurchase: Mappable {
    var purchaseKey: String = ""
    var name: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.purchaseKey <- map["purchaseKey"]
        self.name <- map["name"]
    }
}

class VietjetHistorySeatSelection: Mappable {
    var seatIdentifier: String = ""
    var key: String = ""
    var rowIdentifier: String = ""
    var timestamp: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.seatIdentifier <- map["seatIdentifier"]
        self.key <- map["key"]
        self.rowIdentifier <- map["rowIdentifier"]
        self.timestamp <- map["timestamp"]
    }
}
