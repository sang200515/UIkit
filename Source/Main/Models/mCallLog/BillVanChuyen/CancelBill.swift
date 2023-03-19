//
//  CancelBill.swift
//  fptshop
//
//  Created by Apple on 9/27/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"Msg": "Lỗi Hủy CallLog! Trạng thái CL không được hủy: 5663805",
//"Result": 0

import Foundation
import SwiftyJSON

class CancelBill: Jsonable {
    required init(json: JSON) {
        Result = json["Result"].int ?? 0;
        Msg = json["Msg"].string ?? "";
    }
    
    var Result: Int?
    var Msg: String?
}
