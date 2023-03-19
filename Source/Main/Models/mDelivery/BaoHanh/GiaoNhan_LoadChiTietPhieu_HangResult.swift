//
//  GiaoNhan_LoadChiTietPhieu_HangResult.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class GiaoNhan_LoadChiTietPhieu_HangResult: NSObject {
    
    var SoPhieuBH: String
    var TenSanPham: String
    var Imei: String
    
    init(GiaoNhan_LoadChiTietPhieu_HangResult: JSON)
    {
        SoPhieuBH = GiaoNhan_LoadChiTietPhieu_HangResult["SoPhieuBH"].stringValue ;
        TenSanPham = GiaoNhan_LoadChiTietPhieu_HangResult["TenSanPham"].stringValue;
        Imei = GiaoNhan_LoadChiTietPhieu_HangResult["Imei"].stringValue;
    }
}
