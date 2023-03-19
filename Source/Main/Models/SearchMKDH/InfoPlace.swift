//
//  InfoPlace.swift
//  fptshop
//
//  Created by Apple on 8/21/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"TangKe": 10,
//"Hoc_1": null,
//"Hoc_2": null,
//"Hoc_3": null

import UIKit
import SwiftyJSON

class InfoPlace: NSObject {
    
    let TangKe: Int
    let Hoc_1: String
    let Hoc_2: String
    let Hoc_3: String
    
    init(TangKe: Int, Hoc_1: String, Hoc_2: String, Hoc_3: String) {
        self.TangKe = TangKe
        self.Hoc_1 = Hoc_1
        self.Hoc_2 = Hoc_2
        self.Hoc_3 = Hoc_3
    }
    
    class func parseObjfromArray(array:[JSON])->[InfoPlace]{
        var list:[InfoPlace] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> InfoPlace {
        var TangKe = data["TangKe"].int
        var Hoc_1 = data["Hoc_1"].string
        var Hoc_2 = data["Hoc_2"].string
        var Hoc_3 = data["Hoc_3"].string
        
        TangKe = TangKe == nil ? 0 : TangKe
        Hoc_1 = Hoc_1 == nil ? "" : Hoc_1
        Hoc_2 = Hoc_2 == nil ? "" : Hoc_2
        Hoc_3 = Hoc_3 == nil ? "" : Hoc_3
        
        return InfoPlace(TangKe: TangKe!, Hoc_1: Hoc_1!, Hoc_2: Hoc_2!, Hoc_3: Hoc_3!)
    }
}
