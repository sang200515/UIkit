//
//  DetailTotalTimeWorkInMonthItem.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/26/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

struct DetailTotalTimeWorkInMontItem : Codable {
    
    let donGiaGioCongs : [DonGiaGioCong]?
    let gioCongDuyets : [GioCongDuyet]?
    
    enum CodingKeys: String, CodingKey {
        case donGiaGioCongs = "donGiaGioCongs"
        case gioCongDuyets = "gioCongDuyets"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        donGiaGioCongs = try values.decodeIfPresent([DonGiaGioCong].self, forKey: .donGiaGioCongs)
        gioCongDuyets = try values.decodeIfPresent([GioCongDuyet].self, forKey: .gioCongDuyets)
    }
    
}

struct DonGiaGioCong : Codable {
    
    let title : String?
    let value : String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case value = "value"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }
    
}

struct GioCongDuyet : Codable {
    
    let donGiaGioCong : String?
    let duyetGioRa : String?
    let duyetGioVao : String?
    let employeeCode : String?
    let gioChamCongRa : String?
    let gioChamCongVao : String?
    let luongGioCong : String?
    let ngay : String?
    let soGioCongDuocDuyet : String?
    let tenCa : String?
    
    enum CodingKeys: String, CodingKey {
        case donGiaGioCong = "donGiaGioCong"
        case duyetGioRa = "duyetGioRa"
        case duyetGioVao = "duyetGioVao"
        case employeeCode = "employeeCode"
        case gioChamCongRa = "gioChamCongRa"
        case gioChamCongVao = "gioChamCongVao"
        case luongGioCong = "luongGioCong"
        case ngay = "ngay"
        case soGioCongDuocDuyet = "soGioCongDuocDuyet"
        case tenCa = "tenCa"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        donGiaGioCong = try values.decodeIfPresent(String.self, forKey: .donGiaGioCong)
        duyetGioRa = try values.decodeIfPresent(String.self, forKey: .duyetGioRa)
        duyetGioVao = try values.decodeIfPresent(String.self, forKey: .duyetGioVao)
        employeeCode = try values.decodeIfPresent(String.self, forKey: .employeeCode)
        gioChamCongRa = try values.decodeIfPresent(String.self, forKey: .gioChamCongRa)
        gioChamCongVao = try values.decodeIfPresent(String.self, forKey: .gioChamCongVao)
        luongGioCong = try values.decodeIfPresent(String.self, forKey: .luongGioCong)
        ngay = try values.decodeIfPresent(String.self, forKey: .ngay)
        soGioCongDuocDuyet = try values.decodeIfPresent(String.self, forKey: .soGioCongDuocDuyet)
        tenCa = try values.decodeIfPresent(String.self, forKey: .tenCa)
    }
    
}
