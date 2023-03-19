//
//  SearchVendor.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class SearchVendor: NSObject {
    
    var Code: String
    var Name: String
    init(Code: String, Name: String){
        self.Code = Code
        self.Name = Name
    }
    class func parseObjfromArray(array:[JSON])->[SearchVendor]{
        var list:[SearchVendor] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> SearchVendor{
        
        var code = data["Code"].string
        var name = data["Name"].string
        
        code = code == nil ? "" : code
        name = name == nil ? "" : name
        
        return SearchVendor(Code: code!, Name: name!)
    }
}

