//
//  DanhSachCamKetModel.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 17/10/2022.
//

import Foundation

class DanhSachCamKetModel: Codable {
    let id: Int?
    let nameCustomer, cmnd, phone, dateSign: String?
    let statusName: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case nameCustomer = "NameCustomer"
        case cmnd = "CMND"
        case phone = "Phone"
        case dateSign = "DateSign"
        case statusName = "StatusName"
    }
}

