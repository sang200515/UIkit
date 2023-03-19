//
//  ShiftList.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 15/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class UserShift: Jsonable{
    required init?(json: JSON) {
        EmployeeCode = json["EmployeeCode"].string ?? "";
        EndTime = json["EndTime"].string ?? "";
        ShiftCode = json["ShiftCode"].string ?? "";
        ShiftDate = json["ShiftDate"].string ?? "";
        StartTime = json["StartTime"].string ?? "";
        Type = json["Type"].int ?? 0;
        UserID = json["UserID"].int ?? 0;
    }
    
    var EmployeeCode: String?;
    var EndTime: String?;
    var ShiftCode: String?;
    var ShiftDate: String?;
    var StartTime: String?;
    var `Type`: Int?;
    var UserID: Int?;
}
