//
//  WeLoveRequest.swift
//  mCallLog_v2
//
//  Created by Trần Thành Phương Đăng on 20/09/18.
//  Copyright © 2018 vn.com.fptshop. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class WeLovePostRequestResult: Jsonable {
    required init(json: JSON) {
        Message = json["Msg"].string ?? "";
        RequestId = json["RequestId"].int ?? 0;
        Result = json["Result"].string ?? "";
    }
    
    var Message: String?;
    var RequestId: Int?;
    var Result: String?;
}
