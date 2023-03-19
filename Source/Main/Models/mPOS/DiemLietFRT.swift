//
//  DiemLietFRT.swift
//  fptshop
//
//  Created by tan on 4/17/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class DiemLietFRT: NSObject {
    var Result:Int
    var Message:String
    
    init(  Result:Int
    , Message:String){
        self.Result = Result
        self.Message = Message
    }
    
    class func parseObjfromArray(array:[JSON])->[DiemLietFRT]{
        var list:[DiemLietFRT] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> DiemLietFRT{
        
        var Result = data["Result"].int
        var Message = data["Message"].string

        
        
        
        Result = Result == nil ? 0 : Result
        Message = Message == nil ? "" : Message
    
        
        
        
        return DiemLietFRT(Result: Result!, Message: Message!)
    }
}
