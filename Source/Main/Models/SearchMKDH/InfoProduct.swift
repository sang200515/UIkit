//
//  InfoProduct.swift
//  fptshop
//
//  Created by Apple on 8/21/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"Vitri": "B-6-3",
//"TenViTri": "B-6-3 Tủ: B, Tầng:6, Hộc:3",
//"ItemCode": "00001003",
//"ItemName": "Apple ĐTDĐ iPhone 5s 16G Gold (A1530)_MF354VN/A"

import UIKit
import SwiftyJSON

class InfoProduct: NSObject {
    
    let Vitri: String
    let TenViTri: String
    let ItemCode: String
    let ItemName: String
    
    init(Vitri: String, TenViTri: String, ItemCode: String, ItemName: String) {
        self.Vitri = Vitri
        self.TenViTri = TenViTri
        self.ItemCode = ItemCode
        self.ItemName = ItemName
    }
    
    class func parseObjfromArray(array:[JSON])->[InfoProduct]{
        var list:[InfoProduct] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> InfoProduct {
        var Vitri = data["Vitri"].string
        var TenViTri = data["TenViTri"].string
        var ItemCode = data["ItemCode"].string
        var ItemName = data["ItemName"].string
        
        Vitri = Vitri == nil ? "" : Vitri
        TenViTri = TenViTri == nil ? "" : TenViTri
        ItemCode = ItemCode == nil ? "" : ItemCode
        ItemName = ItemName == nil ? "" : ItemName
        
        return InfoProduct(Vitri: Vitri!, TenViTri: TenViTri!, ItemCode: ItemCode!, ItemName: ItemName!)
    }
}

class ImgSearchProduct: NSObject {
    
    let Linkanh: String
    let Linkanh_Tu: String
    
    init(Linkanh: String, Linkanh_Tu: String) {
        self.Linkanh = Linkanh
        self.Linkanh_Tu = Linkanh_Tu
    }
    
    class func parseObjfromArray(array:[JSON])->[ImgSearchProduct]{
        var list:[ImgSearchProduct] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ImgSearchProduct {
        var Linkanh = data["Linkanh"].string
        var Linkanh_Tu = data["Linkanh_Tu"].string
        
        Linkanh = Linkanh == nil ? "" : Linkanh
        Linkanh_Tu = Linkanh_Tu == nil ? "" : Linkanh_Tu
        
        return ImgSearchProduct(Linkanh: Linkanh!, Linkanh_Tu:Linkanh_Tu!)
    }
}
