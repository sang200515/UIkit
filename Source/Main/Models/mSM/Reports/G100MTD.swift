//
//  G100MTD.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 10/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class G100MTD: Jsonable{
    required init?(json: JSON) {
        DoanhSoMTD = json["DoanhSoMTD"].double ?? 0.0;
        DoanhSoPK = json["DoanhSoPK"].double ?? 0.0;
        LoiKhenTN = json["LoiKhen_TN"].int ?? 0;
        LoiKhenTT = json["LoiKhen_TT"].int ?? 0;
        PhanTramHTTarget = json["PhanTramHTTarget"].double ?? 0.0;
        PhanTramSOMTD = json["PhanTramSOMTD"].double ?? 0.0;
        PhanTramTangGiamLK = json["PhanTramTangGiamLK"].double ?? 0.0;
        PhanTramTangGiamSL = json["PhanTramTangGiamSL"].double ?? 0.0;
        SLHopDongTraGop = json["SLHopDongTraGop"].int ?? 0;
        SLMayTN = json["SLMay_TN"].int ?? 0;
        SLMayTT = json["SLMay_TT"].int ?? 0;
        SoLuongSSD = json["SoLuongSSD"].int ?? 0;
        TargetSLMay = json["TargetSLMay"].int ?? 0;
        TenASM = json["TenASM"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        TyTrongPK = json["TyTrongPK"].double ?? 0.0;
        SLPK_TN = json["SLPK_TN"].int ?? 0;
        SLPK_TNSLMay_TN = json["SLPK_TNSLMay_TN"].double ?? 0.0;
    }
    
    var DoanhSoMTD: Double?;
    var DoanhSoPK: Double?;
    var LoiKhenTN: Int?;
    var LoiKhenTT: Int?;
    var PhanTramHTTarget: Double?;
    var PhanTramSOMTD: Double?;
    var PhanTramTangGiamLK: Double?;
    var PhanTramTangGiamSL: Double?;
    var SLHopDongTraGop: Int?;
    var SLMayTN: Int?;
    var SLMayTT: Int?;
    var SoLuongSSD: Int?;
    var TargetSLMay: Int?;
    var TenASM: String?;
    var TenShop: String?;
    var TyTrongPK: Double?;
    var SLPK_TN: Int?;
    var SLPK_TNSLMay_TN: Double?;
}
