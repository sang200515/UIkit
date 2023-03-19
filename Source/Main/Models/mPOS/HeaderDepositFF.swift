//
//  HeaderDepositFF.swift
//  fptshop
//
//  Created by Ngo Dang tan on 12/12/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
//"EcomNum": 11683873,
//"SDT": "0901020304",
//"Cardname": " test_huyvq8",
//"CreateDate": "2019-11-18T16:13:46.563",
//"Doctotal": 21990000.0
class HeaderDepositFF: NSObject {
    var EcomNum:Int
    var SDT:String
    var Cardname:String
    var CreateDate:String
    var Doctotal:Float
    
    init(     EcomNum:Int
    , SDT:String
    , Cardname:String
    , CreateDate:String
    , Doctotal:Float){
        self.EcomNum = EcomNum
        self.SDT = SDT
        self.Cardname = Cardname
        self.CreateDate = CreateDate
        self.Doctotal = Doctotal
    }
    class func parseObjfromArray(array:[JSON])->[HeaderDepositFF]{
        var list:[HeaderDepositFF] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> HeaderDepositFF{
        var EcomNum = data["EcomNum"].int
        var SDT = data["SDT"].string
        var Cardname = data["Cardname"].string
        var CreateDate = data["CreateDate"].string
        var Doctotal = data["Doctotal"].float
        
        EcomNum = EcomNum == nil ? 0 : EcomNum
        SDT = SDT == nil ? "" : SDT
        Cardname = Cardname == nil ? "" : Cardname
        CreateDate = CreateDate == nil ? "" : CreateDate
        Doctotal = Doctotal == nil ? 0 : Doctotal
        return HeaderDepositFF(EcomNum:EcomNum!
        , SDT:SDT!
        , Cardname:Cardname!
        , CreateDate:CreateDate!
        , Doctotal:Doctotal!)
    }
    
}
