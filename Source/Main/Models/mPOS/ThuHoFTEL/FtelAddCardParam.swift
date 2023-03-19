//
//  FtelAddCardParam.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 14/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class FtelAddCardParam: Mappable {
    var orderStatus: Int = 0
    var orderStatusDisplay: String = ""
    var billNo: String = ""
    var customerId: String = ""
    var customerName: String = ""
    var customerPhoneNumber: String = ""
    var warehouseCode: String = ""
    var regionCode: String = ""
    var creationBy: String = ""
    var creationTime: String = ""
    var referenceSystem: String = ""
    var referenceValue: String = ""
    var orderTransactionDtos: [FtelOrderTransactionDto] = []
    var payments: [FtelPayment] = []
    var id: String = ""
    var ip: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.orderStatus <- map["orderStatus"]
        self.orderStatusDisplay <- map["orderStatusDisplay"]
        self.billNo <- map["billNo"]
        self.customerId <- map["customerId"]
        self.customerName <- map["customerName"]
        self.customerPhoneNumber <- map["customerPhoneNumber"]
        self.warehouseCode <- map["warehouseCode"]
        self.regionCode <- map["regionCode"]
        self.creationBy <- map["creationBy"]
        self.creationTime <- map["creationTime"]
        self.referenceSystem <- map["referenceSystem"]
        self.referenceValue <- map["referenceValue"]
        self.orderTransactionDtos <- map["orderTransactionDtos"]
        self.payments <- map["payments"]
        self.id <- map["id"]
        self.ip <- map["ip"]
    }
}
