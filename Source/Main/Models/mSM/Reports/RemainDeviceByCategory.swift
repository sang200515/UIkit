//
//  RemainDeviceByCategory.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 28/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class RemainDeviceByCategory: Jsonable{
    required init?(json: JSON) {
         GiaTriHangBan = json["GiaTriHangBan"].double ?? 0.0;
         NganhHang = json["NganhHang"].string ?? "";
         TonKhoBaoHanh = json["TonKhoBaoHanh"].int ?? 0;
         TonKhoChoXuLy = json["TonKhoChoXuLy"].int ?? 0;
         TonKhoHangBan = json["TonKhoHangBan"].int ?? 0;
         TonKhoKyGoi = json["TonKhoKyGoi"].int ?? 0;
         TonKhoMayCu = json["TonKhoMayCu"].int ?? 0;
         VongQuay = json["VongQuay"].double ?? 0.0;
    }
    
    var GiaTriHangBan: Double?;
    var NganhHang: String?;
    var TonKhoBaoHanh: Int?;
    var TonKhoChoXuLy: Int?;
    var TonKhoHangBan: Int?;
    var TonKhoKyGoi: Int?;
    var TonKhoMayCu: Int?;
    var VongQuay: Double?;
}
