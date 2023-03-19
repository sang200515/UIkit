//
//  ImageMayDemoBH.swift
//  fptshop
//
//  Created by DiemMy Le on 5/12/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"type_image": 1,
//"label": "Ảnh mặt trước",
//"urlimage": "http://imagewarrantybeta.fptshop.com.vn:6789/HinhMauMayCuEcom/DTDD/1_MTruoc.jpg"

import UIKit
import SwiftyJSON

class ImageMayDemoBH: NSObject {
    let type_image:Int
    let label:String
    let urlimage:String
    var urlDetailImgThucTe:String
    
    init(type_image:Int, label:String, urlimage:String, urlDetailImgThucTe:String) {
        self.type_image = type_image
        self.label = label
        self.urlimage = urlimage
        self.urlDetailImgThucTe = urlDetailImgThucTe
    }
    
    class func parseObjfromArray(array:[JSON])->[ImageMayDemoBH]{
        var list:[ImageMayDemoBH] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
        
    class func getObjFromDictionary(data:JSON) -> ImageMayDemoBH {
        var type_image = data["type_image"].int
        var label = data["label"].string
        var urlimage = data["urlimage"].string
        var urlDetailImgThucTe = data["url_image"].string
        
        type_image = type_image == nil ? 0 : type_image
        label = label == nil ? "" : label
        urlimage = urlimage == nil ? "" : urlimage
        urlDetailImgThucTe = urlDetailImgThucTe == nil ? "" : urlDetailImgThucTe
        
        return ImageMayDemoBH(type_image: type_image!, label: label!, urlimage: urlimage!, urlDetailImgThucTe: urlDetailImgThucTe!)
        
    }
}

class ErrorItemMayDemoBH: NSObject {
    let code:String
    let label:String
    var isCheck: Bool
    
    init(code:String, label:String, isCheck: Bool) {
        self.code = code
        self.label = label
        self.isCheck = isCheck
    }
    class func parseObjfromArray(array:[JSON])->[ErrorItemMayDemoBH]{
        var list:[ErrorItemMayDemoBH] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ErrorItemMayDemoBH {
        var code = data["code"].string
        var label = data["label"].string
        
        code = code == nil ? "" : code
        label = label == nil ? "" : label
        
        return ErrorItemMayDemoBH(code: code!, label: label!, isCheck: false)
    }
}
