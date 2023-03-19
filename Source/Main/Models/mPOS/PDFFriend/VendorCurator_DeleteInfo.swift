//
//  VendorCurator_DeleteInfo.swift
//  fptshop
//
//  Created by tan on 1/12/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class VendorCurator_DeleteInfo: NSObject {
    var Result:Int
    var Message:String
    
    init(    Result:Int
    , Message:String){
        self.Result = Result
        self.Message = Message
    }
    
    class func parseObjfromArray(array:[JSON])->[VendorCurator_DeleteInfo]{
        var list:[VendorCurator_DeleteInfo] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> VendorCurator_DeleteInfo{
        
        var Result = data["Result"].int
        var Message = data["Message"].string
        
        
        
        
        Result = Result == nil ? 0 : Result
        Message = Message == nil ? "" : Message
        
        
        return VendorCurator_DeleteInfo(Result:Result!
            , Message:Message!)
    }
}
