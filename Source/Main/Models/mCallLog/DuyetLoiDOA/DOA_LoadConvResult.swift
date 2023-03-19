//
//  DOA_LoadConvResult.swift
//  fptshop
//
//  Created by Apple on 7/19/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"EmployeeCode": "14214",
//"EmployeeName": "Hệ thống ",
//"Message": "<br>-Thông tin kiểm tra sản phẩm 00484676 và imei 359447098274640 từ Hệ thống POS: 1-Tạo yêu cầu điều chuyển thành công.<br>-Thông tin kiểm tra sản phẩm 00484677 và imei 359447098819550 từ Hệ thống POS: 1-Tạo yêu cầu điều chuyển thành công.<br>-Thông tin kiểm tra sản phẩm 00003355 và imei SC07X454HG1HW từ Hệ thống POS: 1-Tạo yêu cầu điều chuyển thành công.<br>-Thông tin kiểm tra sản phẩm 00367556 và imei SFVFX9BGHHV22 từ Hệ thống POS: 1-Tạo yêu cầu điều chuyển thành công.",
//"TimeCreate": "/Date(1557820633163+0700)/",
//"TimeCreate_Format": "14/05/2019"

import UIKit
import SwiftyJSON

class DOA_LoadConvResult: Jsonable {
    required init(json: JSON) {
        
        EmployeeCode = json["EmployeeCode"].string ?? ""
        EmployeeName = json["EmployeeName"].string ?? ""
        Message = json["Message"].string ?? ""
        TimeCreate = json["TimeCreate"].string ?? ""
        TimeCreate_Format = json["TimeCreate_Format"].string ?? ""
    }
    
    var EmployeeCode: String?
    var EmployeeName: String?
    var Message: String?
    var TimeCreate: String?
    var TimeCreate_Format: String?
}
