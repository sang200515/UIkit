//
//  ThongTinGiaHanSSD.swift
//  mPOS
//
//  Created by tan on 10/4/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class ThongTinGiaHanSSD:NSObject{
    var NoiDung:String
    var TenKH:String
    var GoiCuoc:String
    var ItemCode:String
    var CampaignID:String
    var VASID:String
    var SDT:String
    var CMND:String
    var NgaySinh:String
    var TienGoiCuoc:Int
    var p_status:Int
    var SoSOPOS:String
    var SoDuTaiKhoan:Int
    
    init(NoiDung:String
        , TenKH:String
        , GoiCuoc:String
        , ItemCode:String
        , CampaignID:String
        , VASID:String
        , SDT:String
        , CMND:String
        , NgaySinh:String
        , TienGoiCuoc:Int
        , p_status:Int
        , SoSOPOS:String
        , SoDuTaiKhoan:Int){
        self.NoiDung = NoiDung
        self.TenKH = TenKH
        self.GoiCuoc =  GoiCuoc
        self.ItemCode = ItemCode
        self.CampaignID = CampaignID
        self.VASID = VASID
        self.SDT = SDT
        self.CMND = CMND
        self.NgaySinh = NgaySinh
        self.TienGoiCuoc = TienGoiCuoc
        self.p_status = p_status
        self.SoSOPOS = SoSOPOS
        self.SoDuTaiKhoan = SoDuTaiKhoan
    }
    
    class func parseObjfromArray(array:[JSON])->[ThongTinGiaHanSSD]{
        var list:[ThongTinGiaHanSSD] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    class func getObjFromDictionary(data:JSON) -> ThongTinGiaHanSSD{
        var NoiDung = data["NoiDung"].string
        var TenKH = data["TenKH"].string
        
        var GoiCuoc = data["GoiCuoc"].string
        var ItemCode = data["ItemCode"].string
        var CampaignID = data["CampaignID"].string
        var VASID = data["VASID"].string
        var SDT = data["SDT"].string
        var CMND = data["CMND"].string
        var NgaySinh = data["NgaySinh"].string
        var TienGoiCuoc = data["TienGoiCuoc"].int
        var p_status = data["p_status"].int
        var SoSOPOS = data["SoSOPOS"].string
        var SoDuTaiKhoan = data["SoDuTaiKhoan"].int
        
        NoiDung = NoiDung == nil ? "" : NoiDung
        TenKH = TenKH == nil ? "" : TenKH
        GoiCuoc = GoiCuoc == nil ? "" : GoiCuoc
        ItemCode = ItemCode == nil ? "" : ItemCode
        CampaignID = CampaignID == nil ? "" : CampaignID
        VASID = VASID == nil ? "" : VASID
        SDT = SDT == nil ? "" : SDT
        CMND = CMND == nil ? "" : CMND
        NgaySinh = NgaySinh == nil ? "" : NgaySinh
        SoSOPOS = SoSOPOS == nil ? "" : SoSOPOS
        SoDuTaiKhoan = SoDuTaiKhoan == nil ? 0 : SoDuTaiKhoan
        
        TienGoiCuoc = TienGoiCuoc == nil ? 0 : TienGoiCuoc
        p_status = p_status == nil ? 0 : p_status
        return ThongTinGiaHanSSD(NoiDung:NoiDung!
            , TenKH:TenKH!
            , GoiCuoc:GoiCuoc!
            , ItemCode:ItemCode!
            , CampaignID:CampaignID!
            , VASID:VASID!
            , SDT:SDT!
            , CMND:CMND!
            , NgaySinh:NgaySinh!
            , TienGoiCuoc:TienGoiCuoc!
            , p_status:p_status!
            , SoSOPOS:SoSOPOS!
            , SoDuTaiKhoan:SoDuTaiKhoan!)
    }
    
}
