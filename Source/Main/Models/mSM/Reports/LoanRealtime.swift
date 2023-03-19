//
//  LoanRealtime.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 05/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class LoanRealtime: Jsonable{
    required init?(json: JSON) {
        SLSOHoanTat = json["SLSOHoanTat"].int ?? 0;
        DoanhThuTraGop = json["DoanhThuTraGop"].int ?? 0;
        SL_TraGop_NH = json["SL_TraGop_NH"].int ?? 0;
        SoLuong_SVFC = json["SoLuong_SVFC"].int ?? 0;
        SoLuong_FEC = json["SoLuong_FEC"].int ?? 0;
        SoLuong_HC = json["SoLuong_HC"].int ?? 0;
        SoLuong_HDS = json["SoLuong_HDS"].int ?? 0;
        TiTrongTraGop = json["TiTrongTraGop"].string ?? "";
        Total = json["Total"].int ?? 0;
        VungMien = json["VungMien"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        KhuVung = json["KhuVung"].string ?? "";
    }
    
    var SLSOHoanTat: Int?;
    var DoanhThuTraGop: Int?;
    var SL_TraGop_NH: Int?;
    var SoLuong_SVFC: Int?;
    var SoLuong_FEC: Int?;
    var SoLuong_HC: Int?;
    var SoLuong_HDS: Int?;
    var TiTrongTraGop: String?;
    var Total: Int?;
    var VungMien: String?;
    var TenShop: String?;
    var KhuVung: String?;
}
