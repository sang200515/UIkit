//
//  BaoKimHistoryDetail.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 30/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class BaoKimHistoryDetail: Mappable {
    var cardName: String = ""
    var licTradNum: String = ""
    var bookingID: String = ""
    var customerEmail: String = ""
    var sompos: String = ""
    var discount: Int = 0
    var preDoctal: Int = 0
    var doctal: Int = 0
    var frTORDRPROMOS: [BaoKimFrTORDRPROMOS] = []
    var frTRDR1S: [BaoKimFrTRDR1] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.cardName <- map["cardName"]
        self.licTradNum <- map["licTradNum"]
        self.bookingID <- map["bookingId"]
        self.customerEmail <- map["customer_email"]
        self.sompos <- map["sompos"]
        self.discount <- map["discount"]
        self.preDoctal <- map["pre_doctal"]
        self.doctal <- map["doctal"]
        self.frTORDRPROMOS <- map["frT_ORDR_PROMOS"]
        self.frTRDR1S <- map["frT_RDR1S"]
    }
}

class BaoKimFrTORDRPROMOS: Mappable {
    var tienGiam: Int = 0
    var sLTang: Int = 0
    var tenCTKM: String = ""
    var tenSANPhamTang: String = ""
    var sanPhamMUA: String = ""
    var loaiKM: String = ""
    var maCTKM: String = ""
    var sanPhamTang: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.tienGiam <- map["tienGiam"]
        self.sLTang <- map["sL_Tang"]
        self.tenCTKM <- map["tenCTKM"]
        self.tenSANPhamTang <- map["tenSanPham_Tang"]
        self.sanPhamMUA <- map["sanPham_Mua"]
        self.loaiKM <- map["loaiKM"]
        self.maCTKM <- map["maCTKM"]
        self.sanPhamTang <- map["sanPham_Tang"]
    }
}

class BaoKimFrTRDR1: Mappable {
    var itemCode: String = ""
    var description: String = ""
    var quantity: Int = 0
    var priceFisrt: Int = 0

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.itemCode <- map["itemCode"]
        self.description <- map["description"]
        self.quantity <- map["quantity"]
        self.priceFisrt <- map["price_fisrt"]
    }
}
