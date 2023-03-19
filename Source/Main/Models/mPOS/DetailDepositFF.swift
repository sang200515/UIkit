//
//  DetailDepositFF.swift
//  fptshop
//
//  Created by Ngo Dang tan on 12/12/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"ItemCode": "00606122",
//"ItemName": "iPhone 11 64GB",
//"Price": 19990909.000000,
//"BonusScopeBoom": "B8",
//"linkAnh": "http://cdn.fptshop.com.vn/Uploads/Thumbs/2019/9/11/637037651956109900_11-chung.png",
//"ID": 28991,
//"BrandID": 2,
//"ProductTypeID": 1,
//"PriceMarket": 19990909,
//"PriceBeforeTax": 18173553,
//"iconUrl": "http://cdn.fptshop.com.vn/Uploads/Thumbs/2019/9/11/637037651956109900_11-chung.png",
//"ManSerNum": "Y",
//"inventory": 1,
//"IncludeInfo": "",
//"LabelName": "",
//"HightlightsDes": "",
//"qlSerial": "Y",
//"LableProduct": ""
import Foundation
import SwiftyJSON
class DetailDepositFF: NSObject {
    
    var ItemCode:String
    var ItemName:String
    var Price:Float
    var BonusScopeBoom:String
    var linkAnh:String
    var ID:Int
    var BrandID:Int
    var ProductTypeID:Int
    var PriceMarket:Float
    var PriceBeforeTax:Float
    var iconUrl:String
    var ManSerNum:String
    var inventory:Int
    var IncludeInfo:String
    var LabelName:String
    var HightlightsDes:String
    var qlSerial:String
    var LableProduct:String
    
    init(ItemCode:String
     , ItemName:String
     , Price:Float
     , BonusScopeBoom:String
     , linkAnh:String
     , ID:Int
     , BrandID:Int
     , ProductTypeID:Int
     , PriceMarket:Float
     , PriceBeforeTax:Float
     , iconUrl:String
     , ManSerNum:String
     , inventory:Int
     , IncludeInfo:String
     , LabelName:String
     , HightlightsDes:String
     , qlSerial:String
     , LableProduct:String){
        self.ItemCode = ItemCode
        self.ItemName = ItemName
        self.Price = Price
        self.BonusScopeBoom = BonusScopeBoom
        self.linkAnh = linkAnh
        self.ID = ID
        self.BrandID = BrandID
        self.ProductTypeID = ProductTypeID
        self.PriceMarket = PriceMarket
        self.PriceBeforeTax = PriceBeforeTax
        self.iconUrl = iconUrl
        self.ManSerNum = ManSerNum
        self.inventory = inventory
        self.IncludeInfo = IncludeInfo
        self.LabelName = LabelName
        self.HightlightsDes = HightlightsDes
        self.qlSerial = qlSerial
        self.LableProduct = LableProduct
    }
    
    class func parseObjfromArray(array:[JSON])->[DetailDepositFF]{
        var list:[DetailDepositFF] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
   class func getObjFromDictionary(data:JSON) -> DetailDepositFF{
          
          var ItemCode = data["ItemCode"].string
          var ItemName = data["ItemName"].string
          var Price = data["Price"].float
          var BonusScopeBoom = data["BonusScopeBoom"].string
          var linkAnh = data["linkAnh"].string
          var ID = data["ID"].int
          var BrandID = data["BrandID"].int
          var ProductTypeID = data["ProductTypeID"].int
          var PriceMarket = data["PriceMarket"].float
          var PriceBeforeTax = data["PriceBeforeTax"].float
          var iconUrl = data["iconUrl"].string
          var ManSerNum = data["ManSerNum"].string
          var inventory = data["inventory"].int
          var IncludeInfo = data["IncludeInfo"].string
          var LabelName = data["LabelName"].string
          var HightlightsDes = data["HightlightsDes"].string
          var qlSerial = data["qlSerial"].string
          var LableProduct = data["LableProduct"].string
          
          
          ItemCode = ItemCode == nil ? "" : ItemCode
          ItemName = ItemName == nil ? "" : ItemName
          Price = Price == nil ? 0 : Price
          BonusScopeBoom = BonusScopeBoom == nil ? "" : BonusScopeBoom
          linkAnh = linkAnh == nil ? "" : linkAnh
          ID = ID == nil ? 0 : ID
          BrandID = BrandID == nil ? 0 : BrandID
          ProductTypeID = ProductTypeID == nil ? 0 : ProductTypeID
          PriceMarket = PriceMarket == nil ? 0 : PriceMarket
              PriceBeforeTax = PriceBeforeTax == nil ? 0 : PriceBeforeTax
              iconUrl = iconUrl == nil ? "" : iconUrl
          ManSerNum = ManSerNum == nil ? "" : ManSerNum
          inventory = inventory == nil ? 0 : inventory
             IncludeInfo = IncludeInfo == nil ? "" : IncludeInfo
                 LabelName = LabelName == nil ? "" : LabelName
           HightlightsDes = HightlightsDes == nil ? "" : HightlightsDes
               qlSerial = qlSerial == nil ? "" : qlSerial
          LableProduct = LableProduct == nil ? "" : LableProduct
          
          return DetailDepositFF(ItemCode:ItemCode!
              , ItemName:ItemName!
              , Price:Price!
              , BonusScopeBoom:BonusScopeBoom!
              , linkAnh:linkAnh!
              , ID:ID!
              , BrandID:BrandID!
              , ProductTypeID:ProductTypeID!
              , PriceMarket:PriceMarket!
              , PriceBeforeTax:PriceBeforeTax!
              , iconUrl:iconUrl!
              , ManSerNum:ManSerNum!
              , inventory:inventory!
              , IncludeInfo:IncludeInfo!
              , LabelName:LabelName!
              , HightlightsDes:HightlightsDes!
              , qlSerial:qlSerial!
              , LableProduct:LableProduct!
          )
      }

}
