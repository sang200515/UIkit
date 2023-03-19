//
//  NewCheckVersionModel.swift
//  fptshop
//
//  Created by KhanhNguyen on 10/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

struct NewCheckVersionModelRoot: Codable {
    let success: Bool?
    let data: NewCheckVersionModelDatum?
    private enum CodingKeys: String, CodingKey {
        case success = "Success"
        case data = "Data"
    }
}

struct NewCheckVersionModelDatum: Codable {
    let version: String?
    let listModule: String?
    let descriptions: String?
    let isGateway: Int?
    let isUpdateApp: Int?
    private enum CodingKeys: String, CodingKey {
        case version
        case listModule = "list_module"
        case descriptions
        case isGateway = "is_gateway"
        case isUpdateApp = "is_update_app"
    }
}
