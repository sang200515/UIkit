//
//  GetBillResultBodyCheckList.swift
//  mPOS
//
//  Created by sumi on 11/23/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit

class GetBillResultBodyCheckList: NSObject {
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
    init(ID:String,BillID:String,Month:String,TotalAmount:Int,ExpiredDate:String,IsPrepaid:String,PaymentFee:Int,BusinessOrderNo:String,BusinessName:String,InfoEx:String,BillTitle:String,CustomerCode:String,IsCheck:String,IsClick:String) {
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
}

