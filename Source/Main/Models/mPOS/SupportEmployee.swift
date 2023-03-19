//
//  SupportEmployee.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/7/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class SupportEmployee:NSObject{
    
    var EmployeeCode:String
    var EmployeeName:String
    
    init(EmployeeCode:String, EmployeeName:String){
        self.EmployeeCode = EmployeeCode
        self.EmployeeName = EmployeeName
    }
    
    class func parseObjfromArray(array:[JSON])->[SupportEmployee]{
        var list:[SupportEmployee] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> SupportEmployee{
        var EmployeeCode = data["EmployeeCode"].string
        var EmployeeName = data["EmployeeName"].string
        
        EmployeeCode = EmployeeCode == nil ? "" : EmployeeCode
        EmployeeName = EmployeeName == nil ? "" : EmployeeName
        
        return SupportEmployee(EmployeeCode:EmployeeCode!, EmployeeName:EmployeeName!)
    }
    
    
}
