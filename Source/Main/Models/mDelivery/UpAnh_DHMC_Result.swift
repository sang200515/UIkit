//
//  UpAnh_DHMC_Result.swift
//  NewmDelivery
//
//  Created by sumi on 5/10/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class UpAnh_DHMC_Result: NSObject {
    
    var SoSO : String
    var FileName : String
    var Base64String : String
    var TypeImg : String
    
    init(UpAnh_DHMC_Result: JSON)
    {
        SoSO = UpAnh_DHMC_Result["SoSO"].stringValue;
        FileName = UpAnh_DHMC_Result["FileName"].stringValue;
        Base64String = UpAnh_DHMC_Result["Base64String"].stringValue;
        TypeImg = UpAnh_DHMC_Result["TypeImg"].stringValue;
        
    }
    
}
