//
//  DiscountLoan.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 15/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class DiscountLoan: Jsonable{
    required init?(json: JSON) {
        MaCongTy = json["MaCongTy"].string ?? "";
        TenCongTy = json["TenCongTy"].string ?? "";
        MaShop = json["MaShop"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        MaKhachHang = json["MaKhachHang"].string ?? "";
        TenKhachHang = json["TenKhachHang"].string ?? "";
        SoDT = json["SoDT"].string ?? "";
        DonHangNoKM = json["DonHangNoKM"].string ?? "";
        DonHangGoc = json["DonHangGoc"].string ?? "";
        NgayDonHang = json["NgayDonHang"].string ?? "";
        MaSPGoc = json["MaSPGoc"].string ?? "";
        TenSPGoc = json["TenSPGoc"].string ?? "";
        MaSPNoKM = json["MaSPNoKM"].string ?? "";
        TenSPNoKM = json["TenSPNoKM"].string ?? "";
        MaKhoCon = json["MaKhoCon"].string ?? "";
        SoNgayNo = json["SoNgayNo"].int ?? 0;
        SLNo = json["SLNo"].int ?? 0;
        SLTonKho = json["SLTonKho"].int ?? 0;
    }
    
    var MaCongTy: String?;
    var TenCongTy: String?;
    var MaShop: String?;
    var TenShop: String?;
    var MaKhachHang: String?;
    var TenKhachHang: String?;
    var SoDT: String?;
    var DonHangNoKM: String?;
    var DonHangGoc: String?;
    var NgayDonHang: String?;
    var MaSPGoc: String?;
    var TenSPGoc: String?;
    var MaSPNoKM: String?;
    var TenSPNoKM: String?;
    var MaKhoCon: String?;
    var SoNgayNo: Int?;
    var SLNo: Int?;
    var SLTonKho: Int?;
}
