//
//  LayTinhTrangMayResult.swift
//  mPOS
//
//  Created by sumi on 1/5/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class LayTinhTrangMayResult: NSObject {
    
    var KHGiaoShop: String
    var MaTinhTrang: String
    var TenTinhTrang: String
    
    
    init(LayTinhTrangMayResult: JSON)
    {
        KHGiaoShop = LayTinhTrangMayResult["KHGiaoShop"].stringValue ;
        MaTinhTrang = LayTinhTrangMayResult["MaTinhTrang"].stringValue;
        TenTinhTrang = LayTinhTrangMayResult["TenTinhTrang"].stringValue;
        print("poppoopop \(KHGiaoShop)")
        
    }
}
