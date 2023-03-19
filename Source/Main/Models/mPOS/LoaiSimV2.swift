//
//  LoaiSimV2.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/31/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class LoaiSimV2: NSObject{
    var ID:Int
    var TypeName:String
    
    init(ID:Int,TypeName:String){
        self.ID = ID
        self.TypeName = TypeName
    }
    class func parseObjfromArray(array:[JSON])->[LoaiSimV2]{
        var list:[LoaiSimV2] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> LoaiSimV2{
        var ID = data["ID"].int
        var TypeName = data["TypeName"].string
        ID = ID == nil ? 0 : ID
        TypeName = TypeName == nil ? "" : TypeName
        return LoaiSimV2(ID:ID!,TypeName:TypeName!)
    }
}

