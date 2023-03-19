//
//  ConfidentFund.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 15/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class ConfidentFund: Jsonable{
    required init?(json: JSON) {
        BaoHanh = json["BaoHanh"].string ?? "";
        ChenhLech = json["ChenhLech"].string ?? "";
        DoanhThu = json["DoanhThu"].string ?? "";
        DoanhThu_5 = json["DoanhThu_5"].string ?? "";
        DoiTra = json["DoiTra"].string ?? "";
        MaShop = json["MaShop"].string ?? "";
        STT = json["STT"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        ThuMua = json["ThuMua"].string ?? "";
        TongChiPhi = json["TongChiPhi"].string ?? "";
    }
    
    var BaoHanh: String?;
    var ChenhLech: String
    var DoanhThu: String?;
    var DoanhThu_5: String?;
    var DoiTra: String?;
    var MaShop: String?;
    var STT: String?;
    var TenShop: String?;
    var ThuMua: String?;
    var TongChiPhi: String?;
}
