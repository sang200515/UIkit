//
//  GiaoNhan_LoadChiTietPhieuNhan.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class GiaoNhan_LoadChiTietPhieuNhan: NSObject {
    
    var MaBBBG: String
    var SoLuong: String
    var Loai:String
    
    init(GiaoNhan_LoadChiTietPhieuNhan: JSON)
    {
        MaBBBG = GiaoNhan_LoadChiTietPhieuNhan["MaBBBG"].stringValue ;
        SoLuong = GiaoNhan_LoadChiTietPhieuNhan["SoLuong"].stringValue;
        Loai = GiaoNhan_LoadChiTietPhieuNhan["Loai"].stringValue;
    }
}
