//
//  ShinHanOTPModel.swift
//  QuickCode
//
//  Created by Sang Trương on 15/09/2022.
//

import Foundation
import ObjectMapper

class ShinHanOTPModel : Mappable {
    var status : Int?
    var message : String?

   required init?(map: Map) {

    }

     func mapping(map: Map) {

        status <- map["status"]
        message <- map["message"]
    }

}
