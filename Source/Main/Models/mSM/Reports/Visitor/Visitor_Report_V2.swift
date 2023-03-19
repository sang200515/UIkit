//
//  Visitor_Report_V2.swift
//  fptshop
//
//  Created by Apple on 7/31/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//--------------
//"Code": "00374",
//"Name": "Miền Bắc 2-KV0",
//"SLShop": 8,

//"Count_Visitor_Now": 64616,
//"TB_Visitor_Now": 8077,
//"Count_Visitor_LastMonth": 18975,
//"Count_Visitor_LastYear": null,
//"Count_Visitor_LastTenDay": null,

//"Count_SO_Now": 13330,
//"TB_Count_SO_Now": 1666,
//"Count_SO_LastMonth": 4000,
//"Count_SO_LastYear": null,
//"Count_SO_LastTenDay": null,

//"Count_ThuHo_Now": 17115,
//"TB_Count_ThuHo_Now": 2139,
//"Count_ThuHo_LastMonth": 5116,
//"Count_ThuHo_LastYear": null,
//"Count_ThuHo_LastTenDay": null,

//"TiLe_Now": 28,
//"TiLe_LastMonth": 29,
//"TiLe_LastYear": null,
//"TiLe_LastTenDay": null

import UIKit
import SwiftyJSON;

class Visitor_Report_V2: Jsonable {
    
    required init(json: JSON) {
        Code = json["Code"].string ?? "";
        Name = json["Name"].string ?? "";
        Count_Visitor_Now = json["Count_Visitor_Now"].int ?? 0;
        Count_Visitor_LastMonth = json["Count_Visitor_LastMonth"].int ?? 0;
        Count_Visitor_LastYear = json["Count_Visitor_LastYear"].int ?? 0;
        Count_Visitor_LastTenDay = json["Count_Visitor_LastTenDay"].int ?? 0;
        TB_Visitor_Now = json["TB_Visitor_Now"].int ?? 0;
        
        
        Count_SO_Now = json["Count_SO_Now"].int ?? 0;
        Count_SO_LastMonth = json["Count_SO_LastMonth"].int ?? 0;
        Count_SO_LastYear = json["Count_SO_LastYear"].int ?? 0;
        Count_SO_LastTenDay = json["Count_SO_LastTenDay"].int ?? 0;
        TB_Count_SO_Now = json["TB_Count_SO_Now"].int ?? 0;
        
        Count_ThuHo_Now = json["Count_ThuHo_Now"].int ?? 0;
        Count_ThuHo_LastMonth = json["Count_ThuHo_LastMonth"].int ?? 0;
        Count_ThuHo_LastYear = json["Count_ThuHo_LastYear"].int ?? 0;
        Count_ThuHo_LastTenDay = json["Count_ThuHo_LastTenDay"].int ?? 0;
        TB_Count_ThuHo_Now = json["TB_Count_ThuHo_Now"].int ?? 0;
        
        TiLe_Now = json["TiLe_Now"].int ?? 0;
        TiLe_LastMonth = json["TiLe_LastMonth"].int ?? 0;
        TiLe_LastYear = json["TiLe_LastYear"].int ?? 0;
        TiLe_LastTenDay = json["TiLe_LastTenDay"].int ?? 0;
    }

    var Code: String?;
    var Name: String?;
    var Count_Visitor_Now: Int?;
    var Count_Visitor_LastMonth: Int?;
    var Count_Visitor_LastYear: Int?;
    var Count_Visitor_LastTenDay: Int?;
    var TB_Visitor_Now: Int?;
    
    var Count_SO_Now: Int?;
    var Count_SO_LastMonth: Int?;
    var Count_SO_LastYear: Int?;
    var Count_SO_LastTenDay: Int?;
    var TB_Count_SO_Now: Int?;
    
    var Count_ThuHo_Now: Int?;
    var Count_ThuHo_LastMonth: Int?;
    var Count_ThuHo_LastYear: Int?;
    var Count_ThuHo_LastTenDay: Int?;
    var TB_Count_ThuHo_Now: Int?;
    
    var TiLe_Now: Int?;
    var TiLe_LastMonth: Int?;
    var TiLe_LastYear: Int?;
    var TiLe_LastTenDay: Int?;
}
