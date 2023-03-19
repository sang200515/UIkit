//
//  CheckInfoTHSmartPay.swift
//  fptshop
//
//  Created by DiemMy Le on 8/20/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"requestId": "20200820130104-frt-checkinfo",
//"contractNo": "1500010000000238",
//"idCardNumber": "***2333",
//"customerName": "TEST TEST TEST",
//"overdueAmount": "0",
//"minAmount": "0",
//"paymentDueDate": "2020-09-09",
//"providerCode": "FEC"

import UIKit
import SwiftyJSON

class CheckInfoTHSmartPay: NSObject {
    
    let requestId:String
    let contractNo:String
    let idCardNumber:String
    let customerName:String
    let overdueAmount:String
    let minAmount:String
    let paymentDueDate:String
    let providerCode:String
    
    init(requestId:String, contractNo:String, idCardNumber:String, customerName:String, overdueAmount:String, minAmount:String, paymentDueDate:String, providerCode:String) {
        
        self.requestId = requestId
        self.contractNo = contractNo
        self.idCardNumber = idCardNumber
        self.customerName = customerName
        self.overdueAmount = overdueAmount
        self.minAmount = minAmount
        self.paymentDueDate = paymentDueDate
        self.providerCode = providerCode
    }
    
    class func getObjFromDictionary(data:JSON) -> CheckInfoTHSmartPay {
        
        var requestId = data["requestId"].string
        var contractNo = data["contractNo"].string
        var idCardNumber = data["idCardNumber"].string
        var customerName = data["customerName"].string
        var overdueAmount = data["overdueAmount"].string
        var minAmount = data["minAmount"].string
        var paymentDueDate = data["paymentDueDate"].string
        var providerCode = data["providerCode"].string
        
        requestId = requestId == nil ? "" : requestId
        contractNo = contractNo == nil ? "" : contractNo
        idCardNumber = idCardNumber == nil ? "" : idCardNumber
        customerName = customerName == nil ? "" : customerName
        overdueAmount = overdueAmount == nil ? "" : overdueAmount
        minAmount = minAmount == nil ? "" : minAmount
        paymentDueDate = paymentDueDate == nil ? "" : paymentDueDate
        providerCode = providerCode == nil ? "" : providerCode
        
        return CheckInfoTHSmartPay(requestId: requestId!, contractNo: contractNo!, idCardNumber: idCardNumber!, customerName: customerName!, overdueAmount: overdueAmount!, minAmount: minAmount!, paymentDueDate: paymentDueDate!, providerCode: providerCode!)
    }
}

class RepaySmartpayVoucher {
    let voucher:String
    let voucher_name:String
    let date_from:String
    let date_to:String
    
    init(voucher:String, voucher_name:String, date_from:String, date_to:String) {
        self.voucher = voucher
        self.voucher_name = voucher_name
        self.date_from = date_from
        self.date_to = date_to
    }
    
    class func getObjFromDictionary(data:JSON) -> RepaySmartpayVoucher {
        let voucher = data["voucher"].stringValue
        let voucher_name = data["voucher_name"].stringValue
        let date_from = data["date_from"].stringValue
        let date_to = data["date_to"].stringValue
        
        return RepaySmartpayVoucher(voucher: voucher, voucher_name: voucher_name, date_from: date_from, date_to: date_to)
    }
}
