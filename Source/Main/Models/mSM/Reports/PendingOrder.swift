//
//  PendingOrder.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 15/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class PendingOrder: Jsonable{
    required init?(json: JSON) {
        HoiVien = json["HoiVien"].string ?? "";
        SDT = json["SDT"].string ?? "";
        SL = json["SL"].string ?? "";
        STT = json["STT"].string ?? "";
        SoDonHang = json["SoDonHang"].string ?? "";
        TenSanPham = json["TenSanPham"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        ThanhTien = json["ThanhTien"].string ?? "";
        TrangThaiDonHang = json["TrangThaiDonhang"].string ?? "";
    }
    
    var HoiVien: String?;
    var SDT: String?;
    var SL: String?;
    var STT: String?;
    var SoDonHang: String?;
    var TenSanPham: String?;
    var TenShop: String?;
    var ThanhTien: String?;
    var TrangThaiDonHang: String?;
}
