//
//  ListHistoryUserviceItem.swift
//  fptshop
//
//  Created by KhanhNguyen on 9/18/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

struct HistoryUserviceTickeData: Codable {
    let createdTime: String?
    let id: Int?
    let ticketOwnerDisplay: String?
    let service: String?
    let status: String?
    let ticketOwner: String?
    let title: String?
    private enum CodingKeys: String, CodingKey {
        case createdTime = "created_Time"
        case id
        case ticketOwnerDisplay = "ticket_Owner_Display"
        case service
        case status
        case ticketOwner = "ticket_Owner"
        case title
    }
}
