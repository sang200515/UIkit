//
//  VietjetDeparture.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 22/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class VietjetDeparture: Mappable {
    var departures: [Departure] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.departures <- map["departures"]
    }
}

class Departure: Mappable {
    var unicode: String = ""
    var arrivals: [Departure] = []
    var code: String = ""
    var name: String = ""
    var type: String = ""
    var identifier: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.unicode <- map["unicode"]
        self.arrivals <- map["arrivals"]
        self.code <- map["code"]
        self.name <- map["name"]
        self.type <- map["type"]
        self.identifier <- map["identifier"]
    }
}
