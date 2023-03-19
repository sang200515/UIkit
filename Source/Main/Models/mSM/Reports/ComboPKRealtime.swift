//
//  ComboPKRealtime.swift
//  fptshop
//
//  Created by Apple on 3/4/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON;


class ComboPKRealtime: Jsonable{
    required init?(json: JSON) {
        SL_Combo10 = json["SL_Combo10"].int ?? 0;
        SL_Combo15 = json["SL_Combo15"].int ?? 0;
        SL_Combo20 = json["SL_Combo20"].int ?? 0;
        STT = json["STT"].string ?? "";
        SoLuongMay = json["SoLuongMay"].int ?? 0;
        Vung = json["Vung"].string ?? "";
        TenASM = json["TenASM"].string ?? "";
        TenKhuVuc = json["TenKhuVuc"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        TongSL_Combo = json["TongSL_Combo"].int ?? 0;
        TyTrong = json["TyTrong"].string ?? "";
        
        DSCombo10 = json["DSCombo10"].string ?? "";
        DSCombo15 = json["DSCombo15"].string ?? "";
        DSCombo20 = json["DSCombo20"].string ?? "";
        TBBillCombo = json["TBBillCombo"].string ?? "";
        MaShop = json["MaShop"].string ?? "";
        
        SLCBKCL_SDP_Cap = json["SLCBKCL_SDP_Cap"].int ?? 0;
        SLCBSDP_KCL = json["SLCBSDP_KCL"].int ?? 0;
        TiLe_SDP_KCL = json["TiLe_SDP_KCL"].string ?? "";
        Tile_KCL_SDP_Cap = json["Tile_KCL_SDP_Cap"].string ?? "";
        ToTalCombo = json["ToTalCombo"].int ?? 0;
        ToTal_TiLe = json["ToTal_TiLe"].string ?? "";
    }
    
    
    var SL_Combo10: Int?;
    var SL_Combo15: Int?;
    var SL_Combo20: Int?;
    var STT: String?;
    var SoLuongMay: Int?;
    var Vung: String?;
    var TenASM: String?;
    var TenKhuVuc: String?;
    var TenShop: String?;
    var TongSL_Combo: Int?;
    var TyTrong: String?;
    
    var DSCombo10: String?;
    var DSCombo15: String?;
    var DSCombo20: String?;
    var TBBillCombo: String?;
    var MaShop: String?;
    
    var SLCBKCL_SDP_Cap: Int?;
    var SLCBSDP_KCL: Int?;
    var TiLe_SDP_KCL: String?;
    var Tile_KCL_SDP_Cap: String?;
    var ToTalCombo: Int?;
    var ToTal_TiLe: String?;
}
