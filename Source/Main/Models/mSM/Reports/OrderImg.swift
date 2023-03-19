//
//  OrderImg.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 15/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class OrderImg: Jsonable{
    required init?(json: JSON) {
        LyDoTuChoi = json["LyDoTuChoi"].string ?? "";
        MaCallLog = json["MaCallLog"].string ?? "";
        NgayHenHan = json["NgayHenHan"].string ?? "";
        SalesShop = json["SalesShop"].string ?? "";
        SoSOPOS = json["SoSOPOS"].string ?? "";
        TinhTrang = json["TinhTrang"].string ?? "";
    }
    
    var LyDoTuChoi: String?;
    var MaCallLog: String?;
    var NgayHenHan: String?;
    var SalesShop: String?;
    var SoSOPOS: String
    var TinhTrang: String
}
