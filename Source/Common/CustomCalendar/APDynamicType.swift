//
//  APDynamicType.swift
//  fptshop
//
//  Created by DiemMy Le on 12/1/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

class Dynamic<T> {
    
    var value: T? {
        didSet {
            bind?(value)
        }
    }
    
    var bind: ((T?)->())?
    
    init(_ _value: T) {
        value = _value
    }
}
