//
//  BHMR.swift
//  fptshop
//
//  Created by DiemMy Le on 2/3/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"SLBHMR_DTDD": 0.000000,
//"SLBHMR_MTB_MTXT": 0.000000,
//"SLSP_DTDD": 0.000000,
//"SLSP_MTB_MTXT": 0.000000,
//"STT": "",
//"TyleKhaiThac_DTDD": 0.000000,
//"TyleKhaiThac_MTB_MTXT": 0.000000,
//"Vung": "",
//Khuvuc

//"ASM": "AnNT1",
//"DoanhThuBHMR": 0.00,
//"Khuvuc": "Miền Bắc 2-KV0",
//"SLBHMR_DTDD": 0.00,
//"SLBHMR_MTB_MTXT": 0.00,
//"SLSP_DTDD": 781.00,
//"SLSP_MTB_MTXT": 118.00,
//"STT": "1",
//"TongBHMR": 0.00,
//"TyleKhaiThac_DTDD": 0.00,
//"TyleKhaiThac_MTB_MTXT": 0.00,

import UIKit

import SwiftyJSON

class BHMR: Jsonable {

    required init(json: JSON) {
        SLBHMR_DTDD = json["SLBHMR_DTDD"].double ?? 0.0;
        SLBHMR_MTB_MTXT = json["SLBHMR_MTB_MTXT"].double ?? 0.0;
        SLSP_DTDD = json["SLSP_DTDD"].double ?? 0.0;
        SLSP_MTB_MTXT = json["SLSP_MTB_MTXT"].double ?? 0.0;
        TyleKhaiThac_DTDD = json["TyleKhaiThac_DTDD"].double ?? 0.0;
        TyleKhaiThac_MTB_MTXT = json["TyleKhaiThac_MTB_MTXT"].double ?? 0.0;
        STT = json["STT"].string ?? "";
        Vung = json["Vung"].string ?? "";
        ASM = json["ASM"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        Khuvuc = json["Khuvuc"].string ?? "";
        DoanhThuBHMR = json["DoanhThuBHMR"].double ?? 0.0;
        TongBHMR = json["TongBHMR"].double ?? 0.0;
    }
    
    var SLBHMR_DTDD: Double
    var SLBHMR_MTB_MTXT: Double
    var SLSP_DTDD: Double
    var SLSP_MTB_MTXT: Double
    var TyleKhaiThac_DTDD: Double
    var TyleKhaiThac_MTB_MTXT: Double
    var STT: String
    var Vung: String
    var ASM: String
    var TenShop: String
    var Khuvuc: String
    var DoanhThuBHMR: Double
    var TongBHMR: Double
}

class BHMR_NewTest: Jsonable {

    required init(json: JSON) {
        STT = json["STT"].string ?? "";
        Vung = json["Vung"].string ?? "";
        ASM = json["ASM"].string ?? "";
        Shop = json["Shop"].string ?? "";
        Khuvuc = json["Khuvuc"].string ?? "";
        DoanhThu = json["DoanhThu"].double ?? 0.0;
        SoLuong = json["SoLuong"].double ?? 0.0;
        
        DoanhThuBHMR = json["DoanhThuBHMR"].double ?? 0.0;
        LaiGop = json["LaiGop"].double ?? 0.0;
        SLBHMR = json["SLBHMR"].int ?? 0;
        KhuvucRealtime = json["KhuVuc"].string ?? "";
        PTLaiGop = json["PTLaiGop"].double ?? 0.0;
    }
    
    var STT: String
    var Vung: String
    var ASM: String
    var Shop: String
    var Khuvuc: String
    var DoanhThu: Double
    var SoLuong: Double
    
    var DoanhThuBHMR: Double
    var LaiGop: Double
    var SLBHMR: Int
    var KhuvucRealtime: String
    var PTLaiGop: Double
}
