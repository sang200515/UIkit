//
//  PromotionImei.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 3/1/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class PromotionImei: NSObject {
    var ItemCode: String
    var WhsCode: String
    var DistNumber: String
    
    init(ItemCode: String, WhsCode: String,DistNumber: String) {
        self.ItemCode = ItemCode
        self.WhsCode = WhsCode
        self.DistNumber = DistNumber
    }
    class func parseObjfromArray(array:[JSON])->[PromotionImei]{
        var list:[PromotionImei] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> PromotionImei{
        
        var itemCode = data["ItemCode"].string
        var whsCode = data["WhsCode"].string
        var distNumber = data["DistNumber"].string
        
        itemCode = itemCode == nil ? "" : itemCode
        whsCode = whsCode == nil ? "" : whsCode
        distNumber = distNumber == nil ? "" : distNumber
        
        return PromotionImei(ItemCode: itemCode!, WhsCode: whsCode!,DistNumber: distNumber!)
    }
}

