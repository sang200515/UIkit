//
//  FtelCard.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 14/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class FtelCard: Mappable {
    var totalCount: Int = 0
    var items: [FtelCardItem] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.totalCount <- map["totalCount"]
        self.items <- map["items"]
    }
}

// MARK: - Item
class FtelCardItem: Mappable {
    var code: String = ""
    var name: String = ""
    var isCardOnline: String = ""
    var id: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.code <- map["code"]
        self.name <- map["name"]
        self.isCardOnline <- map["isCardOnline"]
        self.id <- map["id"]
    }
}
