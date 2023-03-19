//
//  DescriptionRightPhone.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/19/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"mota_DienThoai": "",
//               "mota_phukien": "",
//               "CMND": "",
//               "NgayCapCMND": "01/01/1900",
//               "NoiCapCMND": "",
//               "DiaChiThuongTru": "",
//               "DiaChiHienTai": "",
//               "SDT_home": ""
import Foundation
import SwiftyJSON
class DescriptionRightPhone: NSObject {
    var mota_DienThoai:String
    var mota_phukien:String
    var CMND:String
    var NgayCapCMND:String
    var NoiCapCMND:String
    var DiaChiThuongTru:String
    var DiaChiHienTai:String
    var SDT_home:String
    init(   mota_DienThoai:String
      , mota_phukien:String
      , CMND:String
      , NgayCapCMND:String
        , NoiCapCMND:String
        ,DiaChiThuongTru:String
        ,DiaChiHienTai:String
        ,SDT_home:String){
        
        self.mota_DienThoai = mota_DienThoai
        self.mota_phukien = mota_phukien
        self.CMND = CMND
        self.NgayCapCMND = NgayCapCMND
        self.NoiCapCMND = NoiCapCMND
        self.DiaChiThuongTru = DiaChiThuongTru
        self.DiaChiHienTai = DiaChiHienTai
        self.SDT_home = SDT_home
    }
    class func parseObjfromArray(array:[JSON])->[DescriptionRightPhone]{
         var list:[DescriptionRightPhone] = []
         for item in array {
             list.append(self.getObjFromDictionary(data: item))
         }
         return list
     }
     
     class func getObjFromDictionary(data:JSON) -> DescriptionRightPhone{
         var mota_DienThoai = data["mota_DienThoai"].string
         var mota_phukien = data["mota_phukien"].string
        var CMND = data["CMND"].string
        var NgayCapCMND = data["NgayCapCMND"].string
        var NoiCapCMND = data["NoiCapCMND"].string
        var DiaChiThuongTru = data["DiaChiThuongTru"].string
        var DiaChiHienTai = data["DiaChiHienTai"].string
        var SDT_home = data["SDT_home"].string
        
        
         mota_DienThoai = mota_DienThoai == nil ? "" : mota_DienThoai
         mota_phukien = mota_phukien == nil ? "" : mota_phukien
        CMND = CMND == nil ? "" : CMND
        NgayCapCMND = NgayCapCMND == nil ? "" : NgayCapCMND
        NoiCapCMND = NoiCapCMND == nil ? "" : NoiCapCMND
          DiaChiThuongTru = DiaChiThuongTru == nil ? "" : DiaChiThuongTru
          DiaChiHienTai = DiaChiHienTai == nil ? "" : DiaChiHienTai
               SDT_home = SDT_home == nil ? "" : SDT_home
         return DescriptionRightPhone(mota_DienThoai:mota_DienThoai!
         , mota_phukien:mota_phukien!
         , CMND:CMND!
         , NgayCapCMND:NgayCapCMND!
           , NoiCapCMND:NoiCapCMND!
           ,DiaChiThuongTru:DiaChiThuongTru!
           ,DiaChiHienTai:DiaChiHienTai!
           ,SDT_home:SDT_home!)
     }
}
