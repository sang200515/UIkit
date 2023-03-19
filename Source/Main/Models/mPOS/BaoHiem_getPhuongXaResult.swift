//
//  BaoHiem_getPhuongXaResult.swift
//  mPOS
//
//  Created by sumi on 7/25/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaoHiem_getPhuongXaResult: NSObject {
    
    var PhuongXaCode: String
    var PhuongXaName: String
    
    
    init(PhuongXaCode:String,PhuongXaName:String){
        
        self.PhuongXaCode = PhuongXaCode
        self.PhuongXaName = PhuongXaName
        
    }
    
    class func parseObjfromArray(array:[JSON])->[BaoHiem_getPhuongXaResult]{
        var list:[BaoHiem_getPhuongXaResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> BaoHiem_getPhuongXaResult{
        var PhuongXaCode = data["PhuongXaCode"].string
        var PhuongXaName = data["PhuongXaName"].string
        PhuongXaCode = PhuongXaCode == nil ? "": PhuongXaCode
        PhuongXaName = PhuongXaName == nil ? "" : PhuongXaName
        return BaoHiem_getPhuongXaResult(PhuongXaCode: PhuongXaCode!, PhuongXaName: PhuongXaName!)
    }
}

