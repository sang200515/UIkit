//
//  FFriendsInstall.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 15/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class FFriendsInstall:  Jsonable{
    required init?(json: JSON) {
        DoanhSoLoaiBo = json["DoanhSoLoaiBo"].int ?? 0;
        Doanhso = json["Doanhso"].int ?? 0;
        SL_Ban = json["SL_Ban"].int ?? 0;
        SL_Cai = json["SL_Cai"].int ?? 0;
        STT = json["STT"].int ?? 0;
        TenShop = json["TenShop"].string ?? "";
        TyLe = json["TyLe"].int ?? 0;
    }
    
    var DoanhSoLoaiBo: Int?;
    var Doanhso: Int?;
    var SL_Ban: Int?;
    var SL_Cai: Int?;
    var STT: Int?;
    var TenShop: String?;
    var TyLe: Int?;
}
