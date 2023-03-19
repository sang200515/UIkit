//
//  GiaoNhan_LichSuGiaoNhan.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class GiaoNhan_LichSuGiaoNhan: NSObject {
    
    var STT: String
    var TenDiemBatDau: String
    var U_Action:String
    var DiemDen:String
    var TongSoPhieu: String
    var DiaChiDiemBatDau: String
    var Note:String
    var DoDai:String
    var DiemBatDau:String
    var TenDiemDen:String
    var TimeCheckIn:String
    var DiaChiDiemDen:String
    var SLGiao:String
    var SLNhan:String
    var LinkHinhAnhXacNhan:String
    var LinkHinhAnhChuKy:String
    var LoaiDiemDen:String
    var MaCheckIn:String
    var UserCode_XN:String
    var LinkHinhAnhChuKyGiaoNhan:String
    
    
    init(GiaoNhan_LichSuGiaoNhan: JSON)
    {
        STT = GiaoNhan_LichSuGiaoNhan["STT"].stringValue ;
        TenDiemBatDau = GiaoNhan_LichSuGiaoNhan["TenDiemBatDau"].stringValue;
        U_Action = GiaoNhan_LichSuGiaoNhan["U_Action"].stringValue;
        DiemDen = GiaoNhan_LichSuGiaoNhan["DiemDen"].stringValue;
        TongSoPhieu = GiaoNhan_LichSuGiaoNhan["TongSoPhieu"].stringValue ;
        DiaChiDiemBatDau = GiaoNhan_LichSuGiaoNhan["DiaChiDiemBatDau"].stringValue;
        Note = GiaoNhan_LichSuGiaoNhan["Note"].stringValue;
        DoDai = GiaoNhan_LichSuGiaoNhan["DoDai"].stringValue;
        DiemBatDau = GiaoNhan_LichSuGiaoNhan["DiemBatDau"].stringValue;
        
        TenDiemDen = GiaoNhan_LichSuGiaoNhan["TenDiemDen"].stringValue;
        TimeCheckIn = GiaoNhan_LichSuGiaoNhan["TimeCheckIn"].stringValue;
        DiaChiDiemDen = GiaoNhan_LichSuGiaoNhan["DiaChiDiemDen"].stringValue;
        
        SLGiao = GiaoNhan_LichSuGiaoNhan["SLGiao"].stringValue;
        SLNhan = GiaoNhan_LichSuGiaoNhan["SLNhan"].stringValue;
        
        LinkHinhAnhXacNhan = GiaoNhan_LichSuGiaoNhan["LinkHinhAnhXacNhan"].stringValue;
        LinkHinhAnhChuKy = GiaoNhan_LichSuGiaoNhan["LinkHinhAnhChuKy"].stringValue;
        
        LoaiDiemDen  = GiaoNhan_LichSuGiaoNhan["LoaiDiemDen"].stringValue;
        MaCheckIn = GiaoNhan_LichSuGiaoNhan["MaCheckIn"].stringValue;
        UserCode_XN = GiaoNhan_LichSuGiaoNhan["UserCode_XN"].stringValue;
        LinkHinhAnhChuKyGiaoNhan = GiaoNhan_LichSuGiaoNhan["LinkHinhAnhChuKyGiaoNhan"].stringValue;
    }
}

