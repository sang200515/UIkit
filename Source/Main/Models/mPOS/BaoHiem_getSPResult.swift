//
//  BaoHiem_getSPResult.swift
//  mPOS
//
//  Created by sumi on 7/25/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaoHiem_getSPResult: NSObject {
    
    var SanPhamCode: String
    var SanPhamName: String
    
    init(SanPhamCode:String,SanPhamName:String){
        
        self.SanPhamCode = SanPhamCode
        self.SanPhamName = SanPhamName
        
    }

    class func parseObjfromArray(array:[JSON])->[BaoHiem_getSPResult]{
        var list:[BaoHiem_getSPResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> BaoHiem_getSPResult{
        var SanPhamCode = data["SanPhamCode"].string
        var SanPhamName = data["SanPhamName"].string
        SanPhamCode = SanPhamCode == nil ? "": SanPhamCode
        SanPhamName = SanPhamName == nil ? "" : SanPhamName
        return BaoHiem_getSPResult(SanPhamCode: SanPhamCode!, SanPhamName: SanPhamName!)
    }
}
