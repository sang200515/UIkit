//
//  NhaVanChuyen.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 02/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class NhaVanChuyen: NSObject {
    var code : String
    var name: String
    
    init(code:String,name:String){
        self.code = code
        self.name = name
    }
}
