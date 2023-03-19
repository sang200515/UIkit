//
//  BaoHiem_PrintObject.swift
//  mPOS
//
//  Created by sumi on 8/2/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit

class BaoHiem_PrintObject: NSObject {
    var DiaChiShop:String
    var SoPhieuThu: String
    var DichVu:String
    var NhaBaoHiem:String
    var TenChuXe: String
    var SoDienThoaiKH:String
    var DiaChiKH:String
    var LoaiXe:String
    var DungTich:String
    
    var BienSo:String
    var NgayBatDau:String
    var NgayKetThuc:String
    var GiaBHTDNS:String
    var GiaBHTaiNan:String
    var TongTien:String
    var nhanVien:String
    var MaVoucher:String
    var HanSuDung:String
    
    //
    init(DiaChiShop:String, SoPhieuThu: String, DichVu:String, NhaBaoHiem:String, TenChuXe: String, SoDienThoaiKH:String, DiaChiKH:String, LoaiXe:String, DungTich:String, BienSo:String, NgayBatDau:String, NgayKetThuc:String, GiaBHTDNS:String, GiaBHTaiNan:String, TongTien:String, nhanVien:String,MaVoucher:String,HanSuDung:String) {
        self.DiaChiShop = DiaChiShop
        self.SoPhieuThu = SoPhieuThu
        self.DichVu = DichVu
        self.NhaBaoHiem = NhaBaoHiem
        self.TenChuXe = TenChuXe
        self.SoDienThoaiKH = SoDienThoaiKH
        self.DiaChiKH = DiaChiKH
        self.LoaiXe = LoaiXe
        self.DungTich = DungTich
        self.BienSo = BienSo
        self.NgayBatDau = NgayBatDau
        self.NgayKetThuc = NgayKetThuc
        self.GiaBHTDNS = GiaBHTDNS
        self.GiaBHTaiNan = GiaBHTaiNan
        self.TongTien = TongTien
        self.nhanVien = nhanVien
        self.MaVoucher = MaVoucher
        self.HanSuDung = HanSuDung
    }
}
extension BaoHiem_PrintObject {
    func toJSON() -> Dictionary<String, Any> {
        return [
            "DiaChiShop": self.DiaChiShop,
            "SoPhieuThu": self.SoPhieuThu,
            "DichVu": self.DichVu,
            "NhaBaoHiem": self.NhaBaoHiem,
            "TenChuXe": self.TenChuXe,
            "SoDienThoaiKH": self.SoDienThoaiKH,
            "DiaChiKH": self.DiaChiKH,
            "LoaiXe": self.LoaiXe,
            "DungTich": self.DungTich,
            
            "BienSo": self.BienSo,
            "NgayBatDau": self.NgayBatDau,
            "NgayKetThuc": self.NgayKetThuc,
            "GiaBHTDNS": self.GiaBHTDNS,
            "GiaBHTaiNan": self.GiaBHTaiNan,
            "TongTien": self.TongTien,
            "nhanVien": self.nhanVien,
            "MaVoucher": self.MaVoucher,
            "HanSuDung": self.HanSuDung
        ]
    }
}




