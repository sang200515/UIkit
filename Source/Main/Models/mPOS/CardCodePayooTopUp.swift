//
//  CardCodePayooTopUp.swift
//  mPOS
//
//  Created by sumi on 5/28/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class CardCodePayooTopUp: NSObject {
    
    var DiaChi: String
    var SoDienThoai: String
    var TenLoaiThe: String
    var MenhGiaThe: String
    var ThoiGianXuat: String
    var SoPhieuThu: String
    var MaVoucher:String
    var HanSuDung:String
    var Employee: String
    
    init(DiaChi: String,SoDienThoai: String,TenLoaiThe: String,MenhGiaThe: String,ThoiGianXuat: String,SoPhieuThu: String,MaVoucher:String,HanSuDung:String, Employee: String = "\(Cache.user!.UserName)-\(Cache.user!.EmployeeName)"){
        self.DiaChi = DiaChi
        self.SoDienThoai = SoDienThoai
        self.TenLoaiThe = TenLoaiThe
        self.MenhGiaThe = MenhGiaThe
        self.ThoiGianXuat = ThoiGianXuat
        self.SoPhieuThu = SoPhieuThu
        self.MaVoucher = MaVoucher
        self.HanSuDung = HanSuDung
        self.Employee = Employee
    }
    class func parseObjfromArray(array:[JSON])->[CardCodePayooTopUp]{
        var list:[CardCodePayooTopUp] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> CardCodePayooTopUp{
        
        var DiaChi = data["DiaChi"].string
        var SoDienThoai = data["SoDienThoai"].string
        var TenLoaiThe = data["TenLoaiThe"].string
        var MenhGiaThe = data["MenhGiaThe"].string
        var ThoiGianXuat = data["ThoiGianXuat"].string
        var SoPhieuThu = data["SoPhieuThu"].string
        
        
        DiaChi = DiaChi == nil ? "" : DiaChi
        SoDienThoai = SoDienThoai == nil ? "" : SoDienThoai
        TenLoaiThe = TenLoaiThe == nil ? "" : TenLoaiThe
        MenhGiaThe = MenhGiaThe == nil ? "" : MenhGiaThe
        ThoiGianXuat = ThoiGianXuat == nil ? "" : ThoiGianXuat
        SoPhieuThu = SoPhieuThu == nil ? "" : SoPhieuThu
        
        
        return CardCodePayooTopUp(DiaChi: DiaChi!,SoDienThoai: SoDienThoai!,TenLoaiThe: TenLoaiThe!,MenhGiaThe: MenhGiaThe!,ThoiGianXuat: ThoiGianXuat!,SoPhieuThu: SoPhieuThu!, MaVoucher: "", HanSuDung: "")
    }
}

extension CardCodePayooTopUp {
    func toJSON() -> Dictionary<String, Any> {
        return [
            "DiaChi": self.DiaChi,
            "SoDienThoai": self.SoDienThoai,
            "TenLoaiThe": self.TenLoaiThe,
            "MenhGiaThe": self.MenhGiaThe,
            "ThoiGianXuat": self.ThoiGianXuat,
            "SoPhieuThu": self.SoPhieuThu,
            "MaVoucher":self.MaVoucher,
            "HanSuDung":self.HanSuDung,
            "Employee": self.Employee
        ]
    }
}
