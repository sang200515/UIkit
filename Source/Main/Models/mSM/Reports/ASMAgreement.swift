//
//  ASMAgreement.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 07/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class ASMAgreement: Jsonable{
    required init?(json: JSON) {
        ApprovedDate = json["NgayDanhGia"].string ?? "";
        OrdinalNum = json["STT"].int ?? 0;
        ASMChoice = json["TieuChiChon"].string ?? "";
        UserCode = json["UserCode"].string ?? "";
        ASMFullname = json["UserName"].string ?? "";
        ShopCode = json["WarehouseCode"].string ?? "";
        ShopName = json["WarehouseName"].string ?? "";
    }
    
    var ApprovedDate: String?;
    var OrdinalNum: Int?;
    var ASMChoice: String?;
    var UserCode: String?;
    var ASMFullname: String?;
    var ShopCode: String?;
    var ShopName: String?;
}
