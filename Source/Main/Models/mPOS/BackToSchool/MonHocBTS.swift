//
//  MonHoc.swift
//  fptshop
//
//  Created by Apple on 7/2/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class MonHocBTS: NSObject {
    
    let TenMH: String
    let Diem: String
    
    init(TenMH: String, Diem: String) {
        self.TenMH = TenMH
        self.Diem = Diem
    }
    
    class func parseObjfromArray(array:[JSON])->[MonHocBTS]{
        var list:[MonHocBTS] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> MonHocBTS {
        var TenMH = data["TenMH"].string
        var Diem = data["Diem"].string
        
        TenMH = TenMH == nil ? "" : TenMH
        Diem = Diem == nil ? "" : Diem
        
        return MonHocBTS(TenMH: TenMH!, Diem: Diem!)
    }
}
