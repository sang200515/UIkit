//
//  TaoPhieuBH_NgayHenTraResult.swift
//  mPOS
//
//  Created by sumi on 1/9/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class TaoPhieuBH_NgayHenTraResult: NSObject {
    
    var NgayCamKet: String
    var ThoiGianCamKet: String
    
    
    
    init(TaoPhieuBH_NgayHenTraResult: JSON)
    {
        NgayCamKet = TaoPhieuBH_NgayHenTraResult["NgayCamKet"].stringValue ;
        ThoiGianCamKet = TaoPhieuBH_NgayHenTraResult["ThoiGianCamKet"].stringValue;
        
    }
}
