//
//  CheckinResultV2.swift
//  fptshop
//
//  Created by Apple on 1/3/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON;

class CheckinResultV2: Jsonable {
    var Result: Bool?;
    
    required init?(json: JSON) {
        self.Result = json["KQ"].bool ?? false;
    }
}
