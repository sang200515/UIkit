//
//  HeaderCompleteRP.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/18/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class HeaderCompleteRP: NSObject {
    var IMEI:String
    var ItemName:String
    var Status:String
    var Buy_Name:String
    var Buy_phone:String
    var Sale_Name:String
    var Sale_phone:String
    var Ngay:String
    var Sale_price:Float
    var TrangThai:String
    var docentry:Int
    
    init(IMEI:String
     , ItemName:String
     , Status:String
     , Buy_Name:String
     , Buy_phone:String
     , Sale_Name:String
     , Sale_phone:String
     , Ngay:String
     , Sale_price:Float
     , TrangThai:String
     , docentry:Int){
        self.IMEI = IMEI
        self.ItemName = ItemName
        self.Status = Status
        self.Buy_Name = Buy_Name
        self.Buy_phone = Buy_phone
        self.Sale_Name = Sale_Name
        self.Sale_phone = Sale_phone
        self.Ngay = Ngay
        self.Sale_price = Sale_price
        self.TrangThai = TrangThai
        self.docentry = docentry
    }
    
    class func parseObjfromArray(array:[JSON])->[HeaderCompleteRP]{
             var list:[HeaderCompleteRP] = []
             for item in array {
                 list.append(self.getObjFromDictionary(data: item))
             }
             return list
         }
         
         class func getObjFromDictionary(data:JSON) -> HeaderCompleteRP{
             var IMEI = data["IMEI"].string
            var ItemName = data["ItemName"].string
            var Status = data["Status"].string
            var Buy_Name = data["Buy_Name"].string
            var Buy_phone = data["Buy_phone"].string
            var Sale_Name = data["Sale_Name"].string
            var Sale_phone = data["Sale_phone"].string
            var Ngay = data["Ngay"].string
            var Sale_price = data["Sale_price"].float
            var TrangThai = data["TrangThai"].string
            var docentry = data["docentry"].int
            
             IMEI = IMEI == nil ? "" : IMEI
            ItemName = ItemName == nil ? "" : ItemName
            Status = Status == nil ? "" : Status
            Buy_Name = Buy_Name == nil ? "" : Buy_Name
            Buy_phone = Buy_phone == nil ? "" : Buy_phone
            Sale_Name = Sale_Name == nil ? "" : Sale_Name
            Sale_phone = Sale_phone == nil ? "" : Sale_phone
            Ngay = Ngay == nil ? "" : Ngay
            Sale_price = Sale_price == nil ? 0 : Sale_price
             TrangThai = TrangThai == nil ? "" : TrangThai
              docentry = docentry == nil ? 0 : docentry
             return HeaderCompleteRP(IMEI:IMEI!
             , ItemName:ItemName!
             , Status:Status!
             , Buy_Name:Buy_Name!
             , Buy_phone:Buy_phone!
             , Sale_Name:Sale_Name!
             , Sale_phone:Sale_phone!
             , Ngay:Ngay!
             , Sale_price:Sale_price!
             , TrangThai:TrangThai!
             , docentry:docentry!
        )
         }
}
