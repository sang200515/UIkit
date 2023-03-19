//
//  CompanyFFriend.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class CompanyFFriend: NSObject {
    
    var ID: Int
    var VendorName: String
    var DuoiEmail: String
    var HinhThucTT:String
    var HinhThucXN:String
    var ChiNhanh: [BranchCompanyFFriend]
    var KyHanTra: [KyHan]
    var ChucVu: [ChucVuFFriend]
    var Knox: String
    
    init(ID: Int, VendorName: String, DuoiEmail: String,HinhThucTT:String,HinhThucXN:String, ChiNhanh: [BranchCompanyFFriend],KyHanTra: [KyHan],ChucVu: [ChucVuFFriend],Knox: String){
        self.ID = ID
        self.VendorName = VendorName
        self.DuoiEmail = DuoiEmail
        self.HinhThucTT = HinhThucTT
        self.HinhThucXN = HinhThucXN
        self.ChiNhanh = ChiNhanh
        self.KyHanTra = KyHanTra
        self.ChucVu = ChucVu
        self.Knox = Knox
    }
    class func parseObjfromArray(array:[JSON])->[CompanyFFriend]{
        var list:[CompanyFFriend] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> CompanyFFriend{
        
        var id = data["ID"].int
        var vendorName = data["vendorname"].string
        var duoiEmail = data["DuoiEmail"].string
        var hinhThucTT = data["HTThanhToan"].string
        var hinhThucXN = data["HinhThucXacNhan"].string
        var chiNhanh = data["ChiNhanh"].array
        var kyHan = data["KyHan"].array
        var chucVu = data["ChucVu"].array
        var knox = data["Knox"].string
        
        id = id == nil ? 0 : id
        vendorName = vendorName == nil ? "" : vendorName
        duoiEmail = duoiEmail == nil ? "" : duoiEmail
        hinhThucTT = hinhThucTT == nil ? "" : hinhThucTT
        hinhThucXN = hinhThucXN == nil ? "" : hinhThucXN
        chiNhanh = chiNhanh == nil ? [] : chiNhanh
        kyHan = kyHan == nil ? [] : kyHan
        chucVu = chucVu == nil ? [] : chucVu
        
        knox = knox == nil ? "" : knox
        
        let chiNhanhArr = BranchCompanyFFriend.parseObjfromArray(array: chiNhanh!)
        let kyHanArr = KyHan.parseObjfromArray(array: kyHan!)
        let chucVuArr = ChucVuFFriend.parseObjfromArray(array: chucVu!)
        
        return CompanyFFriend(ID: id!, VendorName: vendorName!, DuoiEmail: duoiEmail!,HinhThucTT:hinhThucTT!,HinhThucXN: hinhThucXN!, ChiNhanh: chiNhanhArr,KyHanTra: kyHanArr,ChucVu: chucVuArr,Knox:knox!)
    }
    
}

