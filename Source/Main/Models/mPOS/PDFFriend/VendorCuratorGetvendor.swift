//
//  VendorCuratorGetvendor.swift
//  fptshop
//
//  Created by tan on 1/11/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class VendorCuratorGetvendor: NSObject {
    var VendCode:Int
    var VendName:String
    
    
    init(VendCode:Int
    , VendName:String){
        self.VendCode = VendCode
        self.VendName = VendName
        
    }
    class func parseObjfromArray(array:[JSON])->[VendorCuratorGetvendor]{
        var list:[VendorCuratorGetvendor] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> VendorCuratorGetvendor{
      
        var VendCode = data["VendCode"].int
          var VendName = data["VendName"].string
        
        
        
        
        VendCode = VendCode == nil ? 0 : VendCode
        VendName = VendName == nil ? "" : VendName
        
        
        return VendorCuratorGetvendor(VendCode:VendCode!
            , VendName:VendName!)
    }
    
    
}
