//
//  DetailXuatDemo.swift
//  fptshop
//
//  Created by Apple on 5/28/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"Id_Detail": 6413600,
//"Images": "",
//"LyDo": "Xuất hàng demo",
//"MaSanPham": "00555884",
//"MaYeuCau": 5323008,
//"PhanLoai": 65,
//"STT": 1,
//"Serial": "355915101073500",
//"SoLuong": 1,
//"TenSanPham": "ĐTDĐ Samsung A70 A705 Black",
//"XacNhanHoanTat": -13


import UIKit
import SwiftyJSON

class DetailXuatDemo: Jsonable {

    required init(json: JSON) {
        
        Id_Detail = json["Id_Detail"].int ?? 0
        Images = json["Images"].string ?? ""
        LyDo = json["LyDo"].string ?? ""
        MaSanPham = json["MaSanPham"].string ?? ""
        MaYeuCau = json["MaYeuCau"].int ?? 0
        PhanLoai = json["PhanLoai"].int ?? 0
        STT = json["STT"].int ?? 0
        Serial = json["Serial"].string ?? ""
        SoLuong = json["SoLuong"].int ?? 0
        TenSanPham = json["TenSanPham"].string ?? ""
        XacNhanHoanTat = json["XacNhanHoanTat"].int ?? 0
    }
    
    var Id_Detail: Int?
    var Images: String?
    var LyDo: String?
    var MaSanPham: String?
    var MaYeuCau: Int?
    var PhanLoai: Int?
    var STT: Int?
    var Serial:String?
    var SoLuong:Int?
    var TenSanPham:String?
    var XacNhanHoanTat:Int?
}
