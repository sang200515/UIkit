//
//  NotBoughtCompany.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 15/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class NotBoughtCompany: Jsonable{
    required init?(json: JSON) {
        ASM = json["ASM"].string ?? "";
        NgayKyHDDoanhNghiep = json["NgayKyHDDoanhNghiep"].string ?? "";
        NguoiTiepCan = json["NguoiTiepCan"].string ?? "";
        STT = json["STT"].string ?? "";
        TenDoanhNghiep = json["TenDoanhNghiep"].string ?? "";
    }
    
    var ASM: String?;
    var NgayKyHDDoanhNghiep: String?;
    var NguoiTiepCan: String?;
    var STT: String?;
    var TenDoanhNghiep: String?;
}
