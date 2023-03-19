//
//  RequestPrintBill.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 01/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct RequestPrintBill: Encodable
{
    var message: RequestMessagePrintBill
}
struct RequestMessagePrintBill: Encodable
{
    var title: String
    var body: String
    var id: String
    var key: String
}
struct RequestBodyPrintBill: Encodable
{
    var Detail: [RequestItemBodyPrintBill]
    var Header: RequestHeaderPrintBill
}
struct RequestItemBodyPrintBill: Encodable
{
    var STT: String
    var Name: String
    var Value: String
}
struct RequestHeaderPrintBill: Encodable
{
    var BillCode: String
    var TransactionCode: String
    var TongTienThanhToan: String
    var ServiceName: String
    var ProVideName: String
    var Employname: String
    var Createby: String
    var ShopAddress: String
    var ThoiGianXuat: String
    var MaVoucher: String
}


struct ResponsePrintBill: Decodable
{
    var result: String
}
