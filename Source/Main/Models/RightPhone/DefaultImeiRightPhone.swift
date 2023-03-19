//
//  DefaultImeiRightPhone.swift
//  fptshop
//
//  Created by Ngo Dang tan on 5/6/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
//"phone_pet_name" : "Galaxy J7 Prime",
//"phone_manufacturer" : "Samsung",
//"seller_email" : "15520953@gm.uit.edu.vn",
//"seller_phone" : "0123456789",
//"seller_name" : "Pham Nhat Truong",
//"phone_color" : "WHITE",
//"self_price" : 847000,
//"imei" : "012956619778185",
//"phone_memory" : "32GB"
class DefaultImeiRightPhone: NSObject {
    var imei:String
    var phone_manufacturer:String
    var phone_pet_name:String
    var phone_memory:String
    var phone_color:String
    var self_price:Float
    var seller_email:String
    var seller_phone:String
    var seller_name:String
    
    
    init(   imei:String
      , phone_manufacturer:String
      , phone_pet_name:String
      , phone_memory:String
      , phone_color:String
        , self_price:Float
        ,seller_email:String
        ,seller_phone:String
        ,seller_name:String){
        self.imei = imei
        self.phone_manufacturer = phone_manufacturer
        self.phone_pet_name = phone_pet_name
        self.phone_memory = phone_memory
        self.phone_color = phone_color
        self.self_price = self_price
        self.seller_email = seller_email
        self.seller_phone = seller_phone
        self.seller_name = seller_name
    }
    
    class func parseObjfromArray(array:[JSON])->[DefaultImeiRightPhone]{
          var list:[DefaultImeiRightPhone] = []
          for item in array {
              list.append(self.getObjFromDictionary(data: item))
          }
          return list
      }
      
      class func getObjFromDictionary(data:JSON) -> DefaultImeiRightPhone{
        
        var imei = data["imei"].string
        var phone_manufacturer = data["phone_manufacturer"].string
        var phone_pet_name = data["phone_pet_name"].string
        var phone_memory = data["phone_memory"].string
        var phone_color = data["phone_color"].string
        var self_price = data["self_price"].float
        var seller_email = data["seller_email"].string
        var seller_phone = data["seller_phone"].string
        var seller_name = data["seller_name"].string
        
          
          
          
          imei = imei == nil ? "" : imei
          phone_manufacturer = phone_manufacturer == nil ? "" : phone_manufacturer
          phone_pet_name = phone_pet_name == nil ? "" : phone_pet_name
        phone_memory = phone_memory == nil ? "" : phone_memory
        phone_color = phone_color == nil ? "" : phone_color
          self_price = self_price == nil ? 0 : self_price
        seller_email = seller_email == nil ? "" : seller_email
        seller_phone = seller_phone == nil ? "" : seller_phone
        seller_name = seller_name == nil ? "" : seller_name
          
          
          return DefaultImeiRightPhone(imei:imei!
          , phone_manufacturer:phone_manufacturer!
          , phone_pet_name:phone_pet_name!
          , phone_memory:phone_memory!
          , phone_color:phone_color!
            , self_price:self_price!
            ,seller_email:seller_email!
            ,seller_phone:seller_phone!
            ,seller_name:seller_name!
          )
      }
}
