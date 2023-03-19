//
//  SaoKeLuong.swift
//  fptshop
//
//  Created by tan on 4/11/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class SaoKeLuong: NSObject {
    var STT:Int
    var ID:Int
    var Thang:String
    var Luong:Int
    var TrungBinh:Int
    
    init(  STT:Int
    , ID:Int
    , Thang:String
    , Luong:Int
        ,TrungBinh: Int){
        self.STT = STT
        self.ID = ID
        self.Thang = Thang
        self.Luong = Luong
        self.TrungBinh = TrungBinh
    }
    
    class func parseObjfromArray(array:[JSON])->[SaoKeLuong]{
        var list:[SaoKeLuong] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> SaoKeLuong{
        
        var STT = data["STT"].int
        var ID = data["ID"].int
        var Thang  = data["Thang"].string
        var Luong = data["Luong"].int
        var TrungBinh = data["TrungBinh"].int
    
        
        
        STT = STT == nil ? 0 : STT
        ID = ID == nil ? 0 : ID
        Thang = Thang == nil ? "" :Thang
        Luong = Luong == nil ? 0 : Luong
        TrungBinh = TrungBinh == nil ? 0 : TrungBinh
    
        
        
        return SaoKeLuong(STT: STT!, ID: ID!,Thang:Thang!,Luong:Luong!,TrungBinh:TrungBinh!)
    }
    
}
