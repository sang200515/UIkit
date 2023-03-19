//
//  DSRealtimeMatKinh.swift
//  fptshop
//
//  Created by DiemMy Le on 11/14/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"DoanhSoNgay": 1291816.400000,
//"KhuVuc": "Hồ Chí Minh-KV1",
//"STT": "2",
//"SoLuong": 7,
//"TBBill": 184545.200000,
//"TenShop": "HCM 261 Khánh Hội",
//"flagToken": null

import UIKit
import SwiftyJSON

class DSRealtimeMatKinh: Jsonable {
    required init(json: JSON) {
        DoanhSoNgay = json["DoanhSoNgay"].double ?? 0.0;
        KhuVuc = json["KhuVuc"].string ?? "";
        STT = json["STT"].string ?? "";
        SoLuong = json["SoLuong"].int ?? 0;
        TBBill = json["TBBill"].double ?? 0.0;
        TenShop = json["TenShop"].string ?? "";
    }
    
    var DoanhSoNgay: Double?;
    var KhuVuc: String?;
    var STT: String?;
    var SoLuong: Int?;
    var TBBill: Double?;
    var TenShop: String?;
}
