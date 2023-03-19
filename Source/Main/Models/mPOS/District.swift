//
//  District.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class District: NSObject {
    var Text: String
    var Value: String
    
    init(Text: String,Value: String) {
        self.Text = Text
        self.Value = Value
    }
    class func parseObjfromArray(array:[JSON])->[District]{
        var list:[District] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> District{
        
        var text = data["Text"].string
        var value = data["Value"].string
        
        text = text == nil ? "" : text
        value = value == nil ? "" : value
        
        return District(Text: text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),Value: value!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
    }
}
