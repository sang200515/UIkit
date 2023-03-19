//
//  PaymentType.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 3/4/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class PaymentType: NSObject {
    
    var Value: Int
    var Text: String
    var IsCardOnline: Int
    
    init(Value: Int, Text: String, IsCardOnline: Int) {
        self.Value = Value
        self.Text = Text
        self.IsCardOnline = IsCardOnline
    }
    class func parseObjfromArray(array:[JSON])->[PaymentType]{
        var list:[PaymentType] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> PaymentType{
        
        var value = data["Value"].int
        var text = data["Text"].string
        var isCardOnline = data["IsCardOnline"].int
        
        value = value == nil ? 0 : value
        text = text == nil ? "" : text
        isCardOnline = isCardOnline == nil ? 0 : isCardOnline
        
        return PaymentType(Value: value!, Text: text!, IsCardOnline: isCardOnline!)
    }
}

