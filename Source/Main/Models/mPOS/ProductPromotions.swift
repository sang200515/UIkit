//
//  ProductPromotions.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ProductPromotions: NSObject, NSCopying{
    var Loai_KM: String
    var MaCTKM: String
    var MaSP: String
    var TenSanPham_Mua: String
    var Nhom: String
    var SL_Tang: Int
    var SanPham_Mua: String
    var SanPham_Tang: String
    var TenCTKM: String
    var TenSanPham_Tang: String
    var TienGiam: Float
    var MaSP_ThayThe: String
    var SL_ThayThe: Int
    var TenSP_ThayThe: String
    
    var MenhGia_VC: String
    var VC_used: String
    var KhoTang: String
    var is_imei:String
    var imei:String
    
    
    init(Loai_KM: String, MaCTKM: String, MaSP: String,TenSanPham_Mua: String, Nhom: String, SL_Tang: Int, SanPham_Tang: String,SanPham_Mua: String, TenCTKM: String,TenSanPham_Tang: String,TienGiam: Float,MaSP_ThayThe: String,SL_ThayThe: Int,TenSP_ThayThe: String, MenhGia_VC: String, VC_used: String, KhoTang: String, is_imei:String,imei:String) {
        self.Loai_KM = Loai_KM
        self.MaCTKM = MaCTKM
        self.MaSP = MaSP
        self.TenSanPham_Mua = TenSanPham_Mua
        self.Nhom = Nhom
        self.SL_Tang = SL_Tang
        self.SanPham_Mua = SanPham_Mua
        self.SanPham_Tang = SanPham_Tang
        self.TenCTKM = TenCTKM
        self.TenSanPham_Tang = TenSanPham_Tang
        self.TienGiam = TienGiam
        self.MaSP_ThayThe = MaSP_ThayThe
        self.SL_ThayThe = SL_ThayThe
        self.TenSP_ThayThe = TenSP_ThayThe
        self.MenhGia_VC = MenhGia_VC
        self.VC_used = VC_used
        self.KhoTang = KhoTang
        self.is_imei = is_imei
        self.imei = imei
    }
    class func parseObjfromArray(array:[JSON])->[ProductPromotions]{
        var list:[ProductPromotions] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ProductPromotions{
        
        var loai_KM = data["Loai_KM"].string
        var maCTKM = data["MaCTKM"].string
        var maSP = data["MaSP"].string
        var tenSanPham_Mua = data["TENSANPHAM_MUA"].string
        var nhom = data["Nhom"].string
        var sl_Tang = data["SL_Tang"].int
        var sanPham_Mua = data["SanPham_Mua"].string
        var sanPham_Tang = data["SanPham_Tang"].string
        var tenCTKM = data["TenCTKM"].string
        var tenSanPham_Tang = data["TenSanPham_Tang"].string
        var tienGiam = data["TienGiam"].float
        var maSP_ThayThe = data["MaSP_ThayThe"].string
        var sl_ThayThe = data["SL_ThayThe"].int
        var tenSP_ThayThe = data["TenSP_ThayThe"].string
        
        var menhGia_VC = data["MenhGia_VC"].string
        var vc_used = data["VC_used"].string
        var khoTang = data["KhoTang"].string
        var is_imei = data["is_imei"].string
        
        loai_KM = loai_KM == nil ? "" : loai_KM
        maCTKM = maCTKM == nil ? "" : maCTKM
        maSP = maSP == nil ? "" : maSP
        tenSanPham_Mua = tenSanPham_Mua == nil ? "" : tenSanPham_Mua
        nhom = nhom == nil ? "" : nhom
        sl_Tang = sl_Tang == nil ? 0 : sl_Tang
        sanPham_Mua = sanPham_Mua == nil ? "" : sanPham_Mua
        sanPham_Tang = sanPham_Tang == nil ? "" : sanPham_Tang
        tenCTKM = tenCTKM == nil ? "" : tenCTKM
        tenSanPham_Tang = tenSanPham_Tang == nil ? "" : tenSanPham_Tang
        tienGiam = tienGiam == nil ? 0.0 : tienGiam
        maSP_ThayThe = maSP_ThayThe == nil ? "" : maSP_ThayThe
        sl_ThayThe = sl_ThayThe == nil ? 0 : sl_ThayThe
        tenSP_ThayThe = tenSP_ThayThe == nil ? "" : tenSP_ThayThe
        
        menhGia_VC = menhGia_VC == nil ? "" : menhGia_VC
        vc_used = vc_used == nil ? "" : vc_used
        khoTang = khoTang == nil ? "" : khoTang
        is_imei = is_imei == nil ? "" : is_imei
        
        return ProductPromotions(Loai_KM: loai_KM!, MaCTKM: maCTKM!, MaSP: maSP!,TenSanPham_Mua:tenSanPham_Mua!, Nhom: nhom!, SL_Tang: sl_Tang!, SanPham_Tang: sanPham_Tang!,SanPham_Mua: sanPham_Mua!, TenCTKM: tenCTKM!,TenSanPham_Tang: tenSanPham_Tang!,TienGiam: tienGiam!,MaSP_ThayThe: maSP_ThayThe!,SL_ThayThe: sl_ThayThe!,TenSP_ThayThe: tenSP_ThayThe!, MenhGia_VC: menhGia_VC!, VC_used: vc_used!, KhoTang: khoTang!, is_imei:is_imei!,imei: "")
    }
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = ProductPromotions(Loai_KM: Loai_KM, MaCTKM: MaCTKM, MaSP: MaSP,TenSanPham_Mua:TenSanPham_Mua, Nhom: Nhom, SL_Tang: SL_Tang, SanPham_Tang: SanPham_Tang,SanPham_Mua: SanPham_Mua, TenCTKM: TenCTKM,TenSanPham_Tang: TenSanPham_Tang,TienGiam: TienGiam,MaSP_ThayThe: MaSP_ThayThe,SL_ThayThe: SL_ThayThe,TenSP_ThayThe: TenSP_ThayThe, MenhGia_VC: MenhGia_VC, VC_used: VC_used, KhoTang: KhoTang, is_imei:is_imei,imei: imei)
        return copy
    }
}

