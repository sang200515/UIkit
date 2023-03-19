//
//  TLPerMonth.swift
//  fptshop
//
//  Created by Apple on 3/19/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class TLPerMonth: Jsonable {
    
//    var ThangNam: String
//    var TiLeDuyetTreHan: String
//
//    init(ThangNam: String, TiLeDuyetTreHan: String) {
//        self.ThangNam = ThangNam
//        self.TiLeDuyetTreHan = TiLeDuyetTreHan
//    }
//
//    class func BuildItemFromJSON(data:JSON) -> TLPerMonth{
//        var ThangNam = data["ThangNam"].string
//        var TiLeDuyetTreHan = data["TiLeDuyetTreHan"].string
//
//        ThangNam = ThangNam == nil ? "" : ThangNam
//        TiLeDuyetTreHan = TiLeDuyetTreHan == nil ? "" : TiLeDuyetTreHan
//
//        return TLPerMonth(ThangNam: ThangNam!, TiLeDuyetTreHan: TiLeDuyetTreHan!)
//    }
//
//    class func parseObjfromArray(array: [JSON])->[TLPerMonth]{
//        var list:[TLPerMonth] = []
//        for item in array {
//            list.append(self.BuildItemFromJSON(data: item))
//        }
//        return list
//    }
    
    required init?(json: JSON) {
        
        ThangNam = json["ThangNam"].string ?? "";
        TiLeDuyetTreHan = json["TiLeDuyetTreHan"].string ?? "";
    }
    
    
    var ThangNam: String?
    var TiLeDuyetTreHan: String?

}
