//
//  ViettelPayTopup.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 5/2/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ViettelPayTopup: NSObject {
    let amount: Int
    let billing_code: String
    let order_id: String
    let service_code: String
    let username: String
    let subID: String
    let error_code: String
    let trans_date: String
    let error_msg: String
    
    var u_vocher: String
    var u_Vchname:String
    var Tu_ngay: String
    var Den_Ngay:String
    
    init(amount: Int, billing_code: String, order_id: String, service_code: String, username: String, subID: String, error_code: String, trans_date: String,error_msg: String,u_vocher: String, u_Vchname:String, Tu_ngay: String, Den_Ngay:String){
        self.amount = amount
        self.billing_code = billing_code
        self.order_id = order_id
        self.service_code = service_code
        self.username = username
        self.subID = subID
        self.error_code = error_code
        self.trans_date = trans_date
        self.error_msg = error_msg
        
        self.u_vocher = u_vocher
        self.u_Vchname = u_Vchname
        self.Tu_ngay = Tu_ngay
        self.Den_Ngay = Den_Ngay
    }
    class func getObjFromDictionary(data:JSON) -> ViettelPayTopup{
        
        var amount = data["amount"].int
        var billing_code = data["billing_code"].string
        var order_id = data["order_id"].string
        var service_code = data["service_code"].string
        var username = data["username"].string
        var subID = data["subID"].string
        var error_code = data["error_code"].string
        var trans_date = data["trans_date"].string
        var error_msg = data["error_msg"].string
        
        var u_vocher = data["u_vocher"].string
        var u_Vchname = data["u_Vchname"].string
        var Tu_ngay = data["Tu_ngay"].string
        var Den_Ngay = data["Den_Ngay"].string
        
        
        amount = amount == nil ? 0 : amount
        billing_code = billing_code == nil ? "" : billing_code
        order_id = order_id == nil ? "" : order_id
        service_code = service_code == nil ? "" : service_code
        
        username = username == nil ? "" : username
        subID = subID == nil ? "" : subID
        error_code = error_code == nil ? "" : error_code
        trans_date = trans_date == nil ? "" : trans_date
        error_msg = error_msg == nil ? "" : error_msg
        
        u_vocher = u_vocher == nil ? "" : u_vocher
        u_Vchname = u_Vchname == nil ? "" : u_Vchname
        Tu_ngay = Tu_ngay == nil ? "" : Tu_ngay
        Den_Ngay = Den_Ngay == nil ? "" : Den_Ngay
        
        return ViettelPayTopup(amount: amount!, billing_code: billing_code!, order_id: order_id!, service_code: service_code!, username: username!, subID: subID!, error_code: error_code!, trans_date: trans_date!,error_msg:error_msg!,u_vocher: u_vocher!, u_Vchname:u_Vchname!, Tu_ngay: Tu_ngay!, Den_Ngay:Den_Ngay!)
    }
    class func parseObjfromArray(array:[JSON])->[ViettelPayTopup]{
        var list:[ViettelPayTopup] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
}




