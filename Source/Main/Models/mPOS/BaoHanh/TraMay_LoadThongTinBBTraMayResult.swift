//
//  TraMay_LoadThongTinBBTraMayResult.swift
//  mPOS
//
//  Created by sumi on 8/23/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class TraMay_LoadThongTinBBTraMayResult: NSObject {
    var Imei: String
    var ImeiTraMay: String
    var MaPhieuBH: String
    var MoTaLoi: String
    var NgayDuKienTra: String
    var NgayHetHanBH: String
    var NgayTaoPhieu: String
    var NgayTraKhachHang: String
    var NguoiTraKhach_Ten: String
    var SDTLienHe: String
    var SoPhieuThu: String
    var SoPhieuThuPOS: String
    var SoTienPhaiThu: String
    var TenNguoiLienHe: String
    var TenPK: String
    var TenSanPhamChinh: String
    var TenSanPhamTra: String
    var ThongTinXuLy: String
    var TongChiPhiSua: String
    var Knox:String
    var MuonMay:String
    var SoTienConLai:String
    
    init(TraMay_LoadThongTinBBTraMayResult: JSON)
    {
        Imei = TraMay_LoadThongTinBBTraMayResult["Imei"].stringValue ;
        ImeiTraMay = TraMay_LoadThongTinBBTraMayResult["ImeiTraMay"].stringValue ;
        MaPhieuBH = TraMay_LoadThongTinBBTraMayResult["MaPhieuBH"].stringValue ;
        MoTaLoi = TraMay_LoadThongTinBBTraMayResult["MoTaLoi"].stringValue ;
        NgayDuKienTra = TraMay_LoadThongTinBBTraMayResult["NgayDuKienTra"].stringValue ;
        NgayHetHanBH = TraMay_LoadThongTinBBTraMayResult["NgayHetHanBH"].stringValue ;
        NgayTaoPhieu = TraMay_LoadThongTinBBTraMayResult["NgayTaoPhieu"].stringValue ;
        NgayTraKhachHang = TraMay_LoadThongTinBBTraMayResult["NgayTraKhachHang"].stringValue ;
        NguoiTraKhach_Ten = TraMay_LoadThongTinBBTraMayResult["NguoiTraKhach_Ten"].stringValue ;
        SDTLienHe = TraMay_LoadThongTinBBTraMayResult["SDTLienHe"].stringValue ;
        SoPhieuThu = TraMay_LoadThongTinBBTraMayResult["SoPhieuThu"].stringValue ;
        SoPhieuThuPOS = TraMay_LoadThongTinBBTraMayResult["SoPhieuThuPOS"].stringValue ;
        SoTienPhaiThu = TraMay_LoadThongTinBBTraMayResult["SoTienPhaiThu"].stringValue ;
        TenNguoiLienHe = TraMay_LoadThongTinBBTraMayResult["TenNguoiLienHe"].stringValue ;
        TenPK = TraMay_LoadThongTinBBTraMayResult["TenPK"].stringValue ;
        TenSanPhamChinh = TraMay_LoadThongTinBBTraMayResult["TenSanPhamChinh"].stringValue ;
        TenSanPhamTra = TraMay_LoadThongTinBBTraMayResult["TenSanPhamTra"].stringValue ;
        ThongTinXuLy = TraMay_LoadThongTinBBTraMayResult["ThongTinXuLy"].stringValue ;
        TongChiPhiSua = TraMay_LoadThongTinBBTraMayResult["TongChiPhiSua"].stringValue ;
        Knox = TraMay_LoadThongTinBBTraMayResult["Knox"].stringValue ;
        MuonMay = TraMay_LoadThongTinBBTraMayResult["MuonMay"].stringValue ;
        SoTienConLai  = TraMay_LoadThongTinBBTraMayResult["SoTienConLai"].stringValue ;
    }
    
    
    
}
