//
//  HeaderXuatDemo.swift
//  fptshop
//
//  Created by Apple on 5/28/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"MaShop": "31248",
//"MaYeuCau": 5323008,
//"Msg": "",
//"NguoiTao": "9549-Giang Thị Thanh Trang",
//"NguoiXuLy": "13750-Trương Hoàng An",
//"NoiDungYeuCau": "test",
//"Result": 1,
//"TenShop": "31248-HCM 368 Tô Ký",
//"ThoiGianTao": "/Date(1557314980480+0700)/",
//"TieuDe": "test--Xuất – Bỏ mẫu demo--31248--HCM 368 Tô Ký--08/05/2019"


import UIKit
import SwiftyJSON

class HeaderXuatDemo: Jsonable {

    required init(json: JSON) {
        MaShop = json["MaShop"].string ?? ""
        MaYeuCau = json["MaYeuCau"].int ?? 0
        Msg = json["Msg"].string ?? ""
        NguoiTao = json["NguoiTao"].string ?? ""
        NguoiXuLy = json["NguoiXuLy"].string ?? ""
        NoiDungYeuCau = json["NoiDungYeuCau"].string ?? ""
        Result = json["Result"].int ?? 0
        TenShop = json["TenShop"].string ?? ""
        ThoiGianTao = json["ThoiGianTao"].string ?? ""
        TieuDe = json["TieuDe"].string ?? ""
    }
    
    var MaShop: String?
    var MaYeuCau: Int?
    var Msg: String?
    var NguoiTao: String?
    var NguoiXuLy: String?
    var NoiDungYeuCau: String?
    var Result: Int?
    var TenShop:String?
    var ThoiGianTao:String?
    var TieuDe:String?
    
}
