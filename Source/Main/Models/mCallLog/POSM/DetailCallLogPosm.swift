//
//  DetailCallLogPosm.swift
//  fptshop
//
//  Created by Ngo Dang tan on 7/25/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class DetailCallLogPosm: NSObject {
    var ChoPhepUpHinh:Bool
    var LinkHinhMau:String
    var LinkHinhShopUp:String
    var LyDoKhongDuyet:String
    var LyDoKhongUpHinh: String
    var RequestDetailId:String
    var RequestId:String
    var TenCongViecChiTiet:String
    var TinhTrangDuyet:String
    var TinhTrangDuyet_Text:String
    var row:Int
    var imageSample:UIImage!
    var isCapture:Bool!
    
    init(ChoPhepUpHinh:Bool
      , LinkHinhMau:String
      , LinkHinhShopUp:String
      , LyDoKhongDuyet:String
      , LyDoKhongUpHinh: String
      , RequestDetailId:String
      , RequestId:String
      , TenCongViecChiTiet:String
      , TinhTrangDuyet:String
      , TinhTrangDuyet_Text:String
        ,row:Int
        ,imageSample:UIImage
        ,isCapture:Bool){
        self.ChoPhepUpHinh = ChoPhepUpHinh
        self.LinkHinhMau = LinkHinhMau
        self.LinkHinhShopUp = LinkHinhShopUp
        self.LyDoKhongDuyet = LyDoKhongDuyet
        self.RequestDetailId = RequestDetailId
        self.RequestId = RequestId
        self.TenCongViecChiTiet = TenCongViecChiTiet
        self.TinhTrangDuyet = TinhTrangDuyet
        self.TinhTrangDuyet_Text = TinhTrangDuyet_Text
        self.row = row
        self.imageSample = imageSample
        self.isCapture = isCapture
        self.LyDoKhongUpHinh = LyDoKhongUpHinh
    }
    
    class func parseObjfromArray(array:[JSON])->[DetailCallLogPosm]{
         var list:[DetailCallLogPosm] = []
         for item in array {
             list.append(self.getObjFromDictionary(data: item))
         }
         return list
     }
     class func getObjFromDictionary(data:JSON) -> DetailCallLogPosm{
          
          var ChoPhepUpHinh = data["ChoPhepUpHinh"].bool
        var LinkHinhMau = data["LinkHinhMau"].string
        var LinkHinhShopUp = data["LinkHinhShopUp"].string
        var LyDoKhongDuyet = data["LyDoKhongDuyet"].string
        var RequestDetailId = data["RequestDetailId"].string
        var RequestId = data["RequestId"].string
        var TenCongViecChiTiet = data["TenCongViecChiTiet"].string
        var TinhTrangDuyet = data["TinhTrangDuyet"].string
        var TinhTrangDuyet_Text = data["TinhTrangDuyet_Text"].string
        var LyDoKhongUpHinh = data["LyDoKhongUpHinh"].string
        
          
          ChoPhepUpHinh = ChoPhepUpHinh == nil ? false : ChoPhepUpHinh
        LinkHinhMau = LinkHinhMau == nil ? "" : LinkHinhMau
        LinkHinhShopUp = LinkHinhShopUp == nil ? "" : LinkHinhShopUp
        LyDoKhongDuyet = LyDoKhongDuyet == nil ? "" : LyDoKhongDuyet
        LyDoKhongUpHinh = LyDoKhongUpHinh == nil ? "" : LyDoKhongUpHinh
        RequestDetailId = RequestDetailId == nil ? "" : RequestDetailId
        RequestId = RequestId == nil ? "" : RequestId
        TenCongViecChiTiet = TenCongViecChiTiet == nil ? "" : TenCongViecChiTiet
        TinhTrangDuyet = TinhTrangDuyet == nil ? "" : TinhTrangDuyet
        TinhTrangDuyet_Text = TinhTrangDuyet_Text == nil ? "" : TinhTrangDuyet_Text
        
          return DetailCallLogPosm(ChoPhepUpHinh:ChoPhepUpHinh!
          , LinkHinhMau:LinkHinhMau!
          , LinkHinhShopUp:LinkHinhShopUp!
          , LyDoKhongDuyet:LyDoKhongDuyet!
          , LyDoKhongUpHinh: LyDoKhongUpHinh!
          , RequestDetailId:RequestDetailId!
          , RequestId:RequestId!
          , TenCongViecChiTiet:TenCongViecChiTiet!
          , TinhTrangDuyet:TinhTrangDuyet!
          , TinhTrangDuyet_Text:TinhTrangDuyet_Text!
            ,row:0,
        imageSample: #imageLiteral(resourceName: "avatar")
            ,isCapture:false)
      }
}
