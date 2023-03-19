//
//  RequestPaymentShop.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 6/11/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class RequestPaymentShop: NSObject {
    var value:String
    var label:String
    
    init(value:String, label:String){
        self.value = value
        self.label = label
    }
    class func parseObjfromArray(array:[JSON])->[RequestPaymentShop]{
        var list:[RequestPaymentShop] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> RequestPaymentShop{
        
        var value = data["value"].string
        var label = data["label"].string
        
        value = value == nil ? "" : value
        label = label == nil ? "" : label
        
        return RequestPaymentShop(value:value!, label:label!)
    }
}

class TaxHDThueNha: NSObject {
    var value:Int
    var label:String
    
    init(value:Int, label:String){
        self.value = value
        self.label = label
    }
    class func parseObjfromArray(array:[JSON])->[TaxHDThueNha]{
        var list:[TaxHDThueNha] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> TaxHDThueNha{
        
        let value = data["value"].intValue
        let label = data["label"].stringValue
        
        return TaxHDThueNha(value:value, label:label)
    }
}

