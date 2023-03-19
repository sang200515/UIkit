//
//  ProductInStock.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/5/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ProductInStock: NSObject {
    var Kho: String
    var MaSP: String
    var TonKho: Int
    var TenSP: String
    
    init(Kho: String, MaSP: String,TenSP: String, TonKho: Int) {
        self.Kho = Kho
        self.MaSP = MaSP
        self.TenSP = TenSP
        self.TonKho = TonKho
        
    }
    class func parseObjfromArray(array:[JSON])->[ProductInStock]{
        var list:[ProductInStock] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ProductInStock{
        
        var kho = data["Kho"].string
        var maSP = data["MaSP"].string
        var tenSP = data["TenSP"].string
        var tonKho = data["TonKho"].int
        
        kho = kho == nil ? "" : kho
        maSP = maSP == nil ? "" : maSP
        tenSP = tenSP == nil ? "" : tenSP
        tonKho = tonKho == nil ? 0 : tonKho
        
        return ProductInStock(Kho: kho!, MaSP: maSP!,TenSP: tenSP!, TonKho: tonKho!)
    }
}
