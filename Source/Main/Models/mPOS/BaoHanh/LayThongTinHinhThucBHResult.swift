//
//  LayThongTinHinhThucBHResult.swift
//  mPOS
//
//  Created by sumi on 1/4/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class LayThongTinHinhThucBHResult: NSObject {
    
    var MaHinhThuc: String
    var TenHinhThuc: String
    
    init(LayThongTinHinhThucBHResult: JSON)
    {
        MaHinhThuc = LayThongTinHinhThucBHResult["MaHinhThuc"].stringValue ;
        TenHinhThuc = LayThongTinHinhThucBHResult["TenHinhThuc"].stringValue;
        
    }
}
