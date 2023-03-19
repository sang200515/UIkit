//
//  VendorInstallment.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/31/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class VendorInstallment: NSObject {
    
    var CardCode: Int
    var CardName: String
    var U_SigName: String
    
    init(CardCode: Int,CardName: String,U_SigName: String){
        self.CardCode = CardCode
        self.CardName = CardName
        self.U_SigName = U_SigName
    }
    class func parseObjfromArray(array:[JSON])->[VendorInstallment]{
        var list:[VendorInstallment] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> VendorInstallment{
        
        var cardCode = data["CardCode"].int
        var cardName = data["CardName"].string
        var u_SigName = data["U_SigName"].string
        
        cardCode = cardCode == nil ? 0 : cardCode
        cardName = cardName == nil ? "" : cardName
        u_SigName = u_SigName == nil ? "" : u_SigName
        
        return VendorInstallment(CardCode: cardCode!,CardName: cardName!,U_SigName: u_SigName!)
    }
    
}

