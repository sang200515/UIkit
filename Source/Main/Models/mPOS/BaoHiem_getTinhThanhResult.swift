//
//  BaoHiem_getTinhThanhResult.swift
//  mPOS
//
//  Created by sumi on 7/25/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaoHiem_getTinhThanhResult: NSObject {
    
    var STT: String
    var TinhThanhCode: String
    var TinhThanhName: String
    init(STT:String,TinhThanhCode:String,TinhThanhName: String){
        
        self.STT = STT
        self.TinhThanhCode = TinhThanhCode
         self.TinhThanhName = TinhThanhName
    }
    
    class func parseObjfromArray(array:[JSON])->[BaoHiem_getTinhThanhResult]{
        var list:[BaoHiem_getTinhThanhResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> BaoHiem_getTinhThanhResult{
        var STT = data["STT"].string
        var TinhThanhCode = data["TinhThanhCode"].string
        var TinhThanhName = data["TinhThanhName"].string
        
        STT = STT == nil ? "": STT
        TinhThanhCode = TinhThanhCode == nil ? "" : TinhThanhCode
        TinhThanhName = TinhThanhName == nil ? "" : TinhThanhName
        return BaoHiem_getTinhThanhResult(STT: STT!, TinhThanhCode: TinhThanhCode!, TinhThanhName: TinhThanhName!)
    }
}
