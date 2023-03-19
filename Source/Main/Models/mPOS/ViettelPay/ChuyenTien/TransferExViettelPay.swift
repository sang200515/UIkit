//
//  TransferExViettelPay.swift
//  fptshop
//
//  Created by tan on 6/27/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class TransferViettelPay: NSObject {
    var error_code:String

    var error_msg:String
    var order_id:String
    var trans_id:String
    
    var nameSender:String
    var phoneSender:String
    var nameReceiver:String
    var phoneReceiver:String
    var id_numberSender:String
    var id_numberReceiver:String

    
    
    
    init( error_code:String

    , error_msg:String
        ,order_id:String
        ,trans_id:String
    , nameSender:String
    , phoneSender:String
    , nameReceiver:String
    , phoneReceiver:String
        ,id_numberSender:String
        ,id_numberReceiver:String){
        self.error_code = error_code
   
        self.error_msg = error_msg
        self.order_id = order_id
        self.trans_id = trans_id
        
        self.nameSender = nameSender
        self.phoneSender = phoneSender
        self.nameReceiver = nameReceiver
        self.phoneReceiver = phoneReceiver
        self.id_numberSender = id_numberSender
        self.id_numberReceiver = id_numberReceiver
    }
    
    class func parseObjfromArray(array:[JSON])->[TransferViettelPay]{
        var list:[TransferViettelPay] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> TransferViettelPay{
        
        var error_code = data["error_code"].string
        var error_msg = data["error_msg"].string
        var order_id = data["order_id"].string
        var trans_id = data["trans_id"].string
        
        
        
        
        
        error_code = error_code == nil ? "" : error_code
        error_msg = error_msg == nil ? "" : error_msg
        order_id = order_id == nil ? "" : order_id
        trans_id = trans_id == nil ? "" : trans_id
  

        
        
        return TransferViettelPay(  error_code:error_code!
            , error_msg:error_msg!
            ,order_id:order_id!
            ,trans_id:trans_id!
        , nameSender:""
        , phoneSender:""
        , nameReceiver:""
        , phoneReceiver:""
            ,id_numberSender:""
            ,id_numberReceiver:"")
    }
}
