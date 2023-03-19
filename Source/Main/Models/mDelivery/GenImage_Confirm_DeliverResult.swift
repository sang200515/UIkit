//
//  GenImage_Confirm_DeliverResult.swift
//  NewmDelivery
//
//  Created by sumi on 9/5/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class GenImage_Confirm_DeliverResult: NSObject {
    var Success : String
    var Url : String
    var Message : String
    
    init(GenImage_Confirm_DeliverResult: JSON)
    {
        Success = GenImage_Confirm_DeliverResult["Success"].stringValue;
        Url = GenImage_Confirm_DeliverResult["Url"].stringValue;
        Message = GenImage_Confirm_DeliverResult["Message"].stringValue;
        
    }
    
}
