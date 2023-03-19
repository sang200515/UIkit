//
//  mDel_UpAnh_GHTNResult.swift
//  NewmDelivery
//
//  Created by sumi on 3/29/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class mDel_UpAnh_GHTNResult: NSObject {
    var Result : String
    var Msg: String
    
    
    init(mDel_UpAnh_GHTNResult: JSON)
    {
        Result = mDel_UpAnh_GHTNResult["Result"].stringValue;
        Msg = mDel_UpAnh_GHTNResult["Msg"].stringValue;
    }
}
