//
//  ThaySimItelModel.swift
//  fptshop
//
//  Created by Ngoc Bao on 05/10/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class OtpItelItem: Mappable {
    var ErrorCode: String = ""
    var ErrorMessage: String = ""
    var Otp: String = ""
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.ErrorCode <- map["ErrorCode"]
        self.ErrorMessage <- map["ErrorMessage"]
        self.Otp <- map["Otp"]
    }
}
