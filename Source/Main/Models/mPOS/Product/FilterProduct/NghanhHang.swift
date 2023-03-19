//
//  NghanhHang.swift
//  fptshop
//
//  Created by Ngo Dang tan on 8/24/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class NghanhHang: NSObject {
    var u_ng_name:String
    var u_ng_code:String
    
    init(u_ng_name:String,u_ng_code:String){
        self.u_ng_name = u_ng_name
        self.u_ng_code = u_ng_code
    }
    
    class func getObjFromDictionary(data:JSON) -> NghanhHang{
        
        var u_ng_name = data["u_ng_name"].string
        var u_ng_code = data["u_ng_code"].string
        
        
        u_ng_name = u_ng_name == nil ? "" : u_ng_name
        u_ng_code = u_ng_code == nil ? "" : u_ng_code
        
        
        return NghanhHang(u_ng_name:u_ng_name!
            , u_ng_code:u_ng_code!)
    }
    class func parseObjfromArray(array:[JSON])->[NghanhHang]{
        var list:[NghanhHang] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
}
