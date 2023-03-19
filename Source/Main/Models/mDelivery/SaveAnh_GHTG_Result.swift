//
//  SaveAnh_GHTG_Result.swift
//  NewmDelivery
//
//  Created by sumi on 4/17/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class SaveAnh_GHTG_Result: NSObject {
    
    var Result : String
    var Msg : String
    var Description:String
    
    init(SaveAnh_GHTG_Result: JSON)
    {
        Result = SaveAnh_GHTG_Result["Result"].stringValue;
        Msg = SaveAnh_GHTG_Result["Msg"].stringValue;
        Description = SaveAnh_GHTG_Result["Description"].stringValue;
    }
}
