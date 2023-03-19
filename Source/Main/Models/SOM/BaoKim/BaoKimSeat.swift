//
//  BaoKimSeat.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 22/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class BaoKimSeat: Mappable {
    var data: BaoKimSeatData = BaoKimSeatData(JSON: [:])!
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

class BaoKimSeatData: Mappable {
    var name: String = ""
    var fare: Int = 0
    var totalSeats: Int = 0
    var totalAvailableSeats: Int = 0
    var numCoaches: Int = 0
    var companyId: Int = 0
    var pickupPoints: [BaoKimDropOffPointsatArrive] = []
    var transferPoints: [BaoKimDropOffPointsatArrive] = []
    var dropOffPointsatArrive: [BaoKimDropOffPointsatArrive] = []
    var coachSeatTemplate: [BaoKimCoachSeatTemplate] = []
    var serviceFee: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.name <- map["Name"]
        self.fare <- map["Fare"]
        self.totalSeats <- map["TotalSeats"]
        self.totalAvailableSeats <- map["TotalAvailableSeats"]
        self.numCoaches <- map["NumCoaches"]
        self.companyId <- map["CompanyId"]
        self.pickupPoints <- map["PickupPoints"]
        self.transferPoints <- map["TransferPoints"]
        self.dropOffPointsatArrive <- map["DropOffPointsatArrive"]
        self.coachSeatTemplate <- map["CoachSeatTemplate"]
        self.serviceFee <- map["ServiceFee"]
    }
}

class BaoKimCoachSeatTemplate: Mappable {
    var coachNum: Int = 0
    var coachName: String = ""
    var numRows: Int = 0
    var numCols: Int = 0
    var seats: [BaoKimSeatTemplate] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.coachNum <- map["CoachNum"]
        self.coachName <- map["CoachName"]
        self.numRows <- map["NumRows"]
        self.numCols <- map["NumCols"]
        self.seats <- map["Seats"]
    }
}

class BaoKimSeatTemplate: Mappable {
    var seatType: Int = 0
    var seatCode: String = ""
    var fare: Int = 0
    var rowNum: Int = 0
    var colNum: Int = 0
    var rowSpan: Int = 0
    var colSpan: Int = 0
    var seatGroup: String = ""
    var isAvailable: Bool = false
    var coachNum: Int = 1

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.seatType <- map["SeatType"]
        self.seatCode <- map["SeatCode"]
        self.fare <- map["Fare"]
        self.rowNum <- map["RowNum"]
        self.colNum <- map["ColNum"]
        self.rowSpan <- map["RowSpan"]
        self.colSpan <- map["ColSpan"]
        self.seatGroup <- map["SeatGroup"]
        self.isAvailable <- map["IsAvailable"]
    }
}

class BaoKimDropOffPointsatArrive: Mappable {
    var id: Int = 0
    var pointId: Int = 0
    var name: String = ""
    var address: String = ""
    var time: Int = 0
    var realTime: String = ""
    var unfixedPoint: Int = 0
    var surcharge: Int = 0
    var surchargeType: Int = 0
    var minCustomer: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.id <- map["Id"]
        self.pointId <- map["PointId"]
        self.name <- map["Name"]
        self.address <- map["Address"]
        self.time <- map["Time"]
        self.realTime <- map["RealTime"]
        self.unfixedPoint <- map["UnfixedPoint"]
        self.surcharge <- map["Surcharge"]
        self.surchargeType <- map["SurchargeType"]
        self.minCustomer <- map["MinCustomer"]
    }
}
