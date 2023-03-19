//
//  DataBookSimV2.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class DataBookSimV2: NSObject{
    var CardName:String
    var GiaCuoc:Int
    var IsSubsidy:Int
    var MaGoiCuoc:String
    var Message:String
    var PackofData:String
    var PhoneNumber:String
    var Provider:String
    var Result:Int
    var ShopCode:String
    var SoEcom:String
    var SoMpos:Int
    var TenGoiCuoc:String
    var type:Int
    
    init(    CardName:String
        , GiaCuoc:Int
        , IsSubsidy:Int
        , MaGoiCuoc:String
        , Message:String
        , PackofData:String
        , PhoneNumber:String
        , Provider:String
        , Result:Int
        , ShopCode:String
        , SoEcom:String
        , SoMpos:Int
        , TenGoiCuoc:String
        , type:Int){
        
        self.CardName = CardName
        self.GiaCuoc = GiaCuoc
        self.IsSubsidy = IsSubsidy
        self.MaGoiCuoc = MaGoiCuoc
        self.Message = Message
        self.PackofData = PackofData
        self.PhoneNumber = PhoneNumber
        self.Provider = Provider
        self.Result = Result
        self.ShopCode = ShopCode
        self.SoEcom = SoEcom
        self.SoMpos = SoMpos
        self.TenGoiCuoc = TenGoiCuoc
        self.type = type
    }
    
    class func parseObjfromArray(array:[JSON])->[DataBookSimV2]{
        var list:[DataBookSimV2] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    class func getObjFromDictionary(data:JSON) -> DataBookSimV2{
        var CardName = data["CardName"].string
        var GiaCuoc = data["GiaCuoc"].int
        var IsSubsidy = data["IsSubsidy"].int
        var MaGoiCuoc = data["MaGoiCuoc"].string
        
        var Message = data["Message"].string
        var PackofData = data["PackofData"].string
        var PhoneNumber = data["PhoneNumber"].string
        var Provider = data["Provider"].string
        var Result = data["Result"].int
        var ShopCode = data["ShopCode"].string
        var SoEcom = data["SoEcom"].string
        var SoMpos = data["SoMpos"].int
        var TenGoiCuoc = data["TenGoiCuoc"].string
        var type = data["Type"].int
        
        
        SoEcom = SoEcom == nil ? "" : SoEcom
        CardName = CardName == nil ? "" : CardName
        Provider = Provider == nil ? "" : Provider
        GiaCuoc = GiaCuoc == nil ? 0 : GiaCuoc
        IsSubsidy = IsSubsidy == nil ? 0 : IsSubsidy
        MaGoiCuoc = MaGoiCuoc == nil ? "" : MaGoiCuoc
        Message = Message == nil ? "" : Message
        PackofData = PackofData == nil ? "" : PackofData
        PhoneNumber = PhoneNumber == nil ? "" : PhoneNumber
        Provider = Provider == nil ? "" : Provider
        
        Result = Result == nil ? 0 : Result
        ShopCode = ShopCode == nil ? "" : ShopCode
        SoMpos = SoMpos == nil ? 0 : SoMpos
        TenGoiCuoc = TenGoiCuoc == nil ? "" : TenGoiCuoc
        type = type == nil ? 0 : type
        
        return DataBookSimV2( CardName:CardName!
            , GiaCuoc:GiaCuoc!
            , IsSubsidy:IsSubsidy!
            , MaGoiCuoc:MaGoiCuoc!
            , Message:Message!
            , PackofData:PackofData!
            , PhoneNumber:PhoneNumber!
            , Provider:Provider!
            , Result:Result!
            , ShopCode:ShopCode!
            , SoEcom:SoEcom!
            , SoMpos:SoMpos!
            , TenGoiCuoc:TenGoiCuoc!
            , type:type!)
    }
}

