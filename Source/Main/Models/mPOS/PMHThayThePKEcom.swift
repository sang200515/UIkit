//
//  PMHThayThePKEcom.swift
//  fptshop
//
//  Created by Ngo Dang tan on 4/13/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"TenSP": "00007047-Ốp lưng Galaxy S7 Edge Spigen Crystal Shell",
//"GiaMua": 791640,
//"GiaPKSauGiam": 400000,
//"GiaKhTra": 0
import Foundation
import SwiftyJSON
class PMHThayThePKEcom: NSObject {
    var TenSP:String
    var GiaMua:Int
    var GiaPKSauGiam:Int
    var GiaKhTra:Int
    
    init(   TenSP:String
        , GiaMua:Int
        , GiaPKSauGiam:Int
        , GiaKhTra:Int){
        self.TenSP = TenSP
        self.GiaMua = GiaMua
        self.GiaPKSauGiam = GiaPKSauGiam
        self.GiaKhTra = GiaKhTra
    }
    class func parseObjfromArray(array:[JSON])->[PMHThayThePKEcom]{
        var list:[PMHThayThePKEcom] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> PMHThayThePKEcom{
        
        var TenSP = data["TenSP"].string
        var GiaMua = data["GiaMua"].int
        var GiaPKSauGiam = data["GiaPKSauGiam"].int
        var GiaKhTra = data["GiaKhTra"].int
        
        
        
        
        TenSP = TenSP == nil ? "" : TenSP
        GiaMua = GiaMua == nil ? 0 : GiaMua
        GiaPKSauGiam = GiaPKSauGiam == nil ? 0 : GiaPKSauGiam
        
        GiaKhTra = GiaKhTra == nil ? 0 : GiaKhTra
        
        
        
        return PMHThayThePKEcom(TenSP:TenSP!
            , GiaMua:GiaMua!
            , GiaPKSauGiam:GiaPKSauGiam!
            , GiaKhTra:GiaKhTra!
        )
    }
}
