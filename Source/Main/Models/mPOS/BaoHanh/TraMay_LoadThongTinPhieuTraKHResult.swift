//
//  TraMay_LoadThongTinPhieuTraKHResult.swift
//  mPOS
//
//  Created by sumi on 8/23/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class TraMay_LoadThongTinPhieuTraKHResult: NSObject {
    var Imei: String
    var MaPhieuBH: String
    var TenKH: String
    var TenSanPham: String
    
    
    init(TraMay_LoadThongTinPhieuTraKHResult: JSON)
    {
        Imei = TraMay_LoadThongTinPhieuTraKHResult["Imei"].stringValue ;
        MaPhieuBH = TraMay_LoadThongTinPhieuTraKHResult["MaPhieuBH"].stringValue ;
        TenKH = TraMay_LoadThongTinPhieuTraKHResult["TenKH"].stringValue ;
        TenSanPham = TraMay_LoadThongTinPhieuTraKHResult["TenSanPham"].stringValue ;
    }
}


