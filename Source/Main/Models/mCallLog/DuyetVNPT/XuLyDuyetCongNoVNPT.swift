//
//  XuLyDuyetCongNoVNPT.swift
//  fptshop
//
//  Created by DiemMy Le on 12/13/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class XuLyDuyetCongNoVNPT: Jsonable {

    required init(json: JSON) {
        Result = json["Result"].int ?? 0
        Msg = json["Msg"].string ?? ""
    }

    var Result: Int?
    var Msg: String?
}

