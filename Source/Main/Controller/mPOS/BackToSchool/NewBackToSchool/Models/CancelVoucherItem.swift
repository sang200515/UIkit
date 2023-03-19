//
//  CancelVoucherItem.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

struct CancelVoucherItem: Codable {
    let success: Bool?
    let message: String?
    struct Data: Codable {
        let result: Int?
        let msg: String?
        private enum CodingKeys: String, CodingKey {
            case result = "Result"
            case msg = "Msg"
        }
    }
    let data: Data?
    private enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
}
