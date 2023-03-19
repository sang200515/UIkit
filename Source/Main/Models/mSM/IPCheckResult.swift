//
//  IPCheckResult.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 07/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class IPCheckingResult: Jsonable{
    var Result: String?;
    
    required init(json: JSON) {
        Result = json["KQ"].string ?? "";
    }
}
class IPCheckingResultV2: Jsonable{
    var Result: Int?;
    
    required init(json: JSON) {
        Result = json["KQ"].int ?? 0;
    }
}
