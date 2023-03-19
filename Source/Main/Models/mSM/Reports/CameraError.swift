//
//  CameraError.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 28/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class CameraError: Jsonable{
    required init?(json: JSON) {
        GhiChu = json["GhiChu"].string ?? "";
        LoaiLoi = json["LoaiLoi"].string ?? "";
        MaYeuCau = json["MaYeuCau"].string ?? "";
        NhanVien = json["NhanVien"].string ?? "";
        STT = json["STT"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        TrangThai = json["TrangThai"].string ?? "";
    }
    
    var GhiChu: String?;
    var LoaiLoi: String?;
    var MaYeuCau: String?;
    var NhanVien: String?;
    var STT: String?;
    var TenShop: String?;
    var TrangThai: String?;
}
