//
//  WeLovePermission.swift
//  mCallLog_v2
//
//  Created by Trần Thành Phương Đăng on 20/09/18.
//  Copyright © 2018 vn.com.fptshop. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class WeLovePermission: Jsonable{
    required init(json: JSON) {
        Message = json["Msg"].string ?? "";
        Result = json["Result"].int ?? -1;
    }
    
    var Message: String?
    var Result: Int?
}
