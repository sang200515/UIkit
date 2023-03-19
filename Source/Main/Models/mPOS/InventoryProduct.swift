//
//  InventoryProduct.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 2/19/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class InventoryProduct: NSObject {
    
    var ItemCode: String
    var whsCode: String
    var SL: Int
    var ShopCode: String
    var ShopName: String
    
    init(ItemCode: String, whsCode: String, SL: Int, ShopCode: String, ShopName: String){
        self.ItemCode = ItemCode
        self.whsCode = whsCode
        self.SL = SL
        self.ShopCode = ShopCode
        self.ShopName = ShopName
    }
    class func parseObjfromArray(array:[JSON])->[InventoryProduct]{
        var list:[InventoryProduct] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> InventoryProduct{
        
        var itemCode = data["ItemCode"].string
        var whsCode = data["whsCode"].string
        var sl = data["SL"].int
        var shopCode = data["ShopCode"].string
        var shopName = data["ShopNam"].string
        
        itemCode = itemCode == nil ? "" : itemCode
        whsCode = whsCode == nil ? "" : whsCode
        sl = sl == nil ? 0 : sl
        shopCode = shopCode == nil ? "" : shopCode
        shopName = shopName == nil ? "" : shopName
        
        return InventoryProduct(ItemCode: itemCode!, whsCode: whsCode!, SL: sl!, ShopCode: shopCode!, ShopName: shopName!)
    }
}

