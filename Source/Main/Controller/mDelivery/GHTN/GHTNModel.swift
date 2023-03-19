//
//  GHTNModel.swift
//  fptshop
//
//  Created by Ngoc Bao on 11/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import SwiftyJSON
import Foundation

class GrabPlainingItem {
    var result : Int
    var msg : String
    var planningId : Int
    var expected_Time : String
    var partner : String
    var amount : Int
    var amount_FRT : Int
    var services_Code : String
    var servicesName : String
    var distance : Double
    var duration : Int
    var diaChiShop : String
    var diaChiKhachHang : String
    var tenDichVu : String
    var khoangCach : String
    var duKien : String
    var tongCong : String
    
    init(result: Int, msg: String, planningId: Int, expected_Time: String, partner: String, amount: Int, amount_FRT: Int, services_Code: String, servicesName: String, distance: Double, duration: Int, diaChiShop: String, diaChiKhachHang: String, tenDichVu: String, khoangCach: String, duKien: String, tongCong: String) {
        self.result = result
        self.msg = msg
        self.planningId = planningId
        self.expected_Time = expected_Time
        self.partner = partner
        self.amount = amount
        self.amount_FRT = amount_FRT
        self.services_Code = services_Code
        self.servicesName = servicesName
        self.distance = distance
        self.duration = duration
        self.diaChiShop = diaChiShop
        self.diaChiKhachHang = diaChiKhachHang
        self.tenDichVu = tenDichVu
        self.khoangCach = khoangCach
        self.duKien = duKien
        self.tongCong = tongCong
    }
    class func getObjFromDictionary(data:JSON) -> GrabPlainingItem {
        let result = data["Result"].intValue
        let msg = data["Msg"].stringValue
        let planningId = data["PlanningId"].intValue
        let expected_Time = data["Expected_Time"].stringValue
        let partner = data["Partner"].stringValue
        let amount = data["Amount"].intValue
        let amount_FRT = data["Amount_FRT"].intValue
        let services_Code = data["Services_Code"].stringValue
        let servicesName = data["ServicesName"].stringValue
        let distance = data["Distance"].doubleValue
        let duration = data["Duration"].intValue
        let diaChiShop = data["DiaChiShop"].stringValue
        let diaChiKhachHang = data["DiaChiKhachHang"].stringValue
        let tenDichVu = data["TenDichVu"].stringValue
        let khoangCach = data["KhoangCach"].stringValue
        let duKien = data["DuKien"].stringValue
        let tongCong = data["TongCong"].stringValue
        return GrabPlainingItem(result: result, msg: msg, planningId: planningId, expected_Time: expected_Time, partner: partner, amount: amount, amount_FRT: amount_FRT, services_Code: services_Code, servicesName: servicesName, distance: distance, duration: duration, diaChiShop: diaChiShop, diaChiKhachHang: diaChiKhachHang, tenDichVu: tenDichVu, khoangCach: khoangCach, duKien: duKien, tongCong: tongCong)
    }
    
}

class BookingItem {
    var result: Int
    var msg: String
    
    init(result: Int, msg: String) {
        self.result = result
        self.msg = msg
    }
    
    class func getObjFromDictionary(data:JSON) -> BookingItem {
        let result = data["Result"].intValue
        let msg = data["Msg"].stringValue
        return BookingItem(result: result, msg: msg)
    }
}
