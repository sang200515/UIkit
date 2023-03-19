//
//  BillLoadDichVu.swift
//  fptshop
//
//  Created by Apple on 5/6/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"Code": "0203",
//"Group": "DichVuVanChuyenKerry",
//"Is_ShowPopupConfirm": 1,
//"Msg_ShowPopupConfirm": "Cước Hỏa tốc cao gấp 10 lần so với cước Chuyển phát nhanh, chọn dịch vụ Hỏa tốc sẽ đẩy CallLog tới ASM/Trưởng bộ phận duyệt!",
//"Name": "Hỏa tốc"


import Foundation
import SwiftyJSON

class BillLoadDichVu: Jsonable {

    required init(json: JSON) {
        Code = json["Code"].string ?? "";
        Group = json["Group"].string ?? "";
        Name = json["Name"].string ?? "";
        Is_ShowPopupConfirm = json["Is_ShowPopupConfirm"].int ?? 0;
        Msg_ShowPopupConfirm = json["Msg_ShowPopupConfirm"].string ?? "";
    }
    
    var Code: String?
    var Group: String?
    var Name: String?
    var Is_ShowPopupConfirm: Int?
    var Msg_ShowPopupConfirm: String?
}
