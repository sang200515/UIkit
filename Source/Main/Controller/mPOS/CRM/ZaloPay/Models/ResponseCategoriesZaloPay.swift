//
//  ResponseCategoriesZaloPay.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 13/09/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct ResponseCategoriesZaloPay: Decodable
{
    var totalCount: Int
    var items: [CategorySOM]
}
