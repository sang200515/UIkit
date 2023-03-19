//
//  RequestPaymentHistory.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 6/20/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class RequestPaymentHistory: NSObject {
    var SoHopDong:String
    var TenChuNha:String
    var SDT:String
    var DiaChiShop:String
    var CreateDate:String
    var CreateBy:String
    var Status:String
    
    init(SoHopDong:String, TenChuNha:String, SDT:String, DiaChiShop:String, CreateDate:String, CreateBy:String, Status:String){
        self.SoHopDong = SoHopDong
        self.TenChuNha = TenChuNha
        self.SDT = SDT
        self.DiaChiShop = DiaChiShop
        self.CreateDate = CreateDate
        self.CreateBy = CreateBy
        self.Status = Status
    }
    class func parseObjfromArray(array:[JSON])->[RequestPaymentHistory]{
        var list:[RequestPaymentHistory] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> RequestPaymentHistory{
        
        var SoHopDong = data["SoHopDong"].string
        var TenChuNha = data["TenChuNha"].string
        var SDT = data["SDT"].string
        var DiaChiShop = data["DiaChiShop"].string
        var CreateDate = data["CreateDate"].string
        var CreateBy = data["CreateBy"].string
        var Status = data["Status"].string
        
        SoHopDong = SoHopDong == nil ? "" : SoHopDong
        TenChuNha = TenChuNha == nil ? "" : TenChuNha
        SDT = SDT == nil ? "" : SDT
        DiaChiShop = DiaChiShop == nil ? "" : DiaChiShop
        CreateDate = CreateDate == nil ? "" : CreateDate
        CreateBy = CreateBy == nil ? "" : CreateBy
        Status = Status == nil ? "" : Status
        
        return RequestPaymentHistory(SoHopDong:SoHopDong!, TenChuNha:TenChuNha!, SDT:SDT!, DiaChiShop:DiaChiShop!, CreateDate:CreateDate!, CreateBy:CreateBy!, Status:Status!)
    }
}
