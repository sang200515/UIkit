//
//  CashInViettelPay.swift
//  fptshop
//
//  Created by tan on 7/15/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class CashInViettelPay: NSObject {
    var error_code:String
    var error_msg:String
    var trans_id:Int
    var amount:Int
    
    var trans_content:String
    var order_id:String
    
    var nameSender:String
    var phoneSender:String
    var nameReceiver:String
    var phoneReceiver:String
    var trans_fee:Int
    var Tu_ngay:String
    var u_vocher:String
    
    init(  error_code:String
    , error_msg:String
        ,trans_id:Int
        ,amount:Int
        , trans_content:String
    , order_id:String
    
    , nameSender:String
    , phoneSender:String
   , nameReceiver:String
    , phoneReceiver:String
        ,trans_fee:Int
    , Tu_ngay:String
      , u_vocher:String){
        self.error_code = error_code
        self.error_msg = error_msg
        self.trans_id = trans_id
        self.amount = amount
        
        self.trans_content = trans_content
        self.order_id = order_id
        
        self.nameSender = nameSender
        self.phoneSender = phoneSender
        self.nameReceiver = nameReceiver
        self.phoneReceiver = phoneReceiver
        self.trans_fee = trans_fee
        self.Tu_ngay = Tu_ngay
        self.u_vocher = u_vocher
    }
    
    class func parseObjfromArray(array:[JSON])->[CashInViettelPay]{
        var list:[CashInViettelPay] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> CashInViettelPay{
        
        var error_code = data["error_code"].string
        var error_msg = data["error_msg"].string
        var trans_id = data["trans_id"].int
        var amount = data["amount"].int
        var trans_content = data["trans_content"].string
        var order_id = data["order_id"].string
        var trans_fee = data["trans_fee"].int
        var Tu_ngay = data["Tu_ngay"].string
        var u_vocher = data["u_vocher"].string
        
        
        
        
        error_code = error_code == nil ? "" : error_code
        error_msg = error_msg == nil ? "" : error_msg
        trans_id = trans_id == nil ? 0 : trans_id
        amount = amount == nil ? 0 : amount
        
        trans_content = trans_content == nil ? "" : trans_content
        order_id = order_id == nil ? "" : order_id
        trans_fee = trans_fee == nil ? 0 : trans_fee
        Tu_ngay = Tu_ngay == nil ? "" : Tu_ngay
        u_vocher = u_vocher == nil ? "" : u_vocher
        
        
        
        return CashInViettelPay(  error_code:error_code!
            , error_msg:error_msg!
            ,trans_id:trans_id!
            ,amount:amount!
            ,trans_content:trans_content!
            ,order_id:order_id!
            , nameSender:""
            , phoneSender:""
            , nameReceiver:""
            , phoneReceiver:""
            ,trans_fee:trans_fee!
            ,Tu_ngay:Tu_ngay!
            ,u_vocher:u_vocher!
        )
    }
}
