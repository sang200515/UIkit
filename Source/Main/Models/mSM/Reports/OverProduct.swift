//
//  OverProduct.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 28/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class OverProduct: Jsonable{
    required init?(json: JSON) {
        IMEI = json["IMEI"].string ?? "";
        NgayBan = json["NgayBan"].string ?? "";
        NgayTon = json["NgayTon"].string ?? "";
        STT = json["STT"].int ?? 0;
        TenSP = json["TenSP"].string ?? "";
    }
    
    var IMEI: String?;
    var NgayBan: String?;
    var NgayTon: String?;
    var STT: Int?;
    var TenSP: String?;
}
