//
//  GiaDungModel.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 24/03/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class GiaDungRealtime: Mappable {
    var result : [GiaDungResult] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        if map.JSON.description.contains("sp_FRT_MSM_Baocaogiadung_Daily_Vung_View_FinalResult") {
            result <- map["sp_FRT_MSM_Baocaogiadung_Daily_Vung_View_FinalResult"]
        } else if map.JSON.description.contains("sp_FRT_MSM_Baocaogiadung_Daily_KhuVuc_View_FinalResult") {
            result <- map["sp_FRT_MSM_Baocaogiadung_Daily_KhuVuc_View_FinalResult"]
        } else if map.JSON.description.contains("sp_FRT_MSM_Baocaogiadung_Daily_Shop_View_FinalResult") {
            result <- map["sp_FRT_MSM_Baocaogiadung_Daily_Shop_View_FinalResult"]
        } else if map.JSON.description.contains("sp_FRT_MSM_Baocaogiadung_Realtime_Vung_View_FinalResult") {
            result <- map["sp_FRT_MSM_Baocaogiadung_Realtime_Vung_View_FinalResult"]
        } else if map.JSON.description.contains("sp_FRT_MSM_Baocaogiadung_Realtime_Khuvuc_View_FinalResult") {
            result <- map["sp_FRT_MSM_Baocaogiadung_Realtime_Khuvuc_View_FinalResult"]
        } else if map.JSON.description.contains("sp_FRT_MSM_Baocaogiadung_Realtime_Shop_View_FinalResult") {
            result <- map["sp_FRT_MSM_Baocaogiadung_Realtime_Shop_View_FinalResult"]
        }
    }
}

class GiaDungResult: Mappable {
    var mtdGiaDung: String = ""
    var m1: String = ""
    var total: String = ""
    var targetGiaDung: String = ""
    var stt: String = ""
    var tenVung: String = ""
    var khuVuc: String = ""
    var tenShop: String = ""
    var mtdGiaDungXiaomi: String = ""
    var phanTramHoanThanh: String = ""
    var flagToken: String = ""
    var cungKy: String = ""
    var phanTramHoanThanhDuKien: String = ""
    var realtimeGiaDungXiaomi: String = ""
    var realtimeGiaDung: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.mtdGiaDung <- map["MTD_GiaDung"]
        self.m1 <- map["M_1"]
        self.total <- map["Total"]
        self.targetGiaDung <- map["TargetGiaDung"]
        self.stt <- map["STT"]
        self.tenVung <- map["TenVung"]
        self.khuVuc <- map["ASM"]
        self.tenShop <- map["TenShop"]
        self.mtdGiaDungXiaomi <- map["MTD_GiaDungXiaomi"]
        self.phanTramHoanThanh <- map["PhanTramHoanThanh"]
        self.flagToken <- map["flagToken"]
        self.cungKy <- map["CungKy"]
        self.phanTramHoanThanhDuKien <- map["PhanTramHoanThanhDuKien"]
        self.realtimeGiaDung <- map["Realtime_GiaDung"]
        self.realtimeGiaDungXiaomi <- map["Realtime_GiaDungXiaomi"]
    }
}
