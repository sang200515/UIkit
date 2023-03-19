//
//  Checkimei_V2_ImeiInfoServices_Result.swift
//  mPOS
//
//  Created by sumi on 1/12/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class Checkimei_V2_ImeiInfoServices_Result: NSObject {
    var HieuLuc: String
    var HieuLucSamSungVip: String
    var HieuLucVip: String
    var MaHDSamSungVip: String
    var MaHDVip: String
    var MaSPBHV: String
    var MaSPVip: String
    var MaSamSungVip: String
    var SoHDBHV: String
    
    init(Checkimei_V2_ImeiInfoServices_Result: JSON)
    {
        HieuLuc = Checkimei_V2_ImeiInfoServices_Result["HieuLuc"].stringValue ;
        HieuLucSamSungVip = Checkimei_V2_ImeiInfoServices_Result["HieuLucSamSungVip"].stringValue;
        HieuLucVip = Checkimei_V2_ImeiInfoServices_Result["HieuLucVip"].stringValue;
        MaHDSamSungVip = Checkimei_V2_ImeiInfoServices_Result["MaHDSamSungVip"].stringValue ;
        MaHDVip = Checkimei_V2_ImeiInfoServices_Result["MaHDVip"].stringValue;
        MaSPBHV = Checkimei_V2_ImeiInfoServices_Result["MaSPBHV"].stringValue;
        MaSPVip = Checkimei_V2_ImeiInfoServices_Result["MaSPVip"].stringValue ;
        MaSamSungVip = Checkimei_V2_ImeiInfoServices_Result["MaSamSungVip"].stringValue;
        SoHDBHV = Checkimei_V2_ImeiInfoServices_Result["SoHDBHV"].stringValue;
    }
}
