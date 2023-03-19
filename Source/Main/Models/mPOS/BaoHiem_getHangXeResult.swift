//
//  BaoHiem_ getHangXeResult.swift
//  mPOS
//
//  Created by sumi on 7/25/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaoHiem_getHangXeResult: NSObject {
    
    var HangXeCode: String
    var HangXeName: String
 
    init(HangXeCode:String,HangXeName:String){
        
        self.HangXeCode = HangXeCode
        self.HangXeName = HangXeName
        
    }
    
    class func parseObjfromArray(array:[JSON])->[BaoHiem_getHangXeResult]{
        var list:[BaoHiem_getHangXeResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> BaoHiem_getHangXeResult{
        var HangXeCode = data["HangXeCode"].string
        var HangXeName = data["HangXeName"].string
        HangXeCode = HangXeCode == nil ? "": HangXeCode
        HangXeName = HangXeName == nil ? "" : HangXeName
        return BaoHiem_getHangXeResult(HangXeCode: HangXeCode!, HangXeName: HangXeName!)
    }
}
