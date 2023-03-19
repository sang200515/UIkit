//
//  CreateObjectResponse.swift
//  fptshop
//
//  Created by Apple on 6/17/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class CreateObjectResponse: NSObject {
    
    let Result: Int
    let Message: String
    
    init(Result: Int, Message: String) {
        self.Result = Result
        self.Message = Message
    }
    
    class func parseObjfromArray(array:[JSON])->[CreateObjectResponse]{
        var list:[CreateObjectResponse] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> CreateObjectResponse{
        var Result = data["Result"].int
        var Message = data["Message"].string
        
        Result = Result == nil ? 0 : Result
        Message = Message == nil ? "" : Message
        
        
        return CreateObjectResponse(Result: Result!, Message: Message!)
    }
}
