//
//  OTP.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 3/27/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class OTP: NSObject {
    let username: String
    let enabled: Bool
    let secret: String
    let qrCodeUrl: String
    
    init(username: String, enabled: Bool, secret: String, qrCodeUrl: String){
        self.username = username
        self.enabled = enabled
        self.secret = secret
        self.qrCodeUrl = qrCodeUrl
    }
    class func getObjFromDictionary(data:JSON) -> OTP{
        
        var username = data["username"].string
        var enabled = data["enabled"].bool
        var secret = data["secret"].string
        var qrCodeUrl = data["qrCodeUrl"].string
        
        username = username == nil ? "" : username
        enabled = enabled == nil ? false : enabled
        secret = secret == nil ? "" : secret
        qrCodeUrl = qrCodeUrl == nil ? "" : qrCodeUrl
        
        
        return OTP(username: username!, enabled: enabled!, secret: secret!, qrCodeUrl: qrCodeUrl!)
    }
    class func parseObjfromArray(array:[JSON])->[OTP]{
        var list:[OTP] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
}



