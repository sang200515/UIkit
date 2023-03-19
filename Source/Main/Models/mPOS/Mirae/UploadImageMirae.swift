//
//  UploadImageMirae.swift
//  fptshop
//
//  Created by tan on 6/6/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class UploadImageMirae: NSObject {
    var url:String
    var type:String
    
    init(   url:String
    , type:String){
        self.url = url
        self.type = type
    }
}
