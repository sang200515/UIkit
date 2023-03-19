//
//  VendorCurator_Saveinfo.swift
//  fptshop
//
//  Created by tan on 1/12/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class VendorCurator_Saveinfo: NSObject {
    var Result:Int
    var Message:String
    
    init(Result:Int
    , Message:String){
        self.Result = Result
        self.Message = Message
    }
    
    class func parseObjfromArray(array:[JSON])->[VendorCurator_Saveinfo]{
        var list:[VendorCurator_Saveinfo] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> VendorCurator_Saveinfo{
        
        var Result = data["Result"].int
        var Message = data["Message"].string
        
        
        
        
        Result = Result == nil ? 0 : Result
        Message = Message == nil ? "" : Message
        
        
        return VendorCurator_Saveinfo(Result:Result!
            , Message:Message!)
    }
    
}
