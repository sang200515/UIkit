//
//  ThuHoSOMHistory.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 24/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class ThuHoSOMHistory: Mappable {
    var orderID: String = ""
    var billNo: String = ""
    var crmBillNo: String = ""
    var totalAmountIncludingFee: Int = 0
    var customerPhoneNumber: String = ""
    var orderStatus: Int = 0
    var productCustomerCode: String = ""
    var productID: String = ""
    var productName: String = ""
    var warehouseName: String = ""
    var warehouseCode: String = ""
    var quantity: Int = 0
    var parentCategoryID: String = ""
    var parentCategoryName: String = ""
    var creationTime: String = ""
    var employeeName: String = ""
    var categoryID: String = ""
    var categoryName: String = ""
    var payoutNo: String = ""
    var transactionCode: String = ""
    var paymentMethods: String = ""
    var posso: String = ""
    var haveSO: Int = 0
    var partnerReturnTransactionID: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.orderID <- map["orderId"]
        self.billNo <- map["billNo"]
        self.crmBillNo <- map["crmBillNo"]
        self.totalAmountIncludingFee <- map["totalAmountIncludingFee"]
        self.customerPhoneNumber <- map["customerPhoneNumber"]
        self.orderStatus <- map["orderStatus"]
        self.productCustomerCode <- map["productCustomerCode"]
        self.productID <- map["productId"]
        self.productName <- map["productName"]
        self.warehouseName <- map["warehouseName"]
        self.warehouseCode <- map["warehouseCode"]
        self.quantity <- map["quantity"]
        self.parentCategoryID <- map["parentCategoryId"]
        self.parentCategoryName <- map["parentCategoryName"]
        self.creationTime <- map["creationTime"]
        self.employeeName <- map["employeeName"]
        self.categoryID <- map["categoryId"]
        self.categoryName <- map["categoryName"]
        self.payoutNo <- map["payoutNo"]
        self.transactionCode <- map["transactionCode"]
        self.paymentMethods <- map["paymentMethods"]
        self.posso <- map["posso"]
        self.haveSO <- map["haveSO"]
        self.partnerReturnTransactionID <- map["partnerReturnTransactionId"]
    }
}
