//
//  RealtimeVungCungKyFinal.swift
//  fptshop
//
//  Created by DiemMy Le on 5/6/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.

//"DS_ECOM": 487788292,
//"DS_ECOM_1": 361265676,
//"DS_ECOM_6": 742095882,
//"DoanhSoNgay": 745064225,
//"DoanhSoNgay_1": 322360338,
//"DoanhSoNgay_6": 346827041,
//"STT": "1",
//"Tong": 1232852517,
//"Tong_1": 683626014,
//"Tong_6": 1088922923,
//"Vung": "Hà Nội",
import UIKit
import SwiftyJSON

class RealtimeVungCungKyFinal: Jsonable {
    var STT: String
    var Vung: String
    var DS_ECOM: Double
    var DS_ECOM_1: Double
    var DS_ECOM_6: Double
    var DoanhSoNgay: Double
    var DoanhSoNgay_1: Double
    var DoanhSoNgay_6: Double
    var Tong: Double
    var Tong_1: Double
    var Tong_6: Double
    
    required init(json: JSON) {
        Vung = json["Vung"].string ?? "";
        STT = json["STT"].string ?? "";
        DS_ECOM = json["DS_ECOM"].double ?? 0.0;
        DS_ECOM_1 = json["DS_ECOM_1"].double ?? 0.0;
        DS_ECOM_6 = json["DS_ECOM_6"].double ?? 0.0;
        
        DoanhSoNgay = json["DoanhSoNgay"].double ?? 0.0;
        DoanhSoNgay_1 = json["DoanhSoNgay_1"].double ?? 0.0;
        DoanhSoNgay_6 = json["DoanhSoNgay_6"].double ?? 0.0;
        Tong = json["Tong"].double ?? 0.0;
        Tong_1 = json["Tong_1"].double ?? 0.0;
        Tong_6 = json["Tong_6"].double ?? 0.0;
    }
}
