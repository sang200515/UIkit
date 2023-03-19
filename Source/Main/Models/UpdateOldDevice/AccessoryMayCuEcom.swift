//
//  AccessoryMayCuEcom.swift
//  fptshop
//
//  Created by DiemMy Le on 11/14/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.

import UIKit

class AccessoryMayCuEcom: NSObject {
    var id: String
    var name: String
    var isCheck: Bool
    
    init(id: String, name: String, isCheck: Bool) {
        self.id = id
        self.name = name
        self.isCheck = isCheck
    }
}
