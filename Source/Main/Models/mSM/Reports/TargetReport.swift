//
//  TargetReport.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 06/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class TargetReport: Jsonable {
    required init?(json: JSON) {
        GhiChu = json["GhiChu"].string ?? "";
        ID = json["ID"].int ?? 0;
        MaNV = json["MaNV"].string ?? "";
        MaTenNV = json["MaTenNV"].string ?? "";
        SoNgayLamViec = json["SoNgayLamViec"].int ?? 0;
        Target_DS = json["Target_DS"].double ?? 0.0;
        Target_PK = json["Target_PK"].double ?? 0.0;
        NhomCD = json["NhomCD"].string ?? "";
    }
    
    var GhiChu: String?;
    var ID: Int?;
    var MaNV: String?;
    var MaTenNV: String?;
    var SoNgayLamViec: Int?;
    var Target_DS: Double?;
    var Target_PK: Double?;
    var NhomCD: String?;
}


class DSTargetResponse: Jsonable {
    required init?(json: JSON) {
        self.Result = json["Result"].int ?? 0
        self.Msg = json["Msg"].string ?? ""
    }
    
    var Result: Int?
    var Msg: String?
}
