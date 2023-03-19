//
//  ReceiptCodeEx.swift
//  fptshop
//
//  Created by tan on 7/12/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ReceiptCodeEx: NSObject {
    var service_code:String
    var object_receipt_type:String
    var error_code:String
    var error_msg:String
    
    init( service_code:String
    , object_receipt_type:String
    , error_code:String
        ,error_msg:String){
        self.service_code = service_code
        self.object_receipt_type = object_receipt_type
        self.error_code = error_code
        self.error_msg = error_msg
    }
    
    class func parseObjfromArray(array:[JSON])->[ReceiptCodeEx]{
        var list:[ReceiptCodeEx] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ReceiptCodeEx{
        
  
        var service_code = data["service_code"].string
        var object_receipt_type = data["object_receipt_type"].string
        var error_code = data["error_code"].string
        var error_msg = data["error_msg"].string
        
        
        
        
        

        service_code = service_code == nil ? "" : service_code
        object_receipt_type = object_receipt_type == nil ? "" : object_receipt_type
        error_code = error_code == nil ? "" : error_code
        error_msg = error_msg == nil ? "" : error_msg
        
        
        
        return ReceiptCodeEx(service_code:service_code!
            , object_receipt_type:object_receipt_type!
            , error_code:error_code!
            , error_msg:error_msg!
            
        )
    }
}
