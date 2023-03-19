//
//  OutsideInfo.swift
//  fptshop
//
//  Created by Apple on 4/3/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"MaNV": "23747",
//"TenNV": "Nguyễn Hoài Thanh",
//"TinhTrang": "Đang hoạt động",
//"HanMuc": 1000000,
//"HanMucConLai": 1000000,
//"CongNo": 0,
//"JobTitleName": "Kế toán cửa hàng",
//"NgayD": "03/04/2019",
//"NgayD_money": 0,
//"NgayD1": "02/04/2019",
//"NgayD1_money": 0,
//"NgayHetHan": "03/04/2019"

import UIKit
import SwiftyJSON

class OutsideInfo: NSObject {

    let MaNV: String
    let TenNV: String
    let TinhTrang: String
    let HanMuc: Int
    let HanMucConLai: Int
    let CongNo: Int
    let JobTitleName: String
    let NgayD: String
    let NgayD_money: Int
    let NgayD1: String
    let NgayD1_money: Int
    let NgayHetHan: String
    
    
    init(MaNV: String, TenNV: String, TinhTrang: String, HanMuc: Int, HanMucConLai: Int, CongNo: Int, JobTitleName: String, NgayD: String, NgayD_money: Int, NgayD1: String, NgayD1_money: Int, NgayHetHan: String) {
        
        self.MaNV = MaNV
        self.TenNV = TenNV
        self.TinhTrang = TinhTrang
        self.HanMuc = HanMuc
        self.HanMucConLai = HanMucConLai
        self.CongNo = CongNo
        self.JobTitleName = JobTitleName
        self.NgayD = NgayD
        self.NgayD_money = NgayD_money
        self.NgayD1 = NgayD1
        self.NgayD1_money = NgayD1_money
        self.NgayHetHan = NgayHetHan
    }
    
    class func BuildItemFromJSON(data:JSON) -> OutsideInfo{
        
        var MaNV = data["MaNV"].string
        var TenNV = data["TenNV"].string
        var TinhTrang = data["TinhTrang"].string
        var HanMuc = data["HanMuc"].int
        var HanMucConLai = data["HanMucConLai"].int
        var CongNo = data["CongNo"].int
        var JobTitleName = data["JobTitleName"].string
        var NgayD = data["NgayD"].string
        var NgayD_money = data["NgayD_money"].int
        var NgayD1 = data["NgayD1"].string
        var NgayD1_money = data["NgayD1_money"].int
        var NgayHetHan = data["NgayHetHan"].string
        
        MaNV = MaNV == nil ? "" : MaNV
        TenNV = TenNV == nil ? "" : TenNV
        TinhTrang = TinhTrang == nil ? "" : TinhTrang
        HanMuc = HanMuc == nil ? 0 : HanMuc
        HanMucConLai = HanMucConLai == nil ? 0 : HanMucConLai
        CongNo = CongNo == nil ? 0 : CongNo
        JobTitleName = JobTitleName == nil ? "" : JobTitleName
        NgayD = NgayD == nil ? "" : NgayD
        NgayD_money = NgayD_money == nil ? 0 : NgayD_money
        NgayD1 = NgayD1 == nil ? "" : NgayD1
        NgayD1_money = NgayD1_money == nil ? 0 : NgayD1_money
        NgayHetHan = NgayHetHan == nil ? "" : NgayHetHan
        
        
        return OutsideInfo(MaNV: MaNV!, TenNV: TenNV!, TinhTrang: TinhTrang!, HanMuc: HanMuc!, HanMucConLai: HanMucConLai!, CongNo: CongNo!, JobTitleName: JobTitleName!, NgayD: NgayD!, NgayD_money: NgayD_money!, NgayD1: NgayD1!, NgayD1_money: NgayD1_money!, NgayHetHan: NgayHetHan!)
    }
    
    class func parseObjfromArray(array: [JSON])->[OutsideInfo]{
        var list:[OutsideInfo] = []
        for item in array {
            list.append(self.BuildItemFromJSON(data: item))
        }
        return list
    }
}
