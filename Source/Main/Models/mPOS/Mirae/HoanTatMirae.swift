//
//  HoanTatMirae.swift
//  fptshop
//
//  Created by tan on 6/11/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class HoanTatMirae: NSObject {
    var p_status:Int
    var p_messagess:String
    
    init( p_status:Int
    , p_messagess:String){
        self.p_status = p_status
        self.p_messagess = p_messagess
    }
    
    class func parseObjfromArray(array:[JSON])->[HoanTatMirae]{
        var list:[HoanTatMirae] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> HoanTatMirae{
        
        var p_status = data["p_status"].int
        var p_messagess = data["p_messagess"].string
        
        
        
        
        p_status = p_status == nil ? 0 : p_status
        p_messagess = p_messagess == nil ? "" : p_messagess
        
        
        
        return HoanTatMirae(p_status:p_status!
            , p_messagess:p_messagess!
            
            
        )
    }
    
}
