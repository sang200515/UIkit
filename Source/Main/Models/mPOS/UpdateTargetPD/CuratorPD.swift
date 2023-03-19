//
//  CuratorPD.swift
//  fptshop
//
//  Created by tan on 2/25/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class CuratorPD: NSObject {
    var CuratorCode:String
    var CuratorName:String
    
    init(  CuratorCode:String
    , CuratorName:String){
        self.CuratorCode = CuratorCode
        self.CuratorName = CuratorName
    }
    
    class func parseObjfromArray(array:[JSON])->[CuratorPD]{
        var list:[CuratorPD] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> CuratorPD{
        
        var CuratorCode = data["CuratorCode"].string
        var CuratorName = data["CuratorName"].string
  
        
        CuratorCode = CuratorCode == nil ? "" : CuratorCode
        CuratorName = CuratorName == nil ? "" : CuratorName
   
        
        return CuratorPD(CuratorCode: CuratorCode!, CuratorName: CuratorName!)
    }
}
