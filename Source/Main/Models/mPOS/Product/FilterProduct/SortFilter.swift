//
//  SortFilter.swift
//  fptshop
//
//  Created by Ngo Dang tan on 8/24/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class SortFilter: NSObject {
    var name:String
    var param_key:String
    var valueFilters: [ValueFilter]
    
    init(name: String,param_key:String, valueFilters: [ValueFilter]) {
        self.name = name
        self.param_key = param_key
        self.valueFilters = valueFilters
    }
    
    class func getObjFromDictionary(data:JSON) -> SortFilter{
        
        var name = data["name"].string
        var param_key = data["param_key"].string
        let valueFiltersDic = data["data"].array
        let valueFilters = ValueFilter.parseObjfromArray(array: valueFiltersDic ?? [])
        name = name == nil ? "" : name
        param_key = param_key == nil ? "" : param_key
        
        return SortFilter(name: name!,param_key:param_key!, valueFilters: valueFilters)
    }
    class func parseObjfromArray(array:[JSON])->[SortFilter]{
        var list:[SortFilter] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
}
