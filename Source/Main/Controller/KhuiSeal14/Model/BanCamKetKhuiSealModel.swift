//
//  BanCamKetKhuiSealModel.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 18/10/2022.
//

import Foundation

class BanCamKetKhuiSealModel: Codable {
    var status: Int?
    var mess: String?
    var id: Int?
    var nameCustomer, cmnd, ngayCap, noiCap: String?
    var phone, sanPham, noiDungCamKet, urlChuKyKhachHang: String?
    var buttonOTP, buttonHoanTatBienBan, buttonKhachHangKhuiSeal: Button?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case mess = "Mess"
        case id = "Id"
        case nameCustomer = "NameCustomer"
        case cmnd = "CMND"
        case ngayCap = "NgayCap"
        case noiCap = "NoiCap"
        case phone = "Phone"
        case sanPham = "SanPham"
        case noiDungCamKet = "NoiDungCamKet"
        case urlChuKyKhachHang = "UrlChuKyKhachHang"
        case buttonOTP = "ButtonOTP"
        case buttonHoanTatBienBan = "ButtonHoanTatBienBan"
        case buttonKhachHangKhuiSeal = "ButtonKhachHangKhuiSeal"
    }
    
}

struct KhuiSealOTPModel: Codable {
    var status: Int?
    var mess: String?
    var idOtp: Int?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case mess = "Mess"
        case idOtp = "ID_OTP"
    }
}

struct UploadImageSealModel: Codable {
    let success: Bool?
    let message: String?
    let url: String?
}

struct Button: Codable {
    let text: String?
    let value: Bool?

    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case value = "Value"
    }
}
