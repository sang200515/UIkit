//
//  ThuHoSOMOrder.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class ThuHoSOMOrder: Mappable {
    var id: String = ""
    var customerId: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.customerId <- map["customerId"]
    }
}
