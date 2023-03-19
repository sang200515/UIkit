//
//  ItemHistorySOM.swift
//  fptshop
//
//  Created by Ngo Dang tan on 28/01/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct ItemHistorySOM: Codable {
    let orderID, billNo, crmBillNo: String?
    let totalAmountIncludingFee: Int?
    let customerPhoneNumber: String?
    let orderStatus: Int?
    let productCustomerCode, productID, productName, warehouseName: String?
    let warehouseCode: String?
    let quantity: Int?
    let parentCategoryID, parentCategoryName, creationTime, employeeName: String?
    let categoryID, categoryName: String?
    let payoutNo: String?
    let transactionCode, paymentMethods: String?
    let posso: String?
    let haveSO: Int?

    enum CodingKeys: String, CodingKey {
        case orderID = "orderId"
        case billNo, crmBillNo, totalAmountIncludingFee, customerPhoneNumber, orderStatus, productCustomerCode
        case productID = "productId"
        case productName, warehouseName, warehouseCode, quantity
        case parentCategoryID = "parentCategoryId"
        case parentCategoryName, creationTime, employeeName
        case categoryID = "categoryId"
        case categoryName, payoutNo, transactionCode, paymentMethods, posso, haveSO
    }
}
