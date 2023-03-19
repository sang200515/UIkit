//
//  DuyetCongNoVNPT.swift
//  fptshop
//
//  Created by DiemMy Le on 12/13/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"CMND": "038085013888",
//"HinhCMNDMatSau": "http://imagevnpt.fptshop.com.vn:3344/Beta/0//312339540_0_021219151343335_MatSauCMND.jpg",
//"HinhCMNDMatTruoc": "http://imagevnpt.fptshop.com.vn:3344/Beta/0//312339540_0_021219151557146_MatTruocCMND.jpg",
//"HinhDonDatHang": "http://imagevnpt.fptshop.com.vn:3344/Beta/0//312339540_0_021219151353286_PhieuMuaHang.jpg",
//"HinhSanPham": "http://imagevnpt.fptshop.com.vn:3344/Beta/2952998//038085013888_2952998_021219163834426_AnhKH.jpg",
//"HoTenKH": "Vũ Văn Sỹ",
//"Id_Detail": 6892633,
//"LyDoTuChoi": "",
//"MaYeuCau": 5799261,
//"NgayTao": "02/12/2019",
//"SDT": "0915790666",
//"STT": 1,
//"Shop": "",
//"TenGDCN": "Nguyễn Quang Hòa",
//"TongTienDonHang": "14,490,000",
//"TrangThaiDuyet": 1

import UIKit
import SwiftyJSON

class DuyetCongNoVNPT: Jsonable {

    required init(json: JSON) {
        CMND = json["CMND"].string ?? ""
        HinhCMNDMatSau = json["HinhCMNDMatSau"].string ?? ""
        HinhCMNDMatTruoc = json["HinhCMNDMatTruoc"].string ?? ""
        HinhDonDatHang = json["HinhDonDatHang"].string ?? ""
        HinhSanPham = json["HinhSanPham"].string ?? ""
        HoTenKH = json["HoTenKH"].string ?? ""
        Id_Detail = json["Id_Detail"].int ?? 0
        LyDoTuChoi = json["LyDoTuChoi"].string ?? ""
        MaYeuCau = json["MaYeuCau"].int ?? 0
        NgayTao = json["NgayTao"].string ?? ""
        SDT = json["SDT"].string ?? ""
        STT = json["STT"].int ?? 0
        Shop = json["Shop"].string ?? ""
        TenGDCN = json["TenGDCN"].string ?? ""
        TongTienDonHang = json["TongTienDonHang"].string ?? ""
        TrangThaiDuyet = json["TrangThaiDuyet"].int ?? 0
        NhanVienBanHang = json["NhanVienBanHang"].string ?? ""
        SoMPOS = json["SoMPOS"].string ?? ""
    }

    var CMND: String?
    var HinhCMNDMatSau: String?
    var HinhCMNDMatTruoc: String?
    var HinhDonDatHang: String?
    var HinhSanPham: String?
    var HoTenKH: String?
    var Id_Detail: Int?
    var LyDoTuChoi: String?
    var MaYeuCau: Int?
    var NgayTao: String?
    var SDT: String?
    var STT: Int?
    var Shop: String?
    var TenGDCN: String?
    var TongTienDonHang: String?
    var TrangThaiDuyet: Int?
    var NhanVienBanHang: String?
    var SoMPOS: String?
}
