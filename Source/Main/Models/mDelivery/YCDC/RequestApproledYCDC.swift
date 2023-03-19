//
//  RequestApproledYCDC.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 21/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct RequestApproledYCDC: Encodable
{
    var user: String
    var shopCode: String
    var soYCDC: String
    var os: String
    var details: [HeaderRequestApproledYCDC]
}
struct HeaderRequestApproledYCDC: Encodable
{
    var itemCode: String
    var whscode: String
    var quantity: Int
    var quantity_Ap: Int
}
