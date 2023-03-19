//
//  InstallmentRate.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class InstallmentRate: Jsonable{
    required init?(json: JSON) {
        VungMien = json["VungMien"].string ?? "";
        LoaiTraGop = json["LoaiTraGop"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        NhaTraGop = json["NhaTraGop"].string ?? "";
        Huy = json["Huy"].int ?? 0;
        PheDuyet = json["PheDuyet"].int ?? 0;
        TuChoi = json["TuChoi"].int ?? 0;
        Tong = json["Tong"].int ?? 0;
        TyLe = json["TyLe"].string ?? "";
    }
    
    var VungMien: String?;
    var LoaiTraGop: String?;
    var TenShop: String?;
    var NhaTraGop: String?;
    var Huy: Int?;
    var PheDuyet: Int?;
    var TuChoi: Int?;
    var Tong: Int?;
    var TyLe: String?;
}
