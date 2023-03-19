//
//  TaoPhieuBH_TimsanphamResult.swift
//  mPOS
//
//  Created by sumi on 1/4/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class TaoPhieuBH_TimsanphamResult: NSObject {
    
    var MaLoai: String
    var MaNganh: String
    var MaNhan: String
    var MaNhomHangCRM: String
    var MaSanPham: String
    var TenLoai: String
    var TenNganh: String
    var TenNhan: String
    var TenSanPham: String
    
    
    init(TaoPhieuBH_TimsanphamResult: JSON)
    {
        MaLoai = TaoPhieuBH_TimsanphamResult["MaLoai"].stringValue ;
        MaNganh = TaoPhieuBH_TimsanphamResult["MaNganh"].stringValue;
        MaNhan = TaoPhieuBH_TimsanphamResult["MaNhan"].stringValue;
        MaNhomHangCRM = TaoPhieuBH_TimsanphamResult["MaNhomHangCRM"].stringValue;
        MaSanPham = TaoPhieuBH_TimsanphamResult["MaSanPham"].stringValue;
        TenLoai = TaoPhieuBH_TimsanphamResult["TenLoai"].stringValue;
        TenNganh = TaoPhieuBH_TimsanphamResult["TenNganh"].stringValue;
        TenNhan = TaoPhieuBH_TimsanphamResult["TenNhan"].stringValue;
        TenSanPham = TaoPhieuBH_TimsanphamResult["TenSanPham"].stringValue;
    }
    
}

