//
//  BillCreateBill.swift
//  fptshop
//
//  Created by Apple on 5/8/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.


//"BillNum": "CK5746253",
//"BillReq": 5746253,
//"Carrier_Msg": "Gửi DO thành công!",
//"Carrier_Result": 1,
//"Msg": "Tạo Vận đơn Thành công!</br>Mã Vận đơn: CK5746253",
//"Result": 1

import Foundation
import SwiftyJSON

class BillCreateBill: Jsonable {
    
    required init(json: JSON) {
        BillNum = json["BillNum"].string ?? "";
        BillReq = json["BillReq"].int ?? 0;
        Carrier_Msg = json["Carrier_Msg"].string ?? "";
        Carrier_Result = json["Carrier_Result"].int ?? 0;
        Msg = json["Msg"].string ?? "";
        Result = json["Result"].int ?? 0;
    }
    
    var BillNum: String?
    var BillReq: Int?
    var Carrier_Msg: String?
    var Carrier_Result: Int?
    var Msg: String?
    var Result: Int?
}
