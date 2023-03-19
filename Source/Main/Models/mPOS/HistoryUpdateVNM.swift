//
//  HistoryUpdateVNM.swift
//  fptshop
//
//  Created by Ngo Dang tan on 7/16/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class HistoryUpdateVNM: NSObject {
    var PhoneNumber:String
    var IdCard:String
    var FullName:String
    var DateOfIssue:String
    var Gender:String
    var EmployeeName:String
    var CreateDate:String
    var ShopName:String
    var PhiCapNhat:String
    var SO_MPOS:Int
    
    init(PhoneNumber:String
        , IdCard:String
        , FullName:String
        , DateOfIssue:String
        , Gender:String
        , EmployeeName:String
        , CreateDate:String
        , ShopName:String
        , PhiCapNhat:String
        , SO_MPOS:Int){
        self.PhoneNumber = PhoneNumber
        self.IdCard = IdCard
        self.FullName = FullName
        self.DateOfIssue = DateOfIssue
        self.Gender = Gender
        self.EmployeeName = EmployeeName
        self.CreateDate = CreateDate
        self.ShopName = ShopName
        self.PhiCapNhat = PhiCapNhat
        self.SO_MPOS = SO_MPOS
    }
    
    class func parseObjfromArray(array:[JSON])->[HistoryUpdateVNM]{
        var list:[HistoryUpdateVNM] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> HistoryUpdateVNM {
        var PhoneNumber = data["PhoneNumber"].string
        var IdCard = data["IdCard"].string
        var FullName = data["FullName"].string
        var DateOfIssue = data["DateOfIssue"].string
        var Gender = data["Gender"].string
        var EmployeeName = data["EmployeeName"].string
        var CreateDate = data["CreateDate"].string
        var ShopName = data["ShopName"].string
        var PhiCapNhat = data["PhiCapNhat"].string
        var SO_MPOS = data["SO_MPOS"].int
        
        PhoneNumber = PhoneNumber == nil ? "" : PhoneNumber
        IdCard = IdCard == nil ? "" : IdCard
        FullName = FullName == nil ? "" : FullName
        DateOfIssue = DateOfIssue == nil ? "" : DateOfIssue
        Gender = Gender == nil ? "" : Gender
        EmployeeName = EmployeeName == nil ? "" : EmployeeName
        CreateDate = CreateDate == nil ? "" : CreateDate
        ShopName = ShopName == nil ? "" : ShopName
        PhiCapNhat = PhiCapNhat == nil ? "" : PhiCapNhat
        SO_MPOS = SO_MPOS == nil ? 0 : SO_MPOS
        
        return HistoryUpdateVNM(PhoneNumber:PhoneNumber!
        , IdCard:IdCard!
        , FullName:FullName!
        , DateOfIssue:DateOfIssue!
        , Gender:Gender!
        , EmployeeName:EmployeeName!
        , CreateDate:CreateDate!
        , ShopName:ShopName!
        , PhiCapNhat:PhiCapNhat!
        , SO_MPOS:SO_MPOS!)
    }
    
}
