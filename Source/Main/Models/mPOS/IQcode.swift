//
//  IQcode.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 7/8/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class IQcode:NSObject{
    
    var p_sotien:Int
    var p_status:Int
    var p_messagess:String
    
    init(p_sotien:Int, p_status:Int, p_messagess:String){
        self.p_sotien = p_sotien
        self.p_status = p_status
        self.p_messagess = p_messagess
    }
    
    class func parseObjfromArray(array:[JSON])->[IQcode]{
        var list:[IQcode] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> IQcode{
        var p_sotien = data["p_sotien"].int
        var p_status = data["p_status"].int
        var p_messagess = data["p_messagess"].string
        
        p_sotien = p_sotien == nil ? 0 : p_sotien
        p_status = p_status == nil ? 0 : p_status
        p_messagess = p_messagess == nil ? "" : p_messagess
        
        return IQcode(p_sotien:p_sotien!, p_status:p_status!, p_messagess:p_messagess!)
    }
    
    
}
