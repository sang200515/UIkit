//
//  ConfirmThuKhoResult.swift
//  NewmDelivery
//
//  Created by sumi on 3/28/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class ConfirmThuKhoResult: NSObject {
    var Result : String
    var Descriptionn: String
    
    
    init(ConfirmThuKhoResult: JSON)
    {
        Result = ConfirmThuKhoResult["Result"].stringValue;
        Descriptionn = ConfirmThuKhoResult["Description"].stringValue;
    }
    
}
