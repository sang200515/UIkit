//
//  InstallApp_Utop.swift
//  fptshop
//
//  Created by DiemMy Le on 12/3/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"OS": "Android",
//"PhoneNum": "0989041292",
//"LastUpdate": "25/11/2019 08:31:21",
//"Payment": 0,
//"StatusApp": "Mở app thất bại!"

import UIKit
import SwiftyJSON

class InstallApp_Utop: NSObject {

    let OS: String
    let PhoneNum: String
    let LastUpdate: String
    let Payment: Int
    let StatusApp: String
    
    init(OS: String, PhoneNum: String, LastUpdate: String, Payment: Int, StatusApp: String) {
        self.OS = OS
        self.PhoneNum = PhoneNum
        self.LastUpdate = LastUpdate
        self.Payment = Payment
        self.StatusApp = StatusApp
    }
    
    class func parseObjfromArray(array:[JSON])->[InstallApp_Utop]{
        var list:[InstallApp_Utop] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> InstallApp_Utop {
        var OS = data["OS"].string
        var PhoneNum = data["PhoneNum"].string
        var LastUpdate = data["LastUpdate"].string
        var Payment = data["Payment"].int
        var StatusApp = data["StatusApp"].string
        
        OS = OS == nil ? "" : OS
        PhoneNum = PhoneNum == nil ? "" : PhoneNum
        LastUpdate = LastUpdate == nil ? "" : LastUpdate
        Payment = Payment == nil ? 0 : Payment
        StatusApp = StatusApp == nil ? "" : StatusApp
        
        return InstallApp_Utop(OS: OS!, PhoneNum: PhoneNum!, LastUpdate: LastUpdate!, Payment: Payment!, StatusApp: StatusApp!)
    }
}
