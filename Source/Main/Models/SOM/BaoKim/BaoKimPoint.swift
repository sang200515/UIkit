//
//  BaoKimPoint.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 23/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class BaoKimPoint: Mappable {
    var data: [BaoKimPointData] = []
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

class BaoKimPointData: Mappable {
    var pointID: Int = 0
    var address: String = ""
    var longitude: String = ""
    var latitude: String = ""
    var url: String = ""
    var introduction: String = ""
    var suggestion: String = ""
    var note: String = ""
    var name: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.pointID <- map["PointId"]
        self.address <- map["Address"]
        self.longitude <- map["Longitude"]
        self.latitude <- map["Latitude"]
        self.url <- map["Url"]
        self.introduction <- map["Introduction"]
        self.suggestion <- map["Suggestion"]
        self.note <- map["Note"]
        self.name <- map["Name"]
    }
}
