//
//  DoanhSoRealtimeSLMay.swift
//  fptshop
//
//  Created by Apple on 4/9/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//let DoanhSo_May: Double
//let STT: String
//let SoLuong_May: Int
//let ASM: String
//let KhuVuc: String
//let Vung: String
//let TenShop: String
//let DoanhSo_CungKy: Double
//let SL_CungKy: Int
//let TangGiam: Double
//let TyLe: String

import UIKit
import SwiftyJSON

class DoanhSoRealtimeSLMay: Jsonable {

    required init?(json: JSON) {
        
        DoanhSo_May = json["DoanhSo_May"].double ?? 0.0;
        STT = json["STT"].string ?? "";
        SoLuong_May = json["SoLuong_May"].int ?? 0;
        ASM = json["ASM"].string ?? "";
        KhuVuc = json["KhuVuc"].string ?? "";
        Vung = json["Vung"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        DoanhSo_CungKy = json["DoanhSo_CungKy"].double ?? 0.0;
        SL_CungKy = json["SL_CungKy"].int ?? 0;
        TangGiam = json["TangGiam"].double ?? 0.0;
        TyLe = json["TyLe"].string ?? "";
    }
    
    
    var DoanhSo_May: Double
    var STT: String
    var SoLuong_May: Int
    var ASM: String
    var KhuVuc: String
    var Vung: String
    var TenShop: String
    var DoanhSo_CungKy: Double
    var SL_CungKy: Int
    var TangGiam: Double
    var TyLe: String

}
