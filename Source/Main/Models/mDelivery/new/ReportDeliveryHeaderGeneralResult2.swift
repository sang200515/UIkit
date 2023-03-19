//
//  ReportDeliveryHeaderGeneralResult.swift
//  NewmDelivery
//
//  Created by sumi on 4/26/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class ReportDeliveryHeaderGeneralResult2: NSObject {
    
    var MaNV : String
    var SoDHDuocPhanCong : String
    var SoDHKhongDungMDelivery : String
    var SoDHTreHen : String
    var TongINC : String
    var TongPhat : String
    init(MaNV: String, SoDHDuocPhanCong: String, SoDHKhongDungMDelivery: String, SoDHTreHen: String, TongINC: String, TongPhat: String) {
        self.MaNV = MaNV
        self.SoDHDuocPhanCong = SoDHDuocPhanCong
        self.SoDHKhongDungMDelivery  = SoDHKhongDungMDelivery
        self.SoDHTreHen  = SoDHTreHen
        self.TongINC  = TongINC
        self.TongPhat  = TongPhat
    }
    class func getObjFromDictionary(data:JSON) -> ReportDeliveryHeaderGeneralResult2{
        
        var MaNV = data["MaNV"].string
        var SoDHDuocPhanCong = data["SoDHDuocPhanCong"].string
        var SoDHKhongDungMDelivery = data["SoDHKhongDungMDelivery"].string
        var SoDHTreHen = data["SoDHTreHen"].string
        var TongINC = data["TongINC"].string
        var TongPhat = data["TongPhat"].string
        
        MaNV = MaNV == nil ? "" : MaNV
        SoDHDuocPhanCong = SoDHDuocPhanCong == nil ? "" : SoDHDuocPhanCong
        
        SoDHKhongDungMDelivery = SoDHKhongDungMDelivery == nil ? "" : SoDHKhongDungMDelivery
        SoDHTreHen = SoDHTreHen == nil ? "" : SoDHTreHen
        
        TongINC = TongINC == nil ? "" : TongINC
        TongPhat = TongPhat == nil ? "" : TongPhat
        
        return ReportDeliveryHeaderGeneralResult2(MaNV: MaNV!, SoDHDuocPhanCong: SoDHDuocPhanCong!, SoDHKhongDungMDelivery: SoDHKhongDungMDelivery!, SoDHTreHen: SoDHTreHen!, TongINC: TongINC!, TongPhat: TongPhat!)
    }
    class func parseObjfromArray(array:[JSON])->[ReportDeliveryHeaderGeneralResult2]{
        var list:[ReportDeliveryHeaderGeneralResult2] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
}


