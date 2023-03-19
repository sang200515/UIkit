//
//  G100Realtime.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 10/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class G100Realtime: Jsonable{
    required init?(json: JSON) {
        DSTong = json["DSTong"].int ?? 0;
        DoanhSoPK = json["DoanhSoPK"].double ?? 0.0;
        SLMay = json["SLMay"].int ?? 0;
        TTPK = json["TTPK"].double ?? 0.0;
        TenShop = json["TenShop"].string ?? "";
        SLPK = json["SLPK"].int ?? 0;
        SLPKSLMay = json["SLPKSLMay"].double ?? 0.0 ;
    }
    
    var DSTong: Int?;
    var DoanhSoPK: Double?;
    var SLMay: Int?;
    var TTPK: Double?;
    var TenShop: String?;
    var SLPK: Int?;
    var SLPKSLMay: Double?;
}
