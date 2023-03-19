//
//  LinePromos.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class LinePromos: NSObject {
    var CreateDate: String
    var Docentry: Int
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
    
    init(CreateDate: String, Docentry: Int, Loai_KM: String, MaCTKM: String, MaSP: String,TenSanPham_Mua: String, Nhom: String, SL_Tang: Int, SanPham_Tang: String,SanPham_Mua: String, TenCTKM: String,TenSanPham_Tang: String,TienGiam: Float) {
        self.CreateDate = CreateDate
        self.Docentry = Docentry
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
    }
    class func parseObjfromArray(array:[JSON])->[LinePromos]{
        var list:[LinePromos] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> LinePromos{
        var createDate = data["CreateDate"].string
        var docentry = data["Docentry"].int
        
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
        
        createDate = createDate == nil ? "" : createDate
        docentry = docentry == nil ? 0 : docentry
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
        
        return LinePromos(CreateDate: createDate!, Docentry: docentry!,Loai_KM: loai_KM!, MaCTKM: maCTKM!, MaSP: maSP!,TenSanPham_Mua:tenSanPham_Mua!, Nhom: nhom!, SL_Tang: sl_Tang!, SanPham_Tang: sanPham_Tang!,SanPham_Mua: sanPham_Mua!, TenCTKM: tenCTKM!,TenSanPham_Tang: tenSanPham_Tang!,TienGiam: tienGiam!)
    }
}

