//
//  RequestPaymentPeriod.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 6/19/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class RequestPaymentPeriod: NSObject {
    var value:Int
    var label:String
    
    init(value:Int, label:String){
        self.value = value
        self.label = label
    }
    class func parseObjfromArray(array:[JSON])->[RequestPaymentPeriod]{
        var list:[RequestPaymentPeriod] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> RequestPaymentPeriod{
        
        var value = data["value"].int
        var label = data["label"].string
        
        value = value == nil ? 0 : value
        label = label == nil ? "" : label
        
        return RequestPaymentPeriod(value:value!, label:label!)
    }
}

