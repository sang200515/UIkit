//
//  ErrorFormat_SOM.swift
//  fptshop
//
//  Created by DiemMy Le on 3/2/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"error": {
//        "extraProperties": {},
//        "code": "32",
//        "message": "Giao dịch đang xử lý (Cần kiểm tra lại kết quả)",
//        "details": null,
//        "validationErrors": null
//    }

import UIKit
import SwiftyJSON

class ErrorFormat_SOM: NSObject {

    let rsCode: String
    let message: String
    let details: String
    let validationErrors: String
    
    init(rsCode: String, message: String, details: String, validationErrors: String) {
        self.rsCode = rsCode
        self.message = message
        self.details = details
        self.validationErrors = validationErrors
    }
    
    class func getObjFromDictionary(data:JSON) -> ErrorFormat_SOM {
        let rsCode = data["code"].stringValue
        let message = data["message"].stringValue
        let details = data["details"].stringValue
        let validationErrors = data["validationErrors"].stringValue
        
        return ErrorFormat_SOM(rsCode: rsCode, message: message, details: details, validationErrors: validationErrors)
    }
}
