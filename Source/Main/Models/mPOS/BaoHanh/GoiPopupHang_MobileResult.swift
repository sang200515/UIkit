//
//  GoiPopupHang_MobileResult.swift
//  mPOS
//
//  Created by sumi on 1/19/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoiPopupHang_MobileResult: NSObject {
    
    var Result: String
    
    init(GoiPopupHang_MobileResult: JSON)
    {
        Result = GoiPopupHang_MobileResult["Result"].stringValue ;
    }
}
