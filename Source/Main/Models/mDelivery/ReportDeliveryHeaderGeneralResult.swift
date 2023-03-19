//
//  ReportDeliveryHeaderGeneralResult.swift
//  NewmDelivery
//
//  Created by sumi on 4/26/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class ReportDeliveryHeaderGeneralResult: NSObject {
    
    var MaNV : String
    var SoDHDuocPhanCong : String
    var SoDHKhongDungMDelivery : String
    var SoDHTreHen : String
    var TongINC : String
    var TongPhat : String
    
    init(ReportDeliveryHeaderGeneralResult: JSON)
    {
        MaNV = ReportDeliveryHeaderGeneralResult["MaNV"].stringValue;
        SoDHDuocPhanCong = ReportDeliveryHeaderGeneralResult["SoDHDuocPhanCong"].stringValue;
        SoDHKhongDungMDelivery = ReportDeliveryHeaderGeneralResult["SoDHKhongDungMDelivery"].stringValue;
        SoDHTreHen = ReportDeliveryHeaderGeneralResult["SoDHTreHen"].stringValue;
        TongINC = ReportDeliveryHeaderGeneralResult["TongINC"].stringValue;
        TongPhat = ReportDeliveryHeaderGeneralResult["TongPhat"].stringValue;
    }
}


