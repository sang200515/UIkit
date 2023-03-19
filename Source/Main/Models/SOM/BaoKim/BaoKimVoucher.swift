//
//  BaoKimVoucher.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 13/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class BaoKimVoucher: Mappable {
    var data: BaoKimVoucherData = BaoKimVoucherData(JSON: [:])!
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

class BaoKimVoucherData: Mappable {
    var info: BaoKimVoucherInfo = BaoKimVoucherInfo(JSON: [:])!
    var responseCode: Int = 0
    var responseMessage: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.info <- map["Info"]
        self.responseCode <- map["ResponseCode"]
        self.responseMessage <- map["ResponseMessage"]
    }
}

class BaoKimVoucherInfo: Mappable {
    var name: String = ""
    var unit: Int = 0
    var type: Int = 0
    var couponValue: Int = 0
    var minNumOfTicket: Int = 0
    var maxNumOfTicket: Int = 0
    var minAffectValue: Int = 0
    var code: String = ""
    var couponCode: String = ""
    var unitDescription: String = ""
    var fareInfo: BaoKimVoucherFareInfo = BaoKimVoucherFareInfo(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.name <- map["Name"]
        self.unit <- map["Unit"]
        self.type <- map["Type"]
        self.couponValue <- map["CouponValue"]
        self.minNumOfTicket <- map["MinNumOfTicket"]
        self.maxNumOfTicket <- map["MaxNumOfTicket"]
        self.minAffectValue <- map["MinAffectValue"]
        self.code <- map["Code"]
        self.couponCode <- map["CouponCode"]
        self.unitDescription <- map["UnitDescription"]
        self.fareInfo <- map["FareInfo"]
    }
}

class BaoKimVoucherFareInfo: Mappable {
    var bookingFare: Int = 0
    var finalFare: Int = 0
    var couponValue: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.bookingFare <- map["BookingFare"]
        self.finalFare <- map["FinalFare"]
        self.couponValue <- map["CouponValue"]
    }
}
