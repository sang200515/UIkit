//
//  VanDon.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 30/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class VanDon: NSObject {
    var vanChuyenDocEntry : String
    var soBillFRT: String
    var trangThaiDuyet : String
    var nguoiDuocDuyet: String
    var tenNguoiDuyet: String
    var thoiGianDuyet: String
    var maNhaVanChuyen : String
    var tenNhaVanChuyen: String
    var maDichVu : String
    var tenDichVu: String
    var chiPhi: String
    var maNhaVanChuyenDeXuat: String
    var tenNhaVanChuyenDeXuat : String
    var maDichVuDeXuat: String
    var tenDichVuDeXuat : String
    var chiPhiDeXuat: String
    var shopXuat: String
    var shopNhan: String
    var ghiChu: String
    var tenTrangThai: String
    
    init(vanChuyenDocEntry : String, soBillFRT: String, trangThaiDuyet : String, nguoiDuocDuyet: String, tenNguoiDuyet: String,thoiGianDuyet: String, maNhaVanChuyen : String, tenNhaVanChuyen: String, maDichVu : String, tenDichVu: String, chiPhi: String, maNhaVanChuyenDeXuat: String, tenNhaVanChuyenDeXuat : String, maDichVuDeXuat: String, tenDichVuDeXuat : String, chiPhiDeXuat: String, shopXuat: String, shopNhan: String, ghiChu: String,tenTrangThai: String){
        self.vanChuyenDocEntry  = vanChuyenDocEntry
        self.soBillFRT = soBillFRT
        self.trangThaiDuyet = trangThaiDuyet
        self.nguoiDuocDuyet = nguoiDuocDuyet
        self.tenNguoiDuyet = tenNguoiDuyet
        self.thoiGianDuyet = thoiGianDuyet
        self.maNhaVanChuyen = maNhaVanChuyen
        self.tenNhaVanChuyen = tenNhaVanChuyen
        self.maDichVu = maDichVu
        self.tenDichVu = tenDichVu
        self.chiPhi = chiPhi
        self.maNhaVanChuyenDeXuat = maNhaVanChuyenDeXuat
        self.tenNhaVanChuyenDeXuat = tenNhaVanChuyenDeXuat
        self.maDichVuDeXuat = maDichVuDeXuat
        self.tenDichVuDeXuat = tenDichVuDeXuat
        self.chiPhiDeXuat = chiPhiDeXuat
        self.shopXuat = shopXuat
        self.shopNhan = shopNhan
        self.ghiChu = ghiChu
        self.tenTrangThai = tenTrangThai
    }
}
