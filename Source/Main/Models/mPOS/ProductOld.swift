//
//  ProductOld.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/7/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
public class ProductOld: NSObject {
    var ID: Int
    var Name: String
    var Quantity: Int
    var Description: String
    var ShortDescription: String
    var StatusDescription: String
    var HightlightsDes: String
    var TimeGuarantee: String
    var ShopCode: String
    var ShopName: String
    var BrandID: Int
    var BrandName: String
    var TypeID: Int
    var TypeName: String
    var Sku: String
    var Price: Float
    var OldPrice: Float
    var IconUrl: String
    var ImageUrl: String
    var LabelName: String
    var UrlLabelPicture: String
    var ManSerNum: String
    var BonusScopeBoom: String
    
    init(ID: Int, Name: String, Quantity: Int, Description: String, ShortDescription: String, StatusDescription: String, HightlightsDes: String, TimeGuarantee: String, ShopCode: String, ShopName: String, BrandID: Int, BrandName: String, TypeID: Int, TypeName: String, Sku: String, Price: Float, OldPrice: Float, IconUrl: String, ImageUrl: String, LabelName: String, UrlLabelPicture: String, ManSerNum: String,BonusScopeBoom: String) {
        self.ID = ID
        self.Name = Name
        self.Quantity = Quantity
        self.Description = Description
        self.ShortDescription = ShortDescription
        self.StatusDescription = StatusDescription
        self.HightlightsDes = HightlightsDes
        self.TimeGuarantee = TimeGuarantee
        self.ShopCode = ShopCode
        self.ShopName = ShopName
        self.BrandID = BrandID
        self.BrandName = BrandName
        self.TypeID = TypeID
        self.TypeName = TypeName
        self.Sku = Sku
        self.Price = Price
        self.OldPrice = OldPrice
        self.IconUrl = IconUrl
        self.ImageUrl = ImageUrl
        self.LabelName = LabelName
        self.UrlLabelPicture = UrlLabelPicture
        self.ManSerNum = ManSerNum
        self.BonusScopeBoom = BonusScopeBoom
    }
    
    class func getObjFromDictionary(data:JSON) -> ProductOld{
        
        var id = data["ID"].int
        var name = data["Name"].string
        var quantity = data["Quantity"].int
        var description = data["Description"].string
        var shortDescription = data["ShortDescription"].string
        var statusDescription = data["StatusDescription"].string
        var hightlightsDes = data["HightlightsDes"].string
        var timeGuarantee = data["TimeGuarantee"].string
        var shopCode = data["ShopCode"].string
        var shopName = data["ShopName"].string
        var brandID = data["BrandID"].int
        var brandName = data["BrandName"].string
        var typeID = data["TypeID"].int
        var typeName = data["TypeName"].string
        var sku = data["Sku"].string
        var price = data["Price"].float
        var oldPrice = data["OldPrice"].float
        var iconUrl = data["IconUrl"].string
        var imageUrl = data["ImageUrl"].string
        var labelName = data["LabelName"].string
        var urlLabelPicture = data["UrlLabelPicture"].string
        var manSerNum = data["ManSerNum"].string
        var bonusScopeBoom = data["BonusScopeBoom"].string
        
        id = id == nil ? 0 : id
        name = name == nil ? "" : name
        quantity = quantity == nil ? 0 : quantity
        description = description == nil ? "" : description
        shortDescription = shortDescription == nil ? "" : shortDescription
        statusDescription = statusDescription == nil ? "" : statusDescription
        hightlightsDes = hightlightsDes == nil ? "" : hightlightsDes
        timeGuarantee = timeGuarantee == nil ? "" : timeGuarantee
        shopCode = shopCode == nil ? "" : shopCode
        shopName = shopName == nil ? "" : shopName
        brandID = brandID == nil ? 0 : brandID
        brandName = brandName == nil ? "" : brandName
        typeID = typeID == nil ? 0 : typeID
        typeName = typeName == nil ? "" : typeName
        sku = sku == nil ? "" : sku
        price = price == nil ? 0 : price
        oldPrice = oldPrice == nil ? 0 : oldPrice
        iconUrl = iconUrl == nil ? "" : iconUrl
        imageUrl = imageUrl == nil ? "" : imageUrl
        labelName = labelName == nil ? "" : labelName
        urlLabelPicture = urlLabelPicture == nil ? "" : urlLabelPicture
        manSerNum = manSerNum == nil ? "" : manSerNum
        bonusScopeBoom = bonusScopeBoom == nil ? "" : bonusScopeBoom
        
        return ProductOld(ID: id!, Name: name!, Quantity: quantity!, Description: description!, ShortDescription: shortDescription!, StatusDescription: statusDescription!, HightlightsDes: hightlightsDes!, TimeGuarantee: timeGuarantee!, ShopCode: shopCode!, ShopName: shopName!, BrandID: brandID!, BrandName: brandName!, TypeID: typeID!, TypeName: typeName!, Sku: sku!, Price: price!, OldPrice: oldPrice!, IconUrl: iconUrl!, ImageUrl: imageUrl!, LabelName: labelName!, UrlLabelPicture: urlLabelPicture!, ManSerNum: manSerNum!, BonusScopeBoom: bonusScopeBoom!)
    }
    class func parseObjfromArray(array:[JSON])->[ProductOld]{
        var list:[ProductOld] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
}

