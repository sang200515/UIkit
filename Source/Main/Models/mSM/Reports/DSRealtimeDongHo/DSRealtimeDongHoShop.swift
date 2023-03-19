//
//  DSRealtimeDongHoShop.swift
//  fptshop
//
//  Created by DiemMy Le on 12/30/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"DoanhSoNgay": 0.000000,
//"Vung": "",
//"STT": "",
//"SoLuong": 0.000000,
//"TBBill": 0.000000,
//"TenShop": "Tổng",

import UIKit
import SwiftyJSON

class DSRealtimeDongHoShop: Jsonable {

    required init(json: JSON) {
        DoanhSoNgay = json["DoanhSoNgay"].double ?? 0.0;
        Vung = json["Vung"].string ?? "";
        STT = json["STT"].string ?? "";
        SoLuong = json["SoLuong"].double ?? 0.0;
        TBBill = json["TBBill"].double ?? 0.0;
        TenShop = json["TenShop"].string ?? "";
    }
    
    var DoanhSoNgay: Double?;
    var Vung: String?;
    var STT: String?;
    var SoLuong: Double?;
    var TBBill: Double?;
    var TenShop: String?;
}
