//
//  FRTUService_Ticket_Create.swift
//  fptshop
//
//  Created by DiemMy Le on 8/25/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"p_status": 0,
//"p_messages": "Ticket Create success",
//"p_data": {
//    "message": "Create ticket successfully.",
//    "data_id": 5954,
//    "resultCode": 200
//}

import UIKit
import SwiftyJSON

class FRTUService_Ticket_Create: NSObject {

    let p_status:Int
    let p_messages:String
    
    let message_data:String
    let data_id:Int
    let resultCode_data:Int
    
    init(p_status:Int, p_messages:String, message_data:String, data_id:Int, resultCode_data:Int) {
        self.p_status = p_status
        self.p_messages = p_messages
        self.message_data = message_data
        self.data_id = data_id
        self.resultCode_data = resultCode_data
    }
    
    class func getObjFromDictionary(data:JSON) -> FRTUService_Ticket_Create {
        
        var p_status = data["p_status"].int
        var p_messages = data["p_messages"].string
        
        let p_data = data["p_data"]
        var message_data = p_data["message"].string
        var data_id = p_data["data_id"].int
        var resultCode_data = p_data["resultCode"].int
        
        p_status = p_status == nil ? 0 : p_status
        p_messages = p_messages == nil ? "" : p_messages
        message_data = message_data == nil ? "" : message_data
        data_id = data_id == nil ? 0 : data_id
        resultCode_data = resultCode_data == nil ? 0 : resultCode_data
        
        return FRTUService_Ticket_Create(p_status: p_status!, p_messages: p_messages!, message_data: message_data!, data_id: data_id!, resultCode_data: resultCode_data!)
    }
}
