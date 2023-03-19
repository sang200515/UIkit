//
//  MoMo.swift
//  fptshop
//
//  Created by Ngo Dang tan on 27/01/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
// MARK: - PermissionMoMo
struct PermissionMoMo: Codable {
    let detail: String?
    let data: DataClass?
    let code: String?

    enum CodingKeys: String, CodingKey {
        case detail = "Detail"
        case data = "Data"
        case code = "Code"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let pStatus: Int?
    let pMessages: String?

    enum CodingKeys: String, CodingKey {
        case pStatus = "p_status"
        case pMessages = "p_messages"
    }
}
// MARK: - InfoProviderSOMResponse
struct InfoProviderSOMResponse: Codable {
    var name: String = ""
    let results: [InfoProviderSOMResult]?



}
struct InfoProviderSOMResult:Codable {
    let integratedProductCode: String?
    let integratedGroupCode: String?
    let productId:String?
    let providerId:String?
    var categoryIds:String?
    
    enum CodingKeys: String, CodingKey {
        case integratedProductCode
        case integratedGroupCode
        case productId,providerId,categoryIds
    }
    
    
}

// MARK: - InfoCustomerMoMo
struct InfoCustomerMoMo: Codable {
    let integrationInfo : IntegrationInfo?
    let subject : Subject?
    var amount : Double?
    let fee : Double?
    let goodToProceed : Bool?
    let extraProperties : ExtraProperties?

    enum CodingKeys: String, CodingKey {

        case integrationInfo = "integrationInfo"
        case subject = "subject"
        case amount = "amount"
        case fee = "fee"
        case goodToProceed = "goodToProceed"
        case extraProperties = "extraProperties"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        integrationInfo = try values.decodeIfPresent(IntegrationInfo.self, forKey: .integrationInfo)
        subject = try values.decodeIfPresent(Subject.self, forKey: .subject)
        amount = try values.decodeIfPresent(Double.self, forKey: .amount)
        fee = try values.decodeIfPresent(Double.self, forKey: .fee)
        goodToProceed = try values.decodeIfPresent(Bool.self, forKey: .goodToProceed)
        extraProperties = try values.decodeIfPresent(ExtraProperties.self, forKey: .extraProperties)
    }
}


// MARK: - IntegrationInfo
struct IntegrationInfo : Codable {
    let requestId : String?
    let responseId : String?
    let returnedCode : String?
    let returnedMessage : String?

    enum CodingKeys: String, CodingKey {

        case requestId = "requestId"
        case responseId = "responseId"
        case returnedCode = "returnedCode"
        case returnedMessage = "returnedMessage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        requestId = try values.decodeIfPresent(String.self, forKey: .requestId)
        responseId = try values.decodeIfPresent(String.self, forKey: .responseId)
        returnedCode = try values.decodeIfPresent(String.self, forKey: .returnedCode)
        returnedMessage = try values.decodeIfPresent(String.self, forKey: .returnedMessage)
    }

}

struct ExtraProperties : Codable {
    let isNonBank : Bool?

    enum CodingKeys: String, CodingKey {

        case isNonBank = "isNonBank"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isNonBank = try values.decodeIfPresent(Bool.self, forKey: .isNonBank)
    }

}

struct Subject : Codable {
    let id : String?
    let idCardNumber : String?
    let name : String?
    let phoneNumber : String?
    let emailAddress : String?
    let address : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case idCardNumber = "idCardNumber"
        case name = "name"
        case phoneNumber = "phoneNumber"
        case emailAddress = "emailAddress"
        case address = "address"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        idCardNumber = try values.decodeIfPresent(String.self, forKey: .idCardNumber)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        emailAddress = try values.decodeIfPresent(String.self, forKey: .emailAddress)
        address = try values.decodeIfPresent(String.self, forKey: .address)
    }

}

// MARK: - Subject
struct SubjectMoMo: Codable {
    let phoneNumber: String?
    var id, address: String?
    let name: String?
    let idCardNumber: String?
    let emailAddress: String?
}
//
// MARK: - OrderSOM
struct OrderSOM: Codable {
    let id, customerID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customerId"
    }
}
