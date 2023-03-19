//
//  ReasonCancelMirae.swift
//  fptshop
//
//  Created by tan on 7/12/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ReasonCancelMirae: NSObject {
    var ID:Int
    var Name:String
    
    init(   ID:Int
    , Name:String){
        self.ID = ID
        self.Name = Name
    }
    
    class func parseObjfromArray(array:[JSON])->[ReasonCancelMirae]{
        var list:[ReasonCancelMirae] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ReasonCancelMirae{
        
        var ID = data["ID"].int
        var Name = data["Name"].string
        
        
        ID = ID == nil ? 0 : ID
        Name = Name == nil ? "" : Name
        
        return ReasonCancelMirae(ID:ID!
            , Name:Name!
        )
    }
}
