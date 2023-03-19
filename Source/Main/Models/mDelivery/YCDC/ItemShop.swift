//
//  ItemShop.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 03/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class ItemShop: NSObject {
    var code : String
    var name: String
    var needFullName = false
    init(code:String,name:String,needFullName: Bool = false){
        self.code = code
        self.name = name
    }
    
    var fullName: String {
        return "\(code) - \(name)"
    }
}
