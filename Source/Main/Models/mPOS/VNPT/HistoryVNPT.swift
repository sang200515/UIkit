//
//  HistoryVNPT.swift
//  fptshop
//
//  Created by Ngo Dang tan on 12/2/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"CMND": "164156657",
//"NgayMua": "27/11/2019",
//"TenKH": "Phạm Trung Kiên",
//"SDT": "0918682668",
//"tenNV": "15261-Nguyễn Phúc Hữu",
//"ShopName": "HCM 305 Tô Hiến Thành",
//"SOMPOS": 0,
//"TongTien": null,
//"SoCalllog": "5798996",
//"TTCalllog": "Từ chối",
//"return_mgs_calllog": null,
//"tenNVcalllog": null
import Foundation
import SwiftyJSON
class HistoryVNPT: NSObject {
    var CMND:String
    var NgayMua:String
    var TenKH:String
    var SDT:String
    var tenNV:String
    var ShopName:String
    var SOMPOS:Int
    var TongTien:Int
    var SoCalllog:String
    var TTCalllog:String
    var return_mgs_calllog:String
    var tenNVcalllog:String
    var TTEdit:String
    var TTuploadAnhKH:String
    var Docentry:Int
    
    init(CMND:String
        , NgayMua:String
        , TenKH:String
        , SDT:String
        , tenNV:String
        , ShopName:String
        , SOMPOS:Int
        , TongTien:Int
        , SoCalllog:String
        , TTCalllog:String
        , return_mgs_calllog:String
        , tenNVcalllog:String
        ,TTEdit:String
        ,TTuploadAnhKH:String
        ,Docentry:Int){
        self.CMND = CMND
        self.NgayMua = NgayMua
        self.TenKH = TenKH
        
        self.SDT = SDT
        self.tenNV = tenNV
        self.ShopName = ShopName
        
        self.SOMPOS = SOMPOS
        self.TongTien = TongTien
        self.SoCalllog = SoCalllog
        
        self.TTCalllog = TTCalllog
        self.return_mgs_calllog = return_mgs_calllog
        self.tenNVcalllog = tenNVcalllog
        self.TTEdit = TTEdit
        self.TTuploadAnhKH = TTuploadAnhKH
        self.Docentry = Docentry
    }
    
    class func parseObjfromArray(array:[JSON])->[HistoryVNPT]{
        var list:[HistoryVNPT] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> HistoryVNPT{
        var CMND = data["CMND"].string
        var NgayMua = data["NgayMua"].string
        var TenKH = data["TenKH"].string
        
        
        var SDT = data["SDT"].string
        var tenNV = data["tenNV"].string
        var ShopName = data["ShopName"].string
        
        var SOMPOS = data["SOMPOS"].int
        var TongTien = data["TongTien"].int
        var SoCalllog = data["SoCalllog"].string
        
        var TTCalllog = data["TTCalllog"].string
        var return_mgs_calllog = data["return_mgs_calllog"].string
        var tenNVcalllog = data["tenNVcalllog"].string
        var TTEdit = data["TTEdit"].string
        var TTuploadAnhKH = data["TTuploadAnhKH"].string
        var Docentry = data["Docentry"].int
        
        CMND = CMND == nil ? "" : CMND
        NgayMua = NgayMua == nil ? "" : NgayMua
        TenKH = TenKH == nil ? "" : TenKH
        
        SDT = SDT == nil ? "" : SDT
        tenNV = tenNV == nil ? "" : tenNV
        ShopName = ShopName == nil ? "" : ShopName
        
        SOMPOS = SOMPOS == nil ? 0 : SOMPOS
        TongTien = TongTien == nil ? 0 : TongTien
        SoCalllog = SoCalllog == nil ? "" : SoCalllog
        
        TTCalllog = TTCalllog == nil ? "" : TTCalllog
        return_mgs_calllog = return_mgs_calllog == nil ? "" : return_mgs_calllog
        tenNVcalllog = tenNVcalllog == nil ? "" : tenNVcalllog
        TTEdit = TTEdit == nil ? "" : TTEdit
        TTuploadAnhKH = TTuploadAnhKH == nil ? "" : TTuploadAnhKH
        Docentry = Docentry == nil ? 0 : Docentry
        return HistoryVNPT(
            CMND:CMND!
            , NgayMua:NgayMua!
            , TenKH:TenKH!
            , SDT:SDT!
            , tenNV:tenNV!
            , ShopName:ShopName!
            , SOMPOS:SOMPOS!
            , TongTien:TongTien!
            , SoCalllog:SoCalllog!
            , TTCalllog:TTCalllog!
            , return_mgs_calllog:return_mgs_calllog!
            , tenNVcalllog:tenNVcalllog!
            ,TTEdit:TTEdit!
            ,TTuploadAnhKH:TTuploadAnhKH!
            ,Docentry:Docentry!
        )
    }
}
