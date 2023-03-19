//
//  TotalLoanByShop.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 15/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class TotalLoanByShop: Jsonable {
    required init?( json: JSON) {
        Name = json["Name"].string ?? "";
        NoChuaDenHan = json["NoChuaDenHan"].string ?? "";
        NoDenHan = json["NoDenHan"].string ?? "";
        NoQuaHan = json["NoQuaHan"].string ?? "";
        NoDuoi30Ngay = json["NoDuoi30Ngay"].string ?? "";
        NoTren30Ngay = json["NoTren30Ngay"].string ?? "";
        NoTren60Ngay = json["NoTren60Ngay"].string ?? "";
        NoTren90Ngay = json["NoTren90Ngay"].string ?? "";
        STT = json["STT"].string ?? "";
        TongNoHienTai = json["TongNoHienTai"].string ?? "";
        NoQuaHan = json["NoQuaHan"].string ?? "";
    }
    
    var Name: String?;
    var NoChuaDenHan: String?;
    var NoDenHan: String?;
    var NoQuaHan: String
    var NoDuoi30Ngay: String?;
    var NoTren30Ngay: String?;
    var NoTren60Ngay: String?;
    var NoTren90Ngay: String?;
    var STT: String?;
    var TongNoHienTai: String?;
}
