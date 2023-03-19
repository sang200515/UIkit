//
//  CustFeeBack.swift
//  fptshop
//
//  Created by tan on 8/1/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class CustFeeBack: NSObject {
    var docentry:Int
    var p_statusfee:Int
    var p_notefee:String
    var amount:Int
    var cust_fee:Int
    var TransactionCode:String
    
    
    init(     docentry:Int
    , p_statusfee:Int
    , p_notefee:String
    , amount:Int
    , cust_fee:Int
    , TransactionCode:String){
        self.docentry = docentry
        self.p_statusfee = p_statusfee
        self.p_notefee = p_notefee
        self.amount = amount
        self.cust_fee = cust_fee
        self.TransactionCode = TransactionCode
    }
    
    class func parseObjfromArray(array:[JSON])->[CustFeeBack]{
        var list:[CustFeeBack] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> CustFeeBack{
        
        
        var docentry = data["docentry"].int
        var p_statusfee = data["p_statusfee"].int
        var p_notefee = data["p_notefee"].string
        var amount = data["amount"].int
        var cust_fee = data["cust_fee"].int
        var TransactionCode = data["TransactionCode"].string
        
        
        
        
        
        
        docentry = docentry == nil ? 0 : docentry
        p_statusfee = p_statusfee == nil ? 0 : p_statusfee
        p_notefee = p_notefee == nil ? "" : p_notefee
        amount = amount == nil ? 0 : amount
        cust_fee = cust_fee == nil ? 0 : cust_fee
              TransactionCode = TransactionCode == nil ? "" : TransactionCode
        
        return CustFeeBack(docentry:docentry!
            , p_statusfee:p_statusfee!
            , p_notefee:p_notefee!
            , amount:amount!
            , cust_fee:cust_fee!
            , TransactionCode:TransactionCode!
            
        )
    }
}
