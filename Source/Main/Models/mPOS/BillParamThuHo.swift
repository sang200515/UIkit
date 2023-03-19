//
//  BillParamThuHo.swift
//  mPOS
//
//  Created by tan on 10/3/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class BillParamThuHo: NSObject{
    var DiaChiShop:String
    var SoPhieuThu:String
    var MaGiaoDich:String
    var ThoiGianThu:String
    var DichVu:String
    var NhaCungCap:String
    var MaKhachHang:String
    var TenKhachHang:String
    var TenNguoiNopTien:String
    var SoDienThoaiKH:String
    var DiaChiNhaThuoc:String
    var NoiDung:String
    var TongTienThu:String
    var NguoiThuPhieu:String
    var NhanVien:String
    
    init( DiaChiShop:String
        , SoPhieuThu:String
        , MaGiaoDich:String
        , ThoiGianThu:String
        , DichVu:String
        , NhaCungCap:String
        , MaKhachHang:String
        , TenKhachHang:String
        , TenNguoiNopTien:String
        , SoDienThoaiKH:String
        , DiaChiNhaThuoc:String
        , NoiDung:String
        , TongTienThu:String
        , NguoiThuPhieu:String
        , NhanVien:String){
        
        self.DiaChiShop = DiaChiShop
        self.SoPhieuThu = SoPhieuThu
        self.MaGiaoDich = MaGiaoDich
        self.ThoiGianThu = ThoiGianThu
        self.DichVu = DichVu
        self.NhaCungCap = NhaCungCap
        self.MaKhachHang = MaKhachHang
        self.TenKhachHang = TenKhachHang
        self.TenNguoiNopTien = TenNguoiNopTien
        self.SoDienThoaiKH = SoDienThoaiKH
        self.DiaChiNhaThuoc = DiaChiNhaThuoc
        self.NoiDung = NoiDung
        self.TongTienThu = TongTienThu
        self.NguoiThuPhieu = NguoiThuPhieu
        self.NhanVien = NhanVien
        
    }
}
extension BillParamThuHo {
    func toJSON() -> Dictionary<String, Any> {
        return [
            "DiaChiShop" : self.DiaChiShop,
            "SoPhieuThu" : self.SoPhieuThu,
            "MaGiaoDich" : self.MaGiaoDich,
            "ThoiGianThu" : self.ThoiGianThu,
            "DichVu": self.DichVu,
            
            "NhaCungCap": self.NhaCungCap,
            "MaKhachHang" : self.MaKhachHang,
            "TenKhachHang" : self.TenKhachHang,
            "TenNguoiNopTien" : self.TenNguoiNopTien,
            "SoDienThoaiKH" : self.SoDienThoaiKH,
            "DiaChiNhaThuoc" : self.DiaChiNhaThuoc,
            "NoiDung" : self.NoiDung,
            "TongTienThu" : self.TongTienThu,
            "NguoiThuPhieu" : self.NguoiThuPhieu,
            "NhanVien" : self.NhanVien,
        ]
    }
}
