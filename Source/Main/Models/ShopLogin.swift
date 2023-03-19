//
//  ShopLogin.swift
//  fptshop
//
//  Created by Ngo Dang tan on 7/9/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ShopLogin: NSObject {
    var ShopCode:String
    var ShopName:String
    var IP:String
    
    init(ShopCode:String
        , ShopName:String
        , IP:String){
        self.ShopCode = ShopCode
        self.ShopName = ShopName
        self.IP = IP
    }
    
    class func parseObjfromArray(array:[JSON])->[ShopLogin]{
        var list:[ShopLogin] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ShopLogin {
        
        var ShopCode = data["ShopCode"].string
        var ShopName = data["ShopName"].string
        var IP = data["IP"].string
        
        ShopCode = ShopCode == nil ? "" : ShopCode
        ShopName = ShopName == nil ? "" : ShopName
        IP = IP == nil ? "" : IP
        return ShopLogin(ShopCode:ShopCode!, ShopName:ShopName!,IP:IP!)
    }
    
    
}
