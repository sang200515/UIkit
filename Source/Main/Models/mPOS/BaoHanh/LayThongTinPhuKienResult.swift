//
//  LayThongTinPhuKienResult.swift
//  mPOS
//
//  Created by sumi on 12/18/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class LayThongTinPhuKienResult: NSObject {
    
    var KHGiaoShop: String
    var MaPK: String
    var STT: String
    var Serial: String
    var SoLuong: String
    var TenPK: String
    var TinhTrangShop: String
    var TTKH: String
    var BaoHanh: String
    
    init(LayThongTinPhuKienResult: JSON)
    {
        KHGiaoShop = LayThongTinPhuKienResult["KHGiaoShop"].stringValue ;
        MaPK = LayThongTinPhuKienResult["MaPK"].stringValue;
        STT = LayThongTinPhuKienResult["STT"].stringValue;
        Serial = LayThongTinPhuKienResult["Serial"].stringValue;
        SoLuong = LayThongTinPhuKienResult["SoLuong"].stringValue;
        TenPK = LayThongTinPhuKienResult["TenPK"].stringValue;
        TinhTrangShop = LayThongTinPhuKienResult["TinhTrangShop"].stringValue;
        BaoHanh = LayThongTinPhuKienResult["BaoHanh"].stringValue;
        TTKH = ""
    }
    
}
