//
//  ThuHoSOMOrderStatus.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class ThuHoSOMOrderStatus: Mappable {
    var orderStatus: Int = 0
    var message: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.orderStatus <- map["orderStatus"]
        self.message <- map["message"]
    }
}
