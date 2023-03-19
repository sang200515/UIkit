//
//  DoanhNghiep.swift
//  fptshop
//
//  Created by Apple on 3/19/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class DoanhNghiep: Jsonable {
//    var MaDN: Int
//    var TenDN: String
//
//    init(MaDN: Int, TenDN: String) {
//        self.MaDN = MaDN
//        self.TenDN = TenDN
//    }
//
//    class func BuildItemFromJSON(data:JSON) -> DoanhNghiep{
//        var MaDN = data["MaDN"].int
//        var TenDN = data["TenDN"].string
//
//        MaDN = MaDN == nil ? 0 : MaDN
//        TenDN = TenDN == nil ? "" : TenDN
//
//        return DoanhNghiep(MaDN: MaDN!, TenDN: TenDN!)
//    }
//
//    class func parseObjfromArray(array:[JSON])->[DoanhNghiep]{
//        var list:[DoanhNghiep] = []
//        for item in array {
//            list.append(self.BuildItemFromJSON(data: item))
//        }
//        return list
//    }
    
    required init?(json: JSON) {
        MaDN = json["MaDN"].int ?? 0;
        TenDN = json["TenDN"].string ?? "";
    }
    
    
    var MaDN: Int?;
    var TenDN: String?;
}
