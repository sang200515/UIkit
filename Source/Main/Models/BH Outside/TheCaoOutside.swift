//
//  TheCaoOutside.swift
//  fptshop
//
//  Created by Apple on 4/3/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//


//"SOMPOS": 402074,
//"SoPhieu": "PY-20190403-10049043-30211",
//"Ngay": "12:13-03/04/2019",
//"LoaiBan": "PAYCODE",
//"MaNhaDichVu": "Mobifone",
//"MenhGia": 20000,
//"Phonenumber": "0904592677",
//"MaNap": "2445-0000-0001-129"


import UIKit
import SwiftyJSON

class TheCaoOutside: NSObject {
    
    let SOMPOS: Int
    let SoPhieu: String
    let Ngay: String
    let LoaiBan: String
    let MaNhaDichVu: String
    let MenhGia: Int
    let Phonenumber: String
    let MaNap: String
    
    
    init(SOMPOS: Int, SoPhieu: String, Ngay: String, LoaiBan: String, MaNhaDichVu: String, MenhGia: Int, Phonenumber: String, MaNap: String) {
        
        self.SOMPOS = SOMPOS
        self.SoPhieu = SoPhieu
        self.Ngay = Ngay
        self.LoaiBan = LoaiBan
        self.MaNhaDichVu = MaNhaDichVu
        self.MenhGia = MenhGia
        self.Phonenumber = Phonenumber
        self.MaNap = MaNap
    }
    
    class func BuildItemFromJSON(data:JSON) -> TheCaoOutside{
        
        var SOMPOS = data["SOMPOS"].int
        var SoPhieu = data["SoPhieu"].string
        var Ngay = data["Ngay"].string
        var LoaiBan = data["LoaiBan"].string
        var MaNhaDichVu = data["MaNhaDichVu"].string
        var MenhGia = data["MenhGia"].int
        var Phonenumber = data["Phonenumber"].string
        var MaNap = data["MaNap"].string
        
        SOMPOS = SOMPOS == nil ? 0 : SOMPOS
        SoPhieu = SoPhieu == nil ? "" : SoPhieu
        Ngay = Ngay == nil ? "" : Ngay
        LoaiBan = LoaiBan == nil ? "" : LoaiBan
        MaNhaDichVu = MaNhaDichVu == nil ? "" : MaNhaDichVu
        MenhGia = MenhGia == nil ? 0 : MenhGia
        Phonenumber = Phonenumber == nil ? "" : Phonenumber
        MaNap = MaNap == nil ? "" : MaNap
        
        return TheCaoOutside(SOMPOS: SOMPOS!, SoPhieu: SoPhieu!, Ngay: Ngay!, LoaiBan: LoaiBan!, MaNhaDichVu: MaNhaDichVu!, MenhGia: MenhGia!, Phonenumber: Phonenumber!, MaNap: MaNap!)
    }
    
    class func parseObjfromArray(array: [JSON])->[TheCaoOutside]{
        var list:[TheCaoOutside] = []
        for item in array {
            list.append(self.BuildItemFromJSON(data: item))
        }
        return list
    }

}
