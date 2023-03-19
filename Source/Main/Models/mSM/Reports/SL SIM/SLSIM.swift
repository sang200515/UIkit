//
//  SLSIM.swift
//  fptshop
//
//  Created by Apple on 4/9/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
import UIKit
import SwiftyJSON

class SLSIM: Jsonable {

    required init?(json: JSON) {
        STT = json["STT"].string ?? "";
        SoLuong_DienThoai = json["SoLuong_DienThoai"].int ?? 0;
        SoLuong_SIM = json["SoLuong_SIM"].int ?? 0;
        TyLe = json["TyLe"].string ?? "";
        Vung = json["Vung"].string ?? "";
        ASM = json["ASM"].string ?? "";
        KhuVuc = json["KhuVuc"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        TenASM = json["TenASM"].string ?? "";
        SLSIM_Mobifone = json["SLSIM_Mobifone"].int ?? 0;
        SLSIM_ESIM_Mobifone = json["SLSIM_ESIM_Mobifone"].intValue
        SLSIM_Vietnamobile = json["SLSIM_Vietnamobile"].int ?? 0;
        SLSIM_Viettel = json["SLSIM_Viettel"].int ?? 0;
        SLSIM_Vinaphone = json["SLSIM_Vinaphone"].int ?? 0;
        TyLeCungKy = json["TyLeCungKy"].stringValue
        TenVung = json["TenVung"].string ?? "";
        SLSIM_ITel = json["SLSIM_ITel"].int ?? 0;
        TyLe_VTL = json["TyLe_VTL"].string ?? "";
        TyLe_ITEL = json["TyLe_ITEL"].string ?? "";
        TyLe_MBF = json["TyLe_MBF"].string ?? "";
        TyLe_VNM = json["TyLe_VNM"].string ?? "";
        TyLe_Vina = json["TyLe_Vina"].string ?? ""
        TyLe_Vtel = json["TyLe_Vtel"].string ?? ""
        TyLe_ESIM_MBF = json["TyLeEsimIphone"].stringValue
        TyLe_ESIM_MBF_RT = json["TyLe_ESIM_MBF"].stringValue
        SL_ESIM_Mobifone = json["SL_ESIM_Mobifone"].intValue
        SLMay_Iphone = json["SLMay_Iphone"].intValue
    }
    
    
    var STT: String
    var SoLuong_DienThoai: Int
    var SoLuong_SIM: Int
    var TyLe: String
    var Vung: String
    var ASM: String
    var KhuVuc: String
    var TenShop: String
    var TenASM: String
    var SLSIM_Mobifone: Int
    var SLSIM_ESIM_Mobifone: Int
    var SLSIM_Vietnamobile: Int
    var SLSIM_Viettel: Int
    var SLSIM_Vinaphone: Int
    var TyLeCungKy: String
    var TenVung: String
    var SLSIM_ITel: Int
    var TyLe_VTL: String
    var TyLe_ITEL: String
    var TyLe_MBF: String
    var TyLe_VNM: String
    var TyLe_Vina: String
    var TyLe_Vtel: String
    var TyLe_ESIM_MBF: String
    var TyLe_ESIM_MBF_RT: String
    var SL_ESIM_Mobifone: Int
    var SLMay_Iphone: Int
}
