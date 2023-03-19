//
//  SimV2.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/31/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class SimV2:NSObject{
    var STT: Int
    var ProductID: String
    var Provider: String
    var Gia: Int
    var PriceSale: Int
    var SimTypeName: String
    var MSPdichvu: String
    var TenSPDichVu: String
    
    init(STT:Int, ProductID:String,Provider:String,Gia:Int,PriceSale:Int,SimTypeName:String,MSPdichvu:String,TenSPDichVu:String){
        self.STT = STT
        self.ProductID = ProductID
        self.Provider = Provider
        self.Gia = Gia
        self.PriceSale = PriceSale
        self.SimTypeName = SimTypeName
        self.MSPdichvu = MSPdichvu
        self.TenSPDichVu = TenSPDichVu
    }
    
    
    class func parseObjfromArray(array:[JSON])->[SimV2]{
        var list:[SimV2] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    class func getObjFromDictionary(data:JSON) -> SimV2{
        var STT = data["STT"].int
        var ProductID = data["ProductID"].string
        var Provider = data["Provider"].string
        var Gia = data["Gia"].int
        
        var PriceSale = data["PriceSale"].int
        var SimTypeName = data["SimTypeName"].string
        var MSPdichvu = data["MSPdichvu"].string
        var TenSPDichVu = data["TenSPDichVu"].string
        
        
        STT = STT == nil ? 0 : STT
        ProductID = ProductID == nil ? "" : ProductID
        Provider = Provider == nil ? "" : Provider
        Gia = Gia == nil ? 0 : Gia
        
        PriceSale = PriceSale == nil ? 0 : PriceSale
        SimTypeName = SimTypeName == nil ? "" : SimTypeName
        MSPdichvu = MSPdichvu == nil ? "" : MSPdichvu
        TenSPDichVu = TenSPDichVu == nil ? "" : TenSPDichVu
        
        
        return SimV2(STT:STT!,ProductID:ProductID!,Provider:Provider!,Gia:Gia!,PriceSale:PriceSale!,SimTypeName:SimTypeName!,MSPdichvu:MSPdichvu!,TenSPDichVu:TenSPDichVu!)
    }
    
}

