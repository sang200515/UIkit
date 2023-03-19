//
//  TransInfoViettelPay.swift
//  fptshop
//
//  Created by tan on 7/12/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class TransInfoViettelPay: NSObject {
    var error_code:String
    var error_msg:String
    var nameReceiver:String
    var msisdnReceiver:String
    var nameSender:String
    var msisdnSender:String
    var trans_id:String
    var status:String
    var amount:String
    var trans_create_date:String
    
    init( error_code:String
    , error_msg:String
    , nameReceiver:String
    , msisdnReceiver:String
    , nameSender:String
    , msisdnSender:String
        ,trans_id:String
        ,status:String
        ,amount:String
        ,trans_create_date:String){
        self.error_code = error_code
        self.error_msg = error_msg
        self.nameReceiver = nameReceiver
        self.msisdnReceiver = msisdnReceiver
        self.nameSender = nameSender
        self.msisdnSender = msisdnSender
        self.trans_id = trans_id
        self.status = status
        self.amount = amount
        self.trans_create_date = trans_create_date
    }
    
    class func parseObjfromArray(array:[JSON])->[TransInfoViettelPay]{
        var list:[TransInfoViettelPay] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> TransInfoViettelPay{
        
        var error_code = data["error_code"].string
        var error_msg = data["error_msg"].string
        var trans_id = data["trans_id"].string
        var status = data["status"].string
        var amount = data["amount"].string
        var trans_create_date = data["trans_create_date"].string
        
        
        
        
        
        error_code = error_code == nil ? "" : error_code
        error_msg = error_msg == nil ? "" : error_msg
        trans_id = trans_id == nil ? "" : trans_id
        status = status == nil ? "" : status
        amount = amount == nil ? "" : amount
        trans_create_date = trans_create_date == nil ? "" : trans_create_date
        
        
        
        return TransInfoViettelPay(  error_code:error_code!
            , error_msg:error_msg!
            , nameReceiver:""
            , msisdnReceiver:""
            , nameSender:""
            , msisdnSender:""
            ,trans_id:trans_id!
            ,status:status!
            ,amount:amount!
            ,trans_create_date:trans_create_date!
        )
    }
    
}
