//
//  VendorCuratorGetCurator.swift
//  fptshop
//
//  Created by tan on 1/11/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class VendorCuratorGetCurator:NSObject{
    var CuratorCode:String
    var CuratorName:String
    var CuratorCodeName:String
    var CuratorEmail:String
    var CuratorPhone:String
    
    init(CuratorCode:String
    , CuratorName:String
    , CuratorCodeName:String
    , CuratorEmail:String
    , CuratorPhone:String){
        self.CuratorCode = CuratorCode
        self.CuratorName = CuratorName
        self.CuratorCodeName = CuratorCodeName
        self.CuratorEmail = CuratorEmail
        self.CuratorPhone = CuratorPhone
    }
    
    class func parseObjfromArray(array:[JSON])->[VendorCuratorGetCurator]{
        var list:[VendorCuratorGetCurator] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> VendorCuratorGetCurator{
        
        var CuratorCode = data["CuratorCode"].string
        var CuratorName = data["CuratorName"].string
        var CuratorCodeName = data["CuratorCodeName"].string
        var CuratorEmail = data["CuratorEmail"].string
        var CuratorPhone = data["CuratorPhone"].string
        
        
        
        
        CuratorCode = CuratorCode == nil ? "" : CuratorCode
        CuratorName = CuratorName == nil ? "" : CuratorName
        CuratorCodeName = CuratorCodeName == nil ? "" : CuratorCodeName
        CuratorEmail = CuratorEmail == nil ? "" : CuratorEmail
        CuratorPhone = CuratorPhone == nil ? "" : CuratorPhone
        
        
        return VendorCuratorGetCurator(CuratorCode:CuratorCode!
            , CuratorName:CuratorName!,CuratorCodeName:CuratorCodeName!,CuratorEmail:CuratorEmail!,CuratorPhone:CuratorPhone!)
    }
    
    
}
