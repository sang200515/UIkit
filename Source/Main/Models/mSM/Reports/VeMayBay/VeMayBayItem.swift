//
//  VeMayBayItem.swift
//  fptshop
//
//  Created by DiemMy Le on 2/11/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"ASM": "HuongTTM",
//"DoanhThu": 0.200000,
//"SL": 0,
//"STT": "1",
//"TenShop": "HCM 305 Tô Hiến Thành",
//KhuVuc
//Vung

import UIKit
import SwiftyJSON

class VeMayBayItem: Jsonable {

    required init(json: JSON) {
        SL = json["SL"].int ?? 0;
        DoanhThu = json["DoanhThu"].double ?? 0.0;
        STT = json["STT"].string ?? "";
        Vung = json["Vung"].string ?? "";
        ASM = json["ASM"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        KhuVuc = json["KhuVuc"].string ?? "";
    }
    
    var SL: Int
    var DoanhThu: Double
    var STT: String
    var Vung: String
    var ASM: String
    var TenShop: String
    var KhuVuc: String
}
