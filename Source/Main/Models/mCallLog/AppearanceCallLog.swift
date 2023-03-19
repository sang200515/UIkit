//
//  AppearanceCallLog.swift
//  mCallLog_v2
//
//  Created by Trần Thành Phương Đăng on 02/10/18.
//  Copyright © 2018 vn.com.fptshop. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class AppearanceCallLog: Jsonable{
    required init(json: JSON) {
        Msg = json["Msg"].string ?? "";
        RequestDetail_Approved = json["RequestDetail_Approved"].int ?? 0;
        RequestDetail_HinhAnhMayLoi = json["RequestDetail_HinhAnhMayLoi"].string ?? "";
        RequestDetail_HinhAnhVoHop = json["RequestDetail_HinhAnhVoHop"].string ?? "";
        RequestDetail_Id = json["RequestDetail_Id"].int ?? 0;
        RequestDetail_Imei = json["RequestDetail_Imei"].string ?? "";
        RequestDetail_MaSanPham = json["RequestDetail_MaSanPham"].string ?? "";
        RequestDetail_NgayXuat = json["RequestDetail_NgayXuat"].string ?? "";
        RequestDetail_SoDonHang = json["RequestDetail_SoDonHang"].int ?? 0;
        RequestDetail_SoHD = json["RequestDetail_SoHD"].int ?? 0;
        RequestDetail_SoLuong = json["RequestDetail_SoLuong"].int ?? 0;
        RequestDetail_TenSanPham = json["RequestDetail_TenSanPham"].string ?? "";
        RequestDetail_TieuChiTinhPhi = json["RequestDetail_TieuChiTinhPhi"].string ?? "";
        Request_DeadLine = json["Request_Deadline"].string ?? "";
        Request_Id = json["Request_Id"].int ?? 0;
        Request_LastConversation = json["Request_LastConversation"].string ?? "";
        Request_Status = json["Request_Status"].int ?? 0;
        Request_StepNo = json["Request_StepNo"].int ?? 0;
        Result = json["Result"].int ?? 0;
        STT = json["STT"].int ?? 0;
    }
    
    var Msg: String?
    var RequestDetail_Approved: Int?
    var RequestDetail_HinhAnhMayLoi: String?
    var RequestDetail_HinhAnhVoHop: String?
    var RequestDetail_Id: Int?
    var RequestDetail_Imei: String?
    var RequestDetail_MaSanPham: String?
    var RequestDetail_NgayXuat: String?
    var RequestDetail_SoDonHang: Int?
    var RequestDetail_SoHD: Int?
    var RequestDetail_SoLuong: Int?
    var RequestDetail_TenSanPham: String?
    var RequestDetail_TieuChiTinhPhi: String?
    var Request_DeadLine: String?
    var Request_Id: Int?
    var Request_LastConversation: String?
    var Request_Status: Int?
    var Request_StepNo: Int?
    var Result: Int?
    var STT: Int?
}
