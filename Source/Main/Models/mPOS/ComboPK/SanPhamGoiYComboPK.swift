//
//  SanPhamGoiYComboPK.swift
//  fptshop
//
//  Created by tan on 3/12/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class SanPhamGoiYComboPK: NSObject {
    var Sku:String
    var price:Int
    var UrlPicture:String
    var Name:String
    var DiemThuong:Int
    var tonKho:Int
    
    init(Sku:String
    , price:Int
    , UrlPicture:String
    , Name:String
    , DiemThuong:Int
    , tonKho:Int){
        self.Sku = Sku
        self.price = price
        self.UrlPicture = UrlPicture
        self.Name = Name
        self.DiemThuong = DiemThuong
        self.tonKho = tonKho
    }
    
    class func parseObjfromArray(array:[JSON])->[SanPhamGoiYComboPK]{
        var list:[SanPhamGoiYComboPK] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> SanPhamGoiYComboPK{
        
        var Sku = data["Sku"].string
        var price = data["price"].int
        var UrlPicture  = data["UrlPicture"].string
        var Name = data["Name"].string
        var DiemThuong = data["DiemThuong"].int
        var tonKho = data["tonKho"].int
        
        
        Sku = Sku == nil ? "" : Sku
        price = price == nil ? 0 : price
        UrlPicture = UrlPicture == nil ? "" :UrlPicture
        Name = Name == nil ? "" : Name
        DiemThuong = DiemThuong == nil ? 0 : DiemThuong
        tonKho = tonKho == nil ? 0 : tonKho
        
        return SanPhamGoiYComboPK(Sku: Sku!, price: price!,UrlPicture:UrlPicture!,Name:Name!
            ,DiemThuong:DiemThuong!,tonKho:tonKho!
        )
    }
    
}
