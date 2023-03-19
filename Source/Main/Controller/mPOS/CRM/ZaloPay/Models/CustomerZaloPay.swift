//
//  CustomerZaloPay.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 30/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct CustomerZaloPay:Decodable
{
    var amount: Double?
    var reference_id: String
    var m_u_id: String
    var name: String
    var phone: String
    var description: String?
}
