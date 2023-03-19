//
//  InfoSOM.swift
//  fptshop
//
//  Created by Ngo Dang tan on 27/01/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
// MARK: - InfoSOM
struct InfoSOM: Codable {
    let id: String?
    let price, fixedFee, percentFee: String?
    let type: Int?
    let detailArr: DetailsSOM?
    let configArr: [ConfigSOM]?
    let providerIDS: [String]?

    let name, infoSOMDescription: String?
    let code, legacyID: String?
    let enabled: Bool?
    let defaultProviderID: String?
    let categoryIDS: [String]?

    enum CodingKeys: String, CodingKey {
        case id, price, fixedFee, percentFee, type
        case detailArr = "details"
        case configArr = "configs"
        case providerIDS = "providerIds"
        case name
        case infoSOMDescription
        case code
        case legacyID
        case enabled
        case defaultProviderID
        case categoryIDS = "categoryIds"
 
    }
}

// MARK: - Config
struct ConfigSOM: Codable {
    let productId: String?
    let providerID, integratedProductCode, integratedGroupCode: String?
    let allowCardPayment, allowCashPayment, allowVoucherPayment: Bool?

    enum CodingKeys: String, CodingKey {
        case productId
        case providerID = "providerId"
        case integratedProductCode, integratedGroupCode, allowCardPayment, allowCashPayment, allowVoucherPayment
    }
}

// MARK: - Details
struct DetailsSOM: Codable {
    let providerID: String?
    let price, sellingPrice, fixedFee, percentFee: String?
    let type: Int?
    let allowCancel, allowUpdate, checkInventory: Bool
 

    enum CodingKeys: String, CodingKey {
        case providerID
        case price, sellingPrice, fixedFee, percentFee, type, allowCancel, allowUpdate, checkInventory
    }
}
