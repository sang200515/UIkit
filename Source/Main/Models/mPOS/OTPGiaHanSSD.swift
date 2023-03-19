//
//  OTPGiaHanSSD.swift
//  mPOS
//
//  Created by tan on 10/4/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class OTPGiaHanSSD:NSObject{
    var Isdn:String
    var Token:String
    var Status:String
    
    init(Isdn:String
        , Token:String
        , Status:String){
        self.Isdn = Isdn
        self.Token = Token
        self.Status = Status
    }
    
    class func parseObjfromArray(array:[JSON])->[OTPGiaHanSSD]{
        var list:[OTPGiaHanSSD] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    class func getObjFromDictionary(data:JSON) -> OTPGiaHanSSD{
        var Isdn = data["Isdn"].string
        var Token = data["Token"].string
        var Status = data["Status"].string
        
        Isdn = Isdn == nil ? "" : Isdn
        Token = Token == nil ? "" : Token
        Status = Status == nil ? "" : Status
        return OTPGiaHanSSD(Isdn:Isdn!
            , Token:Token!
            , Status:Status!)
    }
}
