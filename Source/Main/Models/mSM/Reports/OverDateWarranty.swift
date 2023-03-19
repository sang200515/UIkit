//
//  OverDateWarranty.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 16/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class OverDateWarranty: Jsonable{
    required init?(json: JSON) {
        HinhThuc = json["HinhThuc"].string ?? "";
        KieuChuyen = json["KieuChuyen"].string ?? "";
        MaBaoHanh = json["MaBaoHanh"].string ?? "";
        MaSP = json["MaSP"].string ?? "";
        MaSPBaoHanh = json["MaSPBaoHanh"].string ?? "";
        NgayTao = json["NgayTao"].string ?? "";
        STT = json["STT"].int ?? 0;
        SoNgayConLai = json["SoNgayConLai"].int ?? 0;
        TenShop = json["TenShop"].string ?? "";
        TrangThai = json["TrangThai"].string ?? "";
    }
    
    var HinhThuc: String?;
    var KieuChuyen: String?;
    var MaBaoHanh: String?;
    var MaSP: String?;
    var MaSPBaoHanh: String?;
    var NgayTao: String?;
    var STT: Int?;
    var SoNgayConLai: Int?;
    var TenShop: String?;
    var TrangThai: String?;
}
