//
//  InitTransferEx.swift
//  fptshop
//
//  Created by tan on 7/16/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class InitTransferEx: NSObject {
    var error_code:String
    var error_msg:String
    var confirm_code:String
    var receipt_code:String
    var original_order_id:String
    var order_id:String
    
    init(  error_code:String
    , error_msg:String
    , confirm_code:String
    , receipt_code:String
        ,original_order_id:String
        ,order_id:String){
        self.error_code = error_code
        self.error_msg = error_msg
        self.confirm_code = confirm_code
        self.receipt_code = receipt_code
        self.original_order_id = original_order_id
        self.order_id = order_id
    }
    
    class func parseObjfromArray(array:[JSON])->[InitTransferEx]{
        var list:[InitTransferEx] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> InitTransferEx{
        
        var error_code = data["error_code"].string
        var error_msg = data["error_msg"].string
        var confirm_code = data["confirm_code"].string
        var receipt_code = data["receipt_code"].string
        var original_order_id = data["original_order_id"].string
        var order_id = data["order_id"].string
        
        
        
        
        
        error_code = error_code == nil ? "" : error_code
        error_msg = error_msg == nil ? "" : error_msg
        confirm_code = confirm_code == nil ? "" : confirm_code
        receipt_code = receipt_code == nil ? "" : receipt_code
        original_order_id = original_order_id == nil ? "" : original_order_id
        order_id = order_id == nil ? "" : order_id
        
        
        
        return InitTransferEx(error_code:error_code!
            , error_msg:error_msg!
            , confirm_code:confirm_code!
            , receipt_code:receipt_code!
            , original_order_id:original_order_id!
            , order_id:order_id!
        )
    }
}
