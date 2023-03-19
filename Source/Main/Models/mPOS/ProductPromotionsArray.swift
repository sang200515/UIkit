//
//  ProductPromotionsArray.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class ProductPromotionsArray: NSObject {
    var promotionsMain: ProductPromotions
    var productPromotions: [ProductPromotions]?
    
    init(promotionsMain:ProductPromotions,productPromotions:[ProductPromotions]?) {
        self.promotionsMain = promotionsMain
        self.productPromotions = productPromotions
    }
}
