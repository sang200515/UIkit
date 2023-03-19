//
//  DSTraGop.swift
//  fptshop
//
//  Created by Apple on 4/22/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class DSTraGop: Jsonable {
    
    required init?(json: JSON) {
        
        DoanhSoMay = json["DoanhSoMay"].string ?? "";
        DoanhThuTraGop = json["DoanhThuTraGop"].string ?? "";
        STT = json["STT"].string ?? "";
        SoLuong_SVFC = json["SoLuong_SVFC"].int ?? 0;
        SoLuong_FEC = json["SoLuong_FEC"].int ?? 0;
        SoLuong_HC = json["SoLuong_HC"].int ?? 0;
        SoLuong_HDS = json["SoLuong_HDS"].int ?? 0;
        SoLuong_Tong = json["SoLuong_Tong"].int ?? 0;
        TrungBinh_Bill = json["TrungBinh_Bill"].string ?? "";
        TyTrong = json["TyTrong"].string ?? "";
        VungMien = json["VungMien"].string ?? "";
        KhuVuc = json["KhuVuc"].string ?? "";
        ASM = json["ASM"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        SoLuong_NganHang = json["SoLuong_NganHang"].int ?? 0;
        SoLuong_MAF = json["SoLuong_MAF"].int ?? 0;
        
    }

    var DoanhSoMay: String
    var DoanhThuTraGop: String
    var STT: String
    var SoLuong_SVFC: Int
    var SoLuong_FEC: Int
    var SoLuong_HC: Int
    var SoLuong_HDS: Int
    var SoLuong_Tong: Int
    var TrungBinh_Bill: String
    var TyTrong: String
    var VungMien: String
    var KhuVuc: String
    var ASM: String
    var TenShop: String
    var SoLuong_NganHang: Int
    var SoLuong_MAF: Int
}

class DSTraGopRealtime: Jsonable {
    
    required init?(json: JSON) {
        
        DoanhSoMay = json["DoanhSoMay"].double ?? 0.0;
        DoanhThuTraGop = json["DoanhThuTraGop"].double ?? 0.0;
        STT = json["STT"].string ?? "";
        SoLuong_SVFC = json["SoLuong_SVFC"].int ?? 0;
        SoLuong_FEC = json["SoLuong_FEC"].int ?? 0;
        SoLuong_HC = json["SoLuong_HC"].int ?? 0;
        SoLuong_HDS = json["SoLuong_HDS"].int ?? 0;
        SoLuong_Tong = json["SoLuong_Tong"].int ?? 0;
        TrungBinh_Bill = json["TrungBinh_Bill"].double ?? 0.0;
        TyTrong = json["TyTrong"].string ?? "";
        VungMien = json["VungMien"].string ?? "";
        KhuVuc = json["KhuVuc"].string ?? "";
        ASM = json["ASM"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        SoLuong_NganHang = json["SoLuong_NganHang"].int ?? 0;
        SoLuong_MAF = json["SoLuong_MAF"].int ?? 0;
        SLMay = json["SLMay"].int ?? 0
    }
    
    let DoanhSoMay: Double
    let DoanhThuTraGop: Double
    let STT: String
    let SoLuong_SVFC: Int
    let SoLuong_FEC: Int
    let SoLuong_HC: Int
    let SoLuong_HDS: Int
    let SoLuong_Tong: Int
    let TrungBinh_Bill: Double
    let TyTrong: String
    let VungMien: String
    let KhuVuc: String
    let ASM: String
    let TenShop: String
    let SoLuong_NganHang: Int
    var SoLuong_MAF: Int
    let SLMay: Int
}
