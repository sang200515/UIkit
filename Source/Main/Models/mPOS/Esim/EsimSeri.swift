//
//  EsimSeri.swift
//  fptshop
//
//  Created by tan on 3/8/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class EsimSeri: NSObject {
    var seri:String
    var p_status:Int
    var p_messagess:String
    
    init(    seri:String
    , p_status:Int
    , p_messagess:String){
        self.seri = seri
        self.p_status = p_status
        self.p_messagess = p_messagess
    }
    
    class func parseObjfromArray(array:[JSON])->[EsimSeri]{
        var list:[EsimSeri] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> EsimSeri{
        
     
        var seri = data["seri"].string
        var p_status = data["p_status"].int
        var p_messagess = data["p_messagess"].string
        
        
     
        seri = seri == nil ? "" : seri
        p_status = p_status == nil ? 0 : p_status
        p_messagess = p_messagess == nil ? "" : p_messagess
        
        
        return EsimSeri(seri: seri!,p_status:p_status!,p_messagess:p_messagess!)
    }
    
}
