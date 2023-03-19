//
//  LichSuNhapPO.swift
//  mPOS
//
//  Created by tan beo on 8/23/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class LichSuNhapPO:NSObject{
    var IMEI:String
    var CardName:String
    var PONum:Int
    var SLNhap:Int
    var SLPO:Int
    var ItemName:String
    var Gio:String
    
    
    init(IMEI:String,CardName:String,PONum:Int,SLNhap:Int,SLPO:Int,ItemName:String,Gio:String){
        self.IMEI = IMEI
        self.CardName = CardName
        self.PONum = PONum
        self.SLNhap = SLNhap
        self.SLPO = SLPO
        self.ItemName = ItemName
        self.Gio = Gio
        
    }
    

    
    
    class func parseObjfromArray(array:[JSON])->[LichSuNhapPO]{
        var list:[LichSuNhapPO] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    
    
    class func getObjFromDictionary(data:JSON) -> LichSuNhapPO{
        var IMEI = data["IMEI"].string
        var CardName = data["CardName"].string
        var PONum = data["PONum"].int
        var SLNhap = data["SLNhap"].int
        var SLPO = data["SLPO"].int
        var ItemName = data["ItemName"].string
        var Gio = data["Gio"].string
        
        IMEI = IMEI == nil ? "" : IMEI
        CardName = CardName == nil ? "" : CardName
        PONum = PONum == nil ? 0 : PONum
        SLNhap = SLNhap == nil ? 0 : SLNhap
        SLPO = SLPO == nil ? 0 : SLPO
        ItemName = ItemName == nil ? "" : ItemName
        Gio = Gio == nil ? "" : Gio
     
        
        
        
        
        return LichSuNhapPO(IMEI: IMEI!, CardName: CardName!, PONum: PONum!, SLNhap: SLNhap!, SLPO: SLPO!, ItemName: ItemName!, Gio: Gio!)
    }
}
