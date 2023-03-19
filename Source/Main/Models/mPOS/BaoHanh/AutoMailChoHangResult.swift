//
//  AutoMailChoHangResult.swift
//  mPOS
//
//  Created by sumi on 1/12/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class AutoMailChoHangResult: NSObject {
    
    var Test: String
    
    init(AutoMailChoHangResult: JSON)
    {
        Test = AutoMailChoHangResult["Test"].stringValue ;
    }
}
