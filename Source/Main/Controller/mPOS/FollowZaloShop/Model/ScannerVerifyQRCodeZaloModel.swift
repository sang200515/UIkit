//
//  ScannerVerifyQRCodeZaloModel.swift
//  fptshop
//
//  Created by KhanhNguyen on 10/22/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

struct ScannerVerifyQRCodeZaloModel: Codable {
    let phonenumber: String?
    let fullname: String?
    let address: String?
    let result: Int?
    let messages: String?
    let gender: String?
}
