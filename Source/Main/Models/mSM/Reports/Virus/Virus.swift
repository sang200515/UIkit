//
//  Virus.swift
//  fptshop
//
//  Created by DiemMy Le on 2/3/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"SLSP_DTDD": 0.000000,
//"SLSP_MTB_MTXT": 0.000000,
//"SLVirus_DTDD": 0.000000,
//"SLVirus_MTB_MTXT": 0.000000,
//"STT": "",
//"TyleKhaiThac_DTDD": 0.000000,
//"TyleKhaiThac_MTB_MTXT": 0.000000,
//"Vung": "",
//KhuVuc

import UIKit
import SwiftyJSON

class Virus: Jsonable {

    required init(json: JSON) {
        SLSP_DTDD = json["SLSP_DTDD"].double ?? 0.0;
        SLSP_MTB_MTXT = json["SLSP_MTB_MTXT"].double ?? 0.0;
        SLVirus_DTDD = json["SLVirus_DTDD"].double ?? 0.0;
        SLVirus_MTB_MTXT = json["SLVirus_MTB_MTXT"].double ?? 0.0;
        TyleKhaiThac_DTDD = json["TyleKhaiThac_DTDD"].double ?? 0.0;
        TyleKhaiThac_MTB_MTXT = json["TyleKhaiThac_MTB_MTXT"].double ?? 0.0;
        STT = json["STT"].string ?? "";
        Vung = json["Vung"].string ?? "";
        ASM = json["ASM"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        KhuVuc = json["KhuVuc"].string ?? "";
    }
    
    var SLSP_DTDD: Double
    var SLSP_MTB_MTXT: Double
    var SLVirus_DTDD: Double
    var SLVirus_MTB_MTXT: Double
    var TyleKhaiThac_DTDD: Double
    var TyleKhaiThac_MTB_MTXT: Double
    var STT: String
    var Vung: String
    var ASM: String
    var TenShop: String
    var KhuVuc: String
}
