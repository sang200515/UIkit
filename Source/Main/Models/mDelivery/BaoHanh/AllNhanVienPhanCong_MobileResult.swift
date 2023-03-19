//
//  AllNhanVienPhanCong_MobileResult.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class AllNhanVienPhanCong_MobileResult: NSObject {
    
    var MaLoaiPhanCong: String
    var MaNhanVien: String
    var NoiPhanCong: String
    var MaTTBHFRT: String
    var Loai: String
    var Ten: String
    var DiaChi: String
    var DiaChiToaDo: String
    var mTimeExpected:Int
    var MaPhanBiet:String
    var Latitude:Double
    var Longitude:Double
    
    var Is_CheckIn: String
    var DiemDanhDau: String
    
    
    init(AllNhanVienPhanCong_MobileResult: JSON)
    {
        MaLoaiPhanCong = AllNhanVienPhanCong_MobileResult["MaLoaiPhanCong"].stringValue ;
        MaNhanVien = AllNhanVienPhanCong_MobileResult["MaNhanVien"].stringValue;
        NoiPhanCong = AllNhanVienPhanCong_MobileResult["NoiPhanCong"].stringValue;
        MaTTBHFRT = AllNhanVienPhanCong_MobileResult["MaTTBHFRT"].stringValue;
        Loai = AllNhanVienPhanCong_MobileResult["Loai"].stringValue;
        Ten = AllNhanVienPhanCong_MobileResult["Ten"].stringValue;
        DiaChi = AllNhanVienPhanCong_MobileResult["DiaChi"].stringValue;
        DiaChiToaDo = ""
        mTimeExpected = 0
        
        MaPhanBiet = AllNhanVienPhanCong_MobileResult["MaPhanBiet"].stringValue;
        Latitude = AllNhanVienPhanCong_MobileResult["Latitude"].doubleValue;
        Longitude = AllNhanVienPhanCong_MobileResult["Longitude"].doubleValue;
        
        Is_CheckIn = AllNhanVienPhanCong_MobileResult["Is_CheckIn"].stringValue;
        DiemDanhDau = AllNhanVienPhanCong_MobileResult["DiemDanhDau"].stringValue;
        
        
    }
}

