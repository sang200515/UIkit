//
//  EncashpayooResult.swift
//  mPOS
//
//  Created by sumi on 11/24/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class EncashpayooResult: NSObject {
    
    var BillCode:String
    var ReturnCode: String
    var Description: String
    var MaGDPayoo: String
    var RemarkTransaction: String
    var TransactionReturnCode: String
    var MaGDFRT:String
    
    var u_vocher:String
    var u_Vchname:String
    var Tu_ngay:String
    var Den_Ngay:String

    init(BillCode:String, ReturnCode: String, Description: String, MaGDPayoo: String, RemarkTransaction: String, TransactionReturnCode: String, MaGDFRT:String, u_vocher:String, u_Vchname:String, Tu_ngay:String, Den_Ngay:String){
       self.BillCode = BillCode
       self.ReturnCode = ReturnCode
       self.Description = Description
       self.MaGDPayoo = MaGDPayoo
       self.RemarkTransaction = RemarkTransaction
       self.TransactionReturnCode = TransactionReturnCode
       self.MaGDFRT = MaGDFRT
       self.u_vocher = u_vocher
       self.u_Vchname = u_Vchname
       self.Tu_ngay = Tu_ngay
       self.Den_Ngay = Den_Ngay
    }
    class func parseObjfromArray(array:[JSON])->[EncashpayooResult]{
        var list:[EncashpayooResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> EncashpayooResult{
        var BillCode = data["BillCode"].string
        var ReturnCode = data["ReturnCode"].int
        var Description = data["Description"].string
        
        var MaGDPayoo = data["MaGDPayoo"].string
        var RemarkTransaction = data["RemarkTransaction"].string
        var TransactionReturnCode = data["TransactionReturnCode"].int
        
        var MaGDFRT = data["MaGDFRT"].string
        var u_vocher = data["u_vocher"].string
        var u_Vchname = data["u_Vchname"].string
        
        var Tu_ngay = data["Tu_ngay"].string
        var Den_Ngay = data["Den_Ngay"].string
        
        BillCode = BillCode == nil ? "" : BillCode
        ReturnCode = ReturnCode == nil ? 0 : ReturnCode
        Description = Description == nil ? "" : Description
        
        MaGDPayoo = MaGDPayoo == nil ? "" : MaGDPayoo
        RemarkTransaction = RemarkTransaction == nil ? "" : RemarkTransaction
        TransactionReturnCode = TransactionReturnCode == nil ? 0 : TransactionReturnCode
        
        MaGDFRT = MaGDFRT == nil ? "" : MaGDFRT
        u_vocher = u_vocher == nil ? "" : u_vocher
        u_Vchname = u_Vchname == nil ? "" : u_Vchname
        
        Tu_ngay = Tu_ngay == nil ? "" : Tu_ngay
        Den_Ngay = Den_Ngay == nil ? "" : Den_Ngay
        
        return EncashpayooResult(BillCode:BillCode!, ReturnCode: "\(ReturnCode!)", Description: Description!, MaGDPayoo: MaGDPayoo!, RemarkTransaction: RemarkTransaction!, TransactionReturnCode: "\(TransactionReturnCode!)", MaGDFRT:MaGDFRT!, u_vocher:u_vocher!, u_Vchname:u_Vchname!, Tu_ngay:Tu_ngay!, Den_Ngay:Den_Ngay!)
        
    }
}

