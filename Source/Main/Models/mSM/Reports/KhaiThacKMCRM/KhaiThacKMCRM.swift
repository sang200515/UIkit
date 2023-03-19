//
//  KhaiThacKMCRM.swift
//  fptshop
//
//  Created by Apple on 6/7/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class KhaiThacKMCRM: Jsonable {

    required init?(json: JSON) {
        
        STT = json["STT"].string ?? "";
        Vung = json["Vung"].string ?? "";
        ASM = json["ASM"].string ?? "";
        KhuVuc = json["KhuVuc"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        MaShop = json["MaShop"].string ?? "";
        PTLaiGop = json["PTLaiGop"].double ?? 0.0;
        PT_KhaiThac = json["PT_KhaiThac"].double ?? 0;
        SLThuHo = json["SLThuHo"].int ?? 0;
        SoLuong = json["SoLuong"].int ?? 0;
        TG_TBDH = json["TG_TBDH"].double ?? 0;
        DoanhSo = json["DoanhSo"].int ?? 0;
        LaiGop = json["LaiGop"].int ?? 0;
        
        LaiGopPK = json["LaiGopPK"].int ?? 0;
        LaiGopSim = json["LaiGopSim"].int ?? 0;
        PTKhaiThacPK = json["PTKhaiThacPK"].double ?? 0.0;
        PTKhaiThacSIM = json["PTKhaiThacSIM"].double ?? 0.0;
        SoLuongPK = json["SoLuongPK"].int ?? 0;
        SoLuongSim = json["SoLuongSim"].int ?? 0;
        SLDonHang = json["SLDonHang"].int ?? 0;
        
    }
    
    
    var STT: String
    var Vung: String
    var ASM: String
    var KhuVuc: String
    var TenShop: String
    var MaShop: String
    var PTLaiGop: Double
    var PT_KhaiThac: Double
    var SLThuHo: Int
    var SoLuong: Int
    var TG_TBDH: Double
    var DoanhSo: Int
    var LaiGop: Int
    
    var LaiGopPK: Int
    var LaiGopSim: Int
    var PTKhaiThacPK: Double
    var PTKhaiThacSIM: Double
    var SoLuongPK: Int
    var SoLuongSim: Int
    var SLDonHang: Int
}
