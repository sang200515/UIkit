//
//  infoCurator.swift
//  fptshop
//
//  Created by tan on 1/11/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class InfoCurator: NSObject {
    var ID:Int
    var VendorCode:Int
    var VendorName:String
    var CuratorCode:String
    var CuratorName:String
    var Head_PDCode:String
    var Head_PDName:String
    
    init(ID:Int
    , VendorCode:Int
    , VendorName:String
    , CuratorCode:String
    , CuratorName:String
    , Head_PDCode:String
    , Head_PDName:String){
        
        self.ID = ID
        self.VendorCode = VendorCode
        self.VendorName = VendorName
        self.CuratorCode = CuratorCode
        self.CuratorName  = CuratorName
        self.Head_PDCode = Head_PDCode
        self.Head_PDName = Head_PDName
    }
    
    class func parseObjfromArray(array:[JSON])->[InfoCurator]{
        var list:[InfoCurator] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> InfoCurator{
        
        var ID = data["ID"].int
        var VendorCode = data["VendorCode"].int
        var VendorName = data["VendorName"].string
        var CuratorCode = data["CuratorCode"].string
        var CuratorName = data["CuratorName"].string
        var Head_PDCode = data["Head_PDCode"].string
        var Head_PDName = data["Head_PDName"].string
        
        
        
        
        ID = ID == nil ? 0 : ID
        VendorCode = VendorCode == nil ? 0 : VendorCode
        VendorName = VendorName == nil ? "" : VendorName
        CuratorCode = CuratorCode == nil ? "" : CuratorCode
        CuratorName = CuratorName == nil ? "" : CuratorName
        Head_PDCode = Head_PDCode == nil ? "" : Head_PDCode
        Head_PDName = Head_PDName == nil ? "" : Head_PDName
        
        
        return InfoCurator(ID:ID!
            , VendorCode:VendorCode!,VendorName:VendorName!,CuratorCode:CuratorCode!,CuratorName:CuratorName!,Head_PDCode:Head_PDCode!,Head_PDName:Head_PDName!)
    }
    
    
}
