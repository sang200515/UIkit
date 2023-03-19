//
//  ListStudentInfoSearchItem.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

//struct ListStudentInfoSearchItem: Codable {
//    let success: Bool?
//    let message: String?
//
//    let data: [ListStudentInfoSearchData]?
//    private enum CodingKeys: String, CodingKey {
//        case success = "Success"
//        case message = "Message"
//        case data = "Data"
//    }
//}
//
//struct ListStudentInfoSearchData: Codable {
//    let idBackToSchool: Int?
//    let loaiSinhVien: Int?
//    let loaiSinhVienText: String?
//    let hoTen: String?
//    let sDT: String?
//    let cMND: String?
//    let voucher: String?
//    let phanTramGiamGia: Double?
//    let tinhTrangVoucher: String?
//    private enum CodingKeys: String, CodingKey {
//        case idBackToSchool = "Id_BackToSchool"
//        case loaiSinhVien = "LoaiSinhVien"
//        case loaiSinhVienText = "LoaiSinhVien_Text"
//        case hoTen = "HoTen"
//        case sDT = "SDT"
//        case cMND = "CMND"
//        case voucher = "Voucher"
//        case phanTramGiamGia = "PhanTramGiamGia"
//        case tinhTrangVoucher = "TinhTrangVoucher"
//    }
//}

struct ListStudentInfoSearchItem: Codable {
    let success: Bool?
    let message: String?
    struct Data: Codable {
        let idBackToSchool: Int?
        let loaiSinhVien: Int?
        let loaiSinhVienText: String?
        let hoTen: String?
        let sDT: String?
        let cMND: String?
        let voucher: String?
        let phanTramGiamGia: Double?
        let tinhTrangVoucher: String?
        private enum CodingKeys: String, CodingKey {
            case idBackToSchool = "Id_BackToSchool"
            case loaiSinhVien = "LoaiSinhVien"
            case loaiSinhVienText = "LoaiSinhVien_Text"
            case hoTen = "HoTen"
            case sDT = "SDT"
            case cMND = "CMND"
            case voucher = "Voucher"
            case phanTramGiamGia = "PhanTramGiamGia"
            case tinhTrangVoucher = "TinhTrangVoucher"
        }
    }
    let data: [Data]?
    private enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
}
