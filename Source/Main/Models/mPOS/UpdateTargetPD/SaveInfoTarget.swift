//
//  SaveInfoTarget.swift
//  fptshop
//
//  Created by tan on 2/25/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class SaveInfoTarget: NSObject {
    var Result:Int
    var Message:String
    
    init(     Result:Int
        , Message:String){
        self.Result = Result
        self.Message = Message
    }
    
    class func parseObjfromArray(array:[JSON])->[SaveInfoTarget]{
        var list:[SaveInfoTarget] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> SaveInfoTarget{
        
        var Result = data["Result"].int
        var Message = data["Message"].string
        
        
        Result = Result == nil ? 0 : Result
        Message = Message == nil ? "" : Message
        
        
        return SaveInfoTarget(Result: Result!, Message: Message!)
    }
}
