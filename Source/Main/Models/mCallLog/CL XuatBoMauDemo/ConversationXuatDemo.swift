//
//  ConversationXuatDemo.swift
//  fptshop
//
//  Created by Apple on 5/28/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"MaYeuCau": 5323008,
//"NguoiTao": "Trương Hoàng An",
//"NoiDung": "Trương Hoàng An-PSM-27/05/19: gghgy",
//"STT": 1,
//"ThoiGianTao": "/Date(1558955008620+0700)/"

import UIKit
import SwiftyJSON

class ConversationXuatDemo: Jsonable {

    required init(json: JSON) {
        
        MaYeuCau = json["MaYeuCau"].int ?? 0
        NguoiTao = json["NguoiTao"].string ?? ""
        NoiDung = json["NoiDung"].string ?? ""
        STT = json["STT"].int ?? 0
        ThoiGianTao = json["ThoiGianTao"].string ?? ""
        
    }
    
    var MaYeuCau: Int?
    var NguoiTao: String?
    var NoiDung: String?
    var STT: Int?
    var ThoiGianTao:String?
}
