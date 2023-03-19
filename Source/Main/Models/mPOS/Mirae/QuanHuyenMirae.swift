//
//  QuanHuyenMirae.swift
//  fptshop
//
//  Created by tan on 5/28/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class QuanHuyenMirae: NSObject {
    var Value:String
    var Text:String
    
    init(Value:String
        , Text:String) {
        self.Value = Value
        self.Text = Text
    }
    
    
    class func parseObjfromArray(array:[JSON])->[QuanHuyenMirae]{
        var list:[QuanHuyenMirae] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> QuanHuyenMirae{
        
        var Value = data["Value"].string
        var Text = data["Text"].string
        
        
        Value = Value == nil ? "" : Value
        Text = Text == nil ? "" : Text
        
        return QuanHuyenMirae(Value:Value!
            , Text:Text!
        )
    }
}
