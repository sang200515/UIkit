//
//  CheckinResult.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 08/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class CheckinResult: Jsonable{
    required init?(json: JSON) {
        self.Result = json["KQ"].bool ?? false;
    }
    
    var Result: Bool?
}
