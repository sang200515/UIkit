//
//  CompanyAmortization.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class CompanyAmortization: NSObject {
    var ComCode: Int
    var ComName: String
    var Status: String
    init(ComCode:Int,ComName:String,Status:String) {
        self.ComCode = ComCode
        self.ComName = ComName
        self.Status = Status
    }
    class func parseObjfromArray(array:[JSON])->[CompanyAmortization]{
        var list:[CompanyAmortization] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> CompanyAmortization{
        
        var comCode = data["ComCode"].int
        var comName = data["ComName"].string
        var status = data["Status"].string
        
        comCode = comCode == nil ? 0 : comCode
        comName = comName == nil ? "" : comName
        status = status == nil ? "" : status
        
        return CompanyAmortization(ComCode:comCode!,ComName:comName!,Status:status!)
    }
}

