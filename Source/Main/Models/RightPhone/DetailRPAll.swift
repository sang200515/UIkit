//
//  DetailRPAll.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/13/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class DetailRPAll: NSObject {
    var IMEI:String
    var ItemName:String
    var manufacturer:String
    var memory:String
    var color:String
    var Sale_Name:String
    var Sale_mail:String
    var Sale_phone:String
    var Buy_Name:String
    var Buy_mail:String
    var Buy_phone:String
    var Sale_price:Float
    var Note:String
    var TenShop:String
    var TenNVRcheck:String
    var Rcheck_date:String
    
    init( IMEI:String
    , ItemName:String
    , manufacturer:String
    , memory:String
    , color:String
    , Sale_Name:String
    , Sale_mail:String
    , Sale_phone:String
    , Buy_Name:String
    , Buy_mail:String
    , Buy_phone:String
    , Sale_price:Float
    , Note:String
    , TenShop:String
    , TenNVRcheck:String
        , Rcheck_date:String){
        self.IMEI = IMEI
        self.ItemName = ItemName
        self.manufacturer = manufacturer
        self.memory = memory
        self.color = color
        self.Sale_Name = Sale_Name
        self.Sale_mail = Sale_mail
        self.Sale_phone = Sale_phone
        self.Buy_Name = Buy_Name
        self.Buy_mail = Buy_mail
        self.Buy_phone = Buy_phone
        self.Sale_price = Sale_price
        self.Note = Note
        self.TenShop = TenShop
        self.TenNVRcheck = TenNVRcheck
        self.Rcheck_date = Rcheck_date
    }
    
    class func parseObjfromArray(array:[JSON])->[DetailRPAll]{
            var list:[DetailRPAll] = []
            for item in array {
                list.append(self.getObjFromDictionary(data: item))
            }
            return list
        }
        
        class func getObjFromDictionary(data:JSON) -> DetailRPAll{
            var IMEI = data["IMEI"].string
            var ItemName = data["ItemName"].string
            var manufacturer = data["manufacturer"].string
            var memory = data["memory"].string
            var color = data["color"].string
           var Sale_Name = data["Sale_Name"].string
           var Sale_mail = data["Sale_mail"].string
           var Sale_phone = data["Sale_phone"].string
            var Buy_Name = data["Buy_Name"].string
            var Buy_mail = data["Buy_mail"].string
            var Buy_phone = data["Buy_phone"].string
            var Sale_price = data["Sale_price"].float
            var Note = data["Note"].string
            var TenShop = data["TenShop"].string
            var TenNVRcheck = data["TenNVRcheck"].string
            var Rcheck_date = data["Rcheck_date"].string
            
            IMEI = IMEI == nil ? "" : IMEI
            ItemName = ItemName == nil ? "" : ItemName
            manufacturer = manufacturer == nil ? "" : manufacturer
            memory = memory == nil ? "" : memory
            color = color == nil ? "" : color
           Sale_Name = Sale_Name == nil ? "" : Sale_Name
           Sale_mail = Sale_mail == nil ? "" : Sale_mail
           Sale_phone = Sale_phone == nil ? "" : Sale_phone
            //
            Buy_Name = Buy_Name == nil ? "" : Buy_Name
            Buy_mail = Buy_mail == nil ? "" : Buy_mail
            Buy_phone = Buy_phone == nil ? "" : Buy_phone
            //
           Sale_price = Sale_price == nil ? 0 : Sale_price
           Note = Note == nil ? "" : Note
            TenShop = TenShop == nil ? "" : TenShop
            TenNVRcheck = TenNVRcheck == nil ? "" : TenNVRcheck
            Rcheck_date = Rcheck_date == nil ? "" : Rcheck_date
            return DetailRPAll(IMEI:IMEI!
            , ItemName:ItemName!
            , manufacturer:manufacturer!
            , memory:memory!
            , color:color!
            , Sale_Name:Sale_Name!
            , Sale_mail:Sale_mail!
            , Sale_phone:Sale_phone!
            , Buy_Name:Buy_Name!
            , Buy_mail:Buy_mail!
            , Buy_phone:Buy_phone!
            , Sale_price:Sale_price!
            , Note:Note!
            , TenShop:TenShop!
            , TenNVRcheck:TenNVRcheck!
                , Rcheck_date:Rcheck_date!)
        }
}
