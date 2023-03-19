//
//  BaohanhVangModel.swift
//  fptshop
//
//  Created by Ngoc Bao on 10/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class BaoHanhVang : Mappable {
    var result : [GoldItem] = []

    required init?(map: Map) {}
    func mapping(map: Map) {
        if map.JSON.description.contains("sp_FRT_MSM_BaoHanhVang_KhuVucResult") {
            result <- map["sp_FRT_MSM_BaoHanhVang_KhuVucResult"]
        } else if map.JSON.description.contains("sp_FRT_MSM_BaoHanhVang_VungResult") {
            result <- map["sp_FRT_MSM_BaoHanhVang_VungResult"]
        } else if map.JSON.description.contains("sp_FRT_MSM_BaoHanhVang_ShopResult") {
            result <- map["sp_FRT_MSM_BaoHanhVang_ShopResult"]
        }
    }

}

 class GoldItem : Mappable {
     var BHMR_Realtime: String = ""
     var BHV_Realtime: String = ""
     var DTLuyKe: String = ""
     var DTRealtime: String = ""
     var KhuVuc: String = ""
     var LuyKe: String = ""
     var SLMayLuyKe: String = ""
     var SLMayRealtime: String = ""
     var STT: String = ""
     var TrungBinhBillNgay: String = ""
     var TyLe: String = ""
     var ASM: String = ""
     var Vung: String = ""
     var WarehouseName: String = ""
	 var SLM_15M: String = ""
	 var SLBHMay_15M: String = ""
	 var DTBHMay_15M: String = ""
	 var TiLeBHMay_15M: String = ""
     required init?(map: Map) {}

     func mapping(map: Map) {

         BHMR_Realtime <- map["BHMR_Realtime"]
         BHV_Realtime <- map["BHV_Realtime"]
         DTLuyKe <- map["DTLuyKe"]
         DTRealtime <- map["DTRealtime"]
         KhuVuc <- map["KhuVuc"]
         LuyKe <- map["LuyKe"]
         SLMayLuyKe <- map["SLMayLuyKe"]
         SLMayRealtime <- map["SLMayRealtime"]
         STT <- map["STT"]
         TrungBinhBillNgay <- map["TrungBinhBillNgay"]
         TyLe <- map["TyLe"]
         ASM <- map["ASM"]
         Vung <- map["Vung"]
         WarehouseName <- map["WarehouseName"]
		 SLM_15M <- map["SLM_15M"]
		 SLBHMay_15M <- map["SLBHMay_15M"]
		 DTBHMay_15M <- map["DTBHMay_15M"]
		 TiLeBHMay_15M <- map["TiLeBHMay_15M"]
     }

}
// ==== bao hiem xe
class BaoHiemXeMay : Mappable {
    var result : [MotorItem] = []

    required init?(map: Map) {}
    func mapping(map: Map) {
        if map.JSON.description.contains("sp_FRT_MSM_BaoHiemXe_VungResult") {
            result <- map["sp_FRT_MSM_BaoHiemXe_VungResult"]
        } else if map.JSON.description.contains("sp_FRT_MSM_BaoHiemXe_KhuVucResult") {
            result <- map["sp_FRT_MSM_BaoHiemXe_KhuVucResult"]
        } else if map.JSON.description.contains("sp_FRT_MSM_BaoHiemXe_ShopResult") {
            result <- map["sp_FRT_MSM_BaoHiemXe_ShopResult"]
        }
    }

}

class MotorItem : Mappable {
    var luyKe : String = ""
    var realtime : String = ""
    var sTT : String = ""
    var thuho_BaoHanh : String = ""
    var tile : String = ""
    var vung : String = ""
    var khuvuc : String = ""
    var aSM : String = ""
    var shop : String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        luyKe <- map["LuyKe"]
        realtime <- map["Realtime"]
        sTT <- map["STT"]
        thuho_BaoHanh <- map["Thuho_BaoHanh"]
        tile <- map["Tile"]
        vung <- map["Vung"]
        khuvuc <- map["Khuvuc"]
        aSM <- map["ASM"]
        shop <- map["Shop"]
    }

}
