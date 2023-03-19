//
//  ItemRPComplete.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/7/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ItemRPOnProgress: NSObject {
    var imei:String
    var price:Int
    var seller:String
    var phoneSeller:String
    var buyer:String
    var phoneBuyer:String
    var nameProduct:String
    var Status:String
    var date:String
    var trangthai:String
    var docentry:Int
    
    init( imei:String
    , price:Int
    , seller:String
    , phoneSeller:String
    , buyer:String
    , phoneBuyer:String
    , nameProduct:String
    , Status:String
    , date:String
    , trangthai:String
        , docentry:Int){
        self.imei = imei
        self.price = price
        self.seller = seller
        self.phoneSeller = phoneSeller
        self.buyer = buyer
        self.phoneBuyer = phoneBuyer
        self.nameProduct = nameProduct
        self.Status = Status
        self.date = date
        self.trangthai = trangthai
        self.docentry = docentry
    }
    
    
    class func parseObjfromArray(array:[JSON])->[ItemRPOnProgress]{
         var list:[ItemRPOnProgress] = []
         for item in array {
             list.append(self.getObjFromDictionary(data: item))
         }
         return list
     }
     
     class func getObjFromDictionary(data:JSON) -> ItemRPOnProgress{
         var imei = data["IMEI"].string
         var price = data["Sale_price"].int
         var seller = data["Sale_Name"].string
         var phoneSeller = data["Sale_phone"].string
         var buyer = data["Buy_Name"].string
        var phoneBuyer = data["Buy_phone"].string
        var nameProduct = data["ItemName"].string
        var Status = data["Status"].string
        var date = data["Ngay"].string
        var trangthai = data["TrangThai"].string
        var docentry = data["docentry"].int
         
         imei = imei == nil ? "" : imei
         price = price == nil ? 0 : price
         seller = seller == nil ? "" : seller
         phoneSeller = phoneSeller == nil ? "" : phoneSeller
         buyer = buyer == nil ? "" : buyer
        phoneBuyer = phoneBuyer == nil ? "" : phoneBuyer
        nameProduct = nameProduct == nil ? "" : nameProduct
        Status = Status == nil ? "" : Status
        date = date == nil ? "" : date
        trangthai = trangthai == nil ? "" : trangthai
        docentry = docentry == nil ? 0 : docentry
         return ItemRPOnProgress(imei:imei!
         , price:price!
         , seller:seller!
         , phoneSeller:phoneSeller!
         , buyer:buyer!
         , phoneBuyer:phoneBuyer!
         , nameProduct:nameProduct!
         , Status:Status!
         , date:date!
            , trangthai:trangthai!
            ,docentry:docentry!)
     }
    
    
}
