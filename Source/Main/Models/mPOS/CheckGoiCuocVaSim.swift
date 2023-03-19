//
//  CheckGoiCuocVaSim.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class CheckGoiCuocVaSim: NSObject {
    var Result:Int
    var Message:String
    
    init(Result:Int
        , Message:String){
        self.Result = Result
        self.Message = Message
    }
    class func parseObjfromArray(array:[JSON])->[CheckGoiCuocVaSim]{
        var list:[CheckGoiCuocVaSim] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> CheckGoiCuocVaSim{
        var Result = data["Result"].int
        var Message = data["Message"].string
        Result = Result == nil ? 0 : Result
        Message = Message == nil ? "" : Message
        return CheckGoiCuocVaSim(Result:Result!,Message:Message!)
    }
}

