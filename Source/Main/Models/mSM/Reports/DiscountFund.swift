//
//  DiscountFund.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 15/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class DiscountFund:  Jsonable{
    required init?(json: JSON) {
        ConLai = json["ConLai"].double ?? 0.0;
        MaShop =  json["MaShop"].string ?? "";
        QuyGG =  json["QuyGG"].double ?? 0.0;
        QuyGG_TTLP =  json["QuyGG_TTLP"].double ?? 0.0;
        STT = json["STT"].int ?? 0;
        SoTien =  json["SoTien"].double ?? 0.0;
        TenShop = json["TenShop"].string ?? "";
    }
    
    var ConLai: Double?;
    var MaShop: String?;
    var QuyGG: Double?;
    var QuyGG_TTLP: Double?;
    var STT: Int?;
    var SoTien: Double?;
    var TenShop: String?;
}


class DisCountFundNew: NSObject {
    
    
    var ConLai: Double
    var MaShop: String
    var QuyGG: Double
    var QuyGG_TTLP: Double
    var STT: Int
    var SoTien: Double
    var TenShop: String
    
    
     init(ConLai: Double, MaShop: String, QuyGG: Double, QuyGG_TTLP: Double, STT: Int, SoTien: Double, TenShop: String) {
        self.ConLai = ConLai
        self.MaShop = MaShop
        self.QuyGG = QuyGG
        self.QuyGG_TTLP = QuyGG_TTLP
        self.STT = STT
        self.SoTien = SoTien
        self.TenShop = TenShop
    }
   
    class func getObjectFromJson(data: JSON) -> DisCountFundNew {
        let ConLai = data["ConLai"].doubleValue
        let MaShop = data["MaShop"].stringValue
        let QuyGG = data["QuyGG"].doubleValue
        let QuyGG_TTLP = data["QuyGG_TTLP"].doubleValue
        let STT = data["STT"].intValue
        let SoTien = data["SoTien"].doubleValue
        let TenShop = data["TenShop"].stringValue
        return DisCountFundNew(ConLai: ConLai, MaShop: MaShop, QuyGG: QuyGG, QuyGG_TTLP: QuyGG_TTLP, STT: STT, SoTien: SoTien, TenShop: TenShop)
    }
    
    class func parseObjfromArray(array:[JSON])->[DisCountFundNew]{
        var list:[DisCountFundNew] = []
        for item in array {
            list.append(self.getObjectFromJson(data: item))
        }
        return list
    }
}
