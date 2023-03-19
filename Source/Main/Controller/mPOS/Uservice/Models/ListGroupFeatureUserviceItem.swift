//
//  ListGroupFeatureUserviceItem.swift
//  fptshop
//
//  Created by KhanhNguyen on 9/15/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation


//struct ListFeatureItem {
//    let chucNang: String
//}
//
//struct ListGroupFeatureUserviceItem : Codable {
//
//        let pData : [ListFeatureItemPDatum]?
//        let pMessages : String?
//        let pStatus : Int?
//
//        enum CodingKeys: String, CodingKey {
//                case pData = "p_data"
//                case pMessages = "p_messages"
//                case pStatus = "p_status"
//        }
//
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                pData = try values.decodeIfPresent([ListFeatureItemPDatum].self, forKey: .pData)
//                pMessages = try values.decodeIfPresent(String.self, forKey: .pMessages)
//                pStatus = try values.decodeIfPresent(Int.self, forKey: .pStatus)
//        }
//
//}
//
//struct ListFeatureItemPDatum : Codable {
//
//        let chucNang : String?
//        let idNhomChucNang : String?
//        let tenNhomChucNang : String?
//
//        enum CodingKeys: String, CodingKey {
//                case chucNang = "chucNang"
//                case idNhomChucNang = "idNhomChucNang"
//                case tenNhomChucNang = "tenNhomChucNang"
//        }
//
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                chucNang = try values.decodeIfPresent(String.self, forKey: .chucNang)
//                idNhomChucNang = try values.decodeIfPresent(String.self, forKey: .idNhomChucNang)
//                tenNhomChucNang = try values.decodeIfPresent(String.self, forKey: .tenNhomChucNang)
//        }
//
//}

struct ListFeatureItemPDatum: Codable {
    let chucNang: String
    let idNhomChucNang: Int
    let tenNhomChucNang: String
}
