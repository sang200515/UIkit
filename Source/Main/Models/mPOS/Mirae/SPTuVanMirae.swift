//
//  SPTuVanMirae.swift
//  fptshop
//
//  Created by tan on 6/28/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class SPTuVanMirae: NSObject {
    var TenSP:String
    var SLCoTheBan:Int
    var DonGia:Int
    
    init( TenSP:String
    , SLCoTheBan:Int
    , DonGia:Int){
        self.TenSP = TenSP
        self.SLCoTheBan = SLCoTheBan
        self.DonGia = DonGia
    }
    
    
    class func parseObjfromArray(array:[JSON])->[SPTuVanMirae]{
        var list:[SPTuVanMirae] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> SPTuVanMirae{
        
        var TenSP = data["TenSP"].string
        var SLCoTheBan = data["SLCoTheBan"].int
        var DonGia = data["DonGia"].int
        
        
        TenSP = TenSP == nil ? "" : TenSP
        SLCoTheBan = SLCoTheBan == nil ? 0 : SLCoTheBan
             DonGia = DonGia == nil ? 0 : DonGia
        
        
        return SPTuVanMirae(TenSP:TenSP!
            , SLCoTheBan:SLCoTheBan!,DonGia:DonGia!)
            
            
        
    }
}
