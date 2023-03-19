//
//  TypeId_226_GetDetail.swift
//  fptshop
//
//  Created by DiemMy Le on 2/18/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.

import UIKit
import SwiftyJSON

class TypeId_226_GetDetail: Jsonable {

    required init(json: JSON) {
        Assigner = json["Assigner"].string ?? ""
        CurrentLimit = json["CurrentLimit"].string ?? ""
        NewLimit = json["NewLimit"].string ?? ""
        NoiDung = json["NoiDung"].string ?? ""
        Title = json["Title"].string ?? ""
        TimeCreate = json["TimeCreate"].string ?? ""
        Sender = json["Sender"].string ?? ""
        Sotienshopcanduyet = json["Sotienshopcanduyet"].string ?? ""
        Hanmucduocphepduyet = json["Hanmucduocphepduyet"].string ?? ""
    }

    var Assigner: String
    var CurrentLimit: String
    var NewLimit: String
    var NoiDung: String
    var Title: String
    var TimeCreate: String
    var Sender: String
    var Sotienshopcanduyet: String
    var Hanmucduocphepduyet: String
}

