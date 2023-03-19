//
//  ItemKhaoSatMienTrung.swift
//  fptshop
//
//  Created by Ngo Dang tan on 10/26/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//stt": "1",
//"typeControl": "inputtext",
//"value": "5",
//"description": "Nhập số tiền",
//"parentID": "2",
//"group": "1",
//"children": []

import UIKit
import SwiftyJSON

class ItemKhaoSatMienTrung: NSObject {

    var stt:String
    var typeControl:String
    var value:String
    var descriptionStr:String
    var parentID:String
    var group:String
    var children:[ItemKhaoSatMienTrung]
    var isSelected = false
    
    init(stt:String, typeControl:String, value:String, descriptionStr:String, parentID:String, group:String, children:[ItemKhaoSatMienTrung]) {
        self.stt = stt
        self.typeControl = typeControl
        self.value = value
        self.descriptionStr = descriptionStr
        self.parentID = parentID
        self.group = group
        self.children = children
    }
    
    class func parseObjfromArray(array:[JSON])->[ItemKhaoSatMienTrung]{
        var list:[ItemKhaoSatMienTrung] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ItemKhaoSatMienTrung {
        let stt = data["stt"].stringValue
        let typeControl = data["typeControl"].stringValue
        let value = data["value"].stringValue
        let descriptionStr = data["description"].stringValue
        let parentID = data["parentID"].stringValue
        let group = data["group"].stringValue
        let children = data["children"].arrayValue
        
        let childrenArr = ItemKhaoSatMienTrung.parseObjfromArray(array: children)

        return ItemKhaoSatMienTrung(stt: stt, typeControl: typeControl, value: value, descriptionStr: descriptionStr, parentID: parentID, group: group, children: childrenArr)
    }
}


class ItemKhaoSatResult {
    var itemValue: String
    var itemDescription: String
    
    init(itemValue: String, itemDescription: String) {
        self.itemValue = itemValue
        self.itemDescription = itemDescription
    }
}
