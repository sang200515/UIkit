//
//  ItemSSD.swift
//  mPOS
//
//  Created by MinhDH on 6/29/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class ItemSSD: NSObject {
    var ItemCode:String
    var ItemName:String
    var U_PriceNew:Float
    
    init(ItemCode:String,ItemName:String,U_PriceNew:Float){
        self.ItemCode = ItemCode
        self.ItemName = ItemName
        self.U_PriceNew = U_PriceNew
    }
    class func parseObjfromArray(array:[JSON])->[ItemSSD]{
        var list:[ItemSSD] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ItemSSD{
        var itemCode = data["ItemCode"].string
        var itemName = data["ItemName"].string
        var u_PriceNew = data["U_PriceNew"].float
        
        itemCode = itemCode == nil ? "" : itemCode
        itemName = itemName == nil ? "" : itemName
        u_PriceNew = u_PriceNew == nil ? 0 : u_PriceNew
        
        return ItemSSD(ItemCode: itemCode!, ItemName: itemName!, U_PriceNew: u_PriceNew!)
    }
}
