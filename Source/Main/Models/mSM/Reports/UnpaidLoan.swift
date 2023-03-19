//
//  UnpaidLoan.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 28/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class UnpaidLoan: Jsonable{
    required init(json: JSON) {
        HinhThuc = json["HinhThuc"].string ?? "";
        LoaiThe = json["LoaiThe"].string ?? "";
        NhanVienSale = json["NhanVienSale"].string ?? "";
        TenASM = json["TenASM"].string ?? "";
        TenSM = json["TenSM"].string ?? "";
        TienNo = json["TienNo"].int ?? 0;
        TongThu = json["TongThu"].int ?? 0;
        TongTien = json["TongTien"].int ?? 0;
        WarehouseName = json["WarehouseName"].string ?? "";
    }
    var HinhThuc: String?;
    var LoaiThe: String?;
    var NhanVienSale: String?;
    var TenASM: String?;
    var TenSM: String?;
    var TienNo: Int?;
    var TongThu: Int?;
    var TongTien: Int?;
    var WarehouseName: String?;
}
