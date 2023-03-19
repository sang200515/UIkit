//
//  BaoHiem_getLoaiXeResult.swift
//  mPOS
//
//  Created by sumi on 7/25/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaoHiem_getLoaiXeResult: NSObject {
    
    var LoaiHinhCode: String
    var LoaiHinhName: String
    
    init(LoaiHinhCode:String,LoaiHinhName:String){
        
        self.LoaiHinhCode = LoaiHinhCode
        self.LoaiHinhName = LoaiHinhName
        
    }
    class func parseObjfromArray(array:[JSON])->[BaoHiem_getLoaiXeResult]{
        var list:[BaoHiem_getLoaiXeResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> BaoHiem_getLoaiXeResult{
        var LoaiHinhCode = data["LoaiHinhCode"].string
        var LoaiHinhName = data["LoaiHinhName"].string
        LoaiHinhCode = LoaiHinhCode == nil ? "": LoaiHinhCode
        LoaiHinhName = LoaiHinhName == nil ? "" : LoaiHinhName
        return BaoHiem_getLoaiXeResult(LoaiHinhCode: LoaiHinhCode!, LoaiHinhName: LoaiHinhName!)
    }
}

