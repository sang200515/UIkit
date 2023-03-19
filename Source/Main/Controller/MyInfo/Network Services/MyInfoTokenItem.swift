//
//  MyInfoTokenItem.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

struct MyInfoLoginItem : Codable {
    
    let accessToken : String?
    let expiresIn : String?
    let idToken : String?
    let user : LoginBetaItemUser?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case idToken = "id_token"
        case user = "user"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
        expiresIn = try values.decodeIfPresent(String.self, forKey: .expiresIn)
        idToken = try values.decodeIfPresent(String.self, forKey: .idToken)
        user = try LoginBetaItemUser(from: decoder)
    }
}
struct LoginBetaItemUser : Codable {
    
    let id : String?
    let username : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "username"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        username = try values.decodeIfPresent(String.self, forKey: .username)
    }
    
}
