//
//  ThuHoSOMPrintBill.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 11/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class ThuHoSOMPrintBill: Mappable {
    var detail: [ThuHoSOMPrintBillDetail] = []
    var header: ThuHoSOMPrintBillHeader = ThuHoSOMPrintBillHeader(JSON: [:])!

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.detail <- map["Detail"]
        self.header <- map["Header"]
    }
}

class ThuHoSOMPrintBillDetail: Mappable {
    var stt: String = ""
    var name: String = ""
    var value: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.stt <- map["STT"]
        self.name <- map["Name"]
        self.value <- map["Value"]
    }
}

class ThuHoSOMPrintBillHeader: Mappable {
    var billCode: String = ""
    var transactionCode: String = ""
    var serviceName: String = ""
    var providerName: String = ""
    var total: String = ""
    var employeeName: String = ""
    var createBy: String = ""
    var shopAddress: String = ""
    var time: String = ""
    var voucherCode: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.billCode <- map["BillCode"]
        self.transactionCode <- map["TransactionCode"]
        self.serviceName <- map["ServiceName"]
        self.providerName <- map["ProVideName"]
        self.total <- map["TongTienThanhToan"]
        self.employeeName <- map["Employname"]
        self.createBy <- map["Createby"]
        self.shopAddress <- map["ShopAddress"]
        self.time <- map["ThoiGianXuat"]
        self.voucherCode <- map["MaVoucher"]
    }
}
