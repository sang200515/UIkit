//
//  SimpleResponse1.swift
//  fptshop
//
//  Created by Apple on 8/15/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class SimpleResponse1: NSObject {
    
    let p_messages: String
    let p_status: Int
    
    init(p_status: Int, p_messages: String) {
        
        self.p_status = p_status
        self.p_messages = p_messages
    }
    
    class func parseObjfromArray(array:[JSON])->[SimpleResponse1]{
        var list:[SimpleResponse1] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> SimpleResponse1 {
        
        var p_status = data["p_status"].int
        var p_messages = data["p_messages"].string
        
        p_status = p_status == nil ? 0 : p_status
        p_messages = p_messages == nil ? "" : p_messages
        return SimpleResponse1(p_status:p_status!, p_messages:p_messages!)
    }
}
