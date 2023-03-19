//
//  KyHanMirae.swift
//  fptshop
//
//  Created by tan on 6/4/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class KyHanMirae: NSObject {
    
    var ID:Int
    var Name:String
    var ParticipationFeeRate: Float
    init(ID:Int,
         Name:String,
         ParticipationFeeRate:Float
    ){
    self.ID = ID
    self.Name = Name
        self.ParticipationFeeRate = ParticipationFeeRate
    }
    
    
    class func parseObjfromArray(array:[JSON])->[KyHanMirae]{
        var list:[KyHanMirae] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> KyHanMirae{
        
        var ID = data["ID"].int
        var Name = data["Name"].string
        var ParticipationFeeRate = data["ParticipationFeeRate"].float
        ParticipationFeeRate = ParticipationFeeRate == nil ? 0 : ParticipationFeeRate
        ID = ID == nil ? 0 : ID
        Name = Name == nil ? "" : Name

        return KyHanMirae(ID:ID!,
                          Name:Name!,
                          ParticipationFeeRate:ParticipationFeeRate!
        )
    }
    
}
