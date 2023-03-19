//
//  CallogPending.swift
//  fptshop
//
//  Created by Apple on 3/19/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class CallogPending: Jsonable {
    
//    var TenDN: String
//    var SL_CLDaTreHan: Int
//    var SL_CLSapTreHan: Int
//    var p_Type: Int
    
//    init(TenDN: String, SL_CLDaTreHan: Int, SL_CLSapTreHan: Int, p_Type: Int) {
//        self.TenDN = TenDN
//        self.SL_CLDaTreHan = SL_CLDaTreHan
//        self.SL_CLSapTreHan = SL_CLSapTreHan
//        self.p_Type = p_Type
//    }
//
//    class func BuildItemFromJSON(data:JSON) -> CallogPending{
//
//        var TenDN = data["TenDN"].string
//        var SL_CLDaTreHan = data["SL_CLDaTreHan"].int
//        var SL_CLSapTreHan = data["SL_CLSapTreHan"].int
//        var p_Type = data["p_Type"].int
//
//
//        TenDN = TenDN == nil ? "" : TenDN
//        SL_CLDaTreHan = SL_CLDaTreHan == nil ? 0 : SL_CLDaTreHan
//        SL_CLSapTreHan = SL_CLSapTreHan == nil ? 0 : SL_CLSapTreHan
//        p_Type = p_Type == nil ? 0 : p_Type
//
//        return CallogPending(TenDN: TenDN!, SL_CLDaTreHan: SL_CLDaTreHan!, SL_CLSapTreHan: SL_CLSapTreHan!, p_Type: p_Type!)
//    }
//
//    class func parseObjfromArray(array: [JSON])->[CallogPending]{
//        var list:[CallogPending] = []
//        for item in array {
//            list.append(self.BuildItemFromJSON(data: item))
//        }
//        return list
//    }
    
    required init?(json: JSON) {
        
        TenDN = json["TenDN"].string ?? "";
        SL_CLDaTreHan = json["SL_CLDaTreHan"].int ?? 0;
        SL_CLSapTreHan = json["SL_CLSapTreHan"].int ?? 0;
        p_Type = json["p_Type"].int ?? 0;
    }
    
    
    var TenDN: String?
    var SL_CLDaTreHan: Int?
    var SL_CLSapTreHan: Int?
    var p_Type: Int?

}
