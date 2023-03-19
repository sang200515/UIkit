//
//  GiaoNhan_LoadSoPhieuGiaoNhan.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class GiaoNhan_LoadSoPhieuGiaoNhan: NSObject {
    
    var SoLuongGiao: String
    var SoLuongNhan: String
    var ListGiao:String
    var ListNhan:String
    
    init(GiaoNhan_LoadSoPhieuGiaoNhan: JSON)
    {
        SoLuongGiao = GiaoNhan_LoadSoPhieuGiaoNhan["SoLuongGiao"].stringValue ;
        SoLuongNhan = GiaoNhan_LoadSoPhieuGiaoNhan["SoLuongNhan"].stringValue;
        ListGiao = GiaoNhan_LoadSoPhieuGiaoNhan["ListGiao"].stringValue;
        ListNhan = GiaoNhan_LoadSoPhieuGiaoNhan["ListNhan"].stringValue;
    }
}


