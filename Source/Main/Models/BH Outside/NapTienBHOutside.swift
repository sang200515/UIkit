//
//  NapTienBHOutside.swift
//  fptshop
//
//  Created by Apple on 4/3/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"ChungTuPos": 1,
//"TongTien": 20000,
//"NV_Thu": "4472",
//"ShopDong": "HNI 216 Thái Hà",
//"Ngay": "12h14-03/04/2019"

import UIKit
import SwiftyJSON

class NapTienBHOutside: NSObject {

    let ChungTuPos: Int
    let TongTien: Int
    let NV_Thu: String
    let ShopDong: String
    let Ngay: String
    
    
    
    init(ChungTuPos: Int, TongTien: Int, NV_Thu: String, ShopDong: String, Ngay: String) {
        
        self.ChungTuPos = ChungTuPos
        self.TongTien = TongTien
        self.NV_Thu = NV_Thu
        self.ShopDong = ShopDong
        self.Ngay = Ngay
    }
    
    class func BuildItemFromJSON(data:JSON) -> NapTienBHOutside{
        
        var ChungTuPos = data["ChungTuPos"].int
        var TongTien = data["TongTien"].int
        var NV_Thu = data["NV_Thu"].string
        var ShopDong = data["ShopDong"].string
        var Ngay = data["Ngay"].string
        
        
        ChungTuPos = ChungTuPos == nil ? 0 : ChungTuPos
        TongTien = TongTien == nil ? 0 : TongTien
        NV_Thu = NV_Thu == nil ? "" : NV_Thu
        ShopDong = ShopDong == nil ? "" : ShopDong
        Ngay = Ngay == nil ? "" : Ngay
        
        
        return NapTienBHOutside(ChungTuPos: ChungTuPos!, TongTien: TongTien!, NV_Thu: NV_Thu!, ShopDong: ShopDong!, Ngay: Ngay!)
    }
    
    class func parseObjfromArray(array: [JSON])->[NapTienBHOutside]{
        var list:[NapTienBHOutside] = []
        for item in array {
            list.append(self.BuildItemFromJSON(data: item))
        }
        return list
    }
}
