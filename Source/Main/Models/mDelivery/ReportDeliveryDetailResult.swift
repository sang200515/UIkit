//
//  ReportDeliveryDetailResult.swift
//  NewmDelivery
//
//  Created by sumi on 4/27/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class ReportDeliveryDetailResult: NSObject {
    
    var SoDHEcom : String
    var SoSHPOS : String
    var TinhDungHen : String
    var TinhTrangSDmDelivery : String
    var INC : String
    var ThoiGianGiaoHangChoKhach : String
    var ThoiGianCamKetGiaoHang : String
    var TinhTrangGiaoHangApp : String
    var KhoangCachGiaoHang : String
    
    
    init(ReportDeliveryDetailResult: JSON)
    {
        SoDHEcom = ReportDeliveryDetailResult["SoDHEcom"].stringValue;
        SoSHPOS = ReportDeliveryDetailResult["SoSHPOS"].stringValue;
        TinhDungHen = ReportDeliveryDetailResult["TinhDungHen"].stringValue;
        TinhTrangSDmDelivery = ReportDeliveryDetailResult["TinhTrangSDmDelivery"].stringValue;
        INC = ReportDeliveryDetailResult["INC"].stringValue;
        
        ThoiGianGiaoHangChoKhach = ReportDeliveryDetailResult["ThoiGianGiaoHangChoKhach"].stringValue;
        ThoiGianCamKetGiaoHang = ReportDeliveryDetailResult["ThoiGianCamKetGiaoHang"].stringValue;
        TinhTrangGiaoHangApp = ReportDeliveryDetailResult["TinhTrangGiaoHangApp"].stringValue;
        KhoangCachGiaoHang = ReportDeliveryDetailResult["KhoangCachGiaoHang"].stringValue;
    }
}
