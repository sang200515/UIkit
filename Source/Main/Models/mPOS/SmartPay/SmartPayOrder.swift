//
//  SmartPayOrder.swift
//  fptshop
//
//  Created by Ngo Dang tan on 3/13/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
import Foundation
import SwiftyJSON
class SmartPayOrder: NSObject {
    var transId:String
    var amount:Float
    var created:String
    var orderNo:String
    var signature:String
    var status:String
    
    init(   transId:String
      , amount:Float
      , created:String
      , orderNo:String
      , signature:String
        ,status:String){
        self.transId = transId
        self.amount = amount
        self.created = created
        self.orderNo = orderNo
        self.signature = signature
        self.status = status
        
    }
    
    class func parseObjfromArray(array:[JSON])->[SmartPayOrder]{
        var list:[SmartPayOrder] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> SmartPayOrder{
        var transId = data["transId"].string
        var amount = data["amount"].float
        var created = data["created"].string
        var orderNo = data["orderNo"].string
        var signature = data["signature"].string
        var status = data["status"].string
        
        
        transId = transId == nil ? "" : transId
        amount = amount == nil ? 0 : amount
        created = created == nil ? "" : created
        orderNo = orderNo == nil ? "" : orderNo
        signature = signature == nil ? "" : signature
        status = status == nil ? "" : status
        return SmartPayOrder(transId:transId!
            , amount:amount!
            , created:created!
            , orderNo:orderNo!
            ,signature:signature!
            ,status:status!)
    }
    
    
}
