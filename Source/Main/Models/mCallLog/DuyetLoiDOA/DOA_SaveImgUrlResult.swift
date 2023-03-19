//
//  DOA_SaveImgUrlResult.swift
//  fptshop
//
//  Created by Apple on 7/19/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"Note": "Loại CL Không hợp lệ!",
//"Result": 0

import UIKit
import SwiftyJSON

class DOA_SaveImgUrlResult: Jsonable {
    
    required init(json: JSON) {
        Result = json["Result"].int ?? 0
        Note = json["Note"].string ?? ""
    }

    var Result: Int?
    var Note: String?
}
