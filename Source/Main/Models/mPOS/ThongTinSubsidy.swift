//
//  ThongTinSubsidy.swift
//  mPOS
//
//  Created by MinhDH on 4/5/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class ThongTinSubsidy: NSObject {
    
    var CMND: String
    var NgayKichHoat: String
    var SDT: String
    var TTCaifKnox: String
    var TongNo: Double
    var TenKH: String
    
    init(CMND: String, NgayKichHoat: String, SDT: String, TTCaifKnox: String, TongNo: Double,TenKH: String){
        self.CMND = CMND
        self.NgayKichHoat = NgayKichHoat
        self.SDT = SDT
        self.TTCaifKnox = TTCaifKnox
        self.TongNo = TongNo
        self.TenKH = TenKH
    }
    class func parseObjfromArray(array:[JSON])->[ThongTinSubsidy]{
        var list:[ThongTinSubsidy] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ThongTinSubsidy{
        
        var cmnd = data["CMND"].string
        var ngayKichHoat = data["NgayKichHoat"].string
        var sdt = data["SDT"].string
        var ttCaifKnox = data["TTCaifKnox"].string
        var tongNo = data["TongNo"].double
        var tenKH = data["TenKH"].string
        
        cmnd = cmnd == nil ? "" : cmnd
        ngayKichHoat = ngayKichHoat == nil ? "" : ngayKichHoat
        sdt = sdt == nil ? "" : sdt
        ttCaifKnox = ttCaifKnox == nil ? "" : ttCaifKnox
        tongNo = tongNo == nil ? 0.0 : tongNo
        tenKH = tenKH == nil ? "" : tenKH
        
        return ThongTinSubsidy(CMND: cmnd!, NgayKichHoat: ngayKichHoat!, SDT: sdt!, TTCaifKnox: ttCaifKnox!,TongNo:tongNo!,TenKH:tenKH!)
    }
    
}
