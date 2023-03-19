//
//  TyLePhuKien_Realtime.swift
//  fptshop
//
//  Created by DiemMy Le on 6/25/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
import UIKit
import SwiftyJSON

class TyLePhuKien_Realtime: Jsonable {
    var DoanhSo_All: String
    var DoanhSo_PK: String
    var STT: String
    var TyLe_PhuKien_ALL: String
    var TyTrong_Combo_10: String
    var TyTrong_Combo_15: String
    var TyTrong_Combo_20: String
    var Vung: String
    var TenASM: String
    var TenKV: String
    
    required init(json: JSON) {
        DoanhSo_All = json["DoanhSo_All"].string ?? "";
        DoanhSo_PK = json["DoanhSo_PK"].string ?? "";
        STT = json["STT"].string ?? "";
        TyLe_PhuKien_ALL = json["TyLe_PhuKien_ALL"].string ?? "";
        TyTrong_Combo_10 = json["TyTrong_Combo_10"].string ?? "";
        TyTrong_Combo_15 = json["TyTrong_Combo_15"].string ?? "";
        TyTrong_Combo_20 = json["TyTrong_Combo_20"].string ?? "";
        Vung = json["Vung"].string ?? "";
        TenASM = json["TenASM"].string ?? "";
        TenKV = json["TenKV"].string ?? "";
    }
}
