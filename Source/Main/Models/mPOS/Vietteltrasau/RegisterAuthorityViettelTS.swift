//
//  RegisterAuthorityViettelTS.swift
//  fptshop
//
//  Created by DiemMy Le on 8/12/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"username": "partnerchain",
//"service_code": "100000",
//"billing_code": "84983103127",
//"msisdn": "0963101020",
//"trans_id": "200812622198503",
//"trans_date": "20200812170648",
//"error_code": "00",
//"error_msg": "Đã gửi OTP"


import UIKit
import SwiftyJSON

class RegisterAuthorityViettelTS: NSObject {

    let username:String
    let service_code:String
    let billing_code:String
    let msisdn:String
    let trans_id:String
    let trans_date:String
    let error_code:String
    let error_msg:String
    let otp:String
    
    init(username:String, service_code:String, billing_code:String, msisdn:String, trans_id:String, trans_date:String, error_code:String, error_msg:String, otp:String) {
        self.username = username
        self.service_code = service_code
        self.billing_code = billing_code
        self.msisdn = msisdn
        self.trans_id = trans_id
        self.trans_date = trans_date
        self.error_code = error_code
        self.error_msg = error_msg
        self.otp = otp
    }
    
    class func parseObjfromArray(array:[JSON])->[RegisterAuthorityViettelTS] {
        var list:[RegisterAuthorityViettelTS] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
        
    class func getObjFromDictionary(data:JSON) -> RegisterAuthorityViettelTS {
        var username = data["username"].string
        var service_code = data["service_code"].string
        var billing_code = data["billing_code"].string
        var msisdn = data["msisdn"].string
        var trans_id = data["trans_id"].string
        var trans_date = data["trans_date"].string
        var error_code = data["error_code"].string
        var error_msg = data["error_msg"].string
        var otp = data["otp"].string
        
        username = username == nil ? "" : username
        service_code = service_code == nil ? "" : service_code
        billing_code = billing_code == nil ? "" : billing_code
        msisdn = msisdn == nil ? "" : msisdn
        trans_id = trans_id == nil ? "" : trans_id
        trans_date = trans_date == nil ? "" : trans_date
        error_code = error_code == nil ? "" : error_code
        error_msg = error_msg == nil ? "" : error_msg
        otp = otp == nil ? "" : otp
        
        return RegisterAuthorityViettelTS(username: username!, service_code: service_code!, billing_code: billing_code!, msisdn: msisdn!, trans_id: trans_id!, trans_date: trans_date!, error_code: error_code!, error_msg: error_msg!, otp: otp!)
    }
}
