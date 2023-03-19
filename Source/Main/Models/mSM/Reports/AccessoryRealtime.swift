//
//  AccessoryRealtime.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 28/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class AccessoryRealtime: Jsonable{
    required init?(json: JSON) {
        ASM = json["ASM"].string ?? "";
//        DSPK = json["DSPK"].int ?? 0;
        DSPK = json["DS_06"].int ?? 0;
        KhuVuc = json["KhuVuc"].string ?? "";
        STT = json["STT"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        TyTrong = json["TyTrong"].double ?? 0.0;
        Vung = json["Vung"].string ?? "";
        
        DoanhSoNgay = json["DoanhSoNgay"].int ?? 0;
        PT = json["PT"].double ?? 0.0;
        Tong = json["Tong"].int ?? 0;
        DoanhSoEcom = json["DoanhSoEcom"].int ?? 0;
        
        IntSTT = json["STT"].int ?? 0;
    }
    
    var ASM: String?;
    var DSPK: Int?;
    var KhuVuc: String?;
    var STT: String?;
    var TenShop: String?;
    var TyTrong: Double?;
    var Vung: String?;
    
    var DoanhSoNgay: Int?;
    var PT: Double?;
    var Tong: Int?;
    var DoanhSoEcom: Int?;
    
    var IntSTT: Int?;
}
