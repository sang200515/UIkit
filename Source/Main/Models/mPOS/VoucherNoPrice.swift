//
//  VoucherNoPrice.swift
//  fptshop
//
//  Created by Ngo Dang tan on 7/6/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class VoucherNoPrice: NSObject {
    var VC_Code:String
    var VC_Name:String
    var Endate:String
    var U_OTPcheck:String
    var STT:Int
    var isSelected:Bool
    
    
    init(VC_Code:String
        , VC_Name:String
        , Endate:String
        , U_OTPcheck:String
        , STT:Int
        ,isSelected:Bool){
        self.VC_Code = VC_Code
        self.VC_Name = VC_Name
        self.Endate = Endate
        self.U_OTPcheck = U_OTPcheck
        self.STT = STT
        self.isSelected = isSelected
    }
    
    class func parseObjfromArray(array:[JSON])->[VoucherNoPrice]{
        var list:[VoucherNoPrice] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> VoucherNoPrice{
        var VC_Code = data["VC_Code"].string
        var VC_Name = data["VC_Name"].string
        var Endate = data["Endate"].string
        var U_OTPcheck = data["U_OTPcheck"].string
        var STT = data["STT"].int
      
        
        VC_Code = VC_Code == nil ? "" : VC_Code
        VC_Name = VC_Name == nil ? "" : VC_Name
        Endate = Endate == nil ? "" : Endate
        U_OTPcheck = U_OTPcheck == nil ? "" : U_OTPcheck
        STT = STT == nil ? 0 : STT
        
        
        return VoucherNoPrice(VC_Code:VC_Code!, VC_Name:VC_Name!, Endate:Endate!,U_OTPcheck:U_OTPcheck!,STT:STT!,isSelected:false)
    }
}

class AirpayResponse: NSObject {
    static var storeLocation:String = ""
    static var traceId:String = ""
    static let transactionType:Int = 13 //set default
    static var amount:Double = 0
 
    var qrcode: String
    var qrcodeImageUrl: String
    var amount: Double
    var orderId: String
    var storeLocation: String
    var traceId: String
    init(qrcode: String, qrcodeImageUrl: String, amount: Double, orderId: String, storeLocation:String , traceId:String) {
        self.qrcode = qrcode
        self.qrcodeImageUrl = qrcodeImageUrl
        self.amount = amount
        self.orderId = orderId
        self.storeLocation = storeLocation
        self.traceId = traceId
    }
    
    
    class func getObjFromDictionary(data:JSON) -> AirpayResponse{
        let qrcode = data["qrcode"].stringValue
        let qrcodeImageUrl = data["qrcodeImageUrl"].stringValue
        let amount = data["amount"].doubleValue
        let orderId = data["orderId"].stringValue
        let storeLocation = data["storeLocation"].stringValue
        let traceId = data["traceId"].stringValue
        
        return AirpayResponse(qrcode: qrcode, qrcodeImageUrl: qrcodeImageUrl, amount: amount, orderId: orderId, storeLocation: storeLocation, traceId: traceId)
    }
}

class AirpayError: NSObject {
    var code: String
    var message:String
    
    init(code:String, message: String) {
        self.code = code
        self.message = message
    }
    
    class func getObjFromDictionary(data:JSON) -> AirpayError{
        let code = data["code"].stringValue
        let message = data["message"].stringValue
        
        return AirpayError(code: code, message: message)
    }
}

class AirpayStatus: NSObject {
    
    var code: String
    var messages: String
    var partnerOrderId: String
    var refundedAmount: Double
    var amount: Double
    var orderId: String
    
    init(code: String, messages: String, partnerOrderId: String, refundedAmount: Double, amount: Double, orderId: String) {
        self.code = code
        self.messages = messages
        self.partnerOrderId = partnerOrderId
        self.refundedAmount = refundedAmount
        self.amount = amount
        self.orderId = orderId
    }
    
    class func getObjFromDictionary(data:JSON) -> AirpayStatus{
        let code =  data["code"].stringValue
        let  messages = data["messages"].stringValue
        let  partnerOrderId = data["partnerOrderId"].stringValue
        let refundedAmount = data["refundedAmount"].doubleValue
        let amount = data["amount"].doubleValue
        let orderId = data["orderId"].stringValue
        
        return AirpayStatus(code: code, messages: messages, partnerOrderId: partnerOrderId, refundedAmount: refundedAmount, amount: amount, orderId: orderId)
    }
}

class FoxpayStatus: NSObject {
    
    var paymentStatus: String
    var paymentMessages: String
    var amount: Double
    var orderId: String
    
    init(paymentStatus: String, paymentMessages: String, amount: Double, orderId: String) {
        self.paymentStatus = paymentStatus
        self.paymentMessages = paymentMessages
        self.amount = amount
        self.orderId = orderId
    }
    
    class func getObjFromDictionary(data:JSON) -> FoxpayStatus {
        let paymentStatus =  data["paymentStatus"].stringValue
        let paymentMessages = data["paymentMessages"].stringValue
        let amount = data["amount"].doubleValue
        let orderId = data["orderId"].stringValue
        
        return FoxpayStatus(paymentStatus: paymentStatus, paymentMessages: paymentMessages, amount: amount, orderId: orderId)
    }
}
