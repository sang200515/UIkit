//
//  RequestHistoryZalopay.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 28/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct RequestHistoryZalopay: Encodable
{
    var warehouseCode: String
    var fromDate: String
    var toDate: String
    var isQueryMaKH: Bool
    var parentCategoryIds: [String]
    var term: String
}
