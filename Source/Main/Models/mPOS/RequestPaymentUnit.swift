//
//  RequestPaymentUnit.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 6/19/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class RequestPaymentUnit: NSObject {
    var value:String
    var label:String
    
    init(value:String, label:String){
        self.value = value
        self.label = label
    }
    class func parseObjfromArray(array:[JSON])->[RequestPaymentUnit]{
        var list:[RequestPaymentUnit] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> RequestPaymentUnit{
        
        var value = data["value"].string
        var label = data["label"].string
        
        value = value == nil ? "" : value
        label = label == nil ? "" : label
        
        return RequestPaymentUnit(value:value!, label:label!)
    }
}

