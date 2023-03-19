//
//  InquiryItem.swift
//  fptshop
//
//  Created by DiemMy Le on 11/19/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"code": "01",
//"message": "Truy vấn thông tin giao dịch thất bại! transaction not found",
//"msgID": "",
//"txID": "",
//"status": "",
//"currency": "",
//"amount": "",
//"updated": "",
//"errMsg": ""

import UIKit
import SwiftyJSON

class InquiryItem: NSObject {

    var code:String
    var message:String
    var msgID:String
    var txID:String
    var status:String
    var currency:String
    var amount:String
    var updated:String
    var errMsg:String
    
    init(code:String, message:String, msgID:String, txID:String, status:String, currency:String, amount:String, updated:String, errMsg:String) {
        
        self.code = code
        self.message = message
        self.msgID = msgID
        self.txID = txID
        self.status = status
        self.currency = currency
        self.amount = amount
        self.updated = updated
        self.errMsg = errMsg
    }
    
    class func parseObjfromArray(array:[JSON])->[InquiryItem]{
        var list:[InquiryItem] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> InquiryItem{
        var code = data["code"].string
        var message = data["message"].string
        var msgID = data["msgID"].string
        var txID = data["txID"].string
        var status = data["status"].string
        var currency = data["currency"].string
        var amount = data["amount"].string
        var updated = data["updated"].string
        var errMsg = data["errMsg"].string
        
        code = code == nil ? "" : code
        message = message == nil ? "" : message
        msgID = msgID == nil ? "" : msgID
        txID = txID == nil ? "" : txID
        status = status == nil ? "" : status
        currency = currency == nil ? "" : currency
        amount = amount == nil ? "" : amount
        updated = updated == nil ? "" : updated
        errMsg = errMsg == nil ? "" : errMsg
        
        return InquiryItem(code: code!, message: message!, msgID: msgID!, txID: txID!, status: status!, currency: currency!, amount: amount!, updated: updated!, errMsg: errMsg!)
    }
}
