//
//  Variant.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class Variant: NSObject {
    var model_id:String
    var id: Int
    var sku: String
    var colorName: String
    var colorValue: String
    var price: Float
    var priceMarket: Float
    var priceBeforeTax: Float
    var isRecurring: Bool
    var manSerNum: String
    var bonusScopeBoom: String
    var PriceOnlinePOS:Float
    var PriceSpecial:Float
    var price_online:Float
    var name:String
    var isSelected:Bool
    var ecom_image_url:String
    var replacementAccessories:ReplacementAccessory?
    var hotSticker: Bool
    var is_NK: Bool
    var is_ExtendedWar: Bool
    var skuBH: [String]
    var nameBH: [String]
    var brandGoiBH: [String]
    var isPickGoiBH: String
    var amountGoiBH: String
    var itemCodeGoiBH: String
    var itemNameGoiBH: String
    var priceSauKM: Float
    var role2:[String]
    init(model_id:String,id: Int, sku: String, colorName: String, colorValue: String, price: Float, priceMarket: Float, priceBeforeTax: Float, isRecurring: Bool, manSerNum: String, bonusScopeBoom: String,PriceOnlinePOS:Float,PriceSpecial:Float,price_online: Float,name:String,isSelected:Bool,ecom_image_url:String, replacementAccessories:ReplacementAccessory,hotSticker:Bool,is_NK:Bool,is_ExtendedWar:Bool,skuBH:[String],nameBH:[String],brandGoiBH:[String], isPickGoiBH: String, amountGoiBH: String, itemCodeGoiBH: String, itemNameGoiBH: String, priceSauKM: Float,role2:[String]) {
        self.model_id = model_id
        self.id = id
        self.sku = sku
        self.colorName = colorName
        self.colorValue = colorValue
        self.price = price
        self.priceMarket = priceMarket
        self.priceBeforeTax = priceBeforeTax
        self.isRecurring = isRecurring
        self.manSerNum = manSerNum
        self.bonusScopeBoom = bonusScopeBoom
        self.PriceOnlinePOS = PriceOnlinePOS
        self.PriceSpecial = PriceSpecial
        self.price_online = price_online
        self.name = name
        self.isSelected = isSelected
        self.ecom_image_url = ecom_image_url
        self.replacementAccessories = replacementAccessories
        self.hotSticker = hotSticker
        self.is_NK = is_NK
        self.is_ExtendedWar = is_ExtendedWar
        self.skuBH = skuBH
        self.nameBH = nameBH
        self.brandGoiBH = brandGoiBH
        self.isPickGoiBH = isPickGoiBH
        self.amountGoiBH = amountGoiBH
        self.itemCodeGoiBH = itemCodeGoiBH
        self.itemNameGoiBH = itemNameGoiBH
        self.priceSauKM = priceSauKM
        self.role2 = role2
    }
    
    class func getObjFromDictionary(data:JSON) -> Variant{
        var model_id = data["model_id"].string
        var id = data["ID"].int
        var sku = data["sku"].string
        var colorName = data["ecom_color_name"].string
        var colorValue = data["ecom_color_value"].string
        var price = data["price"].float
        var priceMarket = data["price_market"].float
        var priceBeforeTax = data["price_before_tax"].float
        var isRecurring = data["IsRecurring"].bool //bo
        var manSerNum = data["man_ser_num"].string
        var bonusScopeBoom = data["BonusScopeBoom"].string //bo
        var PriceOnlinePOS = data["price_online_pos"].float
        var PriceSpecial = data["price_special"].float
        var price_online = data["price_online"].float
        var name = data["name"].string
        var ecom_image_url = data["ecom_image_url"].string
        var hotSticker = data["hotSticker"].bool //bo
        var is_NK = data["is_NK"].bool //bo
        var is_ExtendedWar = data["is_ExtendedWar"].bool
        var skuBH = data["skuBH"].arrayObject
        var nameBH = data["nameBH"].arrayObject
        var brandGoiBH = data["brandGoiBh"].arrayObject
        var isPickGoiBH = data["isPickGoiBH"].string
        var amountGoiBH = data["amountGoiBH"].string
        var itemCodeGoiBH = data["itemCodeGoiBH"].string
        var itemNameGoiBH = data["itemNameGoiBH"].string
        var priceSauKM = data["priceSauKM"].float
        var role2 = data["role2"].arrayObject

        //replacement accessories
        let replacementAccessoryObject = data["product_bundled"]
        let replacementAccessories = ReplacementAccessory.getObjFromDictionary(data: replacementAccessoryObject)
        
        model_id = model_id == nil ? "" : model_id
        id = id == nil ? 0 : id
        sku = sku == nil ? "" : sku
        colorName = colorName == nil ? "" : colorName
        colorValue = colorValue == nil ? "" : colorValue
        price = price == nil ? 0 : price
        priceMarket = priceMarket == nil ? 0 : priceMarket
        priceBeforeTax = priceBeforeTax == nil ? 0.0 : priceBeforeTax
        isRecurring = isRecurring == nil ? false : isRecurring
        manSerNum = manSerNum == nil ? "" : manSerNum
        bonusScopeBoom = bonusScopeBoom == nil ? "" : bonusScopeBoom
        PriceOnlinePOS = PriceOnlinePOS == nil ? 0.0 :PriceOnlinePOS
        PriceSpecial = PriceSpecial == nil ? 0.0 : PriceSpecial
        price_online = price_online == nil ? 0.0 : price_online
        name = name == nil ? "" : name
        ecom_image_url = ecom_image_url == nil ? "" : ecom_image_url
        hotSticker = hotSticker == nil ? false : hotSticker
        is_NK = is_NK == nil ? false : is_NK
        is_ExtendedWar = is_ExtendedWar == nil ? false : is_ExtendedWar
        skuBH = skuBH == nil ? [] : skuBH
        nameBH = nameBH == nil ? [] : nameBH
        brandGoiBH = brandGoiBH == nil ? [] : brandGoiBH
        isPickGoiBH = isPickGoiBH == nil ? "" : isPickGoiBH
        amountGoiBH = amountGoiBH == nil ? "" : amountGoiBH 
        itemCodeGoiBH = itemCodeGoiBH == nil ? "" : itemCodeGoiBH
        itemNameGoiBH = itemNameGoiBH == nil ? "" : itemNameGoiBH
        priceSauKM = priceSauKM == nil ? 0 : priceSauKM
        role2 = role2 == nil ? [] : role2

        return Variant(model_id:model_id!,id: id!, sku: sku!, colorName: colorName!, colorValue: colorValue!, price: price!, priceMarket: priceMarket!, priceBeforeTax: priceBeforeTax!, isRecurring: isRecurring!, manSerNum: manSerNum!, bonusScopeBoom: bonusScopeBoom!,PriceOnlinePOS:PriceOnlinePOS!,PriceSpecial:PriceSpecial!,price_online:price_online!,name:name!,isSelected:false,ecom_image_url:ecom_image_url!,replacementAccessories:replacementAccessories, hotSticker: hotSticker!,is_NK: is_NK!,is_ExtendedWar: is_ExtendedWar!,skuBH: skuBH as! [String],nameBH:nameBH as! [String],brandGoiBH:brandGoiBH as! [String],isPickGoiBH:isPickGoiBH!,amountGoiBH:amountGoiBH!,itemCodeGoiBH:itemCodeGoiBH!,itemNameGoiBH:itemNameGoiBH!,priceSauKM:priceSauKM!,role2:role2 as! [String])
    }
    
    class func parseObjfromArray(array:[JSON])->[Variant]{
        var list:[Variant] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
}

class ReplacementAccessory: NSObject {
    var sku: String
    var text: String
    var variants: [Variant]
    
    init(sku: String, text: String, variants: [Variant]) {
        self.sku = sku
        self.text = text
        self.variants = variants
    }
    
    class func getObjFromDictionary(data: JSON) -> ReplacementAccessory {
        let sku = data["sku"].stringValue
        let text = data["text"].stringValue
        let variantArray = data["variants"].arrayValue
        let variants = Variant.parseObjfromArray(array: variantArray)
        
        return ReplacementAccessory(sku: sku, text: text, variants: variants)
    }
}
