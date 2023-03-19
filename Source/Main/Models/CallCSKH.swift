//
//  CallCSKH.swift
//  fptshop
//
//  Created by DiemMy Le on 7/29/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class CallCSKH: NSObject {
    var ID:Int
    var ShopCode:String
    var ShopName:String
    var Phone:String
    var CustomerName:String
    var Model:String
    var Status:String
    var DateAddList:String
    var EmployeeNameCall: String
    var CallDate: String
    
    init(ID:Int, ShopCode:String, ShopName:String, Phone:String, CustomerName:String, Model:String, Status:String, DateAddList:String, EmployeeNameCall: String, CallDate: String) {
        self.ID = ID
        self.ShopCode = ShopCode
        self.ShopName = ShopName
        self.Phone = Phone
        self.CustomerName = CustomerName
        self.Model = Model
        self.Status = Status
        self.DateAddList = DateAddList
        self.EmployeeNameCall = EmployeeNameCall
        self.CallDate = CallDate
    }
    
    class func parseObjfromArray(array:[JSON])->[CallCSKH]{
        var list:[CallCSKH] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> CallCSKH {
        var ID = data["ID"].int
        var ShopCode = data["ShopCode"].string
        var ShopName = data["ShopName"].string
        var Phone = data["Phone"].string
        var CustomerName = data["CustomerName"].string
        var Model = data["Model"].string
        var Status = data["Status"].string
        var DateAddList = data["DateAddList"].string
        var EmployeeNameCall = data["EmployeeNameCall"].string
        var CallDate = data["CallDate"].string

        ID = ID == nil ? 0 : ID
        ShopCode = ShopCode == nil ? "" : ShopCode
        ShopName = ShopName == nil ? "" : ShopName
        Phone = Phone == nil ? "" : Phone
        CustomerName = CustomerName == nil ? "" : CustomerName
        Model = Model == nil ? "" : Model
        Status = Status == nil ? "" : Status
        DateAddList = DateAddList == nil ? "" : DateAddList
        EmployeeNameCall = EmployeeNameCall == nil ? "" : EmployeeNameCall
        CallDate = CallDate == nil ? "" : CallDate

        return CallCSKH(ID: ID!, ShopCode: ShopCode!, ShopName: ShopName!, Phone: Phone!, CustomerName: CustomerName!, Model: Model!, Status: Status!, DateAddList: DateAddList!, EmployeeNameCall: EmployeeNameCall!, CallDate: CallDate!)
    }
}
