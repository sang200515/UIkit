//
//  DueDayMirae.swift
//  fptshop
//
//  Created by tan on 6/3/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class DueDayMirae: NSObject {
    
    var Code:String
    var Name:String
    
    init(    Code:String
    , Name:String){
        self.Code = Code
        self.Name = Name
    }
    
    class func parseObjfromArray(array:[JSON])->[DueDayMirae]{
        var list:[DueDayMirae] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> DueDayMirae{
        
        var Code = data["Code"].string
        var Name = data["Name"].string
    
        
        
        
        Code = Code == nil ? "" : Code
        Name = Name == nil ? "" : Name
   
        
        
        return DueDayMirae(Code:Code!
            , Name:Name!
         
            
        )
    }
}
