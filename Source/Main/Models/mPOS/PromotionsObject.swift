//
//  PromotionsObject.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class PromotionsObject: NSObject {
    var group: String
    var promotions: [ProductPromotionsArray]?
    
    init(group: String,promotions:[ProductPromotionsArray]?) {
        self.group = group
        self.promotions = promotions
    }
}
