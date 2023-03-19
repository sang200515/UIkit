//
//  GetListCustomerResult.swift
//  mPOS
//
//  Created by sumi on 12/1/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetListCustomerResult: NSObject {
    var RowID: Int
    var Contract: String
    var FullName: String
    var Address: String
    var Passport: String
    var Phone: String
    var Debt: String
    var DebtMessage: String
    var PaidDate: String

    init(RowID: Int, Contract: String, FullName: String, Address: String, Passport: String, Phone: String, Debt: String, DebtMessage: String, PaidDate: String){
        self.RowID = RowID
        self.Contract = Contract
        self.FullName = FullName
        self.Address = Address
        self.Passport = Passport
        self.Phone = Phone
        self.Debt = Debt
        self.DebtMessage = DebtMessage
        self.PaidDate = PaidDate
    }
    class func parseObjfromArray(array:[JSON])->[GetListCustomerResult]{
        var list:[GetListCustomerResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> GetListCustomerResult{
        
       var RowID = data["RowID"].int
       var  Contract = data["Contract"].string
       var  FullName = data["FullName"].string
       var  Address = data["Address"].string
       var  Passport = data["Passport"].string
       var  Phone = data["Phone"].string
       var  Debt = data["Debt"].string
       var  DebtMessage = data["DebtMessage"].string
       var  PaidDate = data["PaidDate"].string
        
        RowID = RowID == nil ? 0 : RowID
        Contract = Contract == nil ? "" : Contract
        
        FullName = FullName == nil ? "" : FullName
        Address = Address == nil ? "" : Address
        
        Passport = Passport == nil ? "" : Passport
        Phone = Phone == nil ? "" : Phone
        
        Debt = Debt == nil ? "" : Debt
        DebtMessage = DebtMessage == nil ? "" : DebtMessage
        PaidDate = PaidDate == nil ? "" : PaidDate
        
        return GetListCustomerResult(RowID: RowID!, Contract: Contract!, FullName: FullName!, Address: Address!, Passport: Passport!, Phone: Phone!, Debt: Debt!, DebtMessage: DebtMessage!, PaidDate: PaidDate!)
        
    }
}


