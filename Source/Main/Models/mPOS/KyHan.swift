//
//  KyHan.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class KyHan: NSObject {
    
    var id: String
    var kyHan: String
    
    init(ID: String, KyHan: String){
        self.id = ID
        self.kyHan = KyHan
    }
    class func parseObjfromArray(array:[JSON])->[KyHan]{
        var list:[KyHan] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> KyHan{
        
        var id = data["ID"].string
        var kyHan = data["KyHan"].string
        
        id = id == nil ? "" : id
        kyHan = kyHan == nil ? "" : kyHan
        
        return KyHan(ID: id!, KyHan: kyHan!)
    }
    
}

