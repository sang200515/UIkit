//
//  GiaoNhan_CheckInResult.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class GiaoNhan_CheckInResult: NSObject {
    
    var Result: String
    var Message: String
    
    
    init(GiaoNhan_CheckInResult: JSON)
    {
        Result = GiaoNhan_CheckInResult["Result"].stringValue ;
        Message = GiaoNhan_CheckInResult["Message"].stringValue;
    }
    
}
