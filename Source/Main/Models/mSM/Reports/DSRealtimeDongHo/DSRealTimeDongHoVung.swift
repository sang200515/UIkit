//
//  DSRealTimeDongHo.swift
//  fptshop
//
//  Created by Ngo Dang tan on 3/20/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"DS_DongHo": 4629091,
//"SL_DongHo": 4,
//"SL_Shop": 2,
//"SL_TB_Shop": 2,
//"STT": "1",
//"TB_Bill": 1157273,
//"Vung": "Hà Nội",
//"flagToken": null
//SL_DS_Shop
import Foundation
import UIKit
import SwiftyJSON

class DSRealTimeDongHoVung: Jsonable {

    required init(json: JSON) {
        DS_DongHo = json["DS_DongHo"].double ?? 0;
        SL_DongHo = json["SL_DongHo"].double ?? 0;
        SL_Shop = json["SL_Shop"].double ?? 0;
        SL_TB_Shop = json["SL_TB_Shop"].double ?? 0;
        STT = json["STT"].string ?? "";
        TB_Bill = json["TB_Bill"].double ?? 0;
        Vung = json["Vung"].string ?? "";
        flagToken = json["flagToken"].string ?? "";
        SL_DS_Shop = json["SL_DS_Shop"].double ?? 0;
    }
    
    var DS_DongHo: Double?;
    var SL_DongHo:Double?;
    var SL_Shop:Double?;
    var SL_TB_Shop:Double?;
    var STT:String?;
    var TB_Bill:Double?;
    var Vung:String?;
    var flagToken:String?;
    var SL_DS_Shop: Double?
}
