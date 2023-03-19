//
//  BaoHiem_getQuanHuyenResult.swift
//  mPOS
//
//  Created by sumi on 7/25/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaoHiem_getQuanHuyenResult: NSObject {
    
    var QuanHuyenCode: String
    var QuanHuyenName: String
    
    init(QuanHuyenCode:String,QuanHuyenName:String){
        
        self.QuanHuyenCode = QuanHuyenCode
        self.QuanHuyenName = QuanHuyenName
    }
    
    class func parseObjfromArray(array:[JSON])->[BaoHiem_getQuanHuyenResult]{
        var list:[BaoHiem_getQuanHuyenResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> BaoHiem_getQuanHuyenResult{
        var QuanHuyenCode = data["QuanHuyenCode"].string
        var QuanHuyenName = data["QuanHuyenName"].string
        
        QuanHuyenCode = QuanHuyenCode == nil ? "": QuanHuyenCode
        QuanHuyenName = QuanHuyenName == nil ? "" : QuanHuyenName
        return BaoHiem_getQuanHuyenResult(QuanHuyenCode: QuanHuyenCode!, QuanHuyenName: QuanHuyenName!)
    }
}
