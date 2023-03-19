//
//  BaoHiem_GetTokenResult.swift
//  mPOS
//
//  Created by sumi on 7/31/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaoHiem_GetTokenResult: NSObject {
    
    var Result: String
    var Message: String
    var Code: String
    var Loai: String

    init(Result: String, Message: String, Code: String, Loai: String){
        self.Result = Result
        self.Message = Message
        self.Code = Code
        self.Loai = Loai
    }
    
    class func parseObjfromArray(array:[JSON])->[BaoHiem_GetTokenResult]{
        var list:[BaoHiem_GetTokenResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> BaoHiem_GetTokenResult{
        var Result = data["Result"].string
        var Message = data["Message"].string
        var Code = data["Code"].string
        var Loai = data["Loai"].string
        
        Result = Result == nil ? "": Result
        Message = Message == nil ? "" : Message
        Code = Code == nil ? "" : Code
        Loai = Loai == nil ? "": Loai
        
        return BaoHiem_GetTokenResult(Result: Result!, Message: Message!, Code: Code!, Loai: Loai!)
    }
}
