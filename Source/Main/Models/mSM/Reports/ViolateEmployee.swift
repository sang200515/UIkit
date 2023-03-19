//
//  ViolateEmployee.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 26/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class ViolateEmployee: Jsonable{
    required init?(json: JSON) {
        EmployeeCode = json["EmployeeCode"].string;
        EmployeeName = json["EmployeeName"].string ?? "";
        JobTitleName = json["JobTitleName"].string ?? "";
        RequestByCode = json["RequestByCode"].string ?? "";
        SoTienPhat = json["SoTienPhat"].int ?? 0;
        ViolationContent = json["ViolationContent"].string ?? "";
        ViolationTimes = json["ViolationTimes"].int ?? 0;
        MonthRecord = json["MonthRecord"].string ?? "";
    }
    
    var EmployeeCode: String?;
    var EmployeeName: String?;
    var JobTitleName: String?;
    var RequestByCode: String?;
    var SoTienPhat: Int?;
    var ViolationContent: String?;
    var ViolationTimes: Int?;
    var MonthRecord: String?;
}
