//
//  ResponsePG.swift
//  CheckIn
//
//  Created by Apple on 1/19/19.
//  Copyright © 2019 Apple. All rights reserved.
//

//{
//    "Code": "001",
//    "Data": {
//        "Result": 1,
//        "Message": "Success",
//        "EmployeeCode": "U35426",
//        "EmployeeName": "Nguyễn Văn A",
//        "BirthYear": 1990,
//        "IDCard": "456434221",
//        "Phone": "0936500322",
//        "VendorName": "CÔNG TY TNHH SAMSUNG ELECTRONICS VIỆT NAM THÁI NGUYÊN – CHI NHÁNH THÀNH PHỐ HỒ CHÍ MINH",
//        "IsCheckIn": false
//    },
//    "Detail": "Success"
//}

import UIKit
import SwiftyJSON

class ResponsePG: NSObject {
    
    let Code: String
    let mdata: PGInfo
    let Detail: String
    
    init(Code: String, mdata: PGInfo, Detail: String) {
        self.Code = Code
        self.mdata = mdata
        self.Detail = Detail
    }
    
//    class func getObjFromDictionary(data:JSON) -> ResponsePG{
//        var Code = data["Code"].string
//        let mdata = data["Data"].dictionaryObject
//        var Detail = data["Detail"].string
//        
//        Code = Code == nil ? "" : Code
//        Detail = Detail == nil ? "" : Detail
//        
////        return ResponsePG(Code: Code!, mdata: mdata ?? PGInfo(Result: 0, Message: "", EmployeeCode: "", EmployeeName: "", BirthYear: 0, IDCard: "", Phone: "", VendorName: "", IsCheckIn: false), Detail: Detail!)
//        
//        return ResponsePG(Code: Code!, mdata: mdata!, Detail: Detail!)
//    }

}
