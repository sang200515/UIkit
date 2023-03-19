//
//  ViolationItem.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/28/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

struct ViolationItem : Codable {
    
    var isExpanded: Bool = false
    let group : Int?
    let groupName : String?
    var items : [ViolationDetailItem]?
    let soTienPhat : String?
    let stt : Int?
    
    enum CodingKeys: String, CodingKey {
        case group = "group"
        case groupName = "groupName"
        case items = "items"
        case soTienPhat = "soTienPhat"
        case stt = "stt"
    }
    
     init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        group = try values.decodeIfPresent(Int.self, forKey: .group)
        groupName = try values.decodeIfPresent(String.self, forKey: .groupName)
        items = try values.decodeIfPresent([ViolationDetailItem].self, forKey: .items)
        soTienPhat = try values.decodeIfPresent(String.self, forKey: .soTienPhat)
        stt = try values.decodeIfPresent(Int.self, forKey: .stt)
    }
    
}

struct ViolationDetailItem : Codable {
    
    let ghiNhan : String?
    let mucDoXuLy : String?
    let ngay : String?
    let soPhieu : Int?
    let soTienPhat : String?
    let stt : Int?
    let trangThai : String?
    
    enum CodingKeys: String, CodingKey {
        case ghiNhan = "ghiNhan"
        case mucDoXuLy = "mucDoXuLy"
        case ngay = "ngay"
        case soPhieu = "soPhieu"
        case soTienPhat = "soTienPhat"
        case stt = "stt"
        case trangThai = "trangThai"
    }
    
     init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ghiNhan = try values.decodeIfPresent(String.self, forKey: .ghiNhan)
        mucDoXuLy = try values.decodeIfPresent(String.self, forKey: .mucDoXuLy)
        ngay = try values.decodeIfPresent(String.self, forKey: .ngay)
        soPhieu = try values.decodeIfPresent(Int.self, forKey: .soPhieu)
        soTienPhat = try values.decodeIfPresent(String.self, forKey: .soTienPhat)
        stt = try values.decodeIfPresent(Int.self, forKey: .stt)
        trangThai = try values.decodeIfPresent(String.self, forKey: .trangThai)
    }
    
}
