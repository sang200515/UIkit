//
//  ShopByASM.swift
//  fptshop
//
//  Created by Apple on 8/8/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"MaShop": null,
//"TenShop": null,

import UIKit
import SwiftyJSON;

class ShopByASM: Jsonable {
    
    required init(json: JSON) {
        MaShop = json["MaShop"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        
    }
    var MaShop: String?;
    var TenShop: String?;

}

