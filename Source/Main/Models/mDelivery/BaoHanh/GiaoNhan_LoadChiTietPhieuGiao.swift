//
//  GiaoNhan_LoadChiTietPhieuGiao.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class GiaoNhan_LoadChiTietPhieuGiao: NSObject {
    
    var MaBBBG: String
    var SoLuong: String
    var Loai:String
    
    init(GiaoNhan_LoadChiTietPhieuGiao: JSON)
    {
        MaBBBG = GiaoNhan_LoadChiTietPhieuGiao["MaBBBG"].stringValue ;
        SoLuong = GiaoNhan_LoadChiTietPhieuGiao["SoLuong"].stringValue;
        Loai = GiaoNhan_LoadChiTietPhieuGiao["Loai"].stringValue;
    }
}

