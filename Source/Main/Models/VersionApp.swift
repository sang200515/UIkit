//
//  VersionApp.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 1/2/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class VersionApp: NSObject {
    let TypeSys: Int
    let SysName: String
    let Version: String
    let is_getaway: Int
    
    init(TypeSys: Int, SysName: String, Version: String, is_getaway: Int){
        self.TypeSys = TypeSys
        self.SysName = SysName
        self.Version = Version
        self.is_getaway = is_getaway
    }
    class func getObjFromDictionary(data:JSON) -> VersionApp{
        
        var TypeSys = data["TypeSys"].int
        var SysName = data["SysName"].string
        var Version = data["Version"].string
        var is_getaway = data["is_getaway"].int
        
        TypeSys = TypeSys == nil ? 0 : TypeSys
        SysName = SysName == nil ? "" : SysName
        Version = Version == nil ? "" : Version
        is_getaway = is_getaway == nil ? 1 : is_getaway
 
        return VersionApp(TypeSys: TypeSys!, SysName: SysName!, Version: Version!,is_getaway:is_getaway!)
    }
    class func parseObjfromArray(array:[JSON])->[VersionApp]{
        var list:[VersionApp] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
}


