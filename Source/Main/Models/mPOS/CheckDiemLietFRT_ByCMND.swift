//
//  CheckDiemLietFRT_ByCMND.swift
//  fptshop
//
//  Created by tan on 4/18/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class CheckDiemLietFRT_ByCMND: NSObject {
    var FlagTraGop:String
    var TraThang:String
    
    init(FlagTraGop:String
    , TraThang:String){
        self.FlagTraGop = FlagTraGop
        self.TraThang = TraThang
    }
    
    class func parseObjfromArray(array:[JSON])->[CheckDiemLietFRT_ByCMND]{
        var list:[CheckDiemLietFRT_ByCMND] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> CheckDiemLietFRT_ByCMND{
        
        var FlagTraGop = data["FlagTraGop"].string
        var TraThang = data["TraThang"].string

        
        FlagTraGop = FlagTraGop == nil ? "" : FlagTraGop
        TraThang = TraThang == nil ? "" : TraThang
   
        
        return CheckDiemLietFRT_ByCMND(FlagTraGop: FlagTraGop!,TraThang:TraThang!)
    }
}
