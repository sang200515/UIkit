//
//  FFriendsOrder.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 15/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class FFriendsOrder: Jsonable{
    required init?(json: JSON) {
        EST = json["EST"].string ?? "";
        MTD = json["MTD"].string ?? "";
        STT = json["STT"].string ?? "";
        Shop = json["Shop"].string ?? "";
        TG_FF_SoVoi_DSTong = json["TG_FF_SoVoi_DSTong"].string ?? "";
        TongCong = json["TongCong"].string ?? "";
        TraGop = json["TraGop"].string ?? "";
        TraThang = json["TraThang"].string ?? "";
    }
    
     var EST : String?;
     var MTD : String?;
     var STT : String?;
     var Shop : String?;
     var TG_FF_SoVoi_DSTong : String?;
     var TongCong : String?;
     var TraGop : String?;
     var TraThang : String?;
}
