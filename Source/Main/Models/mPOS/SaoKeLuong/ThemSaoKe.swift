//
//  ThemSaoKe.swift
//  fptshop
//
//  Created by tan on 4/11/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ThemSaoKe: NSObject {
    var Result:Int
    var Message:String
    
    init(Result:Int
    , Message:String){
        self.Result = Result
        self.Message = Message
    }
    
    class func parseObjfromArray(array:[JSON])->[ThemSaoKe]{
        var list:[ThemSaoKe] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ThemSaoKe{
        
        var Result = data["Result"].int
    
        var Message  = data["Message"].string

        
        
        
        Result = Result == nil ? 0 : Result

        Message = Message == nil ? "" :Message


        return ThemSaoKe(Result: Result!, Message: Message!)
    }
}
