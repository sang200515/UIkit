//
//  ShopASM_insertResult.swift
//  fptshop
//
//  Created by Apple on 8/8/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"flagToken": null,
//"p_messagess": "Lưu thành công. Vui lòng vào lịch sử kiểm tra lại!",
//"p_status": 1

import UIKit
import SwiftyJSON;

class ShopASM_insertResult: Jsonable {

    required init(json: JSON) {
        p_messagess = json["p_messagess"].string ?? ""
        p_status = json["p_status"].int ?? 0
    }
    
    var p_messagess: String?;
    var p_status: Int?;
}
