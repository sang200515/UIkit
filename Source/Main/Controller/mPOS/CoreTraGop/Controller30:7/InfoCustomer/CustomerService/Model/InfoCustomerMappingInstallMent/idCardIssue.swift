//
//  idCardIssue.swift
//  fptshop
//
//  Created by Sang Trương on 03/08/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class InsHouseIdCardIssuedBy : Mappable {
    var shinhanCode : String?
    var compCode : String?
    var miraeCode : String?
    var hcCode : String?
    var feCode : String?

    required init?(map: Map) {

    }

     func mapping(map: Map) {

        shinhanCode <- map["shinhanCode"]
        compCode <- map["compCode"]
        miraeCode <- map["miraeCode"]
        hcCode <- map["hcCode"]
        feCode <- map["feCode"]
    }

}
class IdCardIssuedMapping : Mappable {
    var idCardIssuedByCode : String?
    var insHouseIdCardIssuedBy : InsHouseIdCardIssuedBy?
    var idCardIssuedBy : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        idCardIssuedByCode <- map["idCardIssuedByCode"]
        insHouseIdCardIssuedBy <- map["insHouseIdCardIssuedBy"]
        idCardIssuedBy <- map["idCardIssuedBy"]
    }

}
