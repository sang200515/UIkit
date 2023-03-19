//
//  DetailRPComplete.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/8/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"Ngay": "2020-02-12 15:40:48.6",
//"IMEI": "123456",
//"ItemName": "samsung S20",
//"manufacturer": "Samsung",
//"memory": "80GB",
//"color": "Vang",
//"Note": "Shop phải thu 100K sau khi khách chạy rcheck xong "
import Foundation
import SwiftyJSON
class DetailRPRcheck: NSObject {
    var Ngay:String
    var IMEI:String
    var ItemName:String
    var manufacturer:String
    var memory:String
    var color:String
    var Note:String
    var Sale_Name:String
    var Sale_phone:String
    var Sale_mail:String
    var is_rightphone:String
    init( Ngay:String
    , IMEI:String
    , ItemName:String
    , manufacturer:String
    , memory:String
    , color:String
    , Note:String
    , Sale_Name:String
    , Sale_phone:String
    , Sale_mail:String
    , is_rightphone:String){
        self.Ngay = Ngay
        self.IMEI = IMEI
        self.ItemName = ItemName
        self.manufacturer = manufacturer
        self.memory = memory
        self.color = color
        self.Note = Note
        
        self.Sale_Name = Sale_Name
        self.Sale_phone = Sale_phone
        self.Sale_mail = Sale_mail
        self.is_rightphone = is_rightphone
    }
    class func parseObjfromArray(array:[JSON])->[DetailRPRcheck]{
         var list:[DetailRPRcheck] = []
         for item in array {
             list.append(self.getObjFromDictionary(data: item))
         }
         return list
     }
     
     class func getObjFromDictionary(data:JSON) -> DetailRPRcheck{
         var Ngay = data["Ngay"].string
         var IMEI = data["IMEI"].string
         var ItemName = data["ItemName"].string
         var manufacturer = data["manufacturer"].string
         var memory = data["memory"].string
        var color = data["color"].string
        var Note = data["Note"].string
        var Sale_Name = data["Sale_Name"].string
        var Sale_phone = data["Sale_phone"].string
        var Sale_mail = data["Sale_mail"].string
        var is_rightphone = data["is_rightphone"].string
  
         
         Ngay = Ngay == nil ? "" : Ngay
         IMEI = IMEI == nil ? "" : IMEI
         ItemName = ItemName == nil ? "" : ItemName
         manufacturer = manufacturer == nil ? "" : manufacturer
         memory = memory == nil ? "" : memory
        color = color == nil ? "" : color
        Note = Note == nil ? "" : Note
        Sale_Name = Sale_Name == nil ? "" : Sale_Name
        Sale_phone = Sale_phone == nil ? "" : Sale_phone
        Sale_phone = Sale_phone == nil ? "" : Sale_phone
        Sale_mail = Sale_mail == nil ? "" : Sale_mail
        is_rightphone = is_rightphone == nil ? "" : is_rightphone
         return DetailRPRcheck(Ngay:Ngay!
         , IMEI:IMEI!
         , ItemName:ItemName!
         , manufacturer:manufacturer!
         , memory:memory!
         , color:color!
         , Note:Note!
        , Sale_Name:Sale_Name!
        , Sale_phone:Sale_phone!
        , Sale_mail:Sale_mail!
        , is_rightphone:is_rightphone!)
     }
    
}
