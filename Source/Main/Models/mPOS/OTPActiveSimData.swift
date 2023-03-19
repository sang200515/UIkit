//
//  OTPActiveSimData.swift
//  mPOS
//
//  Created by tan on 6/4/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class OTPActiveSimData: NSObject {
    var status:String
    var isdn:String
    
    init(isdn:String,status:String){
        
        self.isdn = isdn
        self.status = status
        
    }
    
    class func getObjFromDictionary(data:JSON) -> OTPActiveSimData{
        var isdn = data["isdn"].string
        var status = data["status"].string
        isdn = isdn == nil ? "": isdn
        status = status == nil ? "" : status
        
        return OTPActiveSimData(isdn: isdn!, status: status!)
    }
}

