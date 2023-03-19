//
//  DepositInfo.swift
//  mPOS
//
//  Created by MinhDH on 1/3/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class DepositInfo: NSObject {
    
    var SoDH_POS: Int
    var NgayDatCoc: String
    var MaSP: String
    var TenSP: String
    var SL: Int
    var TenKH: String
    var SDT: String
    
    
    init(SoDH_POS: Int, NgayDatCoc: String, MaSP: String, TenSP: String, SL: Int, TenKH: String, SDT: String){
        self.SoDH_POS = SoDH_POS
        self.NgayDatCoc = NgayDatCoc
        self.MaSP = MaSP
        self.TenSP = TenSP
        self.SL = SL
        self.TenKH = TenKH
        self.SDT = SDT
    }
    class func parseObjfromArray(array:[JSON])->[DepositInfo]{
        var list:[DepositInfo] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> DepositInfo{
        
        var soDH_POS = data["SoDH_POS"].int
        var ngayDatCoc = data["NgayDatCoc"].string
        var maSP = data["MaSP"].string
        var tenSP = data["TenSP"].string
        var sl = data["SL"].int
        var tenKH = data["TenKH"].string
        var sdt = data["SDT"].string
        
        soDH_POS = soDH_POS == nil ? 0 : soDH_POS
        ngayDatCoc = ngayDatCoc == nil ? "" : ngayDatCoc
        maSP = maSP == nil ? "" : maSP
        tenSP = tenSP == nil ? "" : tenSP
        sl = sl == nil ? 0 : sl
        tenKH = tenKH == nil ? "" : tenKH
        sdt = sdt == nil ? "" : sdt
        
        return DepositInfo(SoDH_POS: soDH_POS!, NgayDatCoc: ngayDatCoc!, MaSP: maSP!, TenSP: tenSP!, SL: sl!, TenKH: tenKH!, SDT: sdt!)
    }
    
}
