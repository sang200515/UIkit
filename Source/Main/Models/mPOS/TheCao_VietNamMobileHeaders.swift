//
//  TheCao_VietNamMobileHeaders.swift
//  mPOS
//
//  Created by sumi on 8/3/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class TheCao_VietNamMobileHeaders: NSObject {
    
    var Den_Ngay: String
    var Message: String
    var Success: String
    var Tu_ngay: String
    var u_Vchname: String
    var u_vocher: String
    
    init(Den_Ngay: String, Message: String, Success: String, Tu_ngay: String, u_Vchname: String, u_vocher: String){
        self.Den_Ngay = Den_Ngay
        self.Message = Message
        self.Success = Success
        self.Tu_ngay = Tu_ngay
        self.u_Vchname = u_Vchname
        self.u_vocher = u_vocher
    }
    class func parseObjfromArray(array:[JSON])->[TheCao_VietNamMobileHeaders]{
        var list:[TheCao_VietNamMobileHeaders] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> TheCao_VietNamMobileHeaders{
        var Den_Ngay = data["Den_Ngay"].string
        var Message = data["Message"].string
        var Success = data["Success"].string
        var Tu_ngay = data["Tu_ngay"].string
        var u_Vchname = data["u_Vchname"].string
        var u_vocher = data["u_vocher"].string
        
        Den_Ngay = Den_Ngay == nil ? "" : Den_Ngay
        Message = Message == nil ? "" : Message
        Success = Success == nil ? "" : Success
        Tu_ngay = Tu_ngay == nil ? "" : Tu_ngay
        u_Vchname = u_Vchname == nil ? "" : u_Vchname
        u_vocher = u_vocher == nil ? "" : u_vocher
        
        return TheCao_VietNamMobileHeaders(Den_Ngay: Den_Ngay!, Message: Message!, Success: Success!, Tu_ngay: Tu_ngay!, u_Vchname: u_Vchname!, u_vocher: u_vocher!)
        
    }
}

