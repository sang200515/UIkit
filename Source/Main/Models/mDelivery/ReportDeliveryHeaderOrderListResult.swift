//
//  ReportDeliveryHeaderOrderListResult.swift
//  NewmDelivery
//
//  Created by sumi on 4/26/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class ReportDeliveryHeaderOrderListResult: NSObject {
    
    var SoDHPOS : String
    var SoDHEcom : String
    var TinhDungHen : String
    var TinhTrangSDmDelivery : String
    var INC : String
    
    
    init(ReportDeliveryHeaderOrderListResult: JSON)
    {
        SoDHPOS = ReportDeliveryHeaderOrderListResult["SoDHPOS"].stringValue;
        SoDHEcom = ReportDeliveryHeaderOrderListResult["SoDHEcom"].stringValue;
        TinhDungHen = ReportDeliveryHeaderOrderListResult["TinhDungHen"].stringValue;
        TinhTrangSDmDelivery = ReportDeliveryHeaderOrderListResult["TinhTrangSDmDelivery"].stringValue;
        INC = ReportDeliveryHeaderOrderListResult["INC"].stringValue;
        
    }
}

