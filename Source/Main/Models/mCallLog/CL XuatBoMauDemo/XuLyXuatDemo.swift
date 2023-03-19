//
//  XuLyXuatDemo.swift
//  fptshop
//
//  Created by Apple on 5/28/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
///"Msg": "Yêu cầu đã được hoàn tất. Không thể thao tác!",
//"Result": 0,
//"SoYCDC": 0

import UIKit
import SwiftyJSON

class XuLyXuatDemo: Jsonable {

    required init(json: JSON) {
        
        Msg = json["Msg"].string ?? ""
        Result = json["Result"].int ?? 0
        SoYCDC = json["SoYCDC"].int ?? 0
        
    }
    
    var Msg: String?
    var Result: Int?
    var SoYCDC: Int?
}
