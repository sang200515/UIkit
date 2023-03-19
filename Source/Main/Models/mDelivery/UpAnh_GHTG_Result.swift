//
//  UpAnh_GHTG_Result.swift
//  NewmDelivery
//
//  Created by sumi on 4/17/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class UpAnh_GHTG_Result: NSObject {
    
    var Result : String
    var Msg : String
    var FileName : String
    
    init(UpAnh_GHTG_Result: JSON)
    {
        Result = UpAnh_GHTG_Result["Result"].stringValue;
        Msg = UpAnh_GHTG_Result["Msg"].stringValue;
        FileName = UpAnh_GHTG_Result["FileName"].stringValue;
        
    }
}
