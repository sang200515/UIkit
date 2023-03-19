//
//  ComboPK_SearchSP.swift
//  fptshop
//
//  Created by tan on 4/30/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class ComboPK_SearchSP: Object {
    @objc dynamic var Name = ""
    @objc dynamic var Price = 0
    @objc dynamic var Sku = ""
    @objc dynamic var BonusScopeBoom = ""
    @objc dynamic var Sl = 0
    @objc dynamic var linkAnh = ""
    @objc dynamic var isSPChinh = ""
    
    @objc dynamic var id = 0
    @objc dynamic var brandID = 0
    @objc dynamic var brandName = ""
    @objc dynamic var typeId = 0
    @objc dynamic var typeName = ""
    @objc dynamic var priceMarket:Float = 0.0
    @objc dynamic var priceBeforeTax:Float = 0.0
    @objc dynamic var iconUrl = ""
    @objc dynamic var imageUrl = ""
    @objc dynamic var promotion = ""
    @objc dynamic var includeInfo = ""
    @objc dynamic var hightlightsDes = ""
    @objc dynamic var labelName = ""
    @objc dynamic var urlLabelPicture = ""
    @objc dynamic var isRecurring = false
    @objc dynamic var manSerNum = ""
    @objc dynamic var qlSerial = ""
    @objc dynamic var LableProduct = ""
    @objc dynamic var hotSticker = false
    @objc dynamic var is_NK = false
    @objc dynamic var is_ExtendedWar = false
      var skuBH :[String] = []
      var nameBH:[String] = []
      var brandGoiBH:[String] = []
    @objc dynamic var isPickGoiBH = ""
    @objc dynamic var amountGoiBH = ""
    @objc dynamic var itemCodeGoiBH = ""
    @objc dynamic var itemNameGoiBH = ""
    @objc dynamic var priceSauKM:Float = 0.0
    var role2 :[String] = []

    //    init(Name:String
    //    , Price:Int
    //    , Sku:String
    //    , BonusScopeBoom:String
    //    , Sl:Int
    //    , linkAnh:String
    //    , isSPChinh:String
    //
    //    ,id:Int
    //     ,brandID: Int
    //    , brandName: String
    //    , typeId: Int
    //    , typeName: String
    //    , priceMarket: Float
    //    , priceBeforeTax: Float
    //    , iconUrl: String
    //     ,imageUrl: String
    //    , promotion: String
    //    , includeInfo: String
    //    , hightlightsDes: String
    //    , labelName: String
    //    , urlLabelPicture: String
    //    , isRecurring: Bool
    //    , manSerNum: String
    //   ,  qlSerial: String
    //   ,  LableProduct:String){
    //        self.Name = Name
    //        self.Price = Price
    //        self.Sku = Sku
    //        self.BonusScopeBoom = BonusScopeBoom
    //        self.Sl = Sl
    //        self.linkAnh = linkAnh
    //        self.isSPChinh = isSPChinh
    //
    //        self.id = id
    //        self.brandID = brandID
    //        self.brandName = brandName
    //        self.typeId = typeId
    //        self.typeName = typeName
    //        self.priceMarket = priceMarket
    //        self.priceBeforeTax = priceBeforeTax
    //        self.iconUrl = iconUrl
    //        self.imageUrl = imageUrl
    //        self.promotion = promotion
    //        self.includeInfo = includeInfo
    //        self.hightlightsDes = hightlightsDes
    //        self.labelName = labelName
    //        self.urlLabelPicture = urlLabelPicture
    //        self.isRecurring = isRecurring
    //        self.manSerNum = manSerNum
    //        self.qlSerial = qlSerial
    //        self.LableProduct = LableProduct
    //
    //    }
    
    
    class func parseObjfromArray(array:[JSON])->[ComboPK_SearchSP]{
        var list:[ComboPK_SearchSP] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    class func getObjFromDictionary(data:JSON) -> ComboPK_SearchSP{
        
        var Name = data["Name"].string
        var Price = data["Price"].int
        var Sku  = data["Sku"].string
        var BonusScopeBoom = data["BonusScopeBoom"].string
        var Sl = data["Sl"].int
        var linkAnh = data["linkAnh"].string
        
        
        var id = data["ID"].int
        var name = data["Name"].string
        var brandID = data["BrandID"].int
        var brandName = data["BrandName"].string
        var typeId = data["TypeID"].int
        var typeName = data["TypeName"].string
        var priceMarket = data["PriceMarket"].float
        var priceBeforeTax = data["PriceBeforeTax"].float
        var iconUrl = data["IconUrl"].string
        var imageUrl = data["ImageUrl"].string
        var promotion = data["Promotion"].string
        var includeInfo = data["IncludeInfo"].string
        var hightlightsDes = data["HightlightsDes"].string
        var labelName = data["LabelName"].string
        var urlLabelPicture = data["UrlLabelPicture"].string
        var isRecurring = data["IsRecurring"].bool
        var manSerNum = data["ManSerNum"].string
        var bonusScopeBoom = data["BonusScopeBoom"].string
        var qlSerial = data["qlSerial"].string
        var LableProduct = data["LableProduct"].string
        var hotSticker = data["is_Hot"].bool
        var is_NK = data["is_NK"].bool
        var is_ExtendedWar = data["is_ExtendedWar"].bool
        //Goi bao hanh
        var skuBH = data["skuBH"].arrayObject
        var brandGoiBH = data["brandGoiBH"].arrayObject
        var nameBH = data["nameBH"].arrayObject
        var isPickGoiBH = data["isPickGoiBH"].string
        var amountGoiBH = data["amountGoiBH"].string
        var itemCodeGoiBH = data["itemCodeGoiBH"].string
        var itemNameGoiBH = data["itemNameGoiBH"].string
        var priceSauKM = data["priceSauKM"].float
        var role2 = data["role2"].arrayObject

        id = id == nil ? 0 : id
        name = name == nil ? "" : name
        brandID = brandID == nil ? 0 : brandID
        brandName = brandName == nil ? "" : brandName
        typeId = typeId == nil ? 0 : typeId
        typeName = typeName == nil ? "" : typeName
        
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
        
        Name = Name == nil ? "" : Name
        Price = Price == nil ? 0 : Price
        Sku = Sku == nil ? "" :Sku
        BonusScopeBoom = BonusScopeBoom == nil ? "" : BonusScopeBoom
        Sl = Sl == nil ? 0 : Sl
        linkAnh = linkAnh == nil ? "" : linkAnh
        let NameSearch = Name!.folding(options: .diacriticInsensitive, locale: nil)
        
        let item = ComboPK_SearchSP()
        item.Name =  NameSearch.uppercased()
        item.Price = Price!
        item.Sku = Sku!
        item.BonusScopeBoom = BonusScopeBoom!
        item.Sl = Sl!
        item.linkAnh = linkAnh!
        item.isSPChinh = ""
        item.id = id!
        item.brandID = brandID!
        item.brandName = brandName!
        item.typeId = typeId!
        item.typeName = typeName!
        item.priceMarket = priceMarket!
        item.priceBeforeTax = priceBeforeTax!
        item.iconUrl = iconUrl!
        item.imageUrl = imageUrl!
        item.promotion = promotion!
        item.includeInfo = includeInfo!
        item.hightlightsDes = hightlightsDes!
        item.labelName = labelName!
        item.urlLabelPicture = urlLabelPicture!
        item.isRecurring = isRecurring!
        item.manSerNum = manSerNum!
        item.qlSerial = qlSerial!
        item.LableProduct = LableProduct!
        item.hotSticker = hotSticker!
        item.is_NK = is_NK!
        item.is_ExtendedWar = is_ExtendedWar!
        item.skuBH = skuBH as! [String]
        item.nameBH = nameBH as! [String]
        item.brandGoiBH = brandGoiBH as! [String]
        item.isPickGoiBH = isPickGoiBH!
        item.amountGoiBH = amountGoiBH!
        item.itemCodeGoiBH = itemCodeGoiBH!
        item.itemNameGoiBH = itemNameGoiBH!
        item.priceSauKM = priceSauKM!
        item.role2 = role2!  as! [String]
        return item
        
        
        
    }
    
    
}
