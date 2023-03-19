//
//  BasicInformation.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class BasicInformation: NSObject {
    var name: String
    var value: String
    
    init(name: String, value: String) {
        self.name = name
        self.value = value
    }
    
    class func getObjFromDictionary(data:JSON) -> BasicInformation{
        
        var name = data["Name"].string
        var value = data["Value"].string
        
        name = name == nil ? "" : name
        value = value == nil ? "" : value
    
        return BasicInformation(name: name!, value: value!)
    }
    class func parseObjfromArray(array:[JSON])->[BasicInformation]{
        var list:[BasicInformation] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
}

