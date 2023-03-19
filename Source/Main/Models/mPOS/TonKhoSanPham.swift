//
//  TonKhoSanPham.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 3/1/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class TonKhoSanPham: NSObject {
    
    var itemcode: String
    var whscode: String
    var whsname: String
    var tonkho: Int
    
    init(itemcode: String, whscode: String, whsname: String, tonkho: Int){
        self.itemcode = itemcode
        self.whscode = whscode
        self.whsname = whsname
        self.tonkho = tonkho
    }
    class func parseObjfromArray(array:[JSON])->[TonKhoSanPham]{
        var list:[TonKhoSanPham] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> TonKhoSanPham{
        
        var itemcode = data["itemcode"].string
        var whscode = data["whscode"].string
        var whsname = data["whsname"].string
        var tonkho = data["tonkho"].int
        
        itemcode = itemcode == nil ? "" : itemcode
        whscode = whscode == nil ? "" : whscode
        whsname = whsname == nil ? "" : whsname
        tonkho = tonkho == nil ? 0 : tonkho
        
        return TonKhoSanPham(itemcode: itemcode!, whscode: whscode!, whsname: whsname!, tonkho: tonkho!)
    }
    
}
