//
//  DoiTuongChamDiem.swift
//  fptshop
//
//  Created by Apple on 5/31/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"STT": 1,
//"ObjectID": 1,
//"ObjectName": "Shop",
//"ScoreLevel": 10,
//"Percent": true

import UIKit
import SwiftyJSON

class DoiTuongChamDiem: NSObject {
    
    let STT: Int
    let ObjectID: Int
    let ObjectName: String
    let ScoreLevel: Int
    let Percent: Bool
    
    
    init(STT: Int, ObjectID: Int, ObjectName: String, ScoreLevel: Int, Percent: Bool) {
        self.STT = STT
        self.ObjectID = ObjectID
        self.ObjectName = ObjectName
        self.ScoreLevel = ScoreLevel
        self.Percent = Percent
    }
    
    class func parseObjfromArray(array:[JSON])->[DoiTuongChamDiem]{
        var list:[DoiTuongChamDiem] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> DoiTuongChamDiem{
        var STT = data["STT"].int
        var ObjectID = data["ObjectID"].int
        var ObjectName = data["ObjectName"].string
        var ScoreLevel = data["ScoreLevel"].int
        var Percent = data["Percent"].bool
        
        
        STT = STT == nil ? 0 : STT
        ObjectID = ObjectID == nil ? 0 : ObjectID
        ObjectName = ObjectName == nil ? "" : ObjectName
        ScoreLevel = ScoreLevel == nil ? 0 : ScoreLevel
        Percent = Percent == nil ? false : Percent
        
        
        return DoiTuongChamDiem(STT: STT!, ObjectID: ObjectID!, ObjectName: ObjectName!, ScoreLevel: ScoreLevel!, Percent: Percent!)
    }
}
