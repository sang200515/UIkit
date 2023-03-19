//
//  TypeId_226_DuyetHanMuc.swift
//  fptshop
//
//  Created by DiemMy Le on 2/18/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//StatusConfirm: 1-Duyệt ; 0-Không duyệt

import UIKit
import SwiftyJSON

class TypeId_226_DuyetHanMuc: Jsonable {

    required init(json: JSON) {
        Result = json["Result"].int ?? 0
        Message = json["Message"].string ?? ""
    }

    var Result: Int?
    var Message: String?
}
