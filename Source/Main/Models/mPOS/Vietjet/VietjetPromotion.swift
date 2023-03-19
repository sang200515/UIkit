//
//  VietjetPromotion.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class JetPromotion: Mappable {
    var unitInStock: [Any] = []
    var promotions: [VietjetPromotion] = []
    var unconfirmationReasons: [Any] = []
    var returnMessage: ReturnMessage = ReturnMessage(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.unitInStock <- map["UnitInStock"]
        self.promotions <- map["Promotions"]
        self.unconfirmationReasons <- map["UnconfirmationReasons"]
        self.returnMessage <- map["ReturnMessage"]
    }
}

class VietjetPromotion: Mappable {
    var sanPhamMUA: String = ""
    var tensanphamMUA: String = ""
    var tienGiam: Int = 0
    var loaiKM: String = ""
    var sanPhamTang: String = ""
    var tenSANPhamTang: String = ""
    var slTang: Int = 0
    var nhom: String = ""
    var maCTKM: String = ""
    var tenCTKM: String = ""
    var maSPThayThe: String = ""
    var tenSPThayThe: String = ""
    var slThayThe: Int = 0
    var menhGiaVC: String = ""
    var vcUsed: String = ""
    var khoTang: String = ""
    var isImei: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.sanPhamMUA <- map["SanPham_Mua"]
        self.tensanphamMUA <- map["TENSANPHAM_MUA"]
        self.tienGiam <- map["TienGiam"]
        self.loaiKM <- map["Loai_KM"]
        if self.loaiKM.isEmpty { self.loaiKM <- map["LoaiKM"] }
        self.sanPhamTang <- map["SanPham_Tang"]
        self.tenSANPhamTang <- map["TenSanPham_Tang"]
        self.slTang <- map["SL_Tang"]
        self.nhom <- map["Nhom"]
        self.maCTKM <- map["MaCTKM"]
        self.tenCTKM <- map["TenCTKM"]
        self.maSPThayThe <- map["MaSP_ThayThe"]
        self.tenSPThayThe <- map["TenSP_ThayThe"]
        self.slThayThe <- map["SL_ThayThe"]
        self.menhGiaVC <- map["MenhGia_VC"]
        self.vcUsed <- map["VC_used"]
        self.khoTang <- map["KhoTang"]
        self.isImei <- map["is_imei"]
    }
}

class ReturnMessage: Mappable {
    var pStatus: Int = 0
    var pMessagess: String = ""
    var khoanvay: Int = 0
    var codevnpay: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.pStatus <- map["p_status"]
        self.pMessagess <- map["p_messagess"]
        self.khoanvay <- map["khoanvay"]
        self.codevnpay <- map["codevnpay"]
    }
}

