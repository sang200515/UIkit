//
//  Atrribute.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class Atrribute: NSObject {
    var group: String
    var attributes: [Attributes]
    
    init(group: String, attributes: [Attributes]) {
        self.group = group
        self.attributes = attributes
    }
    

    
}

