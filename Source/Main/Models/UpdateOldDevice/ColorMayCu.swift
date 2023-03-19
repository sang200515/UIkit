//
//  ColorMayCu.swift
//  fptshop
//
//  Created by DiemMy Le on 11/13/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"ID": 7684,
//"Name": "Đen",
//"ColorValue": "#030003"

import UIKit
import SwiftyJSON

class ColorMayCu: NSObject {

    let ID: Int
    let Name: String
    let ColorValue: String
    
    init(ID: Int, Name: String, ColorValue: String) {
        self.ID = ID
        self.Name = Name
        self.ColorValue = ColorValue
    }
    
    class func parseObjfromArray(array:[JSON])->[ColorMayCu]{
        var list:[ColorMayCu] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ColorMayCu {
        var ID = data["ID"].int
        var Name = data["Name"].string
        var ColorValue = data["ColorValue"].string
        
        ID = ID == nil ? 0 : ID
        Name = Name == nil ? "" : Name
        ColorValue = ColorValue == nil ? "" : ColorValue
        
        return ColorMayCu(ID: ID!, Name: Name!, ColorValue: ColorValue!)
    }
}
