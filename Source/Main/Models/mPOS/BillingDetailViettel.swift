//
//  BillingDetailViettel.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 1/23/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class BillingDetailViettel: NSObject {
    
    var service_code : String
    var expire: String
    var serial: String
    var pincode: String
    var amount: String
    
    init(service_code : String, expire: String, serial: String, pincode: String, amount: String){
        self.service_code = service_code
        self.expire = expire
        self.serial = serial
        self.pincode = pincode
        self.amount = amount
    }
    class func parseObjfromArray(array:[JSON])->[BillingDetailViettel]{
        var list:[BillingDetailViettel] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> BillingDetailViettel{
        var service_code = data["service_code"].string
        var expire = data["expire"].string
        var serial = data["serial"].string
        var pincode = data["pincode"].string
        var amount = data["amount"].string
        
        service_code = service_code == nil ? "" : service_code
        expire = expire == nil ? "" : expire
        serial = serial == nil ? "" : serial
        pincode = pincode == nil ? "" : pincode
        amount = amount == nil ? "" : amount
        
        return BillingDetailViettel(service_code : service_code!, expire: expire!, serial: serial!, pincode: pincode!, amount: amount!)
        
    }
}
