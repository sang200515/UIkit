//
//  PhoneNumberSearch.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 3/7/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
public class PhoneNumberSearch: NSObject{
    var SDT:String
    var SO_POS:Int
    var SOMPOS:Int
    var EcomNum:Int
    var TotalAmount:Float
    var CardName:String
    var p_status:String
    var DocDate:String
    var TenSP:String
    var SL:Int
    var LoaiDH:String
    var U_Imei:String
    var GiaSim:Float
    
    init(SDT:String, SO_POS:Int, SOMPOS:Int, EcomNum:Int, TotalAmount:Float, CardName:String, p_status:String, DocDate:String, TenSP:String, SL:Int, LoaiDH:String,U_Imei: String,GiaSim: Float){
        self.SDT = SDT
        self.SO_POS = SO_POS
        self.SOMPOS = SOMPOS
        self.EcomNum = EcomNum
        self.TotalAmount = TotalAmount
        self.CardName = CardName
        self.p_status = p_status
        self.DocDate = DocDate
        self.TenSP = TenSP
        self.SL = SL
        self.LoaiDH = LoaiDH
        self.U_Imei = U_Imei
        self.GiaSim = GiaSim
    }
    class func parseObjfromArray(array:[JSON])->[PhoneNumberSearch]{
        var list:[PhoneNumberSearch] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    class func getObjFromDictionary(data:JSON) -> PhoneNumberSearch{
        var SDT = data["SDT"].string
        var SO_POS = data["SO_POS"].int
        var SOMPOS = data["SOMPOS"].int
        var EcomNum = data["EcomNum"].int
        var TotalAmount = data["TotalAmount"].float
        var CardName = data["CardName"].string
        var p_status = data["p_status"].string
        var DocDate = data["DocDate"].string
        var TenSP = data["TenSP"].string
        var SL = data["SL"].int
        var LoaiDH = data["LoaiDH"].string
        var U_Imei = data["U_Imei"].string
        var GiaSim = data["GiaSim"].float
        
        SDT = SDT == nil ? "" : SDT
        SO_POS = SO_POS == nil ? 0 : SO_POS
        SOMPOS = SOMPOS == nil ? 0 : SOMPOS
        EcomNum = EcomNum == nil ? 0 : EcomNum
        TotalAmount = TotalAmount == nil ? 0 : TotalAmount
        CardName = CardName == nil ? "" : CardName
        p_status = p_status == nil ? "" : p_status
        
        DocDate = DocDate == nil ? "" : DocDate
        TenSP = TenSP == nil ? "" : TenSP
        SL = SL == nil ? 0 : SL
        LoaiDH = LoaiDH == nil ? "" : LoaiDH
        U_Imei = U_Imei == nil ? "" : U_Imei
        GiaSim = GiaSim == nil ? 0 : GiaSim
        
        return PhoneNumberSearch(SDT:SDT!, SO_POS:SO_POS!, SOMPOS:SOMPOS!, EcomNum:EcomNum!, TotalAmount:TotalAmount!, CardName:CardName!, p_status:p_status!, DocDate:DocDate!, TenSP:TenSP!, SL:SL!, LoaiDH:LoaiDH!,  U_Imei:U_Imei!, GiaSim: GiaSim!)
    }
}
