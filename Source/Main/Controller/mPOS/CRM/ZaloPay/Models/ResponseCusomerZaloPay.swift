//
//  ResponseCusomerZaloPay.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 30/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct ResponseCusomerZaloPay:Decodable
{
    var return_code: String
    var return_message: String
    var sub_return_code: String?
    var sub_return_message: String?
    var data: CustomerZaloPay?
}
