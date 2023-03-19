//
//  ResponeErrorZaloPay.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 25/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct ResponeErrorZaloPay: Decodable
{
    var error: BodyErrorZaloPay
}
struct BodyErrorZaloPay: Decodable
{
    var message: String
    var code: String?
}
