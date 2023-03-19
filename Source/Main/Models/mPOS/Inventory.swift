//
//  Inventory.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class Inventory: NSObject {
    var IsIphoneIpad: String
    var MaKho: String
    var MaSP: String
    var MaShop: String
    var Price: Float
    var Price_BT: Float
    var QLSerial: String
    var SL: Int
    var TenDongHang: String
    var TenKho: String
    var TenLoaiHang: String
    var TenNganhHang: String
    var TenNhanHang: String
    var TenNhomHang: String
    var TenSP: String
    var TenShop: String
    var Tinh: String
    var Vung: String
    
    init(IsIphoneIpad: String,MaKho: String,MaSP: String,MaShop: String,Price: Float,Price_BT: Float,QLSerial: String,SL: Int,TenDongHang: String,TenKho: String,TenLoaiHang: String,TenNganhHang: String,TenNhanHang: String,TenNhomHang: String,TenSP: String,TenShop: String,Tinh: String,Vung: String) {
        self.IsIphoneIpad = IsIphoneIpad
        self.MaKho = MaKho
        self.MaSP = MaSP
        self.MaShop = MaShop
        self.Price = Price
        self.Price_BT = Price_BT
        self.QLSerial = QLSerial
        self.SL = SL
        self.TenDongHang = TenDongHang
        self.TenKho = TenKho
        self.TenLoaiHang = TenLoaiHang
        self.TenNganhHang = TenNganhHang
        self.TenNhanHang = TenNhanHang
        self.TenNhomHang = TenNhomHang
        self.TenSP = TenSP
        self.TenShop = TenShop
        self.Tinh = Tinh
        self.Vung = Vung
    }
    class func parseObjfromArray(array:[JSON])->[Inventory]{
        var list:[Inventory] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> Inventory{
        
        var isIphoneIpad = data["IsIphoneIpad"].string
        var maKho = data["MaKho"].string
        var maSP = data["MaSP"].string
        var maShop = data["MaShop"].string
        var price = data["Price"].float
        var price_BT = data["Price_BT"].float
        var qlSerial = data["QLSerial"].string
        var sl = data["SL"].int
        var tenDongHang = data["TenDongHang"].string
        var tenKho = data["TenKho"].string
        var tenLoaiHang = data["TenLoaiHang"].string
        var tenNganhHang = data["TenNganhHang"].string
        var tenNhanHang = data["TenNhanHang"].string
        var tenNhomHang = data["TenNhomHang"].string
        var tenSP = data["TenSP"].string
        var tenShop = data["TenShop"].string
        var tinh = data["Tinh"].string
        var vung = data["Vung"].string
        
        isIphoneIpad = isIphoneIpad == nil ? "" : isIphoneIpad
        maKho = maKho == nil ? "" : maKho
        maSP = maSP == nil ? "" : maSP
        maShop = maShop == nil ? "" : maShop
        price = price == nil ? 0 : price
        price_BT = price_BT == nil ? 0 : price_BT
        qlSerial = qlSerial == nil ? "" : qlSerial
        sl = sl == nil ? 0 : sl
        tenDongHang = tenDongHang == nil ? "" : tenDongHang
        tenKho = tenKho == nil ? "" : tenKho
        tenLoaiHang = tenLoaiHang == nil ? "" : tenLoaiHang
        tenNganhHang = tenNganhHang == nil ? "" : tenNganhHang
        tenNhanHang = tenNhanHang == nil ? "" : tenNhanHang
        tenNhomHang = tenNhomHang == nil ? "" : tenNhomHang
        tenSP = tenSP == nil ? "" : tenSP
        tenShop = tenShop == nil ? "" : tenShop
        tinh = tinh == nil ? "" : tinh
        vung = vung == nil ? "" : vung
        
        return Inventory(IsIphoneIpad: isIphoneIpad!,MaKho: maKho!,MaSP: maSP!,MaShop: maShop!,Price: price!,Price_BT: price_BT!,QLSerial: qlSerial!,SL: sl!,TenDongHang: tenDongHang!,TenKho: tenKho!,TenLoaiHang: tenLoaiHang!,TenNganhHang: tenNganhHang!,TenNhanHang: tenNhanHang!,TenNhomHang: tenNhomHang!,TenSP: tenSP!,TenShop: tenShop!,Tinh: tinh!,Vung: vung!)
    }
}

