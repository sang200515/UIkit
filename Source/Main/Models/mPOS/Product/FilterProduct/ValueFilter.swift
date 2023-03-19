//
//  ValueFilter.swift
//  fptshop
//
//  Created by Ngo Dang tan on 8/24/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ValueFilter: NSObject {
    var total_inventory:Int
    var total:Int
    var value:String
    var label:String
    var isSelectFilter: Bool
    
    init(value:String,label:String,isSelectFilter:Bool = false,total:Int = 0,total_inventory:Int = 0){
        self.value = value
        self.label = label
        self.isSelectFilter = isSelectFilter
        self.total = total
        self.total_inventory = total_inventory
    }
    class func getObjFromDictionary(data:JSON) -> ValueFilter{
         
         var value = data["value"].string
         var label = data["label"].string
        var total = data["total"].int
        var total_inventory = data["total_inventory"].int
         
         value = value == nil ? "" : value
         label = label == nil ? "" : label
        total = total == nil ? 0 : total
        total_inventory = total_inventory == nil ? 0 : total_inventory
         
        return ValueFilter(value:value!, label:label!,total:total!,total_inventory:total_inventory!)
     }
     class func parseObjfromArray(array:[JSON])->[ValueFilter]{
         var list:[ValueFilter] = []
         for item in array {
             list.append(self.getObjFromDictionary(data: item))
         }
         return list
     }
    
}
