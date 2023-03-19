//
//  ViettelPayOrder.swift
//  fptshop
//
//  Created by DiemMy Le on 3/2/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"orderStatus": 2,
//    "orderStatusDisplay": "",
//    "billNo": "3080863749844646186",
//    "customerId": "8e3085b0-8815-4e71-b9ba-5da35a32201c",
//    "referenceSystem": "CRM",
//    "referenceValue": "",
//    "tenant": null,
//    "warehouseCode": "30808",
//    "regionCode": "43",
//    "ip": "10.96.254.227",
//    "orderTransactionDtos": [
//        {
//            "description": "test HT",
//            "productId": "79ef7a15-eefe-4d6d-a816-90df86cd0ad3",
//            "productName": "Nạp tiền tài khoản Viettel Pay",
//            "providerId": "67defced-5f16-4ba9-9db8-5eac8fe9df68",
//            "providerName": null,
//            "categoryId": "e0b79ec6-f263-4473-ab07-97bf6299281a",
//            "categoryName": "Viettel Pay",
//            "sellingPrice": 0.0,
//            "price": 60000.0,
//            "quantity": 1,
//            "totalAmount": 60000.0,
//            "totalAmountIncludingFee": 71000.0,
//            "totalFee": 11000.0,
//            "creationTime": null,
//            "creationBy": null,
//            "integratedGroupCode": "TOPUP",
//            "integratedGroupName": null,
//            "integratedProductCode": "TRANSFER",
//            "integratedProductName": null,
//            "isOfflineTransaction": null,
//            "isExportInvoice": false,
//            "referenceCode": "",
//            "minFee": null,
//            "maxFee": null,
//            "percentFee": null,
//            "constantFee": null,
//            "paymentFeeType": null,
//            "paymentRule": null,
//            "productCustomerCode": "0375217287",
//            "vehicleNumber": "",
//            "productCustomerName": "DuongNT",
//            "productCustomerPhoneNumber": "0375217287",
//            "transactionCode": "6e10930f-b64e-44bd-b99d-93200a18981d",
//            "receiptMethod": "0",
//            "transferMethod": "0",
//            "productCustomerAddress": "",
//            "productCustomerEmailAddress": "",
//            "sender": {
//                "id": "00000000-0000-0000-0000-000000000000",
//                "fullname": "Nguyễn Minh Thương",
//                "idCard": null,
//                "idIssuedOnDate": null,
//                "idIssuedOnPlace": null,
//                "phonenumber": "0396440829",
//                "idCardFrontPhoto": null,
//                "idCardBackPhoto": null,
//                "provinceCode": null,
//                "precinctCode": null,
//                "districtCode": null
//            },
//            "receiver": {
//                "id": "00000000-0000-0000-0000-000000000000",
//                "fullname": "DuongNT",
//                "idCard": null,
//                "idIssuedOnDate": null,
//                "idIssuedOnPlace": null,
//                "phonenumber": "0375217287",
//                "idCardFrontPhoto": null,
//                "idCardBackPhoto": null,
//                "provinceCode": null,
//                "precinctCode": null,
//                "districtCode": null
//            },
//            "licenseKey": null,
//            "productConfigDto": null,
//            "invoices": [],
//            "payments": null,
//            "id": "21ea2f12-a50c-418f-a9ba-0085fc078ae9",
//            "extraProperties": {}
//        }
//    ],
//    "orderHistories": [
//        {
//            "creationTime": "2021-02-25T10:11:11.4294653+07:00",
//            "action": "SUCCESS",
//            "actionDisplay": 2,
//            "description": ""
//        },
//        {
//            "creationTime": "2021-02-25T10:10:46.1862294+07:00",
//            "action": "CREATE",
//            "actionDisplay": 1,
//            "description": ""
//        }
//    ],
//    "customerName": "Nguyễn Minh Thương",
//    "customerPhoneNumber": "0396440829",
//    "employeeName": "15261 - Nguyễn Phúc Hữu",
//    "warehouseAddress": "305 Tô Hiến Thành – Phường 13 - Quân  10  –TPHCM",
//    "payments": [
//        {
//            "paymentType": 1,
//            "paymentCode": null,
//            "paymentCodeDescription": null,
//            "paymentAccountNumber": null,
//            "paymentValue": 71000.00,
//            "bankType": null,
//            "bankTypeDescription": null,
//            "cardType": null,
//            "cardTypeDescription": null,
//            "isCardOnline": false,
//            "paymentExtraFee": 0.00,
//            "paymentPercentFee": 0.0,
//            "isChargeOnCash": false
//        }
//    ],
//    "creationTime": "2021-02-25T03:10:46.186+00:00",
//    "creationBy": "15261",
//    "id": "b6fe01b2-5cb7-755b-8c6d-39fae957b3b2"

import UIKit
import SwiftyJSON

class ViettelPayOrder: NSObject {
    var orderStatus: Int
    var orderStatusDisplay: String
    var billNo: String
    var customerId: String
    var referenceSystem: String
    var referenceValue: String
    var tenant: String
    var warehouseCode: String
    var regionCode: String
    var ip: String
    var creationTime: String
    var creationBy: String
    var id: String
    var customerName: String
    var customerPhoneNumber: String
    var employeeName: String
    var warehouseAddress: String
    var orderTransactionDtos:[ViettelPayOrder_OrderTransactionDtos]
    var orderHistories:[ViettelPayOrder_OrderHistories]
    var payments:[ViettelPayOrder_Payment]

    init( orderStatus: Int,
     orderStatusDisplay: String,
     billNo: String,
     customerId: String,
     referenceSystem: String,
     referenceValue: String,
     tenant: String,
     warehouseCode: String,
     regionCode: String,
     ip: String,
     creationTime: String,
     creationBy: String,
     id: String,
     customerName: String,
     customerPhoneNumber: String,
     employeeName: String,
     warehouseAddress: String,
     orderTransactionDtos:[ViettelPayOrder_OrderTransactionDtos],
     orderHistories:[ViettelPayOrder_OrderHistories],
     payments:[ViettelPayOrder_Payment]) {

        self.orderStatus = orderStatus
        self.orderStatusDisplay = orderStatusDisplay
        self.billNo = billNo
        self.customerId = customerId
        self.referenceSystem = referenceSystem
        self.referenceValue = referenceValue
        self.tenant = tenant
        self.warehouseCode = warehouseCode
        self.regionCode = regionCode
        self.ip = ip
        self.creationTime = creationTime
        self.creationBy = creationBy
        self.id = id
        self.customerName = customerName
        self.customerPhoneNumber = customerPhoneNumber
        self.employeeName = employeeName
        self.warehouseAddress = warehouseAddress
        self.orderTransactionDtos = orderTransactionDtos
        self.orderHistories = orderHistories
        self.payments = payments
    }
    
    class func getObjFromDictionary(data:JSON) -> ViettelPayOrder {
        let orderStatus = data["orderStatus"].intValue
        let orderStatusDisplay = data["orderStatusDisplay"].stringValue
        let billNo = data["billNo"].stringValue
        let customerId = data["customerId"].stringValue
        let referenceSystem = data["referenceSystem"].stringValue
        let referenceValue = data["referenceValue"].stringValue
        let tenant = data["tenant"].stringValue
        let warehouseCode = data["warehouseCode"].stringValue
        let regionCode = data["regionCode"].stringValue
        
        let ip = data["ip"].stringValue
        let creationTime = data["creationTime"].stringValue
        let creationBy = data["creationBy"].stringValue
        let id = data["id"].stringValue
        let customerName = data["customerName"].stringValue
        
        let customerPhoneNumber = data["customerPhoneNumber"].stringValue
        let employeeName = data["employeeName"].stringValue
        let warehouseAddress = data["warehouseAddress"].stringValue
        
        let orderTransactionDtosArrayJson = data["orderTransactionDtos"].arrayValue
        let orderTransactionDtos = ViettelPayOrder_OrderTransactionDtos.parseObjfromArray(array: orderTransactionDtosArrayJson)
        
        let orderHistoriesArrayJson = data["orderHistories"].arrayValue
        let orderHistories = ViettelPayOrder_OrderHistories.parseObjfromArray(array: orderHistoriesArrayJson)
        
        let paymentsArrayJson = data["payments"].arrayValue
        let payments = ViettelPayOrder_Payment.parseObjfromArray(array: paymentsArrayJson)
        
        return ViettelPayOrder(orderStatus: orderStatus, orderStatusDisplay: orderStatusDisplay, billNo: billNo, customerId: customerId, referenceSystem: referenceSystem, referenceValue: referenceValue, tenant: tenant, warehouseCode: warehouseCode, regionCode: regionCode, ip: ip, creationTime: creationTime, creationBy: creationBy, id: id, customerName: customerName, customerPhoneNumber: customerPhoneNumber, employeeName: employeeName, warehouseAddress: warehouseAddress, orderTransactionDtos: orderTransactionDtos, orderHistories: orderHistories, payments: payments)
    }

}

class ViettelPayOrder_OrderTransactionDtos {
    var mDescription: String
    var productId: String
    var productName: String
    var providerId: String
    var providerName: String
    var categoryId: String
    var categoryName: String
    
    var sellingPrice: Double
    var price: Double
    var quantity: Int
    var totalAmount: Double
    var totalAmountIncludingFee: Double
    var totalFee: Double
    
    var creationTime: String
    var creationBy: String
    var integratedGroupCode: String
    var integratedGroupName: String
    var integratedProductCode: String
    var integratedProductName: String
    
    var isOfflineTransaction: Bool
    var isExportInvoice: Bool
    
    var referenceCode: String
    var minFee: Double
    var maxFee: Double
    var percentFee: Double
    var constantFee: Double
    
    var paymentFeeType: String
    var paymentRule: String
    var productCustomerCode: String
    var vehicleNumber: String
    var productCustomerName: String
    var productCustomerPhoneNumber: String
    var transactionCode: String
    var receiptMethod: String
    var transferMethod: String
    var productCustomerAddress: String
    var productCustomerEmailAddress: String
    var sender:ViettelPayOrder_OrderMember
    var receiver:ViettelPayOrder_OrderMember
    var licenseKey: String
    var id: String
    
    
    init(mDescription: String,productId: String,productName: String,providerId: String,providerName: String,categoryId: String,
         categoryName: String,sellingPrice: Double,price: Double,quantity: Int,totalAmount: Double, totalAmountIncludingFee: Double,totalFee: Double,creationTime: String,creationBy: String,integratedGroupCode: String, integratedGroupName: String,integratedProductCode: String,integratedProductName: String,isOfflineTransaction: Bool, isExportInvoice: Bool,referenceCode: String,minFee: Double,maxFee: Double,percentFee: Double, constantFee: Double, paymentFeeType: String,paymentRule: String, productCustomerCode: String, vehicleNumber: String, productCustomerName: String,
         productCustomerPhoneNumber: String, transactionCode: String,receiptMethod: String, transferMethod: String,
         productCustomerAddress: String, productCustomerEmailAddress: String, sender:ViettelPayOrder_OrderMember, receiver:ViettelPayOrder_OrderMember, licenseKey: String, id: String) {
        
        self.mDescription = mDescription
        self.productId = productId
        self.productName = productName
        self.providerId = providerId
        self.providerName = providerName
        self.categoryId = categoryId
        self.categoryName = categoryName
        self.sellingPrice = sellingPrice
        self.price = price
        self.quantity = quantity
        self.totalAmount = totalAmount
        self.totalAmountIncludingFee = totalAmountIncludingFee
        self.totalFee = totalFee
        self.creationTime = creationTime
        self.creationBy = creationBy
        self.integratedGroupCode = integratedGroupCode
        self.integratedGroupName = integratedGroupName
        self.integratedProductCode = integratedProductCode
        self.integratedProductName = integratedProductName
        self.isOfflineTransaction = isOfflineTransaction
        self.isExportInvoice = isExportInvoice
        self.referenceCode = referenceCode
        self.minFee = minFee
        self.maxFee = maxFee
        self.percentFee = percentFee
        self.constantFee = constantFee
        self.paymentFeeType = paymentFeeType
        self.paymentRule = paymentRule
        self.productCustomerCode = productCustomerCode
        self.vehicleNumber = vehicleNumber
        self.productCustomerName = productCustomerName
        self.productCustomerPhoneNumber = productCustomerPhoneNumber
        self.transactionCode = transactionCode
        self.receiptMethod = receiptMethod
        self.transferMethod = transferMethod
        self.productCustomerAddress = productCustomerAddress
        self.productCustomerEmailAddress = productCustomerEmailAddress
        self.sender = sender
        self.receiver = receiver
        self.licenseKey = licenseKey
        self.id = id
    }
    
    class func getObjFromDictionary(data:JSON) -> ViettelPayOrder_OrderTransactionDtos {
        let mDescription = data["description"].stringValue
        let productId = data["productId"].stringValue
        let productName = data["productName"].stringValue
        let providerId = data["providerId"].stringValue
        let providerName = data["providerName"].stringValue
        let categoryId = data["categoryId"].stringValue
        let categoryName = data["categoryName"].stringValue
        
        let sellingPrice = data["sellingPrice"].doubleValue
        let price = data["price"].doubleValue
        let quantity = data["quantity"].intValue
        let totalAmount = data["totalAmount"].doubleValue
        let totalAmountIncludingFee = data["totalAmountIncludingFee"].doubleValue
        let totalFee = data["totalFee"].doubleValue
        
        let creationTime = data["creationTime"].stringValue
        let creationBy = data["creationBy"].stringValue
        let integratedGroupCode = data["integratedGroupCode"].stringValue
        let integratedGroupName = data["integratedGroupName"].stringValue
        let integratedProductCode = data["integratedProductCode"].stringValue
        let integratedProductName = data["integratedProductName"].stringValue
        let isOfflineTransaction = data["isOfflineTransaction"].boolValue
        let isExportInvoice = data["isExportInvoice"].boolValue
        
        let referenceCode = data["referenceCode"].stringValue
        let minFee = data["minFee"].doubleValue
        let maxFee = data["maxFee"].doubleValue
        let percentFee = data["percentFee"].doubleValue
        let constantFee = data["constantFee"].doubleValue
        
        let paymentFeeType = data["paymentFeeType"].stringValue
        let paymentRule = data["paymentRule"].stringValue
        let productCustomerCode = data["productCustomerCode"].stringValue
        let vehicleNumber = data["vehicleNumber"].stringValue
        let productCustomerName = data["productCustomerName"].stringValue
        let productCustomerPhoneNumber = data["productCustomerPhoneNumber"].stringValue
        let transactionCode = data["transactionCode"].stringValue
        let receiptMethod = data["receiptMethod"].stringValue
        let transferMethod = data["transferMethod"].stringValue
        let productCustomerAddress = data["productCustomerAddress"].stringValue
        let productCustomerEmailAddress = data["productCustomerEmailAddress"].stringValue
        
        let sender = ViettelPayOrder_OrderMember.getObjFromDictionary(data: data["sender"])
        let receiver = ViettelPayOrder_OrderMember.getObjFromDictionary(data: data["receiver"])
        let licenseKey = data["licenseKey"].stringValue
        let id = data["id"].stringValue
        
        return ViettelPayOrder_OrderTransactionDtos(mDescription: mDescription, productId: productId, productName: productName, providerId: providerId, providerName: providerName, categoryId: categoryId, categoryName: categoryName, sellingPrice: sellingPrice, price: price, quantity: quantity, totalAmount: totalAmount, totalAmountIncludingFee: totalAmountIncludingFee, totalFee: totalFee, creationTime: creationTime, creationBy: creationBy, integratedGroupCode: integratedGroupCode, integratedGroupName: integratedGroupName, integratedProductCode: integratedProductCode, integratedProductName: integratedProductName, isOfflineTransaction: isOfflineTransaction, isExportInvoice: isExportInvoice, referenceCode: referenceCode, minFee: minFee, maxFee: maxFee, percentFee: percentFee, constantFee: constantFee, paymentFeeType: paymentFeeType, paymentRule: paymentRule, productCustomerCode: productCustomerCode, vehicleNumber: vehicleNumber, productCustomerName: productCustomerName, productCustomerPhoneNumber: productCustomerPhoneNumber, transactionCode: transactionCode, receiptMethod: receiptMethod, transferMethod: transferMethod, productCustomerAddress: productCustomerAddress, productCustomerEmailAddress: productCustomerEmailAddress, sender: sender, receiver: receiver, licenseKey: licenseKey, id: id)
    }
    
    class func parseObjfromArray(array:[JSON])->[ViettelPayOrder_OrderTransactionDtos]{
        var list:[ViettelPayOrder_OrderTransactionDtos] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
}

class ViettelPayOrder_OrderMember {
    var id: String
    var fullname: String
    var idCard: String
    var idIssuedOnDate: String
    var idIssuedOnPlace: String
    var phonenumber: String
    var idCardFrontPhoto: String
    var idCardBackPhoto: String
    var provinceCode: String
    var precinctCode: String
    var districtCode: String
    
    init(id: String, fullname: String, idCard: String, idIssuedOnDate: String, idIssuedOnPlace: String, phonenumber: String, idCardFrontPhoto: String, idCardBackPhoto: String, provinceCode: String, precinctCode: String, districtCode: String) {
        self.id = id
        self.fullname = fullname
        self.idCard = idCard
        self.idIssuedOnDate = idIssuedOnDate
        self.idIssuedOnPlace = idIssuedOnPlace
        self.phonenumber = phonenumber
        self.idCardFrontPhoto = idCardFrontPhoto
        self.idCardBackPhoto = idCardBackPhoto
        self.provinceCode = provinceCode
        self.precinctCode = precinctCode
        self.districtCode = districtCode
    }
    
    class func getObjFromDictionary(data:JSON) -> ViettelPayOrder_OrderMember {
        let id = data["id"].stringValue
        let fullname = data["fullname"].stringValue
        let idCard = data["idCard"].stringValue
        let idIssuedOnDate = data["idIssuedOnDate"].stringValue
        let idIssuedOnPlace = data["idIssuedOnPlace"].stringValue
        let phonenumber = data["phonenumber"].stringValue
        let idCardFrontPhoto = data["idCardFrontPhoto"].stringValue
        let idCardBackPhoto = data["idCardBackPhoto"].stringValue
        let provinceCode = data["provinceCode"].stringValue
        let precinctCode = data["precinctCode"].stringValue
        let districtCode = data["districtCode"].stringValue
        
        return ViettelPayOrder_OrderMember(id: id, fullname: fullname, idCard: idCard, idIssuedOnDate: idIssuedOnDate, idIssuedOnPlace: idIssuedOnPlace, phonenumber: phonenumber, idCardFrontPhoto: idCardFrontPhoto, idCardBackPhoto: idCardBackPhoto, provinceCode: provinceCode, precinctCode: precinctCode, districtCode: districtCode)
    }
}

class ViettelPayOrder_OrderHistories {
    var creationTime: String
    var action: String
    var actionDisplay: Int
    var mDescription: String
    
    init(creationTime: String, action: String, actionDisplay: Int, mDescription: String) {
        self.creationTime = creationTime
        self.action = action
        self.actionDisplay = actionDisplay
        self.mDescription = mDescription
    }
    class func getObjFromDictionary(data:JSON) -> ViettelPayOrder_OrderHistories {
        let creationTime = data["creationTime"].stringValue
        let action = data["action"].stringValue
        let actionDisplay = data["actionDisplay"].intValue
        let mDescription = data["description"].stringValue
        
        return ViettelPayOrder_OrderHistories(creationTime: creationTime, action: action, actionDisplay: actionDisplay, mDescription: mDescription)
    }
    
    class func parseObjfromArray(array:[JSON])->[ViettelPayOrder_OrderHistories]{
        var list:[ViettelPayOrder_OrderHistories] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
}

class ViettelPayOrder_Payment {
    var paymentType: Int
    var paymentCode: String
    var paymentCodeDescription: String
    var paymentAccountNumber: String
    var paymentValue: Double
    var bankType: String
    var bankTypeDescription: String
    var cardType: String
    var cardTypeDescription: String
    var isCardOnline: Bool
    var paymentExtraFee: Double
    var paymentPercentFee: Double
    var isChargeOnCash: Bool
    
    init(paymentType: Int, paymentCode: String, paymentCodeDescription: String, paymentAccountNumber: String, paymentValue: Double, bankType: String, bankTypeDescription: String, cardType: String, cardTypeDescription: String, isCardOnline: Bool, paymentExtraFee: Double, paymentPercentFee: Double, isChargeOnCash: Bool) {
        self.paymentType = paymentType
        self.paymentCode = paymentCode
        self.paymentCodeDescription = paymentCodeDescription
        self.paymentAccountNumber = paymentAccountNumber
        self.paymentValue = paymentValue
        self.bankType = bankType
        self.bankTypeDescription = bankTypeDescription
        self.cardType = cardType
        self.cardTypeDescription = cardTypeDescription
        self.isCardOnline = isCardOnline
        self.paymentExtraFee = paymentExtraFee
        self.paymentPercentFee = paymentPercentFee
        self.isChargeOnCash = isChargeOnCash
    }
    
    class func getObjFromDictionary(data:JSON) -> ViettelPayOrder_Payment {
        
        let paymentType = data["paymentType"].intValue
        let paymentCode = data["paymentCode"].stringValue
        let paymentCodeDescription = data["paymentCodeDescription"].stringValue
        let paymentAccountNumber = data["paymentAccountNumber"].stringValue
        let paymentValue = data["paymentValue"].doubleValue
        
        let bankType = data["bankType"].stringValue
        let bankTypeDescription = data["bankTypeDescription"].stringValue
        let cardType = data["cardType"].stringValue
        let cardTypeDescription = data["cardTypeDescription"].stringValue
        let isCardOnline = data["isCardOnline"].boolValue
        let paymentExtraFee = data["paymentExtraFee"].doubleValue
        let paymentPercentFee = data["paymentPercentFee"].doubleValue
        let isChargeOnCash = data["isChargeOnCash"].boolValue
        
        return ViettelPayOrder_Payment(paymentType: paymentType, paymentCode: paymentCode, paymentCodeDescription: paymentCodeDescription, paymentAccountNumber: paymentAccountNumber, paymentValue: paymentValue, bankType: bankType, bankTypeDescription: bankTypeDescription, cardType: cardType, cardTypeDescription: cardTypeDescription, isCardOnline: isCardOnline, paymentExtraFee: paymentExtraFee, paymentPercentFee: paymentPercentFee, isChargeOnCash: isChargeOnCash)
    }
    
    class func parseObjfromArray(array:[JSON])->[ViettelPayOrder_Payment]{
        var list:[ViettelPayOrder_Payment] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func convertTodict(from list: [ViettelPayOrder_Payment]) -> [[String:Any]] {
        var arrDict_payments = [[String:Any]]()
        var firstItem: [String:Any] = [:]
        for item in list {
            let dict_payments: [String:Any] = ["paymentType": item.paymentType,
                                               "paymentCode": item.paymentCode,
                                               "paymentValue": Int(item.paymentValue),
                                               "bankType": item.bankType,
                                               "cardType": item.cardType,
                                               "paymentExtraFee": Int(item.paymentExtraFee),
                                               "paymentPercentFee": Int(item.paymentPercentFee),
                                               "cardTypeDescription": item.cardTypeDescription,
                                               "bankTypeDescription": item.bankTypeDescription,
                                               "isCardOnline": item.isCardOnline,
                                               "isChargeOnCash": item.isChargeOnCash,
            ]
            if item.paymentType == 1 {
                firstItem = dict_payments
            } else {
                arrDict_payments.append(dict_payments)
            }
        }
        arrDict_payments.insert(firstItem, at: 0)
        return arrDict_payments
    }
}
