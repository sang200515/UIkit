//
//  VietjetOrderMessage.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 28/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class VietjetOrderMessage: Mappable {
    var messages: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.messages <- map["messages"]
    }
}
