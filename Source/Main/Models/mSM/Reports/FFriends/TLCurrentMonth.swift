//
//  TLCurrentMonth.swift
//  fptshop
//
//  Created by Apple on 3/19/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class TLCurrentMonth: Jsonable {
    
//    var TenDN: String
//    var TiLeDuyetTreHan: String
//    var TongCLPhatSinh: Int
//
//    init(TenDN: String, TiLeDuyetTreHan: String, TongCLPhatSinh: Int) {
//        self.TenDN = TenDN
//        self.TiLeDuyetTreHan = TiLeDuyetTreHan
//        self.TongCLPhatSinh = TongCLPhatSinh
//    }
//
//    class func BuildItemFromJSON(data:JSON) -> TLCurrentMonth{
//
//        var TenDN = data["TenDN"].string
//        var TiLeDuyetTreHan = data["TiLeDuyetTreHan"].string
//        var TongCLPhatSinh = data["TongCLPhatSinh"].int
//
//
//        TenDN = TenDN == nil ? "" : TenDN
//        TiLeDuyetTreHan = TiLeDuyetTreHan == nil ? "" : TiLeDuyetTreHan
//        TongCLPhatSinh = TongCLPhatSinh == nil ? 0 : TongCLPhatSinh
//
//        return TLCurrentMonth(TenDN: TenDN!, TiLeDuyetTreHan: TiLeDuyetTreHan!, TongCLPhatSinh: TongCLPhatSinh!)
//    }
//
//    class func parseObjfromArray(array:[JSON])->[TLCurrentMonth]{
//        var list:[TLCurrentMonth] = []
//        for item in array {
//            list.append(self.BuildItemFromJSON(data: item))
//        }
//        return list
//    }
    
    required init?(json: JSON) {
        
        TenDN = json["TenDN"].string ?? "";
        TiLeDuyetTreHan = json["TiLeDuyetTreHan"].string ?? "";
        TongCLPhatSinh = json["TongCLPhatSinh"].int ?? 0;
    }
    
    
    var TenDN: String?
    var TiLeDuyetTreHan: String?
    var TongCLPhatSinh: Int?

}
