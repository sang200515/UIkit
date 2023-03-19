//
//  QRcodeFFriend.swift
//  fptshop
//
//  Created by Ngo Dang tan on 3/5/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"Result": 0,
//"Messages": "Không lấy được token từ phía Ftel. Vui lòng liên hệ support để hỗ trợ",
//"IdCard": "",
//"FullName": "",
//"PhoneNumber": "",
//"contractNo": "",
//"VendorCode": "",
//"prefix": ""
import Foundation
import SwiftyJSON
class QRcodeFFriend: NSObject {
    var Result:Int
    var Messages:String
    var IdCard:String
    var FullName:String
    var PhoneNumber:String
    var contractNo:String
    var VendorCode:String
    var prefix:String
    
    init( Result:Int
     , Messages:String
     , IdCard:String
     , FullName:String
     , PhoneNumber:String
     , contractNo:String
     , VendorCode:String
     , prefix:String){
        
        self.Result = Result
        self.Messages = Messages
        self.IdCard = IdCard
        self.FullName = FullName
        self.PhoneNumber = PhoneNumber
        self.contractNo = contractNo
        self.VendorCode = VendorCode
        self.prefix = prefix
    }
    
    class func parseObjfromArray(array:[JSON])->[QRcodeFFriend]{
        var list:[QRcodeFFriend] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> QRcodeFFriend{
        var Result = data["Result"].int
        var Messages = data["Messages"].string
        var IdCard = data["IdCard"].string
        var FullName = data["FullName"].string
        var PhoneNumber = data["PhoneNumber"].string
        var contractNo = data["contractNo"].string
        var VendorCode = data["VendorCode"].string
        var prefix = data["prefix"].string
        
        Result = Result == nil ? 0 : Result
        Messages = Messages == nil ? "" : Messages
        IdCard = IdCard == nil ? "" : IdCard
        FullName = FullName == nil ? "" : FullName
        PhoneNumber = PhoneNumber == nil ? "" : PhoneNumber
        contractNo = contractNo == nil ? "" : contractNo
        VendorCode = VendorCode == nil ? "" : VendorCode
        prefix = prefix == nil ? "" : prefix
        return QRcodeFFriend(Result:Result!
        , Messages:Messages!
        , IdCard:IdCard!
        , FullName:FullName!
        , PhoneNumber:PhoneNumber!
        , contractNo:contractNo!
        , VendorCode:VendorCode!
        , prefix:prefix!)
    }
}
