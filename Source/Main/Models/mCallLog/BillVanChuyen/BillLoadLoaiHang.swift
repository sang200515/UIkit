//
//  BillLoadLoaiHang.swift
//  fptshop
//
//  Created by Apple on 5/6/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"Code": 1,
//"Name": "Hàng hóa"

import Foundation
import SwiftyJSON

class BillLoadLoaiHang: Jsonable {

    required init(json: JSON) {
        Code = json["Code"].int ?? 0;
        Name = json["Name"].string ?? "";
    }
    
    var Code: Int?
    var Name: String?
}
