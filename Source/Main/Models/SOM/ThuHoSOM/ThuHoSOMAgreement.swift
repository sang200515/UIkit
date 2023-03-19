//
//  ThuHoSOMAgreement.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 16/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class ThuHoSOMAgreements: Mappable {
    var agreements: [ThuHoSOMAgreement] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.agreements <- map["agreements"]
    }
}

class ThuHoSOMAgreement: Mappable {
    var contract: String = ""
    var fullName: String = ""
    var address: String = ""
    var passport: String = ""
    var phone: String = ""
    var debt: String = ""
    var debtMessage: String = ""
    var paidDate: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.contract <- map["contract"]
        self.fullName <- map["fullName"]
        self.address <- map["address"]
        self.passport <- map["passport"]
        self.phone <- map["phone"]
        self.debt <- map["debt"]
        self.debtMessage <- map["debtMessage"]
        self.paidDate <- map["paidDate"]
    }
}
