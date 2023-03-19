//
//  FeeCashInViettelPay.swift
//  fptshop
//
//  Created by tan on 7/11/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class FeeCashInViettelPay: NSObject {
    var amount:String
    var key_otp_fee:String
    var otp:String
    var error_code:String
    var trans_fee:String
    var trans_id:String
    var error_msg:String
    
    var nameReceiver:String
    var phoneReceiver:String
    var nameSender:String
    var phoneSender:String
    
    
    init(amount:String
        ,key_otp_fee:String
    , otp:String
    , error_code:String
    , trans_fee:String
    , trans_id:String
    , error_msg:String
    , nameReceiver:String
    , phoneReceiver:String
    , nameSender:String
    , phoneSender:String){
        self.amount =  amount
        self.key_otp_fee = key_otp_fee
        self.otp = otp
        self.error_code = error_code
        
        self.trans_fee = trans_fee
        self.trans_id = trans_id
        self.error_msg = error_msg
        
        self.nameReceiver = nameReceiver
        self.phoneReceiver = phoneReceiver
        self.nameSender = nameSender
        self.phoneSender = phoneSender
    }
    
    class func parseObjfromArray(array:[JSON])->[FeeCashInViettelPay]{
        var list:[FeeCashInViettelPay] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> FeeCashInViettelPay{
        
        var amount = data["amount"].string
        var key_otp_fee = data["key_otp_fee"].string
        var otp = data["otp"].string
        var error_code = data["error_code"].string
        
        var trans_fee = data["trans_fee"].string
        var trans_id = data["trans_id"].string
        var error_msg = data["error_msg"].string
        
        
        
        
        amount = amount == nil ? "" : amount
        key_otp_fee = key_otp_fee == nil ? "" : key_otp_fee
        otp = otp == nil ? "" : otp
        error_code = error_code == nil ? "" : error_code
        
        trans_fee = trans_fee == nil ? "" : trans_fee
        trans_id = trans_id == nil ? "" : trans_id
        error_msg = error_msg == nil ? "" : error_msg
        
        return FeeCashInViettelPay( amount:amount!
            , key_otp_fee:key_otp_fee!
            , otp:otp!
            , error_code:error_code!
            ,trans_fee:trans_fee!
            ,trans_id:trans_id!
            ,error_msg:error_msg!
            , nameReceiver: ""
            , phoneReceiver: ""
            , nameSender: ""
            , phoneSender:""
            
        )
    }}
