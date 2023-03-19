//
//  ReportHealth.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 08/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class ReportHealth: Jsonable{
    required init?(json: JSON) {
        self.ChiSoChoPhep = json["ChiSoChoPhep"].string ?? "";
        self.ChiSoConLai = json["ChiSoConLai"].string ?? "";
        self.ChiSoHienTai = json["ChiSoHienTai"].string ?? "";
        self.DoanhThuSSD = json["DoanhThuSSD"].string ?? "";
        self.DoanhThuSamSung = json["DoanhThuSamSung"].string ?? "";
        self.GiaTri = json["GiaTri"].string ?? "";
        self.Id = json["ID"].string ?? "";
        self.Shop = json["Shop"].string ?? "";
        self.SoLuong = json["SoLuong"].string ?? "";
        self.SoLuongSSD = json["SoLuongSSD"].string ?? "";
        self.SoLuongSamsung = json["SoLuongSamSung"].string ?? "";
        self.SoSanh = json["SoSanh"].string ?? "";
        self.TenChiTieu = json["TenChiTieu"].string ?? "";
        self.TiLeDS = json["TiLeDS"].string ?? "";
        self.TiLeSL = json["TiLeSL"].string ?? "";
        self.TinhTrang = json["TinhTrang"].string ?? "";
        self.VongQuay = json["VongQuay"].string ?? "";
    }
    
    var ChiSoChoPhep: String?;
    var ChiSoConLai: String?;
    var ChiSoHienTai: String?;
    var DoanhThuSSD: String?;
    var DoanhThuSamSung: String?;
    var GiaTri: String?;
    var Id: String?;
    var Shop: String?;
    var SoLuong:String?;
    var SoLuongSSD: String?;
    var SoLuongSamsung: String?;
    var SoSanh: String?;
    var TenChiTieu: String?;
    var TiLeDS: String?;
    var TiLeSL: String?;
    var TinhTrang: String?;
    var VongQuay: String?;
}
