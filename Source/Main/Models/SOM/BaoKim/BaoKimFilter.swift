//
//  BaoKimFilter.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 14/01/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class BaoKimFilter: Mappable {
    var data: BaoKimFilterData = BaoKimFilterData(JSON: [:])!
    var responseCode: Int = 0
    var responseMessage: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.data <- map["Data"]
        self.responseCode <- map["ResponseCode"]
        self.responseMessage <- map["ResponseMessage"]
    }
}

class BaoKimFilterData: Mappable {
    var total: Int = 0
    var rating: BaoKimFilterRating = BaoKimFilterRating(JSON: [:])!
    var templateSeats: [BaoKimFilterTemplateSeat] = []
    var totalAvailableTrips: Int = 0
    var isPromotion: Int = 0
    var vehicleTypes: [BaoKimFilterVehicleType] = []
    var companies: BaoKimFilterCompanies = BaoKimFilterCompanies(JSON: [:])!
    var onlineTicket: Int = 0
    var pickupPoints: [BaoKimFilterPoint] = []
    var dropoffPoints: [BaoKimFilterPoint] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.total <- map["Total"]
        self.rating <- map["Rating"]
        self.templateSeats <- map["TemplateSeats"]
        self.totalAvailableTrips <- map["TotalAvailableTrips"]
        self.isPromotion <- map["IsPromotion"]
        self.vehicleTypes <- map["VehicleTypes"]
        self.companies <- map["Companies"]
        self.onlineTicket <- map["OnlineTicket"]
        self.pickupPoints <- map["PickupPoints"]
        self.dropoffPoints <- map["DropoffPoints"]
    }
}

class BaoKimFilterCompanies: Mappable {
    var total: Int = 0
    var data: [BaoKimFilterCompaniesData] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.total <- map["Total"]
        self.data <- map["Data"]
    }
}

class BaoKimFilterCompaniesData: Mappable {
    var id: Int = 0
    var name: String = ""
    var displayName: String = ""
    var tripCount: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.id <- map["Id"]
        self.name <- map["Name"]
        self.displayName <- map["DisplayName"]
        self.tripCount <- map["TripCount"]
    }
}

class BaoKimFilterPoint: Mappable {
    var district: String = ""
    var tripCount: Int = 0
    var points: [BaoKimFilterPointElement] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.district <- map["District"]
        self.tripCount <- map["TripCount"]
        self.points <- map["Points"]
    }
}

class BaoKimFilterPointElement: Mappable {
    var name: String = ""
    var tripCount: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.name <- map["Name"]
        self.tripCount <- map["TripCount"]
    }
}

class BaoKimFilterRating: Mappable {
    var detail: [BaoKimFilterVehicleType] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.detail <- map["Detail"]
    }
}

class BaoKimFilterVehicleType: Mappable {
    var value: String = ""
    var count: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.value <- map["Value"]
        self.count <- map["Count"]
    }
}

class BaoKimFilterTemplateSeat: Mappable {
    var typeNumber: Int = 0
    var type: String = ""
    var number: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.typeNumber <- map["TypeNumber"]
        self.type <- map["Type"]
        self.number <- map["Number"]
    }
}
