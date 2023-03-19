//
//  SODetailMirae.swift
//  fptshop
//
//  Created by tan on 6/8/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class SODetailMirae: NSObject {
    var Quantity:Int
    var Price:Int
    var Quantity1:Int
    var Dscription:String
    var U_Imei:String
    var ItemCode:String
    var U_PROMOS:String
    
    init( Quantity:Int
        , Price:Int
        , Quantity1:Int
        , Dscription:String
        , U_Imei:String
        , ItemCode:String
        , U_PROMOS:String){
        self.Quantity = Quantity
        self.Price = Price
        self.Quantity1 = Quantity1
        self.Dscription = Dscription
        self.U_Imei =  U_Imei
        self.ItemCode = ItemCode
        self.U_PROMOS = U_PROMOS
    }
    
    class func parseObjfromArray(array:[JSON])->[SODetailMirae]{
        var list:[SODetailMirae] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> SODetailMirae{
        
        var Quantity = data["Quantity"].int
        var Price = data["Price"].int
        var Quantity1 = data["Quantity1"].int
        
        var Dscription = data["Dscription"].string
        var U_Imei = data["U_Imei"].string
        var ItemCode = data["ItemCode"].string
        var U_PROMOS = data["U_PROMOS"].string
        
        Quantity = Quantity == nil ? 0 : Quantity
        Price = Price == nil ? 0 : Price
        Quantity1 = Quantity1 == nil ? 0 : Quantity1
        
        Dscription = Dscription == nil ? "" : Dscription
        U_Imei = U_Imei == nil ? "" : U_Imei
        ItemCode = ItemCode == nil ? "" : ItemCode
        U_PROMOS = U_PROMOS == nil ? "" : U_PROMOS
        
        return SODetailMirae( Quantity:Quantity!
            , Price:Price!
            , Quantity1:Quantity1!
            , Dscription:Dscription!
            , U_Imei:U_Imei!
            , ItemCode:ItemCode!
            , U_PROMOS:U_PROMOS!
        )
    }
    
}
