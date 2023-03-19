//
//  Checkimei_V2_MoreResult.swift
//  mPOS
//
//  Created by sumi on 1/24/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class Checkimei_V2_MoreResult: NSObject {
    
    
    var LINE: String
    var NgayBaoHanh: String
    var SoDonHang: String
    var TenSanPham: String
    var imei: String
    
    
    init(Checkimei_V2_MoreResult: JSON)
    {
        LINE = Checkimei_V2_MoreResult["LINE"].stringValue ;
        NgayBaoHanh = Checkimei_V2_MoreResult["NgayBaoHanh"].stringValue;
        SoDonHang = Checkimei_V2_MoreResult["SoDonHang"].stringValue ;
        TenSanPham = Checkimei_V2_MoreResult["TenSanPham"].stringValue;
        imei = Checkimei_V2_MoreResult["imei"].stringValue ;
        
    }
    
}

