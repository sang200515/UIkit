//
//  VisitorReport.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 7/29/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"Fillter": "",
//"Code": "00205",
//"Name": "Miền Đông Nam Bộ",
//"Visitor": 449172,
//"SO": 47547,
//"ThuHo": 147843,
//"Visitor_Tru_ThuHo": 301329,
//"TiLeSO_ThanhCong": 16,
//"Visitor_LastMonth": 0,
//"SO_LastMonth": 0,
//"ThuHo_LastMonth": 0,
//"Visitor_Tru_ThuHo_LastMonth": 0,
//"TiLeSO_ThanhCong_LastMonth": 0

import Foundation
import SwiftyJSON;

class VisitorReport: Jsonable{
    required init(json: JSON) {
        Fillter = json["Fillter"].string ?? "";
        Code = json["Code"].string ?? "";
        Name = json["Name"].string ?? "";
        Visitor = json["Visitor"].int ?? 0;
        SO = json["SO"].int ?? 0;
        ThuHo = json["ThuHo"].int ?? 0;
        Visitor_Tru_ThuHo = json["Visitor_Tru_ThuHo"].int ?? 0;
        TiLeSO_ThanhCong = json["TiLeSO_ThanhCong"].int ?? 0;
        Visitor_LastMonth = json["Visitor_LastMonth"].int ?? 0;
        SO_LastMonth = json["SO_LastMonth"].int ?? 0;
        ThuHo_LastMonth = json["ThuHo_LastMonth"].int ?? 0;
        Visitor_Tru_ThuHo_LastMonth = json["Visitor_Tru_ThuHo_LastMonth"].int ?? 0;
        TiLeSO_ThanhCong_LastMonth = json["TiLeSO_ThanhCong_LastMonth"].int ?? 0;
    }
    var Fillter: String?;
    var Code: String?;
    var Name: String?;
    var Visitor: Int?;
    var SO: Int?;
    var ThuHo: Int?;
    var Visitor_Tru_ThuHo: Int?;
    var TiLeSO_ThanhCong: Int?;
    var Visitor_LastMonth: Int?;
    var SO_LastMonth: Int?;
    var ThuHo_LastMonth: Int?;
    var Visitor_Tru_ThuHo_LastMonth: Int?;
    var TiLeSO_ThanhCong_LastMonth: Int?;
}
