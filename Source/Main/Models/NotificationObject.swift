//
//  NotificationObject.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/27/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class NotificationObject: NSObject {
    var Title: String
    var NoiDung: String
    var ID: Int
    var URL: String
    var Createdate: String
    var is_level: Int
    var is_read:Int
    var System_Name: String
    var CallLog_TypeId: Int
    var CallLog_ReqId: Int
    
    init(Title: String, NoiDung: String, ID: Int, URL: String, Createdate: String, is_level: Int,is_read:Int,System_Name: String, CallLog_TypeId: Int, CallLog_ReqId: Int) {
        self.Title = Title
        self.NoiDung = NoiDung
        self.ID = ID
        self.URL = URL
        self.Createdate = Createdate
        self.is_level = is_level
        self.is_read = is_read
        self.System_Name = System_Name
        self.CallLog_TypeId = CallLog_TypeId
        self.CallLog_ReqId = CallLog_ReqId
    }
    
    class func getObjFromDictionary(data:JSON) -> NotificationObject{
        
        var ID = data["ID"].int
        var Title = data["Title"].string
        var NoiDung = data["NoiDung"].string
        var URL = data["URL"].string
        var Createdate = data["Createdate"].string
        var is_level = data["is_level"].int
        var is_read = data["is_read"].int
        var System_Name = data["System_Name"].string
        
        var CallLog_TypeId = data["CallLog_TypeId"].int
        var CallLog_ReqId = data["CallLog_ReqId"].int
        
        ID = ID == nil ? 0 : ID
        Title = Title == nil ? "" : Title
        NoiDung = NoiDung == nil ? "" : NoiDung
        URL = URL == nil ? "" : URL
        Createdate = Createdate == nil ? "" : Createdate
        is_level = is_level == nil ? 0 : is_level
        is_read = is_read == nil ? 0 : is_read
        System_Name = System_Name == nil ? "" : System_Name
        CallLog_TypeId = CallLog_TypeId == nil ? 0 : CallLog_TypeId
        CallLog_ReqId = CallLog_ReqId == nil ? 0 : CallLog_ReqId
        
        return NotificationObject(Title: Title!, NoiDung: NoiDung!, ID: ID!, URL: URL!, Createdate: Createdate!, is_level: is_level!,is_read:is_read!,System_Name:System_Name!,CallLog_TypeId:CallLog_TypeId!,CallLog_ReqId:CallLog_ReqId!)
    }
    class func parseObjfromArray(array:[JSON])->[NotificationObject]{
        var list:[NotificationObject] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
}


