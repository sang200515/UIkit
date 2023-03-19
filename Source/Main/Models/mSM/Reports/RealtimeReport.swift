//
//  RealtimeReport.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 30/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

//add dspknk

class RealtimeReport: Jsonable{
    required init?(json: JSON) {
        
        DSPK = json["DSPK"].double ?? 0.0;
        DSPKThuong = json["DS_06"].double ?? 0.0;
        DSPKNK = json["DS_07"].double ?? 0.0;
        PT = json["PT"].double ?? 0.0;
        DS_ECOM = json["DS_ECOM"].double ?? 0.0;
        DoanhSoNgay = json["DoanhSoNgay"].double ?? 0.0;
        STT = json["STT"].string ?? "";
        Tong = json["Tong"].double ?? 0.0;
        Vung = json["Vung"].string ?? "";
        Shop = json["Shop"].string ?? "";
        KhuVuc = json["KhuVuc"].string ?? "";
        ASM = json["ASM"].string ?? "";
        DSDV = json["DSDV"].double ?? 0.0;
    }
    
    
    var DSPK: Double?;
    var DSPKThuong: Double?;
    var DSPKNK: Double?;
    var PT: Double?;
    var DS_ECOM: Double?;
    var DoanhSoNgay: Double?;
    var STT: String?;
    var Tong: Double?;
    var Vung: String?;
    var Shop: String?;
    var KhuVuc: String?;
    var ASM: String?;
    var DSDV: Double?;
}
