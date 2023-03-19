//
//  BaoKimHistory.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 30/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class BaoKimHistory: Mappable {
    var bookingID: String = ""
    var transactioncode: String = ""
    var requestidPayment: String = ""
    var sompos: Int = 0
    var customerPhone: String = ""
    var customerName: String = ""
    var customerEmail: String = ""
    var doctotal: Int = 0
    var couponCode: String = ""
    var discount: Int = 0
    var preDoctotal: Int = 0
    var bookingDate: String = ""
    var status: String = ""
    var statusName: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.bookingID <- map["bookingId"]
        self.transactioncode <- map["transactioncode"]
        self.requestidPayment <- map["requestid_payment"]
        self.sompos <- map["sompos"]
        self.customerPhone <- map["customer_phone"]
        self.customerName <- map["customer_name"]
        self.customerEmail <- map["customer_email"]
        self.doctotal <- map["doctotal"]
        self.couponCode <- map["coupon_code"]
        self.discount <- map["discount"]
        self.preDoctotal <- map["pre_doctotal"]
        self.bookingDate <- map["booking_date"]
        self.status <- map["status"]
        self.statusName <- map["status_name"]
    }
}
