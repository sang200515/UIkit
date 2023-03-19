//
//  KTMayKemPK.swift
//  fptshop
//
//  Created by DiemMy Le on 4/29/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"ASM": "Bùi Vinh Lâm",
//"SLMDMH": 414,
//"SLMay": 238,
//"SLOplung": 26,
//"SLSDP": 39,
//"STT": "1",
//"TenShop": "HNI 10-12 Cầu Diễn",
//"TyleKTMDMH": 2,
//"TyleKTOplung": 0,
//"TyleKTSDP": 0,
//"Vung": "Hà Nội"

import UIKit
import SwiftyJSON

class KTMayKemPK: Jsonable {

    var ASM: String
    var STT: String
    var Vung: String
    var TenShop: String
    var SLMDMH: Double
    var SLMay: Double
    var SLOplung: Double
    var SLSDP: Double
    var TyleKTMDMH: Double
    var TyleKTOplung: Double
    var TyleKTSDP: Double
    
    required init(json: JSON) {
        ASM = json["ASM"].string ?? "";
        STT = json["STT"].string ?? "";
        Vung = json["Vung"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        SLMDMH = json["SLMDMH"].double ?? 0.0;
        SLMay = json["SLMay"].double ?? 0.0;
        SLOplung = json["SLOplung"].double ?? 0.0;
        SLSDP = json["SLSDP"].double ?? 0.0;
        TyleKTMDMH = json["TyleKTMDMH"].double ?? 0.0;
        TyleKTOplung = json["TyleKTOplung"].double ?? 0.0;
        TyleKTSDP = json["TyleKTSDP"].double ?? 0.0;
    }
}
