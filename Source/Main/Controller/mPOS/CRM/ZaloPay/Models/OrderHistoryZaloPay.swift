//
//  OrderHistoryZaloPay.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 29/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct OrderHistoryZaloPay:Decodable
{
    var description: String
    var creationTime: String
    var actionDisplay: Int
    var action: String
}
