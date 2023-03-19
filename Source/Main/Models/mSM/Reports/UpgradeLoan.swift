//
//  UpgradeLoan.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 26/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class UpgradeLoan: Jsonable{
    required init?(json: JSON) {
        PT_Target = (json["PT_Target"].double) ?? 0.0;
        PT_Target_UocTinh = (json["PT_Target_UocTinh"].double) ?? 0.0;
        SL_BanTG_36 = (json["SL_BanTG_36"].int) ?? 0;
        SL_BanThang_13 = (json["SL_BanThang_13"].int) ?? 0;
        TB_13 = (json["TB_13"].int) ?? 0;
        TB_36 = (json["TB_36"].int) ?? 0;
        Target_TG = (json["Target_TG"].int) ?? 0;
        TenNV = (json["TenNV"].string) ?? "";
        TenVietTat = (json["TenVietTat"].string) ?? "";
        TienThuong = (json["TienThuong"].int) ?? 0;
        UocTinh = (json["UocTinh"].int) ?? 0;
    }
    
    var PT_Target: Double?;
    var PT_Target_UocTinh: Double?;
    var SL_BanTG_36: Int?;
    var SL_BanThang_13: Int?;
    var TB_13: Int?;
    var TB_36: Int?;
    var Target_TG: Int?;
    var TenNV: String?;
    var TenVietTat: String?;
    var TienThuong: Int?;
    var UocTinh: Int?;
}
