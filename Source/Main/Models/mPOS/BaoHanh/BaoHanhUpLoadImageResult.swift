//
//  BaoHanhUpLoadImageResult.swift
//  mPOS
//
//  Created by sumi on 1/10/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaoHanhUpLoadImageResult: NSObject {
    
    var ImageName: String
    var Result: String
    
    init(BaoHanhUpLoadImageResult: JSON)
    {
        ImageName = BaoHanhUpLoadImageResult["ImageName"].stringValue ;
        Result = BaoHanhUpLoadImageResult["Result"].stringValue;
    }
    
}
