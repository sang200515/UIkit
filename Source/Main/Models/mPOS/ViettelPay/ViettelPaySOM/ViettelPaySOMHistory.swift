//
//  ViettelPaySOMHistory.swift
//  fptshop
//
//  Created by DiemMy Le on 3/10/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViettelPaySOMHistory: NSObject {

    let orderId: String
    let billNo: String
    let crmBillNo: String
    let totalAmountIncludingFee: Double
    let customerPhoneNumber: String
    let orderStatus: Int
    let productCustomerCode: String
    let productId: String
    let productName: String
    let warehouseName: String
    let warehouseCode: String
    let quantity: Int
    let parentCategoryId: String
    let parentCategoryName: String
    let creationTime: String
    let employeeName: String
    let categoryId: String
    let categoryName: String
    let payoutNo: String
    let transactionCode: String
    let paymentMethods: String
    let posso: String
    let haveSO: Int
    let partnerReturnTransactionId: String
//    var orderDetail: ViettelPayOrder
    
    init( orderId: String,
          billNo: String,
          crmBillNo: String,
          totalAmountIncludingFee: Double,
          customerPhoneNumber: String,
          orderStatus: Int,
          productCustomerCode: String,
          productId: String,
          productName: String,
          warehouseName: String,
          warehouseCode: String,
          quantity: Int,
          parentCategoryId: String,
          parentCategoryName: String,
          creationTime: String,
          employeeName: String,
          categoryId: String,
          categoryName: String,
          payoutNo: String,
          transactionCode: String,
          paymentMethods: String,
          posso: String,
          haveSO: Int,
          partnerReturnTransactionId: String) {
        
        self.orderId = orderId
        self.billNo = billNo
        self.crmBillNo = crmBillNo
        self.totalAmountIncludingFee = totalAmountIncludingFee
        self.customerPhoneNumber = customerPhoneNumber
        self.orderStatus = orderStatus
        self.productCustomerCode = productCustomerCode
        self.productId = productId
        self.productName = productName
        self.warehouseName = warehouseName
        self.warehouseCode = warehouseCode
        self.quantity = quantity
        self.parentCategoryId = parentCategoryId
        self.parentCategoryName = parentCategoryName
        self.creationTime = creationTime
        self.employeeName = employeeName
        self.categoryId = categoryId
        self.categoryName = categoryName
        self.payoutNo = payoutNo
        self.transactionCode = transactionCode
        self.paymentMethods = paymentMethods
        self.posso = posso
        self.haveSO = haveSO
        self.partnerReturnTransactionId = partnerReturnTransactionId
    }
    
    class func getObjFromDictionary(data:JSON) -> ViettelPaySOMHistory {
        let orderId = data["orderId"].stringValue
        let billNo = data["billNo"].stringValue
        let crmBillNo = data["crmBillNo"].stringValue
        let totalAmountIncludingFee = data["totalAmountIncludingFee"].doubleValue
        let customerPhoneNumber = data["customerPhoneNumber"].stringValue
        
        let orderStatus = data["orderStatus"].intValue
        let productCustomerCode = data["productCustomerCode"].stringValue
        let productId = data["productId"].stringValue
        let productName = data["productName"].stringValue
        let warehouseName = data["warehouseName"].stringValue
        let warehouseCode = data["warehouseCode"].stringValue
        
        let quantity = data["quantity"].intValue
        let parentCategoryId = data["parentCategoryId"].stringValue
        let parentCategoryName = data["warehouseCode"].stringValue
        
        let creationTime = data["creationTime"].stringValue
        let employeeName = data["employeeName"].stringValue
        let categoryId = data["categoryId"].stringValue
        let categoryName = data["categoryName"].stringValue
        
        let payoutNo = data["payoutNo"].stringValue
        let transactionCode = data["transactionCode"].stringValue
        let paymentMethods = data["paymentMethods"].stringValue
        let posso = data["posso"].stringValue
        
        let haveSO = data["haveSO"].intValue
        let partnerReturnTransactionId = data["partnerReturnTransactionId"].stringValue
        
//        let itemOrder = ViettelPayOrder(orderStatus: 0, orderStatusDisplay: "", billNo: "", customerId: "", referenceSystem: "", referenceValue: "", tenant: "", warehouseCode: "", regionCode: "", ip: "", creationTime: "", creationBy: "", id: "", customerName: "", customerPhoneNumber: "", employeeName: "", warehouseAddress: "", orderTransactionDtos: [], orderHistories: [], payments: [])
        
        return ViettelPaySOMHistory( orderId: orderId,
                                     billNo: billNo,
                                     crmBillNo: crmBillNo,
                                     totalAmountIncludingFee: totalAmountIncludingFee,
                                     customerPhoneNumber: customerPhoneNumber,
                                     orderStatus: orderStatus,
                                     productCustomerCode: productCustomerCode,
                                     productId: productId,
                                     productName: productName,
                                     warehouseName: warehouseName,
                                     warehouseCode: warehouseCode,
                                     quantity: quantity,
                                     parentCategoryId: parentCategoryId,
                                     parentCategoryName: parentCategoryName,
                                     creationTime: creationTime,
                                     employeeName: employeeName,
                                     categoryId: categoryId,
                                     categoryName: categoryName,
                                     payoutNo: payoutNo,
                                     transactionCode: transactionCode,
                                     paymentMethods: paymentMethods,
                                     posso: posso,
                                     haveSO: haveSO,
                                     partnerReturnTransactionId: partnerReturnTransactionId)
    }
    class func parseObjfromArray(array:[JSON])->[ViettelPaySOMHistory]{
        var list:[ViettelPaySOMHistory] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
}

