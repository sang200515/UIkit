//
//  DeviceNotSold.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class DeviceNotSold: Jsonable{
    required init?(json: JSON) {
        shopXinHang = json["U_ShpCodName"].string ?? "";
        maSP = json["ItemCode"].string ?? "";
        tenSP = json["ItemName"].string ?? "";
        slChuaBan = json["Quatity"].int ?? 0;
        giaTriChuaBan = json["U_Price"].int ?? 0;
        percentChuaBan = json["TyLe"].double ?? 0.0;
    }
    
    var shopXinHang: String?;
    var maSP: String?;
    var tenSP: String?;
    var slChuaBan: Int?;
    var giaTriChuaBan: Int?;
    var percentChuaBan: Double?;
}
