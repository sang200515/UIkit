//
//  SimpleResponse.swift
//  CheckIn
//
//  Created by Apple on 1/20/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import SwiftyJSON

class SimpleResponse: NSObject {
    let Code: String
    let mdata: String
    let Detail: String
    
    init(Code: String, mdata: String, Detail: String) {
        self.Code = Code
        self.mdata = mdata
        self.Detail = Detail
    }
    
    class func getObjFromDictionary(data:JSON) -> SimpleResponse{
        var Code = data["Code"].string
        var mdata = data["Data"].string
        var Detail = data["Detail"].string
        
        Code = Code == nil ? "" : Code
        mdata = mdata == nil ? "" : mdata
        Detail = Detail == nil ? "" : Detail
        return SimpleResponse(Code: Code!, mdata: mdata ?? mdata!, Detail: Detail!)
    }
}
