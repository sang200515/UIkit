//
//  ItemDetailPayoo.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/30/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ItemDetailPayoo: NSObject {
    
    var ID: Int
    var BillID: String
    var Month: String
    
    var TotalAmount: Int
    var ExpiredDate: String
    var IsPrepaid: Bool
    
    var PaymentFee:Int
    var BusinessOrderNo: String
    var BusinessName: String
    
    var InfoEx: String
    var BillTitle: String
    var CustomerCode: String
    
    var IsCheck: String
    var IsClick: String
    
    init(ID: Int, BillID: String, Month: String, TotalAmount: Int, ExpiredDate: String, IsPrepaid: Bool, PaymentFee:Int, BusinessOrderNo: String, BusinessName: String, InfoEx: String, BillTitle: String, CustomerCode: String, IsCheck: String, IsClick: String){
        self.ID = ID
        self.BillID = BillID
        self.Month = Month
        self.TotalAmount = TotalAmount
        self.ExpiredDate = ExpiredDate
        self.IsPrepaid = IsPrepaid
        self.PaymentFee = PaymentFee
        self.BusinessOrderNo = BusinessOrderNo
        self.BusinessName = BusinessName
        self.InfoEx = InfoEx
        self.BillTitle = BillTitle
        self.CustomerCode = CustomerCode
        self.IsCheck = IsCheck
        self.IsClick = IsClick
    }
    class func parseObjfromArray(array:[JSON])->[ItemDetailPayoo]{
        var list:[ItemDetailPayoo] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ItemDetailPayoo{
        var ID = data["ID"].int
        var BillID = data["BillID"].string
        var Month = data["Month"].string
        
        var TotalAmount = data["TotalAmount"].int
        var ExpiredDate = data["ExpiredDate"].string
        var IsPrepaid = data["IsPrepaid"].bool
        
        var PaymentFee = data["PaymentFee"].int
        var BusinessOrderNo = data["BusinessOrderNo"].string
        var BusinessName = data["BusinessName"].string
        
        PaymentFee = PaymentFee == nil ? 0 : PaymentFee
        BusinessOrderNo = BusinessOrderNo == nil ? "": BusinessOrderNo
        BusinessName = BusinessName == nil ? "": BusinessName
        
        ID = ID == nil ? 0 : ID
        BillID = BillID == nil ? "" : BillID
        Month = Month == nil ? "" : Month
        
        TotalAmount = TotalAmount == nil ? 0 : TotalAmount
        ExpiredDate = ExpiredDate == nil ? "": ExpiredDate
        IsPrepaid = IsPrepaid == nil ? false : IsPrepaid
        
        
        var InfoEx = data["InfoEx"].string
        var BillTitle = data["BillTitle"].string
        var CustomerCode = data["CustomerCode"].string
        
        InfoEx = InfoEx == nil ? "": InfoEx
        BillTitle = BillTitle == nil ? "": BillTitle
        CustomerCode = CustomerCode == nil ? "": CustomerCode
        
        var IsCheck = data["IsCheck"].string
        var IsClick = data["IsCheck"].string
        
        IsCheck = IsCheck == nil ? "": IsCheck
        IsClick = IsClick == nil ? "": IsClick
        
        return ItemDetailPayoo(ID: ID!, BillID: BillID!, Month: Month!, TotalAmount: TotalAmount!, ExpiredDate: ExpiredDate!, IsPrepaid: IsPrepaid!, PaymentFee:PaymentFee!, BusinessOrderNo: BusinessOrderNo!, BusinessName: BusinessName!, InfoEx: InfoEx!, BillTitle: BillTitle!, CustomerCode: CustomerCode!, IsCheck: IsCheck!, IsClick: IsClick!)
    }
    
    
}
