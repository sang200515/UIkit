//
//  CheckoutResult.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 15/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class CheckoutResult: Jsonable{
    required init?(json: JSON) {
        ApproveOutDateTime = json["ApproveOutDateTime"].string ?? "";
        CheckDate = json["CheckDate"].string ?? "";
        CheckinDate = json["CheckInDate"].string ?? "";
        CheckoutDate = json["CheckOutDate"].string ?? "";
        ID = json["ID"].int ?? 0;
        UserID = json["UserID"].int ?? 0;
    }
    
    var ApproveOutDateTime: String?;
    var CheckDate: String?;
    var CheckinDate: String?;
    var CheckoutDate: String?;
    var ID: Int?;
    var UserID: Int?;
}
