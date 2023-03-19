//
//  TheNapSOMVoucher.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class TheNapSOMVoucher: Mappable {
    var voucherAmount: Int = 0
    var voucherName: String = ""
    var voucherAccount: String = ""
    var voucherCode: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.voucherAmount <- map["voucherAmount"]
        self.voucherName <- map["voucherName"]
        self.voucherAccount <- map["voucherAccount"]
        self.voucherCode <- map["voucherCode"]
    }
}
