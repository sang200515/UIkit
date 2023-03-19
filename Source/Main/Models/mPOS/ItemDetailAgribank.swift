//
//  ItemDetailAgribank.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/30/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class ItemDetailAgribank: NSObject {
    
    var AgriBank_TransID: String
    var AmountOverdue: Int
    var ContractNo: String
    var ID: Int
    var InstallmentDueDate: String
    var MinAmount: Int
    var PaymentDueDate: String
    var TotalAmount: Int
    var TransRef:String
    
    init(AgriBank_TransID: String, AmountOverdue: Int, ContractNo: String, ID: Int, InstallmentDueDate: String, MinAmount: Int, PaymentDueDate: String, TotalAmount: Int, TransRef:String){
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
    class func parseObjfromArray(array:[JSON])->[ItemDetailAgribank]{
        var list:[ItemDetailAgribank] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ItemDetailAgribank{
        var AgriBank_TransID = data["AgriBank_TransID"].string
        var AmountOverdue = data["AmountOverdue"].int
        var ContractNo = data["ContractNo"].string
        var  ID = data["ID"].int
        var InstallmentDueDate = data["InstallmentDueDate"].string
        var  MinAmount = data["MinAmount"].int
        var PaymentDueDate = data["PaymentDueDate"].string
        var TotalAmount = data["TotalAmount"].int
        var  TransRef = data["TransRef"].string
        
        AgriBank_TransID = AgriBank_TransID == nil ? "" : AgriBank_TransID
        AmountOverdue = AmountOverdue == nil ? 0 : AmountOverdue
        ContractNo = ContractNo == nil ? "" : ContractNo
        
        ID = ID == nil ? 0 : ID
        InstallmentDueDate = InstallmentDueDate == nil ? "" : InstallmentDueDate
        MinAmount = MinAmount == nil ? 0 : MinAmount
        
        PaymentDueDate = PaymentDueDate == nil ? "" : PaymentDueDate
        TotalAmount = TotalAmount == nil ? 0 : TotalAmount
        TransRef = TransRef == nil ? "" : TransRef
        
        return ItemDetailAgribank(AgriBank_TransID: AgriBank_TransID!, AmountOverdue: AmountOverdue!, ContractNo: ContractNo!, ID: ID!, InstallmentDueDate: InstallmentDueDate!, MinAmount: MinAmount!, PaymentDueDate: PaymentDueDate!, TotalAmount: TotalAmount!, TransRef:TransRef!)
        
    }
}



