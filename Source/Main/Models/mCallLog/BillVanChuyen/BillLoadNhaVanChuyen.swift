//
//  BillLoadNhaVanChuyen.swift
//  fptshop
//
//  Created by Apple on 5/6/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"CuocPhiMin": "88000",
//"MaNVC": "Kerry",
//"STT": 2,
//"TenDichVu": "Hỏa tốc",
//"TenNVC": "Kerry"

import Foundation
import SwiftyJSON

class BillLoadNhaVanChuyen: Jsonable {
    
    required init(json: JSON) {
        CuocPhiMin = json["CuocPhiMin"].string ?? "";
        MaNVC = json["MaNVC"].string ?? "";
        STT = json["STT"].int ?? 0;
        TenDichVu = json["TenDichVu"].string ?? "";
        TenNVC = json["TenNVC"].string ?? "";
    }
    
    var CuocPhiMin: String?
    var MaNVC: String?
    var STT: Int?
    var TenDichVu: String?
    var TenNVC: String?
}
