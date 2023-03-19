//
//  Product.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
public class Product: NSObject , NSCopying{
    var model_id:String
    var id: Int
    var name: String
    var brandID: Int
    var brandName: String
    var typeId: Int
    var typeName: String
    var sku: String
    var price: Float
    var priceMarket: Float
    var priceBeforeTax: Float
    var iconUrl: String
    var imageUrl: String
    var promotion: String
    var includeInfo: String
    var hightlightsDes: String
    var labelName: String //Y:Sim P: Up hinh mdmh dong ho
    var urlLabelPicture: String
    var isRecurring: Bool
    var manSerNum: String
    var bonusScopeBoom: String
    var qlSerial: String
    var inventory: Int
    var LableProduct:String
    var p_matkinh:String
    var ecomColorValue:String
    var ecomColorName:String
    var ecom_itemname_web:String
    var price_special: Float
    var price_online_pos: Float
    var price_online: Float
    var hotSticker:Bool
    var is_NK:Bool
    var is_ExtendedWar:Bool
    var skuBH:[String]
    var nameBH:[String]
    var brandGoiBH:[String]
    var isPickGoiBH:String
    var amountGoiBH:String
    var itemCodeGoiBH:String
    var itemNameGoiBH:String
    var priceSauKM:Float
    var role2:[String]
    init(model_id:String,id: Int, name: String, brandID: Int, brandName: String, typeId: Int, typeName: String, sku: String, price: Float, priceMarket: Float, priceBeforeTax: Float, iconUrl: String, imageUrl: String, promotion: String, includeInfo: String, hightlightsDes: String, labelName: String, urlLabelPicture: String, isRecurring: Bool, manSerNum: String, bonusScopeBoom: String,qlSerial: String,inventory: Int,LableProduct:String,p_matkinh:String,ecomColorValue:String,ecomColorName:String,ecom_itemname_web:String,price_special:Float,price_online_pos: Float,price_online: Float,hotSticker:Bool,is_NK:Bool,is_ExtendedWar:Bool,skuBH:[String],nameBH:[String],brandGoiBH:[String],isPickGoiBH:String,amountGoiBH:String,itemCodeGoiBH:String,itemNameGoiBH:String,priceSauKM:Float,role2:[String]) {
        self.id = id
        self.name = name
        self.brandID = brandID
        self.brandName = brandName
        self.typeId = typeId
        self.typeName = typeName
        self.sku = sku
        self.price = price
        self.priceMarket = priceMarket
        self.priceBeforeTax = priceBeforeTax
        self.iconUrl = iconUrl
        self.imageUrl = imageUrl
        self.promotion = promotion
        self.includeInfo = includeInfo
        self.hightlightsDes = hightlightsDes
        self.labelName = labelName
        self.urlLabelPicture = urlLabelPicture
        self.isRecurring = isRecurring
        self.manSerNum = manSerNum
        self.bonusScopeBoom = bonusScopeBoom
        self.qlSerial = qlSerial
        self.inventory = inventory
        self.LableProduct = LableProduct
        self.model_id = model_id
        self.p_matkinh = p_matkinh
        self.ecomColorValue = ecomColorValue
        self.ecomColorName = ecomColorName
        self.ecom_itemname_web = ecom_itemname_web
        self.price_special = price_special
        self.price_online_pos = price_online_pos
        self.price_online = price_online
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
    
    class func getObjFromDictionary(data:JSON) -> Product{
        
        var id = data["ID"].int
        var name = data["name"].string
        var brandID = data["BrandID"].int //bo
        var brandName = data["ecom_band_name"].string
        var typeId = data["TypeID"].int //bo
        var typeName = data["TypeName"].string //bo
        var sku = data["sku"].string
        var price = data["price"].float
        var priceMarket = data["price_market"].float
        var priceBeforeTax = data["price_before_tax"].float
        var iconUrl = data["ecom_icon_url"].string
        var imageUrl = data["ecom_image_url"].string
        var promotion = data["ecom_promotion"].string
        var includeInfo = data["ecom_include_info"].string
        var hightlightsDes = data["ecom_highlights_des"].string
        var labelName = data["ecom_label_name"].string
        var urlLabelPicture = data["UrlLabelPicture"].string //bo
        var isRecurring = data["IsRecurring"].bool  //bo
        var manSerNum = data["man_ser_num"].string
        var bonusScopeBoom = data["ecom_bonus_scope_boom"].string
        var qlSerial = data["man_ser_num"].string
        var LableProduct = data["LableProduct"].string //bo
        var model_id = data["model_id"].string
        var ecom_itemname_web = data["ecom_itemname_web"].string
        var price_special = data["price_special"].float
        var price_online_pos = data["price_online_pos"].float
        var price_online = data["price_online"].float
        var ecomColorValue = data["ecom_color_value"].string
        var hotSticker = data["is_Hot"].bool
        var is_NK = data["is_NK"].bool
        var is_ExtendedWar = data["is_ExtendedWar"].bool
        var skuBH = data["skuBH"].arrayObject
        var nameBH = data["nameBH"].arrayObject
        var brandGoiBH = data["brandGoiBH"].arrayObject
        var isPickGoiBH = data["isPickGoiBH"].string
        var amountGoiBH = data["amountGoiBH"].string
        var itemCodeGoiBH = data["itemCodeGoiBH"].string
        var itemNameGoiBH = data["itemNameGoiBH"].string 
        var priceSauKM = data["priceSauKM"].float
        var role2 = data["role2"].arrayObject
        model_id = model_id == nil ? "" : model_id
        id = id == nil ? 0 : id
        name = name == nil ? "" : name
        brandID = brandID == nil ? 0 : brandID
        brandName = brandName == nil ? "" : brandName
        typeId = typeId == nil ? 0 : typeId
        typeName = typeName == nil ? "" : typeName
        sku = sku == nil ? "" : sku
        price = price == nil ? 0 : price
        priceMarket = priceMarket == nil ? 0 : priceMarket
        priceBeforeTax = priceBeforeTax == nil ? 0.0 : priceBeforeTax
        iconUrl = iconUrl == nil ? "" : iconUrl
        imageUrl = imageUrl == nil ? "" : imageUrl
        promotion = promotion == nil ? "" : promotion
        includeInfo = includeInfo == nil ? "" : includeInfo
        hightlightsDes = hightlightsDes == nil ? "" : hightlightsDes
        labelName = labelName == nil ? "" : labelName
        urlLabelPicture = urlLabelPicture == nil ? "" : urlLabelPicture
        isRecurring = isRecurring == nil ? false : isRecurring
        manSerNum = manSerNum == nil ? "" : manSerNum
        bonusScopeBoom = bonusScopeBoom == nil ? "" : bonusScopeBoom
        qlSerial = qlSerial == nil ? "" : qlSerial
        LableProduct = LableProduct == nil ? "" : LableProduct
        ecom_itemname_web = ecom_itemname_web == nil ? "" : ecom_itemname_web
        price_special = price_special == nil ? 0 : price_special
        price_online_pos = price_online_pos == nil ? 0 : price_online_pos
        price_online = price_online == nil ? 0 : price_online
        ecomColorValue = ecomColorValue == nil ? "" : ecomColorValue
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
        return Product(model_id:model_id!,id: id!, name: name!, brandID: brandID!, brandName: brandName!, typeId: typeId!, typeName: typeName!, sku: sku!, price: price!, priceMarket: priceMarket!, priceBeforeTax: priceBeforeTax!, iconUrl: iconUrl!, imageUrl: imageUrl!, promotion: promotion!, includeInfo: includeInfo!, hightlightsDes: hightlightsDes!, labelName: labelName!, urlLabelPicture: urlLabelPicture!, isRecurring: isRecurring!, manSerNum: manSerNum!, bonusScopeBoom: bonusScopeBoom!,qlSerial:qlSerial!,inventory:0,LableProduct:LableProduct!,p_matkinh:"",ecomColorValue:ecomColorValue!,ecomColorName:"",ecom_itemname_web:ecom_itemname_web!,price_special:price_special!,price_online_pos:price_online_pos!,price_online:price_online!, hotSticker: hotSticker!,is_NK:is_NK!,is_ExtendedWar:is_ExtendedWar!,skuBH:skuBH as! [String],nameBH: nameBH as! [String],brandGoiBH: brandGoiBH as! [String],isPickGoiBH: isPickGoiBH!,amountGoiBH: amountGoiBH!,itemCodeGoiBH: itemCodeGoiBH!,itemNameGoiBH: itemNameGoiBH!,priceSauKM: priceSauKM!,role2: role2 as! [String])
    }
    class func parseObjfromArray(array:[JSON])->[Product]{
        var list:[Product] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = Product(model_id:model_id,id: id, name: name, brandID: brandID, brandName: brandName, typeId: typeId, typeName: typeName, sku: sku, price: price, priceMarket: priceMarket, priceBeforeTax: priceBeforeTax, iconUrl: iconUrl, imageUrl: imageUrl, promotion: promotion, includeInfo: includeInfo, hightlightsDes: hightlightsDes, labelName: labelName, urlLabelPicture: urlLabelPicture, isRecurring: isRecurring, manSerNum: manSerNum, bonusScopeBoom: bonusScopeBoom,qlSerial:qlSerial,inventory:0,LableProduct:LableProduct,p_matkinh:p_matkinh,ecomColorValue:ecomColorValue,ecomColorName:ecomColorName,ecom_itemname_web:ecom_itemname_web,price_special:price_special,price_online_pos:price_online_pos,price_online:price_online, hotSticker: hotSticker,is_NK: is_NK,is_ExtendedWar: is_ExtendedWar,skuBH: skuBH,nameBH: nameBH, brandGoiBH:brandGoiBH,isPickGoiBH: isPickGoiBH,amountGoiBH: amountGoiBH,itemCodeGoiBH: itemCodeGoiBH,itemNameGoiBH: itemNameGoiBH,priceSauKM: priceSauKM,role2: role2)
        return copy
    }
    
}
