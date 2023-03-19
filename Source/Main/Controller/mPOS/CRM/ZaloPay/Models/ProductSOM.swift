//
//  ProductSOM.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 30/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct ProductSOM: Decodable
{
    var id: String
    var defaultProviderId: String
    var name: String
    var configs: [ConfigProductSOM]
}
struct ConfigProductSOM: Decodable
{
    var integratedGroupCode: String?
    var allowVoucherPayment: Bool
    var allowCashPayment: Bool
    var allowCardPayment: Bool
    var createUrl:  String?
    var integratedProductCode: String?
    var providerId: String?
}

