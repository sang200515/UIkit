//
//  WeLoveRequest.swift
//  mCallLog_v2
//
//  Created by Trần Thành Phương Đăng on 20/09/18.
//  Copyright © 2018 vn.com.fptshop. All rights reserved.
//

import Foundation
import SwiftyJSON;

class WeLoveEvaluation: Jsonable{
    required init(json: JSON) {
        Id = json["Id"].int ?? 0;
        EvaluationName = json["Name"].string ?? "";
    }
    
    var Id: Int?;
    var EvaluationName: String?;
}
