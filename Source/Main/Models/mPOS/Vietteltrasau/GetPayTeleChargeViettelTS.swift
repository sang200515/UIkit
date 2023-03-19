//
//  GetPayTeleChargeViettelTS.swift
//  fptshop
//
//  Created by DiemMy Le on 8/14/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"order_id": "9b638754-4f83-4ca7-bda6-975034ee8c56",
//"trans_id": "200814622204747",
//"trans_date": "20200814100335",
//"service_code": "100000",
//"billing_code": "0969460450",
//"amount": null,
//"error_code": "K82",
//"error_msg": "Vuot qua han muc ngay BVB",
//"subID": "23",
//"payment_order_id": "FPTSHOP-M-30808-10648-23"

//var original_trans_id:String
//var payer_msisdn:String

import UIKit
import SwiftyJSON

class GetPayTeleChargeViettelTS: NSObject {
    
    let order_id:String
    let trans_id:String
    let trans_date:String
    let service_code:String
    let billing_code:String
    let amount:String
    let error_code:String
    let error_msg:String
    let subID:String
    let payment_order_id:String
    let sompos:String
    
    //for payment
    var original_trans_id:String
    var payer_msisdn:String
    
    init(order_id:String, trans_id:String, trans_date:String, service_code:String, billing_code:String, amount:String, error_code:String, error_msg:String, subID:String, payment_order_id:String, original_trans_id:String, payer_msisdn:String, sompos:String) {
        
        self.order_id = order_id
        self.trans_id = trans_id
        self.trans_date = trans_date
        self.service_code = service_code
        self.billing_code = billing_code
        self.amount = amount
        self.error_code = error_code
        self.error_msg = error_msg
        self.subID = subID
        self.payment_order_id = payment_order_id
        self.original_trans_id = original_trans_id
        self.payer_msisdn = payer_msisdn
        self.sompos = sompos
    }
    
    class func getObjFromDictionary(data:JSON) -> GetPayTeleChargeViettelTS {
        var order_id = data["order_id"].string
        var trans_id = data["trans_id"].string
        var trans_date = data["trans_date"].string
        var service_code = data["service_code"].string
        var billing_code = data["billing_code"].string
        var amount = data["amount"].string
        var error_code = data["error_code"].string
        var error_msg = data["error_msg"].string
        var subID = data["subID"].string
        var payment_order_id = data["payment_order_id"].string
        var original_trans_id = data["original_trans_id"].string
        var payer_msisdn = data["payer_msisdn"].string
        var sompos = data["sompos"].string
        
        order_id = order_id == nil ? "" : order_id
        trans_id = trans_id == nil ? "" : trans_id
        trans_date = trans_date == nil ? "" : trans_date
        service_code = service_code == nil ? "" : service_code
        billing_code = billing_code == nil ? "" : billing_code
        amount = amount == nil ? "0" : amount
        error_code = error_code == nil ? "" : error_code
        error_msg = error_msg == nil ? "" : error_msg
        subID = subID == nil ? "" : subID
        payment_order_id = payment_order_id == nil ? "" : payment_order_id
        original_trans_id = original_trans_id == nil ? "" : original_trans_id
        payer_msisdn = payer_msisdn == nil ? "" : payer_msisdn
        sompos = sompos == nil ? "" : sompos
        
        return GetPayTeleChargeViettelTS(order_id: order_id!, trans_id: trans_id!, trans_date: trans_date!, service_code: service_code!, billing_code: billing_code!, amount: amount!, error_code: error_code!, error_msg: error_msg!, subID: subID!, payment_order_id: payment_order_id!, original_trans_id: original_trans_id!, payer_msisdn: payer_msisdn!, sompos: sompos!)
    }
}
