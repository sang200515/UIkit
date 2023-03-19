//
//  SPTraGop.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class SPTraGop: NSObject {
    
    var ItemCode: String
    var TenSanPham: String
    var LaiSuat: Float
    var KyHan: String
    var SL: Int
    var docentry: String
    var SoTienTraTruoc: Float
    var DiemThuong: String
    var ImageUrl: String
    var Price: String
    var model_id:String
    
    
    init(ItemCode: String, TenSanPham: String, LaiSuat: Float, KyHan: String, SL: Int, docentry: String, SoTienTraTruoc: Float, DiemThuong: String, ImageUrl: String, Price: String,model_id: String){
        self.ItemCode = ItemCode
        self.TenSanPham = TenSanPham
        self.LaiSuat = LaiSuat
        self.KyHan = KyHan
        self.SL = SL
        self.docentry = docentry
        self.SoTienTraTruoc = SoTienTraTruoc
        self.DiemThuong = DiemThuong
        self.ImageUrl = ImageUrl
        self.Price = Price
        self.model_id = model_id
    }
    class func parseObjfromArray(array:[JSON])->[SPTraGop]{
        var list:[SPTraGop] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> SPTraGop{
        
        var itemCode = data["ItemCode"].string
        var tenSanPham = data["TenSanPham"].string
        var laiSuat = data["LaiSuat"].float
        var kyHan = data["KyHan"].string
        var sl = data["SL"].int
        var docentry = data["docentry"].string
        var soTienTraTruoc = data["SoTienTraTruoc"].float
        var diemThuong = data["DiemThuong"].string
        var imageUrl = data["ImageUrl"].string
        var price = data["Price"].string
        var model_id = data["model_id"].string
        
        
        
        itemCode = itemCode == nil ? "" : itemCode
        tenSanPham = tenSanPham == nil ? "" : tenSanPham
        laiSuat = laiSuat == nil ? 0 : laiSuat
        kyHan = kyHan == nil ? "" : kyHan
        sl = sl == nil ? 0 : sl
        docentry = docentry == nil ? "" : docentry
        soTienTraTruoc = soTienTraTruoc == nil ? 0 : soTienTraTruoc
        diemThuong = diemThuong == nil ? "" : diemThuong
        imageUrl = imageUrl == nil ? "" : imageUrl
        price = price == nil ? "" : price
        model_id = model_id == nil ? "" : model_id
        
        return SPTraGop(ItemCode: itemCode!, TenSanPham: tenSanPham!, LaiSuat: laiSuat!, KyHan: kyHan!, SL: sl!, docentry: docentry!, SoTienTraTruoc: soTienTraTruoc!, DiemThuong: diemThuong!, ImageUrl: imageUrl!, Price: price!, model_id:model_id!)
    }
}


