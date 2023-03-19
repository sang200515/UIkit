//
//  BaoHiem_addOrderResult.swift
//  mPOS
//
//  Created by sumi on 7/31/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaoHiem_addOrderResult: NSObject {
    
    var Loai: String
    var EcomCode: String
    var ResultFRT: String
    var MSGFRT: String
    var IDDonHangFRT: String
    
    init(Loai: String, EcomCode: String, ResultFRT: String, MSGFRT: String,IDDonHangFRT:String){
        self.Loai = Loai
        self.EcomCode = EcomCode
        self.ResultFRT = ResultFRT
        self.MSGFRT = MSGFRT
        self.IDDonHangFRT = IDDonHangFRT
    }
    
    class func parseObjfromArray(array:[JSON])->[BaoHiem_addOrderResult]{
        var list:[BaoHiem_addOrderResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> BaoHiem_addOrderResult{
        var IDDonHangFRT = data["IDDonHangFRT"].string
        var MSGFRT = data["MSGFRT"].string
        var ResultFRT = data["ResultFRT"].string
        var EcomCode = data["EcomCode"].string
        var Loai = data["Loai"].string
        
        IDDonHangFRT = IDDonHangFRT == nil ? "": IDDonHangFRT
        MSGFRT = MSGFRT == nil ? "" : MSGFRT
        ResultFRT = ResultFRT == nil ? "" : ResultFRT
        EcomCode = EcomCode == nil ? "": EcomCode
        Loai = Loai == nil ? "": Loai
        return BaoHiem_addOrderResult(Loai: Loai!, EcomCode: EcomCode!, ResultFRT: ResultFRT!, MSGFRT: MSGFRT!,IDDonHangFRT:IDDonHangFRT!)
    }
}

