//
//  BaoHiem_getGiaBanAllResult.swift
//  mPOS
//
//  Created by sumi on 7/25/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaoHiem_getGiaBanAllResult: NSObject {
    
    var GiaSPChinh: String
    var NgoiSau: String
    var GiaTong: String
    var LoaiXe: String
    var DoiTuong: String
    var DoiTuongName: String

    init(GiaSPChinh: String, NgoiSau: String, GiaTong: String, LoaiXe: String, DoiTuong: String, DoiTuongName: String){
        self.GiaSPChinh = GiaSPChinh
        self.NgoiSau = NgoiSau
        self.GiaTong = GiaTong
        self.LoaiXe = LoaiXe
        self.DoiTuong = DoiTuong
        self.DoiTuongName = DoiTuongName
    }
    
    class func parseObjfromArray(array:[JSON])->[BaoHiem_getGiaBanAllResult]{
        var list:[BaoHiem_getGiaBanAllResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> BaoHiem_getGiaBanAllResult{
        var GiaSPChinh = data["GiaSPChinh"].string
        var NgoiSau = data["NgoiSau"].string
        var GiaTong = data["GiaTong"].string
        
        var LoaiXe = data["LoaiXe"].string
        var DoiTuong = data["DoiTuong"].string
        var DoiTuongName = data["DoiTuongName"].string
        
        GiaSPChinh = GiaSPChinh == nil ? "": GiaSPChinh
        NgoiSau = NgoiSau == nil ? "" : NgoiSau
        GiaTong = GiaTong == nil ? "" : GiaTong
        
        LoaiXe = LoaiXe == nil ? "": LoaiXe
        DoiTuong = DoiTuong == nil ? "" : DoiTuong
        DoiTuongName = DoiTuongName == nil ? "" : DoiTuongName
        
        return BaoHiem_getGiaBanAllResult(GiaSPChinh: GiaSPChinh!, NgoiSau: NgoiSau!, GiaTong: GiaTong!, LoaiXe: LoaiXe!, DoiTuong: DoiTuong!, DoiTuongName: DoiTuongName!)
    }
}


