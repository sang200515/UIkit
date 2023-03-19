//
//  BaoKimTransaction.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 10/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class BaoKimTransaction: Mappable {
    var status: String = ""
    var message: String = ""
    var transactionCode: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.status <- map["p_status"]
        self.message <- map["p_message"]
        self.transactionCode <- map["transactioncode"]
    }
}
