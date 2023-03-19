//
//  KhaiThacCombo.swift
//  fptshop
//
//  Created by Apple on 9/16/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//
//"MaNV": "29063",
//"MaShop": "30803",
//"NgayXuat": "2019-09-15",
//"SLMay3M": 0,
//"STT": "1",
//"SoComboBanKemMay": 0,
//"SoMayChuaKemCombo": 0,
//"TenNV": "Trần Hữu Nghĩa",
//"TenShop": "HCM 149 Cách Mạng Tháng Tám",
//"flagToken": null

import UIKit
import SwiftyJSON;

class KhaiThacCombo: Jsonable {
    required init(json: JSON) {
        MaNV = json["MaNV"].string ?? "";
        MaShop = json["MaShop"].string ?? "";
        NgayXuat = json["NgayXuat"].string ?? "";
        SLMay3M = json["SLMay3M"].int ?? 0;
        STT = json["STT"].string ?? "";
        SoComboBanKemMay = json["SoComboBanKemMay"].int ?? 0;
        SoMayChuaKemCombo = json["SoMayChuaKemCombo"].int ?? 0;
        TenNV = json["TenNV"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
    }
    
    var MaNV: String?;
    var MaShop: String?;
    var NgayXuat: String?;
    var SLMay3M: Int?;
    var STT: String?;
    var SoComboBanKemMay: Int?;
    var SoMayChuaKemCombo: Int?;
    var TenNV: String?;
    var TenShop: String?;
}
