//
//  UploadImageScoringResult.swift
//  fptshop
//
//  Created by tan on 4/17/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class UploadImageScoringResult: NSObject {
    var Result:Int
    var IDImageXN:Int
    var Message:String
    
    init(Result:Int
    , IDImageXN:Int
    , Message:String){
        self.Result = Result
        self.IDImageXN = IDImageXN
        self.Message = Message
    }
    
    class func parseObjfromArray(array:[JSON])->[UploadImageScoringResult]{
        var list:[UploadImageScoringResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> UploadImageScoringResult{
        
        var Result = data["Result"].int
        var IDImageXN = data["IDImageXNLog"].int
        var Message = data["Message"].string

        Result = Result == nil ? 0 : Result
        IDImageXN = IDImageXN == nil ? 0 : IDImageXN
        Message = Message == nil ? "" : Message

        return UploadImageScoringResult(Result: Result!,IDImageXN:IDImageXN!, Message: Message!)
    }
}
