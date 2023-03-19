//
//  DetailFEC_227.swift
//  fptshop
//
//  Created by DiemMy Le on 4/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"ChiTietLoi": [
//    {
//        "ChiTietLoi": "Ho so nay tao lao qua, up anh gi ma toan anh Ngoc Trinh khong la sao",
//        "NgayGhiNhanLoi": "21/04/2020",
//        "STT": 1
//    }
//],
//"HoTenKH": "Tessstt",
//"Id": 5871738,
//"NgayTao": "21/04/2020",
//"NgayXuatHoaDon": "21/04/2020",
//"NhanVienLamHoSo": " - ",
//"NoiDung": "Hợp đông số 20200416-4967014 của nhân viên",
//"SoDonHang": "3115711",
//"SoHopDong": "20200416-4967014",
//"SoTien": "50,000 vnd",
//"TenSanPham": "00606111-iPhone 11 Pro Max 256GB",
//"TenShop": "30808 - HCM 305 Tô Hiến Thành",
//"TrangThaiCallLog": "Chờ xử lý"

import UIKit
import SwiftyJSON

class DetailFEC_227: NSObject {

    let HoTenKH: String
    let NgayTao: String
    let NgayXuatHoaDon: String
    let NhanVienLamHoSo: String
    let NoiDung: String
    let SoDonHang: String
    let SoHopDong: String
    let SoTien: String
    let TenSanPham: String
    let TenShop: String
    let TrangThaiCallLog: String
    let Id: Int
    let listChiTietLoi:[ChiTietLoi_227]
    
    init(HoTenKH: String, NgayTao: String, NgayXuatHoaDon: String, NhanVienLamHoSo: String, NoiDung: String, SoDonHang: String, SoHopDong: String, SoTien: String, TenSanPham: String, TenShop: String, TrangThaiCallLog: String, Id: Int, listChiTietLoi:[ChiTietLoi_227]) {
        self.HoTenKH = HoTenKH
        self.NgayTao = NgayTao
        self.NgayXuatHoaDon = NgayXuatHoaDon
        self.NhanVienLamHoSo = NhanVienLamHoSo
        self.NoiDung = NoiDung
        self.SoDonHang = SoDonHang
        self.SoHopDong = SoHopDong
        self.SoTien = SoTien
        self.TenSanPham = TenSanPham
        self.TenShop = TenShop
        self.TrangThaiCallLog = TrangThaiCallLog
        self.Id = Id
        self.listChiTietLoi = listChiTietLoi
    }
    
    class func getObjFromDictionary(data:JSON) -> DetailFEC_227 {
        var HoTenKH = data["HoTenKH"].string
        var NgayTao = data["NgayTao"].string
        var NgayXuatHoaDon = data["NgayXuatHoaDon"].string
        var NhanVienLamHoSo = data["NhanVienLamHoSo"].string
        var NoiDung = data["NoiDung"].string
        var SoDonHang = data["SoDonHang"].string
        var SoHopDong = data["SoHopDong"].string
        var SoTien = data["SoTien"].string
        var TenSanPham = data["TenSanPham"].string
        var TenShop = data["TenShop"].string
        var TrangThaiCallLog = data["TrangThaiCallLog"].string
        var Id = data["Id"].int
        let list = data["ChiTietLoi"].array
        
        HoTenKH = HoTenKH == nil ? "" : HoTenKH
        NgayTao = NgayTao == nil ? "" : NgayTao
        NgayXuatHoaDon = NgayXuatHoaDon == nil ? "" : NgayXuatHoaDon
        NhanVienLamHoSo = NhanVienLamHoSo == nil ? "" : NhanVienLamHoSo
        NoiDung = NoiDung == nil ? "" : NoiDung
        SoDonHang = SoDonHang == nil ? "" : SoDonHang
        SoHopDong = SoHopDong == nil ? "" : SoHopDong
        SoTien = SoTien == nil ? "" : SoTien
        TenSanPham = TenSanPham == nil ? "" : TenSanPham
        TenShop = TenShop == nil ? "" : TenShop
        TrangThaiCallLog = TrangThaiCallLog == nil ? "" : TrangThaiCallLog
        Id = Id == nil ? 0 : Id
        let listChiTietLoi = ChiTietLoi_227.parseObjfromArray(array: list ?? [])
        
        return DetailFEC_227(HoTenKH: HoTenKH!, NgayTao: NgayTao!, NgayXuatHoaDon: NgayXuatHoaDon!, NhanVienLamHoSo: NhanVienLamHoSo!, NoiDung: NoiDung!, SoDonHang: SoDonHang!, SoHopDong: SoHopDong!, SoTien: SoTien!, TenSanPham: TenSanPham!, TenShop: TenShop!, TrangThaiCallLog: TrangThaiCallLog!, Id: Id!, listChiTietLoi: listChiTietLoi)
    }
}
