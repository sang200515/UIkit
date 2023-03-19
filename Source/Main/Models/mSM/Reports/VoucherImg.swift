//
//  VoucherImg.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 15/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class VoucherImg: Jsonable{
    required init?(json: JSON) {
        SDT = json["SDT"].string ?? "";
        CallLog = json["CallLog"].string ?? "";
        NgayHetHan = json["NgayHetHan"].string ?? "";
        SalesShop = json["SalesShop"].string ?? "";
        KH = json["KH"].string ?? "";
        TinhTrang = json["TinhTrang"].string ?? "";
    }
    
    var CallLog: String?;
    var KH: String?;
    var NgayHetHan: String?;
    var SDT: String?;
    var SalesShop: String?;
    var TinhTrang: String?;
}
