//
//  MiraeLoaiChungTu.swift
//  fptshop
//
//  Created by tan on 5/28/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class MiraeLoaiChungTu: NSObject {
    var code:String
    var name:String
    
    init( code:String
    , name:String){
        self.code = code
        self.name = name
    }
    
    class func parseObjfromArray(array:[JSON])->[MiraeLoaiChungTu]{
        var list:[MiraeLoaiChungTu] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> MiraeLoaiChungTu{
        
        var code = data["code"].string
        var name = data["name"].string

        
        code = code == nil ? "" : code
        name = name == nil ? "" : name

        return MiraeLoaiChungTu(code:code!
            , name:name!
          )
    }
    
    
}
