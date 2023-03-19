//
//  RemainOldDevice60.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 28/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class RemainOldDevice60: Jsonable{
    required init?(json: JSON) {
        DistNumber = json["DistNumber"].string ?? "";
        TenSP = json["TenSP"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        TuoiTon = json["TuoiTon"].int ?? 0;
    }
    
    var DistNumber: String?;
    var TenSP: String?;
    var TenShop: String?;
    var TuoiTon: Int?;
}
