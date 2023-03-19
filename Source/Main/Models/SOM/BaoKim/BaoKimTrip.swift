//
//  BaoKimTrip.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 19/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class BaoKimTrip: Mappable {
    var data: [BaoKimTripData] = []
    var page: Int = 0
    var pageSize: Int = 0
    var total: Int = 0
    var totalPages: Int = 0
    var responseCode: Int = 0
    var responseMessage: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.data <- map["Data"]
        self.page <- map["Page"]
        self.pageSize <- map["PageSize"]
        self.total <- map["Total"]
        self.totalPages <- map["TotalPages"]
        self.responseCode <- map["ResponseCode"]
        self.responseMessage <- map["ResponseMessage"]
    }
}

class BaoKimAreaLocation: Mappable {
    var id: String = ""
    var code: String = ""
    var name: String = ""
    var address: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.id <- map["Id"]
        self.code <- map["Code"]
        self.name <- map["Name"]
        self.address <- map["Address"]
    }
}

class BaoKimTripData: Mappable {
    var idIndex: String = ""
    var route: BaoKimRoute = BaoKimRoute(JSON: [:])!
    var company: BaoKimCompany = BaoKimCompany(JSON: [:])!
    var isIdCard: Int = 0
    var maxTotalSeats: Int = 0
    var status: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.idIndex <- map["IdIndex"]
        self.route <- map["Route"]
        self.company <- map["Company"]
        self.isIdCard <- map["IsIdCard"]
        self.maxTotalSeats <- map["MaxTotalSeats"]
        self.status <- map["Status"]
    }
}

class BaoKimCompany: Mappable {
    var images: [BaoKimImage] = []
    var id: Int = 0
    var name: String = ""
    var ratings: BaoKimRatings = BaoKimRatings(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.images <- map["Images"]
        self.id <- map["Id"]
        self.name <- map["Name"]
        self.ratings <- map["Ratings"]
    }
}

class BaoKimImage: Mappable {
    var files: BaoKimFiles = BaoKimFiles(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.files <- map["Files"]
    }
}

class BaoKimFiles: Mappable {
    var the1000X600: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.the1000X600 <- map["1000x600"]
    }
}

class BaoKimRatings: Mappable {
    var overall: Int = 0
    var comments: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.overall <- map["Overall"]
        self.comments <- map["Comments"]
    }
}

class BaoKimRoute: Mappable {
    var id: Int = 0
    var name: String = ""
    var departureDate: String = ""
    var vehicleQuality: Int = 0
    var from: BaoKimAreaLocation = BaoKimAreaLocation(JSON: [:])!
    var to: BaoKimAreaLocation = BaoKimAreaLocation(JSON: [:])!
    var duration: Int = 0
    var distance: Int = 0
    var fullTrip: Bool = false
    var schedules: [BaoKimSchedule] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.id <- map["Id"]
        self.name <- map["Name"]
        self.departureDate <- map["DepartureDate"]
        self.vehicleQuality <- map["VehicleQuality"]
        self.from <- map["From"]
        self.to <- map["To"]
        self.duration <- map["Duration"]
        self.distance <- map["Distance"]
        self.fullTrip <- map["FullTrip"]
        self.schedules <- map["Schedules"]
    }
}

class BaoKimSchedule: Mappable {
    var tripCode: String = ""
    var hour: Int = 0
    var minute: Int = 0
    var pickupDate: String = ""
    var arrivalTime: String = ""
    var fare: BaoKimFare = BaoKimFare(JSON: [:])!
    var seatType: Int = 0
    var availableSeats: Int = 0
    var totalSeats: Int = 0
    var vehicleType: String = ""
    var refundable: Int = 0
    var unchoosable: Int = 0
    var seatTemplateID: Int = 0
    var config: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.tripCode <- map["TripCode"]
        self.hour <- map["Hour"]
        self.minute <- map["Minute"]
        self.pickupDate <- map["PickupDate"]
        self.arrivalTime <- map["ArrivalTime"]
        self.fare <- map["Fare"]
        self.seatType <- map["SeatType"]
        self.availableSeats <- map["AvailableSeats"]
        self.totalSeats <- map["TotalSeats"]
        self.vehicleType <- map["VehicleType"]
        self.refundable <- map["Refundable"]
        self.unchoosable <- map["Unchoosable"]
        self.seatTemplateID <- map["SeatTemplateID"]
        self.config <- map["Config"]
    }
}

class BaoKimFare: Mappable {
    var original: Int = 0
    var discount: Int = 0
    var max: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.original <- map["Original"]
        self.discount <- map["Discount"]
        self.max <- map["Max"]
    }
}
