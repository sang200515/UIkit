//
//  DOA_LoadDetailResult.swift
//  fptshop
//
//  Created by Apple on 7/19/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"Assigner": "14214",
//"GiaTriSanPham": "11,390,500",
//"Imei": null,
//"MaSanPham": "00484676",
//"NgayXuat": "/Date(1557820626037+0700)/",
//"Request_ID": 5333195,
//"Sender": "24698",
//"SoDonHang": "359447098274640",
//"SoHoaDon": "--",
//"SoLuong": 1,
//"TenSanPham": "ĐTDĐ Samsung Note 9 Blue",
//"TieuChiTinhPhi": "xuất demo",
//"TimeCreate": "/Date(1557819469993+0700)/",
//"TinhTrangMay": "Kho ký gửi"

import UIKit
import SwiftyJSON

class DOA_LoadDetailResult: Jsonable {
    required init(json: JSON) {
        Assigner = json["Assigner"].string ?? ""
        GiaTriSanPham = json["GiaTriSanPham"].string ?? ""
        Imei = json["Imei"].string ?? ""
        MaSanPham = json["MaSanPham"].string ?? ""
        NgayXuat = json["NgayXuat"].string ?? ""
        Request_ID = json["Request_ID"].int ?? 0
        Sender = json["Sender"].string ?? ""
        SoDonHang = json["SoDonHang"].string ?? ""
        SoHoaDon = json["SoHoaDon"].string ?? ""
        SoLuong = json["SoLuong"].int ?? 0
        TenSanPham = json["TenSanPham"].string ?? ""
        TieuChiTinhPhi = json["TieuChiTinhPhi"].string ?? ""
        TimeCreate = json["TimeCreate"].string ?? ""
        TinhTrangMay = json["TinhTrangMay"].string ?? ""
    }
    
    var Assigner: String?
    var GiaTriSanPham: String?
    var Imei: String?
    var MaSanPham: String?
    var NgayXuat: String?
    var Request_ID: Int?
    var Sender: String?
    var SoDonHang: String?
    var SoHoaDon: String?
    var SoLuong: Int?
    var TenSanPham: String?
    var TieuChiTinhPhi: String?
    var TimeCreate: String?
    var TinhTrangMay: String?
    
}
