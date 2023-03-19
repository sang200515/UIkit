//
//  Shop.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 15/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class Shop: Jsonable{
    required init?(json: JSON) {
        Address = json["Address"].string ?? "";
        ID = json["ID"].int ?? 0;
        IPMax = json["IPMax"].int ?? 0;
        IPMin = json["IPMin"].int ?? 0;
        IPPublic = json["IPPublic"].string ?? "";
        IPRange = json["IPRange"].string ?? "";
        ShopCode = json["ShopCode"].string ?? "";
        ShopCode = json["MaShop"].string ?? "";
        ShopName = json["ShopName"].string ?? "";
        ShopName = json["TenShop"].string ?? "";
    }
    
    var Address: String?;
    var ID: Int?;
    var IPMax: Int?;
    var IPMin: Int?;
    var IPPublic: String?;
    var IPRange: String?;
    var ShopCode: String?;
    var ShopName: String?;
}
