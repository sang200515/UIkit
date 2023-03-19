//
//  AppleRealtimePK.swift
//  fptshop
//
//  Created by DiemMy Le on 1/26/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"ASM": "Nguyễn Văn A",
//            "Combo1": 0,
//            "Combo2": 0,
//            "Combo3": 0,
//            "SLMay": 3.000000,
//            "STT": "0",
//            "TyLeCombo1": 0.000000,
//            "TyLeCombo2": 0.000000,
//            "TyLeCombo3": 0.000000,
//            "Vung": "Hồ Chí Minh",
//"Model": "iPhone 11 128GB",
//KhuVuc

import UIKit
import SwiftyJSON

class AppleRealtimePK: Jsonable {
    var STT: String
    var Vung: String
    var ASM: String
    var KhuVuc: String
    var Model: String
    var Combo1: Int
    var Combo2: Int
    var Combo3: Int
    var SLMay: Double
    var TyLeCombo1: Double
    var TyLeCombo2: Double
    var TyLeCombo3: Double
    
    required init(json: JSON) {
        Vung = json["Vung"].stringValue
        STT = json["STT"].stringValue
        ASM = json["ASM"].stringValue
        KhuVuc = json["KhuVuc"].stringValue
        Model = json["Model"].stringValue
        Combo1 = json["Combo1"].intValue
        Combo2 = json["Combo2"].intValue
        Combo3 = json["Combo3"].intValue
        
        SLMay = json["SLMay"].doubleValue
        TyLeCombo1 = json["TyLeCombo1"].doubleValue
        TyLeCombo2 = json["TyLeCombo2"].doubleValue
        TyLeCombo3 = json["TyLeCombo3"].doubleValue
    }
}
