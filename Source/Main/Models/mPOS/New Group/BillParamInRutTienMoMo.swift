//
//  BillParamInRutTienMoMo.swift
//  fptshop
//
//  Created by tan on 1/9/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class BillParamInRutTienMoMo: NSObject {
    var ShopAddress:String
    var SoPhieuChi:String
    var MaGiaoDich:String
    var ThoiGianChi:String
    var DichVu:String
    var NhaCungCap:String
    var SDT_KH:String
    var TenKH:String
    var Email:String
    var TongTienRutVi:String
    var PhiRutTien:String
    var NguoiChiTien:String
    var MaNV:String
    
    init(    ShopAddress:String
    , SoPhieuChi:String
    , MaGiaoDich:String
    , ThoiGianChi:String
    , DichVu:String
    , NhaCungCap:String
    , SDT_KH:String
    , TenKH:String
    , Email:String
    , TongTienRutVi:String
    , PhiRutTien:String
    , NguoiChiTien:String
    , MaNV:String){
        self.ShopAddress = ShopAddress
        self.SoPhieuChi = SoPhieuChi
        self.MaGiaoDich = MaGiaoDich
        self.ThoiGianChi = ThoiGianChi
        self.DichVu = DichVu
        self.NhaCungCap = NhaCungCap
        self.SDT_KH = SDT_KH
        self.TenKH = TenKH
        self.Email = Email
        self.TongTienRutVi = TongTienRutVi
        self.PhiRutTien = PhiRutTien
        self.NguoiChiTien = NguoiChiTien
        self.MaNV = MaNV
        
    }
    
    
    
    
}

extension BillParamInRutTienMoMo {
    func toJSON() -> Dictionary<String, Any> {
        return [
            "ShopAddress" : self.ShopAddress,
            "SoPhieuChi" : self.SoPhieuChi,
            "MaGiaoDich" : self.MaGiaoDich,
            "ThoiGianChi" : self.ThoiGianChi,
            "DichVu": self.DichVu,
            
            "NhaCungCap": self.NhaCungCap,
            "SDT_KH" : self.SDT_KH,
            "TenKH" : self.TenKH,
            "Email": self.Email,
            "TongTienRutVi" : self.TongTienRutVi,
            "NguoiChiTien" : self.NguoiChiTien,
            "MaNV" : self.MaNV,
        ]
    }
}
