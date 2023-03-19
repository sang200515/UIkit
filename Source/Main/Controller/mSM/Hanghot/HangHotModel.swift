//
//  HangHotModel.swift
//  fptshop
//
//  Created by Ngoc Bao on 29/09/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class HangHotRealtime : Mappable {
    var result : [HotResult] = []

    required init?(map: Map) {}
    func mapping(map: Map) {
        if map.JSON.description.contains("sp_FRT_MSM_TyleHTTargetHH_Realtime_Vung_ViewResult") {
            result <- map["sp_FRT_MSM_TyleHTTargetHH_Realtime_Vung_ViewResult"]
        } else if map.JSON.description.contains("sp_FRT_MSM_TyLeHTTargetHangHot_ASMResult") {
            result <- map["sp_FRT_MSM_TyLeHTTargetHangHot_ASMResult"]
        } else if map.JSON.description.contains("sp_FRT_MSM_TyLeHTTargetHangHot_VungResult") {
            result <- map["sp_FRT_MSM_TyLeHTTargetHangHot_VungResult"]
        } else if map.JSON.description.contains("sp_FRT_MSM_TyLeHTTargetHangHot_TheoShopResult") {
            result <- map["sp_FRT_MSM_TyLeHTTargetHangHot_TheoShopResult"]
        } else if map.JSON.description.contains("sp_FRT_MSM_TyleHTTargetHH_Realtime_Shop_ViewResult") {
            result <- map["sp_FRT_MSM_TyleHTTargetHH_Realtime_Shop_ViewResult"]
        } else if map.JSON.description.contains("sp_FRT_MSM_TyleHTTargetHH_Realtime_KhuVuc_ViewResult") {
            result <- map["sp_FRT_MSM_TyleHTTargetHH_Realtime_KhuVuc_ViewResult"]
        }
    }

}

 class HotResult : Mappable {
     var Sim_DS: String = ""
    var ASM: String = ""
    var baohanh_DS : String = ""
    var baohanh_SL : String = ""
    var chuot_DS : String = ""
    var chuot_SL : String = ""
    var mDMH_DS : String = ""
    var mDMH_SL : String = ""
    var phanTramHoanThanh : String = ""
    var phanmem_DS : String = ""
    var phanmem_SL : String = ""
    var sDP_DS : String = ""
    var sDP_SL : String = ""
    var sTT : String = ""
    var shop : String = ""
    var tOTAL_DS : String = ""
    var tOTAL_SL : String = ""
    var tainghe_DS : String = ""
    var tainghe_SL : String = ""
    var target_hanghot : String = ""
     var Vung : String = ""

     required init?(map: Map) {}

     func mapping(map: Map) {
         Sim_DS <- map["Sim_DS"]
         baohanh_DS <- map["Baohanh_DS"]
         baohanh_SL <- map["Baohanh_SL"]
         chuot_DS <- map["Chuot_DS"]
         chuot_SL <- map["Chuot_SL"]
         mDMH_DS <- map["MDMH_DS"]
         mDMH_SL <- map["MDMH_SL"]
         phanTramHoanThanh <- map["PhanTramHoanThanh"]
         phanmem_DS <- map["Phanmem_DS"]
         phanmem_SL <- map["Phanmem_SL"]
         sDP_DS <- map["SDP_DS"]
         sDP_SL <- map["SDP_SL"]
         sTT <- map["STT"]
         tOTAL_DS <- map["TOTAL_DS"]
         tOTAL_SL <- map["TOTAL_SL"]
         tainghe_DS <- map["Tainghe_DS"]
         tainghe_SL <- map["Tainghe_SL"]
         target_hanghot <- map["Target_hanghot"]
         shop <- map["Shop"]
         Vung <- map["Vung"]
         ASM <- map["ASM"]
     }

}
