//
//  Traffic.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class Traffic: Jsonable{
    required init?(json: JSON) {
        STT = json["STT"].int ?? 0;
        Name = json["Name"].string ?? "";
        Rate_D = json["Rate_D"].float ?? 0.0;
        Rate_Medium = json["Rate_Medium"].float ?? 0.0;
        Traffic_D = json["Traffic_D"].int ?? 0;
        Traffic_D_Minus_1 = json["Traffic_D_Minus_1"].int ?? 0;
        ShopCounting = json["ShopCounting"].int ?? 0;
        Date_D = json["Date_D"].string ?? "";
        Rate_SO_Traffic = json["Rate_SO_Traffic"].float ?? 0.0;
        SO = json["SO"].int ?? 0;
    }
    
    var STT: Int?;
    var Name: String?;
    var Rate_D: Float?;
    var Rate_Medium: Float?;
    var Traffic_D: Int?;
    var Traffic_D_Minus_1: Int?;
    var ShopCounting: Int?;
    var Date_D: String?;
    var Rate_SO_Traffic: Float?;
    var SO: Int?;
}
