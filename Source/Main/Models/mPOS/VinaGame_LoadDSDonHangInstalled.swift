//
//  VinaGame_LoadDSDonHangInstalled.swift
//  mPOS
//
//  Created by sumi on 9/6/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class VinaGame_LoadDSDonHangInstalled: NSObject {
    var SOPOS: Int
    var SOMPOS: Int
    var IMEI: String
    var Listapp: String
    var TrangThai_zalo: String
    var NgayCai: String
    var cardname: String
    var NgayHoanTatDH:String
    var TrangThai_labankey: String
    var TrangThai_zing: String
    var TrangThai_baomoi: String
    
    init(SOPOS: Int, SOMPOS: Int, IMEI: String, Listapp: String, TrangThai_zalo: String, NgayCai: String, cardname: String, NgayHoanTatDH:String, TrangThai_labankey: String, TrangThai_zing: String, TrangThai_baomoi: String){
        self.SOPOS = SOPOS
        self.SOMPOS = SOMPOS
        self.IMEI = IMEI
        self.Listapp = Listapp
        self.TrangThai_zalo = TrangThai_zalo
        self.NgayCai = NgayCai
        self.cardname = cardname
        self.NgayHoanTatDH = NgayHoanTatDH
        self.TrangThai_labankey = TrangThai_labankey
        self.TrangThai_zing = TrangThai_zing
        self.TrangThai_baomoi = TrangThai_baomoi
    }
    class func parseObjfromArray(array:[JSON])->[VinaGame_LoadDSDonHangInstalled]{
        var list:[VinaGame_LoadDSDonHangInstalled] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> VinaGame_LoadDSDonHangInstalled{
        var SOPOS = data["SOPOS"].int
        var SOMPOS = data["SOMPOS"].int
        var IMEI = data["IMEI"].string
        var Listapp = data["Listapp"].string
        var TrangThai_zalo = data["TrangThai_zalo"].string
        var NgayCai = data["NgayCai"].string
        var cardname = data["cardname"].string
        var NgayHoanTatDH = data["NgayHoanTatDH"].string
        var TrangThai_labankey = data["TrangThai_labankey"].string
        var TrangThai_zing = data["TrangThai_zing"].string
        var TrangThai_baomoi = data["TrangThai_baomoi"].string
        
        SOPOS = SOPOS == nil ? 0 : SOPOS
        SOMPOS = SOMPOS == nil ? 0 : SOMPOS
        IMEI = IMEI == nil ? "" : IMEI
        Listapp = Listapp == nil ? "" : Listapp
        TrangThai_zalo = TrangThai_zalo == nil ? "" : TrangThai_zalo
        NgayCai = NgayCai == nil ? "" : NgayCai
        
        cardname = cardname == nil ? "" : cardname
        NgayHoanTatDH = NgayHoanTatDH == nil ? "" : NgayHoanTatDH
        TrangThai_labankey = TrangThai_labankey == nil ? "" : TrangThai_labankey
        TrangThai_zing = TrangThai_zing == nil ? "" : TrangThai_zing
        TrangThai_baomoi = TrangThai_baomoi == nil ? "" : TrangThai_baomoi
        
        return VinaGame_LoadDSDonHangInstalled(SOPOS: SOPOS!, SOMPOS: SOMPOS!, IMEI: IMEI!, Listapp: Listapp!, TrangThai_zalo: TrangThai_zalo!, NgayCai: NgayCai!, cardname: cardname!, NgayHoanTatDH:NgayHoanTatDH!, TrangThai_labankey: TrangThai_labankey!, TrangThai_zing: TrangThai_zing!, TrangThai_baomoi: TrangThai_baomoi!)
    }
}
