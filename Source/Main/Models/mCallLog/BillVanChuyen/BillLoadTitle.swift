//
//  BillLoadTitle.swift
//  fptshop
//
//  Created by Apple on 5/6/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"EmployeeCode": "6087",
//"EmployeeName": "Mai Xuân Hoàng Việt",
//"Title": "Bill Vận chuyển - Hồ Chí Minh - Nhóm Call Log - 06/05/2019"

import Foundation
import SwiftyJSON

class BillLoadTitle: Jsonable {

    required init(json: JSON) {
        EmployeeCode = json["EmployeeCode"].string ?? "";
        EmployeeName = json["EmployeeName"].string ?? "";
        Title = json["Title"].string ?? "";
        
    }
    
    var EmployeeCode: String?
    var EmployeeName: String?
    var Title: String?

}
