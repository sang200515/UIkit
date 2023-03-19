//
//  Mirae_LoadInfo_Send_Bill.swift
//  fptshop
//
//  Created by Apple on 9/3/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"Shop_PB": "Công ty Mirae Asset",
//"DiaChi": "Lầu 3, Tòa nhà Pax Sky, Số 26 Ung Văn Khiêm, Phường 25",
//"TinhTP": 23,
//"QuanHuyen": 237,
//"NguoiNhan": "Bùi Ngọc Ánh",
//"SDT": "0789807306",
//"Loaihang": 2,
//"TenHangHoa": "Chứng từ Mirae",
//"DichVu": "chuyenphatnhanh",
//"HinhThucTT": 1

import UIKit
import SwiftyJSON

class Mirae_LoadInfo_Send_Bill: NSObject {
    
    let Shop_PB: String
    let DiaChi: String
    let TinhTP: Int
    let QuanHuyen: Int
    let NguoiNhan: String
    let SDT: String
    let Loaihang: Int
    let TenHangHoa: String
    let DichVu: String
    let HinhThucTT: Int
    
    init(Shop_PB: String, DiaChi: String, TinhTP: Int, QuanHuyen: Int, NguoiNhan: String, SDT: String, Loaihang: Int, TenHangHoa: String, DichVu: String, HinhThucTT: Int) {
        self.Shop_PB = Shop_PB
        self.DiaChi = DiaChi
        self.TinhTP = TinhTP
        self.QuanHuyen = QuanHuyen
        self.NguoiNhan = NguoiNhan
        self.SDT = SDT
        self.Loaihang = Loaihang
        self.TenHangHoa = TenHangHoa
        self.DichVu = DichVu
        self.HinhThucTT = HinhThucTT
    }
    
    class func parseObjfromArray(array:[JSON])->[Mirae_LoadInfo_Send_Bill]{
        var list:[Mirae_LoadInfo_Send_Bill] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> Mirae_LoadInfo_Send_Bill {
        var Shop_PB = data["Shop_PB"].string
        var DiaChi = data["DiaChi"].string
        var TinhTP = data["TinhTP"].int
        var QuanHuyen = data["QuanHuyen"].int
        var NguoiNhan = data["NguoiNhan"].string
        var SDT = data["SDT"].string
        var Loaihang = data["Loaihang"].int
        var TenHangHoa = data["TenHangHoa"].string
        var DichVu = data["DichVu"].string
        var HinhThucTT = data["HinhThucTT"].int
        
        Shop_PB = Shop_PB == nil ? "" : Shop_PB
        DiaChi = DiaChi == nil ? "" : DiaChi
        TinhTP = TinhTP == nil ? 0 : TinhTP
        QuanHuyen = QuanHuyen == nil ? 0 : QuanHuyen
        NguoiNhan = NguoiNhan == nil ? "" : NguoiNhan
        SDT = SDT == nil ? "" : SDT
        Loaihang = Loaihang == nil ? 0 : Loaihang
        TenHangHoa = TenHangHoa == nil ? "" : TenHangHoa
        DichVu = DichVu == nil ? "" : DichVu
        HinhThucTT = HinhThucTT == nil ? 0 : HinhThucTT
        
        return Mirae_LoadInfo_Send_Bill(Shop_PB: Shop_PB!, DiaChi: DiaChi!, TinhTP: TinhTP!, QuanHuyen: QuanHuyen!, NguoiNhan: NguoiNhan!, SDT: SDT!, Loaihang: Loaihang!, TenHangHoa: TenHangHoa!, DichVu: DichVu!, HinhThucTT: HinhThucTT!)
    }
}
