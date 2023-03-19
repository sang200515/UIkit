//
//  ReasonCodes.swift
//  fptshop
//
//  Created by Apple on 4/16/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"Code": "DSTT_ESIM",
//"Name": "Thay esim sang esim",
//"is_esim": "Y"

import UIKit
import SwiftyJSON

class ReasonCodes: NSObject {

    let Code: String
    let Name: String
    let is_esim: String
    
    
    init(Code: String, Name: String, is_esim: String) {
        self.Code = Code
        self.Name = Name
        self.is_esim = is_esim
    }
    
    class func parseObjfromArray(array:[JSON])->[ReasonCodes]{
        var list:[ReasonCodes] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ReasonCodes{
        var Code = data["Code"].string
        var Name = data["Name"].string
        var is_esim = data["is_esim"].string
        
        Code = Code == nil ? "" : Code
        Name = Name == nil ? "" : Name
        is_esim = is_esim == nil ? "" : is_esim
        
        
        return ReasonCodes(Code: Code!, Name: Name!, is_esim: is_esim!)
    }
}
