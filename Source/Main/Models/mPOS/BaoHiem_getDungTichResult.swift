//
//  BaoHiem_getDungTichResult.swift
//  mPOS
//
//  Created by sumi on 7/25/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaoHiem_getDungTichResult: NSObject {
    var DoiTuongCode: String
    var DoiTuongName: String
    
    init(DoiTuongCode:String,DoiTuongName:String){
        
        self.DoiTuongCode = DoiTuongCode
        self.DoiTuongName = DoiTuongName
        
    }
    
    class func parseObjfromArray(array:[JSON])->[BaoHiem_getDungTichResult]{
        var list:[BaoHiem_getDungTichResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> BaoHiem_getDungTichResult{
        var DoiTuongCode = data["DoiTuongCode"].string
        var DoiTuongName = data["DoiTuongName"].string
        DoiTuongCode = DoiTuongCode == nil ? "": DoiTuongCode
        DoiTuongName = DoiTuongName == nil ? "" : DoiTuongName
        return BaoHiem_getDungTichResult(DoiTuongCode: DoiTuongCode!, DoiTuongName: DoiTuongName!)
    }
}
