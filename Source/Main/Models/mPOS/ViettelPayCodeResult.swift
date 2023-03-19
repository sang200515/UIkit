//
//  ViettelPayCodeResult.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 1/23/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class ViettelPayCodeResult: NSObject {
    
    var billing_detail : [BillingDetailViettel]
    var order_id: String
    var subID: String
    var error_msg: String
    var error_code:String
    var u_vocher: String
    var u_Vchname:String
    var Tu_ngay: String
    var Den_Ngay:String
    
    init(billing_detail : [BillingDetailViettel], order_id: String, subID: String, error_msg: String,error_code:String,u_vocher: String, u_Vchname:String, Tu_ngay: String, Den_Ngay:String){
        self.billing_detail = billing_detail
        self.order_id = order_id
        self.subID = subID
        self.error_msg = error_msg
        self.error_code = error_code
        
        self.u_vocher = u_vocher
        self.u_Vchname = u_Vchname
        self.Tu_ngay = Tu_ngay
        self.Den_Ngay = Den_Ngay
    }
    class func parseObjfromArray(array:[JSON])->[ViettelPayCodeResult]{
        var list:[ViettelPayCodeResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ViettelPayCodeResult{
        var billing_detail = data["billing_detail"].array
        billing_detail = billing_detail == nil ? [] : billing_detail
        let arr = BillingDetailViettel.parseObjfromArray(array: billing_detail!)
        var order_id = data["order_id"].string
        var subID = data["subID"].string
        var error_msg = data["error_msg"].string
        var error_code = data["error_code"].string
        
        order_id = order_id == nil ? "" : order_id
        subID = subID == nil ? "" : subID
        error_msg = error_msg == nil ? "" : error_msg
        error_code = error_code == nil ? "" : error_code
        
        return ViettelPayCodeResult(billing_detail : arr, order_id: order_id!, subID: subID!, error_msg: error_msg!,error_code:error_code!,u_vocher: "", u_Vchname:"", Tu_ngay: "", Den_Ngay:"")
        
    }
}
