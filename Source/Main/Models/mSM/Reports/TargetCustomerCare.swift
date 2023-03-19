//
//  TargetCustomerCare.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 28/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class TargetCustomerCare: Jsonable{
    required init?(json: JSON) {
        ChatLuong  = json["ChatLuong"].string ?? "";
        DiemCamera = json["DiemCamera"].string ?? "";
        DiemHappy = json["DiemHappy"].string ?? "";
        STT = json["STT"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        TongDiemCSKH = json["TongDiemCSKH"].string ?? "";
        
        KetQua_W3 = json["KetQua_W3"].string ?? "";
        LoiKhen_W3 = json["LoiKhen_W3"].string ?? "";
        SoSO = json["SoSO"].string ?? "";
        TARGET_W3 = json["TARGET_W3"].string ?? "";
    }
    
    var ChatLuong: String?;
    var DiemCamera: String?;
    var DiemHappy: String?;
    var STT: String?;
    var TenShop: String?;
    var TongDiemCSKH: String?;
    
    var KetQua_W3: String?;
    var LoiKhen_W3: String?;
    var SoSO: String?;
    var TARGET_W3: String?;
}
