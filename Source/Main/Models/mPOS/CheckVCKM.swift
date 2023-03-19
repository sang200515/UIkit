//
//  CheckVCKM.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/5/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
import Foundation
import SwiftyJSON
class CheckVCKM: NSObject{
    var p_status:String
    init(p_status:String){
        self.p_status = p_status
    }
    class func parseObjfromArray(array:[JSON])->[CheckVCKM]{
        var list:[CheckVCKM] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> CheckVCKM{
        var p_status = data["p_status"].string
        p_status = p_status == nil ? "" : p_status
        return CheckVCKM(p_status:p_status!)
    }
}
