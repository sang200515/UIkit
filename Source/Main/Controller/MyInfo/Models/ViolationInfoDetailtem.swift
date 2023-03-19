//
//  ViolationDetailItem.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/29/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit


struct ViolationInfoDetailItem: Codable {
    let info: InfoViolationItem?
    let conversations: [Conversations]?
}

struct InfoViolationItem: Codable {
     let phieuPhat: Int?
     let ngayTao: String?
     let trangThai: String?
     let quyTrinh: String?
     let mucDoXuLy: String?
     let soLanLap: Int?
     let soTienPhatCongPhatThem: String?
     let phanTramTruINC: String? //TODO: Specify the type to conforms Codable protocol
     let thang: String?
     let nguoiGhiNhan: String?
     let noiDungKiemTra: String?
     let noiDungViPham: String?
     let huongDan: String?
     let phanHoiDongY: Int?
     let phanHoiTuChoi: String?
 }

struct Conversations: Codable {
    let empCodeName: String?
    let ngay: String?
    let noiDung: String?
    let type: Int?
}
