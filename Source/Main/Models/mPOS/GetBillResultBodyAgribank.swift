//
//  GetBillResultBodyAgribank.swift
//  mPOS
//
//  Created by sumi on 11/27/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetBillResultBodyAgribank: NSObject {
    
    var AgriBank_TransID: String
    var AmountOverdue: String
    var ContractNo: String
    var ID: String
    var InstallmentDueDate: String
    var MinAmount: String
    var PaymentDueDate: String
    var TotalAmount: String
    var TransRef:String
    
    init(AgriBank_TransID: String, AmountOverdue: String, ContractNo: String, ID: String, InstallmentDueDate: String, MinAmount: String, PaymentDueDate: String, TotalAmount: String, TransRef:String){
        self.AgriBank_TransID = AgriBank_TransID
        self.AmountOverdue = AmountOverdue
        self.ContractNo = ContractNo
        self.ID = ID
        self.InstallmentDueDate = InstallmentDueDate
        self.MinAmount = MinAmount
        self.PaymentDueDate = PaymentDueDate
        self.TotalAmount = TotalAmount
        self.TransRef = TransRef
    }
    class func parseObjfromArray(array:[JSON])->[GetBillResultBodyAgribank]{
        var list:[GetBillResultBodyAgribank] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> GetBillResultBodyAgribank{
        var AgriBank_TransID = data["AgriBank_TransID"].string
        var AmountOverdue = data["AmountOverdue"].string
        var ContractNo = data["ContractNo"].string
        
        var  ID = data["ID"].string
        var InstallmentDueDate = data["InstallmentDueDate"].string
        var  MinAmount = data["MinAmount"].string
        
        var PaymentDueDate = data["PaymentDueDate"].string
        var TotalAmount = data["TotalAmount"].string
        var  TransRef = data["TransRef"].string
        
        AgriBank_TransID = AgriBank_TransID == nil ? "" : AgriBank_TransID
        AmountOverdue = AmountOverdue == nil ? "" : AmountOverdue
        ContractNo = ContractNo == nil ? "" : ContractNo
        
        ID = ID == nil ? "" : ID
        InstallmentDueDate = InstallmentDueDate == nil ? "" : InstallmentDueDate
        MinAmount = MinAmount == nil ? "" : MinAmount
        
        PaymentDueDate = PaymentDueDate == nil ? "" : PaymentDueDate
        TotalAmount = TotalAmount == nil ? "" : TotalAmount
        TransRef = TransRef == nil ? "" : TransRef
        
        return GetBillResultBodyAgribank(AgriBank_TransID: AgriBank_TransID!, AmountOverdue: AmountOverdue!, ContractNo: ContractNo!, ID: ID!, InstallmentDueDate: InstallmentDueDate!, MinAmount: MinAmount!, PaymentDueDate: PaymentDueDate!, TotalAmount: TotalAmount!, TransRef:TransRef!)
        
    }
}


