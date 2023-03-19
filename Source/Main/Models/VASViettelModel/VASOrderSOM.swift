//
//  VASOrderSOM.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 08/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit


struct VASOrderSOM : Codable {
    let orderStatus : Int?
    let orderStatusDisplay : String?
    let billNo : String?
    let customerId : String?
    let referenceSystem : String?
    let referenceValue : String?
    let tenant : String?
    let warehouseCode : String?
    let regionCode : String?
    let ip : String?
    let orderTransactionDtos : [OrderTransactionDtoss]?
    let orderHistories : String?
    let customerName : String?
    let customerPhoneNumber : String?
    let employeeName : String?
    let warehouseAddress : String?
    let payments : [Paymentss]?
    let creationTime : String?
    let creationBy : String?
    let id : String?
}


struct ExtraPropertiess : Codable {
    let referenceIntegrationInfo : ReferenceIntegrationInfos?
    let warehouseName : String?
    let otp : String?
}

struct OrderTransactionDtoss : Codable {
    let description : String?
    let productId : String?
    let productName : String?
    let providerId : String?
    let providerName : String?
    let categoryId : String?
    let categoryName : String?
    let sellingPrice : Double?
    let price : Double?
    let quantity : Int?
    let totalAmount : Double?
    let totalAmountIncludingFee : Double?
    let totalFee : Double?
    let creationTime : String?
    let creationBy : String?
    let integratedGroupCode : String?
    let integratedGroupName : String?
    let integratedProductCode : String?
    let integratedProductName : String?
    let isOfflineTransaction : Bool?
    let isExportInvoice : Bool?
    let referenceCode : String?
    let minFee : Double?
    let maxFee : Double?
    let percentFee : Double?
    let constantFee : Double?
    let paymentFeeType : Int?
    let paymentRule : Int?
    let productCustomerCode : String?
    let vehicleNumber : String?
    let productCustomerName : String?
    let productCustomerPhoneNumber : String?
    let transactionCode : String?
    let receiptMethod : String?
    let transferMethod : String?
    let productCustomerAddress : String?
    let productCustomerEmailAddress : String?
    let sender : Senders?
    let receiver : Receivers?
    let licenseKey : String?
    let productConfigDto : ProductConfigDtos?
    let invoices : [String]?
    let payments : String?
    let id : String?
    let extraProperties : ExtraPropertiess?
}

struct Paymentss : Codable {
    let paymentType : Int?
    let paymentCode : String?
    let paymentCodeDescription : String?
    let paymentAccountNumber : String?
    let paymentValue : Double?
    let bankType : String?
    let bankTypeDescription : String?
    let cardType : String?
    let cardTypeDescription : String?
    let isCardOnline : Bool?
    let paymentExtraFee : Double?
    let paymentPercentFee : Double?
    let isChargeOnCash : Bool?
}

struct ProductConfigDtos : Codable {
    let checkInventory : Bool?
}

struct Receivers : Codable {
    let id : String?
    let fullname : String?
    let idCard : String?
    let idIssuedOnDate : String?
    let idIssuedOnPlace : String?
    let phonenumber : String?
    let idCardFrontPhoto : String?
    let idCardBackPhoto : String?
    let provinceCode : String?
    let precinctCode : String?
    let districtCode : String?

   
}


struct ReferenceIntegrationInfos : Codable {
    let requestId : String?
    let responseId : String?
}

struct Senders : Codable {
    let id : String?
    let fullname : String?
    let idCard : String?
    let idIssuedOnDate : String?
    let idIssuedOnPlace : String?
    let phonenumber : String?
    let idCardFrontPhoto : String?
    let idCardBackPhoto : String?
    let provinceCode : String?
    let precinctCode : String?
    let districtCode : String?
}
