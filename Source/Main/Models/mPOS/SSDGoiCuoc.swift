//
//  SSDGoiCuoc.swift
//  mPOS
//
//  Created by MinhDH on 4/23/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class SSDGoiCuoc: NSObject {
    
    var Data: String
    var Facebook: Int //= 0 : không có 1: có hỗ trợ miễn phí
    var GiaGoi: Int
    var NhaMang: String
    var SMSNoiMang: String
    var SothangCamKet: Int
    var TenGoiCuoc: String
    var ThoaiLienMang: String
    var ThoaiNoiMang: String
    var MaSP:String
    
    init(Data: String, Facebook: Int, GiaGoi: Int, NhaMang: String, SMSNoiMang: String, SothangCamKet: Int, TenGoiCuoc: String, ThoaiLienMang: String, ThoaiNoiMang: String,MaSP:String){
        self.Data = Data
        self.Facebook = Facebook
        self.GiaGoi = GiaGoi
        self.NhaMang = NhaMang
        self.SMSNoiMang = SMSNoiMang
        self.SothangCamKet = SothangCamKet
        self.TenGoiCuoc = TenGoiCuoc
        self.ThoaiLienMang = ThoaiLienMang
        self.ThoaiNoiMang = ThoaiNoiMang
        self.MaSP = MaSP
    }
    class func parseObjfromArray(array:[JSON])->[SSDGoiCuoc]{
        var list:[SSDGoiCuoc] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> SSDGoiCuoc{
        
        var data1 = data["Data"].string
        var facebook = data["Facebook"].int
        var giaGoi = data["GiaGoi"].int
        var nhaMang = data["NhaMang"].string
        
        var smsNoiMang = data["SMSNoiMang"].string
        var sothangCamKet = data["SothangCamKet"].int
        var tenGoiCuoc = data["TenGoiCuoc"].string
        var thoaiLienMang = data["ThoaiLienMang"].string
        var thoaiNoiMang = data["ThoaiNoiMang"].string
        var maSP = data["MaSP"].string
        
        data1 = data1 == nil ? "" : data1
        facebook = facebook == nil ? 0 : facebook
        giaGoi = giaGoi == nil ? 0 : giaGoi
        nhaMang = nhaMang == nil ? "" : nhaMang
        
        smsNoiMang = smsNoiMang == nil ? "" : smsNoiMang
        sothangCamKet = sothangCamKet == nil ? 0 : sothangCamKet
        tenGoiCuoc = tenGoiCuoc == nil ? "" : tenGoiCuoc
        thoaiLienMang = thoaiLienMang == nil ? "" : thoaiLienMang
        thoaiNoiMang = thoaiNoiMang == nil ? "" : thoaiNoiMang
        maSP = maSP == nil ? "" : maSP
        
        return SSDGoiCuoc(Data: data1!, Facebook:facebook!, GiaGoi: giaGoi!, NhaMang: nhaMang!, SMSNoiMang: smsNoiMang!, SothangCamKet: sothangCamKet!, TenGoiCuoc: tenGoiCuoc!, ThoaiLienMang: thoaiLienMang!, ThoaiNoiMang: thoaiNoiMang!,MaSP: maSP!)
    }
}
