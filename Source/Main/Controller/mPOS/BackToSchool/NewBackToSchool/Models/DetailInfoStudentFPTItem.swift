//
//  DetailInfoStudentFPTItem.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

struct DetailInfoStudentFPTItem: Codable {
    let success: String?
    let error: String?
    struct Data: Codable {
        let result: Int?
        let msg: String?
        let iDBackToSchool: Int?
        let allowUploadImg: Int?
        let soBaoDanh: String?
        let hoTen: String?
        let cMND: String?
        let sDT: String?
        let ngaySinh: String?
        let ShipType: Int?
        struct DiemTungMon: Codable {
            let tenMH: String?
            let diem: String?
            private enum CodingKeys: String, CodingKey {
                case tenMH = "TenMH"
                case diem = "Diem"
            }
        }
        let diemTungMon: [DiemTungMon]?
        let diemTrungBinh: String?
        let phanTramGiamGia: String?
        let voucher: String?
        let tinhTrangVoucher: String?
        let urlCMNDMT: String?
        let urlCMNDMS: String?
        let urlGiayBaoThi: String?
        private enum CodingKeys: String, CodingKey {
            case result = "Result"
            case msg = "Msg"
            case iDBackToSchool = "ID_BackToSchool"
            case allowUploadImg = "Allow_UploadImg"
            case soBaoDanh = "SoBaoDanh"
            case hoTen = "HoTen"
            case cMND = "CMND"
            case sDT = "SDT"
            case ngaySinh = "NgaySinh"
            case ShipType = "ShipType"
            case diemTungMon = "DiemTungMon"
            case diemTrungBinh = "DiemTrungBinh"
            case phanTramGiamGia = "PhanTramGiamGia"
            case voucher = "Voucher"
            case tinhTrangVoucher = "TinhTrangVoucher"
            case urlCMNDMT = "Url_CMND_MT"
            case urlCMNDMS = "Url_CMND_MS"
            case urlGiayBaoThi = "Url_GiayBaoThi"
        }
    }
    let data: Data?
    private enum CodingKeys: String, CodingKey {
        case success = "Success"
        case error = "Error"
        case data = "Data"
    }
}
