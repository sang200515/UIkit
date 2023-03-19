//
//  SimBookByShopV2.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class SimBookByShopV2: NSObject{
    
    var Provider:String
    var PhoneNumber:String
    var ShopCode:String
    var MaGoiCuoc:String
    var TenGoiCuoc:String
    var GiaCuoc:Int
    var type:Int
    var SoMpos:Int
    var IsSubsidy:Int
    var CardName:String
    var PackofData:String
    var Ecomnum:Int
    var PackageType:Int
	var GiaGoiCuocActive:Int
	var GiaSim:Int

    init(Provider:String,PhoneNumber:String,ShopCode:String,MaGoiCuoc:String,TenGoiCuoc:String,GiaCuoc:Int,type:Int,SoMpos:Int,IsSubsidy:Int,CardName:String,PackofData:String,Ecomnum:Int, PackageType:Int,GiaGoiCuocActive:Int, GiaSim:Int){
        self.Provider = Provider
        self.PhoneNumber = PhoneNumber
        self.ShopCode = ShopCode
        self.MaGoiCuoc = MaGoiCuoc
        
        self.TenGoiCuoc = TenGoiCuoc
        self.GiaCuoc = GiaCuoc
        self.type = type
        self.SoMpos = SoMpos
        self.IsSubsidy = IsSubsidy
        self.CardName = CardName
        self.PackofData = PackofData
        self.Ecomnum = Ecomnum
        self.PackageType = PackageType
		self.GiaGoiCuocActive = GiaGoiCuocActive
		self.GiaSim = GiaSim
    }
    
    
    class func parseObjfromArray(array:[JSON])->[SimBookByShopV2]{
        var list:[SimBookByShopV2] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    class func getObjFromDictionary(data:JSON) -> SimBookByShopV2{
        var Provider = data["Provider"].string
        var PhoneNumber = data["PhoneNumber"].string
        var ShopCode = data["ShopCode"].string
        var MaGoiCuoc = data["MaGoiCuoc"].string
        
        var TenGoiCuoc = data["TenGoiCuoc"].string
        var GiaCuoc = data["GiaCuoc"].int
        var type = data["Type"].int
        var SoMpos = data["SoMpos"].int
        var IsSubsidy = data["IsSubsidy"].int
        var CardName = data["CardName"].string
        var PackofData = data["PackofData"].string
        var Ecomnum = data["Ecomnum"].int
        var PackageType = data["PackageType"].int
		var GiaGoiCuocActive = data["GiaGoiCuocActive"].int
		var GiaSim = data["GiaSim"].int
        Provider = Provider == nil ? "" : Provider
        PhoneNumber = PhoneNumber == nil ? "" : PhoneNumber
        ShopCode = ShopCode == nil ? "" : ShopCode
        
        TenGoiCuoc = TenGoiCuoc == nil ? "" : TenGoiCuoc
        MaGoiCuoc = MaGoiCuoc == nil ? "" : MaGoiCuoc
        GiaCuoc = GiaCuoc == nil ? 0 : GiaCuoc
        type = type == nil ? 0 : type
        SoMpos = SoMpos == nil ? 0 : SoMpos
        IsSubsidy = IsSubsidy == nil ? 0 : IsSubsidy
        CardName = CardName == nil ? "" : CardName
        PackofData = PackofData == nil ? "" : PackofData
        Ecomnum = Ecomnum == nil ? 0 : Ecomnum
        PackageType = PackageType == nil ? 0 : PackageType
		GiaGoiCuocActive = GiaGoiCuocActive == nil ? 0 : GiaGoiCuocActive
		GiaSim = GiaSim == nil ? 0 : GiaSim
        return SimBookByShopV2(Provider:Provider!,PhoneNumber:PhoneNumber!,ShopCode:ShopCode!,MaGoiCuoc:MaGoiCuoc!, TenGoiCuoc: TenGoiCuoc!,GiaCuoc:GiaCuoc!,type:type!,SoMpos:SoMpos!,IsSubsidy:IsSubsidy!,CardName:CardName!,PackofData:PackofData!,Ecomnum:Ecomnum!, PackageType:PackageType!,GiaGoiCuocActive:GiaGoiCuocActive!, GiaSim:GiaSim!)
    }
    
}

