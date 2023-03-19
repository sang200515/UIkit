//
//  Saleman.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 28/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class Saleman: Jsonable{
    required init?(json: JSON) {
        DS_Apple = json["DS_Apple"].double ?? 0.0
        DS_DichVu = json["DS_DichVu"].double ?? 0.0
        DS_MT = json["DS_MT"].double ?? 0.0
        DS_MTB = json["DS_MTB"].double ?? 0.0
        DS_MayCu = json["DS_MayCu"].double ?? 0.0
        DS_Mobile = json["DS_Mobile"].double ?? 0.0
        DS_PhuKien = json["DS_PhuKien"].double ?? 0.0
        DS_Total = json["DS_Total"].double ?? 0.0
        SL_Apple = json["SL_Apple"].int ?? 0;
        SL_DichVu = json["SL_DichVu"].int ?? 0;
        SL_MT = json["SL_MT"].int ?? 0;
        SL_MTB = json["SL_MTB"].int ?? 0;
        SL_MayCu = json["SL_MayCu"].int ?? 0;
        SL_Mobile = json["SL_Mobile"].int ?? 0;
        SL_Total = json["SL_Total"].int ?? 0;
        STT = json["STT"].string ?? "";
        ShopCode = json["ShopCode"].string ?? "";
        Ten_NVBH = json["Ten_NVBH"].string ?? "";
        TiTrong_DS = json["TiTrong_DS"].float ?? 0.0;
    }
    
    var DS_Apple: Double?;
    var DS_DichVu: Double?;
    var DS_MT: Double?;
    var DS_MTB: Double?;
    var DS_MayCu: Double?;
    var DS_Mobile: Double?;
    var DS_PhuKien: Double?;
    var DS_Total: Double?;
    var SL_Apple: Int?;
    var SL_DichVu: Int?;
    var SL_MT: Int?;
    var SL_MTB: Int?;
    var SL_MayCu: Int?;
    var SL_Mobile: Int?;
    var SL_Total: Int?;
    var STT: String?;
    var ShopCode: String?;
    var Ten_NVBH: String?;
    var TiTrong_DS: Float?;
}
