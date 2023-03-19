//
//  TotalINCItem.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/25/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

struct TotalINCItem : Codable {
    
    var children : [Child]?
    let title : String?
    let type : String?
    let value : String?
    
    enum CodingKeys: String, CodingKey {
        case children = "children"
        case title = "title"
        case type = "type"
        case value = "value"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        children = try values.decodeIfPresent([Child].self, forKey: .children)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }
    
}

struct Child : Codable {
    
    var children : [Child]?
    let title : String?
    let type : String?
    let value : String?
    var isExpanded: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case children = "children"
        case title = "title"
        case type = "type"
        case value = "value"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        children = try values.decodeIfPresent([Child].self, forKey: .children)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }
    
}

