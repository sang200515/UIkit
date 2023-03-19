//
//  BillParamThuHo.swift
//  mPOS
//
//  Created by tan on 10/3/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class BillParamGrab: NSObject{
    var DiaChiShop:String
    var SoPhieuThu:String
    var MaGiaoDich:String
    var ThoiGianThu:String
    var DichVu:String
    var NhaCungCap:String
    var MaKhachHang:String
    var TenKhachHang:String
    var SoDienThoaiKH:String
    var BIenSoXe:String
    var TongTienCuoc:String
    var TongTienPhi:String
    var TongTienThanhToan:String
    var Createby:String
    var Thang:String
    var NhanVien:String
    var MaVoucher:String
 
    
    init( DiaChiShop:String
        , SoPhieuThu:String
        , MaGiaoDich:String
        , ThoiGianThu:String
        , DichVu:String
        , NhaCungCap:String
        , MaKhachHang:String
        , TenKhachHang:String
        , SoDienThoaiKH:String
        
        , BIenSoXe:String
        , TongTienCuoc:String
        , TongTienPhi:String
        , TongTienThanhToan:String
        , Createby:String
        , Thang:String
        , NhanVien:String
    , MaVoucher:String){
        
        self.DiaChiShop = DiaChiShop
        self.SoPhieuThu = SoPhieuThu
        self.MaGiaoDich = MaGiaoDich
        self.ThoiGianThu = ThoiGianThu
        self.DichVu = DichVu
        self.NhaCungCap = NhaCungCap
        self.MaKhachHang = MaKhachHang
        self.TenKhachHang = TenKhachHang
        self.SoDienThoaiKH = SoDienThoaiKH
        
        self.BIenSoXe = BIenSoXe
        self.TongTienCuoc = TongTienCuoc
        self.TongTienPhi = TongTienPhi
        self.TongTienThanhToan = TongTienThanhToan
        self.Thang = Thang
        self.NhanVien = NhanVien
        self.Createby = Createby
        self.MaVoucher = MaVoucher
        
        
    }
}
extension BillParamGrab {
    func toJSON() -> Dictionary<String, Any> {
        return [
            "ShopAddress" : self.DiaChiShop,
            "SoPhieuThu" : self.SoPhieuThu,
            "MaGD" : self.MaGiaoDich,
            "ThoiGianThu" : self.ThoiGianThu,
            "DichVu": self.DichVu,
            "NhanVien": self.NhanVien,
            "NhaCungCap": self.NhaCungCap,
            "MaKhachHang" : self.MaKhachHang,
            "TenKhachHang" : self.TenKhachHang,
            "BIenSoXe" : self.BIenSoXe,
            "SoDienThoaiKH" : self.SoDienThoaiKH,
            "Thang" : self.Thang,
            "TongTienCuoc" : self.TongTienCuoc,
            "TongTienPhi" : self.TongTienPhi,
            "TongTienThanhToan" : self.TongTienThanhToan,
            "Createby" : self.Createby,
            "MaVoucher":self.MaVoucher
        ]
    }
}
