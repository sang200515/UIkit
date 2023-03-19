//
//  CheckInOutResult.swift
//  fptshop
//
//  Created by Sang Trương on 09/06/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper
class CheckInOutResultModel : Mappable {
    var UserKiemTraInOutResult : CheckinOutResult?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        UserKiemTraInOutResult <- map["UserKiemTraInOutResult"]
    }

}
class CheckinOutResult : Mappable {
    var show_CheckIn : Int = 0
    var show_CheckOut : Int = 0

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        show_CheckIn <- map["Show_CheckIn"]
        show_CheckOut <- map["Show_CheckOut"]
    }

}

//-----

class UserCheckInOutResult : Mappable {
    var userCheckInOutResult : UserCheckInOutDetail?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        userCheckInOutResult <- map["UserCheckInOutResult"]
    }

}
class UserCheckInOutDetail : Mappable {
    var msg : String = ""
    var result : Int = 0

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        msg <- map["Msg"]
        result <- map["Result"]
    }

}
