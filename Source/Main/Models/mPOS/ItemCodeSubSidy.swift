//
//  ItemCodeSubSidy.swift
//  mPOS
//
//  Created by MinhDH on 4/24/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class ItemCodeSubSidy: NSObject {
    
    var BonusScopeBoom: String
    var ImageUrl: String
    var ItemCode: String
    var ItemName: String
    var Price: Float
    var SoTienTroGia: Float
    var TienSauTroGia: Float
    
    init(BonusScopeBoom: String, ImageUrl: String, ItemCode: String, ItemName: String, Price: Float, SoTienTroGia: Float, TienSauTroGia: Float){
        self.BonusScopeBoom = BonusScopeBoom
        self.ImageUrl = ImageUrl
        self.ItemCode = ItemCode
        self.ItemName = ItemName
        self.Price = Price
        self.SoTienTroGia = SoTienTroGia
        self.TienSauTroGia = TienSauTroGia
    }
    class func parseObjfromArray(array:[JSON])->[ItemCodeSubSidy]{
        var list:[ItemCodeSubSidy] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ItemCodeSubSidy{
        
        var bonusScopeBoom = data["BonusScopeBoom"].string
        var imageUrl = data["ImageUrl"].string
        var itemCode = data["ItemCode"].string
        var itemName = data["ItemName"].string
        
        var price = data["Price"].float
        var soTienTroGia = data["SoTienTroGia"].float
        var tienSauTroGia = data["TienSauTroGia"].float
        
        bonusScopeBoom = bonusScopeBoom == nil ? "" : bonusScopeBoom
        imageUrl = imageUrl == nil ? "" : imageUrl
        itemCode = itemCode == nil ? "" : itemCode
        itemName = itemName == nil ? "" : itemName
        
        price = price == nil ? 0 : price
        soTienTroGia = soTienTroGia == nil ? 0 : soTienTroGia
        tienSauTroGia = tienSauTroGia == nil ? 0 : tienSauTroGia
        
        return ItemCodeSubSidy(BonusScopeBoom: bonusScopeBoom!, ImageUrl: imageUrl!, ItemCode: itemCode!, ItemName: itemName!, Price: price!, SoTienTroGia: soTienTroGia!, TienSauTroGia: tienSauTroGia!)
    }
}
