//
//  Checkimei_V2Result.swift
//  mPOS
//
//  Created by sumi on 1/4/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class Checkimei_V2Result: NSObject {
    
    var DiaChiKH: String
    var FormType: String
    var HD_Do: String
    var Hang: String
    var HieuLuc: String
    var Imei2: String
    var Loai: String
    var LoaiBH: String
    var LoaiDonHang: String
    var LoaiHang: String
    var LockKnox: String
    var MaChiTietDonHang: String
    var MaKH: String
    var MaKho: String
    var MaNhomHangCRM: String
    var MaSPBHV: String
    var MaSanPham: String
    var Model: String
    var Mot_Doi_Mot: String
    var NganhHang: String
    var NgayBaoHanh: String
    var NgayTao: String
    var NhanHang: String
    var NoiDungHienThi: String
    
    var PKNK: String
    var SO_NOIBO: String
    var ShopTao: String
    var SoDienThoai: String
    var SoDonHang: String
    var SoDonHangEcom: String
    var SoDonHangGoc: String
    var SoHDBHV: String
    var SoLanBH: String
    var SoLanBHV: String
    var SoLuong: String
    
    var SoNgayDaSD: String
    var SoYCDC: String
    var TenKH: String
    var TenLoaiBH: String
    var TenSanPham: String
    var TenShop: String
    var ThongBao: String
    var TinhTrang: String
    var TongTien: String
    var mType: String
    var U_StsRet: String
    var imei: String
    
    var ThongBaoPhieu:String
    var IsDemo:Int
    
    init(Checkimei_V2Result: JSON)
    {
        DiaChiKH = Checkimei_V2Result["DiaChiKH"].stringValue ;
        FormType = Checkimei_V2Result["FormType"].stringValue;
        HD_Do = Checkimei_V2Result["HD_Do"].stringValue;
        Hang = Checkimei_V2Result["Hang"].stringValue;
        HieuLuc = Checkimei_V2Result["HieuLuc"].stringValue;
        Imei2 = Checkimei_V2Result["Imei2"].stringValue;
        Loai = Checkimei_V2Result["Loai"].stringValue;
        LoaiBH = Checkimei_V2Result["LoaiBH"].stringValue;
        LoaiDonHang = Checkimei_V2Result["LoaiDonHang"].stringValue;
        LoaiHang = Checkimei_V2Result["LoaiHang"].stringValue;
        LockKnox = Checkimei_V2Result["LockKnox"].stringValue;
        MaChiTietDonHang = Checkimei_V2Result["MaChiTietDonHang"].stringValue ;
        MaKH = Checkimei_V2Result["MaKH"].stringValue;
        MaKho = Checkimei_V2Result["MaKho"].stringValue;
        MaNhomHangCRM = Checkimei_V2Result["MaNhomHangCRM"].stringValue;
        MaSPBHV = Checkimei_V2Result["MaSPBHV"].stringValue;
        MaSanPham = Checkimei_V2Result["MaSanPham"].stringValue;
        Model = Checkimei_V2Result["Model"].stringValue;
        Mot_Doi_Mot = Checkimei_V2Result["Mot_Doi_Mot"].stringValue;
        NganhHang = Checkimei_V2Result["NganhHang"].stringValue;
        NgayBaoHanh = Checkimei_V2Result["NgayBaoHanh"].stringValue;
        NgayTao = Checkimei_V2Result["NgayTao"].stringValue;
        NhanHang = Checkimei_V2Result["NhanHang"].stringValue;
        NoiDungHienThi = Checkimei_V2Result["NoiDungHienThi"].stringValue;
        PKNK = Checkimei_V2Result["PKNK"].stringValue ;
        SO_NOIBO = Checkimei_V2Result["SO_NOIBO"].stringValue;
        ShopTao = Checkimei_V2Result["ShopTao"].stringValue;
        SoDienThoai = Checkimei_V2Result["SoDienThoai"].stringValue;
        SoDonHang = Checkimei_V2Result["SoDonHang"].stringValue;
        SoDonHangEcom = Checkimei_V2Result["SoDonHangEcom"].stringValue;
        SoDonHangGoc = Checkimei_V2Result["SoDonHangGoc"].stringValue;
        SoHDBHV = Checkimei_V2Result["SoHDBHV"].stringValue;
        SoLanBH = Checkimei_V2Result["SoLanBH"].stringValue;
        SoLanBHV = Checkimei_V2Result["SoLanBHV"].stringValue;
        SoLuong = Checkimei_V2Result["SoLuong"].stringValue;
        SoNgayDaSD = Checkimei_V2Result["SoNgayDaSD"].stringValue ;
        SoYCDC = Checkimei_V2Result["SoYCDC"].stringValue;
        TenKH = Checkimei_V2Result["TenKH"].stringValue;
        TenLoaiBH = Checkimei_V2Result["TenLoaiBH"].stringValue;
        TenSanPham = Checkimei_V2Result["TenSanPham"].stringValue;
        TenShop = Checkimei_V2Result["TenShop"].stringValue;
        ThongBao = Checkimei_V2Result["ThongBao"].stringValue;
        ThongBaoPhieu = Checkimei_V2Result["ThongBaoPhieu"].stringValue;
        TinhTrang = Checkimei_V2Result["TinhTrang"].stringValue;
        TongTien = Checkimei_V2Result["TongTien"].stringValue;
        mType = Checkimei_V2Result["Type"].stringValue;
        U_StsRet = Checkimei_V2Result["U_StsRet"].stringValue;
        imei = Checkimei_V2Result["imei"].stringValue;
        IsDemo = Checkimei_V2Result["IsDemo"].intValue;
    }
    
}
