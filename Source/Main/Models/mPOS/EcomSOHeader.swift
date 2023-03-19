//
//  EcomSOHeader.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class EcomSOHeader: NSObject {
    var DocEntry: Int
    var GhiChu: String
    var LoaiDH: String
    var NgayTao: String
    var SDT: String
    var TenKH: String
    var TenNV: String
    var TenShop: String
    var TinhTrang: String
    var U_NumECom: Int
    
    init(DocEntry: Int,GhiChu: String,LoaiDH: String,NgayTao: String,SDT: String,TenKH: String,TenNV: String,TenShop: String,TinhTrang: String,U_NumECom: Int) {
        self.DocEntry = DocEntry
        self.GhiChu = GhiChu
        self.LoaiDH = LoaiDH
        self.NgayTao = NgayTao
        self.SDT = SDT
        self.TenKH = TenKH
        self.TenNV = TenNV
        self.TenShop = TenShop
        self.TinhTrang = TinhTrang
        self.U_NumECom = U_NumECom
    }
    class func parseObjfromArray(array:[JSON])->[EcomSOHeader]{
        var list:[EcomSOHeader] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> EcomSOHeader{
        var docEntry = data["DocEntry"].int
        var ghiChu = data["GhiChu"].string
        
        var loaiDH = data["LoaiDH"].string
        var ngayTao = data["NgayTao"].string
        var sdt = data["SDT"].string
        var tenKH = data["TenKH"].string
        var tenNV = data["TenNV"].string
        var tenShop = data["TenShop"].string
        var tinhTrang = data["TinhTrang"].string
        var u_NumECom = data["U_NumECom"].int
        
        
        docEntry = docEntry == nil ? 0 : docEntry
        ghiChu = ghiChu == nil ? "" : ghiChu
        loaiDH = loaiDH == nil ? "" : loaiDH
        ngayTao = ngayTao == nil ? "" : ngayTao
        sdt = sdt == nil ? "" : sdt
        tenKH = tenKH == nil ? "" : tenKH
        tenNV = tenNV == nil ? "" : tenNV
        tenShop = tenShop == nil ? "" : tenShop
        tinhTrang = tinhTrang == nil ? "" : tinhTrang
        u_NumECom = u_NumECom == nil ? 0 : u_NumECom
        
        return EcomSOHeader(DocEntry: docEntry!,GhiChu: ghiChu!,LoaiDH: loaiDH!,NgayTao: ngayTao!,SDT: sdt!,TenKH: tenKH!,TenNV: tenNV!,TenShop: tenShop!,TinhTrang: tinhTrang!,U_NumECom: u_NumECom!)
    }
}
