//
//  GoiCuocBookSimV2.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/31/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class GoiCuocBookSimV2: NSObject{
    var MaSP:String
    var TenSP:String
    var GiaCuoc:Int
    var DanhDauSS:Bool
    var isRule: Bool // true: di tu rule binh thuong, false: di tu rule gio hang
    var tenKH:String
    
    
    init(MaSP:String,TenSP:String,GiaCuoc:Int,DanhDauSS:Bool,isRule:Bool,tenKH:String){
        self.MaSP = MaSP
        self.TenSP = TenSP
        self.GiaCuoc = GiaCuoc
        self.DanhDauSS = DanhDauSS
        self.isRule = isRule
        self.tenKH = tenKH
        
    }
    
    
    class func parseObjfromArray(array:[JSON])->[GoiCuocBookSimV2]{
        var list:[GoiCuocBookSimV2] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    class func getObjFromDictionary(data:JSON) -> GoiCuocBookSimV2{
        var MaSP = data["MaSP"].string
        var TenSP = data["TenSP"].string
        var GiaCuoc = data["GiaCuoc"].int
        var DanhDauSS = data["DanhDauSS"].bool
        
        var isRule = data["isRule"].bool
        var tenKH = data["tenKH"].string
        
        
        MaSP = MaSP == nil ? "" : MaSP
        TenSP = TenSP == nil ? "" : TenSP
        
        GiaCuoc = GiaCuoc == nil ? 0 : GiaCuoc
        DanhDauSS = DanhDauSS == nil ? false : DanhDauSS
        
        isRule = isRule == nil ? false : isRule
        tenKH = tenKH == nil ? "" : tenKH
        
        return GoiCuocBookSimV2(MaSP:MaSP!,TenSP:TenSP!,GiaCuoc:GiaCuoc!,DanhDauSS:DanhDauSS!,isRule:isRule!,tenKH:tenKH!)
    }
    
}

