//
//  PayooPayCodeHeaderResult.swift
//  mPOS
//
//  Created by sumi on 7/5/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class PayooPayCodeHeaderResult: NSObject {
    
    var Tu_ngay : String
    var Den_Ngay: String
    var u_Vchname : String
    var u_vocher: String
    
    init(Tu_ngay: String, Den_Ngay: String, u_Vchname : String, u_vocher:String){
        self.Tu_ngay = Tu_ngay
        self.Den_Ngay = Den_Ngay
        self.u_Vchname = u_Vchname
        self.u_vocher = u_vocher
    }
    class func parseObjfromArray(array:[JSON])->[PayooPayCodeHeaderResult]{
        var list:[PayooPayCodeHeaderResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> PayooPayCodeHeaderResult{
        var Tu_ngay = data["Tu_ngay"].string
        var Den_Ngay = data["Den_Ngay"].string
        var u_Vchname = data["u_Vchname"].string
        var u_vocher = data["u_vocher"].string
        
        Tu_ngay = Tu_ngay == nil ? "" : Tu_ngay
        Den_Ngay = Den_Ngay == nil ? "" : Den_Ngay
        u_Vchname = u_Vchname == nil ? "" : u_Vchname
        u_vocher = u_vocher == nil ? "" : u_vocher
        
        return PayooPayCodeHeaderResult(Tu_ngay: Tu_ngay!, Den_Ngay: Den_Ngay!, u_Vchname : u_Vchname!, u_vocher:u_vocher!)
        
    }
}

