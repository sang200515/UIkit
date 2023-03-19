//
//  HeaderSOPOSMirae.swift
//  fptshop
//
//  Created by tan on 8/14/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class HeaderSOPOSMirae: NSObject{
    var SOPOS:Int
    var SOMPOS:Int
    var U_NumECom:Int
    var Cardname:String
    var CardCode:Int
    var CreateDate:String
    var SDT:String
    var SoTienCoc:Float
    
    init(SOPOS:Int
        ,SOMPOS:Int
    , U_NumECom:Int
    , Cardname:String
    , CardCode:Int
  
    , CreateDate:String

        ,SDT:String
        ,SoTienCoc:Float){
        self.SOPOS = SOPOS
        self.SOMPOS = SOMPOS
        self.U_NumECom = U_NumECom
        self.Cardname = Cardname
        self.CardCode = CardCode

        self.CreateDate = CreateDate
  
        self.SDT = SDT
        self.SoTienCoc = SoTienCoc
    }
    
    class func parseObjfromArray(array:[JSON])->[HeaderSOPOSMirae]{
        var list:[HeaderSOPOSMirae] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> HeaderSOPOSMirae{
        
        var SOPOS = data["SOPOS"].int
        var SOMPOS = data["SOMPOS"].int
        var U_NumECom = data["EcomNum"].int
        var Cardname = data["Cardname"].string
        var CardCode = data["CardCode"].int

        var CreateDate = data["CreateDate"].string

        var SDT = data["SDT"].string
        var SoTienCoc = data["SoTienCoc"].float
        
        
        SOPOS = SOPOS == nil ? 0 : SOPOS
        SOMPOS = SOMPOS == nil ? 0 : SOMPOS
        U_NumECom = U_NumECom == nil ? 0 : U_NumECom
        Cardname = Cardname == nil ? "" : Cardname
        CardCode = CardCode == nil ? 0 : CardCode

        CreateDate = CreateDate == nil ? "" : CreateDate

        SDT = SDT == nil ? "" : SDT
        SoTienCoc = SoTienCoc == nil ? 0 : SoTienCoc
        
        
        return HeaderSOPOSMirae(SOPOS:SOPOS!
            ,SOMPOS:SOMPOS!
            , U_NumECom:U_NumECom!
            , Cardname:Cardname!
            , CardCode:CardCode!
  
            , CreateDate:CreateDate!

            ,SDT:SDT!
            ,SoTienCoc:SoTienCoc!
        )
    }
    
}
