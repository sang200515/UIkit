//
//  ResponseStatusOrderZaloPay.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 18/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct ResponseStatusOrderZaloPay: Decodable
{
    var orderStatus: OrderStatus
    var message: String?
}
