//
//  OverDevice.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 28/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class OverDevice: Jsonable{
    required init?(json: JSON) {
        IMEI = json["IMEI"].string ?? "";
        NgayTon = json["NgayTon"].int ?? 0;
        STT = json["STT"].int ?? 0;
        TenSP = json["TenSP"].string ?? "";
    }
    
    var IMEI: String?;
    var NgayTon: Int?;
    var STT: Int?;
    var TenSP: String?;
}
