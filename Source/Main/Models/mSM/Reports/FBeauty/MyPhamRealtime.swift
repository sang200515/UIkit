//
//  MyPhamRealtime.swift
//  fptshop
//
//  Created by DiemMy Le on 12/13/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"DS_CS_CoThe": 0,
//"DS_CS_Da": 1712757,
//"DS_CS_Toc": 170182,
//"DS_Khac": 710943,
//"DS_NuocHoa": 0,
//"DS_Tong": 3787745,
//"DS_TrangDiem": 1193863,
//"SL_SO": 50,
//"STT": "1",
//"TenShop": "FBT 212-214 Nguyễn Trãi",
//"TrungBinhBill": 75755,

import UIKit
import SwiftyJSON

class MyPhamRealtime: Jsonable {

    required init(json: JSON) {
        DS_CS_CoThe = json["DS_CS_CoThe"].double ?? 0.0;
        DS_CS_Da = json["DS_CS_Da"].double ?? 0.0;
        DS_CS_Toc = json["DS_CS_Toc"].double ?? 0.0;
        DS_Khac = json["DS_Khac"].double ?? 0.0;
        DS_NuocHoa = json["DS_NuocHoa"].double ?? 0.0;
        DS_Tong = json["DS_Tong"].double ?? 0.0;
        DS_TrangDiem = json["DS_TrangDiem"].double ?? 0.0;
        STT = json["STT"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        TrungBinhBill = json["TrungBinhBill"].double ?? 0.0;
        SL_SO = json["SL_SO"].double ?? 0.0;
    }
    
    var DS_CS_CoThe: Double?;
    var DS_CS_Da: Double?;
    var DS_CS_Toc: Double?;
    var DS_Khac: Double?;
    var DS_NuocHoa: Double?;
    var DS_Tong: Double?;
    var DS_TrangDiem: Double?;
    var STT: String?;
    var TenShop: String?;
    var TrungBinhBill: Double?;
    var SL_SO: Double?;
}
