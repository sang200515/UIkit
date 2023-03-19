//
//  BillParamInMoMo.swift
//  mPOS
//
//  Created by tan on 12/11/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

//momo
import Foundation
class BillParamInMoMo: NSObject {
    
    var ShopAddress:String
    var SoPhieuThu:String
    var MaGiaoDich:String
    var ThoiGianThu:String
    var DichVu:String
    var NhaCungCap:String
    var SDT_KH:String
    var TenKH:String
    var TongTienNap:String
    var NguoiThuPhieu:String
    var MaNV:String
    
    
    
    init(     ShopAddress:String
        , SoPhieuThu:String
        , MaGiaoDich:String
        , ThoiGianThu:String
        , DichVu:String
        , NhaCungCap:String
        , SDT_KH:String
        , TenKH:String
        , TongTienNap:String
        , NguoiThuPhieu:String
        , MaNV:String){
        self.ShopAddress = ShopAddress
        self.SoPhieuThu = SoPhieuThu
        self.MaGiaoDich = MaGiaoDich
        self.ThoiGianThu = ThoiGianThu
        self.DichVu = DichVu
        self.NhaCungCap = NhaCungCap
        self.SDT_KH = SDT_KH
        self.TenKH = TenKH
        self.TongTienNap = TongTienNap
        self.NguoiThuPhieu = NguoiThuPhieu
        self.MaNV = MaNV
        
    }
}
extension BillParamInMoMo {
    func toJSON() -> Dictionary<String, Any> {
        return [
            "ShopAddress" : self.ShopAddress,
            "SoPhieuThu" : self.SoPhieuThu,
            "MaGiaoDich" : self.MaGiaoDich,
            "ThoiGianThu" : self.ThoiGianThu,
            "DichVu": self.DichVu,
            
            "NhaCungCap": self.NhaCungCap,
            "SDT_KH" : self.SDT_KH,
            "TenKH" : self.TenKH,
            "TongTienNap" : self.TongTienNap,
            "NguoiThuPhieu" : self.NguoiThuPhieu,
            "MaNV" : self.MaNV,
        ]
    }
}
