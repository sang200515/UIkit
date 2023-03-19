//
//  ShopSales.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 05/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class ShopSales: Jsonable{
    required init?(json: JSON) {
        ACS = json["ACS"].int ?? 0;
        Apple = json["Apple"].int ?? 0;
        DS_Estimate = json["DS_Estimate"].double ?? 0.0;
        DS_MTD = json["DS_MTD"].double ?? 0.0;
        DS_MTD_ThangTruoc = json["DS_MTD_ThangTruoc"].double ?? 0.0;
        DS_NgayTruoc = json["DS_NgayTruoc"].double ?? 0.0;
        DS_TB_MTD = json["DS_TB_MTD"].double ?? 0.0;
        DS_TB_MTD_Shop = json["DS_TB_MTD_Shop"].double ?? 0.0;
        DienThoai = json["DienThoai"].int ?? 0;
        FE = json["FE"].int ?? 0;
        HDS = json["HDS"].int ?? 0;
        MaVung = json["MaVung"].string ?? "";
        MayCu = json["MayCu"].int ?? 0;
        MayTinh = json["MayTinh"].int ?? 0;
        MayTinhBang = json["MayTinhBang"].int ?? 0;
        PPF = json["PPF"].int ?? 0;
        Percent_HT_Target = json["Percent_HT_Target"].double ?? 0.0;
        SLShop = json["SLShop"].int ?? 0;
        STT = json["STT"].string ?? "";
        SoSanh_Percent_DS = json["SoSanh_Percent_DS"].double ?? 0.0;
        Target = json["Target"].double ?? 0.0;
        TenVung = json["TenVung"].string ?? "";
        Ten_RSM = json["Ten_RSM"].string ?? "";
        TongSoLuong = json["TongSoLuong"].int ?? 0;
        Total_HS_TraGop = json["Total_HS_TraGop"].int ?? 0;
        DoanhSoNgay = json["DoanhSoNgay"].double ?? 0.0;
        
        DuKienHoanThanhPK = json["DuKienHoanThanhPK"].double ?? 0.0;
        PT_HoanThanhPK = json["PT_HoanThanhPK"].double ?? 0.0;
        TyLePK = json["TyLePK"].double ?? 0.0;
        TyTrongPK = json["TyTrongPK"].double ?? 0.0;
        
        ShopName = json["ShopName"].string ?? "";
        Ten_ASM = json["Ten_ASM"].string ?? "";
        MaKhuVuc = json["MaKhuVuc"].string ?? "";
        TenKhuVuc = json["TenKhuVuc"].string ?? "";
        
        TenShop = json["TenShop"].string ?? "";
        Tong = json["Tong"].double ?? 0.0;
        PT = json["PT"].double ?? 0.0;
        DSPK = json["DSPK"].double ?? 0.0;
        DSPKThuong = json["DS_06"].double ?? 0.0;
        DSPKNK = json["DS_07"].double ?? 0.0;
        DS_ECOM = json["DS_ECOM"].double ?? 0.0;
        
        DoanhSoNgay = json["DoanhSoNgay"].double ?? 0.0;
        DS_TB_NgayConLai = json["DS_TB_NgayConLai"].double ?? 0.0;
        NganhHang = json["NganhHang"].string ?? "";
        SoLuong = json["SoLuong"].int ?? 0;
        TangGiam_Percent_DS = json["TangGiam_Persent_DS"].double ?? 0.0;
        TargetThang = json["TargetThang"].double ?? 0.0;
        KhuVuc = json["KhuVuc"].string ?? "";
    }
    
    var ACS: Int?;
    var Apple: Int?;
    var DS_Estimate: Double?;
    var DS_MTD: Double?;
    var DS_MTD_ThangTruoc: Double?;
    var DS_NgayTruoc: Double?;
    var DS_TB_MTD: Double?;
    var DS_TB_MTD_Shop: Double?;
    var DienThoai: Int?;
    var FE: Int?;
    var HDS: Int?;
    var MaVung: String?;
    var MayCu: Int?;
    var MayTinh: Int?;
    var MayTinhBang: Int?;
    var PPF: Int?;
    var Percent_HT_Target: Double?;
    var SLShop: Int?;
    var STT: String?;
    var SoSanh_Percent_DS: Double?;
    var Target: Double?;
    var TenVung: String?;
    var Ten_RSM: String?;
    var TongSoLuong: Int?;
    var Total_HS_TraGop: Int?;
    var DuKienHoanThanhPK: Double?;
    var PT_HoanThanhPK: Double?;
    var TyLePK: Double?;
    var TyTrongPK: Double?;
    var ShopName: String?;
    var Ten_ASM: String?;
    var MaKhuVuc: String?;
    var TenKhuVuc: String?;
    var TenShop: String?;
    var Tong: Double?;
    var DSPK: Double?;
    var DSPKThuong: Double?;
    var DSPKNK: Double?;
    var PT: Double?;
    var DS_ECOM: Double?;
    var DoanhSoNgay: Double?;
    var DS_TB_NgayConLai: Double?;
    var NganhHang: String?;
    var SoLuong: Int?;
    var TangGiam_Percent_DS: Double?;
    var TargetThang: Double?;
    var KhuVuc: String?;
}
