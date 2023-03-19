//
//  BaoKimProduct.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 14/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class BaoKimProduct: Mappable {
    var itemCode: String = ""
    var itemName: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.itemCode <- map["itemCode"]
        self.itemName <- map["itemName"]
    }
}
