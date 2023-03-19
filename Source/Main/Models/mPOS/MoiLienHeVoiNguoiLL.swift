//
//  MoiLienHeVoiNguoiLL.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/13/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class MoiLienHeVoiNguoiLL: NSObject {
    
    var Code: String
    var Name: String
    
    
    init(Code: String, Name: String){
        self.Code = Code
        self.Name = Name
    }
    class func parseObjfromArray(array:[JSON])->[MoiLienHeVoiNguoiLL]{
        var list:[MoiLienHeVoiNguoiLL] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> MoiLienHeVoiNguoiLL{
        
        var code = data["Code"].string
        var name = data["Name"].string
        
        code = code == nil ? "" : code
        name = name == nil ? "" : name
        
        return MoiLienHeVoiNguoiLL(Code: code!, Name: name!)
    }
    
}

