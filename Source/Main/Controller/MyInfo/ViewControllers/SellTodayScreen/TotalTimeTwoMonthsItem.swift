//
//  TotalTimeTwoMonthsItem.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/24/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

struct TotalTimeTwoMonthsItem : Codable {

        let gioCongChuan : String?
        let thang : String?
        let tongGioCongDuyet : String?

        enum CodingKeys: String, CodingKey {
                case gioCongChuan = "gioCongChuan"
                case thang = "thang"
                case tongGioCongDuyet = "tongGioCongDuyet"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                gioCongChuan = try values.decodeIfPresent(String.self, forKey: .gioCongChuan)
                thang = try values.decodeIfPresent(String.self, forKey: .thang)
                tongGioCongDuyet = try values.decodeIfPresent(String.self, forKey: .tongGioCongDuyet)
        }

}
