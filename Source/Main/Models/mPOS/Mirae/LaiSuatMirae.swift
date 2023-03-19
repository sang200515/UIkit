//
//  LaiSuatMirae.swift
//  fptshop
//
//  Created by tan on 6/2/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class LaiSuatMirae: NSObject {
    var Code:String
    var Name:String
    var laisuat:Float
    var mota:String
    var fee_insurance:Float
    var ParticipationFee: Float
    var ParticipationFeeRate: Float
    init( Code:String,Name:String,laisuat:Float,mota:String,fee_insurance:Float,ParticipationFee: Float,ParticipationFeeRate: Float){
        self.Code = Code
        self.Name = Name
        self.laisuat = laisuat
        self.mota = mota
        self.fee_insurance = fee_insurance
        self.ParticipationFee = ParticipationFee
        self.ParticipationFeeRate = ParticipationFeeRate
    }
    
    class func parseObjfromArray(array:[JSON])->[LaiSuatMirae]{
        var list:[LaiSuatMirae] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> LaiSuatMirae{
        
        var Code = data["Code"].string
        var Name = data["Name"].string
        var laisuat = data["laisuat"].float
        var mota = data["mota"].string
        var fee_insurance = data["fee_insurance"].float
        var ParticipationFee = data["ParticipationFee"].float
        var ParticipationFeeRate = data["ParticipationFeeRate"].float
        
        Code = Code == nil ? "" : Code
        Name = Name == nil ? "" : Name
        laisuat = laisuat == nil ? 0 : laisuat
        mota = mota == nil ? "" : mota
        fee_insurance = fee_insurance == nil ? 0 : fee_insurance
        ParticipationFee = ParticipationFee == nil ? 0 : ParticipationFee
        ParticipationFeeRate = ParticipationFeeRate == nil ? 0 : ParticipationFeeRate
        
        return LaiSuatMirae(Code:Code!
            , Name:Name!
            , laisuat:laisuat!
            ,mota:mota!
            ,fee_insurance:fee_insurance!
            ,ParticipationFee: ParticipationFee!
            ,ParticipationFeeRate:ParticipationFeeRate!
        )
    }
    
}
