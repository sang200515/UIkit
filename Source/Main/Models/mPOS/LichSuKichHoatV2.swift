//
//  LichSuKichHoatV2ViewController.swift
//  mPOS
//
//  Created by tan on 10/1/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class LichSuKichHoatV2: NSObject{
    var Phonenumber:String
    var NgayKichHoat:String
    var GoiCuoc:String
    var FullName:String
    var SOMPOS:Int
    var SoSOPOS:Int
    var TongTien:Int
    var is_esim:Int
    var SeriSIM:String
    var Provider: String
    
    init(Phonenumber:String, NgayKichHoat:String, GoiCuoc:String, FullName:String, SOMPOS:Int, SoSOPOS:Int,TongTien:Int,is_esim:Int,SeriSIM:String,Provider: String){
        self.Phonenumber = Phonenumber
        self.NgayKichHoat = NgayKichHoat
        self.GoiCuoc = GoiCuoc
        self.FullName = FullName
        self.SOMPOS = SOMPOS
        self.SoSOPOS = SoSOPOS
        self.TongTien = TongTien
        self.is_esim = is_esim
        self.SeriSIM = SeriSIM
        self.Provider = Provider
    }
    
    class func parseObjfromArray(array:[JSON])->[LichSuKichHoatV2]{
        var list:[LichSuKichHoatV2] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    class func getObjFromDictionary(data:JSON) -> LichSuKichHoatV2{
        var Phonenumber = data["Phonenumber"].string
        Phonenumber = Phonenumber == nil ? data["phoneNumber"].string : data["Phonenumber"].string
        
        var NgayKichHoat = data["NgayKichHoat"].string
        NgayKichHoat = NgayKichHoat == nil ? data["activatedDate"].string : data["NgayKichHoat"].string
        
        var FullName = data["FullName"].string
        FullName = FullName == nil ? data["CustomerName"].string : data["FullName"].string
        
        var SOMPOS = data["SOMPOS"].int
        SOMPOS = SOMPOS == nil ? data["mposSoNum"].int : data["SOMPOS"].int
        
        var TongTien = data["TongTien"].int
        TongTien = TongTien == nil ? data["Price"].int : data["TongTien"].int
        
        var is_esim = data["is_esim"].int
        is_esim = is_esim == nil ? data["isEsim"].int : data["is_esim"].int
        
        var SeriSIM = data["SeriSIM"].string
        SeriSIM = SeriSIM == nil ? data["SimSerial"].string : data["SeriSIM"].string
        
        var GoiCuoc = data["GoiCuoc"].string
        var SoSOPOS = data["SoSOPOS"].int
        var Provider = data["Provider"].string
        
        Phonenumber = Phonenumber == nil ? "" : Phonenumber
        NgayKichHoat = NgayKichHoat == nil ? "" : NgayKichHoat
        GoiCuoc = GoiCuoc == nil ? "" : GoiCuoc
        FullName = FullName == nil ? "" : FullName
        SOMPOS = SOMPOS == nil ? 0 : SOMPOS
        SoSOPOS = SoSOPOS == nil ? 0 : SoSOPOS
        TongTien = TongTien == nil ? 0 : TongTien
        is_esim = is_esim == nil ? 0 : is_esim
        SeriSIM = SeriSIM == nil ? "" : SeriSIM
        Provider = Provider == nil ? "" : Provider
        return LichSuKichHoatV2(Phonenumber:Phonenumber!, NgayKichHoat:NgayKichHoat!, GoiCuoc:GoiCuoc!, FullName:FullName!, SOMPOS:SOMPOS!, SoSOPOS:SoSOPOS!,TongTien:TongTien!,is_esim:is_esim!,SeriSIM:SeriSIM!, Provider:Provider!)
    }
    
}
