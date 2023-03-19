//
//  TypeId_226_GetConv.swift
//  fptshop
//
//  Created by DiemMy Le on 2/18/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"EmployeeCode": "22451",
//"EmployeeName": "Trần Thị Siêu Xuyến-BA_HT",
//"Message": "test",
//"TimeCreate": "/Date(1581318905763+0700)/",
//"TimeCreate_Format": "10/02/2020"

import UIKit
import SwiftyJSON

class TypeId_226_GetConv: Jsonable {

    required init(json: JSON) {
        EmployeeCode = json["EmployeeCode"].string ?? ""
        EmployeeName = json["EmployeeName"].string ?? ""
        Message = json["Message"].string ?? ""
        TimeCreate = json["TimeCreate"].string ?? ""
        TimeCreate_Format = json["TimeCreate_Format"].string ?? ""
    }

    var EmployeeCode: String
    var EmployeeName: String
    var Message: String
    var TimeCreate: String
    var TimeCreate_Format: String
}
