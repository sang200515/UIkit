//
//  SellTodayItem.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/22/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

struct SellTodayItem: Codable {
    let categoryAlertName : String?
    let contentText : String?
    let title : String?
    
    enum CodingKeys: String, CodingKey {
        case categoryAlertName = "categoryAlertName"
        case contentText = "contentText"
        case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryAlertName = try values.decodeIfPresent(String.self, forKey: .categoryAlertName)
        contentText = try values.decodeIfPresent(String.self, forKey: .contentText)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}
