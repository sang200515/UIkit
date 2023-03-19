//
//  Property.swift
//  mPOS
//
//  Created by MinhDH on 4/18/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class Property: NSObject {
    var Name: String
    var Value: Int
    
    init(Name:String,Value:Int) {
        self.Name = Name
        self.Value = Value
    }
    class func parseObjfromArray(array:[JSON])->[Property]{
        var list:[Property] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> Property{
        
        
        var name = data["Name"].string
        var value = data["Value"].int
        let list = data["List"].string
        name = name == nil ? "" : name
        value = value == nil ? 0 : value
        
        if (list != nil && list == "BONUS_DESC"){
            value = 1
        }else if (list != nil && list == "BONUS_ASC"){
            value = 2
        }
        
        return Property(Name: name!, Value: value!)
    }
}
