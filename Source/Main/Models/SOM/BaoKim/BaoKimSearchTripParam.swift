//
//  BaoKimSearchTripParam.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 18/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class BaoKimSearchTripParam: Mappable {
    var from: Int = 0
    var to: Int = 0
    var date: String = ""
    var isPromotion: Int = 0
    var fareMin: Int = 0
    var fareMax: Int = 10000000
    var availableSeatMin: Int = 0
    var availableSeatMax: Int = 100
    var ratingMin: Int = 0
    var ratingMax: Int = 5
    var timeMin: String = "00:00"
    var timeMax: String = "23:59"
    var limousine: Int = 0
    var seatType: String = "1,2,7"
    var page: Int = 1
    var pagesize: Int = 20
    var sort: String = "time:asc"
    var companies: String = ""
    var pickupPoints: [BaoKimPointParam] = []
    var dropoffPoints: [BaoKimPointParam] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.from <- map["From"]
        self.to <- map["To"]
        self.date <- map["Date"]
        self.isPromotion <- map["IsPromotion"]
        self.fareMin <- map["FareMin"]
        self.fareMax <- map["FareMax"]
        self.availableSeatMin <- map["AvailableSeatMin"]
        self.availableSeatMax <- map["AvailableSeatMax"]
        self.ratingMin <- map["RatingMin"]
        self.ratingMax <- map["RatingMax"]
        self.timeMin <- map["TimeMin"]
        self.timeMax <- map["TimeMax"]
        self.limousine <- map["Limousine"]
        self.seatType <- map["SeatType"]
        self.page <- map["Page"]
        self.pagesize <- map["Pagesize"]
        self.sort <- map["Sort"]
        self.companies <- map["Companies"]
        self.pickupPoints <- map["PickupPoints"]
        self.dropoffPoints <- map["DropoffPoints"]
    }
}

class BaoKimPointParam: Mappable {
    var district: String = ""
    var name: [String] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.district <- map["District"]
        self.name <- map["Name"]
    }
}
