//
//  OTPRequestConvertData2.swift
//  mPOS
//
//  Created by tan on 7/9/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class OTPRequestConvertData2: NSObject{
    var isdn:String
    var status:String
    
    init(isdn:String,status:String){
        self.isdn = isdn
        self.status = status
    }
    class func getObjFromDictionary(data:JSON) -> OTPRequestConvertData2{
        var isdn = data["isdn"].string
        var status = data["status"].string
        
        isdn = isdn == nil ? "" : isdn
        status = status == nil ? "" : status
        
        return OTPRequestConvertData2(isdn: isdn!, status: status!)
    }
}

