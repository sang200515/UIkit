//
//  RequestPaymentTimePrice.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 6/20/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class RequestPaymentTimePrice: NSObject {
    var fromDate:String
    var toDate:String
    var price:Int
    
    init(fromDate:String, toDate:String,price:Int){
        self.fromDate = fromDate
        self.toDate = toDate
        self.price = price
    }
}

