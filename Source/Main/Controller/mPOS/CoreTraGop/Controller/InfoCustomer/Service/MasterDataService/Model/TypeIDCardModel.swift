//
//  TypeIDCardModel.swift
//  fptshop
//
//  Created by Sang Trương on 27/07/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import ObjectMapper
class TypeIDCardModel : Mappable {
    var idCardType : Int?
    var idCardTypeName : String?

   required init?(map: Map) {

    }

     func mapping(map: Map) {

        idCardType <- map["idCardType"]
        idCardTypeName <- map["idCardTypeName"]
    }

}
