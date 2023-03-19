//
//  PaymentOfFunds_New.swift
//  fptshop
//
//  Created by Apple on 7/16/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//
//"DocEntry": 11,
//"Date": "15/07/2019",
//"StatusCode": "P         ",
//"Money": 30799000,
//"EmployeeName": "15261 - Nguyễn Phúc Hữu",
//"ShopName": "30808 - HCM 305 Tô Hiến Thành"

import UIKit
import SwiftyJSON

class PaymentOfFunds_New: NSObject {

    let DocEntry: Int
    let Date: String
    let StatusCode: String
    let Money: String
    let EmployeeName: String
    let ShopName: String
    let RequestId: Int
    
    init(DocEntry: Int, Date: String, StatusCode: String, Money: String, EmployeeName: String, ShopName: String, RequestId: Int) {
        
        self.DocEntry = DocEntry
        self.Date = Date
        self.StatusCode = StatusCode
        self.Money = Money
        self.EmployeeName = EmployeeName
        self.ShopName = ShopName
        self.RequestId = RequestId
    }
    
    class func parseObjfromArray(array:[JSON])->[PaymentOfFunds_New]{
        var list:[PaymentOfFunds_New] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> PaymentOfFunds_New {
        
        var DocEntry = data["DocEntry"].int
        var Date = data["Date"].string
        var StatusCode = data["StatusCode"].string
        var Money = data["Money"].string
        var EmployeeName = data["EmployeeName"].string
        var ShopName = data["ShopName"].string
        var RequestId = data["RequestId"].int
        
        DocEntry = DocEntry == nil ? 0 : DocEntry
        Date = Date == nil ? "" : Date
        StatusCode = StatusCode == nil ? "" : StatusCode
        Money = Money == nil ? "" : Money
        EmployeeName = EmployeeName == nil ? "" : EmployeeName
        ShopName = ShopName == nil ? "" : ShopName
        RequestId = RequestId == nil ? 0 : RequestId
        
        return PaymentOfFunds_New(DocEntry: DocEntry!, Date: Date!, StatusCode: StatusCode!, Money: Money!, EmployeeName: EmployeeName!, ShopName: ShopName!, RequestId:RequestId!)
    }
}
