//
//  ShopInventory.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ShopInventory: NSObject {
    
    var itemcode: String
    var ShopCode: String
    var Shopname: String
    var SL: Int
    var Mausac: String
    
    
    init(itemcode: String,ShopCode: String,Shopname: String,SL: Int,Mausac: String){
        self.itemcode = itemcode
        self.ShopCode = ShopCode
        self.Shopname = Shopname
        self.SL = SL
        self.Mausac = Mausac
    }
    class func parseObjfromArray(array:[JSON])->[ShopInventory]{
        var list:[ShopInventory] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ShopInventory{
        
        var itemcode = data["itemcode"].string
        var shopCode = data["ShopCode"].string
        var shopname = data["Shopname"].string
        var sl = data["SL"].int
        var mausac = data["Mausac"].string
        
        itemcode = itemcode == nil ? "" : itemcode
        shopCode = shopCode == nil ? "" : shopCode
        shopname = shopname == nil ? "" : shopname
        sl = sl == nil ? 0 : sl
        mausac = mausac == nil ? "" : mausac
        
        return ShopInventory(itemcode: itemcode!,ShopCode: shopCode!,Shopname: shopname!,SL: sl!,Mausac:mausac!)
    }
    
}

