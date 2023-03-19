//
//  ImageUploadResult.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 20/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class ImageUploadResult: Jsonable {
    required init?(json: JSON) {
        Result = json["Result"].int ?? 0;
        Message = json["Msg"].string ?? "";
        FilePath = json["FilePath"].string ?? "";
    }
    
    var Result: Int?;
    var Message: String?;
    var FilePath: String?;
}
