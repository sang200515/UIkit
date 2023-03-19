//
//  ShopMyPhamItem.swift
//  fptshop
//
//  Created by DiemMy Le on 2/17/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"ASM": "",
//"CoThe": 0.000000,
//"DS_Estimate": 0.000000,
//"DS_MTD": 0.000000,
//"DS_MTD_ThangTruoc": 0.000000,
//"DS_TB_Ngay": 0.000000,
//"Da": 0.000000,
//"Khac": 0.000000,
//"NuocHoa": 0.000000,
//"PT_HT_target": 0.000000,
//"PT_TangGiamVsDSThangTruoc": 0.000000,
//"STT": "9999",
//"Shop": "Tổng",
//"Target_ThangTruoc": 0.000000,
//"Toc": 0.000000,
//"TongSL": 0.000000,
//"TrangDiem": 0.000000,
//SLSO
//DS_TBBill

import UIKit
import SwiftyJSON

class ShopMyPhamItem: Jsonable {
    
    required init(json: JSON) {
        ASM = json["ASM"].string ?? "";
        CoThe = json["CoThe"].double ?? 0.0;
        DS_Estimate = json["DS_Estimate"].double ?? 0.0;
        DS_MTD = json["DS_MTD"].double ?? 0.0;
        DS_MTD_ThangTruoc = json["DS_MTD_ThangTruoc"].double ?? 0.0;
        DS_TB_Ngay = json["DS_TB_Ngay"].double ?? 0.0;
        Da = json["Da"].double ?? 0.0;
        Khac = json["Khac"].double ?? 0.0;
        NuocHoa = json["NuocHoa"].double ?? 0.0;
        PT_HT_target = json["PT_HT_target"].double ?? 0.0;
        PT_TangGiamVsDSThangTruoc = json["PT_TangGiamVsDSThangTruoc"].double ?? 0.0;
        STT = json["STT"].string ?? "";
        Shop = json["Shop"].string ?? "";
        Target_ThangTruoc = json["Target_ThangTruoc"].double ?? 0.0;
        Toc = json["Toc"].double ?? 0.0;
        TongSL = json["TongSL"].double ?? 0.0;
        TrangDiem = json["TrangDiem"].double ?? 0.0;
        SLSO = json["SLSO"].double ?? 0.0;
        DS_TBBill = json["DS_TBBill"].double ?? 0.0;
    }

    var ASM: String
    var CoThe: Double
    var DS_Estimate: Double
    var DS_MTD: Double
    var DS_MTD_ThangTruoc: Double
    var DS_TB_Ngay: Double
    var Da: Double
    var Khac: Double
    var NuocHoa: Double
    var PT_HT_target: Double
    var PT_TangGiamVsDSThangTruoc: Double
    var STT: String
    var Shop: String
    var Target_ThangTruoc: Double
    var Toc: Double
    var TongSL: Double
    var TrangDiem: Double
    var SLSO: Double
    var DS_TBBill: Double
}
