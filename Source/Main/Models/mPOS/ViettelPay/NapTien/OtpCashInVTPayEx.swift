//
//  OtpCashInVTPayEx.swift
//  fptshop
//
//  Created by tan on 6/26/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class OtpCashInVTPayEx: NSObject{
    var amount:Int
    var error_code:String
    var key_otp_fee:String
    var error_msg:String
    var nameSender:String
    var phoneSender:String
    var nameReceiver:String
    var phoneReceiver:String
    var trans_date:String
    
    init(  amount:Int
    , error_code:String
    , key_otp_fee:String
    , error_msg:String
    , nameSender:String
    , phoneSender:String
    , nameReceiver:String
    , phoneReceiver:String
    , trans_date:String){
        self.amount = amount
        self.error_code = error_code
        self.key_otp_fee = key_otp_fee
        self.error_msg = error_msg
        self.nameSender = nameSender
        self.phoneSender = phoneSender
        self.nameReceiver = nameReceiver
        self.phoneReceiver = phoneReceiver
        self.trans_date = trans_date
    }
    
    class func parseObjfromArray(array:[JSON])->[OtpCashInVTPayEx]{
        var list:[OtpCashInVTPayEx] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> OtpCashInVTPayEx{
        
        var amount = data["amount"].int
        var error_code = data["error_code"].string
        var key_otp_fee = data["key_otp_fee"].string
        var error_msg = data["error_msg"].string
        var trans_date = data["trans_date"].string
        
        
        
        
        
        amount = amount == nil ? 0 : amount
        error_code = error_code == nil ? "" : error_code
        key_otp_fee = key_otp_fee == nil ? "" : key_otp_fee
        error_msg = error_msg == nil ? "" : error_msg
        trans_date = trans_date == nil ? "" : trans_date
        
        
        return OtpCashInVTPayEx( amount:amount!
            , error_code:error_code!
            , key_otp_fee:key_otp_fee!
            , error_msg:error_msg!
            , nameSender:""
            , phoneSender:""
            , nameReceiver:""
            , phoneReceiver:""
            , trans_date:trans_date!
        )
    }
    
}
