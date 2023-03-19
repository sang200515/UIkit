//
//  HinhMauMayCu.swift
//  fptshop
//
//  Created by DiemMy Le on 4/24/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"typeitem": "DH",
//"typeimage": 1,
//"label": "Ảnh mặt trước",
//"urlimage": "http://imagewarrantybeta.fptshop.com.vn:6789/HinhMauMayCuEcom/DH/1_MatTruoc.jpg"
//"isupload": 1

import UIKit
import SwiftyJSON

class HinhMauMayCu: NSObject {

    let typeimage: Int
    let typeitem: String
    let label: String
    let urlimage: String
    let isupload: Int
    
    init(typeimage: Int, typeitem: String, label: String, urlimage: String, isupload: Int) {
        self.typeimage = typeimage
        self.typeitem = typeitem
        self.label = label
        self.urlimage = urlimage
        self.isupload = isupload
    }
    
    class func parseObjfromArray(array:[JSON])->[HinhMauMayCu]{
        var list:[HinhMauMayCu] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> HinhMauMayCu {
        var typeimage = data["typeimage"].int
        var typeitem = data["typeitem"].string
        var label = data["label"].string
        var urlimage = data["urlimage"].string
        var isupload = data["isupload"].int
        
        typeimage = typeimage == nil ? 0 : typeimage
        typeitem = typeitem == nil ? "" : typeitem
        label = label == nil ? "" : label
        urlimage = urlimage == nil ? "" : urlimage
        isupload = isupload == nil ? 0 : isupload
        
        return HinhMauMayCu(typeimage: typeimage!, typeitem: typeitem!, label: label!, urlimage: urlimage!, isupload: isupload!)
    }
}
