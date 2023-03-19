//
//  LayHinhThucBanGiaoChoBHVResult.swift
//  mPOS
//
//  Created by sumi on 1/8/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class LayHinhThucBanGiaoChoBHVResult: NSObject {
    
    var DiaChiTTBHFRT: String
    var DiachiTTBH: String
    var HinhThucBG: String
    var MaTTBHFRT: String
    var MaTTBHHang: String
    var TenHinhThuc: String
    var TenTTBH: String
    var TenTTBHFRT: String
    
    
    
    init(LayHinhThucBanGiaoChoBHVResult: JSON)
    {
        DiaChiTTBHFRT = LayHinhThucBanGiaoChoBHVResult["DiaChiTTBHFRT"].stringValue ;
        DiachiTTBH = LayHinhThucBanGiaoChoBHVResult["DiachiTTBH"].stringValue;
        HinhThucBG = LayHinhThucBanGiaoChoBHVResult["HinhThucBG"].stringValue;
        MaTTBHFRT = LayHinhThucBanGiaoChoBHVResult["MaTTBHFRT"].stringValue ;
        MaTTBHHang = LayHinhThucBanGiaoChoBHVResult["MaTTBHHang"].stringValue;
        TenHinhThuc = LayHinhThucBanGiaoChoBHVResult["TenHinhThuc"].stringValue;
        TenTTBH = LayHinhThucBanGiaoChoBHVResult["TenTTBH"].stringValue;
        TenTTBHFRT = LayHinhThucBanGiaoChoBHVResult["TenTTBHFRT"].stringValue;
        
        
        
    }
}
