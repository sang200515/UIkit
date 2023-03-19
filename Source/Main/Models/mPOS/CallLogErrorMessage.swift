//
//  CallLogErrorMessage.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 6/17/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class CallLogErrorMessage: NSObject {
    var TimeCreate_Format:String
    var EmployeeCode:String
    var EmployeeName:String
    var Message:String
    var TimeCreate:String
    
    init(TimeCreate_Format:String, EmployeeCode:String, EmployeeName:String, Message:String, TimeCreate:String){
        self.TimeCreate_Format = TimeCreate_Format
        self.EmployeeCode = EmployeeCode
        self.EmployeeName = EmployeeName
        self.Message = Message
        self.TimeCreate = TimeCreate
    }
    class func parseObjfromArray(array:[JSON])->[CallLogErrorMessage]{
        var list:[CallLogErrorMessage] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> CallLogErrorMessage{
        
        var TimeCreate_Format = data["TimeCreate_Format"].string
        var EmployeeCode = data["EmployeeCode"].string
        var EmployeeName = data["EmployeeName"].string
        var Message = data["Message"].string
        var TimeCreate = data["TimeCreate"].string
        
        TimeCreate_Format = TimeCreate_Format == nil ? "" : TimeCreate_Format
        EmployeeCode = EmployeeCode == nil ? "" : EmployeeCode
        EmployeeName = EmployeeName == nil ? "" : EmployeeName
        Message = Message == nil ? "" : Message
        TimeCreate = TimeCreate == nil ? "" : TimeCreate
        
        
        return CallLogErrorMessage(TimeCreate_Format:TimeCreate_Format!, EmployeeCode:EmployeeCode!, EmployeeName:EmployeeName!, Message:Message!, TimeCreate:TimeCreate!)
    }
}

