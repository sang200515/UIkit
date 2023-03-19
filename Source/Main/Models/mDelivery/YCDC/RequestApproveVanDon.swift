//
//  RequestApproveVanDon.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 02/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct RequestApproveVanDon: Encodable
{
    var userCode: String
    var userName: String
    var os: String
    var listBill: [BodyRequestApproveVanDon]
}
struct BodyRequestApproveVanDon: Encodable
{
    var duyet: Bool
    var soBillFRT: String
    var ghiChu: String
}
