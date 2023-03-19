//
//  ConfirmCancel.swift
//  fptshop
//
//  Created by tan on 7/21/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ConfirmCancel: NSObject {
    var error_code:String
    var error_msg:String
    
    init( error_code:String
    , error_msg:String){
        self.error_code = error_code
        self.error_msg = error_msg
    }
    
    
    class func parseObjfromArray(array:[JSON])->[ConfirmCancel]{
        var list:[ConfirmCancel] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ConfirmCancel{
        
        var error_code = data["error_code"].string
        var error_msg = data["error_msg"].string

        
        
        
        
        
        error_code = error_code == nil ? "" : error_code
        error_msg = error_msg == nil ? "" : error_msg
     
        
        
        
        return ConfirmCancel(error_code:error_code!
            , error_msg:error_msg!
        )
    }
    
}
