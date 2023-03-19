//
//  APRSales.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class APRSales: Jsonable{
    required init?(json: JSON) {
        DS_TBN = json["DS_TBN"].double ?? 0.0;
        DoanhSoMTD = json["DoanhSoMTD"].double ?? 0.0;
        PT_DuKienHoanThanh = json["PT_DuKienHoanThanh"].double ?? 0.0;
        PT_HoanThanh = json["PT_HoanThanh"].double ?? 0.0;
        STT = json["STT"].string ?? "";
        TangGiam = json["TangGiam"].double ?? 0.0;
        Target_Thang = json["Target_Thang"].double ?? 0.0;
        TenShop = json["TenShop"].string ?? "";
    }
    
    var DS_TBN: Double?;
    var DoanhSoMTD: Double?;
    var PT_DuKienHoanThanh: Double?;
    var PT_HoanThanh: Double?;
    var STT: String?;
    var TangGiam: Double?;
    var Target_Thang:Double?;
    var TenShop:String?;
}
