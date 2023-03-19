//
//  FtelReceipt.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 06/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class FtelReceipt: Mappable {
    var orderId: String = ""
    var billNo: String = ""
    var totalAmountIncludingFee: Int = 0
    var customerPhoneNumber: String = ""
    var orderStatus: Int = 0
    var productCustomerCode: String = ""
    var productId: String = ""
    var productName: String = ""
    var warehouseName: String = ""
    var warehouseCode: String = ""
    var quantity: Int = 0
    var parentCategoryId: String = ""
    var parentCategoryName: String = ""
    var creationTime: String = ""
    var employeeName: String = ""
    var categoryId: String = ""
    var categoryName: String = ""
    var transactionCode: String = ""
    var paymentMethods: String = ""
    var haveSO: Int = 0
    var partnerReturnTransactionId: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.orderId <- map["orderId"]
        self.billNo <- map["billNo"]
        self.totalAmountIncludingFee <- map["totalAmountIncludingFee"]
        self.customerPhoneNumber <- map["customerPhoneNumber"]
        self.orderStatus <- map["orderStatus"]
        self.productCustomerCode <- map["productCustomerCode"]
        self.productId <- map["productId"]
        self.productName <- map["productName"]
        self.warehouseName <- map["warehouseName"]
        self.warehouseCode <- map["warehouseCode"]
        self.quantity <- map["quantity"]
        self.parentCategoryId <- map["parentCategoryId"]
        self.parentCategoryName <- map["parentCategoryName"]
        self.creationTime <- map["creationTime"]
        self.employeeName <- map["employeeName"]
        self.categoryId <- map["categoryId"]
        self.categoryName <- map["categoryName"]
        self.transactionCode <- map["transactionCode"]
        self.paymentMethods <- map["paymentMethods"]
        self.haveSO <- map["haveSO"]
        self.partnerReturnTransactionId <- map["partnerReturnTransactionId"]
    }
}
