//
//  RequestPaymentBank.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 6/11/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class RequestPaymentBank: NSObject {
    var value:Int
    var label:String
    
    init(value:Int, label:String){
        self.value = value
        self.label = label
    }
    class func parseObjfromArray(array:[JSON])->[RequestPaymentBank]{
        var list:[RequestPaymentBank] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> RequestPaymentBank{
        
        var value = data["value"].int
        var label = data["label"].string
        
        value = value == nil ? 0 : value
        label = label == nil ? "" : label
        
        return RequestPaymentBank(value:value!, label:label!)
    }
}
