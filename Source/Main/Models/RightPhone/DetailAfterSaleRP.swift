//
//  DetailAfterSaleRP.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/18/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class DetailAfterSaleRP: NSObject {
    var docentry:String
      var KhacShop:String
      var IMEI:String
      var manufacturer:String
      var memory:String
      var color:String
      var Sale_price:Float
      var NgayDang:String
      var Sale_Name:String
      var Sale_mail:String
      var Sale_phone:String
      var Buy_Name:String
      var Buy_mail:String
      var Buy_phone:String
      var Buy_invoice_SKTel:String
      var buy_date:String
      var NgayDenShop:String
      var Note:String
      var Sotiencoc:Float
      var SoTienConLai:Float
    
    
    init(docentry:String
      , KhacShop:String
      , IMEI:String
      , manufacturer:String
      , memory:String
      , color:String
      , Sale_price:Float
      , NgayDang:String
      , Sale_Name:String
      , Sale_mail:String
      , Sale_phone:String
      , Buy_Name:String
      , Buy_mail:String
      , Buy_phone:String
      , Buy_invoice_SKTel:String
      , buy_date:String
      , NgayDenShop:String
      , Note:String
      , Sotiencoc:Float
      , SoTienConLai:Float){
        self.docentry = docentry
        self.KhacShop = KhacShop
        self.IMEI = IMEI
        self.manufacturer = manufacturer
        self.memory = memory
        self.color = color
        self.Sale_price = Sale_price
        self.NgayDang = NgayDang
        self.Sale_Name = Sale_Name
        self.Sale_mail = Sale_mail
        self.Sale_phone = Sale_phone
        self.Buy_Name = Buy_Name
        self.Buy_mail = Buy_mail
        self.Buy_phone = Buy_phone
        self.Buy_invoice_SKTel = Buy_invoice_SKTel
        self.buy_date = buy_date
        self.NgayDenShop = NgayDenShop
        self.Note = Note
        self.Sotiencoc = Sotiencoc
        self.SoTienConLai = SoTienConLai
  
    }
    
    
    class func parseObjfromArray(array:[JSON])->[DetailAfterSaleRP]{
             var list:[DetailAfterSaleRP] = []
             for item in array {
                 list.append(self.getObjFromDictionary(data: item))
             }
             return list
         }
         
         class func getObjFromDictionary(data:JSON) -> DetailAfterSaleRP{
             var docentry = data["docentry"].string
            var KhacShop = data["KhacShop"].string
            var IMEI = data["IMEI"].string
            var manufacturer = data["manufacturer"].string
            var memory = data["memory"].string
            var color = data["color"].string
            var Sale_price = data["Sale_price"].float
            var NgayDang = data["NgayDang"].string
            var Sale_Name = data["Sale_Name"].string
            
            var Sale_mail = data["Sale_mail"].string
            var Sale_phone = data["Sale_phone"].string
            var Buy_Name = data["Buy_Name"].string
            var Buy_mail = data["Buy_mail"].string
            var Buy_phone = data["Buy_phone"].string
            var Buy_invoice_SKTel = data["Buy_invoice_SKTel"].string
            var buy_date = data["buy_date"].string
            var NgayDenShop = data["NgayDenShop"].string
            var Note = data["Note"].string
            var Sotiencoc = data["Sotiencoc"].float
            var SoTienConLai = data["SoTienConLai"].float
   
             
             docentry = docentry == nil ? "" : docentry
            KhacShop = KhacShop == nil ? "" : KhacShop
            IMEI = IMEI == nil ? "" : IMEI
            manufacturer = manufacturer == nil ? "" : manufacturer
            memory = memory == nil ? "" : memory
            color = color == nil ? "" : color
            Sale_price = Sale_price == nil ? 0 : Sale_price
            NgayDang = NgayDang == nil ? "" : NgayDang
            Sale_Name = Sale_Name == nil ? "" : Sale_Name
            Sale_mail = Sale_mail == nil ? "" : Sale_mail
            Sale_phone = Sale_phone == nil ? "" : Sale_phone
            Buy_Name = Buy_Name == nil ? "" : Buy_Name
            Buy_mail = Buy_mail == nil ? "" : Buy_mail
            Buy_phone = Buy_phone == nil ? "" : Buy_phone
            Buy_invoice_SKTel = Buy_invoice_SKTel == nil ? "" : Buy_invoice_SKTel
            buy_date = buy_date == nil ? "" : buy_date
            NgayDenShop = NgayDenShop == nil ? "" : NgayDenShop
            Note = Note == nil ? "" : Note
            Sotiencoc = Sotiencoc == nil ? 0 :Sotiencoc
            SoTienConLai = SoTienConLai == nil ? 0 : SoTienConLai
            
             return DetailAfterSaleRP(docentry:docentry!
             , KhacShop:KhacShop!
             , IMEI:IMEI!
             , manufacturer:manufacturer!
             , memory:memory!
             , color:color!
             , Sale_price:Sale_price!
             , NgayDang:NgayDang!
             , Sale_Name:Sale_Name!
             , Sale_mail:Sale_mail!
             , Sale_phone:Sale_phone!
             , Buy_Name:Buy_Name!
             , Buy_mail:Buy_mail!
             , Buy_phone:Buy_phone!
             , Buy_invoice_SKTel:Buy_invoice_SKTel!
             , buy_date:buy_date!
             , NgayDenShop:NgayDenShop!
             , Note:Note!
             , Sotiencoc:Sotiencoc!
             , SoTienConLai:SoTienConLai!)
         }
    
}
