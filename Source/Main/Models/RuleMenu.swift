//
//  RuleMenu.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 1/3/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class RuleMenu: NSObject {
    let p_status: Int
    let p_messagess: String

    init(p_status: Int, p_messagess: String){
        self.p_status = p_status
        self.p_messagess = p_messagess
    }
    class func getObjFromDictionary(data:JSON) -> RuleMenu{
        
        var p_status = data["p_status"].int
        var p_messagess = data["p_messagess"].string
        
        p_status = p_status == nil ? 0 : p_status
        p_messagess = p_messagess == nil ? "" : p_messagess
        
        return RuleMenu(p_status: p_status!, p_messagess: p_messagess!)
    }
    class func parseObjfromArray(array:[JSON])->[RuleMenu]{
        var list:[RuleMenu] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
}


