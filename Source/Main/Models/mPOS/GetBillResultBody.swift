//
//  GetBillResultBody.swift
//  mPOS
//
//  Created by sumi on 11/21/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetBillResultBody: NSObject {
    
    var ID: String
    var BillID: String
    var Month: String
    
    var TotalAmount: Int
    var ExpiredDate: String
    var IsPrepaid: String
    
    var PaymentFee:Int
    var BusinessOrderNo: String
    var BusinessName: String
    
    var InfoEx: String
    var BillTitle: String
    var CustomerCode: String
    
    var IsCheck: String
    var IsClick: String
    
    init(ID: String, BillID: String, Month: String, TotalAmount: Int, ExpiredDate: String, IsPrepaid: String, PaymentFee:Int, BusinessOrderNo: String, BusinessName: String, InfoEx: String, BillTitle: String, CustomerCode: String, IsCheck: String, IsClick: String){
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
    class func parseObjfromArray(array:[JSON])->[GetBillResultBody]{
        var list:[GetBillResultBody] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> GetBillResultBody{
        var ID = data["ID"].string
        var BillID = data["BillID"].string
        var Month = data["Month"].string
        
        var TotalAmount = data["TotalAmount"].int
        var ExpiredDate = data["ExpiredDate"].string
        var IsPrepaid = data["IsPrepaid"].string
        
        var PaymentFee = data["PaymentFee"].int
        var BusinessOrderNo = data["BusinessOrderNo"].string
        var BusinessName = data["BusinessName"].string

        PaymentFee = PaymentFee == nil ? 0 : PaymentFee
        BusinessOrderNo = BusinessOrderNo == nil ? "": BusinessOrderNo
        BusinessName = BusinessName == nil ? "": BusinessName
        
        ID = ID == nil ? "": ID
        BillID = BillID == nil ? "" : BillID
        Month = Month == nil ? "" : Month
        
        TotalAmount = TotalAmount == nil ? 0 : TotalAmount
        ExpiredDate = ExpiredDate == nil ? "": ExpiredDate
        IsPrepaid = IsPrepaid == nil ? "": IsPrepaid
        
        
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
        
        return GetBillResultBody(ID: ID!, BillID: BillID!, Month: Month!, TotalAmount: TotalAmount!, ExpiredDate: ExpiredDate!, IsPrepaid: IsPrepaid!, PaymentFee:PaymentFee!, BusinessOrderNo: BusinessOrderNo!, BusinessName: BusinessName!, InfoEx: InfoEx!, BillTitle: BillTitle!, CustomerCode: CustomerCode!, IsCheck: IsCheck!, IsClick: IsClick!)
    }
    
    
}

