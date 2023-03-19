//
//  BillLoadCC.swift
//  fptshop
//
//  Created by Apple on 5/6/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"Code": "0051",
//"Name": "0051 - Bùi Thị Kim Anh",
//"Type": "Employee"

import Foundation
import SwiftyJSON

class BillLoadCC: Jsonable {

    required init(json: JSON) {
        Code = json["Code"].string ?? "";
        Name = json["Name"].string ?? "";
        mType = json["Type"].string ?? "";
        
    }
    
    var Code: String?
    var Name: String?
    var mType: String?
}
