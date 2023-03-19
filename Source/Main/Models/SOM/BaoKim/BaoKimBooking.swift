//
//  BaoKimBooking.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 24/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class BaoKimBooking: Mappable {
    var data: [BaoKimBookingData] = []
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

class BaoKimBookingData: Mappable {
    var seats: Int = 0
    var code: String = ""
    var status: String = ""
    var description: String = ""
    var amountBooking: Int = 0
    var from: String = ""
    var to: String = ""
    var customer: BaoKimCustomer = BaoKimCustomer(JSON: [:])!
    var ticket: BaoKimTicket = BaoKimTicket(JSON: [:])!
    var userCharge: String = ""
    var chargeDate: String = ""
    var cancelledDate: String = ""
    var createdUser: String = ""
    var seatCodes: [String] = []
    var createdDate: String = ""
    var expiredTime: String = ""
    var company: String = ""
    var companyID: String = ""
    var tripDate: String = ""
    var arrivalDate: String = ""
    var tripName: String = ""
    var tripCode: String = ""
    var pickupDate: String = ""
    var pickupGuide: String = ""
    var pickupTimeExpectedFull: String = ""
    var pickupInfo: String = ""
    var pickupSurcharge: Int = 0
    var pickupID: Int = 0
    var transferID: Int = 0
    var transferSurcharge: Int = 0
    var arriveTransferSurcharge: Int = 0
    var dropOffSurcharge: Int = 0
    var dropOffPointID: Int = 0
    var dropOffInfo: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.seats <- map["Seats"]
        self.code <- map["Code"]
        self.status <- map["Status"]
        self.description <- map["Description"]
        self.amountBooking <- map["AmountBooking"]
        self.from <- map["From"]
        self.to <- map["To"]
        self.customer <- map["Customer"]
        self.ticket <- map["Ticket"]
        self.userCharge <- map["UserCharge"]
        self.chargeDate <- map["ChargeDate"]
        self.cancelledDate <- map["CancelledDate"]
        self.createdUser <- map["CreatedUser"]
        self.seatCodes <- map["SeatCodes"]
        self.createdDate <- map["CreatedDate"]
        self.expiredTime <- map["ExpiredTime"]
        self.company <- map["Company"]
        self.companyID <- map["CompId"]
        self.tripDate <- map["TripDate"]
        self.arrivalDate <- map["ArrivalDate"]
        self.tripName <- map["TripName"]
        self.tripCode <- map["Tripcode"]
        self.pickupDate <- map["PickupDate"]
        self.pickupGuide <- map["PickupGuide"]
        self.pickupTimeExpectedFull <- map["PickupTimeExpectedFull"]
        self.pickupInfo <- map["PickupInfo"]
        self.pickupSurcharge <- map["PickupSurcharge"]
        self.pickupID <- map["PickupId"]
        self.transferID <- map["TransferId"]
        self.transferSurcharge <- map["TransferSurcharge"]
        self.arriveTransferSurcharge <- map["ArriveTransferSurcharge"]
        self.dropOffSurcharge <- map["DropOffSurcharge"]
        self.dropOffPointID <- map["DropOffPointId"]
        self.dropOffInfo <- map["DropOffInfo"]
    }
}

class BaoKimCustomer: Mappable {
    var name: String = ""
    var phone: String = ""
    var email: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.name <- map["Name"]
        self.phone <- map["Phone"]
        self.email <- map["Email"]
    }
}

class BaoKimTicket: Mappable {
    var code: String = ""
    var status: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.code <- map["Code"]
        self.status <- map["Status"]
    }
}


class BaoKimBookingCode: Mappable {
    var tickets: [Int] = []
    var code: String = ""
    var bookingCode: String = ""
    var transactionID: String = ""
    var transactionIDBk: String = ""
    var transactionTimeBk: String = ""
    var responseCode: Int = 0
    var responseMessage: String = ""
    var ticketCode: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.tickets <- map["Tickets"]
        self.code <- map["Code"]
        self.bookingCode <- map["BookingCode"]
        self.transactionID <- map["TransactionId"]
        self.transactionIDBk <- map["TransactionIdBk"]
        self.transactionTimeBk <- map["TransactionTimeBk"]
        self.responseCode <- map["ResponseCode"]
        self.responseMessage <- map["ResponseMessage"]
        self.ticketCode <- map["TicketCode"]
    }
}
