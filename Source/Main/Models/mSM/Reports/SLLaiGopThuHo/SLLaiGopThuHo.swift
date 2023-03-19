//
//  SLLaiGopThuHo.swift
//  fptshop
//
//  Created by Apple on 5/17/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//let Vung: String
//let ASM: String
//let KhuVuc: String
//let TenShop: String
//let LaiGop_ChietKhau: String
//let SL_NapRut: Int
//let SL_NhanChuyen: Int
//let SL_ThuHoCoBan: Int
//let SL_Tong: Int
//let STT: String

import UIKit
import SwiftyJSON

class SLLaiGopThuHo: Jsonable {

    required init?(json: JSON) {
        
        Vung = json["Vung"].string ?? "";
        ASM = json["ASM"].string ?? "";
        KhuVuc = json["KhuVuc"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        LaiGop_ChietKhau = json["LaiGop_ChietKhau"].string ?? "";
        SL_NapRut = json["SL_NapRut"].int ?? 0;
        SL_NhanChuyen = json["SL_NhanChuyen"].int ?? 0;
        SL_ThuHoCoBan = json["SL_ThuHoCoBan"].int ?? 0;
        SL_Tong = json["SL_Tong"].int ?? 0;
        STT = json["STT"].string ?? "";
    }
    
    
    var Vung: String
    var ASM: String
    var KhuVuc: String
    var TenShop: String
    var LaiGop_ChietKhau: String
    var SL_NapRut: Int
    var SL_NhanChuyen: Int
    var SL_ThuHoCoBan: Int
    var SL_Tong: Int
    var STT: String
}
