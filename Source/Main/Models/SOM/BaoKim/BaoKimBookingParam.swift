//
//  BaoKimBookingParam.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 24/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class BaoKimBookingParam: Mappable {
    var transactionId: String = ""
    var tripCode: String = ""
    var seats: String = ""
    var customerPhone: String = ""
    var customerName: String = ""
    var customerEmail: String = ""
    var pickup: String = ""
    var pickupId: Int = 0
    var transfer: String = ""
    var transferId: Int = 0
    var dropOffInfo: String = ""
    var dropOffPointId: Int = 0
    var dropOffTransferInfo: String = ""
    var arriveTransferId: Int = 0
    var haveEating: Int = 0
    var userAgent: String = ""
    var note: String = ""
    var busId: Int = 0
    var customerIdCard: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.transactionId <- map["TransactionId"]
        self.tripCode <- map["TripCode"]
        self.seats <- map["Seats"]
        self.customerPhone <- map["CustomerPhone"]
        self.customerName <- map["CustomerName"]
        self.customerEmail <- map["CustomerEmail"]
        self.pickup <- map["Pickup"]
        self.pickupId <- map["PickupId"]
        self.transfer <- map["Transfer"]
        self.transferId <- map["TransferId"]
        self.dropOffInfo <- map["DropOffInfo"]
        self.dropOffPointId <- map["DropOffPointId"]
        self.dropOffTransferInfo <- map["DropOffTransferInfo"]
        self.arriveTransferId <- map["ArriveTransferId"]
        self.haveEating <- map["HaveEating"]
        self.userAgent <- map["UserAgent"]
        self.note <- map["Note"]
        self.busId <- map["BusId"]
        self.customerIdCard <- map["CustomerIdCard"]
    }
}
