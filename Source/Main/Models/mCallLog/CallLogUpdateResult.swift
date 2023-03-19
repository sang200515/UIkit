//
//  CallLogUpdateResult.swift
//  mCallLog_v2
//
//  Created by Trần Thành Phương Đăng on 27/09/18.
//  Copyright © 2018 vn.com.fptshop. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class CallLogUpdateResult: Jsonable{
    required init(json: JSON) {
        Message = json["Msg"].string ?? "";
        StatusCode = json["Result"].int ?? 0;
    }
    
    var Message: String?;
    var StatusCode: Int?;
}
