//
//  SoPhoneNumberDetailSP.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 3/7/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class SoPhoneNumberDetailSP:NSObject{
    
    var ItemCode:String
    var Dscription:String
    var Quantity:Int
    var U_Imei:String
    
    init(ItemCode:String, Dscription:String, Quantity:Int, U_Imei:String){
        self.ItemCode = ItemCode
        self.Dscription = Dscription
        self.Quantity = Quantity
        self.U_Imei = U_Imei
    }
    
    class func parseObjfromArray(array:[JSON])->[SoPhoneNumberDetailSP]{
        var list:[SoPhoneNumberDetailSP] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }

    class func getObjFromDictionary(data:JSON) -> SoPhoneNumberDetailSP{
        var ItemCode = data["ItemCode"].string
        var Dscription = data["Dscription"].string
        var Quantity = data["Quantity"].int
        var U_Imei = data["U_Imei"].string
        
        ItemCode = ItemCode == nil ? "" : ItemCode
        Dscription = Dscription == nil ? "" : Dscription
        Quantity = Quantity == nil ? 0 : Quantity
        U_Imei = U_Imei == nil ? "" : U_Imei
        
        return SoPhoneNumberDetailSP(ItemCode:ItemCode!, Dscription:Dscription!, Quantity:Quantity!, U_Imei:U_Imei!)
    }
    
    
}
