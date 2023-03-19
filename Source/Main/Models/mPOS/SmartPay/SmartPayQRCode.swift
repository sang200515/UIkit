//
//  SmartPayQRCode.swift
//  fptshop
//
//  Created by Ngo Dang tan on 3/13/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class SmartPayQRCode: NSObject {
    var payload:String
    var prepayId:String
    var orderNo:String
    var signature:String
    
    init(  payload:String
        , prepayId:String
        , orderNo:String
        , signature:String){
        self.payload = payload
        self.prepayId = prepayId
        self.orderNo = orderNo
        self.signature = signature
    }
    
    class func parseObjfromArray(array:[JSON])->[SmartPayQRCode]{
        var list:[SmartPayQRCode] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> SmartPayQRCode{
        var payload = data["payload"].string
        var prepayId = data["prepayId"].string
        var orderNo = data["orderNo"].string
        var signature = data["signature"].string
        
        
        payload = payload == nil ? "" : payload
        prepayId = prepayId == nil ? "" : prepayId
        orderNo = orderNo == nil ? "" : orderNo
        signature = signature == nil ? "" : signature
        
        return SmartPayQRCode(payload:payload!
            , prepayId:prepayId!
            , orderNo:orderNo!
            , signature:signature!)
    }
    
}
