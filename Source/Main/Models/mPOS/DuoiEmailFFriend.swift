//
//  DuoiEmailFFriend.swift
//  fptshop
//
//  Created by tan on 5/9/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class DuoiEmailFFriend: NSObject {
    var DuoiEmail:String
    
    init(DuoiEmail:String){
        self.DuoiEmail = DuoiEmail
    }
    class func parseObjfromArray(array:[JSON])->[DuoiEmailFFriend]{
        var list:[DuoiEmailFFriend] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> DuoiEmailFFriend{
        
        var DuoiEmail = data["DuoiEmail"].string
        
        DuoiEmail = DuoiEmail == nil ? "" : DuoiEmail
        
        
        return DuoiEmailFFriend(DuoiEmail: DuoiEmail!)
    }
}
