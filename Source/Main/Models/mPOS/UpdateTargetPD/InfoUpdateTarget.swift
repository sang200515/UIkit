//
//  InfoUpdateTarget.swift
//  fptshop
//
//  Created by tan on 2/26/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class InfoUpdateTarget: NSObject {
    var HoTenPD:String
    var SoTarget:Float
    var Thang:Int
    var IDTarget:Int
    var PD_Code:String
    
    init(     HoTenPD:String
    , SoTarget:Float
    , Thang:Int
    , IDTarget: Int,
      PD_Code:String){
        self.HoTenPD = HoTenPD
        self.SoTarget = SoTarget
        self.Thang = Thang
        self.IDTarget = IDTarget
        self.PD_Code = PD_Code
    }
    
    
    class func parseObjfromArray(array:[JSON])->[InfoUpdateTarget]{
        var list:[InfoUpdateTarget] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> InfoUpdateTarget{
        
        var HoTenPD = data["HoTenPD"].string
        var SoTarget = data["SoTarget"].float
        var Thang = data["Thang"].int
        var IDTarget = data["IDTarget"].int
        var PD_Code = data["PD_Code"].string
        
        
        HoTenPD = HoTenPD == nil ? "" : HoTenPD
        SoTarget = SoTarget == nil ? 0 : SoTarget
        Thang = Thang == nil ? 0 : Thang
        IDTarget = IDTarget == nil ? 0 : IDTarget
        PD_Code = PD_Code == nil ? "" : PD_Code
        
        return InfoUpdateTarget(HoTenPD: HoTenPD!, SoTarget: SoTarget!,Thang:Thang!,IDTarget:IDTarget!,PD_Code:PD_Code!)
    }
}
