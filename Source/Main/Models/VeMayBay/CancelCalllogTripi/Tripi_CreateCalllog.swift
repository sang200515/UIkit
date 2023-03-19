//
//  Tripi_CreateCalllog.swift
//  fptshop
//
//  Created by DiemMy Le on 1/10/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"Result": 1,
//"Message": "Đã tạo yêu cầu trao đổi với Tripi thành công, mã CL: 329758",
//"RequestID": 329758

import UIKit
import SwiftyJSON

class Tripi_CreateCalllog: NSObject {
    let Result: Int
    let Message: String
    let RequestID: Int
    
    init(Result: Int, Message: String, RequestID: Int) {
        self.Result = Result
        self.Message = Message
        self.RequestID = RequestID
    }
    
    class func parseObjfromArray(array:[JSON])->[Tripi_CreateCalllog]{
        var list:[Tripi_CreateCalllog] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> Tripi_CreateCalllog {
        var Result = data["Result"].int
        var Message = data["Message"].string
        var RequestID = data["RequestID"].int
        
        Result = Result == nil ? 0 : Result
        Message = Message == nil ? "" : Message
        RequestID = RequestID == nil ? 0 : RequestID
        
        return Tripi_CreateCalllog(Result: Result!, Message: Message!, RequestID: RequestID!)
    }
}
