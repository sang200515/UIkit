//
//  ListCustomerFollowZaloModel.swift
//  fptshop
//
//  Created by KhanhNguyen on 10/22/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

struct ListCustomerFollowZaloModel: Codable {
    let senderId: String?
    let senderName: String?
    let channel: String?
    let createdate: String?
    let gender: String?
    let birthday: String?
    let avatar: String?
    private enum CodingKeys: String, CodingKey {
        case senderId = "sender_id"
        case senderName = "sender_name"
        case channel
        case createdate
        case gender
        case birthday
        case avatar
    }
}
