//
//  Attributes.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class Attributes: NSObject {
    var groupName:String
    var name: String
    var value: String
    
    init(groupName:String,name: String, value: String) {
        self.groupName = groupName
        self.name = name
        self.value = value
    }
    
    class func getObjFromDictionary(data:JSON) -> Attributes{
        var groupName = data["groupName"].string
        var name = data["attributeName"].string
        var value = data["specName"].string
        
        groupName = groupName == nil ? "" : groupName
        name = name == nil ? "" : name
        value = value == nil ? "" : value
        
        return Attributes(groupName:groupName!,name: name!, value: value!)
    }
    class func parseObjfromArray(array:[JSON])->[Attributes]{
        var list:[Attributes] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
}

