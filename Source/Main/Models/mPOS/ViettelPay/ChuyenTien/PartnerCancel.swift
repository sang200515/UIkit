//
//  PartnerCancel.swift
//  fptshop
//
//  Created by tan on 8/2/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class PartnerCancel: NSObject {
    var error_code:String
    var trans_date:String
    var original_trans_id:String
    var cust_fee_back:Bool
    var cust_fee_back_msg:String
    var error_msg:String
    
    init(error_code:String
    , trans_date:String
    , original_trans_id:String
    , cust_fee_back:Bool
    , cust_fee_back_msg:String
    , error_msg:String){
        self.error_code = error_code
        self.trans_date = trans_date
        self.original_trans_id = original_trans_id
        self.cust_fee_back = cust_fee_back
        self.cust_fee_back_msg = cust_fee_back_msg
        self.error_msg = error_msg
    }
    
    class func parseObjfromArray(array:[JSON])->[PartnerCancel]{
        var list:[PartnerCancel] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> PartnerCancel{
        
        
        var error_code = data["error_code"].string
        var trans_date = data["trans_date"].string
        var original_trans_id = data["original_trans_id"].string
        var cust_fee_back = data["cust_fee_back"].bool
        var cust_fee_back_msg = data["cust_fee_back_msg"].string
        var error_msg = data["error_msg"].string
        
        
        
        
        
        
        error_code = error_code == nil ? "" : error_code
        trans_date = trans_date == nil ? "" : trans_date
        original_trans_id = original_trans_id == nil ? "" : original_trans_id
        cust_fee_back = cust_fee_back == nil ? false : cust_fee_back
        cust_fee_back_msg = cust_fee_back_msg == nil ? "" : cust_fee_back_msg
        error_msg = error_msg == nil ? "" : error_msg
        
        return PartnerCancel(error_code:error_code!
            , trans_date:trans_date!
            , original_trans_id:original_trans_id!
            , cust_fee_back:cust_fee_back!
            , cust_fee_back_msg:cust_fee_back_msg!
            , error_msg:error_msg!
            
        )
    }
}
