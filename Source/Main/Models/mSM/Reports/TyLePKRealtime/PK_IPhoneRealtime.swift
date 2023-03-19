//
//  PK_IPhoneRealtime.swift
//  fptshop
//
//  Created by DiemMy Le on 6/25/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
import UIKit
import SwiftyJSON

class PK_IPhoneRealtime: Jsonable {
    var STT: String
    var DoanhSo_Iphone: String
    var DoanhSo_None_Iphone: String
    var DoanhSo_PK: String
    var DoanhSo_PKNK: String
    var TyLe_PhuKien_ALL: String
    var TyLe_PhuKien_IPhone: String
    var Vung: String
    var TenKV: String
    var TenASM: String
    
    required init(json: JSON) {
        STT = json["STT"].string ?? "";
        DoanhSo_Iphone = json["DoanhSo_Iphone"].string ?? "";
        DoanhSo_None_Iphone = json["DoanhSo_None_Iphone"].string ?? "";
        DoanhSo_PK = json["DoanhSo_PK"].string ?? "";
        DoanhSo_PKNK = json["DoanhSo_PKNK"].string ?? "";
        TyLe_PhuKien_ALL = json["TyLe_PhuKien_ALL"].string ?? "";
        TyLe_PhuKien_IPhone = json["TyLe_PhuKien_IPhone"].string ?? "";
        Vung = json["Vung"].string ?? "";
        TenASM = json["TenASM"].string ?? "";
        TenKV = json["TenKV"].string ?? "";
    }
}
