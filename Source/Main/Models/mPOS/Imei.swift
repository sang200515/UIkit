//
//  Imei.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/30/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class Imei: NSObject {
    var ItemCode: String
    var DistNumber: String
    var CreateDate: String
    var WhsCode: String
    
    init(ItemCode: String,DistNumber: String,CreateDate: String,WhsCode: String) {
        self.ItemCode = ItemCode
        self.DistNumber = DistNumber
        self.CreateDate = CreateDate
        self.WhsCode = WhsCode
    }
    
    class func parseObjfromArray(array:[JSON])->[Imei]{
        var list:[Imei] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> Imei{
        var itemCode = data["ItemCode"].string
        var distNumber = data["DistNumber"].string
        var createDate = data["CreateDate"].string
        var whsCode = data["WhsCode"].string
        
        itemCode = itemCode == nil ? "" : itemCode
        distNumber = distNumber == nil ? "" : distNumber
        createDate = createDate == nil ? "" : createDate
        whsCode = whsCode == nil ? "" : whsCode
        
        return Imei(ItemCode: itemCode!, DistNumber: distNumber!, CreateDate: createDate!, WhsCode: whsCode!)
    }
}

