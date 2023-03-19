//
//  ViettelPayNapTien.swift
//  fptshop
//
//  Created by DiemMy Le on 3/2/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"integrationInfo": {
//    "requestId": "94606a93-a2b5-4145-9409-71b2d1696f23",
//    "responseId": null,
//    "returnedCode": null,
//    "returnedMessage": null
//  },
//  "subject": {
//    "id": "0375217287",
//    "idCardNumber": null,
//    "name": "DuongNT",
//    "phoneNumber": "0375217287",
//    "emailAddress": null,
//    "address": null
//  },
//  "amount": null,
//  "fee": null,
//  "goodToProceed": true,
//  "extraProperties": {
//    "keyOtpFee": "94606a93-a2b5-4145-9409-71b2d1696f230375217287"
//  }

import UIKit
import SwiftyJSON

class ViettelPayNapTien: NSObject {
    let integrationInfo: ViettelPayNapTien_IntegrationInfo
    let subject: ViettelPayNapTien_Subject
    let amount: Double
    let fee: Double
    let goodToProceed: Bool
    let keyOtpFee: String
    
    init(integrationInfo: ViettelPayNapTien_IntegrationInfo, subject: ViettelPayNapTien_Subject, amount: Double, fee: Double, goodToProceed: Bool, keyOtpFee: String) {
        self.integrationInfo = integrationInfo
        self.subject = subject
        self.amount = amount
        self.fee = fee
        self.goodToProceed = goodToProceed
        self.keyOtpFee = keyOtpFee
    }
    
    class func getObjFromDictionary(data:JSON) -> ViettelPayNapTien {
        let integrationInfo = ViettelPayNapTien_IntegrationInfo.getObjFromDictionary(data: data["integrationInfo"])
        let subject = ViettelPayNapTien_Subject.getObjFromDictionary(data: data["subject"])
        let amount = data["amount"].doubleValue
        let fee = data["fee"].doubleValue
        let goodToProceed = data["goodToProceed"].boolValue
        
        let extraProperties = data["extraProperties"]
        let keyOtpFee = extraProperties["keyOtpFee"].stringValue
        
        return ViettelPayNapTien(integrationInfo: integrationInfo, subject: subject, amount: amount, fee: fee, goodToProceed: goodToProceed, keyOtpFee: keyOtpFee)
    }
}

class ViettelPayNapTien_IntegrationInfo {
    let requestId: String
    let responseId: String
    let returnedCode: String
    let returnedMessage: String
    
    init(requestId: String, responseId: String, returnedCode: String, returnedMessage: String) {
        self.requestId = requestId
        self.responseId = responseId
        self.returnedCode = returnedCode
        self.returnedMessage = returnedMessage
    }
    
    class func getObjFromDictionary(data:JSON) -> ViettelPayNapTien_IntegrationInfo {
        let requestId = data["requestId"].stringValue
        let responseId = data["responseId"].stringValue
        let returnedCode = data["returnedCode"].stringValue
        let returnedMessage = data["returnedMessage"].stringValue
        
        return ViettelPayNapTien_IntegrationInfo(requestId: requestId, responseId: responseId, returnedCode: returnedCode, returnedMessage: returnedMessage)
    }
}

class ViettelPayNapTien_Subject {
    let id: String
    let idCardNumber: String
    let name: String
    let phoneNumber: String
    let emailAddress: String
    let address: String
    
    init(id: String, idCardNumber: String, name: String, phoneNumber: String, emailAddress: String, address: String) {
        self.id = id
        self.idCardNumber = idCardNumber
        self.name = name
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
        self.address = address
    }
    
    class func getObjFromDictionary(data:JSON) -> ViettelPayNapTien_Subject {
        let id = data["id"].stringValue
        let idCardNumber = data["idCardNumber"].stringValue
        let name = data["name"].stringValue
        let phoneNumber = data["phoneNumber"].stringValue
        let emailAddress = data["emailAddress"].stringValue
        let address = data["address"].stringValue
        
        return ViettelPayNapTien_Subject(id: id, idCardNumber: idCardNumber, name: name, phoneNumber: phoneNumber, emailAddress: emailAddress, address: address)
    }
}
