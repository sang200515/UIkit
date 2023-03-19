//
//  GiaoNhan_DanhSachLoTrinh.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class GiaoNhan_DanhSachLoTrinh: NSObject {
    
    var STT: String
    var NoiPhanCong: String
    var Ten:String
    var DiaChi:String
    var Latitude: String
    var Longitude: String
    var LengthOfRoad:String
    var TimeCheckIn:String
    var IsCheckIn:String
    var SLGiao:String
    var SLNhan:String
    
    init(GiaoNhan_DanhSachLoTrinh: JSON)
    {
        STT = GiaoNhan_DanhSachLoTrinh["STT"].stringValue ;
        NoiPhanCong = GiaoNhan_DanhSachLoTrinh["NoiPhanCong"].stringValue;
        Ten = GiaoNhan_DanhSachLoTrinh["Ten"].stringValue;
        DiaChi = GiaoNhan_DanhSachLoTrinh["DiaChi"].stringValue;
        Latitude = GiaoNhan_DanhSachLoTrinh["Latitude"].stringValue ;
        Longitude = GiaoNhan_DanhSachLoTrinh["Longitude"].stringValue;
        LengthOfRoad = GiaoNhan_DanhSachLoTrinh["LengthOfRoad"].stringValue;
        TimeCheckIn = GiaoNhan_DanhSachLoTrinh["TimeCheckIn"].stringValue;
        IsCheckIn = GiaoNhan_DanhSachLoTrinh["IsCheckIn"].stringValue;
        SLGiao = GiaoNhan_DanhSachLoTrinh["SLGiao"].stringValue;
        SLNhan = GiaoNhan_DanhSachLoTrinh["SLNhan"].stringValue;
    }
    
}

