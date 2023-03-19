//
//  MDMHSim.swift
//  fptshop
//
//  Created by Ngo Dang tan on 8/25/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class MDMHSim: NSObject {
    var p_MDMH:Int
    var p_matkinh:String
    var Brandname:String
    var p_sim:String
    
    init( p_MDMH:Int
    , p_matkinh:String
    , Brandname:String
    , p_sim:String){
        self.p_MDMH = p_MDMH
        self.p_matkinh = p_matkinh
        self.Brandname = Brandname
        self.p_sim = p_sim
    }
    
    class func getObjFromDictionary(data:JSON) -> MDMHSim{
        
        var p_MDMH = data["p_MDMH"].int
        var p_matkinh = data["p_matkinh"].string
        var Brandname = data["Brandname"].string
        var p_sim = data["p_sim"].string
        
        p_MDMH = p_MDMH == nil ? 0 : p_MDMH
        p_matkinh = p_matkinh == nil ? "" : p_matkinh
        Brandname = Brandname == nil ? "" : Brandname
        p_sim = p_sim == nil ? "" : p_sim
        
        return MDMHSim(p_MDMH:p_MDMH!
        , p_matkinh:p_matkinh!
        , Brandname:Brandname!
        , p_sim:p_sim!)
    }
    class func parseObjfromArray(array:[JSON])->[MDMHSim]{
        var list:[MDMHSim] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
}
