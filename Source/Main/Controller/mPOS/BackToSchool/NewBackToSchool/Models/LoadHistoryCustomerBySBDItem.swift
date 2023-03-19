//
//  LoadHistoryCustomerBySBDItem.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/25/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

struct LoadHistoryCustomerBySBDItem: Codable {
    let success: Bool?
    let message: String?
    struct Data: Codable {
        let diemSinh: Int?
        let hoTen: String?
        let cMND: String?
        let diemHoa: Int?
        let diemToan: Int?
        let urlGiayBaoThi: String?
        let diemGDCD: Int?
        let phanTramGiamGia: Int?
        let tinhTrangVoucher: String?
        let diemNgoaiNgu: Int?
        let msg: String?
        let ngaySinh: String?
        let sDT: String?
        let urlCMNDMS: String?
        let diemLy: Int?
        let diemDia: Int?
        let diemSu: Int?
        let result: Int?
        let soBaoDanh: String?
        let voucher: String?
        let test: String?
        let urlCMNDMT: String?
        let diemTrungBinh: Int? //TODO: Specify the type to conforms Codable protocol
        let diemVan: Int?
        private enum CodingKeys: String, CodingKey {
            case diemSinh = "DiemSinh"
            case hoTen = "HoTen"
            case cMND = "CMND"
            case diemHoa = "DiemHoa"
            case diemToan = "DiemToan"
            case urlGiayBaoThi = "Url_GiayBaoThi"
            case diemGDCD = "DiemGDCD"
            case phanTramGiamGia = "PhanTramGiamGia"
            case tinhTrangVoucher = "TinhTrangVoucher"
            case diemNgoaiNgu = "DiemNgoaiNgu"
            case msg = "Msg"
            case ngaySinh = "NgaySinh"
            case sDT = "SDT"
            case urlCMNDMS = "Url_CMND_MS"
            case diemLy = "DiemLy"
            case diemDia = "DiemDia"
            case diemSu = "DiemSu"
            case result = "Result"
            case soBaoDanh = "SoBaoDanh"
            case voucher = "Voucher"
            case test = "Test"
            case urlCMNDMT = "Url_CMND_MT"
            case diemTrungBinh = "DiemTrungBinh"
            case diemVan = "DiemVan"
        }
    }
    let data: [Data]?
    private enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
}
