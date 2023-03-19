//
//  DoneEvaluateModel.swift
//  QuickCode
//
//  Created by Sang Trương on 01/11/2022.
//

import Foundation
import ObjectMapper

class DoneEveluateModel : Mappable {
    var status : Int?
    var mess : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        status <- map["Status"]
        mess <- map["Mess"]
    }

}
