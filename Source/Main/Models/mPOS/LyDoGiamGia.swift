//
//  LyDoGiamGia.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 2/28/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class LyDoGiamGia: NSObject {
    
    var Value: Int
    var Name: String
    
    init(Value: Int, Name: String){
        self.Value = Value
        self.Name = Name
    }
    class func parseObjfromArray(array:[JSON])->[LyDoGiamGia]{
        var list:[LyDoGiamGia] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> LyDoGiamGia{
        
        var value = data["Value"].int
        var name = data["Name"].string
        
        value = value == nil ? 0 : value
        name = name == nil ? "" : name
        
        return LyDoGiamGia(Value: value!, Name: name!)
    }
    
}

