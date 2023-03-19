//
//  VerifyVoucher.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 3/4/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class VerifyVoucher: NSObject {
    var Price: Float // so tien thuc te su dung
    var VC_code: String
    var MaSP: String
    var MenhGia: Float // menh gia voucher
    var TenVC: String
    
    init(Price: Float,VC_code: String, MaSP: String, MenhGia: Float, TenVC: String) {
        self.Price = Price
        self.VC_code = VC_code
        self.MaSP = MaSP
        self.MenhGia = MenhGia
        self.TenVC = TenVC
    }
    class func parseObjfromArray(array:[JSON])->[VerifyVoucher]{
        var list:[VerifyVoucher] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> VerifyVoucher{
        
        var price = data["Price"].float
        var vc_code = data["VC_code"].string
        var maSP = data["MaSP"].string
        var menhGia = data["MenhGia"].float
        var tenVC = data["TenVC"].string
        
        price = price == nil ? 0 : price
        vc_code = vc_code == nil ? "" : vc_code
        maSP = maSP == nil ? "" : maSP
        menhGia = menhGia == nil ? 0 : menhGia
        tenVC = tenVC == nil ? "" : tenVC
        
        return VerifyVoucher(Price: price!,VC_code: vc_code!, MaSP: maSP!, MenhGia: menhGia!, TenVC: tenVC!)
    }
}

