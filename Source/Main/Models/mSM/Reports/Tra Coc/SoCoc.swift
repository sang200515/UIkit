//
//  SoCoc.swift
//  fptshop
//
//  Created by Apple on 4/22/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

//class SoCoc: Jsonable {
//
//    required init?(json: JSON) {
//
//        Vung = json["Vung"].string ?? "";
//        TenKhuvuc = json["TenKhuvuc"].string ?? "";
//        TenASM = json["TenASM"].string ?? "";
//        Shop = json["Shop"].string ?? "";
//        SLcocMTD = json["SLcocMTD"].int ?? 0;
//        Target = json["Target"].int ?? 0;
//        Phantram = json["Phantram"].double ?? 0.0;
//    }
//
//    var Vung: String
//    let TenKhuvuc: String
//    let TenASM: String
//    var Shop: String
//    var SLcocMTD: Int
//    let Target: Int
//    var Phantram: Double
//
//}

class SoCoc: NSObject {
    
    var Vung: String
    let TenKhuvuc: String
    let TenASM: String
    var Shop: String
    var SLcocMTD: Int
    let Target: Int
    var Phantram: Double
    
    
    init(Vung: String, TenKhuvuc: String, TenASM: String, Shop: String, SLcocMTD: Int, Target: Int, Phantram: Double){
        self.Vung = Vung
        self.TenKhuvuc = TenKhuvuc
        self.TenASM = TenASM
        self.Shop = Shop
        self.SLcocMTD = SLcocMTD
        self.Target = Target
        self.Phantram = Phantram
    }
    
    class func BuildArrayFromJSON(_ dataArray:[JSON]) -> [SoCoc]{
        var callLog:[SoCoc] = []
        for item in dataArray{
            callLog.append(self.BuildItemFromJSON(item))
        }
        return callLog
    }
    class func BuildItemFromJSON(_ data:JSON) -> SoCoc{
        
        var Vung = data["Vung"].string
        , TenKhuvuc = data["TenKhuvuc"].string
        , TenASM = data["TenASM"].string
        , Shop = data["Shop"].string
        , SLcocMTD = data["SLcocMTD"].int
        , Target = data["Target"].int
        , Phantram = data["Phantram"].double
        
        Vung = Vung == nil ? "" : Vung
        TenKhuvuc = TenKhuvuc == nil ? "" :TenKhuvuc
        TenASM = TenASM == nil ? "" : TenASM
        Shop = Shop == nil ? "" :Shop
        SLcocMTD = SLcocMTD == nil ? 0 : SLcocMTD
        Target = Target == nil ? 0 :Target
        Phantram = Phantram == nil ? 0.0 : Phantram
        
        
        return SoCoc(Vung: Vung!, TenKhuvuc: TenKhuvuc!, TenASM: TenASM!, Shop: Shop!, SLcocMTD: SLcocMTD!, Target: Target!, Phantram: Phantram!)
    }
    
}
