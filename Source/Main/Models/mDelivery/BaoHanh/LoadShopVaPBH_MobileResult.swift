//
//  LoadShopVaPBH_MobileResult.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoadShopVaPBH_MobileResult: NSObject {
    
    var Ma: String
    var Ten: String
    var DiaChi: String
    var Loai: String
    
    init(LoadShopVaPBH_MobileResult: JSON)
    {
        Ma = LoadShopVaPBH_MobileResult["Ma"].stringValue ;
        Ten = LoadShopVaPBH_MobileResult["Ten"].stringValue;
        DiaChi = LoadShopVaPBH_MobileResult["DiaChi"].stringValue;
        Loai = LoadShopVaPBH_MobileResult["Loai"].stringValue;
        
    }
    
    
    
}

