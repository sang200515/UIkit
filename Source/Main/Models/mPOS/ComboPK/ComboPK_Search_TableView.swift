//
//  ComboPK_SearchSP2.swift
//  fptshop
//
//  Created by tan on 5/7/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ComboPK_Search_TableView: NSObject {
    var Name:String
    var Price:Int
    var Sku:String
    var BonusScopeBoom:String
    var Sl:Int
    var linkAnh:String
    var isSPChinh:String
    
    var id:Int = 0
    var brandID:Int = 0
    var brandName:String
    var typeId:Int
    var typeName:String
    var priceMarket:Float
    var priceBeforeTax:Float
    var iconUrl:String
    var imageUrl:String
    var promotion:String
    var includeInfo:String
    var hightlightsDes:String
    var labelName:String
    var urlLabelPicture:String
    var isRecurring:Bool
    var manSerNum:String
    var qlSerial:String
    var LableProduct:String
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
    init(Name:String
        , Price:Int
        , Sku:String
        , BonusScopeBoom:String
        , Sl:Int
        , linkAnh:String
        , isSPChinh:String
        
        ,id:Int
        ,brandID: Int
        , brandName: String
        , typeId: Int
        , typeName: String
        , priceMarket: Float
        , priceBeforeTax: Float
        , iconUrl: String
        ,imageUrl: String
        , promotion: String
        , includeInfo: String
        , hightlightsDes: String
        , labelName: String
        , urlLabelPicture: String
        , isRecurring: Bool
        , manSerNum: String
        ,  qlSerial: String
        ,  LableProduct:String
         ,hotSticker:Bool
         ,is_NK:Bool
         ,is_ExtendedWar:Bool
         ,skuBH:[String]
         ,nameBH:[String]
         ,brandGoiBH:[String]
         , isPickGoiBH: String
         , amountGoiBH: String
         , itemCodeGoiBH: String
         , itemNameGoiBH: String
         , priceSauKM: Float
         , role2: [String]
    ){
        self.Name = Name
        self.Price = Price
        self.Sku = Sku
        self.BonusScopeBoom = BonusScopeBoom
        self.Sl = Sl
        self.linkAnh = linkAnh
        self.isSPChinh = isSPChinh
        
        self.id = id
        self.brandID = brandID
        self.brandName = brandName
        self.typeId = typeId
        self.typeName = typeName
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
        self.qlSerial = qlSerial
        self.LableProduct = LableProduct
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
}
